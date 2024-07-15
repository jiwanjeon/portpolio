defmodule PersonalPortfolioWeb.MainLive.Show do
  use PersonalPortfolioWeb, :live_view

  alias PersonalPortfolio.Portfolio

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:main, Portfolio.get_main!(id))}
  end

  defp page_title(:show), do: "Show Main"
  defp page_title(:edit), do: "Edit Main"
end
