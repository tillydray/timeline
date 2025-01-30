defmodule Timeline.Repo.Migrations.UpdateRequestedTable do
  use Ecto.Migration

  def change do
    alter table(:requests) do
      modify(:inserted_at, :utc_datetime)
    end
  end
end
