class Task < ApplicationRecord
  enum importance: { 低: 0, 中: 1, 高: 2 }
  enum status: { 未着手: 0, 着手: 1, 完了: 2 }
end