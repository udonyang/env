(use-modules (ice-9 popen))
(use-modules (ice-9 rdelim))
(use-modules (dwylkz utils))

(define p (open-input-pipe "ls -l"))
(write (read-line p))
(write (read-line p))
