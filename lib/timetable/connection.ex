defmodule Timetable.Connection do
  use GenServer


  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end



  # Callbacks

  def init(:ok) do
    # Contrary to what the docs say, `Spell.connect` does not properly start
    # the Spell.Peer.Supervisor. Omitting `Peer.start_link` will cause
    # `connect` to exit with a "no process" error.
    Spell.Peer.start_link
    wamp_uri    = Application.get_env(:timetable, :wamp_uri)
    wamp_realm  = Application.get_env(:timetable, :wamp_realm)
    {:ok, connection} = Spell.connect(wamp_uri, realm: wamp_realm, roles: [Spell.Role.Callee])
    {:ok, _} = Spell.call_register(connection, "timetable.next_visits")
    {:ok, _} = Spell.call_register(connection, "timetable.last_visits")

    {:ok, connection}
  end


  def handle_info({Spell.Peer, _pid, %Spell.Message{args: [request, _rid, _msg, params], type: :invocation}}, conn) do
    Spell.cast_yield(conn, request, [arguments_kw: %{result: "I got it"}])
    {:noreply, conn}
  end

  def handle_info({Spell.Peer, _pid, %Spell.Message{args: [request, _rid, _msg], type: :invocation}}, conn) do
    Spell.cast_yield(conn, request, [])
  end
end
