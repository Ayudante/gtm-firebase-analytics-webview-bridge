# Firebase Analytics WebView Bridge — GTM タグテンプレート

[English version](README.md)

アプリ内 WebView から Firebase Analytics ネイティブ SDK に、イベントとユーザープロパティを送信するための、Google Tag Manager カスタムタグテンプレートです。

## 概要

モバイルアプリの WebView から Web ページが読み込まれているとき、通常の gtag.js や GA4 タグはアプリの Firebase Analytics SDK （ GA4 のアプリストリーム）にイベントデータを転送することができません。
このテンプレートは、ネイティブアプリの WebView に実装された次の JavaScript インターフェースを呼び出すことで、アプリ版 GA4 イベント計測タグとして機能します。

- **Android**: `AnalyticsWebInterface.logEvent` / `AnalyticsWebInterface.setUserProperty`
- **iOS**: `webkit.messageHandlers.firebase.postMessage`

テンプレートは実行時に Android / iOS のどちらのプラットフォームが利用可能かを自動判定し、適切なインターフェースを呼び出します。
本テンプレートを利用するためには、予めアプリ側で WebView コンポーネントへのネイティブインターフェースの実装が必要です。

**Firebase 公式ドキュメント**: [WebView で Analytics を使用する](https://firebase.google.com/docs/analytics/webview?hl=ja)

## 要件

- Google タグマネージャーの Web コンテナ
- ホストアプリに Firebase Analytics SDK が導入されており、WebView 向けの JavaScript インターフェースが実装されていること（[実装手順](https://firebase.google.com/docs/analytics/webview?hl=ja)）

## インストール

コミュニティテンプレートギャラリーから追加できます。

1. GTM の Web コンテナで **テンプレート** を開きます
2. タグテンプレートの **検索ギャラリー** をクリックします
3. 「Firebase Analytics WebView Bridge」を検索して選択します
4. **ワークスペースに追加** をクリックします

## 設定

### Google タグ: 設定変数 *(省略可)*

有効にすると、「Google タグ: 設定」変数から共通のイベントパラメータとユーザープロパティを読み込みます。

- 同じ名前のパラメータ・ユーザープロパティが設定変数とこのタグの両方にある場合は、変数ではなく、このタグ設定で直接設定された値が優先されます
- ただし、このタグ側のパラメータの値が `undefined` に解決される場合は、設定変数の値をそのまま使います（標準の GA4 イベントタグと同じマージ動作です）
- 選択した変数がオブジェクトを返さない場合は、無視します
- 変数内の `user_properties` はイベントパラメータとしては送信せず、各エントリを `setUserProperty` で設定します（[ユーザープロパティ](#ユーザープロパティ)を参照）
- 変数内の Web 専用 `gtag.js` 設定パラメータは Firebase へ**転送しません**。これらはブラウザ側の計測制御（Cookie・シグナル・送信先）のための設定であり、アプリでは無意味または有害なため、除去します: `allow_ad_personalization_signals`、`allow_google_signals`、`client_id`、`cookie_domain`、`cookie_expires`、`cookie_flags`、`cookie_path`、`cookie_prefix`、`cookie_update`、`first_party_collection`、`ignore_referrer`、`send_page_view`、`server_container_url`、`transport_url`、`update`（[GA4 config リファレンス](https://developers.google.com/analytics/devguides/collection/ga4/reference/config?hl=ja)）

### イベント名

Firebase Analytics のイベント名（例: `screen_view`、`purchase`）。

- 英字で始まる必要があります
- 使用できるのは英字・数字・アンダースコアのみ
- 最大 40 文字
- 空欄にするとイベントを記録せず、ユーザープロパティのみ送信します

**禁止プレフィックス**: `_`、`firebase_`、`ga_`、`google_`、`gtag.` で始めることはできません

https://firebase.google.com/docs/reference/cpp/group/event-names

### イベントパラメータ

イベントパラメータとして送信するキーと値のペア。パラメータ名はイベント名と同じルール（最大 40 文字）に従います。パラメータ値が 100 文字を超える場合は自動的に切り詰めます。

以下のキー名は特別に扱われます。

- `items` — 使用できません。専用の **Items（商品の配列）** フィールドを使用してください（GTM の管理画面で入力時に拒否されます）
- [設定変数のセクション](#google-タグ-設定変数-省略可)に列挙した Web 専用 `gtag.js` 設定パラメータ — GTM の管理画面で入力時に拒否され、変数経由で渡された場合も実行時に除去します
- `user_properties` — イベントパラメータとしては送信されません。オブジェクトを返す変数を値に指定すると、設定変数の `user_properties` と同様に、各エントリを `setUserProperty` で設定します。**ユーザープロパティ** テーブルの設定はこの方法より優先されます。オブジェクト以外の値はスキップします

#### ページ情報パラメータの自動付与 *(省略可)*

**イベントパラメータ** セクション上部のラジオボタンで、ページ情報をイベントパラメータとして自動付与するかどうかを選択できます。

- `page_location` — ページ URL ( URL の # 記号より右は省略)
- `page_title` — ページのタイトル
- `page_referrer` — 遷移元のページ URL (document.referrer 相当)

デフォルトは **Do not add automatically （自動的に付与しない）** です。

**Add automatically（自動的に付与する）** を選んだ場合の動作:

- 同じパラメータ名が設定変数またはイベントパラメータの表で設定されている場合は、自動付与の値よりそちらが優先されます
- 値が空のパラメータ（リファラーがないページの `page_referrer` など）は送信しません
- 他のパラメータ値と同様に、100 文字を超える値は切り詰めます（`page_location` は超えやすい点に注意してください）

#### utm からのキャンペーンパラメータの自動付与 *(省略可)*

**イベントパラメータ** セクションの2つ目のラジオボタンで、現在のページ URL の `utm_*` クエリパラメータをイベントパラメータとして自動付与するかどうかを選択できます。パラメータ名は GA4 の Web タグが記録するものと同じです。

| URL クエリパラメータ | イベントパラメータ |
|---|---|
| `utm_source` | `source` |
| `utm_medium` | `medium` |
| `utm_campaign` | `campaign` |
| `utm_id` | `campaign_id` |
| `utm_term` | `term` |
| `utm_content` | `content` |

デフォルトは **Do not add automatically（自動的に付与しない）** です。

**Add automatically（自動的に付与する）** を選んだ場合の動作:

- 同じパラメータ名が設定変数またはイベントパラメータの表で設定されている場合は、自動付与の値よりそちらが優先されます
- URL に存在しない、または値が空の `utm_*` パラメータは送信しません
- 100 文字を超える値は警告を出して切り詰めます

**注意**: アプリのデータストリームでは、これらは通常のイベントパラメータとして記録されます。GA4 の集客（トラフィック獲得）ディメンション（セッションのソース/メディアなど）には**反映されません**。

#### Items（商品の配列）*(省略可)*

**items パラメータを送信する** を有効にすると、`items` 配列を Firebase に送信できます（`purchase` などの e コマースイベントに必要）。アイテムオブジェクトの配列を返す GTM 変数を選択してください。通常のイベントパラメータテーブルでは配列を扱えない（オブジェクト・配列の値は警告とともにスキップされる）ため、専用フィールドとして提供しています。

テンプレートは各アイテムの `quantity` および `index` フィールドを整数型に変換してからネイティブインターフェースに渡します。Firebase Analytics SDK がこれらを `Long`（Android）/ `Int`（iOS）として期待するためです。

選択した変数が空の配列、または配列以外の値を返した場合、`items` パラメータは送信されず、コンソールに警告を出力します。

#### items を使用するためのネイティブインターフェース カスタマイズ

[公式ドキュメント](https://firebase.google.com/docs/analytics/webview?hl=ja#implement-native-interface)に示されているネイティブインターフェースのサンプル実装は、そのままでは `items` 配列を処理できません。以下のカスタマイズが必要です。

##### Android

公式サンプルの `bundleFromJson` ヘルパーはプリミティブ型（String、Integer、Double）しか処理しません。`items` を正しく `Bundle[]` 配列に変換するために、`JSONArray` の処理を追加してください。

```java
private Bundle bundleFromJson(String json) {
    Bundle bundle = new Bundle();
    try {
        JSONObject jsonObject = new JSONObject(json);
        Iterator<String> keys = jsonObject.keys();
        while (keys.hasNext()) {
            String key = keys.next();
            Object value = jsonObject.get(key);
            if (value instanceof String) {
                bundle.putString(key, (String) value);
            } else if (value instanceof Integer) {
                bundle.putInt(key, (Integer) value);
            } else if (value instanceof Long) {
                bundle.putLong(key, (Long) value);
            } else if (value instanceof Double) {
                bundle.putDouble(key, (Double) value);
            } else if (value instanceof Boolean) {
                bundle.putBoolean(key, (Boolean) value);
            } else if (value instanceof JSONArray) {
                // items 配列の処理
                JSONArray array = (JSONArray) value;
                Bundle[] bundles = new Bundle[array.length()];
                for (int i = 0; i < array.length(); i++) {
                    bundles[i] = bundleFromJson(array.getJSONObject(i).toString());
                }
                bundle.putParcelableArray(key, bundles);
            }
        }
    } catch (JSONException e) {
        Log.e(TAG, "bundleFromJson failed", e);
    }
    return bundle;
}
```

##### iOS

WKWebView が JavaScript の数値を `postMessage` 経由で Swift に渡すとき、常に `NSNumber` にラップされます。Firebase SDK が `Int` として期待するフィールド（`quantity` と `index`）に対して `NSNumber(Double)` が渡されると、値が `0` として記録される場合があります。メッセージ受信後にこれらの整数フィールドを明示的に変換してください。

```swift
func userContentController(_ userContentController: WKUserContentController,
                           didReceive message: WKScriptMessage) {
    guard let body = message.body as? [String: Any] else { return }
    guard let command = body["command"] as? String else { return }
    guard let name = body["name"] as? String else { return }

    if command == "setUserProperty" {
        guard let value = body["value"] as? String else { return }
        Analytics.setUserProperty(value, forName: name)
    } else if command == "logEvent" {
        guard var params = body["parameters"] as? [String: NSObject] else { return }
        // 整数フィールド（quantity, index）が Double として渡され 0 になる問題を
        // 回避するため、Int に変換する
        if let items = params["items"] as? [[String: Any]] {
            let normalizedItems: [[String: Any]] = items.map { item in
                var normalized = item
                for field in ["quantity", "index"] {
                    if let value = item[field] as? NSNumber {
                        normalized[field] = value.intValue
                    }
                }
                return normalized
            }
            params["items"] = normalizedItems as NSObject
        }
        Analytics.logEvent(name, parameters: params)
    }
}
```

### ユーザープロパティ

Firebase Analytics ユーザープロパティとして設定するキーと値のペア。プロパティ名は英字で始まり、英字・数字・アンダースコアのみ使用可能で、最大 24 文字です。値が 36 文字を超える場合は自動的に切り詰めます。

ユーザープロパティは、設定変数の `user_properties` → イベントパラメータテーブルの `user_properties` → このテーブル、の順にマージされます（後のものが優先）。

**禁止プレフィックス**: `_`、`firebase_`、`ga_`、`google_` で始めることはできません

### 値の型の扱い

イベントパラメータとユーザープロパティの値は、送信前に実行時チェックされます。

| 値の型 | 動作 |
|---|---|
| string / number | そのまま送信します。ただしユーザープロパティに設定した数値は文字列に変換します（ネイティブインターフェースが文字列のみ受け付けるため） |
| boolean | 文字列 `'true'` / `'false'` に変換します |
| object / 配列 / function | 警告を出してスキップします（`items` 配列は専用の Items フィールドを使用してください） |
| `undefined` | 「未設定」として扱い、設定変数の値を保持します |
| `null` | そのまま送信し、設定変数の値を上書きします |

## 実行時の動作

- まず Android インターフェースを探し、見つかればそれを使用します
- Android インターフェースが見つからない場合は iOS インターフェースを使用します
- どちらも見つからない場合、タグは何も実行しません
- 文字数制限を超えた値は実行時に切り詰めます

## 推奨設定1 : 目的外のGA4プロパティへのデータ送信防止

本タグが実装された Web ページが第三者のアプリ内 WebView （例: Facebook アプリ）上で開かれたとき、そのアプリにも同様の JavaScript インターフェースとFirebase Analyticsが実装されていた場合、イベントデータが第三者の Google Analytics に送信される可能性があります。
これを避けるため、自分のアプリの User-Agent 情報などを元に、あなたのタグ設定が第三者のアプリ上で発火しないように設定することを推奨します。

（※ GTM サンドボックスの制約により、テンプレート内での User-Agent による動作制限はサポートしていません。）

次の例を参考に設定してください。


### 変数設定 "cjs - Official App Verification" の作成

この変数設定は、ブラウザ( WebView )の User-Agent 文字列が特定のフレーズを含んでおり、かつ、 JavaScript インターフェースが使用可能( Firebase に情報を送信可能)なときに `true` を返します。それ以外のとき、 `false` を返します。

#### 変数のタイプ

カスタム JavaScript 変数

#### カスタム JavaScript

`'INSERT HERE YOUR APP USER AGENT KEY'` の部分を、イベント計測対象のアプリのUser-Agent文字列が持つ特徴的な文字列に置き換えて使用してください。

User-Agent情報を元に、目的のアプリのWebViewであり、かつ、Firebase側にGTMからイベントが送信できる状態であるかを確認して、これらの条件がすべて満たされたとき `true` 、そうでないとき `false` を返します。

```js
function(){
  var USER_AGENT_KEY = 'INSERT HERE YOUR APP USER AGENT KEY';

  var isAccessFromOfficialApp = navigator.userAgent.indexOf(USER_AGENT_KEY) > -1;
  var isNativeInterfaceAvailable = !!(window.AnalyticsWebInterface || window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.firebase);
  return isNativeInterfaceAvailable && isAccessFromOfficialApp;
}
```

### トリガー設定 "event - .* - excl. Official App WebView" の作成
「対象アプリのWebView内でページが開かれており、かつ、GTMからFirebaseに情報を送信できる」という条件が満たされていないときに反応するトリガー設定です。
このトリガー設定を、本テンプレートによって作成された WebView イベント計測用のタグに例外トリガーとして設定することで、別アプリの WebView で、目的外の Firebase にイベントを送信することを防ぎます。

#### トリガーのタイプ

カスタムイベントトリガー

#### イベント名

```
.*
```

✅ 正規表現一致を使用

#### このトリガーの発生場所

一部のイベント

イベント発生時にこれらすべての条件が true の場合にこのトリガーを配信します

`{{cjs - Official App Verification}}` 等しい `false`

## 推奨設定2 : GA4への二重データ送信防止

通常の GA4 タグ設定と、本テンプレートにより作成したタグ設定が WebView 内で同時に発火して、同じ GA4 プロパティにデータを送信した場合、同一のユーザーアクションが Web ストリームとアプリストリームで二重計測される懸念があります。これを回避するため、通常の GA4 タグ設定には次の例外トリガー設定を行い、 WebView 上で発火しないように設定します。

### 変数設定 "cjs - Official App Verification" の作成

「推奨設定1」で作成した変数設定を使います。

### トリガー設定 "event - .* - Official App WebView" の作成

「対象アプリの WebView 内でページが開かれており、かつ、 GTM から Firebase に情報を送信できる」という条件が満たされているときに反応するトリガー設定です。
このトリガー設定を通常のGA4タグ設定に例外トリガーとして設定することで、 WebView 上で GA4 Webストリームにデータが送信されることを防ぎます。

#### トリガーのタイプ

カスタムイベントトリガー

#### イベント名

```
.*
```

✅ 正規表現一致を使用

#### このトリガーの発生場所

一部のイベント

イベント発生時にこれらすべての条件が true の場合にこのトリガーを配信します

`{{cjs - Official App Verification}}` 等しい `true`

## 補足

- このテンプレートは GTM **Web** コンテナ専用です
- このテンプレートを使用したタグ設定が動作するためには、 GTM Web コンテナが WebView 内で動作する必要があります(一部のアプリではWebView時にGTMが読み込まれないような設定を独自に行なっている場合があります)
- イベント名・パラメータ名・ユーザープロパティ名の命名規則バリデーションは、フィールドに直接入力した値に対して GTM の管理画面上で適用されます。変数経由で渡した値はこのバリデーションを通らないため注意してください（Firebase 側の制限は別途適用されます）

## ライセンス

[Apache License, Version 2.0](LICENSE) のもとで公開しています。

## 作者

[Ayudante, inc.](https://ayudante.jp)