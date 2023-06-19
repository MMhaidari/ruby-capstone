def handle_option(option, app)
  option_actions = {
    1 => :list_all_books,
    2 => :list_all_music_albums,
    3 => :list_all_games,
    4 => :list_all_movies,
    5 => :add_item,
    6 => :quit
  }

  action = option_actions[option]

  if action
    app.send(action)
  else
    puts 'Invalid option!'
  end
end
