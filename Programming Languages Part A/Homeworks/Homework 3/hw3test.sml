use "hw3.sml";

(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

val test1_1 = only_capitals [] = []
val test1_2 = only_capitals ["A","a"] = ["A"]
val test1_3 = only_capitals ["a","b"] = []
val test1_4 = only_capitals ["A","a","B"] = ["A","B"]
val test1_5 = only_capitals ["a","A","B","b","C"] = ["A","B","C"]
val test1_6 = only_capitals ["A","B","C"] = ["A","B","C"]

val test2_1 = longest_string1 [] = ""
val test2_2 = longest_string1 [""] = ""
val test2_3 = longest_string1 ["A","bc","C","cd"] = "bc"
val test2_4 = longest_string1 ["","C"] = "C"
val test2_5 = longest_string1 ["A","bc","C"] = "bc"
val test2_6 = longest_string1 ["A","bc","C","bcde"] = "bcde"
val test2_7 = longest_string1 ["bcde","A","bc","C"] = "bcde"
val test2_8 = longest_string1 ["A","B","C"] = "A"

val test3_1 = longest_string2 [] = ""
val test3_2 = longest_string2 [""] = ""
val test3_3 = longest_string2 ["A","bc","C","cd"] = "cd"
val test3_4 = longest_string2 ["","C"] = "C"
val test3_5 = longest_string2 ["A","bc","C"] = "bc"
val test3_6 = longest_string2 ["A","bc","C","bcde"] = "bcde"
val test3_7 = longest_string2 ["bcde","A","bc","C"] = "bcde"
val test3_8 = longest_string2 ["A","B","C"] = "C"

val test4a_1 = longest_string3 [] = ""
val test4a_2 = longest_string3 [""] = ""
val test4a_3 = longest_string3 ["A","bc","C","cd"] = "bc"
val test4a_4 = longest_string3 ["","C"] = "C"
val test4a_5 = longest_string3 ["A","bc","C"] = "bc"
val test4a_6 = longest_string3 ["A","bc","C","bcde"] = "bcde"
val test4a_7 = longest_string3 ["bcde","A","bc","C"] = "bcde"
val test4a_8 = longest_string3 ["A","B","C"] = "A"

val test4b_1 = longest_string4 [] = ""
val test4b_2 = longest_string4 [""] = ""
val test4b_3 = longest_string4 ["A","bc","C","cd"] = "cd"
val test4b_4 = longest_string4 ["","C"] = "C"
val test4b_5 = longest_string4 ["A","bc","C"] = "bc"
val test4b_6 = longest_string4 ["A","bc","C","bcde"] = "bcde"
val test4b_7 = longest_string4 ["bcde","A","bc","C"] = "bcde"
val test4b_8 = longest_string4 ["A","B","C"] = "C"

val test5_1 = longest_capitalized [] = ""
val test5_3 = longest_capitalized ["a"] = ""
val test5_4 = longest_capitalized ["a","b"] = ""
val test5_5 = longest_capitalized ["a","B"] = "B"
val test5_6 = longest_capitalized ["A","bc","C"] = "A"
val test5_7 = longest_capitalized ["a","bc","C"] = "C"
val test5_8 = longest_capitalized ["ABC","bc","CD"] = "ABC"
val test5_9 = longest_capitalized ["ABCDE","bc","ABCDF"] = "ABCDE"

val test6_1 = rev_string "" = ""
val test6_2 = rev_string "a" = "a"
val test6_3 = rev_string "Bc" = "cB"
val test6_4 = rev_string "abc" = "cba"

val test7_1 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4
val test7_2 = first_answer (fn x => if x >= 1 then SOME x else NONE) [1,2,3,4,5] = 1
val test7_3 = first_answer (fn x => if x <> 1 then SOME x else NONE) [1,2,3,4,5] = 2
val test7_4 = first_answer (fn x => if x <> 1 then SOME x else NONE) [1,2,3,4,5] = 2
val test7_5 = first_answer (fn x => if x then SOME x else NONE) [false, true, false] = true

val test8_1 = all_answers (fn x => SOME [x]) [] = SOME []
val test8_2 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [] = SOME []
val test8_3 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val test8_4 = all_answers (fn x => if x > 1 then SOME [x] else NONE) [2,3,4,5,6,7] = SOME [2,3,4,5,6,7]
val test8_5 = all_answers (fn x => if x > 4 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val test8_6 = all_answers (fn x => if x < 5 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val test8_7 = all_answers (fn x => if x > 1 then SOME [x,x+2] else NONE) [2,3,4] = SOME [2,4,3,5,4,6]
val test8_8 = all_answers (fn x => if x then SOME [false] else NONE) [true,false,true,true] = NONE
val test8_9 = all_answers (fn x => if x then SOME [false] else NONE) [true,true,true] = SOME [false,false,false]

val test9a_1 = count_wildcards UnitP = 0
val test9a_2 = count_wildcards Wildcard = 1
val test9a_3 = count_wildcards (TupleP [Wildcard]) = 1
val test9a_4 = count_wildcards (TupleP [Wildcard, UnitP]) = 1
val test9a_5 = count_wildcards (TupleP [Wildcard, TupleP [UnitP]]) = 1
val test9a_6 = count_wildcards (TupleP [Wildcard, TupleP [Wildcard]]) = 2
val test9a_7 = count_wildcards (TupleP [Wildcard, TupleP [Wildcard, Wildcard]]) = 3
val test9a_8 = count_wildcards (TupleP [TupleP [UnitP, Wildcard, UnitP], Wildcard, TupleP [Wildcard, Wildcard]]) = 4
val test9a_9 = count_wildcards (TupleP [TupleP [UnitP, Wildcard, ConstructorP ("Hello, World!", Wildcard)], Wildcard, TupleP [Wildcard, Wildcard]]) = 5
val test9a_10 = count_wildcards (TupleP [TupleP [UnitP, Wildcard, ConstructorP ("Hello, World!", TupleP [Wildcard, UnitP])], Wildcard, TupleP [Wildcard, Wildcard]]) = 5

val test9b_1 = count_wild_and_variable_lengths (Variable("")) = 0
val test9b_2 = count_wild_and_variable_lengths (Variable("a")) = 1
val test9b_3 = count_wild_and_variable_lengths (Variable("abc")) = 3
val test9b_4 = count_wild_and_variable_lengths Wildcard = 1
val test9b_5 = count_wild_and_variable_lengths (TupleP [Wildcard, Variable("")]) = 1
val test9b_6 = count_wild_and_variable_lengths (TupleP [Wildcard, Variable("abc")]) = 4
val test9b_7 = count_wild_and_variable_lengths (TupleP [TupleP [Variable("abc"), Wildcard, ConstructorP ("Hello, World!", Variable(""))], Wildcard, TupleP [Wildcard, Variable("abcde")]]) = 11

val test9c_1 = count_some_var ("", Variable("")) = 1
val test9c_2 = count_some_var ("x", Variable("")) = 0
val test9c_3 = count_some_var ("", Variable("x")) = 0
val test9c_4 = count_some_var ("x", Variable("x")) = 1
val test9c_5 = count_some_var ("x", (TupleP [Wildcard, Variable("abc")])) = 0
val test9c_6 = count_some_var ("abc", (TupleP [Wildcard, Variable("abc")])) = 1
val test9c_7 = count_some_var ("abcde", (TupleP [TupleP [Variable("abcde"), Wildcard, ConstructorP ("Hello, World!", Variable(""))], Wildcard, TupleP [Wildcard, Variable("abcde")]])) = 2

val test10_1 = check_pat (UnitP) = true
val test10_2 = check_pat (Variable("x")) = true
val test10_3 = check_pat (TupleP [Variable("x"), Variable("x")]) = false
val test10_4 = check_pat (TupleP [Variable("x"), Variable("y")]) = true
val test10_5 = check_pat (TupleP [Variable("x"), TupleP [Variable("y"), Variable("x")]]) = false
val test10_6 = check_pat (TupleP [Variable("x"), TupleP [Variable("y"), Variable("z")]]) = true
val test10_7 = check_pat (TupleP [Variable("x"), TupleP [ConstructorP ("Hello, World!", Variable("z")), Variable("z")]]) = false
val test10_8 = check_pat (TupleP [Variable("x"), TupleP [ConstructorP ("z", Variable("z")), Variable("y")]]) = true

val test11_1 = match (Const(1), UnitP) = NONE
val test11_2 = match (Const(1), Wildcard) = SOME []
val test11_3 = match (Const(27), Variable("abc")) = SOME [("abc", Const(27))]
val test11_4 = match (Unit, UnitP) = SOME []
val test11_5 = match (Const(18), ConstP(18)) = SOME []
val test11_6 = match (Const(18), ConstP(25)) = NONE
val test11_7 = match (Tuple [], TupleP []) = SOME []
val test11_8 = match (Tuple [Const(1)], TupleP [ConstP(1)]) = SOME []
val test11_9 = match (Tuple [Const(1), Const(35)], TupleP [ConstP(1), Variable("abc")]) = SOME [("abc", Const(35))]
val test11_10 = match (Tuple [Const(1), Const(35)], TupleP [ConstP(1), Variable("abc"), UnitP]) = NONE
val test11_11 = match (Tuple [Const(1), Tuple [Const(35), Unit]], TupleP [ConstP(1), TupleP [Variable("abc"), UnitP]]) = SOME [("abc", Const(35))]
val test11_12 = match (Tuple [Const(1), Tuple [Const(35), Const(20)]], TupleP [ConstP(1), TupleP [Variable("abc"), Variable("lol")]]) = SOME [("abc", Const(35)), ("lol", Const(20))]
val test11_13 = match (Constructor ("abc", Unit), ConstructorP ("abc", ConstP(19))) = NONE
val test11_14 = match (Constructor ("abc", Unit), ConstructorP ("abc", UnitP)) = SOME []
val test11_15 = match (Constructor ("abc", Tuple [Const(35), Unit]), ConstructorP ("abc", TupleP [Variable("abc"), UnitP])) = SOME [("abc", Const(35))]

val test12_1 = first_match Unit [] = NONE
val test12_2 = first_match Unit [UnitP] = SOME []
val test12_3 = first_match Unit [Variable("xyz"), UnitP] = SOME [("xyz", Unit)]
val test12_4 = first_match Unit [ConstP(7), UnitP] = SOME []
val test12_5 = first_match (Const(7)) [ConstP(7), UnitP] = SOME []
val test12_6 = first_match (Const(9)) [ConstP(7), Variable("abc")] = SOME [("abc", Const(9))]
val test12_7 = first_match (Const(9)) [ConstP(7), Wildcard, Variable("abc")] = SOME []
val test12_8 = first_match (Tuple[Unit, Unit]) [ConstP(7), (TupleP[Wildcard, UnitP]), Variable("abc")] = SOME []
val test12_9 = first_match (Tuple[Unit, Unit]) [ConstP(7), (TupleP[UnitP, ConstP(37)]), Variable("abc")] = SOME [("abc", Tuple[Unit, Unit])]
val test12_10 = first_match (Constructor("matching", Const(7))) [ConstP(7), ConstructorP("matching", ConstP(7))] = SOME []
val test12_11 = first_match (Constructor("matching", Const(7))) [ConstP(7), ConstructorP("matching", Variable("abc"))] = SOME [("abc", Const(7))]
val test12_12 = first_match (Constructor("matching", Const(7))) [ConstP(7), ConstructorP("unmatching", Variable("abc"))] = NONE
val test12_13 = first_match (Constructor("matching", Unit)) [ConstP(7), ConstructorP("matching", Variable("abc"))] = SOME [("abc", Unit)]
val test12_14 = first_match (Constructor("matching", Unit)) [ConstP(7), ConstructorP("unmatching", Variable("abc"))] = NONE