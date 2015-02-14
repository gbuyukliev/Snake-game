class Segment
	attr_accessor :x, :snake, :y
	
	SNAKE_COLOR = Gosu::Color.argb(0xff000000)

	def initialize(window, snake, position)
		@window = window
		@x = position[0]
		@y = position[1]
	end

	def draw
		@window.draw_quad(@x, @y, SNAKE_COLOR,
											@x + 25, @y, SNAKE_COLOR,
											@x, @y + 25, SNAKE_COLOR,
											@x + 25, @y + 25, SNAKE_COLOR, 1)
	end
end