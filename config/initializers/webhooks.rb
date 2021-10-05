# frozen_string_literal: true

if defined?(SolidusWebhooks)
  SolidusWebhooks.config.register_webhook_handler :easypost_trackers, ->(payload) do
    SolidusEasypost::TrackerWebhookHandler.call(payload)
  end
end
