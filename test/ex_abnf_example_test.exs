defmodule ABNFAppTest do
  @moduledoc """
  Test module.
      Copyright 2015 Marcelo Gornstein <marcelog@gmail.com>
      Licensed under the Apache License, Version 2.0 (the "License");
      you may not use this file except in compliance with the License.
      You may obtain a copy of the License at
      http://www.apache.org/licenses/LICENSE-2.0
      Unless required by applicable law or agreed to in writing, software
      distributed under the License is distributed on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
      See the License for the specific language governing permissions and
      limitations under the License.
  """

  use ExUnit.Case
  require Logger

  test "simple postal addresses" do
    postal_address = 'John M. Doe Jr.\r\n4 6th 18ave\r\nMiami, FL 33166-1234\r\n'
    parse_and_assert postal_address, "postal-address", %{
      name: "John M. Doe Jr.",
      street: %{
        apartment: 4,
        house: "6th",
        street: "18ave"
      },
      zip: %{
        town: "Miami",
        state: "FL",
        zip: %{
          code: 33166,
          extended: 1234
        }
      }
    }
  end

  defp parse_and_assert(input, rule, expected_result) do
    result = ABNFApp.init |> ABNFApp.parse(input, rule)
    assert is_map result
    assert hd(result.values) === expected_result
  end
end
