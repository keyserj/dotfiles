; Ctrl + Shift + Alt + [jkhl] for VIM-corresponding arrow keys
^+!j::
SendInput {Down}
return

^+!k::
SendInput {Up}
return

^+!h::
SendInput {Left}
return

^+!l::
SendInput {Right}
return

; CapsLock for Esc
CapsLock::Esc
return

; Alt + [jkhl] for Alt + arrow keys (mainly for line-moving)
!j::
SendInput {Blind}{Down}
return

!k::
SendInput {Blind}{Up}
return

!h::
SendInput {Blind}{Left}
return

!l::
SendInput {Blind}{Right}
return

; Right-Alt for context menu (laptop doesn't have the key!!)
RAlt::AppsKey