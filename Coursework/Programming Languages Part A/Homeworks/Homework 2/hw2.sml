(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* #1 *)
(* string * string list -> string list option *)
fun all_except_option (string, strings) =
   case strings of
      [] => NONE
    | head::tail => if same_string(head, string)
                          then SOME tail
                          else case all_except_option(string, tail) of
                              SOME x => SOME (head::x)
                            | NONE => NONE

(* #2 *)
(* string list list * string -> string list *)
fun get_substitutions1 (substitutions, string) =
   case substitutions of
      [] => []
    | head::tail => case all_except_option(string, head) of
                      SOME x => x @ get_substitutions1(tail, string)
                    | NONE => get_substitutions1(tail, string)


(* #3 *)
(* string list list * string -> string list *)
fun get_substitutions2 (substitutions, string) =
   let
      fun fn_for_substitutions (substitutions, acc) =
         case substitutions of
            [] => acc
          | head::tail => case all_except_option(string, head) of
                          SOME x => fn_for_substitutions(tail, acc @ x)
                        | NONE => fn_for_substitutions(tail, acc)
   in
      fn_for_substitutions(substitutions, [])
   end


(* #4 *)
(* string list list * {first:string, middle:string, middle:string} => {first:string, last:string, middle:string} list *)
fun similar_names (substitutions, {first=x, middle=y, last=z}) =
   let
      val similar_names = get_substitutions2(substitutions, x);
      fun fn_for_substitutions(similar_names, {first=x, last=y, middle=z}) =
         case similar_names of
            [] => []
         | head::tail => {first=head, last=y, middle=z}::fn_for_substitutions(tail, {first=x, last=y, middle=z})
   in
      {first=x, last=z, middle=y}::fn_for_substitutions(similar_names, {first=x, last=z, middle=y})
   end


(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

(* #5 *)
(* card -> color *)
fun card_color card =
   case card of
      (Clubs, rank) => Black
    | (Diamonds, rank) => Red
    | (Hearts, rank) => Red
    | (Spades, rank) => Black


(* #6 *)
(* card -> int *)
fun card_value card =
   case card of
      (suit, Ace) => 11
    | (suit, Jack) => 10
    | (suit, Queen) => 10
    | (suit, King) => 10
    | (suit, Num x) => x


(* #7 *)
(* card list * card * exn -> card list *)
fun remove_card (cs, c, e) =
   case cs of
      [] => raise e
    | head::tail => if head = c
                        then tail
                        else head::remove_card(tail, c, e)


(* #8 *)
(* card list -> bool *)
fun all_same_color cards =
   case cards of
      [] => true
    | head::neck => case neck of
                    [] => true
                  | neck::tail => if card_color(head) = card_color(neck)
                                    then true andalso all_same_color(neck::tail)
                                    else false


(* #9 *)
(* card list -> int *)
fun sum_cards cards =
   let
      fun fn_for_cards(cards, acc) =
         case cards of
            [] => acc
         | head::tail => fn_for_cards(tail, card_value(head) + acc)
   in
      fn_for_cards(cards, 0)
   end


(* #10 *)
(* card list * int -> int *)
(* if sum > goal then preliminary_score = 3 * (sum - goal)
   if sum < goal then preliminary_score =     (goal - sum)
   if all_same_color(cards) then score = preliminary_score div 2
                            else score = preliminary_score       *)
fun score (cards, goal) =
   let
      val sum = sum_cards(cards);
      val preliminary_score = if sum > goal
                                 then 3 * (sum - goal)
                                 else (goal - sum);
   in
      if all_same_color(cards)
         then preliminary_score div 2
         else preliminary_score
   end


(* #11 *)
(* card list * move list * int -> int *)
(* NOTE: if sum of held_cards > goal, end and get score *)
fun officiate (cards, moves, goal) =
   let
      fun fn_helper (cards, moves, held_cards) =
         if sum_cards(held_cards) > goal
            then score(held_cards, goal)
            else
               case cards of
                  [] => score(held_cards, goal)
               | c_head::c_tail => case moves of
                                       [] => score(held_cards, goal)
                                    | m_head::m_tail => case m_head of
                                                            Draw => fn_helper(c_tail, m_tail, c_head::held_cards)
                                                            | Discard c => fn_helper(c_head::c_tail, m_tail, remove_card(held_cards, c, IllegalMove))
   in
      fn_helper (cards, moves, [])
   end