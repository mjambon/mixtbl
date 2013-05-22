
open OUnit

let test_readme () =
  let get_int, set_int = Mixtbl.access () in
  let tbl = Mixtbl.create 10 in
  OUnit.assert_equal None (get_int tbl "a");
  set_int tbl "a" 1;
  OUnit.assert_equal (Some 1) (get_int tbl "a");
  let get_string, set_string = Mixtbl.access () in
  set_string tbl "b" "Hello";
  OUnit.assert_equal (Some "Hello") (get_string tbl "b");
  OUnit.assert_equal None (get_string tbl "a");
  OUnit.assert_equal (Some 1) (get_int tbl "a");
  set_string tbl "a" "Bye";
  OUnit.assert_equal None (get_int tbl "a");
  OUnit.assert_equal (Some "Bye") (get_string tbl "a");
  ()

let test_length () =
  let get_int, set_int = Mixtbl.access () in
  let tbl = Mixtbl.create 5 in
  Mixtbl.set ~setter:set_int tbl "foo" 1;
  Mixtbl.set ~setter:set_int tbl "bar" 2;
  OUnit.assert_equal 2 (Mixtbl.length tbl);
  OUnit.assert_equal 2 (Mixtbl.find ~getter:get_int tbl "bar");
  Mixtbl.set ~setter:set_int tbl "foo" 42;
  OUnit.assert_equal 2 (Mixtbl.length tbl);
  Mixtbl.remove tbl "bar";
  OUnit.assert_equal 1 (Mixtbl.length tbl);
  ()

let test_clear () =
  let get_int, set_int = Mixtbl.access () in
  let get_str, set_str = Mixtbl.access () in
  let tbl = Mixtbl.create 5 in
  Mixtbl.set ~setter:set_int tbl "foo" 1;
  Mixtbl.set ~setter:set_int tbl "bar" 2;
  Mixtbl.set ~setter:set_str tbl "baaz" "hello";
  OUnit.assert_equal 3 (Mixtbl.length tbl);
  Mixtbl.clear tbl;
  OUnit.assert_equal 0 (Mixtbl.length tbl);
  ()

let test_mem () =
  let get_int, set_int = Mixtbl.access () in
  let get_str, set_str = Mixtbl.access () in
  let tbl = Mixtbl.create 5 in
  Mixtbl.set ~setter:set_int tbl "foo" 1;
  Mixtbl.set ~setter:set_int tbl "bar" 2;
  Mixtbl.set ~setter:set_str tbl "baaz" "hello";
  OUnit.assert_bool "mem foo int" (Mixtbl.mem ~getter:get_int tbl "foo");
  OUnit.assert_bool "mem bar int" (Mixtbl.mem ~getter:get_int tbl "bar");
  OUnit.assert_bool "not mem baaz int" (not (Mixtbl.mem ~getter:get_int tbl "baaz"));
  OUnit.assert_bool "not mem foo str" (not (Mixtbl.mem ~getter:get_str tbl "foo"));
  OUnit.assert_bool "not mem bar str" (not (Mixtbl.mem ~getter:get_str tbl "bar"));
  OUnit.assert_bool "mem baaz str" (Mixtbl.mem ~getter:get_str tbl "baaz");
  ()

let test_keys () =
  let get_int, set_int = Mixtbl.access () in
  let get_str, set_str = Mixtbl.access () in
  let tbl = Mixtbl.create 5 in
  Mixtbl.set ~setter:set_int tbl "foo" 1;
  Mixtbl.set ~setter:set_int tbl "bar" 2;
  Mixtbl.set ~setter:set_str tbl "baaz" "hello";
  let l = Mixtbl.keys tbl in
  OUnit.assert_equal ["baaz"; "bar"; "foo"] (List.sort compare l);
  ()

let test_bindings () =
  let get_int, set_int = Mixtbl.access () in
  let get_str, set_str = Mixtbl.access () in
  let tbl = Mixtbl.create 5 in
  Mixtbl.set ~setter:set_int tbl "foo" 1;
  Mixtbl.set ~setter:set_int tbl "bar" 2;
  Mixtbl.set ~setter:set_str tbl "baaz" "hello";
  Mixtbl.set ~setter:set_str tbl "str" "rts";
  let l_int = Mixtbl.bindings tbl ~getter:get_int in
  OUnit.assert_equal ["bar", 2; "foo", 1] (List.sort compare l_int);
  let l_str = Mixtbl.bindings tbl ~getter:get_str in
  OUnit.assert_equal ["baaz", "hello"; "str", "rts"] (List.sort compare l_str);
  ()

let suite =
  "test_mixtbl" >:::
    [ "test_readme" >:: test_readme;
      "test_length" >:: test_length;
      "test_clear" >:: test_clear;
      "test_mem" >:: test_mem;
      "test_bindings" >:: test_bindings;
    ]

let _ =
  OUnit.run_test_tt_main suite
