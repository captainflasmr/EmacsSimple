;;
;; -> requires-core
;;
(require 'org)
(require 'grep)
(require 'bookmark)
(require 'dired)

;;
;; -> completion-core
;;
(setq-default abbrev-mode t)
(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs try-expand-dabbrev
        try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially try-complete-lisp-symbol))

;;
;; -> modeline-completion-core
;;
(fido-mode 1)
(defun my-icomplete-exit-minibuffer-with-input ()
  "Exit the minibuffer with the current input, without forcing completion."
  (interactive)
  (exit-minibuffer))
(define-key icomplete-minibuffer-map (kbd "M-RET") 'my-icomplete-exit-minibuffer-with-input)
(setq icomplete-compute-delay 0)
(setq icomplete-show-matches-on-no-input t)

;;
;; -> keys-navigation-core
;;
(defvar my-jump-keymap (make-sparse-keymap))
(global-set-key (kbd "M-o") my-jump-keymap)
(define-key my-jump-keymap (kbd "=") #'tab-bar-new-tab)
(define-key my-jump-keymap (kbd "b") (lambda () (interactive) (find-file "~/bin")))
(define-key my-jump-keymap (kbd "e")
            (lambda ()
              (interactive)
              (find-file (expand-file-name "init.el" user-emacs-directory))))
(define-key my-jump-keymap (kbd "f") #'find-name-dired)
(define-key my-jump-keymap (kbd "g") (lambda () (interactive) (find-file "~/.config")))
(define-key my-jump-keymap (kbd "h") (lambda () (interactive) (find-file "~")))
(define-key my-jump-keymap (kbd "j") (lambda () (interactive) (find-file "~/DCIM/content/aaa--todo.org")))
(define-key my-jump-keymap (kbd "k")
            (lambda () (interactive)
              (find-file (concat user-emacs-directory "emacs--core.org"))))
(define-key my-jump-keymap (kbd "l") #'recentf-open-files)
(define-key my-jump-keymap (kbd "m") #'customize-themes)
(define-key my-jump-keymap (kbd "n") (lambda () (interactive) (find-file "~/nas")))
(define-key my-jump-keymap (kbd "o") #'bookmark-jump)
(define-key my-jump-keymap (kbd "r") (lambda () (interactive) (switch-to-buffer "*scratch*")))
(define-key my-jump-keymap (kbd "w") (lambda () (interactive) (find-file "~/DCIM/content/")))
(define-key my-jump-keymap (kbd "-") #'tab-close)

;;
;; -> keys-visual-core
;;
(defvar my-win-keymap (make-sparse-keymap))
(global-set-key (kbd "C-q") my-win-keymap)
(define-key my-win-keymap (kbd "c") #'display-fill-column-indicator-mode)
(define-key my-win-keymap (kbd "d") #'window-divider-mode)
(define-key my-win-keymap (kbd "e") #'whitespace-mode)
(define-key my-win-keymap (kbd "f") #'font-lock-mode)
(define-key my-win-keymap (kbd "h") #'global-hl-line-mode)
(define-key my-win-keymap (kbd "k") #'my/toggle-mode-line)
(define-key my-win-keymap (kbd "l") #'my/sync-tab-bar-to-theme)
(define-key my-win-keymap (kbd "m") #'my/load-theme)
(define-key my-win-keymap (kbd "n") #'display-line-numbers-mode)
(define-key my-win-keymap (kbd "o") #'toggle-centered-buffer)
(define-key my-win-keymap (kbd "p") #'variable-pitch-mode)
(define-key my-win-keymap (kbd "q") #'toggle-menu-bar-mode-from-frame)
(define-key my-win-keymap (kbd "s") #'my/toggle-internal-border-width)
(define-key my-win-keymap (kbd "u") #'set-cursor-color)
(define-key my-win-keymap (kbd "v") #'visual-line-mode)
(define-key my-win-keymap (kbd "b") #'(lambda () (interactive)(tab-bar-mode 'toggle)))

;;
;; -> keys-other-core
;;
(global-set-key (kbd "M-s ,") #'my/mark-line)
(global-set-key (kbd "M-s g") #'rgrep)
(global-set-key (kbd "M-s h") #'my/mark-block)
(global-set-key (kbd "M-s j") #'eval-defun)
(global-set-key (kbd "M-s l") #'eval-expression)
(global-set-key (kbd "M-s =") #'ediff-buffers)
(global-set-key (kbd "M-s w") #'(lambda ()(interactive)
                                  (org-html-export-to-html)
                                  (my/html-promote-headers)
                                  (my/html-org-table-highlight)))
(global-set-key (kbd "M-s e") #'(lambda ()(interactive)
                                  (org-odt-export-to-odt)
                                  (async-shell-command
                                   "libreoffice --headless --convert-to docx confluence--setup-sles.odt" "*create-docs*")))
(global-set-key (kbd "M-s ;") #'my/copy-buffer-to-kill-ring)

;;
;; -> keybinding-core
;;
(global-set-key (kbd "C-=") (lambda ()(interactive)(text-scale-adjust 1)))
(global-set-key (kbd "C--") (lambda ()(interactive)(text-scale-adjust -1)))
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c d") #'my/dired-duplicate-file)
(global-set-key (kbd "C-c h") #'my/shell-create)
(global-set-key (kbd "C-c n") #'my/repeat-window-size)
(global-set-key (kbd "C-c o h") #'outline-hide-sublevels)
(global-set-key (kbd "C-c o s") #'outline-show-all)
(global-set-key (kbd "C-c u") #'my/dired-du)
(global-set-key (kbd "C-o") #'other-window)
(global-set-key (kbd "C-x ;") #'my/switch-to-thing)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x [") #'beginning-of-buffer)
(global-set-key (kbd "C-x ]") #'end-of-buffer)
(global-set-key (kbd "C-x j") #'(lambda() (interactive)(tab-bar-history-back)(my/repeat-history)))
(global-set-key (kbd "C-x k") #'(lambda() (interactive)(tab-bar-history-forward)(my/repeat-history)))
(global-set-key (kbd "C-x l") #'scroll-lock-mode)
(global-set-key (kbd "C-x m") #'my/switch-to-thing)
(global-set-key (kbd "C-x s") #'save-buffer)
(global-set-key (kbd "C-x v e") 'vc-ediff)
(global-set-key (kbd "C-x x g") #'revert-buffer)
(global-set-key (kbd "C-x x t") #'toggle-truncate-lines)
(global-set-key (kbd "M-z") #'my/comment-or-uncomment)
(global-set-key (kbd "C-z") #'my/comment-or-uncomment)
(global-set-key (kbd "M-c") #'delete-other-windows)
(global-set-key (kbd "M-'") #'set-mark-command)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-1") #'delete-other-windows)
(global-set-key (kbd "M-2") #'split-window-vertically)
(global-set-key (kbd "M-3") #'split-window-horizontally)
(global-set-key (kbd "M-1") #'delete-other-windows)
(global-set-key (kbd "M-9") #'hippie-expand)
(global-set-key (kbd "M-;") 'delete-other-windows)
(global-set-key (kbd "M-[") #'yank)
(global-set-key (kbd "M-]") #'yank-pop)
(global-set-key (kbd "M-e") #'dired-jump)
(global-set-key (kbd "M-g i") 'imenu)
(global-set-key (kbd "M-i") #'tab-bar-switch-to-next-tab)
(global-set-key (kbd "M-j") #'(lambda ()(interactive)(scroll-up (/ (window-height) 4))))
(global-set-key (kbd "M-k") #'(lambda ()(interactive)(scroll-down (/ (window-height) 4))))
(global-set-key (kbd "M-l") #'split-window-horizontally)
(global-set-key (kbd "M-m") #'split-window-vertically)
(global-set-key (kbd "M-u") #'tab-bar-switch-to-prev-tab)
(global-unset-key (kbd "C-h h"))
(global-unset-key (kbd "C-t"))
(with-eval-after-load 'ibuffer
  (define-key ibuffer-mode-map (kbd "C-o") nil)
  (define-key ibuffer-mode-map (kbd "M-j") nil))
(with-eval-after-load 'vc-dir
  (define-key vc-dir-mode-map (kbd "e") #'vc-ediff)
  (define-key vc-dir-mode-map (kbd "C-o") nil)
  (define-key vc-dir-mode-map (kbd "M-j") nil))

;;
;; -> modes-core
;;
(column-number-mode 1)
(desktop-save-mode -1)
(display-time-mode -1)
(global-auto-revert-mode t)
(savehist-mode 1)
(show-paren-mode t)
(tab-bar-history-mode 1)
(global-font-lock-mode t)

;;
;; -> bell-core
;;
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;;
;; -> setqs-core
;;
(setq completion-styles '(basic partial-completion emacs22))
(setq custom-safe-themes t)
(setq delete-selection-mode nil)
(setq enable-local-variables :all)
(setq frame-title-format "%f")
(setq kill-whole-line t)
(setq-default truncate-lines t)
(setq frame-inhibit-implied-resize t)
(setq native-comp-async-report-warnings-errors nil)

;;
;; -> confirm-core
;;
(defalias 'yes-or-no-p 'y-or-n-p)
(setq confirm-kill-emacs 'y-or-n-p)
(setq confirm-kill-processes nil)
(setq confirm-nonexistent-file-or-buffer nil)
(set-buffer-modified-p nil)

;;
;; -> backups-core
;;
(setq make-backup-files 1)
(setq backup-directory-alist '(("." . "~/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 10   ; how many of the newest versions to keep
      kept-old-versions 5)   ; and how many of the old

;;
;; -> custom-settings-core
;;
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit default :weight regular :height 1.0))))
 '(org-level-2 ((t (:inherit default :weight light :height 1.0))))
 '(org-level-3 ((t (:inherit default :weight light :height 1.0))))
 '(org-level-4 ((t (:inherit default :weight light :height 1.0))))
 '(org-level-5 ((t (:inherit default :weight light :height 1.0))))
 '(org-level-6 ((t (:inherit default :weight light :height 1.0))))
 '(ediff-current-diff-A ((t (:extend t :background "#b5daeb" :foreground "#000000"))))
 '(ediff-even-diff-A ((t (:background "#bafbba" :foreground "#000000" :extend t))))
 '(ediff-fine-diff-A ((t (:background "#f4bd92" :foreground "#000000" :extend t))))
 '(ediff-odd-diff-A ((t (:background "#b8fbb8" :foreground "#000000" :extend t))))
 '(font-lock-warning-face ((t (:foreground "#930000" :inverse-video nil))))
 '(org-link ((t (:underline nil))))
 '(indent-guide-face ((t (:background "#282828" :foreground "#666666"))))
 '(widget-button ((t (:inherit fixed-pitch :weight regular))))
 '(window-divider ((t (:foreground "black"))))
 '(org-tag ((t (:height 0.99))))
 '(vertical-border ((t (:foreground "#000000")))))
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wombat))
 '(warning-suppress-log-types '((frameset)))
 '(warning-suppress-types '((frameset))))

;;
;; -> defun-core
;;
(defun save-macro (name)
  "Save a macro by NAME."
  (interactive "SName of the macro: ")
  (kmacro-name-last-macro name)
  (find-file user-init-file)
  (goto-char (point-max))
  (newline)
  (insert-kbd-macro name)
  (newline))
;;
(defun my/comment-or-uncomment ()
  "Comments or uncomments the current line or region."
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region
       (region-beginning)(region-end))
    (comment-or-uncomment-region
     (line-beginning-position)(line-end-position))))
;;
(defun my/dired-duplicate-file (arg)
  "Duplicate a file from DIRED with an incremented number.
                              If ARG is provided, it sets the counter."
  (interactive "p")
  (let* ((file (dired-get-file-for-visit))
         (dir (file-name-directory file))
         (name (file-name-nondirectory file))
         (base-name (file-name-sans-extension name))
         (extension (file-name-extension name t))
         (counter (if arg (prefix-numeric-value arg) 1))
         (new-file))
    (while (and (setq new-file
                      (format "%s%s_%03d%s" dir base-name counter extension))
                (file-exists-p new-file))
      (setq counter (1+ counter)))
    (if (file-directory-p file)
        (copy-directory file new-file)
      (copy-file file new-file))
    (dired-revert)))
;;
(defun my/mark-line ()
  "Mark whole line."
  (interactive)
  (beginning-of-line)
  (push-mark (point) nil t)
  (end-of-line))
;;
(defun my/mark-block ()
  "Marking a block of text surrounded by a newline."
  (interactive)
  (when (not (region-active-p))
    (backward-char))
  (skip-chars-forward " \n\t")
  (re-search-backward "^[ \t]*\n" nil 1)
  (skip-chars-forward " \n\t")
  (when (not (region-active-p))
    (push-mark))
  (re-search-forward "^[ \t]*\n" nil 1)
  (skip-chars-backward " \n\t")
  (setq mark-active t))
;;
(defun my/repeat-history ()
  ""
  (interactive)
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "j") (lambda () (interactive)
                                (tab-bar-history-back)))
    (define-key map (kbd "k") (lambda () (interactive)
                                (tab-bar-history-forward)))
    (set-transient-map map t)))
;;
(defun my/repeat-window-size ()
  "Sset up a sparse keymap for repeating window actions."
  (interactive)
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "n") (lambda () (interactive)
                                (window-swap-states)))
    (define-key map (kbd "h") (lambda () (interactive)
                                (enlarge-window 2 t)))
    (define-key map (kbd "l") (lambda () (interactive)
                                (enlarge-window -2 t)))
    (define-key map (kbd "j") (lambda () (interactive)
                                (enlarge-window 1 nil)))
    (define-key map (kbd "k") (lambda () (interactive)
                                (enlarge-window -1 nil)))
    (set-transient-map map t)))
;;
(defun my/sync-tab-bar-to-theme ()
  "Synchronize tab-bar faces with the current theme, and set mode-line background color interactively using `read-color`."
  (interactive)
  ;; Use `read-color` to get the mode-line background color from the user
  (let ((selected-color (read-color)))
    (set-hl-line-darker-background)
    (set-face-attribute 'mode-line nil :height 120 :underline nil :overline nil :box nil
                        :background selected-color :foreground "#000000")
    (set-face-attribute 'mode-line-inactive nil :height 120 :underline nil :overline nil
                        :background "#000000" :foreground "#aaaaaa")
    (let ((default-bg (face-background 'default))
          (default-fg (face-foreground 'default))
          (default-hl (face-background 'highlight))
          (inactive-fg (face-foreground 'mode-line-inactive)))
      (custom-set-faces
       `(vertical-border ((t (:foreground ,(darken-color default-fg 60)))))
       `(window-divider ((t (:foreground ,(darken-color default-fg 60)))))
       `(fringe ((t (:foreground ,default-bg :background ,default-bg))))
       `(tab-bar ((t (:inherit default :background ,default-bg :foreground ,default-fg))))
       `(tab-bar-tab ((t (:inherit 'highlight :background ,selected-color :foreground "#000000"))))
       `(tab-bar-tab-inactive ((t (:inherit default :background ,default-bg :foreground ,inactive-fg
                                            :box (:line-width 2 :color ,default-bg :style released-button)))))))))
;;
(defun my/dired-du ()
  "Run 'du -hc' on the directory under the cursor in Dired."
  (interactive)
  (let ((current-dir (dired-get-file-for-visit)))
    (if (file-directory-p current-dir)
        (dired-do-async-shell-command "du -hc" nil (list current-dir))
      (message "The current point is not a directory."))))
;;
(defun darken-color (color percent)
  "Return a darker shade of COLOR by reducing its brightness by PERCENT."
  (let* ((rgb (color-values color))
         (factor (/ (- 100 percent) 100.0))
         (darker-rgb (mapcar (lambda (x) (max 0 (round (* x factor)))) rgb)))
    (apply 'format "#%02x%02x%02x" (mapcar (lambda (x) (/ x 256)) darker-rgb))))
;;
(defun set-hl-line-darker-background ()
  "Set the hl-line background to a slightly darker shade of the default background,
                                          preserving the original foreground colors of the current line."
  (interactive)
  (require 'hl-line)
  (unless global-hl-line-mode
    (global-hl-line-mode 1))
  (when (facep 'hl-line)
    (let* ((bg (face-background 'default))
           (darker-bg (darken-color bg 15)))
      (custom-set-faces
       `(hl-line ((t (:background ,darker-bg))))))))
;;
(defun my/load-theme ()
  "Prompt to select a theme from available themes and load the selected theme."
  (interactive)
  (let ((theme (completing-read "Choose theme: " (mapcar 'symbol-name (custom-available-themes)))))
    (dolist (item custom-enabled-themes)
      (disable-theme item))
    (load-theme (intern theme) t)))
;;
(defun my/switch-to-thing ()
  "Switch to a buffer, open a recent file, jump to a bookmark,
                                      or change the theme from a unified interface."
  (interactive)
  (let* ((buffers (mapcar #'buffer-name (buffer-list)))
         (recent-files recentf-list)
         (bookmarks (bookmark-all-names))
         (all-options (append buffers recent-files bookmarks))
         (selection (completing-read "Switch to: " all-options)))
    (pcase selection
      ((pred (lambda (sel) (member sel buffers))) (switch-to-buffer selection))
      ((pred (lambda (sel) (member sel bookmarks))) (bookmark-jump selection))
      (_ (find-file selection)))))
;;
(defvar highlight-rules
  '((th . (("TODO" . "#999")))
    (td . (("\\&gt" . "#bbb")
           ("-\\&gt" . "#ccc")
           ("- " . "#ddd")
           ("- - - - " . "#eee")
           ("- - - - - - - - " . "#fff")
           ("TODO" . "#fdd")
           ("DOING" . "#ddf")
           ("DONE" . "#dfd"))))
  "Alist of elements ('th or 'td) and associated keywords/colors for row highlighting.")
;;
(defun apply-row-style (row-start row-attributes color)
  "Apply a background COLOR to the row starting at ROW-START with ROW-ATTRIBUTES."
  (goto-char row-start)
  (kill-line)
  (insert (format "<tr%s style=\"background: %s\">\n" row-attributes color)))
;;
(defun highlight-row-by-rules (row-start row-end row-attributes element)
  "Highlight a row based on ELEMENT ('th or 'td) keyword rules within ROW-START to ROW-END."
  (let ((rules (cdr (assoc element highlight-rules))))
    (dolist (rule rules)
      (let ((keyword (car rule))
            (color (cdr rule)))
        (when (save-excursion
                (and (re-search-forward (format "<%s.*>%s.*</%s>" element keyword element) row-end t)
                     (goto-char row-start)))
          (apply-row-style row-start row-attributes color))))))
;;
(defun my/html-org-table-highlight ()
  "Open the exported HTML file, find tables with specific classes,
                                                      and add background styles to rows containing keywords in <td> or <th> elements."
  (interactive)
  (let* ((org-file (buffer-file-name))
         (html-file (concat (file-name-sans-extension org-file) ".html")))
    (with-temp-buffer
      (insert-file-contents html-file)
      (goto-char (point-min))
      (while (re-search-forward "<table.*>" nil t)
        (let ((table-start (point))
              (table-end (save-excursion
                           (when (re-search-forward "</table>" nil t)
                             (point)))))
          (when table-end
            (save-restriction
              (narrow-to-region table-start table-end)
              (goto-char (point-min))
              (while (re-search-forward "<tr\\(.*\\)>" nil t)
                (let ((row-start (match-beginning 0))
                      (row-attributes (match-string 1))
                      (row-end (save-excursion (search-forward "</tr>"))))
                  (highlight-row-by-rules row-start row-end row-attributes 'th)
                  (highlight-row-by-rules row-start row-end row-attributes 'td)))))))
      (write-region (point-min) (point-max) html-file))))
;;
(defun my/format-to-table (&optional match properties-to-display)
  "Format Org headings into a structured alist, optionally filtered by MATCH
and displaying only specified PROPERTIES-TO-DISPLAY (e.g., '(\"ID\" \"PRIORITY\"))."
  (interactive)
  (let ((rows '())
        (header '("TODO" "Tags" "Title" "Comments")) ;; Start without "Properties"
        (max-level 0))
    (save-excursion
      (goto-char (point-min))
      (when match (re-search-forward (format "\\*%s\\*$" (regexp-quote match)) nil t))
      ;; Add property names to the header dynamically
      (setq header (append header properties-to-display))
      (org-map-entries
       (lambda ()
         (let* ((entry (org-element-at-point))
                (heading (org-get-heading t t t t))
                (level (org-outline-level))
                (tags (remove "noexport" (org-get-tags)))
                (todo (org-get-todo-state))
                (vis-indent "- ")
                (contents "")
                (all-properties (org-entry-properties))
                (filtered-properties
                 (mapcar (lambda (prop)
                           (if (cdr (assoc prop all-properties))
                               (cdr (assoc prop all-properties))
                             ""))
                         properties-to-display)))
           (prin1 properties-to-display)
           (prin1 all-properties)
           (prin1 filtered-properties)
           (org-end-of-meta-data nil)
           (skip-chars-forward " \n\t")
           (when (eq (org-element-type (org-element-at-point)) 'paragraph)
             (let ((start (point)))
               (org-next-visible-heading 1)
               (setq contents (buffer-substring-no-properties start (point)))
               (dolist (pattern '("^#\\+begin.*" "^#\\+end.*" "\n+"))
                 (setq contents (replace-regexp-in-string pattern
                                                          (if (string= pattern "\n+") " " "")
                                                          (string-trim contents))))))
           (setq max-level (max max-level level))
           (push (append
                  (list
                   (or todo "")
                   (string-join tags ":")
                   (cond ((= level 1)
                          (concat "> " heading))
                         ((= level 2)
                          (concat "> " heading))
                         ((= level 3)
                          (concat "*> " heading "*"))
                         ((= level 4)
                          (concat "*" heading "*"))
                         (t
                          (concat "/"
                                  (mapconcat (lambda (_) vis-indent)
                                             (make-list (* (- level 4) 1) "") "") heading "/")))
                   (or contents ""))
                  filtered-properties)
                 rows)))
       nil (when match 'tree)))
    (setq rows (reverse rows))
    (push 'hline rows)
    (cons header rows)))
;;
(defun my/html-promote-headers ()
  "Promote all headers in the HTML file by one level (e.g., h2 -> h1, h3 -> h2, etc.), accounting for attributes."
  (interactive)
  (let* ((org-file (buffer-file-name))
         (html-file (concat (file-name-sans-extension org-file) ".html")))
    (with-temp-buffer
      (insert-file-contents html-file)
      (goto-char (point-min))
      (let ((header-levels '("h1" "h2" "h3" "h4" "h5" "h6")))
        (dolist (level header-levels)
          (let* ((current-level (string-to-number (substring level 1)))
                 (new-level (max 1 (1- current-level)))  ;; Promote but don't go below h1
                 (open-tag-regex (format "<%s\\([^>]*\\)>" level))  ;; Regex for opening tag with attributes
                 (close-tag-regex (format "</%s>" level))  ;; Regex for closing tag
                 (new-open-tag (format "<h%d\\1>" new-level))  ;; Replacement for opening tag, preserving attributes
                 (new-close-tag (format "</h%d>" new-level)))  ;; Replacement for closing tag
            ;; Replace opening tags
            (goto-char (point-min))
            (while (re-search-forward open-tag-regex nil t)
              (replace-match new-open-tag))
            ;; Replace closing tags
            (goto-char (point-min))
            (while (re-search-forward close-tag-regex nil t)
              (replace-match new-close-tag)))))
      (write-region (point-min) (point-max) html-file))))
;;
(defun toggle-centered-buffer ()
  "Toggle center alignment of the buffer by adjusting window margins based on the fill-column."
  (interactive)
  (let* ((current-margins (window-margins))
         (margin (if (or (equal current-margins '(0 . 0))
                         (null (car (window-margins))))
                     (/ (- (window-total-width) fill-column) 2)
                   0)))
    (visual-line-mode 1)
    (set-window-margins nil margin margin)))
;;
(defun my/copy-buffer-to-kill-ring ()
  "Copy the entire buffer to the kill ring without changing the point."
  (interactive)
  (save-excursion
    (kill-ring-save (point-min) (point-max)))
  (message (concat (buffer-file-name) " Copied")))

;;
;; -> window-positioning-core
;;
(add-to-list 'display-buffer-alist
             '("\\*.*shell"
               (display-buffer-reuse-window display-buffer-in-direction)
               (direction . bottommost)
               (dedicated . t)
               (window-height . 0.2)
               (inhibit-same-window . t)))
(add-to-list 'display-buffer-alist
             '("\\*Messages" display-buffer-same-window))

;;
;; -> org-core
;;
(setq org-startup-indented t)
(setq org-use-speed-commands t)
(setq org-hide-leading-stars t)
(setq org-todo-keywords
      '((sequence "TODO" "DOING" "|" "DONE" "CANCELLED"))
      org-todo-keyword-faces
      '(("TODO" . "#ee5566")
        ("DOING" . "#5577aa")
        ("DONE" . "#77aa66")
        ("CANCELLED" . "#426b3e")))

;;
;; -> scroll-core
;;
(setq scroll-margin 10)
(setq scroll-conservatively 10)
(setq scroll-preserve-screen-position t)

;;
;; -> dired-core
;;
(setq dired-dwim-target t)
(setq dired-listing-switches "-alGgh")
(setq dired-auto-revert-buffer t)
(setq dired-confirm-shell-command nil)
(setq dired-no-confirm t)
(setq dired-deletion-confirmer '(lambda (x) t))
(setq dired-recursive-deletes 'always)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "C-o") nil)
  (define-key dired-mode-map (kbd "_") #'dired-create-empty-file))

;;
;; -> visuals-core
;;
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-startup-screen t)
(setq window-divider-default-bottom-width 2)
(setq window-divider-default-right-width 2)
(setq window-divider-default-places t)
(window-divider-mode -1)
(defvar my/internal-border-width 0 "Default internal border width for toggling.")
(modify-all-frames-parameters `((internal-border-width . ,my/internal-border-width)))
(set-fringe-mode '(20 . 20))

;;
;; -> imenu-core
;;
(defun my-imenu-create-index ()
  "Create an index using definitions starting with ';; ->'."
  (let ((index-alist '())
        (regex "^;;[[:space:]]->\\(.+\\)$"))
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward regex nil t)
        (let ((name (s-trim (match-string 1)))
              (pos (match-beginning 0)))
          (push (cons name (set-marker (make-marker) pos)) index-alist))))
    (setq imenu--index-alist (sort
                              index-alist
                              (lambda (a b)
                                (string< (car a) (car b)))))))
;;
;; (setq imenu-create-index-function #'my-imenu-create-index)
;;
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq truncate-lines t)
            (setq imenu-sort-function 'imenu--sort-by-name)
            (setq imenu-generic-expression
                  '((nil "^;;[[:space:]]+-> \\(.*\\)$" 1)))
            (imenu-add-menubar-index)))
;;
(add-hook 'conf-space-mode-hook
          (lambda ()
            (setq imenu-sort-function 'imenu--sort-by-name)
            (setq imenu-generic-expression
                  '((nil "^#[[:space:]]+-> \\(.*\\)$" 1)))
            (imenu-add-menubar-index)))

;;
;; -> recentf-core
;;
(recentf-mode 1)
(setq recentf-max-menu-items 200)
(setq recentf-max-saved-items 200)

;;
;; -> modeline-core
;;
(setq my/mode-line-format
      (list
       '(:eval (if (and (buffer-file-name) (buffer-modified-p))
                   (propertize " * " 'face
                               '(:background "#ff0000" :foreground "#ffffff" :inherit bold)) ""))
       '(:eval
         (propertize (format "%s" (abbreviate-file-name default-directory)) 'face '(:inherit bold)))
       '(:eval
         (if (not (equal major-mode 'dired-mode))
             (propertize (format "%s " (buffer-name)))
           " "))
       'mode-line-position
       'mode-line-modes
       'mode-line-misc-info
       '(:eval (format " | Point: %d" (point)))))
;;
(setq-default mode-line-format my/mode-line-format)
;;
(defun my/toggle-mode-line ()
  "Toggle the visibility of the mode-line by checking its current state."
  (interactive)
  (if (eq mode-line-format nil)
      (progn
        (setq-default mode-line-format my/mode-line-format)
        (setq frame-title-format "%f"))
    (progn
      (setq-default mode-line-format nil)
      (setq frame-title-format mode-line-format)))
  (force-mode-line-update t))

;;
;; -> find-core
;;
(defun my/find-file ()
  "Find file from current directory in many different ways."
  (interactive)
  (let* ((find-options '(("find -type f -printf \"$PWD/%p\\0\"" . :string)
                         ("fd --absolute-path --type f -0" . :string)
                         ("rg --follow --files --null" . :string)
                         ("find-name-dired" . :command)))
         (selection (completing-read "Select : " find-options))
         (file-list)
         (file))
    (pcase (alist-get selection find-options nil nil #'string=)
      (:command
       (call-interactively (intern selection)))
      (:string
       (setq file-list (split-string (shell-command-to-string selection) "\0" t))
       (setq file (completing-read
                   (format "Find file in %s: "
                           (abbreviate-file-name default-directory))
                   file-list))))
    (when file (find-file (expand-file-name file)))))

;;
;; -> grep-core
;;
(eval-after-load 'grep
  '(progn
     (dolist (dir '("nas" ".cache" "cache" "elpa" "chromium" ".local/share" "syncthing" ".mozilla" ".local/lib" "Games"))
       (push dir grep-find-ignored-directories))
     (dolist (file '(".cache" "*cache*" "*.iso" "*.xmp" "*.jpg" "*.mp4"))
       (push file grep-find-ignored-files))
     ))

;;
;; -> spelling-core
;;
(setq ispell-local-dictionary "en_GB")
(setq ispell-program-name "hunspell")
(global-set-key (kbd "C-c s l") #'(lambda()(interactive)
                                    (flyspell-buffer)
                                    (flyspell-mode)))
(global-set-key (kbd "C-c s s") #'ispell-word)
(global-set-key (kbd "C-c s j") #'ispell-word)

;;
;; -> gdb-core
;;
(setq gdb-display-io-nopopup 1)
(setq gdb-many-windows t)
(global-set-key (kbd "<f9>") 'gud-break)
(global-set-key (kbd "<f10>") 'gud-next)
(global-set-key (kbd "<f11>") 'gud-step)

;;
;; -> compilation-core
;;
(setq compilation-always-kill t)
(setq compilation-context-lines 3)
(setq compilation-scroll-output t)
;; ignore warnings
(setq compilation-skip-threshold 2)
(global-set-key (kbd "<f5>") 'my/project-compile)

;;
;; -> diff-core
;;
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-highlight-all-diffs t)
(setq ediff-split-window-function 'split-window-horizontally)
(add-hook 'ediff-prepare-buffer-hook #'outline-show-all)
(add-hook 'ediff-prepare-buffer-hook (lambda () (visual-line-mode -1)))

;;
;; -> project-core
;;
(defun my/project-create-compilation-search-path ()
  "Populate the 'compilation-search-path' variable.
With directories under project root using find."
  (interactive)
  (let ((find-command
         (concat "find " (project-root (project-current t))
                 " \\( -path \\*/.local -o -path \\*/.config -o
 -path \\*/.svn -o -path \\*/.git -o -path \\*/nas \\) -prune -o
 -type d -print")))
    (setq compilation-search-path
          (split-string
           (shell-command-to-string find-command)
           "\n" t))))

(setq project-vc-extra-root-markers '(".project"))

;;
;; -> indentation-core
;;
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;;
;; -> etags-core
;;
;;
(defun my/etags-load ()
  "Load TAGS file from the first it can find up the directory stack."
  (interactive)
  (let ((my-tags-file (locate-dominating-file default-directory "TAGS")))
    (when my-tags-file
      (message "Loading tags file: %s" my-tags-file)
      (visit-tags-table my-tags-file))))
;;
(when (executable-find "my-generate-etags.sh")
  (defun my/etags-update ()
    "Call external bash script to generate new etags for all languages it can find."
    (interactive)
    (async-shell-command "my-generate-etags.sh" "*etags*")))
;;
(defun predicate-exclusion-p (dir)
  "exclusion of directories"
  (not
   (or
    (string-match "/home/jdyer/examples/CPPrograms/nil" dir)
    )))
;;
(defun my/generate-etags ()
  "Generate TAGS file for various source files in `default-directory` and its subdirectories."
  (interactive)
  (message "Getting file list...")
  (let ((all-files
         (append
          (directory-files-recursively default-directory "\\(?:\\.cpp$\\|\\.c$\\|\\.h$\\)" nil 'predicate-exclusion-p)
          (directory-files-recursively default-directory "\\(?:\\.cs$\\|\\.cs$\\)" nil 'predicate-exclusion-p)
          (directory-files-recursively default-directory "\\(?:\\.ads$\\|\\.adb$\\)" nil 'predicate-exclusion-p)))
        (tags-file-path (expand-file-name (concat default-directory "TAGS"))))
    (unless (file-directory-p default-directory)
      (error "Default directory does not exist: %s" default-directory))
    ;; Generate TAGS file
    (dolist (file all-files)
      (message file)
      (shell-command (format "etags --append \%s -o %s" file tags-file-path)))))
;; (global-set-key (kbd "C-x p l") 'my/etags-load)
;; (global-set-key (kbd "C-x p u") 'my/etags-update)

;;
;; -> shell-core
;;
(defun my/shell-create (name)
  "Create a custom-named eshell buffer with NAME."
  (interactive "sName: ")
  (eshell 'new)
  (let ((new-buffer-name (concat "*eshell-" name "*")))
    (rename-buffer new-buffer-name t)))

;;
;; -> tab-bar-core
;;
(setq tab-bar-close-button-show nil)
(setq tab-bar-new-button-show nil)
(setq tab-bar-new-tab-to 'rightmost)
(setq tab-bar-close-button-show nil)

;;
;; -> windows-specific-core
;;

(when (eq system-type 'windows-nt)
  (setq home-dir "c:/users/jimbo")
  (let ((xPaths
         `(,(expand-file-name "~/bin")
           ,(expand-file-name "~/bin/PortableGit/bin")
           ,(expand-file-name "~/bin/PortableGit/usr/bin")
           ,(expand-file-name "~/bin/Apache-Subversion/bin/")
           ,(expand-file-name "~/bin/svn2git-2.4.0/bin")
           ,(expand-file-name "~/bin/clang/bin")
           ,(expand-file-name "~/bin/find")
           ,(expand-file-name "~/bin/omnisharp-win-x64")
           "c:/GnuWin32/bin"
           "c:/GNAT/2021/bin")))
    (setenv "PATH" (mapconcat 'identity xPaths ";"))
    (setq exec-path (append xPaths (list "." exec-directory))))

  (custom-theme-set-faces
   'user
   '(variable-pitch ((t (:family "Consolas" :height 110 :weight normal))))
   '(fixed-pitch ((t ( :family "Consolas" :height 110)))))

  (setq font-general "Consolas 11")
  (set-frame-font font-general nil t)
  (add-to-list 'default-frame-alist `(font . ,font-general)))

(setq tab-bar-show 1)

;;
;; -> linux-specific-core
;;
(when (eq system-type 'gnu/linux)
  (custom-theme-set-faces
   'user
   '(variable-pitch ((t (:family "DejaVu Sans" :height 120 :weight normal))))
   '(fixed-pitch ((t ( :family "Source Code Pro" :height 110)))))
  (setq font-general "Source Code Pro 12")
  (set-frame-font font-general nil t)
  (add-to-list 'default-frame-alist `(font . ,font-general)))

;;
;; -> development-core
;;
(global-set-key (kbd "C-c t") 'toggle-centered-buffer)
;;
(defun my/md-to-org-convert-buffer ()
  "Convert the current buffer from Markdown to Org-mode format"
  (interactive)
  (save-excursion
    ;; Lists: Translate `-`, `*`, or `+` lists to Org-mode lists
    (goto-char (point-min))
    (while (re-search-forward "^\\([ \t]*\\)[*-+] \\(.*\\)$" nil t)
      (replace-match (concat (match-string 1) "- \\2")))
    ;; Bold: `**bold**` -> `*bold*` only if directly adjacent
    (goto-char (point-min))
    (while (re-search-forward "\\*\\*\\([^ ]\\(.*?\\)[^ ]\\)\\*\\*" nil t)
      (replace-match "*\\1*"))
    ;; Italics: `_italic_` -> `/italic/`
    (goto-char (point-min))
    (while (re-search-forward "\\b_\\([^ ]\\(.*?\\)[^ ]\\)_\\b" nil t)
      (replace-match "/\\1/"))
    ;; Links: `[text](url)` -> `[[url][text]]`
    (goto-char (point-min))
    (while (re-search-forward "\\[\\(.*?\\)\\](\\(.*?\\))" nil t)
      (replace-match "[[\\2][\\1]]"))
    ;; Code blocks: Markdown ```lang ... ``` to Org #+begin_src ... #+end_src
    (goto-char (point-min))
    (while (re-search-forward "```\\(.*?\\)\\(?:\n\\|\\s-\\)\\(\\(?:.\\|\n\\)*?\\)```" nil t)
      (replace-match "#+begin_src \\1\n\\2#+end_src"))
    ;; Inline code: `code` -> =code=
    (goto-char (point-min))
    (while (re-search-forward "`\\(.*?\\)`" nil t)
      (replace-match "=\\1="))
    ;; Horizontal rules: `---` or `***` -> `-----`
    (goto-char (point-min))
    (while (re-search-forward "^\\(-{3,}\\|\\*{3,}\\)$" nil t)
      (replace-match "-----"))
    ;; Images: `![alt text](url)` -> `[[url]]`
    (goto-char (point-min))
    (while (re-search-forward "!\\[.*?\\](\\(.*?\\))" nil t)
      (replace-match "[[\\1]]"))
    (goto-char (point-min))
    ;; Headers: Adjust '#'
    (while (re-search-forward "^\\(#+\\)" nil t)
      (replace-match (make-string (length (match-string 1)) ?*) nil nil))))
;;
(defun my/md-to-org-convert-file (input-file output-file)
  "Convert a Markdown file INPUT-FILE to an Org-mode file OUTPUT-FILE."
  (with-temp-buffer
    (insert-file-contents input-file)
    (md-to-org-convert-buffer)
    (write-file output-file)))
;;
(defun my/convert-markdown-clipboard-to-org ()
  "Convert Markdown content from clipboard to Org format and insert it at point."
  (interactive)
  (let ((markdown-content (current-kill 0))
        (original-buffer (current-buffer)))
    (with-temp-buffer
      (insert markdown-content)
      (my/md-to-org-convert-buffer)
      (let ((org-content (buffer-string)))
        (with-current-buffer original-buffer
          (insert org-content))))))
;;
(defun my/org-promote-all-headings (&optional arg)
  "Promote all headings in the current Org buffer along with their subheadings."
  (interactive "p")
  (org-map-entries
   (lambda () 
     (dotimes (_ arg) (org-promote)))))
;;
(global-set-key (kbd "M-s i") #'my/convert-markdown-clipboard-to-org)
(global-set-key (kbd "M-s u") #'my/org-promote-all-headings)

;;
;; -> LLM-core
;;
;;
(defun safe-add-to-load-path (dir)
  "Add DIR to `load-path` if it exists."
  (when (file-directory-p dir)
    (add-to-list 'load-path dir)))

;; Add directories to load-path only if they exist
(safe-add-to-load-path (expand-file-name "lisp/shell-maker" user-emacs-directory))
(safe-add-to-load-path (expand-file-name "lisp/chatgpt-shell" user-emacs-directory))
(safe-add-to-load-path (expand-file-name "lisp/gptel" user-emacs-directory))

;; Conditionally require and configure packages if their files exist
(when (locate-library "gptel")
  (require 'gptel)
  (require 'gptel-ollama)
  (require 'gptel-curl)
  (gptel-make-ollama "llama3_2"
    :host "localhost:11434"
    :stream t
    :models '(llama3_2:latest))
  (setq gptel-model 'qwen2.5-coder-7b-instruct-q5_k_m:latest
        gptel-backend (gptel-make-ollama "llama3_2"
                        :host "localhost:11434"
                        :stream t
                        :models '(llama3_2:latest))))

(when (locate-library "shell-maker")
  (require 'shell-maker))

(when (locate-library "chatgpt-shell")
  (require 'chatgpt-shell)
  (setq chatgpt-shell-models
        '(((:provider . "Ollama")
           (:label . "Ollama-llama")
           (:version . "llama3_2")
           (:short-version)
           (:token-width . 4)
           (:context-window . 8192)
           (:handler . chatgpt-shell-ollama--handle-ollama-command)
           (:filter . chatgpt-shell-ollama--extract-ollama-response)
           (:payload . chatgpt-shell-ollama-make-payload)
           (:url . chatgpt-shell-ollama--make-url))))
  (with-eval-after-load 'chatgpt-shell
    (defun chatgpt-shell-menu ()
      "Menu for ChatGPT Shell commands."
      (interactive)
      (let ((key (read-key
                  (propertize
                   "ChatGPT Shell Commands:\n
    e: Explain Code      d: Describe Code           l: Start Shell
    p: Proofread Region  r: Refactor Code           t: Save Session Transcript
    g: Write Git Commit  u: Generate Unit Test      o: Summarize Last Command Output
    s: Send Region       a: Send and Review Region  m: Swap Model\n
      q: Quit\n\nPress a key: " 'face 'minibuffer-prompt))))
        (pcase key
          (?e (call-interactively 'chatgpt-shell-explain-code))
          (?p (call-interactively 'chatgpt-shell-proofread-region))
          (?g (call-interactively 'chatgpt-shell-write-git-commit))
          (?s (call-interactively 'chatgpt-shell-send-region))
          (?d (call-interactively 'chatgpt-shell-describe-code))
          (?r (call-interactively 'chatgpt-shell-refactor-code))
          (?u (call-interactively 'chatgpt-shell-generate-unit-test))
          (?a (call-interactively 'chatgpt-shell-send-and-review-region))
          (?l (call-interactively 'chatgpt-shell))
          (?t (call-interactively 'chatgpt-shell-save-session-transcript))
          (?o (call-interactively 'chatgpt-shell-eshell-summarize-last-command-output))
          (?w (call-interactively 'chatgpt-shell-eshell-whats-wrong-with-last-command))
          (?i (call-interactively 'chatgpt-shell-describe-image))
          (?m (call-interactively 'chatgpt-shell-swap-model))
          (?q (message "Quit ChatGPT Shell menu."))
          (?\C-g (message "Quit ChatGPT Shell menu."))
          (_ (message "Invalid key: %c" key))))))
  (global-set-key (kbd "C-c g") 'chatgpt-shell-menu))
