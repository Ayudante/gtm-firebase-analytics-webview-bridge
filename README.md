# Firebase Analytics WebView Bridge — GTM Tag Template

[日本語版はこちら](README.ja.md)

A Google Tag Manager custom tag template for sending events and user properties from an in-app WebView to the Firebase Analytics native SDK.

## Overview

When a web page is loaded inside a mobile app's WebView, the standard gtag.js or GA4 tag cannot forward event data to the app's Firebase Analytics SDK (the GA4 app stream).
This template works as a GA4 event tag for the app stream by calling the following JavaScript interfaces implemented in the native app's WebView:

- **Android**: `AnalyticsWebInterface.logEvent` / `AnalyticsWebInterface.setUserProperty`
- **iOS**: `webkit.messageHandlers.firebase.postMessage`

The template automatically detects which platform is available at runtime and calls the appropriate interface.
To use this template, the native interface must be implemented in the app's WebView component beforehand.

**Firebase official documentation**: [Use Analytics in a WebView](https://firebase.google.com/docs/analytics/webview)

## Requirements

- Google Tag Manager Web container
- Firebase Analytics SDK configured in the host app, with the WebView JavaScript interface implemented ([setup instructions](https://firebase.google.com/docs/analytics/webview))

## Installation

The template is available from the Community Template Gallery.

1. In your GTM Web container, open **Templates**
2. In the Tag Templates section, click **Search Gallery**
3. Search for "Firebase Analytics WebView Bridge" and select it
4. Click **Add to workspace**

## Configuration

### Google Tag: Settings Variable *(optional)*

Enable this to load shared event parameters and user properties from a Google Tag Settings variable.

- If the same parameter or user property name is set both in the settings variable and in this tag, the value set directly in this tag wins
- Exception: when the value on this tag's side resolves to `undefined`, the settings variable value is kept (the same merge behavior as the standard GA4 event tag)
- If the selected variable does not return an object, it is ignored
- `user_properties` in the variable is not sent as an event parameter — each entry is applied via `setUserProperty` (see [User Properties](#user-properties))
- Web-only `gtag.js` config parameters in the variable are **not** forwarded to Firebase. They control browser-side measurement (cookies, signals, routing) and are meaningless or harmful in an app context, so they are removed: `allow_ad_personalization_signals`, `allow_google_signals`, `client_id`, `cookie_domain`, `cookie_expires`, `cookie_flags`, `cookie_path`, `cookie_prefix`, `cookie_update`, `first_party_collection`, `ignore_referrer`, `send_page_view`, `server_container_url`, `transport_url`, `update` ([GA4 config reference](https://developers.google.com/analytics/devguides/collection/ga4/reference/config))

### Event Name

The Firebase Analytics event name (e.g. `screen_view`, `purchase`).

- Must start with a letter
- Only letters, numbers, and underscores allowed
- Max 40 characters
- Leave blank to send user properties only, without logging an event

**Restricted prefixes**: Must not start with `_`, `firebase_`, `ga_`, `google_`, or `gtag.`

https://firebase.google.com/docs/reference/cpp/group/event-names

### Event Parameters

Key-value pairs sent as event parameters. Parameter names follow the same rules as the event name (max 40 characters). Parameter values are truncated to 100 characters if exceeded.

The following key names receive special treatment:

- `items` — cannot be used; use the dedicated **Items (Array Variable)** field instead (rejected in the GTM UI)
- The web-only `gtag.js` config parameters listed in the [settings variable section](#google-tag-settings-variable-optional) — rejected in the GTM UI, and removed at runtime if supplied through a variable
- `user_properties` — not sent as an event parameter. Assign a variable that returns an object, and each entry is applied via `setUserProperty`, the same way as `user_properties` in the settings variable. Entries in the **User Properties** table take precedence over entries supplied this way. Non-object values are skipped

#### Page Parameters (Automatic) *(optional)*

The radio buttons at the top of the **Event Parameters** section control whether page information is added automatically as event parameters:

- `page_location` — the page URL (anything after the `#` character is omitted)
- `page_title` — the page title
- `page_referrer` — the URL of the previous page (equivalent to document.referrer)

The default is **Do not add automatically**.

When set to **Add automatically**:

- If the same parameter name is set in the settings variable or in the event parameters table, that value takes precedence over the automatic one
- Parameters whose value is empty (e.g. `page_referrer` on a page with no referrer) are not sent
- Like all other parameter values, values exceeding 100 characters are truncated (note that `page_location` can easily exceed this limit)

#### Campaign Parameters from UTM (Automatic) *(optional)*

The second set of radio buttons in the **Event Parameters** section controls whether `utm_*` query parameters in the current page URL are added automatically as event parameters. The parameter names are the same as those recorded by the GA4 web tag.

| URL query parameter | Event parameter |
|---|---|
| `utm_source` | `source` |
| `utm_medium` | `medium` |
| `utm_campaign` | `campaign` |
| `utm_id` | `campaign_id` |
| `utm_term` | `term` |
| `utm_content` | `content` |

The default is **Do not add automatically**.

When set to **Add automatically**:

- If the same parameter name is set in the settings variable or in the event parameters table, that value takes precedence over the automatic one
- `utm_*` parameters that are missing from the URL or have an empty value are not sent
- Values exceeding 100 characters are truncated with a warning

**Note**: on app data streams, these are recorded as regular event parameters. They do **not** populate the GA4 traffic acquisition dimensions (session source/medium etc.).

#### Items (Array Variable) *(optional)*

Enable **Send items parameter** to send an `items` array to Firebase (required for e-commerce events such as `purchase`). Select a GTM variable that returns an array of item objects. This dedicated field is provided because the standard event parameters table cannot handle arrays (object and array values are skipped with a warning).

The template converts the `quantity` and `index` fields of each item to integers before passing them to the native interface, because the Firebase Analytics SDK expects them as `Long` (Android) / `Int` (iOS).

If the selected variable returns an empty array or a non-array value, the `items` parameter is not sent and a warning is logged to the console.

#### Native Interface Customization for items

The native interface sample implementations shown in the [official documentation](https://firebase.google.com/docs/analytics/webview#implement-native-interface) cannot process the `items` array as-is. The following customizations are required.

##### Android

The `bundleFromJson` helper in the official sample only handles primitive types (String, Integer, Double). Add `JSONArray` handling so that `items` is correctly converted to a `Bundle[]` array.

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
                // Handle the items array
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

When WKWebView passes a JavaScript number to Swift via `postMessage`, it is always wrapped in an `NSNumber`. If an `NSNumber` backed by a `Double` is passed for fields the Firebase SDK expects as `Int` (`quantity` and `index`), the value may be recorded as `0`. Explicitly convert these integer fields after receiving the message.

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
        // Convert integer fields (quantity, index) to Int to avoid them being
        // passed as Double and recorded as 0
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

### User Properties

Key-value pairs set as Firebase Analytics user properties. Property names must start with a letter, use only letters, numbers, and underscores, and be max 24 characters. Values exceeding 36 characters are automatically truncated.

User properties are merged in the following order, later ones taking precedence: `user_properties` in the settings variable → `user_properties` in the event parameters table → this table.

**Restricted prefixes**: Must not start with `_`, `firebase_`, `ga_`, or `google_`

### Value Type Handling

Event parameter and user property values are checked at runtime before being sent.

| Value type | Behavior |
|---|---|
| string / number | Sent as-is. Numbers set as user property values are converted to strings (the native interfaces only accept string values) |
| boolean | Converted to the string `'true'` / `'false'` |
| object / array / function | Skipped with a warning (for the `items` array, use the dedicated Items field) |
| `undefined` | Treated as "not set" — the settings variable value is kept |
| `null` | Sent as-is, overriding the settings variable value |

## Runtime Behavior

- The Android interface is checked first; if found, it is used
- If the Android interface is not found, the iOS interface is used
- If neither interface is found, the tag does nothing
- Values exceeding the character limits are truncated at runtime

## Recommended Setup 1: Preventing Data from Being Sent to Unintended GA4 Properties

When a web page with this tag is opened inside a third-party app's WebView (e.g. the Facebook app), and that app also implements a similar JavaScript interface with Firebase Analytics, your event data could be sent to the third party's Google Analytics.
To avoid this, we recommend configuring your tag so that it does not fire inside third-party apps, based on your own app's User-Agent string or similar signals.

(Note: due to GTM sandbox restrictions, User-Agent–based restriction inside the template itself is not supported.)

Use the following example as a reference.

### Create a Variable: "cjs - Official App Verification"

This variable returns `true` when the browser (WebView) User-Agent string contains a specific phrase AND the JavaScript interface is available (i.e. data can be sent to Firebase). Otherwise, it returns `false`.

#### Variable type

Custom JavaScript variable

#### Custom JavaScript

Replace `'INSERT HERE YOUR APP USER AGENT KEY'` with a distinctive string contained in the User-Agent of the app you want to measure.

Based on the User-Agent, the variable checks that the page is running in your app's WebView and that GTM can send events to Firebase. It returns `true` when all conditions are met, and `false` otherwise.

```js
function(){
  var USER_AGENT_KEY = 'INSERT HERE YOUR APP USER AGENT KEY';

  var isAccessFromOfficialApp = navigator.userAgent.indexOf(USER_AGENT_KEY) > -1;
  var isNativeInterfaceAvailable = !!(window.AnalyticsWebInterface || window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.firebase);
  return isNativeInterfaceAvailable && isAccessFromOfficialApp;
}
```

### Create a Trigger: "event - .* - excl. Official App WebView"

This trigger fires when the condition "the page is open inside the target app's WebView AND GTM can send data to Firebase" is NOT met.
Attach it as an exception trigger to the WebView measurement tags created from this template, to prevent events from being sent to an unintended Firebase instance from another app's WebView.

#### Trigger type

Custom Event trigger

#### Event name

```
.*
```

✅ Use regex matching

#### This trigger fires on

Some Custom Events

Fire this trigger when an Event occurs and all of these conditions are true:

`{{cjs - Official App Verification}}` equals `false`

## Recommended Setup 2: Preventing Duplicate Data in GA4

If a standard GA4 tag and a tag created from this template fire at the same time inside a WebView and send data to the same GA4 property, the same user action could be double-counted across the web stream and the app stream. To avoid this, add the following exception trigger to your standard GA4 tags so that they do not fire inside the WebView.

### Create a Variable: "cjs - Official App Verification"

Use the variable created in Recommended Setup 1.

### Create a Trigger: "event - .* - Official App WebView"

This trigger fires when the condition "the page is open inside the target app's WebView AND GTM can send data to Firebase" is met.
Attach it as an exception trigger to your standard GA4 tags, to prevent data from being sent to the GA4 web stream inside the WebView.

#### Trigger type

Custom Event trigger

#### Event name

```
.*
```

✅ Use regex matching

#### This trigger fires on

Some Custom Events

Fire this trigger when an Event occurs and all of these conditions are true:

`{{cjs - Official App Verification}}` equals `true`

## Notes

- This template targets the GTM **Web** container only
- For tags created from this template to work, the GTM Web container must load inside the WebView (some apps are configured so that GTM is not loaded in WebViews)
- Naming rules for event names, parameter names, and user property names are validated in the GTM UI only for values typed directly into the fields. Values supplied through variables bypass this validation (Firebase applies its own limits separately)

## License

Licensed under the [Apache License, Version 2.0](LICENSE).

## Author

[Ayudante, inc.](https://ayudante.jp)
