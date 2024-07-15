defmodule PersonalPortfolioWeb.MainLive.Index do
  use PersonalPortfolioWeb, :live_view

  alias PersonalPortfolio.Portfolio
  alias PersonalPortfolio.Portfolio.Main

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :main_collection, Portfolio.list_main())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Main")
    |> assign(:main, Portfolio.get_main!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Main")
    |> assign(:main, %Main{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Main")
    |> assign(:main, nil)
  end

  @impl true
  def handle_info({PersonalPortfolioWeb.MainLive.FormComponent, {:saved, main}}, socket) do
    {:noreply, stream_insert(socket, :main_collection, main)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    main = Portfolio.get_main!(id)
    {:ok, _} = Portfolio.delete_main(main)

    {:noreply, stream_delete(socket, :main_collection, main)}
  end
end
