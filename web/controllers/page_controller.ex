defmodule FileUploader.PageController do
  use FileUploader.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
