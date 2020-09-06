defmodule LeenwoElixir.Endpoint do
  use Plug.Router

  require Logger

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(:dispatch)

  get "/ping" do
    send_resp(conn, 200, "pong!")
  end

  # "ZDAROVA" bot
  post "/leenwo" do
    # %{"message" => %{"chat" => %{"id" => chat_id}}}= conn.body_params
    # Nadia.send_message(chat_id, "ZDAROVA1")
    # send_resp(conn, 200, "")

    %{"message" => %{"chat" => %{"id" => chat_id}, "text" => text}}= conn.body_params
    Logger.info("text = #{text}")
    case String.split(text, ["/", " "], parts: 3) do
      ["", command] -> LeenwoElixir.CommandHandler.handle_command(command, "", chat_id, conn)
      ["", command, tail] -> LeenwoElixir.CommandHandler.handle_command(command, tail, chat_id, conn)
      _ ->
        Nadia.send_message(chat_id, "ZDAROVA1")
        send_resp(conn, 200, "")
    end

  end

  post "/events" do
    {status, body} = case conn.body_params do
                       %{"events" => events} -> {200, process_events(events)}
                       _ -> {422, missing_events()}
                     end
    send_resp(conn, status, body)
  end

  defp process_events(events) when is_list(events) do
    ##
    Poison.encode!(%{response: "Received Events!"})
  end
  defp process_events(_) do
    Poison.encode!(%{response: "Please Send Some Events!"})
  end

  defp missing_events do
    Poison.encode!(%{error: "Expected Payload: { 'events': [...] }"})
  end

  match _ do
    send_resp(conn, 404, "ooops... Nothing there :(")
  end

  def call_send_resp(conn) do
    send_resp(conn, 200, "")
  end

end
