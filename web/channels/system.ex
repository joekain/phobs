defmodule Phobs.SystemChannel.System do
  def info do
    :erlang.system_flag(:scheduler_wall_time, true)

    {{_,input},{_,output}} = :erlang.statistics(:io)

    mem_info = :erlang.memory()

    %{
      system_version:         :erlang.system_info(:otp_release) |> List.to_string,
      erts_version:           :erlang.system_info(:version) |> List.to_string,
      compiled_for:           :erlang.system_info(:system_architecture) |> List.to_string,
      emulator_wordsize:      :erlang.system_info({:wordsize, :external}),
      process_wordsize:       :erlang.system_info({:wordsize, :internal}),
      smp_support:            :erlang.system_info(:smp_support),
      thread_support:         :erlang.system_info(:threads),
      async_thread_pool_size: :erlang.system_info(:thread_pool_size),

      logical_cpus:           :erlang.system_info(:logical_processors),
      logical_cpus_online:    :erlang.system_info(:logical_processors_online),
      logical_cpus_available: :erlang.system_info(:logical_processors_available),
      schedulers:             :erlang.system_info(:schedulers),
      schedulers_online:      :erlang.system_info(:schedulers_online),
      schedulers_available:   :erlang.system_info(:schedulers),  # No _available?

      mem_total:              mem_info[:total],
      mem_processes:          mem_info[:processes],
      mem_atom:               mem_info[:atom],
      mem_binary:             mem_info[:binary],
      mem_code:               mem_info[:code],
      mem_ets:                mem_info[:ets],

      uptime_ms:              uptime_ms,
      processes_limit:        :erlang.system_info(:process_limit),
      processes:              :erlang.system_info(:process_count),
      run_queue:              :erlang.statistics(:run_queue),
      io_input:               input,
      io_output:              output,
    }
  end

  defp uptime_ms do
    {up_ms, _} = :erlang.statistics(:wall_clock)
    up_ms
  end
end
