RSpec.describe Sanitizer do

  it 'masks value of any key passed in the mask argument' do
    
    example = {
      :password => "secretPassword",
      :nested => {
        :password => "someSecret",
        :Password => "intact",
        :deep => {
          :deep => {
            :password => "hidden"
          }
        }
      }
    }

    test_remove_one = example.sanitize()
    expect(test_remove_one[:password]).to eq("**********word")
    expect(test_remove_one[:nested][:password]).to eq("******cret")
    expect(test_remove_one[:nested][:Password]).to eq("intact")
    expect(test_remove_one[:nested][:deep][:deep][:password]).to eq("**dden")
  end

  
  it 'masks value of any string or symbol key passed in the mask argument' do
    example = {
      "password" => "secretPassword",
      :nested => {
        "password" => "someSecret",
        :Password => "intact",
        :deep => {
          :deep => {
            "password" => "hidden"
          }
        }
      }
    }

    test_remove_one = example.sanitize([:password, 'password'])
    expect(test_remove_one['password']).to eq("**********word")
    expect(test_remove_one[:nested]["password"]).to eq("******cret")
    expect(test_remove_one[:nested][:Password]).to eq("intact")
    expect(test_remove_one[:nested][:deep][:deep]["password"]).to eq("**dden")
  end

end
