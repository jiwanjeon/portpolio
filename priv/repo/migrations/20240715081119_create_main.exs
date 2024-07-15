defmodule PersonalPortfolio.Repo.Migrations.CreateMain do
  use Ecto.Migration

  def change do
    create table(:main) do
      add :name, :string
      add :email, :string

      timestamps(type: :utc_datetime)
    end
  end
end
