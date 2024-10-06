module Lexing = Sedlexing.Utf8

let digit = [%sedlex.regexp? '0' .. '9']
let int = [%sedlex.regexp? Opt '-', Plus digit]
let letter = [%sedlex.regexp? 'a' .. 'z' | 'A' .. 'Z']
let id = [%sedlex.regexp? Plus letter]

let rec token buf =
  match%sedlex buf with
  | white_space -> token buf
  | "true" -> Parser.TRUE
  | "false" -> FALSE
  | "<=" -> LEQ
  | "*" -> TIMES
  | "+" -> PLUS
  | "(" -> LPAREN
  | ")" -> RPAREN
  | "let" -> LET
  | "=" -> EQUALS
  | "in" -> IN
  | "if" -> IF
  | "then" -> THEN
  | "else" -> ELSE
  | int -> INT (int_of_string (Lexing.lexeme buf))
  | id -> ID (Lexing.lexeme buf)
  | eof -> EOF
  | _ -> failwith "Unexpected character"

let lexer buf = Sedlexing.with_tokenizer token buf
