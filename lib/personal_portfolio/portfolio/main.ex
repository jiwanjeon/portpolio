defmodule PersonalPortfolio.Portfolio.Main do
  use Ecto.Schema
  import Ecto.Changeset

  schema "main" do
    field :name, :string
    field :email, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(main, attrs) do
    main
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
