Description
===========
This project lets you tag anything from the commandline. The `tag` executable
provides a consistent way to add, remove and modify tags for tagged
items. The goal is to make tagging dead simple and usable by other commandline apps.
In making tags a first class nix citizen, perhaps they will see the light of day.

Examples
========

    $ tag add horse animal
    $ tag add cat animal
    $ tag list animal
    horse
    cat

    # TODO

Motivation
==========
As I wanted to tag [my vim knowledge](http://github.com/cldwalker/vimdb) on the
commandline, I found its tagging features to greatly exceed that project's
scope.

Contributing
============
[See here](http://tagaholic.me/contributing.html)

Todo
====

* Tests!
* Several more tag actions
* Description and time fields
* Make storage agnostic
* Explain how to integrate with other commandline apps
