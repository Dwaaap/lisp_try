(ros-load:load-system "cram_robohow_test" :cram-robohow-test)
(in-package :crt)
(start-ros-node "cram_reasonning")
(init-demo)
(call-relay (get-handle) "hello")
(call-relay (get-handle) "handMoveForward")

(perform-experiment)


(ros-load:load-system "cram_language" :cram-language-tests)
(in-package :cpl-tests)





