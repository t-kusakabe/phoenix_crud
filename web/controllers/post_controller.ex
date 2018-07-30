defmodule PhoenixCrud.PostController do
  use PhoenixCrud.Web, :controller
  alias PhoenixCrud.Post

  def index(conn, _params) do
    posts = Post |> Repo.all
    render conn, "index.html", posts: posts
  end

  def show(conn, %{"id" => id}) do
    post = Post |> Repo.get(id)
    render conn, "show.html", post: post
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"post" => post_params}) do
    changeset = Post.changeset(%Post{}, post_params)
    case Repo.insert(changeset) do 
      {:ok, _} ->
        conn
        |> put_flash(:info, "投稿しました")
        |> redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "投稿に失敗しました")
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    post = Post |> Repo.get(id)
    changeset = Post.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Post |> Repo.get(id)
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "投稿を更新しました")
        |> redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "更新に失敗しました")
        |> render("edit.html", changeset: changeset, post: post)
    end
  end

  def delete(conn,  %{"id" => id}) do
    post = Post |> Repo.get(id)
    Repo.delete(post)

    conn
    |> put_flash(:info, "削除に成功しました")
    |> redirect(to: post_path(conn, :index))
  end
end

