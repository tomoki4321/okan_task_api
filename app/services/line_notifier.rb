require "net/http"
require "json"

class LineNotifier
  ENDPOINT = "https://api.line.me/v2/bot/message/push"

  # text: 送信するテキスト
  # sticker: { package_id: "...", sticker_id: "..." } を渡すとスタンプも一緒に送る（省略可）
  def self.push(text:, sticker: nil)
    user_id = ENV["LINE_USER_ID"]
    token   = ENV["LINE_CHANNEL_TOKEN"]
    return if user_id.blank? || token.blank?

    messages = [{ type: "text", text: text }]

    if sticker
      messages << {
        type: "sticker",
        packageId: sticker[:package_id],
        stickerId: sticker[:sticker_id]
      }
    end

    uri = URI(ENDPOINT)
    req = Net::HTTP::Post.new(uri)
    req["Content-Type"]  = "application/json"
    req["Authorization"] = "Bearer #{token}"
    req.body = {
      to: user_id,
      messages: messages
    }.to_json

    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true, open_timeout: 5, read_timeout: 10) do |http|
      http.request(req)
    end
    Rails.logger.info("LINE notify response: #{res.code} #{res.body}")
    res
  rescue => e
    Rails.logger.error("LINE notify error: #{e.class} #{e.message}")
    nil
  end
end
