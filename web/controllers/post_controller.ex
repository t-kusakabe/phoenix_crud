defmodule PhoenixCrud.PostController do
  use PhoenixCrud.Web, :controller
  alias PhoenixCrud.Post

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render conn, "new.html", changeset: changeset
  end
end

