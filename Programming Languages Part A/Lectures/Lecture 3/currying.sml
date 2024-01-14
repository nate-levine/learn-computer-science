(* Old way to get the effect of multiple arguments *)
fun sorted3_tuple (x, y, z) =
    z >= y andalso y >= x1

val t1 = sorted3_tuple (7, 9, 11)


(* New way using currying *)
val sorted3_curry =
    fn x => fn y => fn z => z >= y andalso y >= x

val t2 = (((sorted3_curry 7) 9) 11)


(* Currying cleaned up *)
val sorted3 x y z =
    z >= y andalso y >= x

val t3 = sorted3 7 9 11