# frozen_string_literal: true

if defined?(SolidusWebhooks)
  SolidusWebhooks.register_webhook :easypost_trackers, ->(payload) do
    SolidusEasypost::TrackerWebhookHandler.call(payload)
  end
end
