defmodule TaskManager.CLI do
  import IO

  def run do
    loop([])
  end

  defp loop(tasks) do
    print_menu()
    input = String.trim(IO.gets(">> "))
    handle_input(input, tasks)
  end

  defp print_menu do
    """
    Task Manager Menu:
    1. List tasks
    2. Add task
    3. Edit task
    4. Delete task
    5. Exit
    """
    |> IO.puts()
  end

  defp handle_input("1", tasks) do
    IO.puts("List of tasks:")
    Enum.each(tasks, &IO.inspect(&1))
    loop(tasks)
  end

  defp handle_input("2", tasks) do
    IO.puts("Enter task title:")
    title = String.trim(IO.gets(""))
    IO.puts("Enter task description:")
    description = String.trim(IO.gets(""))
    new_task = %TaskManager.Task{id: length(tasks) + 1, title: title, description: description}
    loop([new_task | tasks])
  end

  defp handle_input("3", tasks) do
    IO.puts("Enter task ID to edit:")
    id = String.trim(IO.gets(""))
    case Enum.find_index(tasks, &(&1.id == String.to_integer(id))) do
      nil ->
        IO.puts("Task not found.")
        loop(tasks)
      index ->
        IO.puts("Enter new title for the task:")
        new_title = String.trim(IO.gets(""))
        IO.puts("Enter new description for the task:")
        new_description = String.trim(IO.gets(""))
        updated_task = %TaskManager.Task{id: tasks[index].id, title: new_title, description: new_description}
        updated_tasks = List.replace_at(tasks, index, updated_task)
        loop(updated_tasks)
    end
  end

  defp handle_input("4", tasks) do
    IO.puts("Enter task ID to delete:")
    id = String.trim(IO.gets(""))
    case Enum.find_index(tasks, &(&1.id == String.to_integer(id))) do
      nil ->
        IO.puts("Task not found.")
        loop(tasks)
      index ->
        updated_tasks = List.delete_at(tasks, index)
        IO.puts("Task deleted.")
        loop(updated_tasks)
    end
  end

  defp handle_input("5", _) do
    IO.puts("Exiting Task Manager. Goodbye!")
  end

  defp handle_input(_, tasks) do
    IO.puts("Invalid command.")
    loop(tasks)
  end
end

