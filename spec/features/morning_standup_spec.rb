require_relative '../spec_helper'

describe 'invoking and submitting morning standup', type: :feature do
  let(:session) do
    Capybara::Session.new(:selenium_headless)
  end

  before(:each) do
    LoginHelper.call(session)
  end
  context 'when invoking command for morning standup' do
    it 'will return inputs from ' do
      sleep(5)
      session.find('.ql-editor').send_keys('/morning_standup')
      session.find('.ql-editor').native.send_keys(:return)
      inputs_in_form = session.find_all('.c-input_textarea')
      4.times do |time|
        inputs_in_form[time].click
        inputs_in_form[time].native.send_keys(time.to_s)
      end
      session.choose('radio_choice-action-stationary-0')
      session.check('checkbox_choice-action-checked-0')
      session.find('#morning_saving-action').click

      sleep(3)
      text_in_test = session.find_all('.c-message_kit__attachments').last.text.split("\n")

      expect(text_in_test[1]).to eq('0')
      expect(text_in_test[3]).to eq('1')
      expect(text_in_test[5]).to eq('2')
      expect(text_in_test[7]).to eq('3')
      footer_text = text_in_test[8].split
      expect(footer_text[0]).to eq('#stacjonarnie')
      expect(footer_text[1..2].join(' ')).to eq('#chce sam')
    end
  end
end
