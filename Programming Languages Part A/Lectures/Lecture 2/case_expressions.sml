datatype mytype = TwoInts of int * int
                | Str of string
                | Pizza

(* mytype -> int *)
fun f (x : mytype) =
    case x of
        Pizza => 3
      | Str s => s ^ "s"
      | TwoInts (i1, i2) => i1 + i2

(* Call "f" with a "mytype",  return 3 *)
f (TwoInts (1, 2))