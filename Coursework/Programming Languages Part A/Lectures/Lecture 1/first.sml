(* This is a comment. This is our first program. *)

val x = 34; (* int *)
(* static environment: x : int *)
(* dynamic environment: x --> 34 *)

val y = 17;
(* static environment: x : int, y : int *)
(* dynamic environment: x --> 34, y --> 17 *)

val z = (x + y) + (y + 2);
(* static environment: x : int, y : int, z : int *)
(* dynamic environment: x --> 34, y --> 17, z --> 70 *)

val q = z + 1
(* static environment: x : int, y : int, z : int, q : int *)
(* dynamic environment: x --> 34, y --> 17, z --> 70, w --> 71 *)

val abs_oz_z = if z < 0 then 0 - z else z; (* bool *) (* int *)
(* abs_of_z : int *)
(* dynamic environment: ..., abs_of_z --> 70 *)

(* Less-than comparisions:
Syntax:
    e1 < e2, where <, e1, and e2 are subexpressions
Type-checking:
    e1 and e2 must have type int,
    the type of the entire expression is bool
Evaluation rules:
    If e1 is less than e2 the result of the expression
    is true; false otherwise *)