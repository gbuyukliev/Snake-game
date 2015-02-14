class GameWindow < Gosu::Window

  TEXT_COLOR = Gosu::Color.argb(0xff808080)
  PAUSE_TEXT_COLOR = Gosu::Color.argb(0xffffffff)

  def initialize
    super(640, 527, false)
    self.caption = "Snake"

    @background_image = Gosu::Image.new(self, "media/Grass.jpg", true)
    @background_image_black = Gosu::Image.new(self, "media/Black.jpg", true)
    @font = Gosu::Font.new(self, Gosu.default_font_name, 20)

    reset_game
  end

  def next_level
    @snake = Snake.new(self)
    @apple = Apple.new(self)		
    @wall = Wall.new(self)

    @level += 1
    @apples_to_collect = 5 * @level + 10
  end

  def reset_game
    @snake = Snake.new(self)
    @apple = Apple.new(self)
    @wall = Wall.new(self)

    @paused = false
    @game_over = false
    @level = 1
    @apples_to_collect = 15
    @score = 0
  end

  def toggle_pause
    @paused = !@paused
	
    if @snake.speed != 0
      @snake.speed = 0
    else @snake.speed = @save_speed
    end
  end

  def snake_update
    if button_down? Gosu::KbLeft and @snake.direction != :right
      @snake.direction = :left
    elsif button_down? Gosu::KbUp and @snake.direction != :down
      @snake.direction = :up		
    elsif button_down? Gosu::KbRight and @snake.direction != :left
      @snake.direction = :right		
    elsif button_down? Gosu::KbDown and @snake.direction != :up
      @snake.direction = :down
    end

    @snake.length -= 1 if @snake.length > 0
  end

  def eat_apples_update
    if @snake.ate_apple?(@apple)
      @apples_to_collect -= 1
      @score += 20

      if @apples_to_collect == 0
        next_level
      else
        @apple = Apple.new(self)
        @snake.length += 6
      end
    end
  end

  def update
    unless @paused || @game_over
      snake_update
      eat_apples_update
      if @level == 2 then @snake.teleport_level_2 end
      if @snake.hit_self? then @game_over = true end
      case @level
        when 1
          if @snake.hit_wall_level_1? then @game_over = true end
	when 2
          if @snake.hit_wall_level_2? then @game_over = true end
      end
      @save_speed = @snake.speed
    end
  end

  def draw_text
    @font.draw("Apples: #{@apples_to_collect}", 15, 10, 3, 1.3, 1.3, TEXT_COLOR)
    @font.draw("Score: #{@score}", 145, 10, 3, 1.3, 1.3, TEXT_COLOR)		
    @font.draw("Level: #{@level}", 540, 10, 3, 1.3, 1.3, TEXT_COLOR)		
  end

  def draw_pause_screen
    @font.draw("PAUSED", 245, 220, 5, 2, 2, PAUSE_TEXT_COLOR)
    @font.draw("Press P to unpause", 200, 270, 5, 1.5, 1.5, PAUSE_TEXT_COLOR)
    @font.draw("Tip: Press 1 through 5 to dynamically change the difficulty", 80, 440, 5, 1, 1, PAUSE_TEXT_COLOR)
  end

  def draw_game_over_screen
    @background_image_black.draw(0, 0, 4)
    @font.draw("GAME OVER", 215, 220, 5, 2, 2, TEXT_COLOR)
    @font.draw("Press Enter to Play Again", 165, 270, 5, 1.5, 1.5, TEXT_COLOR)  
  end

  def draw
    @background_image.draw(0, 47, 0)
    @snake.update
    @snake.draw
    @apple.draw		
    draw_text
    draw_pause_screen if @paused and @snake.speed == 0
    draw_game_over_screen if @game_over

    case @level
      when 1 then @wall.draw_1
      when 2 then @wall.draw_2
    end		
  end

  def button_down(id)
    if @game_over
      if id == Gosu::KbEnter or id == Gosu::KbReturn
        reset_game
      end  
    else
      case id
        when Gosu::KbP
	  toggle_pause
	when Gosu::Kb1
	  @snake.speed = 4
	when Gosu::Kb2
	  @snake.speed = 6
	when Gosu::Kb3
	  @snake.speed = 8
	when Gosu::Kb4
	  @snake.speed = 10
	when Gosu::Kb5
	  @snake.speed = 12
	when Gosu::Kb9
	  @apples_to_collect += 10
	when Gosu::Kb0
	  next_level
      end
    end
    close if id == Gosu::KbEscape
  end
end

=begin
  def save_game
    save_snake
    save_apple
    save_paused
    save_level
    save_apples_to_collect
    save_score
  end

  def load_game
    load_snake
    load_apple
    load_paused
    load_level
    load_apples_to_collect
    load_score
  end


  def save_snake
    File.open( 'save/save_snake.yaml', 'w' ) { |out| YAML.dump(@snake, out) }
  end

  def save_apple
    File.open( 'save/save_apple.yaml', 'w' ) { |out| YAML.dump(@apple, out) }
  end

  def save_paused
    File.open( 'save/save_paused.yaml', 'w' ) { |out| YAML.dump(@paused, out) }
  end

  def save_level
    File.open( 'save/save_level.yaml', 'w' ) { |out| YAML.dump(@level, out) }
  end

  def save_apples_to_collect
    File.open( 'save/save_apples_to_collect.yaml', 'w' ) { |out| YAML.dump(@apples_to_collect, out) }
  end

  def save_score
    File.open( 'save/save_score.yaml', 'w' ) { |out| YAML.dump(@score, out) }
  end


  def load_snake
    File.open( 'save/save_snake.yaml' ) { |yf|	@snake = YAML::load(yf) }
  end

  def load_apple
    File.open( 'save/save_apple.yaml' ) { |yf|	@apple = YAML::load(yf) }
  end

  def load_paused
    File.open( 'save/save_paused.yaml' ) { |yf|	@paused = YAML::load(yf) }
  end

  def load_level
    File.open( 'save/save_level.yaml' ) { |yf|	@level = YAML::load(yf) }
  end

  def load_apples_to_collect
    File.open( 'save/save_apples_to_collect.yaml' ) { |yf|	@apples_to_collect = YAML::load(yf) }
  end

  def load_score
    File.open( 'save/save_score.yaml' ) { |yf|	@score = YAML::load(yf) }
  end
=end