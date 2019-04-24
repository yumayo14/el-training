# frozen_string_literal: true

json.nested do
  json.current_page @tasks.current_page
  json.last_page @tasks.total_pages
  unless @tasks.last_page?
    json.next_page_url '/api/tasks.json?page=' + @tasks.next_page.to_s
  else
    json.next_page_url ''
  end
  unless @tasks.first_page?
    json.prev_page_url '/api/tasks.json?page=' + @tasks.prev_page.to_s
  else
    json.prev_page_url ''
  end
  json.data do
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
  end
end




