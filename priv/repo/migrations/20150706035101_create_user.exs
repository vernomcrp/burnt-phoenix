defmodule FileUploader.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :bio, :string
      add :age, :integer

      timestamps
    end

  end
end
