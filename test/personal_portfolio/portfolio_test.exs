defmodule PersonalPortfolio.PortfolioTest do
  use PersonalPortfolio.DataCase

  alias PersonalPortfolio.Portfolio

  describe "main" do
    alias PersonalPortfolio.Portfolio.Main

    import PersonalPortfolio.PortfolioFixtures

    @invalid_attrs %{name: nil, email: nil}

    test "list_main/0 returns all main" do
      main = main_fixture()
      assert Portfolio.list_main() == [main]
    end

    test "get_main!/1 returns the main with given id" do
      main = main_fixture()
      assert Portfolio.get_main!(main.id) == main
    end

    test "create_main/1 with valid data creates a main" do
      valid_attrs = %{name: "some name", email: "some email"}

      assert {:ok, %Main{} = main} = Portfolio.create_main(valid_attrs)
      assert main.name == "some name"
      assert main.email == "some email"
    end

    test "create_main/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portfolio.create_main(@invalid_attrs)
    end

    test "update_main/2 with valid data updates the main" do
      main = main_fixture()
      update_attrs = %{name: "some updated name", email: "some updated email"}

      assert {:ok, %Main{} = main} = Portfolio.update_main(main, update_attrs)
      assert main.name == "some updated name"
      assert main.email == "some updated email"
    end

    test "update_main/2 with invalid data returns error changeset" do
      main = main_fixture()
      assert {:error, %Ecto.Changeset{}} = Portfolio.update_main(main, @invalid_attrs)
      assert main == Portfolio.get_main!(main.id)
    end

    test "delete_main/1 deletes the main" do
      main = main_fixture()
      assert {:ok, %Main{}} = Portfolio.delete_main(main)
      assert_raise Ecto.NoResultsError, fn -> Portfolio.get_main!(main.id) end
    end

    test "change_main/1 returns a main changeset" do
      main = main_fixture()
      assert %Ecto.Changeset{} = Portfolio.change_main(main)
    end
  end
end
