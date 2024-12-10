Code.require_file("module.ex")

case File.read("input.txt") do
  {:ok, content} ->
    content
    |> DataAnalysis.PreProcessing.format_raw_data()
    |> DataAnalysis.Processing.count_safe_rows()
    |> IO.puts()

  {:error, reason} ->
    IO.puts("Error reading file: #{reason}")
end
