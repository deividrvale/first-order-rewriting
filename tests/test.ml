open Terms
open Unif

let s = F ("f", 2, [Var ("x", 2); F("p",3, [F("a",0,[])])]);;
(* let t = F ("f", 2, [Var ("X",1); Var ("X", 3)]);; *)

let s1 = F ("f", 2, [ F ("g", 3, [Var ("x", 1); Var ("y", 1); F ("h", 1, [Var ("w", 1)])]); Var ("z", 1)] );;
(* let s2 = F ("f", 2, [ F ("g", 3, [ F ("a", 0, []); F ("h", 1, [Var ("x",1)]); F ("h", 1, [ F ("f", 2, [ Var ("x",1); F ("b", 0, []) ])])]) ]);; *)

unify (Pr ([(s1, s)], []))

