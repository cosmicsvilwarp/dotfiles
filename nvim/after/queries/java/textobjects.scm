; extends

; annotations (@Override, @Autowired, etc.)
(marker_annotation) @annotation.outer
(annotation) @annotation.outer
(annotation
  arguments: (annotation_argument_list
    .
    "("
    _+ @annotation.inner
    ")"))

; try/catch blocks
(try_statement) @trycatch.outer
(try_statement
  body: (block
    .
    "{"
    _+ @trycatch.inner
    "}"))

(catch_clause
  body: (block
    .
    "{"
    _+ @trycatch.inner
    "}")) @trycatch.outer

(finally_clause
  (block
    .
    "{"
    _+ @trycatch.inner
    "}")) @trycatch.outer

; assignments (int x = getValue();)
(local_variable_declaration
  declarator: (variable_declarator
    value: (_) @assignment.inner @assignment.rhs)) @assignment.outer

(local_variable_declaration
  declarator: (variable_declarator
    name: (_) @assignment.lhs))

(local_variable_declaration
  declarator: (variable_declarator
    name: (_) @assignment.inner))

(assignment_expression
  right: (_) @assignment.inner @assignment.rhs) @assignment.outer

(assignment_expression
  left: (_) @assignment.lhs)

(assignment_expression
  left: (_) @assignment.inner)

(field_declaration
  declarator: (variable_declarator
    value: (_) @assignment.inner @assignment.rhs)) @assignment.outer

(field_declaration
  declarator: (variable_declarator
    name: (_) @assignment.lhs))

(field_declaration
  declarator: (variable_declarator
    name: (_) @assignment.inner))
