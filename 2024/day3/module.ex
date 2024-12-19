# module.ex
defmodule FunctionFinder do
  def find_functions(input, function_names) do
    # Create regex pattern from list of function names
    names_pattern = function_names |> Enum.join("|")
    regex = ~r/(?:#{names_pattern})\((\d+),(\d+)\)/

    # Find all matches and return the full matches (entire function calls)
    Regex.scan(regex, input)
    |> Enum.map(fn [full_match | _] -> full_match end)
  end

  def process_muls_with_conditions(input) do
    # Split input into segments based on do() and don't() instructions
    segments = Regex.split(~r/(?:do|don't)\(\)/, input)
    control_states = extract_control_states(input)

    # Combine segments with their control states and process
    Enum.zip(segments, control_states)
    |> Enum.map(fn {segment, enabled?} ->
      if enabled? do
        process_segment(segment)
      else
        0
      end
    end)
    |> Enum.sum()
  end

  defp extract_control_states(input) do
    # Find all control instructions
    controls = Regex.scan(~r/(?:do|don't)\(\)/, input)
    |> Enum.map(fn [match] -> match end)

    # Convert to list of boolean states (true for enabled, false for disabled)
    initial_state = [true]  # mul is enabled at start
    controls
    |> Enum.reduce(initial_state, fn control, states ->
      new_state = case control do
        "do()" -> true
        "don't()" -> false
      end
      [new_state | states]
    end)
    |> Enum.reverse()
  end

  defp process_segment(segment) do
    # Process mul functions in a segment
    regex = ~r/mul\((\d+),(\d+)\)/

    Regex.scan(regex, segment)
    |> Enum.map(fn [_full_match, num1, num2] ->
      String.to_integer(num1) * String.to_integer(num2)
    end)
    |> Enum.sum()
  end
end
