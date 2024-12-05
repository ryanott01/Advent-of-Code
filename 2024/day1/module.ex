defmodule ColumnAnalyzer do
  def get_sorted_columns(input_string) do
    {list_a, list_b} = input_string
    |> String.trim()
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(fn line ->
      line
      |> String.split()
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
    |> Enum.reduce({[], []}, fn {left, right}, {left_acc, right_acc} ->
      {[left | left_acc], [right | right_acc]}
    end)

    %{
      sorted_a: Enum.sort(list_a),
      sorted_b: Enum.sort(list_b)
    }
  end

  def sum_differences(columns) do
    Enum.with_index(columns.sorted_a, fn x, index ->
      y = Enum.at(columns.sorted_b, index)
      abs(x - y)
    end)
    |> Enum.sum()
  end

  def count_matching_numbers(columns) do
    Enum.map(columns.sorted_a, fn x ->
      frequency = Enum.count(columns.sorted_b, fn y -> y == x end)
       x * frequency
    end)
    |> Enum.sum()
  end
end
