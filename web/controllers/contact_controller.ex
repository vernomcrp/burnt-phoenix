defmodule FileUploader.ContactController do
  use FileUploader.Web, :controller
  # alias FileUploader.Repo
  alias FileUploader.Contact

  # plug :scrub_params, "contact" when action in [:create, :update]

  def index(conn, _params) do
    contacts = Repo.all(Contact)
    render conn, contacts: contacts
  end

  def create(conn, post_params) do
    changeset = Contact.changeset(%Contact{}, post_params)

    IO.inspect changeset

    if changeset.valid? do
      # render(conn, "new.html", changeset: changeset)
      new_contact = Repo.insert changeset
      render conn, changeset: new_contact
    end
  end
end
