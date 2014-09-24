defmodule PostalCodexServerTest do
  use ExUnit.Case, async: true

  @naerum 			%PostalCode{name: "Nærum", number: 2850}
  @malmoe 			%PostalCode{name: "Malmö", number: 21119}
  @denmark 			%{ 2850 =>  @naerum }
  @sweden 			%{ 21119 =>  @malmoe }
  @postal_codes %{ :dk => @denmark, :se => @sweden }

  setup do
    {:ok, postal_server} = PostalCodex.Server.start_link(@postal_codes)
    on_exit(fn -> send(postal_server, :stop) end)
    {:ok, postal_server: postal_server}
  end

  test "get_postal_code" do
		assert PostalCodex.Server.postal_code(:dk, 2850)  ==  @naerum
		assert PostalCodex.Server.postal_code(:se, 21119)  ==  @malmoe
  end

end
