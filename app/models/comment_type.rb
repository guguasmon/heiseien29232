class CommentType < ActiveHash::Base
  self.data = [
    { id: 1, name: '新規' },
    { id: 2, name: '更新' }
  ]
end