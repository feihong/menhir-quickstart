let parse_using_ocamllex (s : string) : Ast.expr = s |> Lexing.from_string |> Parser.prog Olexer.read

let parse (s : string) : Ast.expr =
  s |> Sedlexing.Utf8.from_string |> Lexer.lexer |> MenhirLib.Convert.Simplified.traditional2revised Parser.prog
