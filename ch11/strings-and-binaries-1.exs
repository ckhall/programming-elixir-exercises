defmodule Ascii do
  def printable(str) do
    Enum.all(str, fn ch -> ch in ?\s..?~ end)
  end
end
