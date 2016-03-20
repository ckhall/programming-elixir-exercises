defmodule Taxes do

  # tax_rates = [ NC: 0.075, TX: 0.08 ]
  #
  # orders - [
  #   id: 123, ship_to: :NC, net_amount: 100.00 ],
  #   ...
  # ]

  def calculate(tax_rates, orders) do
    Enum.map(orders, &(&1 |> apply_tax(tax_rates)))
  end

  def apply_tax(order, tax_rates) do
    [ id: _, ship_to: state, net_amount: net ] = order
    total = state |> tax_rate(tax_rates) |> calc_total(net)
    order ++ [ total_amount: total ]
  end

  def tax_rate(state, tax_rates) do
    Keyword.get(tax_rates, state, 0)
  end

  def calc_total(rate, net) do
    net * (1.0 + rate) |> Float.round(2)
  end
end
