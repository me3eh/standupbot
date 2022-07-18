require 'rspec'

describe PrepareMorningForm do
  let(:random_number) { Faker::Number.number(digits: 10).to_s }
  let(:other_random_number) { Faker::Number.number(digits: 10).to_s }
  subject(:result_without_standup) { described_class.call(user_id: random_number, team_id: other_random_number) }
  let(:only_inputs_without_standup) { result_without_standup.select { |u| u[:type] == "input"} }

  let(:type_values) do
    %w[header input divider divider input divider divider input divider divider input actions]
  end
  
  context 'when no standup was created in recent day' do

    it "will return only provided jsons" do
      expect(result_without_standup.size).to eq(12)
      expect(result_without_standup.pluck(:type)).to eq( type_values )
    end
    it 'will post empty form' do
      expect( only_inputs_without_standup.map{|u| u[:element][:initial_value]} ).to all( eq("") )
    end
  end

  context 'when standup was created in recent day' do
    let!(:standup) { create(:standup, :morning_standup, user_id: random_number, team: other_random_number) }
    subject(:result_with_standup) { described_class.call(user_id: random_number, team_id: other_random_number) }
    let(:only_inputs_with_standup) { result_with_standup.select { |u| u[:type] == "input"} }

    it "will return only provided jsons" do
      expect(result_with_standup.size).to eq(12)
      expect(result_with_standup.pluck(:type)).to eq( type_values )
    end

    it 'will post filled form with data from standup from database' do
      expect(only_inputs_with_standup.first[:element][:initial_value]).to eq(standup.morning_first)
      expect(only_inputs_with_standup.second[:element][:initial_value]).to eq(standup.morning_second)
      expect(only_inputs_with_standup.third[:element][:initial_value]).to eq(standup.morning_third)
      expect(only_inputs_with_standup.fourth[:element][:initial_value]).to eq(standup.morning_fourth)

    end
  end
end
