defmodule NoaaTest do
  use ExUnit.Case
  doctest Noaa

  test "noaa_url returns the correct url" do
    assert Noaa.to_url("ABCD") == "http://w1.weather.gov/xml/current_obs/ABCD.xml"
  end
end
