defmodule MyEnum do
  def all?(list), do: all?(l, fn x -> x end)
  def all?([], _), do: true
  def all?([head | tail], func) do
    if func.(head), do: all?(tail, func), else: false
  end

  def each([], _), do: []
  def each([head | tail], func) do
    [func.(head) | each(tail, func)]
  end

  def filter([], _), do: []
  def filter([head | tail], func) do
    if func.(head), do: [head | filter(tail, func)], else: [filter(tail, func)]
  end

  def split(list, size), do: _split(list, [], size)
  def _split([], acc, _), do: [Enum.reverse(acc), []]
  def _split(tail, acc, 0), do: [Enum.reverse(acc), tail]
  def _split([head, tail], acc, size), do: _split(tail, [head | acc], size-1)

  def take(list, size), do: hd(split(list, size))
end
