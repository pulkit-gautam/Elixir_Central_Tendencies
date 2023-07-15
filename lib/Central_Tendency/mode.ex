defmodule Stats.CentralTendency.Mode do
  alias Stats.Errors
  alias Stats.Validators
  def mode(nums) when is_list(nums) do
    nums
    |> Validators.validate_num_list()
    |> calc_mode()

  end

  defp calc_mode({:error , _msg}), do: Errors.invalid_data_type()
  defp calc_mode({false, _nums}),  do: Errors.invalid_data_type()

  defp calc_mode({true, nums}) do
    ranked_map = nums |> Enum.frequencies()

    ranked_map
    |> Map.values()
    |> Enum.max()
    |> mode_func(ranked_map)
  end

  defp mode_func(1, _ranked_map), do: nil
  defp mode_func(max, ranked_map) do
    ranked_map
    |> Map.filter(fn {_key, value} -> value == max end)
    |> Map.keys()
  end
end
