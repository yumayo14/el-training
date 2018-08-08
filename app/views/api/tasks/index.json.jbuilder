json.array! @tasks do |task|
  json.id task.id
  json.title task.title
  json.importance task.importance
  json.dead_line_on task.dead_line_on
  json.status task.status
  json.detail task.detail
  json.created_at task.created_at.strftime('%Y/%m/%d')
end