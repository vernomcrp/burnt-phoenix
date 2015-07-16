defmodule FileUploader.ContactView do
  use FileUploader.Web, :view

  def render("index.json", %{contacts: contacts}) do
    contacts
  end

  def render("create.json", %{changeset: changeset}) do
    changeset
  end
end