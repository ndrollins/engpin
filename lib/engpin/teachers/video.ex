defmodule Engpin.Teachers.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :content_type, :string
    field :filename, :string
    field :path, :string
    field :title, :string
    field :video_file, :any, virtual: true

    timestamps()
  end

  @required_fields ~w(title video_file)a
  @optional_fields ~w(filename)a
  @doc false
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> put_video_file()
  end

  def put_video_file(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{video_file: video_file}} ->
        path = Ecto.UUID.generate() <> Path.extname(video_file.filename)

        changeset
        |> put_change(:path, path)
        |> put_change(:filename, video_file.filename)
        |> put_change(:content_type, video_file.content_type)

      _ ->
        changeset
    end
  end
end
