use "hw1.sml";

(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)


val test1_1 = is_older ((1,2,3),(2,3,4)) = true
val test1_2 = is_older ((2,1,4),(1,1,4)) = false
val test1_3 = is_older ((1,1,4),(1,2,4)) = true
val test1_4 = is_older ((1,2,4),(1,1,4)) = false
val test1_5 = is_older ((1,2,3),(1,2,4)) = true
val test1_6 = is_older ((1,2,4),(1,2,3)) = false
val test1_7 = is_older ((1,2,4),(1,2,4)) = false

val test2_1 = number_in_month ([(2,11,28),(2013,12,2)],2) = 0
val test2_2 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1
val test2_3 = number_in_month ([(2012,2,28),(2013,2,1)],2) = 2

val test3_1 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3
val test3_2 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[]) = 0
val test3_3 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3]) = 2
val test3_4 = number_in_months ([(2012,2,28),(2013,12,1),(2011,2,31),(2011,4,28)],[2,3]) = 2
val test3_5 = number_in_months ([(2012,3,28),(2013,12,1),(2011,1,31),(2011,4,28)],[3]) = 1
val test3_6 = number_in_months ([(2012,9,28),(2013,12,1),(2011,1,31),(2011,12,28)],[2,3,4]) = 0
val test3_7 = number_in_months ([],[2,3,4]) = 0
val test3_8 = number_in_months ([],[]) = 0

val test4_1 = dates_in_month ([],2) = []
val test4_2 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]
val test4_3 = dates_in_month ([(2012,2,28),(2013,2,1)],2) = [(2012,2,28),(2013,2,1)]
val test4_4 = dates_in_month ([(2012,2,28),(2013,12,1)],12) = [(2013,12,1)]
val test4_5 = dates_in_month ([(2012,2,28),(2013,12,1), (2014,2,10)],2) = [(2012,2,28),(2014,2,10)]

val test5_1 = dates_in_months ([],[2,3,4]) = []
val test5_2 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[]) = []
val test5_3 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]
val test5_4 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,4]) = [(2012,2,28),(2011,4,28)]
val test5_5 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,2,31),(2011,4,28)],[2,4]) =  [(2012,2,28),(2011,2,31),(2011,4,28)]
val test5_6 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,12,31),(2011,4,28)],[2, 12]) = [(2012,2,28),(2013,12,1),(2011,12,31)]

val test6_1 = get_nth (["hi", "there", "how", "are", "you"], 1) = "hi"
val test6_2 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"
val test6_3 = get_nth (["hi", "there", "how", "are", "you"], 5) = "you"
val test6_4 = get_nth (["hi", "there", "how", "are", "you"], 6) = "you"

val test7_1 = date_to_string (2013, 6, 1) = "June 1, 2013"
val test7_2 = date_to_string (2022, 1, 40) = "January 40, 2022"
val test7_3 = date_to_string (2000, 12, 15) = "December 15, 2000"
val test7_4 = date_to_string (1999, 13, 14) = "December 14, 1999"

val test8_1 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3
val test8_2 = number_before_reaching_sum (9, [1,2,3,4,5]) = 3
val test8_3 = number_before_reaching_sum (3, [1,2,3,4,5]) = 1
val test8_4 = number_before_reaching_sum (7, [1,5,5,5,5]) = 2
val test8_5 = number_before_reaching_sum (11, [1,5,5,5,5]) = 2
val test8_6 = number_before_reaching_sum (1, [1,2,3,4,5]) = 0

 val test9_1 = what_month 1 = 1
 val test9_2 = what_month 31 = 1
 val test9_3 = what_month 32 = 2
 val test9_4 = what_month 59 = 2
 val test9_5 = what_month 60 = 3
 val test9_6 = what_month 90 = 3
 val test9_7 = what_month 91 = 4
 val test9_8 = what_month 330 = 11
 val test9_9 = what_month 350 = 12
 val test9_10 = what_month 365 = 12

val test10_1 = month_range (31, 34) = [1,2,2,2]
val test10_2 = month_range (29, 31) = [1,1,1]
val test10_3 = month_range (58, 62) = [2,2,3,3,3]
val test10_4 = month_range (333, 335) = [11,11,12]
val test10_5 = month_range (360, 365) = [12,12,12,12,12,12]
val test10_6 = month_range (100, 98) = []
val test10_7 = month_range (70, 70) = [3]

val test11_1 = oldest([]) = NONE
val test11_2 = oldest([(2012,2,28),(2011,3,31),(2014,4,28)]) = SOME (2011,3,31)
val test11_3 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)
val test11_4 = oldest([(2012,2,28),(2011,3,31),(2011,3,28)]) = SOME (2011,3,28)
val test11_5 = oldest([(2012,2,28),(2011,3,31)]) = SOME (2011,3,31)
val test11_6 = oldest([(2012,2,28)]) = SOME (2012,2,28)