module LoginHelper
  extend self
  def call(session)
    session.visit 'https://slack.com/workspace-signin'
    session.fill_in 'domain', with: 'pajaceroku'

    session.click_button 'Continue'
    sleep(1)
    # close popup which asks for cookie
    session.find('#onetrust-reject-all-handler').click

    session.fill_in 'email', with: $ENV.get('SLACK_NAME')
    session.fill_in 'password', with: $ENV.get('SLACK_PASS')

    session.click_button 'Sign in'
    session.visit 'https://app.slack.com/client/T01PQKG5X19/C01PWJCSCKW'
  end
end
