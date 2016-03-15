defmodule MyList do
  def mapsum([], _),      do: 0
  def mapsum([h | t], f), do: f.(h) + mapsum(t, f)
end
