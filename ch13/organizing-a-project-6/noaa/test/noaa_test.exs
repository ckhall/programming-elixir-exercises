defmodule NoaaTest do
  use ExUnit.Case
  doctest Noaa

  test "noaa_url returns the correct url" do
    assert Noaa.to_url("ABCD") == "http://w1.weather.gov/xml/current_obs/ABCD.xml"
  end
  
  test "column_from_xml returns the text of the given element name" do
    assert Noaa.column_from_xml("<foo>bar</foo>", "foo") == "bar"
  end
  
  test "column_from_xml returns nil if given element name does not exist" do
    assert Noaa.column_from_xml("<foo>bar</foo>", "bar") == nil
  end
end
