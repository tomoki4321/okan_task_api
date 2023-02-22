FactoryBot.define do
  factory :task1,class: Task do
    name {"テスト1"}
    content {"テスト内容1"}
    limit {Date.today}
    status {2}
    priority {2}
    progress {30}
  end

  factory :task2,class: Task do
    name {"テスト2"}
    content {"テスト内容3"}
    limit {Date.today}
    status {2}
    priority {2}
    progress {30}
    created_at {Time.current}
  end

  factory :task3,class: Task do
    name {"テスト3"}
    content {"テスト内容3"}
    limit {Date.today}
    status {2}
    priority {2}
    progress {30}
    created_at {Time.current + 1.hour}
  end
end