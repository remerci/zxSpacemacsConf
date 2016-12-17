                                        ;====================
                                        ; keybinding & global conf
                                        ;====================
;; Custom Key Bindings
(global-set-key (kbd "<f9> a") 'org-agenda)
;; (global-set-key (kbd "<f9> I") 'bh/punch-in)
;; (global-set-key (kbd "<f9> O") 'bh/punch-out)
(global-set-key (kbd "<f9> i") 'org-clock-in)
(global-set-key (kbd "<f9> o") 'org-clock-out)
(global-set-key (kbd "<f9> g") 'org-clock-goto)
(global-set-key (kbd "<f9> SPC") 'org-clock-in-last)
(global-set-key (kbd "<f9> c") 'calendar)
(global-set-key (kbd "<f9> s") 'org-ido-switchb)
(global-set-key (kbd "<f9> h") 'bh/hide-other)
(global-set-key (kbd "<f9> l") 'org-toggle-link-display)
(global-set-key (kbd "<f9> t") 'org-toggle-inline-images)

