use "hw2.sml";

(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

val test1_1 = all_except_option ("", []) = NONE
val test1_2 = all_except_option ("string", []) = NONE
val test1_3 = all_except_option ("string", ["int"]) = NONE
val test1_4 = all_except_option ("string", ["string", "int"]) = SOME ["int"]
val test1_5 = all_except_option ("string", ["int", "string"]) = SOME ["int"]
val test1_6 = all_except_option ("string", ["real", "int"]) = NONE
val test1_7 = all_except_option ("string", ["string", "real", "int"]) = SOME ["real", "int"]
val test1_8 = all_except_option ("string", ["real", "string", "int"]) = SOME ["real", "int"]
val test1_9 = all_except_option ("string", ["real", "int", "string"]) = SOME ["real", "int"]

val test2_1 = get_substitutions1 ([], "") = []
val test2_2 = get_substitutions1 ([["foo"],["there"]], "") = []
val test2_3 = get_substitutions1 ([], "foo") = []
val test2_4 = get_substitutions1 ([["foo"],["there"]], "foo") = []
val test2_5 = get_substitutions1 ([["foo", "bar"],["there"]], "foo") = ["bar"]
val test2_6 = get_substitutions1 ([["foo"],["there", "bar"]], "foo") = []
val test2_7 = get_substitutions1 ([["foo", "bar", "baz"],["there"]], "foo") = ["bar", "baz"]
val test2_8 = get_substitutions1 ([["foo", "bar"],["there"],["Hello, World!", "foo"]], "foo") = ["bar", "Hello, World!"]
val test2_9 = get_substitutions1 ([["foo", "bar"],["there"],["Hello, World!", "foo", "bar"]], "foo") = ["bar", "Hello, World!", "bar"]
val test2_10 = get_substitutions1 ([["bar"],["there"],["Hello, World!"]], "foo") = []

val test3_1 = get_substitutions2 ([], "") = []
val test3_2 = get_substitutions2 ([["foo"],["there"]], "") = []
val test3_3 = get_substitutions2 ([], "foo") = []
val test3_4 = get_substitutions2 ([["foo"],["there"]], "foo") = []
val test3_5 = get_substitutions2 ([["foo", "bar"],["there"]], "foo") = ["bar"]
val test3_6 = get_substitutions2 ([["foo"],["there", "bar"]], "foo") = []
val test3_7 = get_substitutions2 ([["foo", "bar", "baz"],["there"]], "foo") = ["bar", "baz"]
val test3_8 = get_substitutions2 ([["foo", "bar"],["there"],["Hello, World!", "foo"]], "foo") = ["bar", "Hello, World!"]
val test3_9 = get_substitutions2 ([["foo", "bar"],["there"],["Hello, World!", "foo", "bar"]], "foo") = ["bar", "Hello, World!", "bar"]
val test3_10 = get_substitutions2 ([["bar"],["there"],["Hello, World!"]], "foo") = []

val test4_1 = similar_names ([], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}]
val test4_2 = similar_names ([["Fred"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}]
val test4_3 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"}]
val test4_4 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]
val test4_5 = similar_names ([["Fred"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Freddie", last="Smith", middle="W"},
         {first="F", last="Smith", middle="W"}]
val test4_6 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Betty", middle="W", last="Johnson"}) =
	    [{first="Betty", last="Johnson", middle="W"}, {first="Elizabeth", last="Johnson", middle="W"}]
val test4_7 = similar_names ([["Fred","Fredrick", "F"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="F", last="Smith", middle="W"}, {first="Freddie", last="Smith", middle="W"},
         {first="F", last="Smith", middle="W"}]

val test5_1 = card_color (Clubs, Num 2) = Black
val test5_2 = card_color (Spades, Queen) = Black
val test5_3 = card_color (Diamonds, Num 10) = Red
val test5_4 = card_color (Hearts, Ace) = Red

val test6_1 = card_value (Clubs, Num 2) = 2
val test6_2 = card_value (Spades, Num 5) = 5
val test6_3 = card_value (Diamonds, Num 10) = 10
val test6_4 = card_value (Hearts, Jack) = 10
val test6_5 = card_value (Clubs, Queen) = 10
val test6_6 = card_value (Spades, King) = 10
val test6_7 = card_value (Diamonds, Ace) = 11

val test7_1 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []
val test7_2 = remove_card ([(Hearts, Ace), (Diamonds, Num 10)], (Hearts, Ace), IllegalMove) = [(Diamonds, Num 10)]
val test7_3 = remove_card ([(Hearts, Ace), (Diamonds, Num 10), (Hearts, Ace)], (Hearts, Ace), IllegalMove) = [(Diamonds, Num 10), (Hearts, Ace)]
val test7_4 = remove_card ([(Hearts, Ace), (Hearts, Ace), (Diamonds, Num 10)], (Hearts, Ace), IllegalMove) = [(Hearts, Ace), (Diamonds, Num 10)]

val test8_1 = all_same_color [(Hearts, Ace)] = true
val test8_2 = all_same_color [] = true
val test8_3 = all_same_color [(Spades, Num 10)] = true
val test8_4 = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true
val test8_5 = all_same_color [(Hearts, Ace), (Diamonds, Ace)] = true
val test8_6 = all_same_color [(Spades, Ace), (Hearts, Ace)] = false
val test8_7 = all_same_color [(Hearts, Ace), (Hearts, Jack)] = true
val test8_8 = all_same_color [(Hearts, Ace), (Hearts, Jack), (Clubs, Jack)] = false
val test8_9 = all_same_color [(Hearts, Ace), (Spades, Jack), (Diamonds, Jack)] = false
val test8_10 = all_same_color [(Clubs, Num 2), (Spades, Jack), (Clubs, Jack)] = true

val test9_1 = sum_cards [] = 0
val test9_2 = sum_cards [(Clubs, Num 2)] = 2
val test9_3 = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4
val test9_4 = sum_cards [(Clubs, Num 2),(Clubs, Jack)] = 12
val test9_5 = sum_cards [(Clubs, Ace),(Clubs, Num 9)] = 20
val test9_6 = sum_cards [(Clubs, Ace),(Clubs, King)] = 21
val test9_7 = sum_cards [(Clubs, Num 10),(Clubs, King)] = 20

val test10_1 = score ([], 0) = 0
val test10_2 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4
val test10_3 = score ([(Hearts, Jack),(Clubs, Num 5)],10) = 15
val test10_4 = score ([(Hearts, Num 6),(Clubs, Num 4)],10) = 0
val test10_5 = score ([(Spades, Num 2),(Clubs, Num 4)],10) = 2
val test10_6 = score ([(Hearts, Ace),(Diamonds, Num 5)],10) = 9
val test10_7 = score ([(Hearts, King),(Diamonds, Num 5)],10) = 7
val test10_8 = score ([(Hearts, Num 6),(Hearts, Num 4)],10) = 0

val test11_1 = officiate ([],[], 0) = 0
val test11_2 = officiate ([(Hearts, Num 2)],[], 0) = 0
val test11_3 = officiate ([],[Draw], 15) = 7
val test11_4 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6
val test11_5 = officiate ([(Hearts, Num 2),(Clubs, Num 4),(Spades, Ace),(Diamonds, Jack)],[Draw, Draw, Discard (Clubs, Num 4)], 15) = 6
val test11_6 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw, Draw, Draw], 15) = 9
val test11_7 = officiate ([(Spades, Num 2),(Clubs, Num 4)],[Draw, Draw, Draw], 15) = 4
val test11_8 = officiate ([(Hearts, Num 2),(Clubs, Num 4),(Spades, Ace),(Diamonds, Jack)],[Draw, Draw, Discard (Clubs, Num 4)], 4) = 6
val test11_9 = officiate ([(Hearts, Num 2),(Diamonds, Num 4),(Spades, Ace),(Diamonds, Jack)],[Draw, Draw, Discard (Clubs, Num 4)], 4) = 3
val test11_10 = officiate ([(Hearts, Num 9),(Clubs, Num 4),(Spades, Ace),(Diamonds, Jack)],[Draw, Draw, Discard (Clubs, Num 4)], 4) = 7
val test11_11 = officiate ([(Hearts, Num 9),(Clubs, Num 4),(Spades, Ace),(Diamonds, Jack)],[Draw, Draw, Discard (Clubs, Num 4), Draw], 17) = 9
val test11_12 = officiate ([(Clubs, Num 9),(Clubs, Num 4),(Spades, Ace),(Diamonds, Jack)],[Draw, Draw, Discard (Clubs, Num 4), Draw], 17) = 4
val test11_13 = officiate ([(Hearts, Num 9),(Clubs, Num 4),(Spades, Ace),(Diamonds, Jack)],[Draw, Draw], 13) = 0
val test11_14 = officiate ([(Hearts, Num 9),(Clubs, Num 4),(Spades, Ace),(Diamonds, Jack)],[Draw, Draw, Draw], 13) = 33
val test11_15 = officiate ([(Clubs, Num 9),(Clubs, Num 4),(Spades, Ace),(Diamonds, Jack)],[Draw, Draw, Draw], 13) = 16

(* val test12 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3

val test13 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true) *)