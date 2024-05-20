(require 'org)

;; (defun tbl-export (name)
;;   "Search for a table named `NAME` and export."
;;   (interactive "s")
;;   (outline-show-all)
;;   (let ((case-fold-search t))
;; 	(if (search-forward-regexp (concat "#\\+TBLNAME: +" name) nil t)
;; 		(progn
;; 		  (next-line)
;; 		  (org-table-export (format "%s.csv" name) "orgtbl-to-csv")))))

(defun tbl-export ()
  "Search for all the tables in the file and choose which to export with ivy."
  (interactive)
  (outline-show-all)
  (let ((case-fold-search t)
		(tbl-regexp "^#\\+TBLNAME: +\\(.+\\)")
		(tbl-names '()))
	(save-excursion
	  (goto-char (point-min))
	  (while (re-search-forward tbl-regexp nil t)
		(push (match-string 1) tbl-names)))
	(ivy-read "Select table: " (nreverse tbl-names)
			  :action (lambda (name)
						(goto-char (point-min))
						(when (re-search-forward (concat "#\\+TBLNAME: +" name) nil t)
						  (forward-line)
						  (org-table-export (format "%s.csv" name) "orgtbl-to-csv"))))))
