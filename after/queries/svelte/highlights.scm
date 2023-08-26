;; extends

; https://neovim.io/doc/user/treesitter.html#treesitter-node
; This query makes all @strings in svelte syntax show up with three dots.
(
 (attribute_value) @conceal
 (#match? @string "**")
 ; (#set! conceal "")
 (#set! conceal "")
)
