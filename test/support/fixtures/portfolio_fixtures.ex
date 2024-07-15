defmodule PersonalPortfolio.PortfolioFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PersonalPortfolio.Portfolio` context.
  """

  @doc """
  Generate a main.
  """
  def main_fixture(attrs \\ %{}) do
    {:ok, main} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name"
      })
      |> PersonalPortfolio.Portfolio.create_main()

    main
  end
end
