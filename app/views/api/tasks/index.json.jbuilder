# frozen_string_literal: true

json.nested do
  # vuejs-paginatorを使う際に必要な値
  json.current_page @tasks.current_page
  json.last_page @tasks.total_pages
  json.next_page_url '/api/tasks.json?page=' + @tasks.next_page.to_s unless @tasks.last_page?
  json.next_page_url '' if @tasks.last_page?
  json.prev_page_url '/api/tasks.json?page=' + @tasks.prev_page.to_s unless @tasks.first_page?
  json.prev_page_url '' if @tasks.first_page?
  json.data do
    json.array! @tasks do |task|
      json.id task.id
      json.title task.title
      json.importance do
        json.text task.human_attribute_enum(:importance)
        json.value task.importance
        # index_vue.js内のタスクを優先順位順に並べるメソッドで使用する数値。
        json.rank task.importance_before_type_cast
      end
      json.dead_line_on task.dead_line_on
      json.status do
        json.text task.human_attribute_enum(:status)
        json.value task.status
      end
      json.detail task.detail
      json.created_at task.created_at.strftime('%Y/%m/%d')
    end
  end
end
