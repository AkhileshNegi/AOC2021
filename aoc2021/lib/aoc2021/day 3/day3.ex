defmodule Aoc2021.Day3 do
  @moduledoc """
  The Advent of Code
  """

  @doc """
  Aoc2021.Day3.import_file("/Users/akhileshnegi/projects/AOC2021/aoc2021/lib/aoc2021/day 3/day3.txt")
  """
  def import_file(path) do
    {:ok, file_input} = File.read(path)
    process_file(file_input)
  end

  @init %{
    1 => %{0 => 0, 1 => 0},
    2 => %{0 => 0, 1 => 0},
    3 => %{0 => 0, 1 => 0},
    4 => %{0 => 0, 1 => 0},
    5 => %{0 => 0, 1 => 0},
    6 => %{0 => 0, 1 => 0},
    7 => %{0 => 0, 1 => 0},
    8 => %{0 => 0, 1 => 0},
    9 => %{0 => 0, 1 => 0},
    10 => %{0 => 0, 1 => 0},
    11 => %{0 => 0, 1 => 0},
    12 => %{0 => 0, 1 => 0}
  }
  defp process_file(file_input) do
    file_input
    |> String.split("\n", trim: true)
    |> Enum.reduce(@init, fn bit, acc ->
      process_bits(bit, acc)
    end)
    |> process_gamma_rate()
  end

  defp process_gamma_rate(result) do
    1..12
    |> Enum.reduce("", fn key, acc ->
      result
      |> Map.get(key)
      |> compute_gamma_rate(acc)
    end)
    |> mirror_bits()
  end

  defp mirror_bits(value) do
    bit_value =
      0..11
      |> Enum.reduce("", fn key, acc ->
        mirror_value = if String.at(value, key) == "0", do: "1", else: "0"
        "#{acc}#{mirror_value}"
      end)
      |> String.to_integer(2)

    bit_value * String.to_integer(value, 2)
  end

  defp compute_gamma_rate(%{0 => zeros, 1 => ones}, acc) do
    new_bit = if zeros > ones, do: "0", else: "1"
    "#{acc}#{new_bit}"
  end

  defp process_bits(bit, bit_count) do
    update_bit_count(bit_count, String.at(bit, 0), 1)
    |> update_bit_count(String.at(bit, 1), 2)
    |> update_bit_count(String.at(bit, 2), 3)
    |> update_bit_count(String.at(bit, 3), 4)
    |> update_bit_count(String.at(bit, 4), 5)
    |> update_bit_count(String.at(bit, 5), 6)
    |> update_bit_count(String.at(bit, 6), 7)
    |> update_bit_count(String.at(bit, 7), 8)
    |> update_bit_count(String.at(bit, 8), 9)
    |> update_bit_count(String.at(bit, 9), 10)
    |> update_bit_count(String.at(bit, 10), 11)
    |> update_bit_count(String.at(bit, 11), 12)
  end

  defp update_bit_count(bit_count, value, key) when value == "0" do
    %{0 => zeros, 1 => ones} = Map.get(bit_count, key)
    Map.put(bit_count, key, %{0 => zeros + 1, 1 => ones})
  end

  defp update_bit_count(bit_count, value, key) when value == "1" do
    %{0 => zeros, 1 => ones} = Map.get(bit_count, key)
    Map.put(bit_count, key, %{0 => zeros, 1 => ones + 1})
  end
end
