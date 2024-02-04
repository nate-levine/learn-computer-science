(* How the built-in map function works *)
(* Type:
	(a' -> b') * 'a list -> 'b list *)
fun map (f, xs) =
    case xs of
        [] => []
      | x:xs' => (f x)::map(f, xs')

(* Use map, produce [5, 9, 13, 17] *)
(* Specific Type (with anonymouse function):
	(int' -> int') * 'int list -> 'int list *)
val x1 = map(fn x => x + 1, [4, 8, 12, 16])


(* How the built-in filter function works *)
(* Type:
   ('a -> bool) * 'a list -> 'a list *)
fun filter (f, xs) =
  case xs of
    [] => []
  | x:xs' => if (f x)
                then x::filter(f, xs')
                else filter(f, xs')

(* Specific Type (with anonymouse function):
   ('int -> bool) * 'int list -> 'int list *)
(* Use filter, produce [12, 16]) *)
val x2 = filter(fn x => x > 9, [4, 8, 12, 16])