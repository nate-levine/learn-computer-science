(* Use closures to compose two functions *)
(* Type:
   ('b -> 'c) * ('a -> 'b) -> ('a -> 'c) *)
fun compose (f, g) = fn x => f(g x)


(* SML implementation, where the "o" composes f and g *)
f o g

fun backup (f, g) =
    fn x => case f x of
                NONE => g x
              | SOME y => y