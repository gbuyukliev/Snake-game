class Apple
	attr_reader :x, :y, :apple
	
	APPLE_COLOR = Gosu::Color.argb(0xffff0000)

	def initialize(window)
		@window = window
		@x = rand(40..600)
		@y = rand(87..487)
	end

	def draw
			@window.draw_quad(@x, @y, APPLE_COLOR,
												@x, @y + 15, APPLE_COLOR,
												@x + 15, @y, APPLE_COLOR,
												@x + 15, @y + 15, APPLE_COLOR, 1)
	end
end