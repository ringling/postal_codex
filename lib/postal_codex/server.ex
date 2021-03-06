defmodule PostalCodex.Server do
  use GenServer
  require Logger

  #####
  # External API

  def start_link(countries) do
    Logger.info "Starting postal server."
    GenServer.start_link(__MODULE__, countries, name: __MODULE__)
  end

  def init(countries) do
    Logger.info "Server started"
    {:ok, countries}
  end

  def crash do
    GenServer.call(__MODULE__, {:crash, " DO CRASH!!!"})
  end

  def postal_code(country, postal_number) do
    GenServer.call(__MODULE__, {:postal_code, country, postal_number}
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
