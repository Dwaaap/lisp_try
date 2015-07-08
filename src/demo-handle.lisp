(in-package :crt)

(defstruct (demo-handle (:conc-name dh-))
 (something nil)
  (relay nil)
)

(defun init-demo ()
  (let (
     (relay
      (actionlib:make-action-client
        "CRAM"
        "robohow_action/relayAction")))
      (actionlib:wait-for-server relay 5.0)
      (make-demo-handle
        :relay relay)
  )
  ;;(ros-info (cram-node) "Client for relay started.")
)




;(defun call-relay (handle task-name)
;  (declare (ignore handle))
;  (ros-info (cram-node) "Send a goal predefined.")
;  (actionlib:send-goal-and-wait
;    (dh-relay handle)
;    (actionlib:make-action-goal-msg (dh-relay handle)
;     :name task-name
;      )
;    0.0
;    1.0
;    )
;  (ros-info (cram-node) "Finished.")
;)

(defparameter *handle* nil)

(defun get-handle ()
  (unless *handle*
    (setf *handle* (init-demo)))
  *handle*
)

(defparameter *navp-client* nil)

(defun get-action-client ()
  (when (null *navp-client*) 
    (init-action-client))
  *navp-client*
)
 
(defun init-action-client ()
  (setf *navp-client* (actionlib:make-action-client
                       "CRAM"
                       "robohow_action/relayAction"))
  (roslisp:ros-info (relay-action-client) 
                    "Waiting for relay action server...")
  ;; workaround for race condition in actionlib wait-for server
  (loop until
    (actionlib:wait-for-server *navp-client*))
  (roslisp:ros-info (relay-action-client) 
                    "Relay action client created.")

)

(defun call-relay-p_task (task-name-c)
  
  (multiple-value-bind (result status)
  (if (actionlib:connected-to-server (get-action-client))
    (progn
      (ros-info (call-relay) "Really?!")
      (actionlib:send-goal-and-wait 
        (get-action-client) ;client
        (actionlib:make-action-goal ;goal
          (get-action-client)
          :name task-name-c)
        ))
    (progn
      (ros-info (call-relay) "The client isn't connected to the server.")
    )
  )
  (values result status)
  (ros-info (call-relay) "Received an answer from the server ~a" result))
)


(defun call-relay (handle task-name)
  (declare (ignore handle))
  (ros-info (cram-node) "Send a goal predefined.")
  (actionlib:send-goal-and-wait
    (dh-relay handle)
    (actionlib:make-action-goal (dh-relay handle)
     :name task-name
      )
    )
  (ros-info (cram-node) "Finished.")
)


