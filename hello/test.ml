let ( -: ) name f = Alcotest.test_case name `Quick f

let test_case n expected =
  let name = Printf.sprintf "%d random hanzi" n in
  name -: fun () -> Hanzi.random n |> Alcotest.(check string) "same string" expected

let () =
  Random.init 88;
  Alcotest.run "Hello"
    [
      ( "random-hanzi",
        [
          test_case 0 "";
          test_case 1 "韠";
          test_case 2 "鴀謳";
          test_case 4 "枢禬疮雍";
          test_case 5 "醄為析誏鹧";
          test_case 6 "忈遼虼鞓竝儘";
          test_case 7 "奏憖垹銮干柏趠";
          test_case 8 "砿洬郮潥馿縭玔矐";
        ] );
    ]
