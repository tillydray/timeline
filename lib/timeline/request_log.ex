defmodule Timeline.RequestLog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "requests" do
    field(:endpoint, :string)
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:endpoint])
    |> validate_required([:endpoint])
  end
end
