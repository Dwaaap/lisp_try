(in-package :crt)

;;;
;;; PROCESS MODULE GENERALITIES
;;;

(defgeneric call-action (action &rest params))

(defmacro def-action-handler (name args &body body)
  (alexandria:with-gensyms (action-sym params)
    `(defmethod call-action ((,action-sym (common-lisp:eql ',name)) &rest ,params)
       (destructuring-bind ,args ,params ,@body))))

;;(defun valid-package-symbol-p (symbol)
;;  "Predicate that checks whether `symbol' is interned in CRAM-BOXY-PM."
;;  (eql (symbol-package symbol) (find-package 'cram-robohow-test)))

;;(defun safe-reference (desig)
;;  "Iterates over all reference solutions for the action designator `desig' until
;; it finds one that refers to an action-handler in this package and returns that
;; solution. If no such solution exists, it returns NIL."
;;  (ros-info (task-pm) "safe-reference ~a" desig)
;;  (loop for solution = (reference des) with des = desig do
;;    (when (valid-package-symbol-p (car solution))
;;      (return solution))
;;    (if (next-solution des)
;;        (setf des (next-solution des))
;;        (return nil))))

(def-process-module task-process-module (desig)
  (apply #'call-action (reference desig)))

(def-action-handler task-sender (action-desig task-name)
  (ros-info (task-pm) "Task send ~a" task-name)
  (call-relay-p_task task-name)
)

(def-fact-group task-pm-action-designators (action-desig)
  
  (<- (task-pm-running?)
    (desig::lisp-pred get-running-process-module task-process-module))

  (ros-info (task-pm) "Defining a process module selector ")
  (<- (action-desig ?desig (task-sender ?current-desig ?task-name))
      (task-pm-running?)
      ;(desig:predefined-desig? ?desig)
      (current-designator ?desig ?current-desig)
      (desig-prop ?current-desig (task-name ?task-name))
  )
  
  
)

(def-fact-group task-process-module (matching-process-module available-process-module)
  (ros-info (task-pm) "Trying to find a process module")
  (<- (matching-process-module ?desig task-process-module)
      (desig::action-desig? ?desig)
      ;(or (desig-prop ?desig (type predefined)))
  )

  (<- (available-process-module task-process-module)
      (crs:true)
  )
)










