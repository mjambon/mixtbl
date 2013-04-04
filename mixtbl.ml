(* This source code is released into the Public Domain *)

type 'a t = ('a, (unit -> unit)) Hashtbl.t

let create n = Hashtbl.create n

let access () =
  let r = ref None in
  let get tbl k =
    r := None; (* reset state in case last operation was not a get *)
    try
      (Hashtbl.find tbl k) ();
      let result = !r in
      r := None; (* clean up here in order avoid memory leak *)
      result
    with Not_found -> None
  in
  let set tbl k v =
    let v_opt = Some v in
    Hashtbl.replace tbl k (fun () -> r := v_opt)
  in
  get, set
