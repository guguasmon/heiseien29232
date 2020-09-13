class Thickness < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: 'とろみなし' },
    { id: 2, name: '小匙半分' },
    { id: 3, name: '小匙一杯' }
  ]
end
