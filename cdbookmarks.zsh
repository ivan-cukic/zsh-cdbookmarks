# Module: Change directory with bookmarks
# Priority: 90
#
# (C) by Ivan Cukic, 2010-present
# (C) by Stan Angeloff, 2010-present

ZSH_BOOKMARKS="$HOME/.cdbookmarks.conf"

zmodload zsh/pcre
setopt REMATCH_PCRE

function cdb_edit() {
    $EDITOR "$ZSH_BOOKMARKS"
}

function cdb() {
    local index
    local entry
    index=0
    for entry in $(echo "$1" | tr '/' '\n'); do
        if [[ $index == "0" ]]; then
            local CD
            CD=$(egrep "^$entry\\s" "$ZSH_BOOKMARKS" | sed "s#^$entry\\s\+##")
            if [ -z "$CD" ]; then
                echo "$0: no such bookmark: $entry"
                break
            else
                cd "$CD"
            fi
        else
            cd "$entry"
            if [ "$?" -ne "0" ]; then
                break
            fi
        fi
        let "index++"
    done
}

function _cdb() {
    current_string=$words[2]

    if [[ "$current_string" = */* ]]; then
        head=${current_string%%/*}
        body=""
        tail=${current_string#*/}

        if [[ "$tail" = */* ]]; then
            body=${tail%/*}/
            tail=${tail##*/}
        fi

        expanded_path=(`grep "$head" "$ZSH_BOOKMARKS" | sed -e 's#^[^\d\W]*\s##g'`)

        reply=(`find "$expanded_path"/"$body" -name "$tail*" -maxdepth 1 -mindepth 1 -type d -printf '%P\n' 2> /dev/null | sed 's#^.*$#'$head'/'$body'\0/#'`)

    else
        reply=(`sed -e 's#^\(.*\)\s.*$#\1/#g' "$ZSH_BOOKMARKS" `)

    fi
}

function cdb_add() {
    if [[ "$2" == "" ]]; then
        echo "$1 $PWD" >> $ZSH_BOOKMARKS
    else
        echo "$1 $2" >> $ZSH_BOOKMARKS
    fi
}

compctl -K _cdb -S '' cdb

