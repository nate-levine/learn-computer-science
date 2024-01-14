(* Filter strings that are equal to or longer than string s *)
fun all_shorter_than_1 (xs, s) =
    filter (fn x => String.size x < String.size s, xs)

(* Avoid recomputation by computing the size of s once *)
fun all_shorter_than_2 (xs, s) =
    let
        val len_s = String.size s
    in
        filter (fn x => String.size x < len_s, xs)
    end