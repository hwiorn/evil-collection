;;; evil-collection-howm.el --- Evil Bindings for Howm -*- lexical-binding: t -*-

;; Copyright (C) 2024 Tim Lee

;; Author: Tim Lee <hwiorn@gmail.com>
;; Maintainer: Tim Lee <hwiorn@gmail.com>
;; URL: https://github.com/emacs-evil/evil-collection
;; Version: 0.0.2
;; Package-Requires: ((emacs "27.1"))
;; Keywords: evil, emacs, convenience, tools, howm

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;; Evil bindings for `howm-mode' from the `wgrep-howm' package.

;;; Code:
(require 'evil-collection)
(require 'howm nil t)

(defconst evil-collection-howm-maps '(;; howm-mode is derived from riffle-mode
                                      howm-view-summary-mode-map
                                      howm-view-contents-mode-map
                                      howm-remember-mode-map
                                      howm-menu-mode-map
                                      howm-mode-map

                                      ;; ;; illusion-mode in howm package
                                      ;; illusion-mode-map

                                      ;; riffle-mode in howm package
                                      riffle-summary-mode-map
                                      riffle-contents-mode-map
                                      riffle-mode-map))

;;;###autoload
(defun evil-collection-howm-setup ()
  "Set up `evil' bindings for `howm'."
  (evil-collection-define-key '(normal visual) 'howm-view-summary-mode-map
    ;; date
    "+" 'howm-date-forward
    "-" 'howm-date-backward
    ")" 'howm-date-forward
    "(" 'howm-date-backward
    "}" 'howm-date-forward-month
    "{" 'howm-date-backward-month
    "]" 'howm-date-forward-year
    "[" 'howm-date-backward-year

    ;; reminder
    "." 'howm-reminder-goto-today

    ;; summary
    "\C-m" 'howm-view-summary-open
    "u" 'howm-view-filter-uniq
    "!" 'howm-view-summary-shell-command
    "T" 'howm-list-toggle-title ;; defined in other file. dirty!
    [tab] 'howm-view-summary-next-section
    [(backtab)] 'howm-view-summary-previous-section
    "\C-n" 'howm-view-summary-next-section
    "\C-p" 'howm-view-summary-previous-section

    ;; common
    "f" 'howm-view-filter
    "G" 'howm-view-filter-by-contents
    "S" 'howm-view-sort
    "R" 'howm-view-sort-reverse
    "q" 'howm-view-kill-buffer
    "X" 'howm-view-dired)

  (evil-collection-define-key '(normal visual) 'howm-view-contents-mode-map
    ;; contents
    "\C-m" 'howm-view-contents-open

    ;; common
    "f" 'howm-view-filter
    "G" 'howm-view-filter-by-contents
    "S" 'howm-view-sort
    "R" 'howm-view-sort-reverse
    "q" 'howm-view-kill-buffer
    "X" 'howm-view-dired)

  (evil-collection-define-key '(normal visual) 'howm-remember-mode-map
    "\C-c\C-c" 'howm-remember-submit    ;; FIXME
    "\C-c\C-k" 'howm-remember-discard)

  (evil-collection-define-key '(normal visual) 'howm-menu-mode-map
    action-lock-magic-return-key 'howm-menu-invoke
    [tab] 'action-lock-goto-next-link
    [(backtab)] 'action-lock-goto-previous-link
    "j" 'action-lock-goto-next-link
    "k" 'action-lock-goto-previous-link
    "\C-k" 'scroll-up
    "\C-j" 'scroll-down
    "q" 'bury-buffer
    "?" 'describe-mode)

  ;; (evil-collection-define-key '(normal visual) 'howm-mode-map
  ;;   (kbd "\C-x\C-s") 'howm-save-buffer)

  (evil-set-initial-state 'howm-view-summary-mode 'normal)
  (evil-set-initial-state 'howm-view-contents-mode 'normal)
  (evil-set-initial-state 'howm-remember-mode 'normal)
  ;; (evil-set-initial-state 'howm-menu-mode 'normal) ;;FIXME
  ;; (evil-set-initial-state 'howm-mode 'normal)

  ;;; illusion-mode in howm package
  ;; (evil-collection-define-key '(normal visual) 'illusion-mode-map
  ;;   illusion-submit-key illusion-submit)
  ;; (evil-set-initial-state 'illusion-mode 'normal)

  ;;; riffle-mode
  (evil-collection-define-key '(normal visual) 'riffle-mode-map
    "j" 'next-line
    "k" 'previous-line
    "?" 'describe-mode
    "q" 'riffle-kill-buffer)

  (evil-collection-define-key '(normal visual) 'riffle-summary-mode-map
    "\C-j" 'riffle-pop-or-scroll-other-window
    [backspace] 'scroll-other-window-down
    "\C-k" 'riffle-scroll-other-window-down
    "@" 'riffle-summary-to-contents
    "v0" 'riffle-summary-to-contents     ;; FIXME 0,1,2,v ->를 합칠것
    "v1" 'delete-other-windows
    "v2" 'riffle-pop-window
    "vv" 'riffle-toggle-window
    )

  (evil-collection-define-key '(normal visual) 'riffle-contents-mode-map
    "\C-j" 'scroll-up
    [backspace] 'scroll-down
    "\C-k" 'scroll-down
    "j" 'riffle-scroll-up
    "k" 'riffle-scroll-down
    "@" 'riffle-contents-to-summary
    "0" 'riffle-contents-to-summary
    ;; "\C-i" 'riffle-contents-goto-next-item
    ;; "\M-\C-i" 'riffle-contents-goto-previous-item
    ;; [tab] 'riffle-contents-goto-next-item
    ;; [(meta tab)] 'riffle-contents-goto-previous-item
    "\C-n" 'riffle-contents-goto-next-item
    "\C-p" 'riffle-contents-goto-previous-item
    [tab] 'riffle-contents-goto-next-item
    [(backtab)] 'riffle-contents-goto-previous-item
    ;;   (define-key m "o" 'riffle-jump-to-summary)
    )

  (evil-set-initial-state 'riffle-summary-mode 'normal)
  (evil-set-initial-state 'riffle-contents-mode 'normal)
  (evil-set-initial-state 'riffle-mode 'normal))

(provide 'evil-collection-howm)
;;; evil-collection-howm.el ends here
