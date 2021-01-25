defmodule ReactPhoenixWeb.PageController do
  use ReactPhoenixWeb, :controller
  alias ReactPhoenix.Storage
  def index(conn, _params) do
    render(conn, "index.html")
  end

  def add_todo(conn, params) do
    case Storage.add_todo(params) do
      {:ok,msg} ->
        json(conn, %{msg: msg})
      {:error,msg} ->
        json(conn, %{msg: msg})
    end
  end
  def get_todos(conn,params) do
    case Storage.get_todo_list() do
      list ->
        json(conn, %{list: list})
      _ ->
        json(conn, %{msg: "Some Error Occurred!"})
    end
  end
  def delete_todo(conn,params) do
    case Storage.delete_todo(params) do
      :ok ->
        json(conn, %{msg: "Record Deleted Successfully!"})
      _ ->
        json(conn, %{msg: "Some Error Occurred!"})
    end
  end
  def find_record(conn,params) do
    case Storage.find_record(params) do
      {:atomic, [{_, key, value}]} ->
        json(conn, %{id: key,value: value})
      {:atomic, []} ->
        json(conn, %{msg: "Record Not Found!"})
      _ ->
        json(conn, %{msg: "Some Error Occurred!"})
    end
  end
end
