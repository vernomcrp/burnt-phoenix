defmodule FileUploader.UserController do
  use FileUploader.Web, :controller

  alias FileUploader.Avatar
  alias FileUploader.User
  

  plug :scrub_params, "user" when action in [:create, :update]

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do

    # Start debug
#    IO.inspect user_params
#    tmp_photo = user_params["photo"]
#    tmp_user = user_params["user"]
#    IO.inspect tmp_photo.filename
#    IO.inspect tmp_photo.path
#    tmp_path = Path.split(tmp_photo.path) |> Path.join

    # We should use value of tmp_path to move to s3
#    upload_file = "/Users/developer/#{tmp_photo.filename}"
#
#    File.cp(tmp_path, upload_file)
#    Avatar.store { upload_file, %{ id: tmp_user.id}}

#    pre_user = %User{photo_url: tmp_photo.filename}
#    changeset = User.changeset(pre_user, user_params)
     changeset = User.changeset(%User{}, user_params)

    IO.inspect changeset

    if changeset.valid? do
      new_user = Repo.insert!(changeset)
      photo = user_params["photo"]
      user_data = user_params["user"]
      IO.inspect photo
      IO.inspect user_data
      tmp_path = Path.split(photo.path) |> Path.join
      upload_file = "/Users/developer/#{photo.filename}"
      File.cp tmp_path, upload_file

      IO.inspect new_user
      IO.inspect tmp_path

      Avatar.store { upload_file, %{id: new_user.id} }

      conn
      |> put_flash(:info, "User created successfully.")
      |> redirect(to: user_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    if changeset.valid? do
      Repo.update!(changeset)

      conn
      |> put_flash(:info, "User updated successfully.")
      |> redirect(to: user_path(conn, :index))
    else
      render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    Repo.delete!(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
