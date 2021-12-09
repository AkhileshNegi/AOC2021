defmodule Aoc2021.Day3P2 do
  @moduledoc """
  The Advent of Code
    Aoc2021.Day3P2.import_file("/Users/akhileshnegi/projects/AOC2021/aoc2021/lib/aoc2021/day 3/day3.txt")
  Final Answers:
    011110001111 -  1935
    110001001001 - 3145
    1935 * 3145 = 6085575
  """
  def import_file(path) do
    {:ok, file_input} = File.read(path)
    process_file(file_input)
  end

  defp process_file(file_input) do
    input = String.split(file_input, "\n", trim: true)
    o2_rating = Enum.reduce(0..11, input, &process_bits(&2, &1, :o2)) |> List.first()
    co2_rating = Enum.reduce(0..11, input, &process_bits(&2, &1, :co2)) |> List.first()
    String.to_integer(o2_rating, 2) * String.to_integer(co2_rating, 2)
  end

  defp process_bits(input, _position, _type) when length(input) == 1, do: input

  defp process_bits(input, position, :o2) do
    %{0 => count_zero, 1 => count_one} =
      Enum.reduce(input, %{0 => 0, 1 => 0}, &update_bit_count(&2, String.at(&1, position)))

    if count_one >= count_zero,
      do: input |> Enum.filter(&(String.at(&1, position) == "1")),
      else: input |> Enum.filter(&(String.at(&1, position) == "0"))
  end

  defp process_bits(input, position, :co2) do
    %{0 => count_zero, 1 => count_one} =
      Enum.reduce(input, %{0 => 0, 1 => 0}, &update_bit_count(&2, String.at(&1, position)))

    if count_zero <= count_one,
      do: input |> Enum.filter(&(String.at(&1, position) == "0")),
      else: input |> Enum.filter(&(String.at(&1, position) == "1"))
  end

  defp update_bit_count(%{0 => zeros, 1 => ones}, value) when value == "0",
    do: %{0 => zeros + 1, 1 => ones}

  defp update_bit_count(%{0 => zeros, 1 => ones}, value) when value == "1",
    do: %{0 => zeros, 1 => ones + 1}
end
