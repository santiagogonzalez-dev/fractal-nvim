;; extends

; https://neovim.io/doc/user/treesitter.html#treesitter-node
; This query makes all @strings in svelte syntax show up with three dots.
(
 (attribute_value) @string
 (#match? @string "**")
 (#set! conceal "")
)
