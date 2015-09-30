(defun put-alist (key value alist)
  "Set cdr of an element (KEY . ...) in ALIST to VALUE and return ALIST.
If there is no such element, create a new pair (KEY . VALUE) and
return a new alist whose car is the new pair and cdr is ALIST."
  (let ((elm (assoc key alist)))
    (if elm
        (progn
          (setcdr elm value)
          alist)
      (cons (cons key value) alist))))

(defadvice make-network-process (before force-tcp-server-ipv4 activate)
  "Monkey patch the server to force it to use ipv4. This is a bug fix that will
hopefully be in emacs 24: http://debbugs.gnu.org/cgi/bugreport.cgi?bug=6781"
  (if (eq nil (plist-get (ad-get-args 0) :family))
      (ad-set-args 0 (plist-put (ad-get-args 0) :family 'ipv4))))

;; now that the ipv4 advice is in place, restart the server.
(custom-set-variables '(server-use-tcp t))
;;(if (server-running-p) (server-start))

(defun update-tramp-emacs-server-ssh-port-forward ()
  "Update TRAMP's ssh method to forward the Emacs server port to the local host.
This lets emacsclient on the remote host open files in the local Emacs server.

put-alist, used below, is defined in alist, which is part of the APEL library:
http://kanji.zinbun.kyoto-u.ac.jp/~tomo/elisp/APEL/index.en.html"
  (let* ((ssh-method (assoc "ssh" tramp-methods))
         (ssh-args (cadr (assoc 'tramp-login-args ssh-method))))
    (put-alist 'tramp-login-args
      (list (put-alist "-R" (let ((port (process-contact server-process :service)))
        ;; put-alist makes a dotted pair for the key/value, but tramp-methods
        ;; needs a normal list, so put the value inside a list so that the
        ;; second part of the dotted pair (ie the cdr) is a list, which converts
        ;; it from a dotted pair into a normal list.
                              (list (format "%d:127.0.0.1:%d" port port)))
                       ssh-args))
      ssh-method)))

(defadvice server-process-filter (before handle-remote-emacsclient-file activate)
  "Detect remote emacsclient and inject the tramp '/host:' prefix.

  Note the hack here that assumes remote emacsclient invocations
  have the regex '-tty /dev/(pts/[0-9]|ttype)[0-9]+)' in their
  command sequence string, and all others have either no -tty or
  a one-digit /dev/pts/.... I haven't yet found a better way to
  distinguish local and remote clients."
  (if (string-match "-tty /dev/\\(pts/[0-9]\\|ttyp\\)[0-9]+" (ad-get-arg 1))
      (with-parsed-tramp-file-name default-directory parsed
        (let* ((message (ad-get-arg 1))
               (absolute (and (string-match "-file \\([^ ]+\\)" message)
                              (file-name-absolute-p (match-string 1 message))))
               (tramp-prefix (tramp-make-tramp-file-name parsed-method
                                                         parsed-user
                                                         parsed-host
                                                         nil))
               (dir (if absolute nil parsed-localname)))
          (ad-set-arg 1 (replace-regexp-in-string "-file "
                          (concat "-file " tramp-prefix dir) message))))))

(defun ssh-shell (host bufname)
  "SSH to a remote host in a shell-mode buffer using TRAMP."
  (update-tramp-emacs-server-ssh-port-forward)
  (let ((default-directory (format "/%s:" host))
        (tramp-remote-process-environment
         (cons (format "EDITOR='emacsclient -f ~/.emacs.d/%s_server'" (getenv "HOST"))
                 tramp-remote-process-environment)))
    (shell bufname))
  ;; copy emacs server file so remote emacsclient can connect to this emacs
  (let ((default-directory "/tmp")
        (local-server-file (process-get server-process :server-file))
        (remote-server-file (format "~/.emacs.d/%s_server" (getenv "HOST"))))
    (async-shell-command
     (format "scp -v %s %s:%s" local-server-file host remote-server-file))))

(provide 'remote-e)
