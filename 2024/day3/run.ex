# run.ex
Code.require_file("module.ex")

defmodule Run do
  def main do
    # Read input from file
    input = File.read!("input.txt")

    # Define what functions we want to find
    function_names = ["mul", "add", "sub"]

    # Find all matching functions
    matches = FunctionFinder.find_functions(input, function_names)

    # Print each match on a new line
    IO.puts("Found functions:")
    Enum.each(matches, &IO.puts/1)

    # Process mul functions with conditions and print result
    result = FunctionFinder.process_muls_with_conditions(input)
    IO.puts("\nSum of all valid multiplication results: #{result}")
  end
end

# Run the program
Run.main()
