defmodule Timeline.SecretReader do
  def read_password do
    System.cmd("op", ["read", "op://Jason/db/password"], into: "")
    |> elem(0)
    |> String.trim()
  end
end
