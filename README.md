# rails_template
* 参考：[rails6\_template/app\_template\.rb at master · Iwark/rails6\_template](https://github.com/Iwark/rails6_template/blob/master/app_template.rb)

## Usage

```console
$ rails new app -d postgresql -BTC --skip-turbolinks -m app_template.rb
```

## Motivation

- newのあとにGemfileを編集したくない
- bundleのあとの必須設定を自動でやってほしい
  - i18nのja.ymlのダウンロード
  - RSpec generate時の作成ファイルの設定
  - Gemfileのコメント行の削除
  - 
