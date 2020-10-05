class StapleAmount < ActiveHash::Base
  self.data = [
    { id: 1, name: '大盛り' },
    { id: 2, name: '普通' },
    { id: 3, name: '小盛り' }
  ]
end
