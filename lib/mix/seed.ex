defmodule Mix.Tasks.Seed do
  use Mix.Task

  @shortdoc "Resets & seeds the DB."
  def run(_) do
    Mix.Task.run "app.start"
    drop_tables()
    create_tables()
    seed_data()
  end

  defp drop_tables() do
    IO.puts("Dropping tables")
    Postgrex.query!(DB, "DROP TABLE IF EXISTS fruits", [], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "DROP TABLE IF EXISTS users", [], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "DROP TABLE IF EXISTS schools", [], pool: DBConnection.ConnectionPool) #DENNA ÄR TILLFÄLLIG FÖR ATT SLIPA DUPLICATION FEL MEDDELANDE
    Postgrex.query!(DB, "DROP TABLE IF EXISTS students", [], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "DROP TABLE IF EXISTS teacher_table", [], pool: DBConnection.ConnectionPool)
  end

  defp create_tables() do
    IO.puts("Creating tables")
    #För skolor
    Postgrex.query!(DB, "Create TABLE schools (id SERIAL, name TEXT NOT NULL UNIQUE)", [], pool: DBConnection.ConnectionPool)

    #För Lärare
    Postgrex.query!(DB, "Create TABLE teacher_table (teacher_id SERIAL, teacher_name TEXT NOT NULL, classes TEXT UNIQUE)", [], pool: DBConnection.ConnectionPool)


    Postgrex.query!(DB, "Create TABLE students (id SERIAL, student_name TEXT NOT NULL, group_id TEXT)", [], pool: DBConnection.ConnectionPool)

    #För användare (lärare/admin)
    Postgrex.query!(DB, "Create TABLE users (id SERIAL, username TEXT NOT NULL UNIQUE, password TEXT NOT NULL, status INTEGER)", [], pool: DBConnection.ConnectionPool)

  end

  defp seed_data() do
    IO.puts("Seeding data")
    Postgrex.query!(DB, "INSERT INTO schools(name) VALUES($1)", ["ITG"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO schools(name) VALUES($1)", ["NTI"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO schools(name) VALUES($1)", ["GTG"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO schools(name) VALUES($1)", ["MTG"], pool: DBConnection.ConnectionPool)

    Postgrex.query!(DB, "INSERT INTO teacher_table(teacher_name, classes) VALUES($1, $2)", ["NILS","1c"], pool: DBConnection.ConnectionPool)

    Postgrex.query!(DB, "INSERT INTO students(student_name) VALUES($1)", ["Dree"], pool: DBConnection.ConnectionPool)
  end

end
