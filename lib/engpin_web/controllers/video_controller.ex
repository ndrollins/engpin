defmodule EngpinWeb.VideoController do
  use EngpinWeb, :controller

  import Engpin.Util, only: [build_video_path: 1]

  alias Engpin.Teachers
  alias Engpin.Teachers.Video

  def index(conn, _params) do
    videos = Teachers.list_videos()
    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params) do
    changeset = Teachers.change_video(%Video{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" => video_params}) do
    temp_path = video_params["video_file"].path
    video_params = update_path(video_params, "priv/static/videos#{video_params["video_file"].filename}")
    case Teachers.create_video(video_params) do
      {:ok, video} ->
        save_file(video, temp_path)

        conn
        |> put_flash(:info, "Video created successfully.")
        |> redirect(to: Routes.video_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # def create(conn, %{"video" => video_params}) do
  #  case Teachers.create_video(video_params) do
  #    {:ok, video} ->
  #      conn
  #      |> put_flash(:info, "Video created successfully.")
  #      |> redirect(to: Routes.video_path(conn, :show, video))

  #    {:error, %Ecto.Changeset{} = changeset} ->
  #      render(conn, "new.html", changeset: changeset)
  #  end
  # end

  def show(conn, %{"id" => id}) do
    video = Teachers.get_video!(id)
    render(conn, "show.html", video: video)
  end

  def edit(conn, %{"id" => id}) do
    video = Teachers.get_video!(id)
    changeset = Teachers.change_video(video)
    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    video = Teachers.get_video!(id)

    case Teachers.update_video(video, video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video updated successfully.")
        |> redirect(to: Routes.video_path(conn, :show, video))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", video: video, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    video = Teachers.get_video!(id)
    {:ok, _video} = Teachers.delete_video(video)

    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: Routes.video_path(conn, :index))
  end

  defp  save_file(video, temp_path) do
    video_path = build_video_path(video.filename)

    unless File.exists?(video_path) do
      video_path |> Path.dirname() |> File.mkdir_p()
      File.copy!(temp_path, video_path)
    end
  end

  defp update_path(video_params, new_path) do
    Map.update(video_params, "video_file", nil, fn video_file ->
      Map.put(video_file, :path, new_path)
    end)
  end
end
