class Denture < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '義歯なし' },
    { id: 2, name: '部分義歯' },
    { id: 3, name: '上義歯' },
    { id: 4, name: '下義歯' },
    { id: 5, name: '総義歯' }
  ]
end
