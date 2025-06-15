# frozen_string_literal: true

json.task do
  json.extract! @task,
    :id,
    :slug,
    :title

  json.assigned_user do
    son.extract! @task.assigned_user,
      :id,
      :name
  end
end
