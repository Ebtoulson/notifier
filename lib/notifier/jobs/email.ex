defmodule Notifier.EmailJob do
  use TaskBunny.Job
  require Logger

  # ack = :ok | {:ok, _}
  # retry = exits | exception | not (:ok | {:ok, _}) | times out
  # reject = :reject | {:reject, _}
  def perform(%{"name" => name}) do
    Logger.info("Starting #{name}")
    Process.sleep(10_000)
    Logger.info("Finishing #{name}")
    :ok
  end

  # no infinite retry
  def max_retry, do: 1

  # you do have to re-create queue if you change this
  def retry_interval(_failed_count), do: 10_000

  def timeout, do: 300_000
end
