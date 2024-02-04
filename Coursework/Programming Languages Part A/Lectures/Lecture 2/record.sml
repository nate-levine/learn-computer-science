val x = {bar=1+2, foo=true, baz="Hello, World!"}

val my_brother = {name="Matthew", age=23}

(* 23 *)
age = #age my_brother

(* (4, 3, 7) *)
val record_as_tuple = {2=3, 1=4, 3=7}

(* 4 *)
val first = #1 record_as_tuple