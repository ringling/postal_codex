defmodule PostalCode do
	defstruct name: nil, number: nil

	def find_postal_code(countries, country, postal_number) do
  	countries
  	|> get_postal_codes(country)
  	|> get_postal_code(postal_number)
  end

  defp get_postal_codes(nil, _country), do: nil
  defp get_postal_codes(countries, country) do
  	countries |> Map.get(country)
  end

  defp get_postal_code(nil, _postal_number), do: nil
  defp get_postal_code(postal_codes, postal_number) do
  	postal_codes |> Map.get(postal_number)
  end

end
