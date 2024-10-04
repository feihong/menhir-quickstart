let random n =
  let buf = Buffer.create 4 in
  for _ = 1 to n do
    Random.int_in_range ~min:0x4e00 ~max:0x9fff |> Uchar.of_int |> Buffer.add_utf_8_uchar buf
  done;
  Buffer.contents buf
