<a id='x-28LW-ADD-ONS-3A-40INDEX-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29'></a>

# LW-ADD-ONS

## Table of Contents

- [1 LW-ADD-ONS ASDF System Details][090a]
- [2 Compatibility with different LispWorks releases][a748]
- [3 Installation][076f]
- [4 Overview][8f10]
    - [4.1 Symbol Completion][1bba]
    - [4.2 Information about the arguments of a function][6607]
    - [4.3 Apropos dialog][37d2]

###### \[in package LW-ADD-ONS\]
[`LW-ADD-ONS`][090a] is a collection of small "enhancements" to
the [LispWorks](http://www.lispworks.com/) IDE that I
usually load from my initialization file. Most of this code is
intended to make LispWorks behave similar
to [SLIME](http://common-lisp.net/project/slime/) and [GNU Emacs](http://www.gnu.org/software/emacs/emacs.html).

The details of what's included are outlined below. (Whether
one thinks these are enhancements or rather distractions is of course
a matter of taste.)

The code has been used and tested on LispWorks for Windows mostly (I
don't use the IDE on Linux), but I hear there are also some Mac
hackers using it successfully.  For an overview of which LispWorks
releases are supported, see [Compatibility with different LispWorks releases][a748] section.

It comes with a [BSD-style license](http://www.opensource.org/licenses/bsd-license.php)
so you can basically do with it whatever you want.

<a id='x-28-22lw-add-ons-22-20ASDF-2FSYSTEM-3ASYSTEM-29'></a>

## 1 LW-ADD-ONS ASDF System Details

- Version: 0.10.3


<a id='x-28LW-ADD-ONS-3A-40COMPATIBILITY-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29'></a>

## 2 Compatibility with different LispWorks releases

[`LW-ADD-ONS`][090a] was originally (in 2005) conceived and written for
LispWorks 4.4.5/4.4.6 (and it will likely not work with older
versions).  Since then, the fine LispWorks hackers have added several
new features to their IDE which rendered some parts of [`LW-ADD-ONS`][090a]
obsolete.  As I usually use the latest LispWorks version, you can
expect [`LW-ADD-ONS`][090a] to be adapted to it pretty soon after its release.
This might include dropping features which are now superseded by
capabilities offered by the LispWorks IDE itself.

The newest LispWorks release which is currently supported is 7.0.
Support for older LispWorks versions might at some point disappear.
Keep your old [`LW-ADD-ONS`][090a] tarballs if you plan on sticking with a
certain LispWorks release.

<a id='x-28LW-ADD-ONS-3A-40INSTALLATION-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29'></a>

## 3 Installation

To use [`LW-ADD-ONS`][090a] you need `LW-DOC` and a recent version of
LispWorks:

<http://weitz.de/lw-doc/>
  <http://www.lispworks.com/>

Use of [Quicklisp](http://www.quicklisp.org) is recommended together
with [LispWorks distribution](https://ultralisp.org/dists/lispworks).

If you already have a LispWorks init file, append the included file
`.lispworks' to it, otherwise instruct LispWorks to use this file as
your initialization file.  In that file, modify the special variables
`*ASDF-BASE-DIRS*`, and`*WORKING-DIR*`to fit your local settings.
Specifically, make sure that LW-ADD-ONS, LW-DOC and their supporting
libraries can be found via`*ASDF-BASE-DIRS*\`.

Download the `HTML` page <http://www.lisp.org/mop/dictionary.html> and
store it locally.  At the end of the init file (after [`LW-ADD-ONS`][090a] has
been loaded) set the value of `LW-ADD-ONS:*MOP-PAGE*` to the pathname of
the saved `HTML` file.  (There are some other special variables that can
be used to modfiy the behaviour of [`LW-ADD-ONS`][090a].  See the documentation
for details.)

You should now be able to use [`LW-ADD-ONS`][090a] by simply starting LispWorks.

Note: The Personal Edition of LispWorks doesn't support the automatic
loading of initialization files.  You'll have to use some kind of
workaround.

<a id='x-28LW-ADD-ONS-3A-40OVERVIEW-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29'></a>

## 4 Overview

Here's an overview of what's currently in [`LW-ADD-ONS`][090a].  If you want
more details you got to look at the source code which should be
reasonably documented.

<a id='x-28LW-ADD-ONS-3A-40SYMBOL-COMPLETION-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29'></a>

### 4.1 Symbol Completion

Symbol completion is divided into two editor commands. The "outer" command is
[`Indent And Complete Symbol`][792b] which tries to indent the current line
and only performs completion if the line hasn't changed. I have bound this command
to the `TAB` key in my init file, so I can use `TAB` for both indentation and completion.
(In LispWorks 7.0 the editor command [`Indent Selection or Complete Symbol`][390b]
was introduced, so you probably no longer need my workaround.)

The "inner" command is [`Complete Symbol Without Dialog`][1568] which is intended to work
more or less like SLIME's `SLIME-COMPLETE-SYMBOL*` function, i.e. you can type, e.g., `m-v-b`
and it'll be expanded to `MULTIPLE-VALUE-BIND`. If there's more than one possible completion,
then the command only performs completion up to the longest unambiguous prefix and shows
a list of (some of) the possible completions in the echo area. There's no GUI dialog popping
up because I think that's distracting.

[`Indent And Complete Symbol`][792b] calls [`Complete Symbol Without Dialog`][1568] on LispWorks
4.4.x and 5.0.x. In 5.1, however, the new command [`Abbreviated Complete Symbol`][5d5a] was introduced
by LispWorks, so now you can decide which function should be used via the special
variable [`*USE-ABBREVIATED-COMPLETE-SYMBOL*`][9aef].

If it can be determined that you're within a string then [`Indent And Complete Symbol`][792b]
tries pathname completion instead. (This is not perfect, though, as it won't work if
the string contains spaces.)

If the symbol which is completed denotes a function without arguments, [`Complete Symbol Without Dialog`][1568]
will automatically add a closing parenthesis. This can be customized through the variable
`*INSERT-RIGHT-PARENTHESIS-IF-NO-ARGS*`.

You can customize the behavior of [`Complete Symbol Without Dialog`][1568] by changing
the value of the variable [`*COMPLETION-MATCH-FUNCTION*`][c683].

Note that for LispWorks 7.0 the default behavior had to be changed - see here.

<a id='x-28LW-ADD-ONS-3A-2ACOMPLETION-MATCH-FUNCTION-2A-20-28VARIABLE-29-29'></a>

- [variable] **\*COMPLETION-MATCH-FUNCTION\*** *COMPOUND-PREFIX-MATCH*

    The function used by **"Complete Symbol Without Dialog"** to
    check possible completions.  Should be a designator for a
    function of two arguments and return true iff the second argument
    is a possible completion of the first one.

<a id='x-28LW-ADD-ONS-3A-2AUSE-ABBREVIATED-COMPLETE-SYMBOL-2A-20-28VARIABLE-29-29'></a>

- [variable] **\*USE-ABBREVIATED-COMPLETE-SYMBOL\*** *NIL*

    Whether **"Indent And Complete Symbol"** should call
    **"Abbreviated Complete Symbol"** (only available in LispWorks 5.1 or higher) instead
    of **"Complete Symbol Without Dialog"**.

<a id='x-28-3A-7CIndent-20And-20Complete-20Symbol-7C-20-2840ANTS-DOC-2FLOCATIVES-3A-3ACOMMAND-29-29'></a>

- [command] **Indent And Complete Symbol**

    Indents the current line and performs symbol completion.
    First indents the line.  If indenting doesn't change the line
    point is in, completes the symbol.  If there's no symbol at the
    point, shows the arglist for the most recently enclosed macro or
    function.

<a id='x-28-3A-7CComplete-20Symbol-20Without-20Dialog-7C-20-2840ANTS-DOC-2FLOCATIVES-3A-3ACOMMAND-29-29'></a>

- [command] **Complete Symbol Without Dialog**

    Completes the symbol before or around point.  Doesn't pop
    up a `CAPI` dialog window.

These two commands are coming with LispWorks >= 7.0:

<a id='x-28-3A-7CIndent-20Selection-20or-20Complete-20Symbol-7C-20-2840ANTS-DOC-2FLOCATIVES-3A-3ACOMMAND-29-29'></a>

- [command] **Indent Selection or Complete Symbol**

    Either indent the current selection/line or complete a symbol at the current point, according to where the point is in the line.

<a id='x-28-3A-7CAbbreviated-20Complete-20Symbol-7C-20-2840ANTS-DOC-2FLOCATIVES-3A-3ACOMMAND-29-29'></a>

- [command] **Abbreviated Complete Symbol**

    Complete the symbol before the point, taking the string as abbreviation.

<a id='x-28LW-ADD-ONS-3A-40ARGS-OF-FUNCTION-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29'></a>

### 4.2 Information about the arguments of a function

The editor command [`Insert Space and Show Arglist`][a3e9] which I've bound to the space
key inserts a space and shows the argument list of the nearest enclosing operator
in the echo area. If [`*SHOW-DOC-STRING-WHEN-SHOWING-ARGLIST*`][f684] is true the documentation
string of the operator is also shown.

Note that this command is different from the one that's distributed as an example
together with LispWorks.

<a id='x-28-3A-7CInsert-20Space-20and-20Show-20Arglist-7C-20-2840ANTS-DOC-2FLOCATIVES-3A-3ACOMMAND-29-29'></a>

- [command] **Insert Space and Show Arglist**

    Displays arglist of nearest enclosing operator in the echo
    area after inserting a space.

<a id='x-28LW-ADD-ONS-3A-2ASHOW-DOC-STRING-WHEN-SHOWING-ARGLIST-2A-20-28VARIABLE-29-29'></a>

- [variable] **\*SHOW-DOC-STRING-WHEN-SHOWING-ARGLIST\*** *T*

    Whether the editor command [`Insert Space and Show Arglist`][a3e9]
    is supposed to show the documentation string as well.

<a id='x-28LW-ADD-ONS-3A-40APROPOS-DIALOG-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29'></a>

### 4.3 Apropos dialog

There is an Apropos dialog (see picture above) that can be reached via
the LispWorks `Tools` menu or the [`Tools Apropos`][3487] editor command (bound to `C-c C-a`):

![](docs/apropos.png)

The dialog should be mostly self-explanatory. Note that right-clicking on the results
in the multi-column list panel (after selecting one or more items) pops up
a menu with various options similar to other IDE tools. Double-clicking an item tries
to find the corresponding source code or, failing that, the documentation.

Note that in LispWorks 5.0 a [similar tool](http://www.lispworks.com/documentation/lw50/CLWUG-W/html/clwuser-w-318.htm)
was introduced and it is bound to `C-c C-a` shortcut.

<a id='x-28-3A-7CTools-20Apropos-7C-20-2840ANTS-DOC-2FLOCATIVES-3A-3ACOMMAND-29-29'></a>

- [command] **Tools Apropos**

    Shows Apropos Dialog.

  [076f]: #x-28LW-ADD-ONS-3A-40INSTALLATION-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29 "Installation"
  [090a]: #x-28-22lw-add-ons-22-20ASDF-2FSYSTEM-3ASYSTEM-29 "(\"lw-add-ons\" ASDF/SYSTEM:SYSTEM)"
  [1568]: #x-28-3A-7CComplete-20Symbol-20Without-20Dialog-7C-20-2840ANTS-DOC-2FLOCATIVES-3A-3ACOMMAND-29-29 "(:|Complete Symbol Without Dialog| (40ANTS-DOC/LOCATIVES::COMMAND))"
  [1bba]: #x-28LW-ADD-ONS-3A-40SYMBOL-COMPLETION-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29 "Symbol Completion"
  [3487]: #x-28-3A-7CTools-20Apropos-7C-20-2840ANTS-DOC-2FLOCATIVES-3A-3ACOMMAND-29-29 "(:|Tools Apropos| (40ANTS-DOC/LOCATIVES::COMMAND))"
  [37d2]: #x-28LW-ADD-ONS-3A-40APROPOS-DIALOG-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29 "Apropos dialog"
  [390b]: #x-28-3A-7CIndent-20Selection-20or-20Complete-20Symbol-7C-20-2840ANTS-DOC-2FLOCATIVES-3A-3ACOMMAND-29-29 "(:|Indent Selection or Complete Symbol| (40ANTS-DOC/LOCATIVES::COMMAND))"
  [5d5a]: #x-28-3A-7CAbbreviated-20Complete-20Symbol-7C-20-2840ANTS-DOC-2FLOCATIVES-3A-3ACOMMAND-29-29 "(:|Abbreviated Complete Symbol| (40ANTS-DOC/LOCATIVES::COMMAND))"
  [6607]: #x-28LW-ADD-ONS-3A-40ARGS-OF-FUNCTION-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29 "Information about the arguments of a function"
  [792b]: #x-28-3A-7CIndent-20And-20Complete-20Symbol-7C-20-2840ANTS-DOC-2FLOCATIVES-3A-3ACOMMAND-29-29 "(:|Indent And Complete Symbol| (40ANTS-DOC/LOCATIVES::COMMAND))"
  [8f10]: #x-28LW-ADD-ONS-3A-40OVERVIEW-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29 "Overview"
  [9aef]: #x-28LW-ADD-ONS-3A-2AUSE-ABBREVIATED-COMPLETE-SYMBOL-2A-20-28VARIABLE-29-29 "(LW-ADD-ONS:*USE-ABBREVIATED-COMPLETE-SYMBOL* (VARIABLE))"
  [a3e9]: #x-28-3A-7CInsert-20Space-20and-20Show-20Arglist-7C-20-2840ANTS-DOC-2FLOCATIVES-3A-3ACOMMAND-29-29 "(:|Insert Space and Show Arglist| (40ANTS-DOC/LOCATIVES::COMMAND))"
  [a748]: #x-28LW-ADD-ONS-3A-40COMPATIBILITY-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29 "Compatibility with different LispWorks releases"
  [c683]: #x-28LW-ADD-ONS-3A-2ACOMPLETION-MATCH-FUNCTION-2A-20-28VARIABLE-29-29 "(LW-ADD-ONS:*COMPLETION-MATCH-FUNCTION* (VARIABLE))"
  [f684]: #x-28LW-ADD-ONS-3A-2ASHOW-DOC-STRING-WHEN-SHOWING-ARGLIST-2A-20-28VARIABLE-29-29 "(LW-ADD-ONS:*SHOW-DOC-STRING-WHEN-SHOWING-ARGLIST* (VARIABLE))"

* * *
###### \[generated by [40ANTS-DOC](https://40ants.com/doc)\]
