class DrinkType < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: 'お茶' },
    { id: 2, name: '牛乳' },
    { id: 3, name: 'コーヒー牛乳' },
    { id: 4, name: 'ヤクルト' },
    { id: 5, name: 'ジュース' },
    { id: 6, name: 'プリン' },
    { id: 7, name: 'ヨーグルト' },
    { id: 8, name: '牛乳ゼリー' }
  ]
end