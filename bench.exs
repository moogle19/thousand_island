defmodule Bench do
  def run do
    # Warmup
    1..10_000 |> Enum.each(fn _ -> nil end)

    sockets_count = 100
    list_sockets = Enum.map(1..sockets_count, fn id -> {id, "socket_#{id}"} end)
    tuple_sockets = list_sockets |> Enum.map(fn {_, s} -> s end) |> List.to_tuple()

    iters = 1_000_000

    # Old O(N) approach
    {time_old, _} = :timer.tc(fn ->
      Enum.each(1..iters, fn i ->
        acceptor_id = i
        num_listen_sockets = length(list_sockets)
        socket_id = rem(acceptor_id - 1, num_listen_sockets) + 1
        {^socket_id, _listener_socket} = List.keyfind(list_sockets, socket_id, 0)
      end)
    end)

    # New O(1) approach
    {time_new, _} = :timer.tc(fn ->
      Enum.each(1..iters, fn i ->
        acceptor_id = i
        num_listen_sockets = sockets_count
        socket_index = rem(acceptor_id - 1, num_listen_sockets)
        _listener_socket = elem(tuple_sockets, socket_index)
      end)
    end)

    IO.puts("Old O(N) approach: #{time_old / 1000} ms")
    IO.puts("New O(1) approach: #{time_new / 1000} ms")
    IO.puts("Improvement: #{Float.round((time_old - time_new) / time_old * 100, 2)}% faster")
  end
end

Bench.run()
