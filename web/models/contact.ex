defmodule FileUploader.Contact do
  use FileUploader.Web, :model

  schema "contacts" do
    field :name, :string
    field :phone, :string

    timestamps
  end

  @required_fields ~w(name phone)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
