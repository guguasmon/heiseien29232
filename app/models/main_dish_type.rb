class MainDishType < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '常食' },
    { id: 2, name: '軟菜' },
    { id: 3, name: '刻み' },
    { id: 4, name: 'ペースト' }
  ]
end
