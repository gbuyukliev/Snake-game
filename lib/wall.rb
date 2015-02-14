class Wall
	attr_reader :x, :y
	
	WALL_COLOR = Gosu::Color.argb(0xffffff00)

	def initialize(window)
		@window = window
	end
	
	def draw_1
			@window.draw_quad(0, 527, WALL_COLOR,
												640, 527, WALL_COLOR,
												640, 512, WALL_COLOR,
												0, 512, WALL_COLOR, 2)
												
			@window.draw_quad(0, 527, WALL_COLOR,
												15, 527, WALL_COLOR,
												15, 47, WALL_COLOR,
												0, 47, WALL_COLOR, 2)
												
			@window.draw_quad(625, 527, WALL_COLOR,
												640, 527, WALL_COLOR,
												640, 47, WALL_COLOR,
												625, 47, WALL_COLOR, 2)
												
			@window.draw_quad(0, 62, WALL_COLOR,
												640, 62, WALL_COLOR,
												640, 47, WALL_COLOR,
												0, 47, WALL_COLOR, 2)
	end
	
	def draw_2
		@window.draw_quad(80, 217, WALL_COLOR,
											560, 217, WALL_COLOR,
											560, 197, WALL_COLOR,
											80, 197, WALL_COLOR, 2)
											
		@window.draw_quad(80, 377, WALL_COLOR,
											560, 377, WALL_COLOR,
											560, 357, WALL_COLOR,
											80, 357, WALL_COLOR, 2)
	end	
end