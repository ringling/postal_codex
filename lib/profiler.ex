defmodule Profiler do
  def run(module, operations_count, concurrency_level \\ 1) do
    module.start_link(%{dk: %{2850 => "Nærum"}})

    time = execution_time(
      fn -> module.postal_code(:dk, 2850) end,
      operations_count,
      concurrency_level
    )

    projected_rate = round((operations_count*concurrency_level) / (time / 1000))
    IO.puts "#{projected_rate} reqs/sec\n"
  end

  defp execution_time(fun, operations_count, concurrency_level) do
    {time, _} = :timer.tc(fn ->
      me = self

      for _ <- 1..concurrency_level do
        spawn(fn ->
          for _ <- 1..operations_count, do: fun.()
          send(me, :computed)
        end)
      end

      for _ <- 1..concurrency_level do
        receive do
          :computed -> :ok
        end
      end
    end)

    time / 1000
  end
end
