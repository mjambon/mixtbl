
open OUnit

let test1 () =
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

let suite =
  "test_mixtbl" >:::
    [ "test1" >:: test1;
    ]

let _ =
  OUnit.run_test_tt_main suite
