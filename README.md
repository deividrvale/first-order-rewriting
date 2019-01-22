# First Order Rewriting and Unification

This project aims is the implementation of most usefull mathematical notions and algorithms on first-order languages and first-order abstract syntax.

At a first hand, we are building the basic language for terms and unification.

---

## Basic Setup

To compile and run the project you need:

* The [Opam](https://opam.ocaml.org/doc/Install.html) package managment. It is also the recommend way to install the OCaml compiler.

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

### Unification
