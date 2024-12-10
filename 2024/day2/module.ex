defmodule DataAnalysis do
  defmodule PreProcessing do
    def format_raw_data(input) do
      input
      |> split_into_rows()
      |> convert_rows_to_integers()
    end

    defp split_into_rows(input) do
      input
      |> String.split("\n", trim: true)
    end

    defp convert_row_to_integers(row) do
      row
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end

    defp convert_rows_to_integers(rows) do
      rows
      |> Enum.map(&convert_row_to_integers/1)
    end
  end

  defmodule Processing do
    def analyze_row_safety(input) do
      input
      |> Enum.map(&check_row_safety/1)
    end

    def count_safe_rows(input) do
      input
      |> analyze_row_safety()
      |> Enum.count(fn {_row, safety} -> safety == :safe end)
    end

    def check_row_safety(row) do
      case {sequence_consistent?(row), steps_valid?(row)} do
        {true, true} -> {row, :safe}
        _ -> check_row_with_removals(row)
      end
    end

    defp check_row_with_removals(row) do
      variations = for i <- 0..(length(row) - 1) do
        List.delete_at(row, i)
      end

      case Enum.any?(variations, fn variation ->
        sequence_consistent?(variation) && steps_valid?(variation)
      end) do
        true -> {row, :safe}
        false -> {row, :unsafe}
      end
    end

    defp sequence_consistent?(row) do
      increasing = Enum.chunk_every(row, 2, 1, :discard)
                  |> Enum.all?(fn [a, b] -> b > a end)

      decreasing = Enum.chunk_every(row, 2, 1, :discard)
                  |> Enum.all?(fn [a, b] -> b < a end)

      increasing || decreasing
    end

    defp steps_valid?(row) do
      Enum.chunk_every(row, 2, 1, :discard)
      |> Enum.all?(fn [a, b] -> abs(b - a) <= 3 end)
    end
  end
 end
