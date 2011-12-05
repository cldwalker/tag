Description
===========
This project lets you tag anything from the commandline. The `tag` executable
provides a consistent way to add, remove and modify tags for tagged
items. The goal is to make tagging dead simple and usable by other commandline apps.
In making tags a first class nix citizen, perhaps they will see the light of day.

Examples
========

Let's start with tagging animals:

    $ tag add horse -t fast strong
    $ tag add cat -t fast independent
    $ tag add dog -t loving
    $ tag list fast
    horse
    cat

Tired of animals, let's tag cities. To avoid interfering with
the animals list, we'll use a cities model:

    $ tag add nyc -t fast fun -m cities
    $ tag add boston -t educated clean -m cities
    $ tag add paris -t awesome delicious
    $ tag list fast -m cities
    nyc
    # to avoid typing '-m cities' for every command
    $ export TAG_MODEL=cities

Since models are isolated from one another, third party commandline apps can
use tag for their own private tagging purposes.

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

* Several more tag actions
* Description and time fields
* Make storage agnostic
* Switch from thor to boson
* Explain how to integrate with other commandline apps
