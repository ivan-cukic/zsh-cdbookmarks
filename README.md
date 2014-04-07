zsh-cdbookmarks
===============

ZSH cd bookmarks

ZSH bookmarking system for directory changing.

Installation
------------

Just source it via your .zshrc

Usage
-----

You need to create a .zsh/cdbookmarks file to contain the mappings between bookmark names and folders. Something like:

project   /home/user/project/private/project
pictures  /home/user/document/photos/blah/blah/blah

Mind that the bookmark names can not contain spaces!

After that, you can type:

    cdb project

or

    cdb project/some/subfolder/

cdb_add
-------

If you do not want to create the .zsh/cdbookmarks file manually, you can use the cdb_add command.

    cdb_add bookmark_name

adds the current directory to the file under the specified name.

    cdb_add bookmark_name bookmark_location

adds the specified location.

cdb_edit
--------

cdb_edit command opens the bookmarks file in your $EDITOR


TODO: Rewrite the README file :)
