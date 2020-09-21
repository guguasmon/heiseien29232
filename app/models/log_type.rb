class LogType < ActiveHash::Base
  self.data = [
    { id: 0, name: '新規' },
    { id: 1, name: '本人の希望' },
    { id: 2, name: '家族の要望' },
    { id: 3, name: 'ADLの低下' },
    { id: 4, name: '体調の悪化' },
    { id: 5, name: '一時的な変更' },
    { id: 6, name: 'その他' }
  ]
end