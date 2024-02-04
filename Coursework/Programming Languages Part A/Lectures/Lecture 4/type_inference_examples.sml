(* 
1. Determine types of bindings in order:
    f : T1 -> T2 [must be a function; all functions take 1 argument]
    x : T1
    y: T3
    z: T4

2. For each val and fun binding analyze the definition for all facts:
    T1 = T3 * T4 [else pattern match does not type-check]
    T1 = int [abs has type int -> int]
    T4 = int [because we added z to an int]
    so: T1 = int * int
    so: (abs y + z) : int, so let-expression : int, so body : int,
    so: T2 = int

    f : int * int -> int
 *)
fun f x =
    let
        val (y, z) = x
    in
        (abs y) + z
    end


(* 
1. Determine types of bindings in order:
    sum : T1 -> T2
    xs : T1
    x : T3
    xs' : T3 list [pattern match a T1]

2. For each val and fun binding analyze the definition for all facts:
    T1 = T3 list
    T2 = int [because 0 might be returned]
    T3 = int [because x : T3, and we add x to something]
    from T1 = T3 list and T3 = int, we know T1 = int list
    from that and T2 int, we know that

    f : int list -> int
*)
fun sum xs =
    case xs of
        [] => 0
      | x:xs' => x + (sum xs')