defmodule MyList do
  def caesar([], _), do: []
  def caesar([head | tail], n) when head + n <= ?z, do: [ head+n | caesar(tail, n) ]
  def caesar([head | tail], n), do: [ head+n-26 | caesar(tail, n) ]
end
