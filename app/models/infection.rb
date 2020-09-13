class Infection < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '感染症なし' },
    { id: 2, name: 'B肝肝炎' },
    { id: 3, name: 'C肝肝炎' },
    { id: 4, name: 'MRSA' },
    { id: 5, name: '疥癬' }
  ]
end
