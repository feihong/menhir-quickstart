open Ast

let parse_using_ocamllex (s : string) : expr = s |> Lexing.from_string |> Parser.prog OcamlLexer.read

let parse (s : string) : expr =
  s |> Sedlexing.Utf8.from_string |> Lexer.lexer |> MenhirLib.Convert.Simplified.traditional2revised Parser.prog

let rec eval = function Int i -> i | Binop (Add, l, r) -> eval l + eval r | Binop (Mult, l, r) -> eval l * eval r

let interp lexer (s : string) : string =
  let parse = match lexer with `Sedlex -> parse | `Ocamllex -> parse_using_ocamllex in
  s |> parse |> eval |> string_of_int
