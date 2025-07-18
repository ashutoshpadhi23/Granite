# frozen_string_literal: true

require "test_helper"

class PreferencesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = create(:user)
    @preference = @user.preference
    @headers = headers(@user)
  end

  def test_show_preference_for_a_valid_user
    get preference_path, headers: @headers
    assert_response :ok
    assert_equal @preference.id, response.parsed_body["preference"]["id"]
  end

  def test_not_found_error_rendered_if_preference_is_not_present
    @user.preference = nil
    get preference_path, headers: @headers
    assert_response :not_found
  end

  def test_update_success
    preference_params = { preference: { should_receive_email: false } }

    put preference_path, params: preference_params, headers: @headers
    @preference.reload
    assert_response :ok
    refute @preference.should_receive_email
  end

  def test_update_failure_for_invalid_notification_delivery_hour
    preference_params = { preference: { notification_delivery_hour: 24 } }

    put preference_path, params: preference_params, headers: @headers
    assert_response :unprocessable_entity
    assert_equal "Notification delivery hour #{I18n.t("preference.notification_delivery_hour.range")}",
      response.parsed_body["error"]
  end

  def test_update_success_mail
    preference_params = { preference: { should_receive_email: false } }

    patch mail_preference_path, params: preference_params, headers: @headers
    @preference.reload
    assert_response :ok
    refute @preference.should_receive_email
  end
end
