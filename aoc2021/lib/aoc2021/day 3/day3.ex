defmodule Aoc2021.Day3 do
  @moduledoc """
  The Advent of Code
  """

  @doc """
  Aoc2021.Day3.import_file("/Users/akhileshnegi/projects/AOC2021/aoc2021/lib/aoc2021/day 3/day3.txt")
  2250414
  """
  def import_file(path) do
    {:ok, file_input} = File.read(path)
    process_file(file_input)
  end

  defp process_file(file_input) do
    init = 1..12 |> Enum.reduce(%{}, fn x, acc -> Map.put(acc, x, %{0 => 0, 1 => 0}) end)

    file_input
    |> String.split("\n", trim: true)
    |> Enum.reduce(init, fn bit, acc ->
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

  def mirror_bits(value) do
    bit_value =
      value
      |> String.replace("0", "2")
      |> String.replace("1", "0")
      |> String.replace("2", "1")
      |> String.to_integer(2)

    bit_value * String.to_integer(value, 2)
  end

  defp compute_gamma_rate(%{0 => zeros, 1 => ones}, acc) do
    new_bit = if zeros > ones, do: "0", else: "1"
    "#{acc}#{new_bit}"
  end

  defp process_bits(bit, bit_count) do
    0..11
    |> Enum.reduce(bit_count, fn count, acc ->
      result = update_bit_count(bit_count, String.at(bit, count), count + 1)
      Map.put(acc, count + 1, result[count + 1])
    end)
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
