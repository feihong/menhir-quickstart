let rec loop () =
  print_string "> ";
  match read_line () with
  | exception End_of_file -> print_newline ()
  | s ->
      print_endline (Calc.interp `Sedlex s);
      loop ()

let () =
  print_endline "Welcome to Calculator!";
  loop ()
