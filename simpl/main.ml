let rec loop () =
  print_string "> ";
  match read_line () with
  | exception End_of_file -> print_newline ()
  | s ->
      print_endline ("~> " ^ s);
      loop ()

let () =
  print_endline "Welcome to SimPL!";
  loop ()
