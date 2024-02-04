(* Apply a function to "x", "n" time *)
fun n_times(f, n, x) =
    if n=0
        then x
        else f(n_times(f, n-1, x))

(* Use the higher-order function to create a simple triple "n" times function *)
fun triple x = 3 * x
fun triple_n_times1(n, x) =
	n_times(triple, n, x)

(* We can define triple in triple_n_times with an anonymous function *)
fun triple_n_times2(n, x) =
	n_times(fn x => 3 * x, n, x)