;(in-package :cl-user)
;
;(desig-props:def-desig-package cram-robohow-test
;  (:nicknames :crt)
;  (:use #:cpl 
;        #:roslisp 
;        #:cl-transforms)
;)

(in-package :cl-user)

(desig-props:def-desig-package :cram-robohow-test
  (:documentation "Package for the cram-language test-suite")
  (:nicknames :crt)
  (:use 
        ;#:cram-language-implementation
        #:cram-utilities
        #:alexandria
        #:roslisp
        #:cram-process-modules
        #:desig
        #:cram-language
        #:cram-language-designator-support
       ; #:common-lisp
        )
  (:import-from #:cram-walker #:make-plan-tree-node)
  (:import-from #:cram-reasoning #:<- #:def-fact-group)
  (:shadowing-import-from :cram-language-implementation #:fail)
  (:desig-properties
    :play-task
    :task-name
    :p_or_c
    :what
    :predefined
    )
  
  
)