defmodule LeenwoElixir.CommandHandler do
  
  def handle_command("start", _tail, chat_id, conn) do
    Nadia.send_message(chat_id, "Startanul - molodec")
    LeenwoElixir.Endpoint.call_send_resp(conn)
  end

  def handle_command("help", _tail, chat_id, conn) do
    Nadia.send_message(chat_id, "Nikto tebe ne pomozhet")
    LeenwoElixir.Endpoint.call_send_resp(conn)
  end

  def handle_command(command, _tail, _chat_id, _conn) do
    {:error, "Undefined command: #{command}"}
  end
end