json.array! @tasks do |task|
  json.extract! task,
    :id,
    :user_id,
    :name,
    :limit ,
    :content,
    :priority,
    :status,
    :progress,
    :created_at,
    :updated_at

    json.user do
      json.extract! task.user,
      :id,
      :name
    end


end