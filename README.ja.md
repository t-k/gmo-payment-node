GMO
====
[![NPM version](https://badge.fury.io/js/gmo.png)](http://badge.fury.io/js/gmo)
[![Build Status](https://travis-ci.org/t-k/gmo-payment-node.png)](https://travis-ci.org/t-k/gmo-payment-node)
[![Dependency Status](https://david-dm.org/t-k/gmo-payment-node/status.png)](http://david-dm.org/t-k/gmo-payment-node)

Node.jsからGMOペイメント(PGマルチペイメントサービス)のAPIを扱うためのGemです。

インストール方法
---

```bash
npm install gmo
```

使い方
---

```javascript
var gmo, option, shopApi;

gmo = require("gmo");

shopApi = new gmo.ShopAPI({
  host:      "hoge.mul-pay.jp",
  shop_id:   "shop_id",
  shop_pass: "shop_pass"
});

option = {
  order_id: "order_id",
  job_cd:   "AUTH",
  amount:   "100"
};

shopApi.entryTran(option, function(err, res) {
  if (err) {
    console.log(err);
  }
  if (res) {
    return console.log(res);
  }
});
```
その他のサンプルは<a href="https://github.com/t-k/gmo-payment-node/tree/master/test">test ディレクトリ</a>を参照してください。

Shop API
---

GMO Gemでは、API呼び出しにGMOから与えられたショップID、ショップパスが必要になるAPIをShop APIと定義しています。

Site API
---

API呼び出しにGMOから与えられたショップID、ショップパス、サイトID、サイトパスが必要になるAPI群。

ShopAndSite API
---

API呼び出しにGMOから与えられたサイトID、サイトパスが必要になるAPI。

他の言語での実装
---

* <a href="https://github.com/t-k/gmo-payment-ruby">GMO Payment Ruby</a>

Contributors
---
Patches contributed by [those people](https://github.com/t-k/gmo-payment-node/contributors).
