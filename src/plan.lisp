(in-package :crt)

;; TODO: Defined a plan for the robot
;; Step 1: Simple plan - Use a predefined task
;; Step 1.2: + designators
;; Step 2: Simple plan get back: Add the return value (ACK) from the qp
;; Step 3: Simple plan evo - Use a predefined task but with modulable parameters
;; Step 4: Simple plan faillure - Try a plan wich failed and recover a faillure
;; Step 5: Simple plan two steps - Try the succession of two tasks
;; At this point, plan only defined in CPL
;; 
;; Step 6: Complex plan - Add a module vision simulated
;; Step 7: Complex plan - Add the walk part
;; Step 8: 
;; 
;; 
;; 
;; 

(def-top-level-cram-function simple-plan-1 (_name_)
  (ros-info (simple-plan-1) "Perform task ~a" _name_)
  (call-relay-p_task _name_)
)

(def-top-level-cram-function simple-plan-2 (_name_)
  (ros-info (simple-plan-1) "Perform task ~a" _name_)
  (with-process-modules-running (task-process-module)
  (with-designators 
    ((play_task (action `((type predefined) (task-name ,_name_)))))
    (plan-lib:perform play_task)))
)

(def-top-level-cram-function ack-plan (_name_)
  ;
  (ros-info (ack-plan) "Perform task ~a" _name_)
  (with-process-modules-running (task-process-module)
  (with-designators 
    ((play_task (action `((type predefined) (task-name ,_name_)))))
    (plan-lib:perform play_task)))
)

(def-top-level-cram-function get-the-printed-paper-demo ()
  (ros-info (top-level-plan) "Get the printed paper.") 
  (let ((signal-fluent (cpl:make-fluent)))
  (with-tags
    (partial-order
      ((:tag plan-1
        (ros-info (plan-1) "I'm here"))
      (:tag plan-2
        (ros-info (plan-2) "I'm here in the plan 2"))
        (cpl:pulse signal-fluent)
      (:tag plan-3
        (ros-info (plan-3) "Plan 3")))
        (:order plan-2 plan-1)
        (:order signal-fluent plan-3)
  )))
)

(defun perform-experiment ()
  (setf *handle* nil)  
  (start-ros-node "cram_reasonning")
  (init-action-client)
  (sleep 2)
  ;;(beliefstate:enable-logging t)
  ;;(beliefstate:set-metadata
  ;;:robot "HRP4"
  ;;:creator "CNRS, IAI"
  ;;:experiment "Something"
  ;;:description "Something too"
  
  ;;(get-the-printed-paper-demo)
  ;;(beliefstate:extract-files)
  ;;
  ;; Step 1 - Using a well predefined task directly
  ;;(simple-plan-1 "handMoveForward")
  ;; Step 2 - Using a well predefined task in the process module way
  ;;(simple-plan-2 "handMoveForward")
  ;; Step 3 - Using a well predefined task and wait for the controller ACK
  (ack-plan "handMoveForward")
) 




