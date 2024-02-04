(* 
1. Determine types of bindings in order:
    length : T1 -> T2
    xs : T1

    x : T3
    xs' : T3 list

2. For each binding analyze the definitions for each fact:
    T2 = int
    that's all...

    T3 list -> int

3. Use polymorphic types for unconstrained types:
    T3 = 'a

    'a list -> int
 *)
fun length xs =
    case xs of
        [] => 0
      | x:xxs' => 1 + (length xs')


(* 
Determine types of bindings in order:
    f : T1 * T2 * T3 -> T4
    x : T1
    y : T2
    z : T3

2. For each binding analyze the definitions for each fact:
    T4 = T1 * T2 * T3
    T4 = T2 * T1 * T3
        - only way those can both be true is if T1 = T2
    put it all together:

    f : T1 * T1 * T3 -> T1 * T1 * T3

3. Use polymorphic types for unconstrained types:
    T1 = 'a
    T3 = 'b

    'a * 'a * 'b -> 'a * 'a * 'b
 *)
fun f (x, y z) =
    if true
    then (x, y, z)
    else (y, x, z)


(* 
1. Determine types of bindings in order:
    compose : T1 * T2 -> T3
    f : T1
    g : T2

    x : T4

2. For each binding analyze the definitions for each fact:
    - body being a function has type:
    T3 = T4 -> T5
    - from g being passed x:
    T2 = T4 -> T6
    - from f being passed the result of g:
    T1 = T6 -> T7
    - from f being body of anonymous function:
    T7 = T5

    ...
    T1 = T6 -> T5
    T2 = T4 -> T6
    T3 = T4 -> T5

    (T6 -> T5) * (T4 -> T6) -> (T4 -> T5)

3. Use polymorphic types for unconstrained types:
    T6 = 'a
    T5 = 'b
    T4 = 'c

    ('a -> 'b) * ('c -> 'a) -> ('c -> 'b)
 *)
fun compose (f, g) =
    fn x => f (g x)