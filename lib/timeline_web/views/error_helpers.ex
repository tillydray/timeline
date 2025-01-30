defmodule TimelineWeb.ErrorHelpers do
  use Phoenix.HTML

  # Example translation method
  def translate_error({msg, _opts}) do
    msg
  end

  # Example helper for printing an error tag
  def error_tag(form, field) do
    Enum.map(Keyword.get_values(form.errors, field), fn error ->
      content_tag(:span, translate_error(error), class: "error")
    end)
  end
end
