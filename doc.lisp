(in-package :lw-add-ons)


(40ants-doc:defsection @index (:title "LW-ADD-ONS"
                               :ignore-words ("IDE"
                                              "SLIME"
                                              "HTML"
                                              "TAB"
                                              "GUI"))
  "
LW-ADD-ONS is a collection of small \"enhancements\" to
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
releases are supported, see @COMPATIBILITY section.

It comes with a [BSD-style license](http://www.opensource.org/licenses/bsd-license.php)
so you can basically do with it whatever you want.

"
  (lw-add-ons system)
  (@compatibility section)
  (@installation section)
  (@overview section)
  (@acknowledgements section))


(40ants-doc:defsection @compatibility (:title "Compatibility with different LispWorks releases")
  "
LW-ADD-ONS was originally (in 2005) conceived and written for
LispWorks 4.4.5/4.4.6 (and it will likely not work with older
versions).  Since then, the fine LispWorks hackers have added several
new features to their IDE which rendered some parts of LW-ADD-ONS
obsolete.  As I usually use the latest LispWorks version, you can
expect LW-ADD-ONS to be adapted to it pretty soon after its release.
This might include dropping features which are now superseded by
capabilities offered by the LispWorks IDE itself.

The newest LispWorks release which is currently supported is 7.0.
Support for older LispWorks versions might at some point disappear.
Keep your old LW-ADD-ONS tarballs if you plan on sticking with a
certain LispWorks release.
")


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
`*ASDF-BASE-DIRS*`, and `*WORKING-DIR*` to fit your local settings.
Specifically, make sure that LW-ADD-ONS, LW-DOC and their supporting
libraries can be found via `*ASDF-BASE-DIRS*`.

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


(40ants-doc:defsection @overview (:title "Overview")
  "
Here's an overview of what's currently in LW-ADD-ONS.  If you want
more details you got to look at the source code which should be
reasonably documented.
"

  (@symbol-completion section)
  (@args-of-function section)
  (@apropos-dialog section)
  (@transient-mode section)
  (@search-and-replace section)
  (@documentation section)
  (@asdf-integration section)
  (@quicklisp-integration section)
  (@listener-shortcuts section)
  (@alternative-backups section)
  (@misc section))


(40ants-doc:defsection @misc (:title "Miscellaneous"
                              :ignore-words ("DDE"))
  "The command `Next Ordinary Window` (usually bound to `C-x o`) is modified to also allow switching from an editor window to a listener window."
  (:|Next Ordinary Window| command)

  "The command `Find Alternate File` (usually bound to `C-x C-v`) is modified such that it checks whether the contents of the buffer are consistent with the file on disk. Also, it'll provide the full pathname of the current buffer as the default when prompting."
  (:|Find Alternate File| command)

  "The command `Indent And Complete Symbol` includes a workaround to make sure that the start of a top-level form will always be indented to the beginning of a line. LispWorks usually doesn't do that."
  (:|Indent And Complete Symbol| command)

  "The commands `Evaluate Last Form And Inspect` (`C-c i`) and `Evaluate Last Form And Describe` (`C-c d`) are like `Evaluate Last Form` but open the result in an IDE inspector or describe it in a help window respectively."
  (:|Evaluate Last Form And Inspect| command)
  (:|Evaluate Last Form And Describe| command)

  "The command `Untrace All` executes `(untrace)`, the command `Toggle Trace` (`C-c C-t`) traces or untraces a function depending on its current state."
  (:|Untrace All| command)
  (:|Toggle Trace| command)
  
  "
The included initialization file makes sure you start with an editor
and (if you use the MDI interface) tiles the windows vertically.

A DDE Server [as described in the LispWorks Knowledgebase](http://www.lispworks.com/kb/55af67dc408cab568025687f004b1442.html)
is set up so you can open Lisp source files by double-clicking them.
You have to configure Windows Explorer to use this facility, of course.

The function keys `F11` and `F12` are bound to commands that switch to an editor
or a listener respectively (and create these tools if necessary).
")


(40ants-doc:defsection @acknowledgements (:title "Acknowledgements")
  "The inhabitants of the LispWorks mailing list are an invaluable source of
   information when one writes LispWorks-specific code.
   Specifically, Jeff Caldwell, Bill Clementson, John DeSoi, Dmitriy Ivanov,
   Arthur Lemmens, Nick Levine, Sean Ross, Jens Teich, Barry Wilkes,
   and (from LispWorks Ltd.) Dave Fox and Martin Simmons have been very helpful
   in various ways.

   Thanks also go to the cool [SLIME](http://common-lisp.net/project/slime)
   project which provided inspiration and code to steal.
")


(40ants-doc/locatives/base::define-locative-type command ()
  "LispWorks interactive command.")


;; TODO: Сделать чтобы command экспортировалась из locatives
(defmethod 40ants-doc/locatives/base::locate-object (symbol (locative-type (eql '40ants-doc/locatives::command))
                                                     locative-args)
  (40ants-doc/reference::make-reference symbol (cons locative-type locative-args)))


;; TODO: Проверить, используется ли как указано в доке document-object
(defmethod 40ants-doc/locatives/base::locate-and-document (symbol (locative-type (eql '40ants-doc/locatives::command))
                                                           locative-args stream)
  (40ants-doc/builder/bullet::locate-and-print-bullet locative-type locative-args symbol stream
                                                      :name (symbol-name symbol))
  (40ants-doc/builder/bullet::print-end-bullet stream)
  (40ants-doc/args::with-dislocated-symbols ((list symbol))
    (40ants-doc/render/print::maybe-print-docstring symbol 'type stream))
  (let* ((command (editor::find-command (symbol-name symbol)))
         (docstring (when command
                      (editor::command-documentation command))))
    (when docstring
      (format stream
              "~%~A~%"
              (40ants-doc/markdown/transform::massage-docstring docstring)))))

(defun build-docs ()
  (unless (find-package :docs-builder)
    (ql:quickload :docs-builder))
  
  (loop with target-dir = (asdf:system-relative-pathname :lw-add-ons "docs/")
        with build-path = (uiop:symbol-call :docs-builder :build
                                            :lw-add-ons)
        for file-name in (directory build-path)
        for target-file-name = (make-pathname :name (pathname-name file-name)
                                              :type (pathname-type file-name)
                                              :directory (pathname-directory target-dir))
        do (copy-file file-name
                      target-file-name)
           (delete-file file-name)
        finally (delete-directory build-path))

  (let ((filename (asdf:system-relative-pathname :lw-add-ons "README.md")))
    (alexandria:write-string-into-file
     (cl-ppcre:regex-replace-all "\\((.*\.png)"
                                 (alexandria:read-file-into-string filename)
                                 "(docs/\\1")
     filename
     :if-exists :supersede))

  (values))
