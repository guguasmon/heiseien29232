class Timing < ActiveHash::Base
  self.data = [
    { id: 1, name: '最初' },
    { id: 2, name: '早め' },
    { id: 3, name: '普通' },
    { id: 4, name: '遅め' },
    { id: 5, name: '最後' }
  ]
end
