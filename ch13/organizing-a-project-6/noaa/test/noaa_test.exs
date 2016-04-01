defmodule NoaaTest do
  use ExUnit.Case
  doctest Noaa
  import Noaa, only: [ fetch: 1 ]
  
  test "given a 200 response the body is returned" do
    xml_doc = "<?xml version=\"1.0\" encoding=\"UTF-8\"<foo>bar</foo>"
    mock_response = { :ok, %{ status_code: 200, body: xml_doc } }
    :meck.expect(HTTPoison, :get, fn("http://w1.weather.gov/xml/current_obs/ABCD.xml") ->
      mock_response
    end)
    assert fetch("ABCD") == { :ok, xml_doc }
  end
  
  test "given a 404 response, an error message is returned" do
    mock_response = { :whocares, %{ status_code: 404, body: "whocares" } }
    :meck.expect(HTTPoison, :get, fn("http://w1.weather.gov/xml/current_obs/ABCD.xml") ->
      mock_response
    end)
    assert fetch("ABCD") == { :error, "Station ABCD not found" }
  end

  test "given any other response, an error message containing the status is returned" do
    mock_response = { :whocares, %{ status_code: 500, body: "whocares" } }
    :meck.expect(HTTPoison, :get, fn("http://w1.weather.gov/xml/current_obs/ABCD.xml") ->
      mock_response
    end)
    assert fetch("ABCD") == { :error, "500" }
  end
end
