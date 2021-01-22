defmodule Engpin.Util do
  def build_video_path(filepath) do
    #    Application.get_env(:engpin, :uploads_dir) |> Path.join(video.path)
    Path.join(:code.priv_dir(:engpin), "static/#{filepath}")
  end

  def send_video(conn, headers, video) do
    video_path = build_video_path(video)

    conn
    |> Plug.Conn.put_resp_header("content-type", video.content_type)
    |> Plug.Conn.send_file(200, video_path)
  end
end
