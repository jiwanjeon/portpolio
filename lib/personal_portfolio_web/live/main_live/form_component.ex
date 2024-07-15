defmodule PersonalPortfolioWeb.MainLive.FormComponent do
  use PersonalPortfolioWeb, :live_component

  alias PersonalPortfolio.Portfolio

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage main records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="main-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:email]} type="text" label="Email" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Main</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{main: main} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Portfolio.change_main(main))
     end)}
  end

  @impl true
  def handle_event("validate", %{"main" => main_params}, socket) do
    changeset = Portfolio.change_main(socket.assigns.main, main_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"main" => main_params}, socket) do
    save_main(socket, socket.assigns.action, main_params)
  end

  defp save_main(socket, :edit, main_params) do
    case Portfolio.update_main(socket.assigns.main, main_params) do
      {:ok, main} ->
        notify_parent({:saved, main})

        {:noreply,
         socket
         |> put_flash(:info, "Main updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_main(socket, :new, main_params) do
    case Portfolio.create_main(main_params) do
      {:ok, main} ->
        notify_parent({:saved, main})

        {:noreply,
         socket
         |> put_flash(:info, "Main created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
