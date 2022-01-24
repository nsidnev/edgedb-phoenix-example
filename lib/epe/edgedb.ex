defmodule EPE.EdgeDB do
  use EPE.EdgeDB.Queries, name: __MODULE__

  def transaction(callback, opts \\ []) do
    EdgeDB.transaction(__MODULE__, callback, opts)
  end
end
