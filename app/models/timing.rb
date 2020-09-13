class Timing < ActiveHash::Base
  self.data = [
    { id: 0, name: '普通' },
    { id: 1, name: '最初' },
    { id: 2, name: '早め' },
    { id: 3, name: '遅め' },
    { id: 4, name: '最後' }
  ]
end
