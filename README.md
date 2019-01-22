# First Order Rewriting and Unification

This project aims is the implementation of most usefull mathematical notions and algorithms on first-order languages and first-order abstract syntax.

## Note

This is a learning project. So if you are an expert developer in OCaml do expect some naive implementation. Even some non-standard development practice. I'm working hard to minimize that as I learn more about OCaml and Functional Programming.

I have two main concern in the development:

* Learn the OCaml programming language in an effective way. Nothing more better than create a problem to solve. Right?

* Learn how the implementation of pure mathematical notions can be done. I'm a mathematician and, pure algoritmic problems usually is not my area of expertise. This project are helping me a lot with this problem.

* Additionally, with the knowledge I get with this project I'm working on implementations of Nominal Terms and Nominal Unification. This is the main concern in my research project as a mathematician.

With all these things considered, at a first moment efficience is not my primary concern (but I do the best I can to run things as fast as possible). I will update the library to a more consise production one, as the development flows to a more concise first-order library.

---

## Basic Setup

To compile and run the project you need:

* The [Opam](https://opam.ocaml.org/doc/Install.html) package management. It is also the recommend way to install the OCaml compiler.

* OCaml v4.07.1, see [the installation instructions](https://ocaml.org/docs/install.html) for mor details on how to install OCaml.

* Dune build system v1.6.3
  * It can be installed easily by using Opam. Just type:

        opam install dune

For development purposes I'm also using:

* [Visual Studio Code](https://code.visualstudio.com/) with this [plugin](https://marketplace.visualstudio.com/items?itemName=freebroccolo.reasonml) to support OCaml development.

* For language IntelliSense most people use the [Merlin](https://github.com/ocaml/merlin) tool.

---

## Mathematical Objects in OCaml

OCaml doesn't have a built-in set type. I implement multisets as the built-in OCaml lists.

## Automated Reasoning Implementations

As this project grows I will add more info about the implementation details. For now we have only the basic abstract syntax and unification.

Terms and Unification are served project-wide as libraries. This is better if one needs to extend the development to other module that need to work with terms or unification.

### Terms Language

Terms are built using type constructors.

```ocaml
    (* Variables Names *)
    type varName = string * int

    (* Inductive type of firs-order-terms *)
    type term =
        | Var of varName
        | F of string * int * term list
```

A term is a variable (wich has a variable name type instance) and function application is a triple defined by a function name, function arity and a list of its arguments.

Substitutions are just list o mappings from variables-names to terms, as usual.

```ocaml
    (* A substitution is a list of mappings from varNames to Terms *)
    type subst = (varName * term) list
```

They are extended to a mapping from terms to terms as usual in the theory.

### Unification

We have implemented the martelli-montanari rules approach to unification. The algoritm consist on applying simplification rules for problems (defined as a tuple set of equations and equations in solved form).

It has no variable sharing, so the complexity can be in the worst case **exponential**.
