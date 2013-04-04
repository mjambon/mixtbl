Toy OCaml implementation of a statically-typed hash table holding values
of different types.

For actual use, you probably want to include a number of functions from
the standard Hashtbl module and a way to iterate over the keys.

Demo:
```ocaml
$ ocaml
        OCaml version 4.00.1

# #use "topfind";;
- : unit = ()
Findlib has been successfully loaded. Additional directives:
  #require "package";;      to load a package
  #list;;                   to list the available packages
  #camlp4o;;                to load camlp4 (standard syntax)
  #camlp4r;;                to load camlp4 (revised syntax)
  #predicates "p,q,...";;   to set these predicates
  Topfind.reset();;         to force that packages will be reloaded
  #thread;;                 to enable threads

- : unit = ()
# #require "mixtbl";;
/home/martin/dev/mn/powder/lib/ocaml/site-lib/mixtbl: added to search path
/home/martin/dev/mn/powder/lib/ocaml/site-lib/mixtbl/mixtbl.cmo: loaded
# let get_int, set_int = Mixtbl.access ();;
val get_int : '_a Mixtbl.t -> '_a -> '_b option = <fun>
val set_int : '_a Mixtbl.t -> '_a -> '_b -> unit = <fun>
# let tbl = Mixtbl.create 10;;
val tbl : '_a Mixtbl.t = <abstr>
# get_int tbl "a";;
- : '_a option = None
# set_int tbl "a" 1;;
- : unit = ()
# get_int tbl "a";;
- : int option = Some 1
# let get_string, set_string = Mixtbl.access ();;
val get_string : '_a Mixtbl.t -> '_a -> '_b option = <fun>
val set_string : '_a Mixtbl.t -> '_a -> '_b -> unit = <fun>
# set_string tbl "b" "Hello";;
- : unit = ()
# get_string tbl "b";;
- : string option = Some "Hello"
# get_string tbl "a";;
- : string option = None
# get_int tbl "a";;
- : int option = Some 1
# set_string tbl "a" "Bye";;
- : unit = ()
# get_int tbl "a";;
- : int option = None
# get_string tbl "a";;
- : string option = Some "Bye"
```
