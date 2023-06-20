def handle_option(option, app)
  option_actions = option_actions_hash

  action = option_actions[option]

  if action
    app.send(action)
  else
    puts 'Invalid option!'
  end
end

def option_actions_hash
  {
    1 => :list_all_books,
    2 => :list_all_labels,
    3 => :list_all_music_albums,
    4 => :list_all_genres,
    5 => :list_all_games,
    6 => :list_all_authors,
    7 => :list_all_movies,
    8 => :list_all_sources,
    9 => :add_new_book,
    10 => :add_new_music_album,
    11 => :add_new_game,
    12 => :add_new_movie,
    13 => :quit
  }
end
