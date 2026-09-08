___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.

___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Firebase Analytics WebView Bridge",
  "brand": {
    "id": "brand_dummy",
    "displayName": "Ayudante,inc."
  },
  "description": "Sends events and user properties from an in-app WebView to the Firebase Analytics native SDK. Supports the Android (AnalyticsWebInterface) and iOS (webkit.messageHandlers.firebase) native interfaces. Setup instructions: https://firebase.google.com/docs/analytics/webview",
  "categories": ["ANALYTICS"],
  "containerContexts": [
    "WEB"
  ],
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "eventName",
    "displayName": {
      "text": "Event Name",
      "translations": [
        {
          "locale": "ja",
          "text": "イベント名"
        }
      ]
    },
    "simpleValueType": true,
    "valueHint": "screen_view, page_view, view_cart",
    "valueValidators": [
      {
        "type": "STRING_LENGTH",
        "args": [
          0,
          40
        ],
        "errorMessage": "Event name must be 40 characters or fewer"
      },
      {
        "type": "REGEX",
        "args": [
          "^([A-Za-z][A-Za-z0-9_]*)?$"
        ],
        "errorMessage": "Event name must start with a letter and contain only letters, numbers, and underscores (no spaces)"
      },
      {
        "type": "REGEX",
        "args": [
          "^(?!(_|firebase_|ga_|google_|gtag\\.)).*$"
        ],
        "errorMessage": "Event name must not start with \"_\", \"firebase_\", \"ga_\", \"google_\", or \"gtag.\""
      }
    ],
    "help": {
      "text": "Specify the name of the event. Must start with a letter. Only letters, numbers, and underscores allowed (no spaces). Max 40 characters. Must not start with \"_\", \"firebase_\", \"ga_\", \"google_\", or \"gtag.\". Leave blank to log no event and send user properties only. \u003ca href\u003d\"https://support.google.com/analytics/answer/13316687\"\u003eEvent naming rules\u003c/a\u003e",
      "translations": [
        {
          "locale": "ja",
          "text": "イベント名を指定します。英字で始まり、英字・数字・アンダースコアのみ使用できます（スペース不可）。最大40文字。\"_\"・\"firebase_\"・\"ga_\"・\"google_\"・\"gtag.\" で始まる名前は使用できません。空欄にするとイベントは記録せず、ユーザープロパティのみ送信します。 \u003ca href\u003d\"https://support.google.com/analytics/answer/13316687\"\u003eイベント命名規則\u003c/a\u003e"
        }
      ]
    }
  },
  {
    "type": "CHECKBOX",
    "name": "useSettingsVariable",
    "checkboxText": {
      "text": "Use Google Tag Settings Variable",
      "translations": [
        {
          "locale": "ja",
          "text": "Google タグ: 設定変数を使用する"
        }
      ]
    },
    "simpleValueType": true,
    "defaultValue": false
  },
  {
    "type": "SELECT",
    "name": "settingsVariable",
    "displayName": {
      "text": "Google Tag: Settings Variable",
      "translations": [
        {
          "locale": "ja",
          "text": "Google タグ: 設定変数"
        }
      ]
    },
    "macrosInSelect": true,
    "selectItems": [],
    "simpleValueType": true,
    "help": {
      "text": "Select a Google Tag Settings variable to load shared event parameters and user properties. If the same parameter or user property name is set both here and in the variable, the value configured in this tag takes precedence. \"user_properties\" in the variable is applied as user properties. Web-only gtag config parameters (cookie settings etc.) are not forwarded to Firebase.",
      "translations": [
        {
          "locale": "ja",
          "text": "「Google タグ: 設定」変数を選択すると、共通のイベントパラメータとユーザープロパティを読み込みます。このタグ内で直接設定したパラメータ・ユーザープロパティと変数の値が同じ名前の場合は、このタグ内の設定が優先されます。変数内の \"user_properties\" はユーザープロパティとして設定されます。Web 専用の gtag 設定パラメータ（Cookie 設定など）は Firebase へ転送されません。"
        }
      ]
    },
    "enablingConditions": [
      {
        "paramName": "useSettingsVariable",
        "paramValue": true,
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupeventParams",
    "displayName": {
      "text": "Event Parameters",
      "translations": [
        {
          "locale": "ja",
          "text": "イベントパラメータ"
        }
      ]
    },
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "RADIO",
        "name": "autoPageParams",
        "displayName": {
          "text": "Page parameters (page_location / page_title / page_referrer)",
          "translations": [
            {
              "locale": "ja",
              "text": "ページ情報パラメータ（page_location / page_title / page_referrer）"
            }
          ]
        },
        "radioItems": [
          {
            "value": "none",
            "displayValue": "Do not add automatically"
          },
          {
            "value": "auto",
            "displayValue": "Add automatically"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "none",
        "help": {
          "text": "When set to \"Add automatically\", the current page URL without the # fragment (page_location), document title (page_title), and referrer (page_referrer) are added as event parameters. If any of these parameters is also set in the settings variable or in the Event Parameters table, that value takes precedence over the automatic one.",
          "translations": [
            {
              "locale": "ja",
              "text": "「Add automatically（自動的に付与する）」を選ぶと、現在のページURL（page_location、#以降のフラグメントを除く）・ドキュメントタイトル（page_title）・リファラー（page_referrer）をイベントパラメータとして自動付与します。これらのパラメータが設定変数またはイベントパラメータの表でも設定されている場合は、自動付与の値よりそちらが優先されます。"
            }
          ]
        }
      },
      {
        "type": "RADIO",
        "name": "autoUtmParams",
        "displayName": {
          "text": "Event parameters from URL utm_parameters (source / medium / campaign / campaign_id / term / content)",
          "translations": [
            {
              "locale": "ja",
              "text": "URL の utm パラメータをイベントパラメータに反映（source / medium / campaign / campaign_id / term / content）"
            }
          ]
        },
        "radioItems": [
          {
            "value": "none",
            "displayValue": "Do not add automatically"
          },
          {
            "value": "auto",
            "displayValue": "Add automatically"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "none",
        "help": {
          "text": "When set to \"Add automatically\", utm parameters in the current page URL are added as event parameters: utm_source → source, utm_medium → medium, utm_campaign → campaign, utm_id → campaign_id, utm_term → term, utm_content → content. If the same parameter is set in the settings variable or in the Event Parameters table, that value takes precedence. Note: these values are recorded as parameters of this event only, not as session traffic source information — they do not populate the session-scoped dimensions (session source / medium etc.) or the GA4 traffic acquisition reports.",
          "translations": [
            {
              "locale": "ja",
              "text": "「Add automatically（自動的に付与する）」を選ぶと、現在のページURLの utm パラメータをイベントパラメータとして付与します: utm_source → source、utm_medium → medium、utm_campaign → campaign、utm_id → campaign_id、utm_term → term、utm_content → content。同名のパラメータが設定変数またはイベントパラメータの表で設定されている場合はそちらが優先されます。注意: これらの値はセッションの参照元情報としてではなく、このイベント単体のパラメータとして記録されます。セッションスコープのディメンション（セッションのソース / メディアなど）や GA4 の集客（トラフィック獲得）レポートには反映されません。"
            }
          ]
        }
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "eventParams",
        "displayName": "",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": {
              "text": "Event Parameter",
              "translations": [
                {
                  "locale": "ja",
                  "text": "イベント パラメータ"
                }
              ]
            },
            "name": "eventParamKey",
            "type": "TEXT",
            "isUnique": true,
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              },
              {
                "type": "STRING_LENGTH",
                "args": [1, 40],
                "errorMessage": "Parameter name must be 40 characters or fewer"
              },
              {
                "type": "REGEX",
                "args": ["^[A-Za-z][A-Za-z0-9_]*$"],
                "errorMessage": "Parameter name must start with a letter and contain only letters, numbers, and underscores (no spaces)"
              },
              {
                "type": "REGEX",
                "args": ["^(?!(_|firebase_|ga_|google_|gtag\\.)).+$"],
                "errorMessage": "Parameter name must not start with \"_\", \"firebase_\", \"ga_\", \"google_\", or \"gtag.\""
              },
              {
                "type": "REGEX",
                "args": ["^(?!items$).+$"],
                "errorMessage": "\"items\" cannot be used as a parameter name. Use the dedicated \"Items (Array Variable)\" field instead"
              },
              {
                "type": "REGEX",
                "args": ["^(?!(allow_ad_personalization_signals|allow_google_signals|client_id|cookie_domain|cookie_expires|cookie_flags|cookie_path|cookie_prefix|cookie_update|first_party_collection|ignore_referrer|send_page_view|server_container_url|transport_url|update)$).+$"],
                "errorMessage": "This parameter name is a web-only gtag config parameter and cannot be sent to Firebase from a WebView"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": {
              "text": "Value",
              "translations": [
                {
                  "locale": "ja",
                  "text": "値"
                }
              ]
            },
            "name": "eventParamVal",
            "type": "TEXT"
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "useItems",
        "checkboxText": {
          "text": "Send items parameter",
          "translations": [
            {
              "locale": "ja",
              "text": "items パラメータを送信する"
            }
          ]
        },
        "simpleValueType": true,
        "defaultValue": false
      },
      {
        "type": "SELECT",
        "name": "itemsParam",
        "displayName": {
          "text": "Items (Array Variable)",
          "translations": [
            {
              "locale": "ja",
              "text": "Items（商品の配列）"
            }
          ]
        },
        "macrosInSelect": true,
        "selectItems": [],
        "simpleValueType": true,
        "help": {
          "text": "Select a GTM variable that returns an array of item objects, such as a Data Layer Variable that reads \"ecommerce.items\". Sent as the \"items\" parameter (required for ecommerce events such as \"purchase\"). Note: the sample native interface in the Firebase documentation cannot process the items array as-is. <a href=\"https://github.com/Ayudante/gtm-firebase-analytics-webview-bridge/blob/main/README.md#native-interface-customization-for-items\">Required native interface customization</a>",
          "translations": [
            {
              "locale": "ja",
              "text": "アイテムオブジェクトの配列を返す GTM 変数を選択します（例: \"ecommerce.items\" を参照する「データレイヤーの変数」）。\"items\" パラメータとして送信されます（\"purchase\" などの e コマースイベントに必要です）。注意: Firebase 公式ドキュメントのサンプル実装のままでは、ネイティブインターフェースが items 配列を処理できません。<a href=\"https://github.com/Ayudante/gtm-firebase-analytics-webview-bridge/blob/main/README.ja.md#items-を使用するためのネイティブインターフェース-カスタマイズ\">必要なカスタマイズ</a>"
            }
          ]
        },
        "enablingConditions": [
          {
            "paramName": "useItems",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      }
    ],
    "enablingConditions": [
      {
        "paramName": "eventName",
        "paramValue": ".+",
        "type": "PRESENT"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupUserProperties",
    "displayName": {
      "text": "User Properties",
      "translations": [
        {
          "locale": "ja",
          "text": "ユーザー プロパティ"
        }
      ]
    },
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "SIMPLE_TABLE",
        "name": "userProperties",
        "displayName": "",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": {
              "text": "Property Name",
              "translations": [
                {
                  "locale": "ja",
                  "text": "プロパティ名"
                }
              ]
            },
            "name": "userPropertyKey",
            "type": "TEXT",
            "isUnique": true,
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              },
              {
                "type": "STRING_LENGTH",
                "args": [1, 24],
                "errorMessage": "User property name must be 24 characters or fewer"
              },
              {
                "type": "REGEX",
                "args": ["^[A-Za-z][A-Za-z0-9_]*$"],
                "errorMessage": "User property name must start with a letter and contain only letters, numbers, and underscores (no spaces)"
              },
              {
                "type": "REGEX",
                "args": ["^(?!(_|firebase_|ga_|google_)).+$"],
                "errorMessage": "User property name must not start with \"_\", \"firebase_\", \"ga_\", or \"google_\""
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": {
              "text": "Value",
              "translations": [
                {
                  "locale": "ja",
                  "text": "値"
                }
              ]
            },
            "name": "userPropertyVal",
            "type": "TEXT"
          }
        ]
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const logToConsole   = require('logToConsole');
const copyFromWindow = require('copyFromWindow');
const callInWindow   = require('callInWindow');
const makeTableMap   = require('makeTableMap');
const makeString     = require('makeString');
const getUrl         = require('getUrl');
const readTitle      = require('readTitle');
const getReferrerUrl = require('getReferrerUrl');
const getQueryParameters = require('getQueryParameters');
const JSON           = require('JSON');

// Firebase Analytics character limits
// Source: https://support.google.com/analytics/answer/9267744
var MAX_PARAM_VALUE_LENGTH   = 100;
var MAX_USER_PROP_VAL_LENGTH = 36;

function truncate(str, maxLen, label) {
  if (typeof str === 'string' && str.length > maxLen) {
    logToConsole('[FA WebView Bridge] Truncated "' + label + '" from ' + str.length + ' to ' + maxLen + ' chars.');
    return str.substring(0, maxLen);
  }
  return str;
}

// Validate and normalize a parameter or user property value.
// string/number/null → pass through
// boolean → convert to 'true'/'false'
// object (non-null), array, function → log warning and return undefined (skip)
function sanitize(val, label) {
  if (typeof val === 'string') return val;
  if (typeof val === 'number') return val;
  if (typeof val === 'boolean') return val ? 'true' : 'false';
  if (val === null) return null;
  logToConsole('[FA WebView Bridge] "' + label + '" has an unsupported type (' + (typeof val) + '). Skipped.');
  return undefined;
}

// User property values must be strings on the native interfaces:
// Android setUserProperty(String, String) receives null when a JS number is
// passed to a String parameter, and the official iOS sample handler drops
// non-string values via its `as? String` guard. Convert numbers to strings.
function sanitizeUserProp(val, label) {
  var v = sanitize(val, label);
  return (typeof v === 'number') ? makeString(v) : v;
}

// Normalize item object field types to match Firebase Analytics native SDK expectations.
// quantity, index → integer (Long/Int); other numeric fields pass through as-is.
var ITEM_INT_FIELDS = {quantity: true, index: true};

function normalizeItems(items) {
  var normalized = [];
  items.forEach(function(item) {
    var normItem = {};
    for (var key in item) {
      var val = item[key];
      if (ITEM_INT_FIELDS[key] === true && typeof val === 'number') {
        normItem[key] = val | 0;
      } else {
        normItem[key] = val;
      }
    }
    normalized.push(normItem);
  });
  return normalized;
}

function hasFn(path) {
  return (typeof copyFromWindow(path) === 'function');
}

// URL utm query parameters mapped to the GA4 / Firebase campaign
// event parameter names (same keys the GA4 web tag records).
var UTM_PARAM_MAP = {
  utm_source: 'source',
  utm_medium: 'medium',
  utm_campaign: 'campaign',
  utm_id: 'campaign_id',
  utm_term: 'term',
  utm_content: 'content'
};

var ANDROID_LOG_EVENT_FN    = 'AnalyticsWebInterface.logEvent';
var ANDROID_SET_USERPROP_FN = 'AnalyticsWebInterface.setUserProperty';
var IOS_POSTMESSAGE_FN      = 'webkit.messageHandlers.firebase.postMessage';

// Web-only gtag config parameters that control gtag.js behavior (cookies,
// signals, routing, web identifiers) and must not be forwarded to Firebase.
// https://developers.google.com/analytics/devguides/collection/ga4/reference/config
var EXCLUDED_PARAMS = {
  allow_ad_personalization_signals: true,
  allow_google_signals: true,
  client_id: true,
  cookie_domain: true,
  cookie_expires: true,
  cookie_flags: true,
  cookie_path: true,
  cookie_prefix: true,
  cookie_update: true,
  first_party_collection: true,
  ignore_referrer: true,
  send_page_view: true,
  server_container_url: true,
  transport_url: true,
  update: true
};

function isExcludedParam(key) {
  if (EXCLUDED_PARAMS[key] === true) {
    logToConsole('[FA WebView Bridge] "' + key + '" is a web-only gtag config parameter. Removed.');
    return true;
  }
  return false;
}

// Resolve the settings variable once. Warn if it does not return an object.
var settingsVar = null;
if (data.useSettingsVariable) {
  if (typeof data.settingsVariable === 'object' && data.settingsVariable !== null) {
    settingsVar = data.settingsVariable;
  } else {
    logToConsole('[FA WebView Bridge] Settings variable did not return an object. Ignored.');
  }
}

// A user_properties object supplied through the event parameters table.
// Collected while building event params, applied later via setUserProperty.
var tableUserProps = null;

if (data.eventName) {
  var params = {};

  // Lowest priority: automatically collected page parameters.
  // Values set in the settings variable or the event parameters table
  // override these. Empty strings (e.g. no referrer) are not sent.
  if (data.autoPageParams === 'auto') {
    // Auto-collected page_location must not include the URL fragment.
    // Manually configured values are sent as-is.
    var pageLocation = getUrl();
    if (typeof pageLocation === 'string') {
      var hashIndex = pageLocation.indexOf('#');
      if (hashIndex !== -1) {
        pageLocation = pageLocation.substring(0, hashIndex);
      }
    }
    var autoParams = {
      page_location: pageLocation,
      page_title: readTitle(),
      page_referrer: getReferrerUrl()
    };
    for (var autoKey in autoParams) {
      if (typeof autoParams[autoKey] === 'string' && autoParams[autoKey].length > 0) {
        params[autoKey] = truncate(autoParams[autoKey], MAX_PARAM_VALUE_LENGTH, autoKey);
      }
    }
  }

  // Lowest priority: campaign parameters collected from utm query
  // parameters in the current page URL. Same override rules as the
  // automatic page parameters. Missing or empty values are not sent.
  if (data.autoUtmParams === 'auto') {
    for (var utmKey in UTM_PARAM_MAP) {
      var utmVal = getQueryParameters(utmKey);
      var utmParamName = UTM_PARAM_MAP[utmKey];
      if (typeof utmVal === 'string' && utmVal.length > 0) {
        params[utmParamName] = truncate(utmVal, MAX_PARAM_VALUE_LENGTH, utmParamName);
      }
    }
  }

  // Base: settings variable params (lower priority)
  if (settingsVar) {
    for (var settingsKey in settingsVar) {
      if (settingsKey === 'user_properties') continue;
      if (isExcludedParam(settingsKey)) continue;
      var sVal = sanitize(settingsVar[settingsKey], settingsKey);
      if (typeof sVal !== 'undefined') {
        params[settingsKey] = truncate(sVal, MAX_PARAM_VALUE_LENGTH, settingsKey);
      }
    }
  }

  // Override: explicit event params (higher priority)
  // undefined values are treated as "not set" and do not override the settings variable
  var rawParams = data.eventParams ? makeTableMap(data.eventParams, 'eventParamKey', 'eventParamVal') : {};
  for (var paramKey in rawParams) {
    if (isExcludedParam(paramKey)) continue;
    if (paramKey === 'user_properties') {
      var upObj = rawParams[paramKey];
      if (typeof upObj === 'object' && upObj !== null && typeof upObj.length !== 'number') {
        tableUserProps = upObj;
      } else if (typeof upObj !== 'undefined') {
        logToConsole('[FA WebView Bridge] "user_properties" must be an object. Skipped.');
      }
      continue;
    }
    if (typeof rawParams[paramKey] !== 'undefined') {
      var pVal = sanitize(rawParams[paramKey], paramKey);
      if (typeof pVal !== 'undefined') {
        params[paramKey] = truncate(pVal, MAX_PARAM_VALUE_LENGTH, paramKey);
      }
    }
  }

  if (data.useItems && data.itemsParam) {
    if (typeof data.itemsParam === 'object' && data.itemsParam !== null && typeof data.itemsParam.length === 'number') {
      if (data.itemsParam.length > 0) {
        params.items = normalizeItems(data.itemsParam);
      } else {
        logToConsole('[FA WebView Bridge] itemsParam is an empty array. Skipped.');
      }
    } else {
      logToConsole('[FA WebView Bridge] itemsParam is not an array. Skipped.');
    }
  }

  if (hasFn(ANDROID_LOG_EVENT_FN)) {
    logToConsole('[FA WebView Bridge] Call Android interface: logEvent');
    callInWindow(ANDROID_LOG_EVENT_FN, data.eventName, JSON.stringify(params));
  } else if (hasFn(IOS_POSTMESSAGE_FN)) {
    logToConsole('[FA WebView Bridge] Call iOS interface: logEvent');
    callInWindow(IOS_POSTMESSAGE_FN, {command: 'logEvent', name: data.eventName, parameters: params});
  } else {
    logToConsole('[FA WebView Bridge] No logEvent native APIs found.');
  }
}

// Merge user properties, lowest to highest priority:
// settings variable → event parameters table (user_properties key) → User Properties table
var mergedUserProps = {};

if (settingsVar && typeof settingsVar.user_properties === 'object' && settingsVar.user_properties !== null) {
  for (var upSettingsKey in settingsVar.user_properties) {
    var upSVal = sanitizeUserProp(settingsVar.user_properties[upSettingsKey], upSettingsKey);
    if (typeof upSVal !== 'undefined') {
      mergedUserProps[upSettingsKey] = upSVal;
    }
  }
}

if (tableUserProps) {
  for (var tblUpKey in tableUserProps) {
    var tblUpVal = sanitizeUserProp(tableUserProps[tblUpKey], tblUpKey);
    if (typeof tblUpVal !== 'undefined') {
      mergedUserProps[tblUpKey] = tblUpVal;
    }
  }
}

if (data.userProperties) {
  data.userProperties.forEach(function(row) {
    if (typeof row.userPropertyVal !== 'undefined') {
      var upVal = sanitizeUserProp(row.userPropertyVal, row.userPropertyKey);
      if (typeof upVal !== 'undefined') {
        mergedUserProps[row.userPropertyKey] = upVal;
      }
    }
  });
}

var hasUserProps = false;
for (var checkKey in mergedUserProps) { hasUserProps = true; break; }

if (hasUserProps) {
  if (hasFn(ANDROID_SET_USERPROP_FN)) {
    logToConsole('[FA WebView Bridge] Call Android interface: setUserProperty');
    for (var androidUpKey in mergedUserProps) {
      var androidVal = truncate(mergedUserProps[androidUpKey], MAX_USER_PROP_VAL_LENGTH, androidUpKey);
      callInWindow(ANDROID_SET_USERPROP_FN, androidUpKey, androidVal);
    }
  } else if (hasFn(IOS_POSTMESSAGE_FN)) {
    logToConsole('[FA WebView Bridge] Call iOS interface: setUserProperty');
    for (var iosUpKey in mergedUserProps) {
      var iosVal = truncate(mergedUserProps[iosUpKey], MAX_USER_PROP_VAL_LENGTH, iosUpKey);
      callInWindow(IOS_POSTMESSAGE_FN, {command: 'setUserProperty', name: iosUpKey, value: iosVal});
    }
  } else {
    logToConsole('[FA WebView Bridge] No setUserProperty native APIs found.');
  }
}

// Nothing to send: no event name and no user properties resolved from any
// source. Fail the tag so the misconfiguration is visible in preview mode.
if (!data.eventName && !hasUserProps) {
  logToConsole('[FA WebView Bridge] Nothing to send: set an event name or at least one user property.');
  return data.gtmOnFailure();
}

data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "AnalyticsWebInterface.logEvent"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "AnalyticsWebInterface.setUserProperty"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "webkit.messageHandlers.firebase.postMessage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_referrer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_title",
        "versionId": "1"
      },
      "param": []
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: 'Keep settings variable value when event param is undefined (Android)'
  code: |-
    const mockData = {
      eventName: 'purchase',
      useSettingsVariable: true,
      settingsVariable: {currency: 'JPY'},
      eventParams: [{eventParamKey: 'currency', eventParamVal: undefined}]
    };

    mock('makeTableMap', function(tableArr, keyCol, valCol) {
      var result = {};
      tableArr.forEach(function(row) { result[row[keyCol]] = row[valCol]; });
      return result;
    });
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'purchase',
      '{"currency":"JPY"}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Keep settings variable value when user property is undefined (Android)'
  code: |-
    const mockData = {
      useSettingsVariable: true,
      settingsVariable: {
        user_properties: {user_type: 'premium'}
      },
      userProperties: [{userPropertyKey: 'user_type', userPropertyVal: undefined}]
    };

    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.setUserProperty') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.setUserProperty',
      'user_type',
      'premium'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Merge event params from settings variable (Android)'
  code: |-
    const mockData = {
      eventName: 'purchase',
      useSettingsVariable: true,
      settingsVariable: {
        currency: 'JPY',
        user_properties: {user_type: 'member'}
      }
    };

    mock('makeTableMap', function(tableArr, keyCol, valCol) {
      var result = {};
      tableArr.forEach(function(row) { result[row[keyCol]] = row[valCol]; });
      return result;
    });
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'purchase',
      '{"currency":"JPY"}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Explicit param overrides settings variable (Android)'
  code: |-
    const mockData = {
      eventName: 'purchase',
      useSettingsVariable: true,
      settingsVariable: {currency: 'USD'},
      eventParams: [{eventParamKey: 'currency', eventParamVal: 'JPY'}]
    };

    mock('makeTableMap', function(tableArr, keyCol, valCol) {
      var result = {};
      tableArr.forEach(function(row) { result[row[keyCol]] = row[valCol]; });
      return result;
    });
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'purchase',
      '{"currency":"JPY"}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Process user_properties from settings variable (Android)'
  code: |-
    const mockData = {
      useSettingsVariable: true,
      settingsVariable: {
        user_properties: {user_type: 'premium', language: 'ja'}
      }
    };

    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.setUserProperty') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.setUserProperty',
      'user_type',
      'premium'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Table value overrides settings variable user_properties (Android)'
  code: |-
    const mockData = {
      useSettingsVariable: true,
      settingsVariable: {
        user_properties: {user_type: 'free'}
      },
      userProperties: [{userPropertyKey: 'user_type', userPropertyVal: 'premium'}]
    };

    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.setUserProperty') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.setUserProperty',
      'user_type',
      'premium'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'logEvent - Android interface (with params)'
  code: |-
    const mockData = {
      eventName: 'purchase',
      eventParams: [
        {eventParamKey: 'value', eventParamVal: '1000'},
        {eventParamKey: 'currency', eventParamVal: 'JPY'}
      ]
    };

    mock('makeTableMap', function(tableArr, keyCol, valCol) {
      var result = {};
      tableArr.forEach(function(row) { result[row[keyCol]] = row[valCol]; });
      return result;
    });
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'purchase',
      '{"value":"1000","currency":"JPY"}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'logEvent - Android interface (no params)'
  code: |-
    const mockData = {
      eventName: 'page_view'
    };

    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'page_view',
      '{}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'logEvent - iOS interface'
  code: |-
    const mockData = {
      eventName: 'screen_view'
    };

    mock('copyFromWindow', function(key) {
      if (key === 'webkit.messageHandlers.firebase.postMessage') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'webkit.messageHandlers.firebase.postMessage',
      {command: 'logEvent', name: 'screen_view', parameters: {}}
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'logEvent - no native API found'
  code: |-
    const mockData = {
      eventName: 'test_event'
    };

    mock('copyFromWindow', function(key) { return undefined; });

    runCode(mockData);

    assertApi('callInWindow').wasNotCalled();
    assertApi('logToConsole').wasCalledWith('[FA WebView Bridge] No logEvent native APIs found.');
    assertApi('gtmOnSuccess').wasCalled();

- name: 'setUserProperty - Android interface'
  code: |-
    const mockData = {
      userProperties: [
        {userPropertyKey: 'user_type', userPropertyVal: 'premium'},
        {userPropertyKey: 'plan', userPropertyVal: 'annual'}
      ]
    };

    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.setUserProperty') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.setUserProperty',
      'user_type',
      'premium'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'setUserProperty - iOS interface'
  code: |-
    const mockData = {
      userProperties: [{userPropertyKey: 'user_type', userPropertyVal: 'free'}]
    };

    mock('copyFromWindow', function(key) {
      if (key === 'webkit.messageHandlers.firebase.postMessage') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'webkit.messageHandlers.firebase.postMessage',
      {command: 'setUserProperty', name: 'user_type', value: 'free'}
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'setUserProperty - no native API found'
  code: |-
    const mockData = {
      userProperties: [{userPropertyKey: 'user_type', userPropertyVal: 'free'}]
    };

    mock('copyFromWindow', function(key) { return undefined; });

    runCode(mockData);

    assertApi('callInWindow').wasNotCalled();
    assertApi('logToConsole').wasCalledWith('[FA WebView Bridge] No setUserProperty native APIs found.');
    assertApi('gtmOnSuccess').wasCalled();

- name: 'logEvent and setUserProperty called together (Android)'
  code: |-
    const mockData = {
      eventName: 'login',
      userProperties: [{userPropertyKey: 'user_type', userPropertyVal: 'member'}]
    };

    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      if (key === 'AnalyticsWebInterface.setUserProperty') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalled();
    assertApi('gtmOnSuccess').wasCalled();

- name: 'logEvent - truncate param value exceeding 100 chars (Android)'
  code: |-
    var longValue = '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901';
    var expectedValue = longValue.substring(0, 100);

    const mockData = {
      eventName: 'test_event',
      eventParams: [{eventParamKey: 'long_param', eventParamVal: longValue}]
    };

    mock('makeTableMap', function(tableArr, keyCol, valCol) {
      var result = {};
      tableArr.forEach(function(row) { result[row[keyCol]] = row[valCol]; });
      return result;
    });
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'test_event',
      '{"long_param":"' + expectedValue + '"}'
    );
    assertApi('logToConsole').wasCalled();
    assertApi('gtmOnSuccess').wasCalled();

- name: 'setUserProperty - truncate value exceeding 36 chars (Android)'
  code: |-
    var longVal = '1234567890123456789012345678901234567';
    var expectedVal = longVal.substring(0, 36);

    const mockData = {
      userProperties: [{userPropertyKey: 'user_segment', userPropertyVal: longVal}]
    };

    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.setUserProperty') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.setUserProperty',
      'user_segment',
      expectedVal
    );
    assertApi('logToConsole').wasCalled();
    assertApi('gtmOnSuccess').wasCalled();

- name: 'logEvent - send itemsParam as items parameter (Android)'
  code: |-
    const mockItems = [
      {item_id: 'SKU_001', item_name: 'Product A', price: 1000},
      {item_id: 'SKU_002', item_name: 'Product B', price: 2000}
    ];

    const mockData = {
      eventName: 'purchase',
      useItems: true,
      itemsParam: mockItems
    };

    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'purchase',
      '{"items":[{"item_id":"SKU_001","item_name":"Product A","price":1000},{"item_id":"SKU_002","item_name":"Product B","price":2000}]}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'logEvent - skip items and warn when itemsParam is empty array (Android)'
  code: |-
    const mockData = {
      eventName: 'purchase',
      useItems: true,
      itemsParam: []
    };

    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'purchase',
      '{}'
    );
    assertApi('logToConsole').wasCalledWith('[FA WebView Bridge] itemsParam is an empty array. Skipped.');
    assertApi('gtmOnSuccess').wasCalled();

- name: 'logEvent - skip items and warn when itemsParam is not an array (Android)'
  code: |-
    const mockData = {
      eventName: 'purchase',
      useItems: true,
      itemsParam: 'not_an_array'
    };

    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'purchase',
      '{}'
    );
    assertApi('logToConsole').wasCalledWith('[FA WebView Bridge] itemsParam is not an array. Skipped.');
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Convert boolean true to string in event param (Android)'
  code: |-
    const mockData = {
      eventName: 'test_event',
      eventParams: [{eventParamKey: 'is_member', eventParamVal: true}]
    };

    mock('makeTableMap', function(tableArr, keyCol, valCol) {
      var result = {};
      tableArr.forEach(function(row) { result[row[keyCol]] = row[valCol]; });
      return result;
    });
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'test_event',
      '{"is_member":"true"}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Convert boolean false to string in event param (Android)'
  code: |-
    const mockData = {
      eventName: 'test_event',
      eventParams: [{eventParamKey: 'is_member', eventParamVal: false}]
    };

    mock('makeTableMap', function(tableArr, keyCol, valCol) {
      var result = {};
      tableArr.forEach(function(row) { result[row[keyCol]] = row[valCol]; });
      return result;
    });
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'test_event',
      '{"is_member":"false"}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Skip and warn when event param value is an object (Android)'
  code: |-
    const mockData = {
      eventName: 'test_event',
      eventParams: [
        {eventParamKey: 'valid_param', eventParamVal: 'ok'},
        {eventParamKey: 'bad_param', eventParamVal: {key: 'value'}}
      ]
    };

    mock('makeTableMap', function(tableArr, keyCol, valCol) {
      var result = {};
      tableArr.forEach(function(row) { result[row[keyCol]] = row[valCol]; });
      return result;
    });
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'test_event',
      '{"valid_param":"ok"}'
    );
    assertApi('logToConsole').wasCalledWith('[FA WebView Bridge] "bad_param" has an unsupported type (object). Skipped.');
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Convert boolean to string in user property (Android)'
  code: |-
    const mockData = {
      userProperties: [{userPropertyKey: 'is_logged_in', userPropertyVal: true}]
    };

    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.setUserProperty') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.setUserProperty',
      'is_logged_in',
      'true'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Skip and warn when user property value is an object (Android)'
  code: |-
    const mockData = {
      userProperties: [
        {userPropertyKey: 'valid_prop', userPropertyVal: 'ok'},
        {userPropertyKey: 'bad_prop', userPropertyVal: {nested: true}}
      ]
    };

    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.setUserProperty') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.setUserProperty',
      'valid_prop',
      'ok'
    );
    assertApi('logToConsole').wasCalledWith('[FA WebView Bridge] "bad_prop" has an unsupported type (object). Skipped.');
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Skip logEvent when event name is empty'
  code: |-
    const mockData = {
      eventName: '',
      userProperties: [{userPropertyKey: 'user_type', userPropertyVal: 'premium'}]
    };

    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      if (key === 'AnalyticsWebInterface.setUserProperty') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasNotCalledWith(
      'AnalyticsWebInterface.logEvent',
      '',
      '{}'
    );
    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.setUserProperty',
      'user_type',
      'premium'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Fail tag when event name is empty and no user properties'
  code: |-
    const mockData = {
      eventName: '',
      userProperties: []
    };

    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      if (key === 'AnalyticsWebInterface.setUserProperty') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasNotCalled();
    assertApi('gtmOnFailure').wasCalled();
    assertApi('gtmOnSuccess').wasNotCalled();

- name: 'Convert number to string in user property (Android)'
  code: |-
    const mockData = {
      userProperties: [{userPropertyKey: 'visit_count', userPropertyVal: 42}]
    };

    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.setUserProperty') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.setUserProperty',
      'visit_count',
      '42'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Send numeric event param as number (Android)'
  code: |-
    const mockData = {
      eventName: 'purchase',
      eventParams: [{eventParamKey: 'value', eventParamVal: 1000}]
    };

    mock('makeTableMap', function(tableArr, keyCol, valCol) {
      var result = {};
      tableArr.forEach(function(row) { result[row[keyCol]] = row[valCol]; });
      return result;
    });
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'purchase',
      '{"value":1000}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Normalize quantity and index to integers in items (Android)'
  code: |-
    const mockData = {
      eventName: 'purchase',
      useItems: true,
      itemsParam: [{item_id: 'SKU_001', quantity: 2.7, index: 1.9, price: 10.5}]
    };

    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'purchase',
      '{"items":[{"item_id":"SKU_001","quantity":2,"index":1,"price":10.5}]}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Warn when settings variable is not an object (Android)'
  code: |-
    const mockData = {
      eventName: 'page_view',
      useSettingsVariable: true,
      settingsVariable: 'not_an_object'
    };

    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('logToConsole').wasCalledWith('[FA WebView Bridge] Settings variable did not return an object. Ignored.');
    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'page_view',
      '{}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Remove web-only config params from settings variable (Android)'
  code: |-
    const mockData = {
      eventName: 'page_view',
      useSettingsVariable: true,
      settingsVariable: {
        currency: 'JPY',
        allow_google_signals: false,
        cookie_domain: 'auto',
        client_id: '123456.789',
        server_container_url: 'https://sst.example.com'
      }
    };

    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'page_view',
      '{"currency":"JPY"}'
    );
    assertApi('logToConsole').wasCalledWith('[FA WebView Bridge] "client_id" is a web-only gtag config parameter. Removed.');
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Remove web-only config param from event parameters table (Android)'
  code: |-
    const mockData = {
      eventName: 'page_view',
      eventParams: [
        {eventParamKey: 'page_title', eventParamVal: 'Home'},
        {eventParamKey: 'client_id', eventParamVal: '123456.789'}
      ]
    };

    mock('makeTableMap', function(tableArr, keyCol, valCol) {
      var result = {};
      tableArr.forEach(function(row) { result[row[keyCol]] = row[valCol]; });
      return result;
    });
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'page_view',
      '{"page_title":"Home"}'
    );
    assertApi('logToConsole').wasCalledWith('[FA WebView Bridge] "client_id" is a web-only gtag config parameter. Removed.');
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Process user_properties in event parameters table via setUserProperty (Android)'
  code: |-
    const mockData = {
      eventName: 'login',
      eventParams: [
        {eventParamKey: 'method', eventParamVal: 'email'},
        {eventParamKey: 'user_properties', eventParamVal: {user_type: 'premium'}}
      ]
    };

    mock('makeTableMap', function(tableArr, keyCol, valCol) {
      var result = {};
      tableArr.forEach(function(row) { result[row[keyCol]] = row[valCol]; });
      return result;
    });
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      if (key === 'AnalyticsWebInterface.setUserProperty') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'login',
      '{"method":"email"}'
    );
    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.setUserProperty',
      'user_type',
      'premium'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'User Properties table overrides user_properties in event parameters table (Android)'
  code: |-
    const mockData = {
      eventName: 'login',
      eventParams: [
        {eventParamKey: 'user_properties', eventParamVal: {user_type: 'basic'}}
      ],
      userProperties: [{userPropertyKey: 'user_type', userPropertyVal: 'premium'}]
    };

    mock('makeTableMap', function(tableArr, keyCol, valCol) {
      var result = {};
      tableArr.forEach(function(row) { result[row[keyCol]] = row[valCol]; });
      return result;
    });
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      if (key === 'AnalyticsWebInterface.setUserProperty') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.setUserProperty',
      'user_type',
      'premium'
    );
    assertApi('callInWindow').wasNotCalledWith(
      'AnalyticsWebInterface.setUserProperty',
      'user_type',
      'basic'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Auto page params - add page_location, page_title, page_referrer (Android)'
  code: |-
    const mockData = {
      eventName: 'page_view',
      autoPageParams: 'auto'
    };

    mock('getUrl', 'https://example.com/page?q=1');
    mock('readTitle', 'Sample Page');
    mock('getReferrerUrl', 'https://referrer.example.com/');
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'page_view',
      '{"page_location":"https://example.com/page?q=1","page_title":"Sample Page","page_referrer":"https://referrer.example.com/"}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Auto page params - settings variable overrides auto value (Android)'
  code: |-
    const mockData = {
      eventName: 'page_view',
      autoPageParams: 'auto',
      useSettingsVariable: true,
      settingsVariable: {page_title: 'Custom Title'}
    };

    mock('getUrl', 'https://example.com/');
    mock('readTitle', 'Auto Title');
    mock('getReferrerUrl', 'https://referrer.example.com/');
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'page_view',
      '{"page_location":"https://example.com/","page_title":"Custom Title","page_referrer":"https://referrer.example.com/"}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Auto page params - event parameters table overrides auto value (Android)'
  code: |-
    const mockData = {
      eventName: 'page_view',
      autoPageParams: 'auto',
      eventParams: [{eventParamKey: 'page_location', eventParamVal: 'https://override.example.com/'}]
    };

    mock('makeTableMap', function(tableArr, keyCol, valCol) {
      var result = {};
      tableArr.forEach(function(row) { result[row[keyCol]] = row[valCol]; });
      return result;
    });
    mock('getUrl', 'https://example.com/');
    mock('readTitle', 'Auto Title');
    mock('getReferrerUrl', 'https://referrer.example.com/');
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'page_view',
      '{"page_location":"https://override.example.com/","page_title":"Auto Title","page_referrer":"https://referrer.example.com/"}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Auto page params - not added when disabled (Android)'
  code: |-
    const mockData = {
      eventName: 'page_view',
      autoPageParams: 'none'
    };

    mock('getUrl', 'https://example.com/');
    mock('readTitle', 'Sample Page');
    mock('getReferrerUrl', 'https://referrer.example.com/');
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('getUrl').wasNotCalled();
    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'page_view',
      '{}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Auto page params - strip fragment from page_location (Android)'
  code: |-
    const mockData = {
      eventName: 'page_view',
      autoPageParams: 'auto'
    };

    mock('getUrl', 'https://example.com/page?q=1#section-2');
    mock('readTitle', 'Sample Page');
    mock('getReferrerUrl', 'https://referrer.example.com/');
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'page_view',
      '{"page_location":"https://example.com/page?q=1","page_title":"Sample Page","page_referrer":"https://referrer.example.com/"}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Auto page params - skip empty page_referrer (Android)'
  code: |-
    const mockData = {
      eventName: 'page_view',
      autoPageParams: 'auto'
    };

    mock('getUrl', 'https://example.com/');
    mock('readTitle', 'Sample Page');
    mock('getReferrerUrl', '');
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'page_view',
      '{"page_location":"https://example.com/","page_title":"Sample Page"}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Auto utm params - map utm parameters to campaign params (Android)'
  code: |-
    const mockData = {
      eventName: 'page_view',
      autoUtmParams: 'auto'
    };

    const query = {
      utm_source: 'newsletter',
      utm_medium: 'email',
      utm_campaign: 'summer_sale',
      utm_id: 'cid_123',
      utm_term: 'running+shoes',
      utm_content: 'header_link'
    };
    mock('getQueryParameters', function(key) { return query[key]; });
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'page_view',
      '{"source":"newsletter","medium":"email","campaign":"summer_sale","campaign_id":"cid_123","term":"running+shoes","content":"header_link"}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Auto utm params - skip missing and empty utm parameters (Android)'
  code: |-
    const mockData = {
      eventName: 'page_view',
      autoUtmParams: 'auto'
    };

    const query = {
      utm_source: 'newsletter',
      utm_medium: ''
    };
    mock('getQueryParameters', function(key) { return query[key]; });
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'page_view',
      '{"source":"newsletter"}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Auto utm params - settings variable overrides auto value (Android)'
  code: |-
    const mockData = {
      eventName: 'page_view',
      autoUtmParams: 'auto',
      useSettingsVariable: true,
      settingsVariable: {source: 'app_banner'}
    };

    const query = {
      utm_source: 'newsletter',
      utm_medium: 'email'
    };
    mock('getQueryParameters', function(key) { return query[key]; });
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'page_view',
      '{"source":"app_banner","medium":"email"}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Auto utm params - event parameters table overrides auto value (Android)'
  code: |-
    const mockData = {
      eventName: 'page_view',
      autoUtmParams: 'auto',
      eventParams: [{eventParamKey: 'source', eventParamVal: 'custom_source'}]
    };

    mock('makeTableMap', function(tableArr, keyCol, valCol) {
      var result = {};
      tableArr.forEach(function(row) { result[row[keyCol]] = row[valCol]; });
      return result;
    });
    const query = {
      utm_source: 'newsletter',
      utm_medium: 'email'
    };
    mock('getQueryParameters', function(key) { return query[key]; });
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'page_view',
      '{"source":"custom_source","medium":"email"}'
    );
    assertApi('gtmOnSuccess').wasCalled();

- name: 'Auto utm params - not added when disabled (Android)'
  code: |-
    const mockData = {
      eventName: 'page_view',
      autoUtmParams: 'none'
    };

    mock('getQueryParameters', function(key) { return 'should_not_be_used'; });
    mock('copyFromWindow', function(key) {
      if (key === 'AnalyticsWebInterface.logEvent') return function() {};
      return undefined;
    });

    runCode(mockData);

    assertApi('getQueryParameters').wasNotCalled();
    assertApi('callInWindow').wasCalledWith(
      'AnalyticsWebInterface.logEvent',
      'page_view',
      '{}'
    );
    assertApi('gtmOnSuccess').wasCalled();


___NOTES___

Created on 2026/6/29 16:40:28


