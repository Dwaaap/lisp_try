(defsystem cram-robohow-test
  :author "Kevin Chappellet"
  :license "BSD"
  :description ""

  :depends-on ( roslisp 
                cram-language 
                cl-transforms 
                geometry_msgs-msg 
                robohow_action-msg
                actionlib-lisp
                cram-plan-failures
                cram-plan-library
                cram-utilities
                cram-test-utilities
                cram-language
                cram-language-designator-support
                alexandria
                )
  :components
  ((:module "src"
        :components
        ( (:file "package")
          (:file "demo-handle" :depends-on ("package"))
          (:file "plan" :depends-on ("package" "demo-handle"))
          (:file "process-module" :depends-on ("package" "demo-handle" "plan"))
        )
  ))
)

(defmethod asdf:perform ((o asdf:test-op)
                         (c (eql (asdf:find-system 'cram-robohow-test))))
  (flet ((symbol (pkg name)
           (intern (string name) (find-package pkg))))
