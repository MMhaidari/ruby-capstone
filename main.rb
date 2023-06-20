require_relative 'app'
require_relative 'options'
require_relative 'display_menu'

def main
  app = App.new

  loop do
    display_menu

    option = gets.chomp.to_i
    puts ''

    handle_option(option, app)

  end
end

main
