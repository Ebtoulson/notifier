defmodule Notifier.TextMessageJob do
  use TaskBunny.Job
  require Logger

  def perform(%{"name" => name}) do
    Logger.info("Hello #{name}")
    :ok
  end
end
