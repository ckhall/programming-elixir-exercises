defmodule Primes do
  def span(from, to) when from > to, do: []
  def span(from, to), do: [from | span(from+1, to)]

  def to(n) do
    range = span(2, n)
    products = products_for(range)
    diff(range, products)
  end

  def products_for(range) do
    for x <- range, y <- range, x >= y, x*y <= Enum.max(range), do: x*y
  end

  def diff(range, products) do
    range -- products
  end
end
