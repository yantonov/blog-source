---
title: "Programmable completion for git and mercurial"
date: 2014-11-09T22:52:36+05:00
categories: [programming]
tags: [emacs, lisp, git, mercurial]
---
Some time ago i read excellent [post](http://tsdh.wordpress.com/2013/05/31/eshell-completion-for-git-bzr-and-hg/) about emacs library [pcomplete](http://www.emacswiki.org/emacs/ProgrammableCompletion).

The author described implementation of completion for git, mercurial version control system using this library. Article is really usefull, i used code as is, its easy and provides all you need, but later i have some problem with it.

First problem - eager evaluation. General commands for git and mercurial are calculated once. Great, there is no reason to call external process like git or hg multiple times but precalculation occured at script evaluation. You may not want to start eshell, so call hg or git is not needed.

Second problem - if you broke PATH variable (emacs cant find git or hg executable, or you install emacs before you install git or mercurial) than you got crash while starting emacs (not fatal but annoying emacs lisp errors).

Thats why i add some modifications. I preserve 'precalculation' of general command list for git and mercurial using this trivial snippet:

cache-defuns.el  
``` lisp
(defun cached (f)
  "evaluate once and cache it"
  (lexical-let ((value nil)
                (fn f))
    (lambda (&rest args)
      (if (eq value nil)
          (progn
            (setq value (funcall fn))
            value)
        value))))

(provide 'cache-defuns)
```

This snippet allow you to calculate function f once, and use its result at subsequent calls.

Another modifications connected with bad PATH variable. I dont throw exception or write message at emacs minibuffer but at time of completion corresponding error message will be printed at eshell instead of autocomplete results. Of course situation of broken PATH is not typical and occured very rarely so described solution works well.

Here you can find final code:

emacs-rc-pcomplete.el
``` lisp
;;**** Git Completion
(defun pcmpl-git-commands ()
  "Return the most common git commands by parsing the git output."
  (interactive)
  (with-temp-buffer
    (call-process-shell-command "git" nil (current-buffer) nil "help" "--all")
    (goto-char 0)
    (if (eq (search-forward "available git commands in") nil)
        '("cant find git executable, check PATH varialbe")
      (let (commands)
        (while (re-search-forward
                "^[[:blank:]]+\\([[:word:]-.]+\\)[[:blank:]]*\\([[:word:]-.]+\\)?"
                nil t)
          (push (match-string 1) commands)
          (when (match-string 2)
            (push (match-string 2) commands)))
        (sort commands #'string<)))))

(defconst cached__pcmpl-git-commands (cached 'pcmpl-git-commands)
  "Cached list of `git' commands.")

(defvar pcmpl-git-ref-list-cmd "git for-each-ref refs/ --format='%(refname)'"
  "The `git' command to run to get a list of refs.")

(defun pcmpl-git-get-refs (type)
  "Return a list of `git' refs filtered by TYPE."
  (with-temp-buffer
    (insert (shell-command-to-string pcmpl-git-ref-list-cmd))
    (goto-char (point-min))
    (let (refs)
      (while (re-search-forward (concat "^refs/" type "/\\(.+\\)$") nil t)
        (push (match-string 1) refs))
      (nreverse refs))))

(defun pcmpl-git-remotes ()
  "Return a list of remote repositories."
  (split-string (shell-command-to-string "git remote")))

(defun pcomplete/git ()
  "Completion for `git'."
  ;; Completion for the command argument.
  (pcomplete-here* (funcall cached__pcmpl-git-commands))
  (cond
   ((pcomplete-match "help" 1)
    (pcomplete-here* (funcall cached__pcmpl-git-commands)))
   ((pcomplete-match (regexp-opt '("pull" "push")) 1)
    (pcomplete-here (pcmpl-git-remotes)))
   ;; provide branch completion for the command `checkout'.
   ((pcomplete-match "checkout" 1)
    (pcomplete-here* (append (pcmpl-git-get-refs "heads")
                             (pcmpl-git-get-refs "tags"))))
   (t
    (while (pcomplete-here (pcomplete-entries))))))

;;**** Mercurial (hg) Completion

(defun pcmpl-hg-commands ()
  "Return the most common hg commands by parsing the hg output."
  (interactive)
  (with-temp-buffer
    (call-process-shell-command "hg" nil (current-buffer) nil "-v" "help")
    (goto-char 0)
    (if (eq (search-forward "list of comxmands:" nil t) nil)
        '("cant find hg executable, check PATH variable")
      (let (commands
            (bound (save-excursion
                     (re-search-forward "^[[:alpha:]]")
                     (forward-line 0)
                     (point))))
        (while (re-search-forward
                "^[[:blank:]]\\([[:word:]]+\\(?:, [[:word:]]+\\)*\\)" bound t)
          (let ((match (match-string 1)))
            (if (not (string-match "," match))
                (push (match-string 1) commands)
              (dolist (c (split-string match ", ?"))
                (push c commands)))))
        (sort commands #'string<)))))

(defconst cached__pcmpl-hg-commands (cached 'pcmpl-hg-commands))

(defun pcomplete/hg ()
  "Completion for `hg'."
  ;; Completion for the command argument.
  (pcomplete-here* (funcall cached__pcmpl-hg-commands))
  (cond
   ((pcomplete-match "help" 1)
    (pcomplete-here* (funcall cached__pcmpl-hg-commands)))
   (t
    (while (pcomplete-here (pcomplete-entries))))))
(provide 'emacs-rc-pcomplete)
```

Thanks [tsdh](http://tsdh.wordpress.com/) and [masteringemacs](http://www.masteringemacs.org/) for excellent posts and great explanation of emacs tricks. Recommend you to read this awesome blogs.
