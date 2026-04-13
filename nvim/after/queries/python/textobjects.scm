; extends

; decorators (@app.route, @staticmethod, etc.)
(decorator) @annotation.outer
(decorator
  (call
    arguments: (argument_list
      .
      "("
      _+ @annotation.inner
      ")")))

; try/except blocks
(try_statement) @trycatch.outer
(try_statement
  body: (block)? @trycatch.inner)

(except_clause
  (block)? @trycatch.inner) @trycatch.outer

(finally_clause
  (block)? @trycatch.inner) @trycatch.outer
