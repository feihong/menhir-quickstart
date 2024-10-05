open Parser
module Lexing = Sedlexing.Utf8

let int = [%sedlex.regexp? Opt '-', Plus '0' .. '9']

let rec token buf =
  match%sedlex buf with
  | white_space -> token buf
  | int -> INT (int_of_string (Lexing.lexeme buf))
  | eof -> EOF
  | _ -> failwith "Unexpected character"

let lexer buf = Sedlexing.with_tokenizer token buf
