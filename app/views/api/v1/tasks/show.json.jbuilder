json.task do
  json.extract! @task,
    :id,
    :user_id,
    :name,
    :content,
    :limit,
    :priority,
    :status,
    :progress,
    :created_at,
    :updated_at
    # json.user do
    #   json.extract! @task.user,
    #   :id,
    #   :name
    # end
end