(* int list -> bool *)
fun nondecreasing xs =
    case xs of
        [] =>
            true
      (* "_" is better style in that is specifies the data from
         the variable is not used in the scope *)
      | _::[] =>
            true
      | head::(neck::tail) =>
            head <= neck andalso nondecreasing(neck::tail)


datatype sgn = P | N | z

(* int * int -> sgn *)
fun multsign (x1, x2) =
    let
        fun sign x =
            if x = 0
                then Z
            else if x > 0
                then P
            else
                N
    in
        case (sign x1, sign x2) of
            (Z, _) => Z
          | (_, Z) => Z
          | (P, P) => P
          | (N, N) => P
          | _ => N
    end

(* 'a list => int *)
fun len xs =
    case xs of
        [] => 0
      | x::xs' => 1 + len(xs')