#require 'yaml'

require 'gosu'

require_relative 'lib/apple'
require_relative 'lib/segment'
require_relative 'lib/snake'
require_relative 'lib/wall'
require_relative 'lib/game'

window = GameWindow.new
window.show