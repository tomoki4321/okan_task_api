FactoryBot.define do
  factory :task1,class: Task do
    name {"テスト1"}
    content {"テスト内容1"}
    limit {Date.today}
    status {2}
    priority {2}
    progress {30}
  end
end