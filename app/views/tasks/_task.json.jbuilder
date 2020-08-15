json.extract! task, :id, :name, :detail, :created_at, :updated_at
json.url task_url(task, format: :json)
