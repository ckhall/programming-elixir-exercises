defmodule Parser do
  def calculate(chars) do
    str = List.to_string(chars)
    regex = ~r{(\d+)\s*(\+|\-|\*|\/)\s*(\d+)}
    [_, left, oper, right] = Regex.run(regex, str)
    [left, right]
      |> Enum.map(&String.to_integer/1)
      |> evaluate(oper)
  end

  defp evaluate([n1, n2], "+"), do: n1 + n2
  defp evaluate([n1, n2], "-"), do: n1 - n2
  defp evaluate([n1, n2], "*"), do: n1 * n2
  defp evaluate([n1, n2], "/"), do: n1 / n2
end
