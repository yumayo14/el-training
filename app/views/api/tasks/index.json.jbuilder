json.array! @tasks do |task|
  json.id task.id
  json.title task.title
  json.importance do
    json.text task.importance
    json.rank task.importance_before_type_cast
  end
  json.dead_line_on task.dead_line_on
  json.status do
    json.text task.status
    json.num task.status_before_type_cast
  end
  json.detail task.detail
  json.created_at task.created_at.strftime('%Y/%m/%d')
end