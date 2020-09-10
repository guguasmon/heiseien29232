class Timing < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '最後' },
    { id: 2, name: '早め' },
    { id: 3, name: '最初' }
  ]
end