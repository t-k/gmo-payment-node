GMO
====
[![NPM version](https://badge.fury.io/js/gmo.png)](http://badge.fury.io/js/gmo)
[![Build Status](https://travis-ci.org/t-k/gmo-payment-node.png)](https://travis-ci.org/t-k/gmo-payment-node)
[![Dependency Status](https://david-dm.org/t-k/gmo-payment-node/status.png)](http://david-dm.org/t-k/gmo-payment-node)

GMO is a Node.js client library for the GMO Payment Platform, supporting the PG Multi Payment API, exec transactions, register users, and so on.

Installation
---

```bash
npm install gmo
```

Usage
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
More examples are available on <a href="https://github.com/t-k/gmo-payment-node/tree/master/test">test directory</a>.

Shop API
---

In this library, we have defined as "Shop API" an API that requires shop ID and shop password to the API call.

Site API
---

An API that requires site ID and site password to the API call.

ShopAndSite API
---

An API that requires shop ID, shop password, site ID and site password to the API call.

In other languages
---

* <a href="https://github.com/t-k/gmo-payment-ruby">GMO Payment Ruby</a>

Contributors
---
Patches contributed by [those people](https://github.com/t-k/gmo-payment-node/contributors).
