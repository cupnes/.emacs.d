;======================================================================
; 追加外部スクリプトに依存しない設定
;======================================================================
(when (equal emacs-major-version 21) (require 'un-define))
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)				;;UTF-8優先
(set-default-coding-systems 'utf-8)
(setq file-name-coding-system 'utf-8)

;; http://stickydiary.blog88.fc2.com/blog-entry-107.html
;; apt-get install fonts-ipafont
(set-default-font "IPAGothic:pixelsize=14:spacing=0")

(mouse-wheel-mode)					;;ホイールマウス
(global-font-lock-mode t)				;;文字の色つけ
(setq line-number-mode t)				;;カーソルのある行番号を表示
(auto-compression-mode t)				;;日本語infoの文字化け防止
(set-scroll-bar-mode 'right)				;;スクロールバーを右に表示
(setq visible-bell nil)					;;ヴィジュアルベル無効
(setq ring-bell-function '(lambda ()))			;;ビープ音も無効
(when (boundp 'show-trailing-whitespace) (setq-default show-trailing-whitespace t))	;;行末のスペースを強調表示

;; 対応する括弧を強調表示
(show-paren-mode t)
(setq show-paren-style 'mixed)
;(set-face-background 'show-paren-match-face "gray10")
(set-face-background 'show-paren-match-face "lawn green")
(set-face-foreground 'show-paren-match-face "light sea green")
(set-face-background 'show-paren-mismatch-face "magenta")
(set-face-foreground 'show-paren-mismatch-face "firebrick")

;; ツールバーを表示しない
(tool-bar-mode 0)

;; メニューを消したい
(menu-bar-mode -1)

;; 時計の設定
(setq display-time-string-forms
	  '((substring year -2) "/" month "/" day " " dayname " " 24-hours ":" minutes))
(display-time)

;; "Lisp nesting exceeds max-lisp-eval-depth"への対処
(setq max-lisp-eval-depth 1000)

;; "Variable binding depth exceeds max-specpdl-size"への対処
(setq max-specpdl-size 1867)

;; 列数を表示する
(column-number-mode t)

;; スタートアップ時のメッセージを抑制
(setq inhibit-startup-message t)

;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
	  (format "%%f - Emacs@%s" (system-name)))

;; 最近使ったファイルをメニューに表示
(recentf-mode t)

;; 最近使ったファイルの表示数
(setq recentf-max-menu-items 10)

;; 最近開いたファイルの保存数を増やす
(setq recentf-max-saved-items 3000)

;; ミニバッファの履歴を保存する
(savehist-mode 1)

;; ミニバッファの履歴の保存数を増やす
(setq history-length 3000)

;; http://seesaawiki.jp/whiteflare503/d/Emacs%20インデント
(setq-default c-basic-offset 4     ;;基本インデント量4
              tab-width 4          ;;タブ幅4
              indent-tabs-mode t)  ;;インデントをタブでするかスペースでするか

;; ;; デフォルトのタブ幅を半角スペース4つ分に
;; (setq default-tab-width 4)

;; c-modeの設定
(setq c-default-style "linux"
	c-basic-offset 4)
;; - http://d.hatena.ne.jp/syohex/20110624/1308871777
;; 	c-modeの自動インデントをデフォルトで無効化
;; 	有効/無効はC-c C-lで切り替え
;; (add-hook 'c-mode-hook
;; 	'(lambda ()
;; 		(c-toggle-electric-state -1)))

;; view-modeの設定
(require 'view)
;; 読み込み専用ファイルを view-mode で開く
(setq view-read-only t)
;; view-mode のキー割り当てを変更する
;; less感覚の操作
(define-key view-mode-map (kbd "N") 'View-search-last-regexp-backward)
(define-key view-mode-map (kbd "?") 'View-search-regexp-backward)
;; vi/w3m感覚の操作
(define-key view-mode-map (kbd "h") 'backward-char)
(define-key view-mode-map (kbd "J") 'next-line)
(define-key view-mode-map (kbd "K") 'previous-line)
(define-key view-mode-map (kbd "l") 'forward-char)
(define-key view-mode-map (kbd "j") 'View-scroll-line-forward)
(define-key view-mode-map (kbd "k") 'View-scroll-line-backward)

;; server start for emacs-client
(require 'server)
(unless (server-running-p)
  (server-start))

;; org-modeの設定
(setq org-todo-keywords
	  '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

;======================================================================
; 追加外部スクリプトに関する設定(Caskで管理)
;======================================================================
;; https://github.com/typester/emacs-config/blob/master/conf/init.el
;; % で対応する括弧に移動
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
((looking-at "\\s\)") (forward-char 1) (backward-list 1))
(t (self-insert-command (or arg 1)))))
(define-key global-map (kbd "C-5") 'match-paren)
;; C-t でother-window、分割されてなかったら分割
(defun other-window-or-split () ; http://d.hatena.ne.jp/rubikitch/20100210/emacs
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))
(define-key global-map (kbd "C-t") 'other-window-or-split)

;; http://d.hatena.ne.jp/naoya/20140424/1398318293
;; cask
(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; gtags
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
	'(lambda ()
		(local-set-key "\M-t" 'gtags-find-tag)		; 関数の定義元へ
		(local-set-key "\M-r" 'gtags-find-rtag)		; 関数の参照元へ
		(local-set-key "\M-s" 'gtags-find-symbol)	; 変数の定義元/参照先へ
		(local-set-key "\M-f" 'gtags-find-file)		; ファイルにジャンプ
		(local-set-key "\C-t" 'gtags-pop-stack)))	; 前のバッファに戻る
;; (add-hook 'gtags-mode-hook
;;   '(lambda ()
;;         ; Local customization (overwrite key mapping)
;;         (define-key gtags-mode-map "\C-f" 'scroll-up)
;;         (define-key gtags-mode-map "\C-b" 'scroll-down)
;; ))
(add-hook 'gtags-select-mode-hook
	'(lambda ()
		(setq hl-line-face 'underline)
		(hl-line-mode 1)))
(add-hook 'c-mode-hook
	'(lambda ()
		(gtags-mode 1)
		(gtags-make-complete-list)))
; Customization
(setq gtags-suggested-key-mapping t)
(setq gtags-auto-update t)

;; auto-complete-mode
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;; ace-jump-mode
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
;;
;; enable a more powerful jump back function from ace jump mode
;;
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; ido-vertical-mode
(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)

;; http://rubikitch.com/2014/09/05/elscreen/
;; elscreen
;;; プレフィクスキーはC-z
(setq elscreen-prefix-key (kbd "C-z"))
(elscreen-start)
;;; タブの先頭に[X]を表示しない
(setq elscreen-tab-display-kill-screen nil)
;;; header-lineの先頭に[<->]を表示しない
(setq elscreen-tab-display-control nil)
;;; バッファ名・モード名からタブに表示させる内容を決定する(デフォルト設定)
(setq elscreen-buffer-to-nickname-alist
      '(("^dired-mode$" .
         (lambda ()
           (format "Dired(%s)" dired-directory)))
        ("^Info-mode$" .
         (lambda ()
           (format "Info(%s)" (file-name-nondirectory Info-current-file))))
        ("^mew-draft-mode$" .
         (lambda ()
           (format "Mew(%s)" (buffer-name (current-buffer)))))
        ("^mew-" . "Mew")
        ("^irchat-" . "IRChat")
        ("^liece-" . "Liece")
        ("^lookup-" . "Lookup")))
(setq elscreen-mode-to-nickname-alist
      '(("[Ss]hell" . "shell")
        ("compilation" . "compile")
        ("-telnet" . "telnet")
        ("dict" . "OnlineDict")
        ("*WL:Message*" . "Wanderlust")))

;; http://d.hatena.ne.jp/khiker/20100123/undo_tree
;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode)

;======================================================================
; global-set-key設定
;======================================================================
;; * Global Key (Might be overridden by major/minor mode maps)
(global-set-key "\C-h" 'backward-delete-char)		;;Ctrl-Hでバックスペース

;; http://d.hatena.ne.jp/syohex/20130426/1366981612
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'query-replace-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-M-%") 'query-replace)

;; ** Function keys
(global-set-key (kbd "<f2>") 'recompile)
(global-set-key (kbd "<f3>") 'compile)
(global-set-key (kbd "<f4>") 'speedbar-get-focus)
(global-set-key (kbd "S-<f4>") 'delete-frame)
(global-set-key (kbd "<f5>") 'magit-status)
(global-set-key (kbd "<f8>") 'deft)

;; ** Control (Very Fast & Repeatable)
(global-set-key (kbd "C-<tab>") 'other-window)
;; (global-set-key (kbd "C-,") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-.") 'mc/mark-next-like-this)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-o") 'open-previous-line)

;; *** C-c C- (Fast, Non-repeatable)
;; (global-set-key (kbd "C-c C-.") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c C-o") 'ido-find-file)
(global-set-key (kbd "C-c C-t") 'toggle-buffer)
(global-set-key (kbd "C-c C-x C-j") 'org-clock-goto)

;; *** C-c (One Tempo)
(global-set-key (kbd "C-c b") 'org-iswitchb)
(global-set-key (kbd "C-c c") 'org-capture)
;; (global-set-key (kbd "C-c g") 'google-this-noconfirm)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c s") 'magit-status)
(global-set-key (kbd "C-c v") 'org-agenda) ;; because org-agenda
;; should be named org-*v*iew

;; *** C-c Shift (Two Tempo)
;; (global-set-key (kbd "C-c G") 'google-this)
;; (global-set-key (kbd "C-c I") 'find-user-init-file)

;; *** C-x
(global-set-key (kbd "C-x C-b") 'ibuffer)
;; (global-set-key (kbd "C-x C-r") 'ido-recentf-open)
;; (global-set-key (kbd "C-x C-v") 'ido-view-file)
;; (global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows)

;; ** Meta
;; (global-set-key (kbd "M-%") 'vr/query-replace)
;(global-set-key (kbd "M-,") 'ace-jump-mode)
;(global-set-key (kbd "M-.") 'gtags-find-tag)
(global-set-key (kbd "M-/") 'hippie-expand)
;; (global-set-key (kbd "M-RET") 'open-next-line)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "M-o") 'other-window)
;; (global-set-key (kbd "M-q") 'toggle-fill-unfill)
;(global-set-key (kbd "M-r") 'gtags-find-rtag)
;; (global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-g") 'goto-line)

;; ** other
;; (global-set-key (kbd "C-M-%") 'vr/replace)
;; (global-set-key (kbd "C-M-S-k") 'kill-eob)
