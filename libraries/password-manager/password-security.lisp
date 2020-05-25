(in-package :password)

;;; Provide an interface to the command line "security" program used
;;; on BSD and Darwin systems to interface with the system keychain

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '*security-cli-program*))
(defvar *security-cli-program* (executable-find "security"))

(defclass security-interface (password-interface) ())

(defmethod list-passwords ((password-interface security-interface))
  (error "Listing passwords not supported by security interface."))

(defmethod clip-password ((password-interface security-interface) &key password-name service)
  (clip-password-string
   (str:replace-all
    "\"" "" (str:replace-first
             "password: " "" (nth-value 1 (uiop:run-program (list *security-cli-program* "find-internet-password"
                                                                  "-a" password-name "-s" service "-g")
                                                            :error-output '(:string :stripped t)))))))

(defmethod save-password ((password-interface security-interface) &key password-name password service)
  (uiop:run-program (list *security-cli-program* "add-internet-password"
                          "-a" password-name "-s" service "-w" password)))

(defmethod password-correct-p ((password-interface security-interface)) t)
