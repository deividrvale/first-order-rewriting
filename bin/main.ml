
let print_string_flush s = (print_string s ; flush stdout)

let str_usage = "\
\n\
Usage :\n\
-------\n\
\n\
ltnm help                : print help\n\
\n\
ltnm alpha s t           : alpha-equivalence between s and t\n\
ltnm match s t           : match s on t\n\
\n\
ltnm bench     <start>\n\
\              <stop>\n\
\              <steps>\n\
\              (core|alpha|match)   : make benches\n\
\n\
ltnm version             : show version\n\
ltnm usage               : this message\n\
\n\
"

exception Bad_usage

let getArgument i =
    if i < Array.length Sys.argv then
        Sys.argv.(i)
    else
        raise Bad_usage

let print_help () =
    print_string_flush str_usage

let print_usage () =
    print_string_flush "Usage Text"

let main () =
  try (match getArgument 1 with
        | "help"    -> print_help ()
        | _         -> raise Bad_usage
      )
  with Bad_usage -> print_usage ()
;;

main ()
