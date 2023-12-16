open Lib;;
open Suffix_tree;;
open Format;;

let a = Ukkonen.create "abcabcde"

(* let () = print_int (Ukkonen.substring a "000") |> print_newline *)

(* let () = Ukkonen.print Format.std_formatter a *)

(* let () = Ukkonen.suffix_array a;; *)

(* let b = Ukkonen.find a "d";;

let () = print_int b.pos_in_edge;;

let () = print_int b.pos_node.path_position;;

let () = match b.pos_node.node_type with
  | Branch br -> print_endline "branch"
  | Leaf _ -> print_endline "leaf"
;; *)


module B = Bmap(CharString)

let search (t: Ukkonen.t) =
  let m = String.length t.tree_string in
  let rec search' (node: Ukkonen.node) depth =
    let e = ref 0 in
    let label_end n = match node.node_type with
      | Leaf _ -> !e
      | Branch _ -> node.label_end
    in
    let e = label_end node in
      match node.node_type with 
        | Leaf l -> print_endline "leaf"; print_int depth |> print_newline;  print_int l |> print_newline; 
        for i = node.label_start to e do
          print_int i |> print_newline;
          fprintf Format.std_formatter "%c"
            (if i == m+1 then '$' else String.unsafe_get t.tree_string (i-1));
          print_newline ();
        done;
        | Branch b -> print_endline "branch"; print_int depth|> print_newline; 
        for i = node.label_start to e do
          print_int i |> print_newline;
          fprintf Format.std_formatter "%c"
            (if i == m+1 then '$' else String.unsafe_get t.tree_string (i-1));
          print_newline ();
        done;
        B.iter (fun _ n -> search' n (depth+1)) b
  in
  search' t.tree_root 0

let () = search a


