defmodule Calibration do
  def get_calibration(line) do
    # "two1nine" -> "219" -> 29
    # "eightwothree" -> "823" -> 83
    # "abcone2threexyz" -> "123" - > 13
    # "xtwone3four" -> "2134" -> 24
    # "4nineeightseven2" -> "49872" -> 42
    # "zoneight234" -> "18234" -> 14
    # "7pqrstsixteen" -> "76" -> 76

    number_words = %{
      :one => 1,
      :two => 2,
      :three => 3,
      :four => 4,
      :five => 5,
      :six => 6,
      :seven => 7,
      :eight => 8,
      :nine => 9
    }

    # need to match the number word in the line and then call this function recursively with the rest of the line

    matches = []

    length = String.length(line)
    range = 3..length

    Enum.map(number_words, fn number_word ->
      # IO.inspect(number_word, label: "number_word")
      {word, number} = number_word
      # IO.inspect(word, label: "word")
      # IO.inspect(number, label: "number")

      for index <- range do
        # IO.inspect(index, label: "index")

        substring = String.slice(line, 0, index)

        if(String.match?(String.last(substring), ~r/\d/)) do
          IO.puts("matched a digit, resetting range")
          range = index..length
        end

        if(String.contains?(substring, Atom.to_string(word))) do
          IO.puts("matched on substring:#{substring} with word:#{word}")
        end
      end
    end)

    # first = List.first(matches)
    # last = List.last(matches)

    # String.to_integer("#{first}#{last}")
  end
end

input = """
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
"""

inputs = String.split(input)
calibration = Calibration.get_calibration(Enum.at(inputs, 0))
# calibrations = Enum.into(inputs, [], fn input -> Calibration.get_calibration(input) end)
IO.inspect(calibration)
# IO.puts("Calibration #{Enum.reduce(calibrations, 0, fn x, acc -> x + acc end)}")
