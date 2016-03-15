defmodule MyList do
  def caesar([], _),
    do: []

  def caesar([h | t], n)
    when h + n <= ?z,
    do: [ h+n | caesar(t, n) ]

  # wrap around
  def caesar([h | t], n),
    do: [ h+n-26 | caesar(t, n) ]
end
