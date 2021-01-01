defmodule Engpin.TeachersTest do
  use Engpin.DataCase

  alias Engpin.Teachers

  describe "videos" do
    alias Engpin.Teachers.Video

    @valid_attrs %{content_type: "some content_type", filename: "some filename", path: "some path", title: "some title"}
    @update_attrs %{content_type: "some updated content_type", filename: "some updated filename", path: "some updated path", title: "some updated title"}
    @invalid_attrs %{content_type: nil, filename: nil, path: nil, title: nil}

    def video_fixture(attrs \\ %{}) do
      {:ok, video} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Teachers.create_video()

      video
    end

    test "list_videos/0 returns all videos" do
      video = video_fixture()
      assert Teachers.list_videos() == [video]
    end

    test "get_video!/1 returns the video with given id" do
      video = video_fixture()
      assert Teachers.get_video!(video.id) == video
    end

    test "create_video/1 with valid data creates a video" do
      assert {:ok, %Video{} = video} = Teachers.create_video(@valid_attrs)
      assert video.content_type == "some content_type"
      assert video.filename == "some filename"
      assert video.path == "some path"
      assert video.title == "some title"
    end

    test "create_video/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Teachers.create_video(@invalid_attrs)
    end

    test "update_video/2 with valid data updates the video" do
      video = video_fixture()
      assert {:ok, %Video{} = video} = Teachers.update_video(video, @update_attrs)
      assert video.content_type == "some updated content_type"
      assert video.filename == "some updated filename"
      assert video.path == "some updated path"
      assert video.title == "some updated title"
    end

    test "update_video/2 with invalid data returns error changeset" do
      video = video_fixture()
      assert {:error, %Ecto.Changeset{}} = Teachers.update_video(video, @invalid_attrs)
      assert video == Teachers.get_video!(video.id)
    end

    test "delete_video/1 deletes the video" do
      video = video_fixture()
      assert {:ok, %Video{}} = Teachers.delete_video(video)
      assert_raise Ecto.NoResultsError, fn -> Teachers.get_video!(video.id) end
    end

    test "change_video/1 returns a video changeset" do
      video = video_fixture()
      assert %Ecto.Changeset{} = Teachers.change_video(video)
    end
  end
end
