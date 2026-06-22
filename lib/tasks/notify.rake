namespace :notify do
  desc "期限が3日後のタスクをLINEに通知する"
  task line_deadline: :environment do
    target_date = Date.today + 3

    tasks = Task.where(limit: target_date).where.not(status: 3)

    if tasks.exists?
      # 冒頭のおかんセリフ
      openings = [
        "ちょっとあんた！😤",
        "ねえ、聞いてる？👂",
        "また忘れてるんじゃないでしょうね？😠",
        "はいはい、お母さんからのお知らせよ〜📣",
        "あら、まだ終わってないの？😳",
      ]

      # タスクごとの催促セリフ（タスク名を埋め込む）
      nags = [
        "「%s」まだやってないでしょ！💢",
        "「%s」、いつまで放置するつもり？⏰",
        "「%s」、ちゃんとやりなさいよ！👊",
        "「%s」忘れてない？早くやっちゃいなさい！🏃",
        "「%s」、後でじゃなくて今やりなさい！❗",
        "「%s」、いい加減手をつけなさいね。😑",
      ]

      # 締めのおかんセリフ
      closings = [
        "宿題やったの？歯磨いたの？タスクも忘れないでよ！🦷",
        "後でやる、は今やる、ってことよ！⏳",
        "やったらすぐ報告してね〜📱",
        "言われる前にやっておきなさいって言ったでしょ！🙅",
        "ちゃんとやるまで何度でも言うからね！🔁",
        "明日になったらもっと面倒になるんだから、今のうちにやりなさい！⚡",
      ]

      # おかん風スタンプのバリエーション（package_id, sticker_idの組み合わせ）
      stickers = [
        { package_id: "446", sticker_id: "2004" },
        { package_id: "789", sticker_id: "10885" },
        { package_id: "789", sticker_id: "10892" },
        { package_id: "6136", sticker_id: "10551382" },
        { package_id: "6325", sticker_id: "10979923" },
        { package_id: "11538", sticker_id: "51626518" },
      ]

      divider = "\n━━━━━━━━━━━━━\n"

      blocks = tasks.map do |t|
        limit_str = t.limit.strftime("%Y年%m月%d日")
        nag = format(nags.sample, t.name)
        <<~TASK.chomp
          #{nag}
          タスク内容：#{t.content}
          期限：#{limit_str}まで
        TASK
      end

      text = "【おかんタスクからのお知らせ】\n" \
            "#{openings.sample}\n" +
            divider + blocks.join(divider) + divider +
            closings.sample

      LineNotifier.push(
        text: text,
        sticker: stickers.sample
        )
    else
      Rails.logger.info("notify:line_deadline 該当タスクなし(#{target_date})")
    end
  end
end