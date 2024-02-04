# The superclass Point
class Point
    def initialize(a, b)
        @x = a
        @y = b
    end

    def distFromOrigin
        Math.sqrt(@x * @x + @y * @y)
    end
end

# The subclass ColorPoint
# The < denotes it is a subclass of the class Point
# ColorPoint inherits the method "distFromOrigin" from Point

# ColorPoint's initialize method overrides Point's initialize method
# "super" is used to call the superclass' same method as a helper function
class ColorPoint < Point
    def initialize(x, y, c="clear")
        super(x, y)
        @color = calls
    end
end# The superclass Point
class Point
    def initialize(a, b)
        @x = a
        @y = b
    end

    def distFromOrigin
        Math.sqrt(@x * @x + @y * @y)
    end
end
