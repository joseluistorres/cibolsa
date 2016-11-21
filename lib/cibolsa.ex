defmodule Cibolsa do
  use Application
  use Hound.Helpers
  alias Cibolsa.Profit

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      worker(Cibolsa.Repo, []),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cibolsa.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def login do
    IO.puts "----------------starting again-----------------"
    Hound.start_session
    navigate_to "https://cicasadebolsa-online.com/cicasadebolsa_online/login.aspx"

    find_element(:id, "txtusuario") |> fill_field(System.get_env("user_ci"))
    find_element(:id, "txtpwd") |> fill_field(System.get_env("user_ci"))
    find_element(:id, "btnAceptar") |> click
  end

  def get_data do
    Hound.start_session
    navigate_to "https://cicasadebolsa-online.com/cicasadebolsa_online/Posicion.aspx"
    ot = find_element(:id, "ctl00_ContentPlaceHolder1_BtnAcepta")
    click( ot )

    my_var = page_source() |> Floki.find("#ctl00_ContentPlaceHolder1_Label56") |> Floki.text
    res = String.replace(my_var, ~r/(,)|\$/, "") |> String.to_float
    #IO.puts res
    operation = - Float.round(2400000 - res, 3)
    Cibolsa.Repo.insert %Profit{amount: operation, date_tracking: Ecto.DateTime.local, user_id: 1}
  end


end
