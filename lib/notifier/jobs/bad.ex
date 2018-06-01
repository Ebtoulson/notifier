defmodule Notifier.BadJob do
  use TaskBunny.Job
  require Logger

  def perform(_payload) do
    Logger.info("Starting bad")
    Process.sleep(2_000)
    :ok = :error
  end

  def max_retry, do: 0
  def timeout, do: 300_000
end
