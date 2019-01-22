open Terms

(* This function applies a substitution to a list of equations *)
let rec appToEqList (sigma: subst) (eqList: eq list): eq list =
    match eqList with
    | [] -> []
    | (s,t) :: tail -> (tSubst sigma s, tSubst sigma t ) :: appToEqList sigma tail

let rec unify (problem: prUnif) =
    match problem with
    | Fail -> Fail
    | Pr ([], _) -> problem
    | Pr ((F (f1,i, arg1), F (f2, j, arg2)) :: tail, sol) ->
        if f1 = f2 && i = j then (
            unify (Pr ((List.combine arg1 arg2) @ tail, sol))
        ) else Fail (* Decomposition and Symbol Clash rules *)
    | Pr ((s,t) :: tail, sol) ->
        (match (s,t) with
        | (F (f, n, arg), Var x) -> unify (Pr ((Var x, F (f, n, arg)) :: tail, sol)) (* Orient Rule *)
        | (Var x, t) ->
            if Var x = t then unify (Pr (tail, sol)) else (
                if Terms.varOccur x t then Fail else (
                    unify (Pr ( appToEqList [(x, t)] tail, (Var x, t) :: appToEqList [(x, t)] sol ) )
                )
            )
        | (s,t) -> if s = t then unify (Pr (tail, sol)) else unify problem (* Trivial Rule *)
        )

let rec extractMgu (problem: prUnif) : subst =
    match unify problem with
    | Fail | Pr (_, []) | Pr (_::_, _) -> []
    | Pr ([], sol) ->
        (match sol with
            | [] -> []
            | (F (_,_,_), _) :: _ -> []
            | (Var x, t) :: tail -> (x,t) :: extractMgu (Pr ([], tail))
        )
