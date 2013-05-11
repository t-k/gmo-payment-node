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

```coffeescript
gmo = require "gmo"

shopApi = new gmo.ShopAPI(
  host: "hoge.mul-pay.jp"
  shop_id: "shop_id"
  shop_pass: "shop_pass"
)

option =
  order_id: "order_id"
  job_cd: "AUTH"
  amount: "100"

shopApi.entryTran option , (err, res) ->
  if err
    console.log err
  if res
    console.log res

```

Contributors
---
Patches contributed by [those people](https://github.com/t-k/gmo-payment-node/contributors).
