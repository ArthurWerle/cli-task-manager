defmodule TaskManager.Task do
	defstruct [:id, :title, :description]
end

defmodule TaskManager.TaskManager do
  alias TaskManager.Task

  # Initial empty task list
  @tasks []

  # CRUD operations

  # List all tasks
  def list_tasks do
    @tasks
  end

  # Get a task by ID
  def get_task(id) do
    Enum.find(@tasks, &(&1.id == id))
  end

  # Create a new task
  def create_task(attrs) do
    task = %Task{id: generate_id(), title: attrs[:title], description: attrs[:description]}
    @tasks = [task | @tasks]
    task
  end

  # Update an existing task
  def update_task(id, attrs) do
    case get_task(id) do
      nil ->
        {:error, "Task not found"}
      task ->
        updated_task = %Task{id: task.id, title: attrs[:title], description: attrs[:description]}
        @tasks = Enum.map(@tasks, fn t -> if t.id == id, do: updated_task, else: t end)
        {:ok, updated_task}
    end
  end

  # Delete a task by ID
  def delete_task(id) do
    case get_task(id) do
      nil ->
        {:error, "Task not found"}
      task ->
        @tasks = Enum.reject(@tasks, &(&1.id == id))
        {:ok, task}
    end
  end

  # Internal function to generate unique task IDs
  defp generate_id do
    length(@tasks) + 1
  end
end

