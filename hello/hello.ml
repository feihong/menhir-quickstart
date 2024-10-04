let () =
  Random.self_init ();
  print_endline "你好世界！";
  Printf.printf "Random: %s\n" (Hanzi.random 16)
