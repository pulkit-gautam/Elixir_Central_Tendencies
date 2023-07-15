defmodule Stats.CentralTendency.Mean do
  alias Stats.{Errors, Validators}
  # alias Stats.Validators

  @spec population_mean([number()]) :: number() | {atom(), String.t()}
  def population_mean([]), do: Errors.invalid_data_type()
  def population_mean(nums) when is_list(nums) do
    nums
    |> Validators.validate_num_list()
    |> calculate_population_mean()
  end

  def population_mean(_), do: Errors.invalid_data_type()

  @spec sample_mean([number()]) :: number() | {atom(), String.t()}
  def sample_mean(nums), do: population_mean(nums)

  defp calculate_population_mean({false, _nums}), do: Errors.invalid_data_type()
  defp calculate_population_mean({true, nums}) do
    nums
    |> Enum.sum()
    |> mean(Enum.count(nums))
  end

  @spec mean(number, number) :: float
  defp mean(sigma, count), do: sigma/count
end
