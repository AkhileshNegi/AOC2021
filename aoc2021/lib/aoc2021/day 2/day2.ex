defmodule Aoc2021.Day2 do
  @moduledoc """
  The Advent of Code
  """

  @doc """
  Aoc2021.Day2.import_file("/Users/akhileshnegi/projects/AOC2021/aoc2021/lib/aoc2021/advent/aoc2.txt")
  """
  def import_file(path) do
    {:ok, file_input} = File.read(path)
    process_file(file_input)
  end

  defp process_file(file_input) do
    file_input
    |> String.replace("\uFEFF", "")
    |> String.split("\r\n", trim: true)
    |> Enum.reduce(%{horizontal: 0, vertical: 0, aim: 0}, fn direction, acc ->
      process_strings(direction, acc)
    end)
    |> process_final()
  end

  defp process_final(result) do
    result.horizontal * result.vertical
  end

  defp process_strings(direction, position) do
    forward(position, String.contains?(direction, "forward"), direction)
    |> down(String.contains?(direction, "down"), direction)
    |> up(String.contains?(direction, "up"), direction)
  end

  defp forward(position, true, direction) do
    %{horizontal: horizontal, vertical: vertical, aim: aim} = position
    {position, _horizontal} = String.replace(direction, "forward ", "") |> Integer.parse()
    new_vertical = aim * position
    %{horizontal: horizontal + position, vertical: vertical + new_vertical, aim: aim}
  end

  defp forward(position, false, _direction), do: position

  defp down(position, true, direction) do
    %{horizontal: horizontal, vertical: vertical, aim: aim} = position
    {position, _horizontal} = String.replace(direction, "down ", "") |> Integer.parse()
    new_aim = aim + position
    %{horizontal: horizontal, vertical: vertical, aim: new_aim}
  end

  defp down(position, false, _direction), do: position

  defp up(position, true, direction) do
    %{horizontal: horizontal, vertical: vertical, aim: aim} = position
    {position, _horizontal} = String.replace(direction, "up ", "") |> Integer.parse()
    %{horizontal: horizontal, vertical: vertical, aim: aim - position}
  end

  defp up(position, false, _direction), do: position
end
