class DrinkType < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '牛乳' },
    { id: 2, name: 'コーヒー牛乳' },
    { id: 3, name: 'ヤクルト' },
    { id: 4, name: 'ジュース' },
    { id: 5, name: 'プリン' },
    { id: 6, name: 'ヨーグルト' },
    { id: 7, name: '牛乳ゼリー' },
    { id: 8, name: 'お茶' }
  ]
end