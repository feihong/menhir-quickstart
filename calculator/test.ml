open Ast

let parse (s : string) : expr = Lexing.from_string s |> Parser.prog Lexer.read
let interp (s : string) : string = match parse s with Int i -> string_of_int i

module Test = struct
  let ( -: ) name f = Alcotest.test_case name `Quick f

  type accumulator = { current : string list; all : string list list }

  let get_test_cases lines =
    let rec aux acc lines =
      match lines with
      | [] ->
          acc.current :: acc.all |> List.rev
          |> List.filter_map (function
               | [] -> None
               | expected :: input ->
                   let input = input |> List.rev |> String.concat "\n" in
                   Some (input -: fun () -> interp input |> Alcotest.(check string) "same string" expected))
      | "" :: tail -> aux { current = []; all = acc.current :: acc.all } tail
      | line :: tail ->
          let new_current = line :: acc.current in
          aux { acc with current = new_current } tail
    in
    aux { current = []; all = [] } lines
end

let () =
  let lines = In_channel.with_open_text "tests.t" In_channel.input_all |> String.trim |> Str.(split (regexp "[\n]")) in
  (* lines |> List.iter (Printf.printf "%S\n") *)
  Alcotest.run "Calculator" [ ("interp", Test.get_test_cases lines) ]
