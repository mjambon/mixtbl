(* This source code is released into the Public Domain *)

type 'a t
  (** A hash table containing values of different types.
      The type parameter ['a] represents the type of the keys. *)

val create : int -> 'a t
  (** [create n] creates a hash table of initial size [n]. *)

val access : unit -> ('a t -> 'a -> 'b option) * ('a t -> 'a -> 'b -> unit)
  (**
     Return a pair (get, set) that works for a given type of values.
     This function is normally called once for each type of value.
     Several getter/setter pairs may be created for the same type,
     but a value set with a given setter can only be retrieved with
     the matching getter.
     The same getters and setters may be reused across multiple tables.
  *)
