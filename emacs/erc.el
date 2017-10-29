(require 'erc)

(setq erc-autojoin-channels-alist
          '(("localhost" "&bitlbee")
	    ("freenode.net" "#emacs-es" "#ourproject" "#emacs")
	    ("irc-hispano.es" "#barcelona" "#sexo")))

(setq erc-user-full-name "David Arroyo Menéndez")
(setq erc-nick "davidam")
(setq erc-message-english-QUIT "%n (%u@%h) se fue: %r")
(setq erc-default-coding-system '(latin-1 . latin-1))
(setq erc-server-history-list '("irc.freenode.net"
                                 "localhost"))


