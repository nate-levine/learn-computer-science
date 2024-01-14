(* How the built-in fold function works *)
(* Type:
	('a * 'b -> 'a) * 'a * 'b list -> 'a *)
fun map (f, acc, xs) =
    case xs of
        [] => []
      | x:xs => fold(f, f(acc, x) xs)


(* Use fold to find the sum of a list, produce 10 *)
(* Specific Type:
	('int * 'int -> 'int) * 'int * 'int list -> 'int *)
fold(fn (x, y) => x + y, 0, [1, 2, 3, 4])