# rails_template

## Ref
* [Rails アプリケーションのテンプレート \- Railsガイド](https://railsguides.jp/rails_application_templates.html)
* [rails6\_template/app\_template\.rb at master · Iwark/rails6\_template](https://github.com/Iwark/rails6_template/blob/master/app_template.rb)
* [Rails new でいつもの準備を済ませる \- Qiita](https://qiita.com/gouf/items/8ecdb1c6fd88935e1808)
* [after_bundle Rails::Generators::Actions](https://api.rubyonrails.org/v5.1/classes/Rails/Generators/Actions.html#method-i-after_bundle)
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
