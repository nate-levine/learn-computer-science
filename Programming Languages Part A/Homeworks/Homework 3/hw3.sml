(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end


(* #1 *)
(* List.filter : ('a -> bool) -> 'a list -> 'a list
    - Filters list based on function f, which returns a bool *)
(* Char.isUpper : char -> bool
    - Returns true if a char c is an uppercase letter *)
(* String.sub : string * int -> char
    - Returns the nth 0-indexed character of a string s *)

(* string list -> string list *)
val only_capitals = List.filter (fn s => Char.isUpper(String.sub(s, 0)))


(* #2 *)
(* List.foldl : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b
    - Returns f(xn, ..., f(x1, acc)), or acc if the list is empty *)
(* String.size : string -> int
    - Returns the number of characters in string s *)

(* string list -> string *)
val longest_string1 =
    List.foldl (fn (x, y) => if String.size(x) > String.size(y)
                             then x
                             else y)
               ""


(* #3 *)
(* List.foldl : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b
    - Returns f(xn, ..., f(x1, acc)), or acc if the list is empty *)
(* String.size : string -> int
    - Returns the number of characters in string s *)

(* string list -> string *)
val longest_string2 =
    List.foldl (fn (x, y) => if String.size(x) >= String.size(y)
                             then x
                             else y)
               ""


(* #4 *)

(* (int * int -> bool) -> string list -> string *)
fun longest_string_helper f strings =
    let
        fun fn_for_strings acc strings =
            case strings of
                [] => acc 
            | head::tail => if f(String.size(head), String.size(acc))
                            then fn_for_strings head tail
                            else fn_for_strings acc tail
    in
        fn_for_strings "" strings
    end

(* a *)
(* string list -> string *)
val longest_string3 = longest_string_helper (fn (x, y) => x > y)

(* b *)
(* string list -> string *)
val longest_string4 = longest_string_helper (fn (x, y) => x >= y)


(* #5 *)
(* string list -> string *)
val longest_capitalized = ((longest_string_helper (fn (x, y) => x > y)) o only_capitals)


(* #6 *)
(* List.rev : 'a list -> 'a list
    - Returns a list of list l's elements in reverse order *)
(* String.explode : string -> char list
    - Produces a list l of characters from string s *)
(* String.implode : char list -> string
    - Produces a string s from characters in list l *)

(* string -> string *)
val rev_string = String.implode o List.rev o String.explode


(* #7 *)
(* ('a -> 'b option) -> 'a list -> 'b *)
fun first_answer f xs =
    case xs of
        [] => raise NoAnswer
      | head::tail => case (f head) of
                      SOME head => head
                    | NONE => first_answer f tail


(* #8 *)
(* ('a -> 'b list option) -> 'a list -> 'b list option *)
fun all_answers f xs =
    let
        fun fn_for_xs acc xs =
            case xs of
                [] => SOME acc
              | head::tail => case (f head) of
                                 SOME xs => fn_for_xs (acc @ xs) tail
                               | NONE => NONE
    in
        fn_for_xs [] xs
    end


(* #9 *)

(* a *)
(* pattern -> int *)
val count_wildcards = g (fn _ => 1) (fn _ => 0)

(* b *)
(* pattern -> int *)
val count_wild_and_variable_lengths = g (fn _ => 1) String.size

(* c *)
(* string * pattern -> int *)
fun count_some_var (s, p) = g (fn _ => 0) (fn x => if x = s then 1 else 0) p


(* #10 *)
(* List.exists : ('a -> bool) -> 'a list -> bool
    - applies function f to each element x until f x evaluates to true
    - returns true if x evaluates to true, false otherwise *)

(* pattern -> string list *)
fun all_variables p =
	case p of
	    Variable x          => [x]
	  | TupleP (head::tail) => (all_variables head) @ (all_variables (TupleP tail))
	  | ConstructorP(_, p)   => all_variables p
	  | _                   => []

(* string list -> boolean *)
fun are_no_repeats strings =
    case strings of
        [] => true
      | head::tail => not(List.exists (fn t' => t' = head) tail) andalso (are_no_repeats tail)

(* pattern -> boolean *)
fun check_pat p = are_no_repeats (all_variables p)


(* #11 *)
(* List.length : 'a list -> int
    - returns the number of elements in list l *)
(* ListPair.zip : 'a list * 'b list -> ('a * 'b) list
    - Combine list l1 and l2 into a a list of pairs, with the nth pair being comprised of the nth element from l1 and l2 *)

(* valu * pattern -> (string * valu) list option *)
fun match (v, p) =
    case (v, p) of
        (Constructor (s1, v), ConstructorP (s2, p)) => if s1 = s2
                                                       then match(v, p)
                                                       else NONE
      | (Tuple v, TupleP p) => if List.length v = List.length p
                               then all_answers (match) (ListPair.zip(v, p))
                               else NONE
      | (Const v, ConstP p) => if v = p
                               then SOME []
                               else NONE
      | (Unit, UnitP) => SOME []
      | (v, Variable s) => SOME [(s, v)]
      | (v, Wildcard) => SOME []
      | _ => NONE


(* #12 *)
(* valu * pattern list -> (string * value) list option *)
fun first_match v ps =
    SOME (first_answer (fn p => match (v, p)) ps)
        handle NoAnswer => NONE


(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)