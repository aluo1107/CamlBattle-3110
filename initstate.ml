let user_output filename =
  let channel = open_in filename in
  let line = ref "" in
  try
    while true do
      line := input_line channel;
      print_endline !line
    done
  with End_of_file -> ()

let _ =
  for i = 1 to Array.length Sys.argv - 1 do
    user_output Sys.argv.(i)
  done
