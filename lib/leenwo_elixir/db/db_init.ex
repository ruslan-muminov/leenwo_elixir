defmodule LeenwoElixir.DbInit do
  alias :mnesia, as: Mnesia

  def create_schema() do
    Mnesia.create_schema([node()])
  end

  def create_table(:user) do
    Mnesia.create_table(User, [attributes: [:chat_id, :name, :username]])
  end

  def init_and_start do
    Mnesia.stop()
    create_schema()
    Mnesia.start()
    create_table(:user)
  end
end