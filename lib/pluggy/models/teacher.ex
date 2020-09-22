defmodule Pluggy.Teacher do
  defstruct(teacher_id: nil, teacher_name: "", classes: "")

  alias Pluggy.Teacher

  def all do
    Postgrex.query!(DB, "SELECT * FROM teacher_table", [], pool: DBConnection.ConnectionPool).rows
    |> to_struct_list
  end

  def get(id) do
    IO.inspect(id)
    Postgrex.query!(DB, "SELECT * FROM teacher_table WHERE teacher_id = $1 LIMIT 1", [String.to_integer(id)],
      pool: DBConnection.ConnectionPool
    ).rows
    |> to_struct
  end

  def update(id, params) do
    name = params[""]
    id = String.to_integer(id)

    Postgrex.query!(
      DB,
      "UPDATE teacher_table SET  teacher_name = $1 WHERE id = $3",
      [name, id],
      pool: DBConnection.ConnectionPool
    )
  end

  def create(params) do
    name = params["teacher_name"]

    Postgrex.query!(DB, "INSERT INTO teacher_table (teacher_name) VALUES ($1)", [name],
      pool: DBConnection.ConnectionPool
    )
  end

  def delete(id) do
    Postgrex.query!(DB, "DELETE FROM teacher_table WHERE teacher_id = $1", [String.to_integer(id)],
      pool: DBConnection.ConnectionPool
    )
  end

  def to_struct([[id, name, classes]]) do
    %Teacher{teacher_id: id,  teacher_name: name, classes: classes}
  end

  def to_struct_list(rows) do
    for [teacher_id, teacher_name, classes] <- rows, do: %Teacher{teacher_id: teacher_id, teacher_name: teacher_name, classes: classes}
  end
end
