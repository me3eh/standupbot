require_relative '../spec_helper'

describe 'invoking and submitting morning standup', type: :feature do
  let(:radio_button_stationary_option) { 'radio_choice-action-stationary-0' }
  let(:checkbox_option) { 'checkbox_choice-action-checked-0' }
  let(:submit_button) { '#morning_saving-action' }
  let(:form_inputs) { '.c-input_textarea' }

  let(:session) do
    Capybara::Session.new(:selenium_headless)
  end

  before(:all) do
    Capybara.run_server
  end

  before(:each) do
    LoginHelper.call(session)
  end
  context 'when invoking command for morning standup' do
    it 'will return inputs from ' do
      raise StandardError unless session.has_css?('.ql-editor', wait: 5)

      chat_input = session.find('.ql-editor')

      chat_input.send_keys('/morning_standup')
      chat_input.native.send_keys(:return)

      inputs_in_form = session.find_all(form_inputs)
      4.times do |number|
        inputs_in_form[number].click
        inputs_in_form[number].native.send_keys(number.to_s)
      end

      session.choose(radio_button_stationary_option)
      session.check(checkbox_option)
      session.find(submit_button).click

      # need that sleep, because it will wait for new message to show up
      sleep(3)

      text_in_standup = session.find_all('.c-message_kit__attachments').last.text.split("\n")

      expect(text_in_standup[1]).to eq('0')
      expect(text_in_standup[3]).to eq('1')
      expect(text_in_standup[5]).to eq('2')
      expect(text_in_standup[7]).to eq('3')
      footer_text = text_in_standup[8].split
      expect(footer_text[0]).to eq('#stacjonarnie')
      expect(footer_text[1..2].join(' ')).to eq('#chce sam')
    end
  end
end
