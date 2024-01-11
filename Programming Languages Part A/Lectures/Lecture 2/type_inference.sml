fun sum_triple1 (x, y, z) =
    x + y + z

(* Without the int * int * int value, the type checker has no idea how many fields triple woudl have *)
fun sum_triple2 (triple: int * int * int) =
    #1 triple + #2 triple + #3 triple

(* Because "y" is not used, it does not neccesarily have to be an int type,
   and therefore the type checker declares it as an 'a type *)
fun partial_sum (x, y, z) =
    x + z