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
      r := None; (* clean up here in order to avoid memory leak *)
      result
    with Not_found -> None
  in
  let set tbl k v =
    let v_opt = Some v in
    Hashtbl.replace tbl k (fun () -> r := v_opt)
  in
  get, set

let get tbl ~getter x = getter tbl x

let set tbl ~setter x y = setter tbl x y

let length tbl = Hashtbl.length tbl

let clear tbl = Hashtbl.clear tbl

let remove tbl x = Hashtbl.remove tbl x

let copy tbl = Hashtbl.copy tbl

let mem tbl ~getter x =
  match getter tbl x with
  | None -> false
  | Some _ -> true

let find tbl ~getter x =
  match getter tbl x with
  | None -> raise Not_found
  | Some y -> y

let iter_keys tbl f =
  Hashtbl.iter (fun x _ -> f x) tbl

let fold_keys tbl acc f =
  Hashtbl.fold (fun x _ acc -> f acc x) tbl acc

let keys tbl =
  Hashtbl.fold (fun x _ acc -> x :: acc) tbl []

let bindings tbl ~getter =
  fold_keys tbl []
    (fun acc k ->
      match getter tbl k with
      | None -> acc
      | Some v -> (k, v) :: acc)
