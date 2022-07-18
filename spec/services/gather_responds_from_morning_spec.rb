require 'rspec'

describe GatherRespondsFromMorning do
  subject(:result) { described_class.call(response)}

  let(:response) do
    {
      "0" => {
        "0" => {
          "type" => "plain_text_input", "value" => first_answer
        }
      }, "1" => {
        "1" => {
          "type" => "plain_text_input", "value" => second_answer
        }
      }, "2" => {
        "2" => {
          "type" => "plain_text_input", "value" => third_answer
        }
      }, "3" => {
        "3" => {
          "type" => "plain_text_input", "value" => fourth_answer
        }
      }, "action" => {
        "radio_choice" => {
          "type" => "radio_buttons", "selected_option" => value_for_radio_button
        }, "checkbox_choice" => {
          "type" => "checkboxes",
          "selected_options" => value_for_checkbox
        }
      }
    }
  end
  context 'when giving parameters to gathers responds from morning standup' do
    let(:first_answer) { "first" }
    let(:second_answer) { "second" }
    let(:third_answer) { "third" }
    let(:fourth_answer) { "fourth" }
    let(:value_for_radio_button) do
      {
        "text" => {
          "type" => "plain_text", "text" => "Zdalnie", "emoji" => true
        }, "value" => "remotely"
      }
    end
    let(:value_for_checkbox) do
      [{
         "text" => {
           "type" => "mrkdwn", "text" => "Open for PP", "verbatim" => false
         },
         "value" => "checked",
         "description" => {
           "type" => "mrkdwn", "text" => "Zaznaczenie na własną odpowiedzialność", "verbatim" => false
         }
       }]
    end
    context "and adding proper inputs" do
      it 'will return 4 responds from input fields, from radio button(remote) and open for pp from checkbox' do
        expect(result[:first_input]).to eq(first_answer)
        expect(result[:second_input]).to eq(second_answer)
        expect(result[:third_input]).to eq(third_answer)
        expect(result[:fourth_input]).to eq(fourth_answer)
        expect(result[:radio_button]).to eq(Constants::Forms::REMOTELY)
        expect(result[:checkbox]).to eq(true)
      end
    end

    context "and leaving some inputs empty" do
      let(:first_answer) { "first" }
      let(:second_answer) { " " }
      let(:third_answer) { nil }
      let(:fourth_answer) { "fourth" }
      it 'will return text for normal inputs and emoji for empty or blank spaces input' do
        expect(result[:first_input]).to eq(first_answer)
        expect(result[:second_input]).to eq(":clown_face:")
        expect(result[:third_input]).to eq(":clown_face:")
        expect(result[:fourth_input]).to eq(fourth_answer)
        expect(result[:radio_button]).to eq(Constants::Forms::REMOTELY)
        expect(result[:checkbox]).to eq(true)
      end
    end

    context "and leaving checkbox field not checked" do
      let(:value_for_checkbox) { [] }
      it 'will return false for checkbox' do
        expect(result[:checkbox]).to eq(false)
      end
    end

    context "and checking stationary in radio button field" do
      let(:value_for_radio_button) do
        {
          "text" => {
            "type" => "plain_text", "text" => "Stacjonarnie", "emoji" => true
          }, "value" => "stationary"
        }
      end
      it 'will return stationary type of work in radio button' do
        expect(result[:radio_button]).to eq(Constants::Forms::STATIONARY)
      end
    end
    context "and checking nothing in radio button field" do
      let(:value_for_radio_button) { nil}
      it 'will return stationary type of work in radio button' do
        expect(result[:radio_button]).to eq(Constants::Forms::SOMEWHERE_FAR_AWAY)
      end
    end
  end
end
