;======================================================================
; 追加外部スクリプトに依存しない設定
;======================================================================

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
;; https://qiita.com/Aten_Ha_Ra/items/71a4a5d1cb352b802843
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
	("melpa" . "https://melpa.org/packages/")
	("org"   . "https://orgmode.org/elpa/")))

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
;;
;; fc-query /usr/share/fonts/opentype/ipafont-gothic/ipag.ttf
;; の結果、"spacing: 90(i)(s)"と出ていたので、"spacing=90"へ変更
;; (set-default-font "IPAGothic:pixelsize=14:spacing=90")
;;
;; set-default-fontはobsoleteになった。23.1以降はset-default-fontを使う
;; https://stackoverflow.com/questions/6026713/how-do-i-change-emacs-default-font-size-and-font-type
(set-frame-font "IPAGothic:pixelsize=14:spacing=90" nil t)

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
;(set-face-background 'show-paren-match-face "lawn green")
;(set-face-foreground 'show-paren-match-face "light sea green")
;(set-face-background 'show-paren-mismatch-face "magenta")
;(set-face-foreground 'show-paren-mismatch-face "firebrick")
;; show-paren-match-faceは削除された
;; https://typeinf-memo.blogspot.com/2016/06/emacsshow-paren-match-faceremoved.html
;; (set-face-attribute 'show-paren-match nil
;; 		    :background 'unspecified
;; 		    :underline "turquoise")

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

;; ;; http://seesaawiki.jp/whiteflare503/d/Emacs%20インデント
;; (setq-default c-basic-offset 4     ;;基本インデント量4
;;               tab-width 4          ;;タブ幅4
;;               indent-tabs-mode t)  ;;インデントをタブでするかスペースでするか

;; ;; デフォルトのタブ幅を半角スペース4つ分に
;; (setq default-tab-width 4)

;; c-modeの設定
;; (setq c-default-style "linux"
;; 	c-basic-offset 4)
;; - http://d.hatena.ne.jp/syohex/20110624/1308871777
;; 	c-modeの自動インデントをデフォルトで無効化
;; 	有効/無効はC-c C-lで切り替え
;; (add-hook 'c-mode-hook
;; 	'(lambda ()
;; 		(c-toggle-electric-state -1)))
(add-hook 'c-mode-common-hook
		  (lambda ()
			;; (require 'recompile-on-save)
			;; (recompile-on-save-advice compile)
			;; (highlight-symbol-mode 1)
			(c-set-style "linux")
			;; (ggtags-mode 1)
			))

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

;; python-modeの設定
(add-hook 'python-mode-hook
		  '(lambda()
			 (setq indent-tabs-mode t)
			 (setq indent-level 4)
			 (setq python-indent 4)
			 (setq tab-width 4)))

;; Browse Urlの設定
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")

;; sh-modeの設定
;; https://keramida.wordpress.com/2008/08/08/tweaking-shell-script-indentation-in-gnu-emacs/
(defun gker-setup-sh-mode ()
  "My own personal preferences for `sh-mode'.

This is a custom function that sets up the parameters I usually
prefer for `sh-mode'.  It is automatically added to
`sh-mode-hook', but is can also be called interactively."
  (interactive)
  (setq sh-basic-offset 8
        sh-indentation 8
        ;; Tweak the indentation level of case-related syntax elements, to avoid
        ;; excessive indentation because of the larger than default value of
        ;; `sh-basic-offset' and other indentation options.
        sh-indent-for-case-label 0
        sh-indent-for-case-alt '+))
(add-hook 'sh-mode-hook 'gker-setup-sh-mode)

;; eww
;; http://emacs.rubikitch.com/eww-nocolor/
(require 'eww)
;;; [2014-11-17 Mon]背景・文字色を無効化する
(defvar eww-disable-colorize t)
(defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
  (unless eww-disable-colorize
    (funcall orig start end fg)))
(advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
(advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)
(defun eww-disable-color ()
  "ewwで文字色を反映させない"
  (interactive)
  (setq-local eww-disable-colorize t)
  (eww-reload))
(defun eww-enable-color ()
  "ewwで文字色を反映させる"
  (interactive)
  (setq-local eww-disable-colorize nil)
  (eww-reload))
;; http://www-he.scphys.kyoto-u.ac.jp/member/shotakaha/dokuwiki/doku.php?id=toolbox:emacs:eww:start
;; (use-package eww
;;   :config
;;   (bind-keys :map eww-mode-map
;;              ("h" . backward-char)
;;              ("j" . next-line)
;;              ("k" . previous-line)
;;              ("l" . forward-char)
;;              ("J" . View-scroll-line-forward)  ;; カーソルは移動せず、画面がスクロースする
;;              ("K" . View-scroll-line-backward)
;;              ("s-[" . eww-back-url)
;;              ("s-]" . eww-forward-url)
;;              ("s-{" . previous-buffer)
;;              ("s-}" . next-buffer)
;;              )
;;   )
(define-key eww-mode-map (kbd "h") 'backward-char)
(define-key eww-mode-map (kbd "j") 'next-line)
(define-key eww-mode-map (kbd "k") 'previous-line)
(define-key eww-mode-map (kbd "l") 'forward-char)
(define-key eww-mode-map (kbd "J") 'View-scroll-line-forward)
(define-key eww-mode-map (kbd "K") 'View-scroll-line-backward)
(define-key eww-mode-map (kbd "s-[") 'eww-back-url)
(define-key eww-mode-map (kbd "s-]") 'eww-forward-url)
(define-key eww-mode-map (kbd "s-{") 'previous-buffer)
(define-key eww-mode-map (kbd "s-}") 'next-buffer)

;; Diredの設定
;; https://kakurasan.blogspot.com/2015/05/dired-filemanager-renamer.html
(add-hook 'dired-load-hook
'(lambda ()
   ;; ディレクトリを再帰的にコピー可能にする
   (setq dired-recursive-copies 'always)

   ;; ディレクトリを確認なしで再帰的に削除可能にする(使用する場合は注意)
				;(setq dired-recursive-deletes 'always)
   ;; 対象の最上位ディレクトリごとに確認が出る形
   (setq dired-recursive-deletes 'top)

   ;; lsのオプションを指定 (詳しくはlsのmanページなどを参照)
   ;; Windows以外向け
   ;; "l" (小文字のエル)は必須
   ;; ディレクトリをファイルよりも上に表示するには
   ;;   "--group-directories-first" を含める
   ;; 出力される日時の形式を "YYYY-MM-DD hh:mm" にするには
   ;;   "--time-style=long-iso" を含める
   (setq dired-listing-switches "-Flha --time-style=long-iso --group-directories-first")   ; "." と ".." が必要な場合
				;(setq dired-listing-switches "-GFlha --time-style=long-iso --group-directories-first") ; グループ表示が不要な場合
				;(setq dired-listing-switches "-FlhA --time-style=long-iso --group-directories-first")  ; "." と ".." が不要な場合

   ;; find-dired/find-grep-diredで、条件に合ったファイルを一覧する際の出力形式
   ;; ([findのオプション(出力に関係するもの)] . [LSのオプション(出力解析上の指定)])
   (setq find-ls-option '("-print0 | xargs -0 ls -Flhatd --time-style=long-iso" . "-Flhatd --time-style=long-iso"))

   ;; 新規バッファを作らずに移動するコマンド "dired-find-alternate-file" は
   ;; 標準では無効化されているので、使用したい場合は下の記述で有効にする
   (put 'dired-find-alternate-file 'disabled nil)
   )
)

;; cask initやcask時の"Failed to download ‘gnu’ archive."というエラーの対処
;; https://francopasut.medium.com/emacs-melpa-and-the-failed-to-download-gnu-archive-error-b834bbe4491e
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; File XXX is large (X.X MiB), really open? (y)es or (n)o or (l)iterally への対処
;; https://emacsredux.com/blog/2014/05/16/opening-large-files/
;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;======================================================================
; 追加外部スクリプトに関する設定(Caskで管理)
; 2021-09-21現在、Cask未使用
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
;; (define-key global-map (kbd "C-t") 'other-window-or-split)

;; http://d.hatena.ne.jp/naoya/20140424/1398318293
;; cask
;; (require 'cask "~/.cask/cask.el")
;; (cask-initialize)

;; gtags
;;
;; 2021-08-05 現在、
;; 以下の手順でインストールした
;; 1. M-x list-packages
;; 2. "ggtags"にカーソルを合わせる
;; 3. i で選択
;; 4. x でインストール
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
	'(lambda ()
		(local-set-key "\M-t" 'gtags-find-tag)		; 関数の定義元へ
		(local-set-key "\M-r" 'gtags-find-rtag)		; 関数の参照元へ
		(local-set-key "\M-s" 'gtags-find-symbol)	; 変数の定義元/参照先へ
		(local-set-key "\M-f" 'gtags-find-file)		; ファイルにジャンプ
		(local-set-key "\C-t" 'gtags-pop-stack)		; 前のバッファに戻る
		(local-set-key "\M-T" 'gtags-pop-stack)))	; 前のバッファに戻る(emacsをシェル内で起動し、C-tがscreenに取られている時)
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
;;
;; 2021-08-06 20:36 現在、
;; 以下の手順でインストールした
;; 1. M-x list-packages
;; 2. "auto-complete"にカーソルを合わせる
;; 3. i で選択
;; 4. x でインストール
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;; ace-jump-mode
;;
;; 2021-08-06 20:28 現在、
;; 以下の手順でインストールした
;; 1. M-x list-packages
;; 2. "ace-jump-mode"にカーソルを合わせる
;; 3. i で選択
;; 4. x でインストール
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
;;
;; 2021-08-06 20:55 現在、
;; 以下の手順でインストールした
;; 1. M-x list-packages
;; 2. "ido-vertical-mode"にカーソルを合わせる
;; 3. i で選択
;; 4. x でインストール
(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)

;; http://rubikitch.com/2014/09/05/elscreen/
;; elscreen
;;
;; 2021-08-06 20:11 現在、
;; 以下の手順でインストールした
;; 1. M-x list-packages
;; 2. "elscreen"にカーソルを合わせる
;; 3. i で選択
;; 4. x でインストール
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
;; (require 'undo-tree)
;; (global-undo-tree-mode)

;; Wanderlust
;; http://opamp.hatenablog.jp/entry/2015/01/07/210407
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-draft "wl" "Write draft with Wanderlust." t)

;; magit
;;
;; 2021-09-21 現在、
;; 以下の手順でインストールした
;; 1. M-x list-packages
;; 2. "magit"にカーソルを合わせる
;; 3. i で選択
;; 4. x でインストール
;; (add-hook 'magit-mode-hook
;; 		  (lambda ()
;; 			(set-face-attribute 'magit-item-highlight nil :inherit :unspecified)))
;; 2021-09-21現在、↓のエラーが出るので↑はコメントアウト
;; set-face-attribute: Invalid face: magit-item-highlight

;; org-textile
;; (require 'ox-textile)

;; org-trello
;; (require 'org-trello)

;; ag
;;
;; 2021-09-21 現在、
;; 以下の手順でインストールした
;; 1. M-x list-packages
;; 2. "ag"にカーソルを合わせる
;; 3. i で選択
;; 4. x でインストール

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
(global-set-key (kbd "C-c r") 'recentf-open-files)
;; should be named org-*v*iew

;; *** C-c Shift (Two Tempo)
;; (global-set-key (kbd "C-c G") 'google-this)
;; (global-set-key (kbd "C-c I") 'find-user-init-file)

;; *** C-x
(global-set-key (kbd "C-x C-b") 'ibuffer)
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
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(magit ag ido-vertical-mode auto-complete ace-jump-mode elscreen ggtags)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
