signature MY_MATH_LIB
sig
	val fact : int -> int
	val half_pi : int
    doubler: int -> int
end


structure MyMathLib :> MY_MATH_LIB
struct

    fun fact x =
        x = 0
        then 1
        else x * fact (x - 1)

    val half_pi = Math.pi / 2.0

    fun doubler y = y + y

end


val pi = MyMathLib.half_pi + MyMathLib.half_pi