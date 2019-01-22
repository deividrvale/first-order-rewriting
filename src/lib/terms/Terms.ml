(* This module declares terms abstract syntax language and som substitutios operations *)
open List

(* Types Definitions *)

    (* The Type of varName - Name of Variables *)
    type varName = string * int

    (* Inductive type of firs-order-terms *)
    type term =
        | Var of varName
        | F of string * int * term list

    (* A substitution is a list of mappings from varNames to Terms *)
    type subst = (varName * term) list

    (* A equation is a pair of terms. *)
    type eq = term * term

    (* A Unification problem is a Fail state or a pair of equations list*)
    type prUnif =
        | Fail
        | Pr of (eq list * eq list)

(* Functions Definitions *)

    (* Tests if a varName is in the domain of the substitution *)
    let rec inDomain (var: varName) (s: subst) =
        match s with
        | [] -> false
        | (x, _) :: tail -> if x = var then true else inDomain var tail

    (* The aplication of a substitution to a variable - Note that this is a partial function, it is defined iff the varName is in the domain of the substitution *)
    let rec vSubst (x: varName) (s: subst) =
        match s with
        | [] -> Var x
        | (y, t) :: tail -> if x = y then t else vSubst x tail

    (* The Homomorphic extension of a substitution to terms *)
    let rec tSubst (s: subst) (t: term) =
        match t with
        | Var x -> if inDomain x s then vSubst x s else Var x
        | F (f, a, t') -> F (f, a, List.map (tSubst s) t')

    let rec varOccur (y: varName) (t: term) =
        match t with
        | Var x -> x = y
        | F (_, _, t') -> exists (varOccur y) t'

(* Examples and Tests *)
    let t = F("f",2 , [Var("x",1); Var("x",2)]);;

    let t2 = F("g", 1, [Var("x",1)])

    let gamma = [(("x",1), t2)];;

    tSubst gamma t

    (* varOccur ("x", 2) t *)
