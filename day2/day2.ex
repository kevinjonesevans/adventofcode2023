# input = """
# Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
# Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
# Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
# Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
# Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
# """

{:ok, input} = File.read("input")

games =
  String.split(input, "\n")
  |> Enum.drop(-1)
  # throw away the Game bit at the beginning as the ID is just the index, for now
  |> Enum.map(fn line -> Enum.at(String.split(line, ":"), 1) end)
  |> Enum.map(fn line -> String.split(line, ";") end)

formatted_games =
  Enum.with_index(
    Enum.map(games, fn game ->
      Enum.map(game, fn session ->
        String.split(session, ",")
        |> Enum.reduce([], fn bag, acc ->
          value =
            String.replace(bag, ~r/^\s+/, "")
            |> String.split(" ")
            |> Enum.reverse()

          Keyword.put(
            acc,
            String.to_atom(Enum.at(value, 0)),
            String.to_integer(Enum.at(value, 1))
          )
        end)
      end)
    end)
  )

IO.inspect(formatted_games, label: "formatted_games")

possible_games =
  Enum.filter(formatted_games, fn {game, _index} ->
    Enum.all?(game, fn session ->
      red = Keyword.get(session, :red) || 0
      green = Keyword.get(session, :green) || 0
      blue = Keyword.get(session, :blue) || 0
      red <= 12 && green <= 13 && blue <= 14
    end)
  end)

IO.inspect(possible_games, label: "possible_games")

total =
  Enum.reduce(possible_games, 0, fn game, acc ->
    # IO.inspect(game)
    # IO.inspect(acc)
    elem(game, 1) + 1 + acc
  end)

IO.inspect(total, label: "Total")
