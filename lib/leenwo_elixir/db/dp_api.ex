defmodule LeenwoElixir.DbApi do
  alias :mnesia, as: Mnesia

  def is_user_in_db(chat_id) do
    case Mnesia.dirty_read({:user, chat_id}) do
      [] -> :false
      _ -> :true
    end
  end

  def add_user(chat_id, name, username) do
    Mnesia.dirty_write({:user, chat_id, name, username})
  end
end