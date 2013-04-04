(* This source code is released in the Public Domain *)

type 'a t = ('a, (unit -> unit)) Hashtbl.t

let create n = Hashtbl.create n

let access () =
  let r = ref None in
  let get tbl k =
    try
      (Hashtbl.find tbl k) ();
      let result = !r in
      r := None;
      result
    with Not_found -> None
  in
  let set tbl k v =
    let v_opt = Some v in
    Hashtbl.replace tbl k (fun () -> r := v_opt)
  in
  get, set
