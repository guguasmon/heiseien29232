$(document).on('turbolinks:load', function(){
  $('form').on('change', 'input[type="file"]', function(e){
    //ファイルオブジェクトを取得する
    const file = e.target.files[0],
          reader = new FileReader(),
          $preview = $(".preview");

    //画像でない場合は処理終了
    if(file.type.indexOf("image") < 0){
      alert("画像ファイルを指定してください。");
      return false;
    }

    // ファイル読み込みが完了した際のイベント登録
    reader.onload = (function(file) {
      return function(e) {
        //既存のプレビューを削除
        $preview.empty();
        // .prevewの領域の中にロードした画像を表示するimageタグを追加
        $preview.append($('<img>').attr({
                  src: e.target.result,
                  style: "width: auto; height: 200px;",
                  class: "preview",
                  title: file.name
              }));
      };
    })(file);

    reader.readAsDataURL(file);

  });
});