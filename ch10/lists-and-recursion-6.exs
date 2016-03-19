defmodule MyEnum do
  def flatten(list), do: _flatten(list, [])
  def _flatten([h | t], tail) when is_list(h), do: _flatten(h, _flatten(t, tail))
  def _flatten([h | t], tail), do: [h | _flatten(t, tail)]
  def _flatten([], tail), do: tail
end
