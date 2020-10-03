class StapleType < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '常食' },
    { id: 2, name: '軟飯' },
    { id: 3, name: '粥' },
    { id: 4, name: 'ペースト' },
    { id: 5, name: 'パン食' },
    { id: 6, name: 'パン粥' }
  ]
end