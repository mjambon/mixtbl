# Mixtbl

Small [OCaml](http://caml.inria.fr/) implementation of a statically-typed hash
table holding values of different types.

The API differs significantly from
[Martin Jambon's initial code](https://github.com/mjambon/mixtbl). To access
a table for values of type `'a`, one needs to create an `'a injection`
using the `access` function. Then, values put in the table using a given
`'a injection` can be retrieved only with the same `'a injection`.

## Tests

Unit tests can be found in `tests.ml`. They demonstrate a basic usage of the
module, and also check some invariants using `OUnit`.

Tests can be run using

```shell
$ make tests
$ ./tests
```

assuming you installed `OUnit` (for instance with `opam install ounit`.

## Demo

Excerpt from the tests:

```ocaml
let test_demo () =
  let inj_int = Mixtbl.access () in
  let tbl = Mixtbl.create 10 in
  OUnit.assert_equal None (Mixtbl.get ~inj:inj_int tbl "a");
  Mixtbl.set inj_int tbl "a" 1;
  OUnit.assert_equal (Some 1) (Mixtbl.get ~inj:inj_int tbl "a");
  let inj_string = Mixtbl.access () in
  Mixtbl.set inj_string tbl "b" "Hello";
  OUnit.assert_equal (Some "Hello") (Mixtbl.get inj_string tbl "b");
  OUnit.assert_equal None (Mixtbl.get inj_string tbl "a");
  OUnit.assert_equal (Some 1) (Mixtbl.get inj_int tbl "a");
  Mixtbl.set inj_string tbl "a" "Bye";
  OUnit.assert_equal None (Mixtbl.get inj_int tbl "a");
  OUnit.assert_equal (Some "Bye") (Mixtbl.get inj_string tbl "a");
  ()
```
