defmodule EngpinWeb.WatchController do
  use EngpinWeb, :controller

  #import Engpin.Util

  alias Engpin.Teachers

  def show(%{req_headers: _headers} = conn, %{"id" => id}) do
    video = Teachers.get_video!(id)
    render(conn, "show.html", video: video)
  end
end
