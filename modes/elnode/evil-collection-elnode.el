;;; evil-collection-elnode.el --- Evil Bindings for Elnode -*- lexical-binding: t -*-

;; Copyright (C) 2024 Tim Lee

;; Author: Tim Lee <hwiorn@gmail.com>
;; Maintainer: Tim Lee <hwiorn@gmail.com>
;; URL: https://github.com/emacs-evil/evil-collection
;; Version: 0.0.1
;; Package-Requires: ((emacs "27.1"))
;; Keywords: evil, elnode, tools

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
;; Evil bindings for `elnode-list-mode' from the `elnode' package.

;;; Code:
(require 'elnode-list nil t)
(require 'evil-collection)

(defconst evil-collection-elnode-list-mode-maps '(elnode-list-mode-map))

;;;###autoload
(defun evil-collection-elnode-setup ()
  "Set up `evil' bindings for `elnode'."
  (evil-collection-define-key '(normal visual) 'elnode-list-mode-map
    "x" 'elnode-lists-kill-server
    "dd" 'elnode-lists-kill-server
    (kbd "\r") 'elnode-lists-server-find-handler)

  ;; `elnode' is best set in 'normal state because its buffer can be edited.
  ;; https://github.com/mhayashi1120/Emacs-wgrep
  (evil-set-initial-state 'elnode-list-mode 'normal))

(provide 'evil-collection-elnode)
;;; evil-collection-elnode.el ends here
