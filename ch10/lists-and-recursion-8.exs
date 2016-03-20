defmodule Taxes do

  # tax_rates = [ NC: 0.075, TX: 0.08 ]
  #
  # orders - [
  #   id: 123, ship_to: :NC, net_amount: 100.00 ],
  #   ...
  # ]

  def calculate(tax_rates, orders) do
    IO.inspect Enum.map(orders, &(apply_tax(&1, tax_rates)))
  end

  def apply_tax(order, tax_rates) do
    [ id: _, ship_to: state, net_amount: net ] = order
    tax_rate = Keyword.get(tax_rates, state, 0)
    total = net |> calc_total(tax_rate)
    order ++ [ total_amount: total ]
  end

  def calc_total(net, rate) do
    net * (1.0 + rate) |> Float.round(2)
  end
end
