(* First-class functions *)
(* Define some functions *)
fun double x = 2 * x
fun incr x = x + 1

(* Bind the functions to a tuple *)
(* val a_tuple = (fn, fn) : (int -> int) * (int -> int) *)
val a_tuple = (double, incr)

(* Access double and pass in 9 as an argument, results in 18 *)
val eighteen = (#1 a_tuple)(9)

(* Functions as arguments *)
(* Apply a function to "x", "n" time *)
fun n_times(f, n, x) =
    if n=0
        then x
        else f(n_times(f, n-1, x))

(* Use the higher-order function to create a simple double "n" times function *)
fun double x = x * 2
fun double_n_times(n, x) =
	n_times(double, n, x)

(* Use the higher-order function to create a simple triple "n" times function *)
fun triple x = 3 * x
fun triple_n_times(n, x) =
	n_times(triple, n, x)