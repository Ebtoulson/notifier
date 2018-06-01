defmodule Notifier.SlowJob do
  use TaskBunny.Job
  require Logger

  def perform(_payload) do
    Logger.info("Starting slow")
    Process.sleep(sleep_time())
    :ok
  end

  # no infinite retry
  def max_retry, do: 0

  # you do have to re-create queue if you change this
  def retry_interval(_failed_count), do: 1_000

  def timeout, do: sleep_time() + 1_000

  def sleep_time, do: (2 * 60 * 1_000)
end
