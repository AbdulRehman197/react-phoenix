defmodule ReactPhoenix.Storage do
  alias :mnesia, as: Mnesia
  def add_todo(params) do
    Mnesia.create_schema([node()])
    Mnesia.start()
    #  Mnesia.create_table(Todo, [attributes: [:id, :todo_name],ram_copies: [Node.self()],disc_only_copies: [Node.self()]]) |> IO.inspect()
      case Mnesia.create_table(Todo, [attributes: [:id, :todo_name],disc_copies: [Node.self()]]) do
      {:aborted, {:already_exists, Todo}} ->
        Mnesia.dump_tables([Todo])
        Mnesia.wait_for_tables([Todo], 5000)
        case Mnesia.dirty_write({Todo,UUID.uuid4(),UUID.uuid4()}) do
          :ok ->  {:ok,"Data Saved Successfully!"}          
          _ ->  {:error,"Some Error Occurred!"}
        end
        {:atomic, :ok} ->
          case Mnesia.dirty_write({Todo,UUID.uuid4(),UUID.uuid4()}) do
            :ok ->
              {:ok,"Data Saved Successfully!"}
            _ ->
              {:error,"Some Error Occurred!"}
          end
      end
      add_todo(params)
  end
  def get_todo_list() do
    Mnesia.create_schema([node()])
    Mnesia.start()
    Mnesia.wait_for_tables([Todo], 200)
    # Mnesia.transaction(fn ->
    # Mnesia.select(Todo, [{{Todo, :"$1", :"$2"}, [], [:"$$"]}]) end)
    Mnesia.table_info(Todo,:size)
    # Mnesia.dirty_last(Todo)
  end
  def delete_todo(params) do
    Mnesia.dirty_delete(Todo,params["id"])
  end
  def find_record(params) do
    # Mnesia.start()
    # Mnesia.wait_for_tables([Todo], 5000)
    data_to_write = fn ->
      Mnesia.write({Person, 4, "Marge Simpson", "home maker"})
      Mnesia.write({Person, 5, "Hans Moleman", "unknown"})
      Mnesia.write({Person, 6, "Monty Burns", "Businessman"})
      Mnesia.write({Person, 7, "Waylon Smithers", "Executive assistant"})
      Mnesia.read({Todo, params["id"]})
    end
    Mnesia.transaction(data_to_write)
    # Mnesia.dirty_read({Todo, params["id"]})
  end
end
