(* 1. Write a function is_older that takes two dates and evaluates to true or false. It evaluates to true if
the first argument is a date that comes before the second argument. (If the two dates are the same,
the result is false.) *)

(* (int * int * int) * (int * int * int) -> bool *)
fun is_older (date1 : int * int * int, date2 : int * int * int) =
    if (#1 date1) < (#1 date2)
        then true
    else if (#1 date1) = (#1 date2)
        then if (#2 date1) < (#2 date2)
            then true
        else if (#2 date1) = (#2 date2)
            then (#3 date1) < (#3 date2)
        else
            false
    else
        false
        
(* 2. Write a function number_in_month that takes a list of dates and a month (i.e., an int) and returns
how many dates in the list are in the given month. *)

(* (int * int * int) list * int -> int *)
fun number_in_month (dates : (int * int * int) list, month : int) =
    (* acc: int; number of dates in month so far *)
    let
        fun fn_for_dates (dates : (int * int * int) list, month : int, acc : int) =
            if null dates
                then acc
            else
                if (#2 (hd dates)) = month
                    then fn_for_dates(tl dates, month, acc + 1)
                else
                    fn_for_dates(tl dates, month, acc)
    in
        fn_for_dates(dates, month, 0)
    end

(* 3. Write a function number_in_months that takes a list of dates and a list of months (i.e., an int list)
and returns the number of dates in the list of dates that are in any of the months in the list of months.
Assume the list of months has no number repeated. Hint: Use your answer to the previous problem. *)

(* (int * int * int) list * int list -> int *)
fun number_in_months (dates : (int * int * int) list, months : int list) =
    (* acc: int; number of dates in month so far *)
    let
        fun fn_for_months (dates : (int * int * int) list, months : int list, acc : int) =
            if null months
                then acc
            else
                fn_for_months(dates, tl months, acc + number_in_month(dates, hd months))
    in
        fn_for_months(dates, months, 0)
    end

(* 4. Write a function dates_in_month that takes a list of dates and a month (i.e., an int) and returns a
list holding the dates from the argument list of dates that are in the month. The returned list should
contain dates in the order they were originally given *)

(* (int * int * int) list * int -> (int * int * int) list *)
fun dates_in_month (dates : (int * int * int) list, month : int) =  
    if null dates
        then []
    else
        if (#2 (hd dates)) = month
            then (hd dates)::dates_in_month(tl dates, month)
        else
            dates_in_month(tl dates, month)

(* 5. Write a function dates_in_months that takes a list of dates and a list of months (i.e., an int list)
and returns a list holding the dates from the argument list of dates that are in any of the months in
the list of months. Assume the list of months has no number repeated. Hint: Use your answer to the
previous problem and SML’s list-append operator (@). *)

(* NOTE: SML has a built in list-append operator: @ *)

(* (int * int * int) list * int list -> (int * int * int) list *)
fun dates_in_months (dates : (int * int * int) list, months : int list) =
    if null months
        then []
    else
        dates_in_month(dates, hd months) @ dates_in_months(dates, (tl months))

(* 6. Write a function get_nth that takes a list of strings and an int n and returns the nth element of the
list where the head of the list is 1st. Do not worry about the case where the list has too few elements:
your function may apply hd or tl to the empty list in this case, which is okay. *)

(* string list * int -> string *)
fun get_nth (strings : string list, index : int) =
    (* acc: int; number of elements seen so far *)
    let
        fun fn_for_strings (strings : string list, index : int, acc : int) =
            if null (tl strings)
                then hd strings
            else
                if acc = index
                    then hd strings
                else
                    fn_for_strings(tl strings, index, acc + 1)
    in
        fn_for_strings(strings, index, 1)
    end

(* 7. Write a function date_to_string that takes a date and returns a string of the form January 20, 2013
(for example). Use the operator ^ for concatenating strings and the library function Int.toString
for converting an int to a string. For producing the month part, do not use a bunch of conditionals.
Instead, use a list holding 12 strings and your answer to the previous problem. For consistency, put a
comma following the day and use capitalized English month names: January, February, March, April,
May, June, July, August, September, October, November, December. *)

(* int * int * int -> string *)
fun date_to_string (date: int * int * int) =
    let
        val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in
        get_nth(months, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
    end

(* 8. Write a function number_before_reaching_sum that takes an int called sum, which you can assume
is positive, and an int list, which you can assume contains all positive numbers, and returns an int.
You should return an int n such that the first n elements of the list add to less than sum, but the first
n + 1 elements of the list add to sum or more. Assume the entire list sums to more than the passed in
value; it is okay for an exception to occur if this is not the case. *)

(* int * int list -> int *)
fun number_before_reaching_sum (target_sum : int, numbers : int list) =
    let
        fun fn_for_numbers (numbers : int list, index : int, sum : int) =
            if null numbers
                then index - 1
            else
                if sum >= target_sum
                    then index - 1
                else
                    fn_for_numbers(tl numbers, index + 1, sum + hd numbers)
    in
        fn_for_numbers(numbers, 0, 0)
    end

(* 9. Write a function what_month that takes a day of year (i.e., an int between 1 and 365) and returns
what month that day is in (1 for January, 2 for February, etc.). Use a list holding 12 integers and your
answer to the previous problem. *)

(* int -> int *)
fun what_month (day : int) =
    let 
        val days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        number_before_reaching_sum(day, days_in_months) + 1
    end

(* 10. Write a function month_range that takes two days of the year day1 and day2 and returns an int list
[m1,m2,...,mn] where m1 is the month of day1, m2 is the month of day1+1, ..., and mn is the month
of day day2. Note the result will have length day2 - day1 + 1 or length 0 if day1>day2. *)

(* int * int -> int list *)
fun month_range (day1 : int, day2 : int) =
    if day1 > day2
        then []
    else
        what_month(day1)::month_range(day1 + 1, day2)

(* 11. Write a function oldest that takes a list of dates and evaluates to an (int*int*int) option. It
evaluates to NONE if the list has no dates and SOME d if the date d is the oldest date in the list. *)

(* (int * int * int) list -> (int * int * int) option *)
fun oldest (dates : (int * int * int) list) =
    if null dates
        then NONE
    else if null (tl dates)
        then SOME (hd dates)
    else
        let
            val oldest_tl = oldest(tl dates)
        in
            if isSome oldest_tl andalso is_older(hd dates, valOf oldest_tl)
                then SOME (hd dates)
            else
                oldest(tl dates)
        end