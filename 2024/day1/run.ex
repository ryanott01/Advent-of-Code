Code.require_file("module.ex")

{:ok, input} = File.read("input.txt")
cols = ColumnAnalyzer.get_sorted_columns(input)

IO.puts """
Sum of differences: #{ColumnAnalyzer.sum_differences(cols)}
Matching values: #{ColumnAnalyzer.count_matching_numbers(cols)}
"""
