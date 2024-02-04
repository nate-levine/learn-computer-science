val x = 1
    (* x maps to 1 *)
fun f y = x + y
    (* f maps to a function that adds 1 to its argument *)
val x = 2
    (* x shadows to 2 *)
val y = 3
    (* y maps to 3 *)
val z = f (x + y)
    (* Call the function defined on line 2 with f(5) *)
    (* z maps to 6 *)
    (* f uses the value of x = 1 that was mapped
       when the function was defined, not x = 2 *)