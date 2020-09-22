defmodule Pluggy.User do
  defstruct(id: nil, username: "")

  alias Pluggy.User

  def get(id) do
    Postgrex.query!(DB, "SELECT id, username FROM users WHERE id = $1 LIMIT 1", [id],
      pool: DBConnection.ConnectionPool
    ).rows
    |> to_struct
  end



  def create(conn) do
    teacher = conn.params["teacher"]
    class = conn.params["class"]

    Postgrex.query!(DB, "INSERT INTO teacher_table (teacher_name, classes) VALUES ($1, $2)", [teacher, class],
      pool: DBConnection.ConnectionPool
    )
  end

  def delete(id) do
    Postgrex.query!(DB, "DELETE FROM teacher_table WHERE teacher_id = $1", [String.to_integer(id)],
      pool: DBConnection.ConnectionPool
    )
  end

  def to_struct([[id, username]]) do
    %User{id: id, username: username}
  end
end
