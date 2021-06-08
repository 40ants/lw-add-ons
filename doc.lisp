(in-package :lw-add-ons)


(40ants-doc:defsection @index (:title "LW-ADD-ONS"
                               :ignore-words ("IDE"
                                              "HTML"))
  "
This system provides a bunch of LispWorks IDE extensions.
"
  (lw-add-ons system)
  (@installation section))


(40ants-doc:defsection @installation (:title "Installation"
                                      :ignore-words ("*ASDF-BASE-DIRS*"
                                                     "*WORKING-DIR*"))
  "
To use LW-ADD-ONS you need LW-DOC and a recent version of
LispWorks:

  <http://weitz.de/lw-doc/>
  <http://www.lispworks.com/>

Use of [Quicklisp](http://www.quicklisp.org) is recommended together
with [LispWorks distribution](https://ultralisp.org/dists/lispworks).

If you already have a LispWorks init file, append the included file
`.lispworks' to it, otherwise instruct LispWorks to use this file as
your initialization file.  In that file, modify the special variables
*ASDF-BASE-DIRS*, and *WORKING-DIR* to fit your local settings.
Specifically, make sure that LW-ADD-ONS, LW-DOC and their supporting
libraries can be found via *ASDF-BASE-DIRS*.

Download the HTML page <http://www.lisp.org/mop/dictionary.html> and
store it locally.  At the end of the init file (after LW-ADD-ONS has
been loaded) set the value of LW-ADD-ONS:*MOP-PAGE* to the pathname of
the saved HTML file.  (There are some other special variables that can
be used to modfiy the behaviour of LW-ADD-ONS.  See the documentation
for details.)

You should now be able to use LW-ADD-ONS by simply starting LispWorks.

Note: The Personal Edition of LispWorks doesn't support the automatic
loading of initialization files.  You'll have to use some kind of
workaround.
")
