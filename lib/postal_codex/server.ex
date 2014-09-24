defmodule PostalCodex.Server do
	use GenServer
	require Logger

	#####
  # External API

  def start do
    GenServer.start(__MODULE__, %{})
  end

  def start(countries) do
    GenServer.start(__MODULE__, countries)
  end

  def init(countries) do
  	Logger.info "init: Postal codes for #{length(Map.values(countries))} countries"
    {:ok, countries}
  end

  def postal_code(postal_code_server, country, postal_number) do
  	GenServer.call(
  		postal_code_server,
  		{:postal_code, country, postal_number}
  	)
  end

  #####
  # GenServer implementationmt
  def handle_call({:postal_code, country, postal_number}, _from, countries) do
  	postal_code = PostalCode.find_postal_code(countries, country, postal_number)
    { :reply, postal_code, countries }
  end

  # Needed for testing purposes
  def handle_info(:stop, countries), do: {:stop, :normal, countries}
  def handle_info(_, state), do: {:noreply, state}

end
