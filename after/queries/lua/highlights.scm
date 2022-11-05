;; extends

(
 (function_call
   (identifier) @pairs
   (#match? @pairs "pairs")
   )
 (set! "priority" 105)
 )

(function_declaration
  (identifier)@function_definition
  )
(
 (function_declaration
   (dot_index_expression
     (identifier)
     (identifier)@function_definition
     )
   )
 (set! "priority" 105)
 )

(
 (assignment_statement
   (variable_list
     (identifier)@function_definition
     )
   (
    expression_list
    (function_definition)
    )
   )
 (set! "priority" 105)
 )
(
 (assignment_statement
   (variable_list
     (dot_index_expression
       (identifier)
       (identifier)@function_definition
       )
     )
   (
    expression_list
    (function_definition)
    )
   )
 (set! "priority" 105)
 )

(
  (function_call
    name: (identifier) @function.builtin
    (#eq? @function.builtin "pairs")
  )
  (#set! conceal "P")
)

(
  (function_call
    name: (identifier) @function.builtin
    (#eq? @function.builtin "ipairs")
  )
  (#set! conceal "I")
)

; (
;   (identifier) @function
;   (#eq? @function "utils")
;   (#set! conceal "")
;   ; (#set! conceal "U")
; )

; (
;   (dot_index_expression
;     table: (identifier) @keyword
;     (#eq? @keyword  "utils" )
;   )
;   (#set! conceal "U")
; )

(
  (dot_index_expression) @keyword
    (#eq? @keyword  "vim.keymap.set" )
  (#set! conceal "襁")
)

; (
;   (dot_index_expression) @variable
;     (#eq? @function  "vim.cmd" )
;   (#set! conceal ">")
; )

(
  (dot_index_expression
  )@keyword
    (#eq? @keyword  "vim.keymap.set" )
  (#set! conceal "")
)

(
  (dot_index_expression
  )@variable
    (#eq? @keyword  "vim.api.nvim_exec_autocmds" )
  (#set! conceal "")
)

(
 (dot_index_expression) @function
 (#eq? @function  "vim.api.nvim_create_autocmd" )
 ; (#set! conceal "a")
 ; (#set! conceal "🪝")
 (#set! conceal "ﯠ")
 )

; (("return" @keyword) (#set! conceal ""))
(("function" @keyword) (#set! conceal ""))
(("not" @keyword) (#set! conceal ""))
; (("for" @repeat) (#set! conceal ""))
(("while" @repeat) (#set! conceal "∞"))

; for -> circle arrow
(
  (break_statement)@keyword
  (#eq? @keyword  "break" )
  (#set! conceal "")
)
