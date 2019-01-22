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

val inDomain : varName -> subst -> bool
val vSubst : varName -> subst -> term
val tSubst : subst -> term -> term
val varOccur : varName -> term -> bool
