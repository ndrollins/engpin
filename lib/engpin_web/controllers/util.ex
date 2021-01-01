defmodule PhoenixVideoStream.Util do
  def build_video_path(video) do
    Application.get_env(:engpin, :uploads_dir) |> Path.join(video.path)
  end
end
