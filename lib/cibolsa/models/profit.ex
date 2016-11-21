defmodule Cibolsa.Profit do  
  use Ecto.Model

  schema "profits" do
    field :date_tracking, Ecto.DateTime, default: Ecto.DateTime.local
    field :amount, :float
    field :user_id, :integer
    timestamps
  end
end  