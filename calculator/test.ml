module Test = struct
  let ( -: ) name f = Alcotest.test_case name `Quick f

  type accumulator = { current : string list; all : string list list }

  let get_test_cases lexer lines =
    let rec aux acc lines =
      match lines with
      | [] ->
          acc.current :: acc.all |> List.rev
          |> List.concat_map (function
               | [] -> []
               | expected :: input ->
                   let input = input |> List.rev |> String.concat "\n" in
                   [ (input -: fun () -> Calc.interp lexer input |> Alcotest.(check string) "same string" expected) ])
      | "" :: tail ->
          let new_all = match acc.current with [] -> acc.all | current -> current :: acc.all in
          aux { current = []; all = new_all } tail
      | line :: tail ->
          let new_current = line :: acc.current in
          aux { acc with current = new_current } tail
    in
    aux { current = []; all = [] } lines
end

let () =
  let lines = In_channel.with_open_text "tests.t" In_channel.input_all |> String.trim |> Str.(split (regexp "[\n]")) in
  Alcotest.run "Calculator"
    [ ("sedlex interp", Test.get_test_cases `Sedlex lines); ("ocamllex interp", Test.get_test_cases `Ocamllex lines) ]
