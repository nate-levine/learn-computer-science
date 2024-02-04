(* This lambda function is redundant *)
fun nth_tail(n, xs) =
    n_times(fn y => tl y, n, xs)


(* A simper solution is just to use tl, as tl is
   already the expression that is needed *)
fun nth_tail(n, xs) =
    n_times(tl, n, xs)