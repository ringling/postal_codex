defmodule PostalCodex.Supervisor do
	use Supervisor

	def start_link(countries) do
		Supervisor.start_link(__MODULE__, countries)
	end

	def init(countries) do
		processes = [worker(PostalCodex.Server, [countries])]
		supervise(processes, strategy: :one_for_one)
	end

end
