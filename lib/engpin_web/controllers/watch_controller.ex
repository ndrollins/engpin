defmodule Engpin.WatchController do
  use EngpinWeb, :controller

  import Engpin.Util

  alias Engpin.Video

  def show(%{req_headers: headers} = conn, %{"id" => id}) do
    video = Repo.get_video!(id)
    render(conn, headers, video)
  end
end
