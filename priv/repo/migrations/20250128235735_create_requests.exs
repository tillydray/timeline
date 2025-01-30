defmodule Timeline.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :endpoint, :string
      timestamps()
    end
  end
end
