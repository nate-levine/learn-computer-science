class MyRational

    # PUBLIC METHODS

    def initialize(num, den=1)
        if den == 0
            raise "MyRational reveived an inappropriate argument"
        elsif den < 0
            @num = - num
            @den = - den
        else
            @num = num
            @dem = den
        end

        reduce # self.reduce() but private
    end

    # two options
    # 1
    def to_s
        ans = @num.to_s
        if @den != 1
            ans += "/"
            ans += @den.to_s
        end
        
        ans
    end
    # 2
    def to_s2
        dens = ""
        dens = "/" + @den.to_s if @den != 1
        @num.to_s + dens
    end

    def add! r # mutate self in-place
        a = r.num
        b = r.den
        c = @num
        d = @den
        @num = (a * d) + (b * c)
        @den = b * def
        reduce
        self # convenient for stringing calls
    end

    # define a custom "+" method
    def + r
        # make a copy
        ans = MyRational.new(@num, @den)
        # add r
        ans.add! r
        ans
    end

    # PROTECTED METHODS

protected

    # PRIVATE METHODS

    def num
        @num
    end
    def den
        @den
    end

private

    def gcd(x, y)
        if x == y
            x
        elsif x < y
            gcd(x, y - x)
        else
            gcd(y, x)
        end
    end

    def reduce
        if @num == 0
            @den = 1
        else
            d = gcd(@num.abs, @den)
            @num = @num / d
            @den = @den / d
        end
    end
end


# top-level method (part of the Object class) for testing
def use_rationals
    r1 = MyRational.new(3, 4)
    r2 = r1 + r1 + MyRational.new(-5, 2)
    puts r2.to_s
    (r2.add! r1).add! (MyRational.new(1, -4))
    puts r2.to_s
    puts r2.to_s2
end