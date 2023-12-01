defmodule Calibration do
  def get_calibration(line) do
    first = String.replace(line, ~r/\D/, "") |> String.first()
    last = String.replace(line, ~r/\D/, "") |> String.last()
    String.to_integer("#{first}#{last}")
  end
end

input = """
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
"""

inputs = String.split(input)
calibrations = Enum.into(inputs, [], fn input -> Calibration.get_calibration(input) end)
IO.inspect(calibrations)
IO.puts("Calibration #{Enum.reduce(calibrations, 0, fn x, acc -> x + acc end)}")
