Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F29B61FF73
	for <lists+linux-can@lfdr.de>; Thu, 16 May 2019 08:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfEPGRi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 16 May 2019 02:17:38 -0400
Received: from mail-eopbgr00081.outbound.protection.outlook.com ([40.107.0.81]:39799
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726464AbfEPGRf (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 16 May 2019 02:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KL3KRRf2t15Oj723EQ9Ucd7Oly9aHNw9CxmEGpLrWFk=;
 b=d1EuX064QL7gLIlAE9SY0sLvrVnJhKwLt8rVpG10YvJLMQ2sLhw6ynove+faVaRdi6m7eKHIzitI1v5kK7S4t1nMLJ4/aj/tA6KWACp7Iw7ghf+TAfXBMVlcJRErdCPwdCf57UycD8ckFu6aLcWFWD2aTasBo0YRPUpOPysi9WE=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2494.eurprd04.prod.outlook.com (10.168.65.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 06:17:30 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::3d45:6b81:13ba:88cf]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::3d45:6b81:13ba:88cf%7]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 06:17:30 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: [PATCH v2 2/2] can: flexcan: make PE clock info conditional
Thread-Topic: [PATCH v2 2/2] can: flexcan: make PE clock info conditional
Thread-Index: AQHVC68KIIbZkHByj0uIdqxCOCTfKQ==
Date:   Thu, 16 May 2019 06:17:30 +0000
Message-ID: <20190516114057.5878-3-pankaj.bansal@nxp.com>
References: <20190516114057.5878-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190516114057.5878-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::15) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d336766c-62f4-4eec-0baf-08d6d9c62d21
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2494;
x-ms-traffictypediagnostic: VI1PR0401MB2494:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR0401MB2494AED0504AE51B962531A9F10A0@VI1PR0401MB2494.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(52116002)(53936002)(99286004)(386003)(102836004)(6506007)(7736002)(50226002)(4326008)(6512007)(26005)(966005)(478600001)(14454004)(316002)(11346002)(44832011)(2616005)(476003)(486006)(446003)(186003)(110136005)(36756003)(8936002)(76176011)(81156014)(68736007)(86362001)(81166006)(2906002)(6436002)(305945005)(8676002)(66946007)(6486002)(6306002)(66066001)(66446008)(66556008)(6116002)(64756008)(66476007)(73956011)(256004)(25786009)(71190400001)(71200400001)(3846002)(1076003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2494;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OcWLTOY5zF1iQ+UdYZ9Yo64thNZx94S4dHrrcfe5Y9vFcfdJgVeD3uW4p/k0Z7zeNPZjLy3R/tIyiNSXXgzUhfHjVQux/6iNG55pglZOnI2V4qowj4NBzNai7Evr4NiZX/ky0dUvBc9IcN9AxUzw9RML+GP8M41Njml2cLZqx5dBT2ExuYX2w89iwwduqopnvAzWvfqpjOjxLup7CuYhKYRy0WKGDg+fc5Y2BMTy8m6oNQLVMlmm4GMW8HRHja4LDvNAFmbr8KuF/hjJVW2BBs5+/n7Qa0eLJYAvk6ej0bs6AIQH0VjkDjipd/Qpn9nokslmEPPCTTYjOjIZaVVGfKLUN6guaM+ciyfDOsXrn9Q1ER6ZoF+B1/xYguVz4qlrZdjBxJhy8dAeIk0bAy/54xmKP8AI+ATIFhQim4ndtOg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d336766c-62f4-4eec-0baf-08d6d9c62d21
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 06:17:30.6869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2494
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

UEUgY2xvY2sgaW5mbyBjYW4gYmUgc2tpcHBlZCBpZiB0aGUgc3luY2hyb25vdXMgY2xvY2tpbmcg
aXMgdG8gYmUgdXNlZA0KaW4gZmxleGNhbi4NCg0KUmVmZXIgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL25ldC9jYW4vZnNsLWZsZXhjYW4udHh0IGZvciBtb3JlDQppbmZvLg0KDQpT
aWduZWQtb2ZmLWJ5OiBQYW5rYWogQmFuc2FsIDxwYW5rYWouYmFuc2FsQG54cC5jb20+DQotLS0N
Cg0KTm90ZXM6DQogICAgRGVwZW5kZW5jaWVzOg0KICAgIFsxXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9wYXRjaHdvcmsvY292ZXIvMTAyNDUzNi8NCiAgICBbMl0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzEwMDE5MTgvDQogICAgDQogICAgVjI6DQogICAgLSBtb2Rp
ZmllZCB0aGUgY2xrX3NyYyA9PSAwIHRvICFjbGtfc3JjDQogICAgLSBtb2RpZmllZCBjaGFuZ2Vz
IGluIGZsZXhjYW5fY2xrc19lbmFibGUNCiAgICAtIEFkZGVkIERlcGVuZGVuY2llcyBpbiBOb3Rl
cw0KDQogZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4uYyB8IDM5ICsrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMTIg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jIGIv
ZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4uYw0KaW5kZXggNWY0MDc1ZDU5OGQwLi4yNDlmYzBhNmY4
NWQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jDQorKysgYi9kcml2ZXJz
L25ldC9jYW4vZmxleGNhbi5jDQpAQCAtNTE1LDIxICs1MTUsMjQgQEAgc3RhdGljIGludCBmbGV4
Y2FuX2Nsa3NfZW5hYmxlKGNvbnN0IHN0cnVjdCBmbGV4Y2FuX3ByaXYgKnByaXYpDQogew0KIAlp
bnQgZXJyOw0KIA0KLQllcnIgPSBjbGtfcHJlcGFyZV9lbmFibGUocHJpdi0+Y2xrX2lwZyk7DQor
CWVyciA9IGNsa19wcmVwYXJlX2VuYWJsZShwcml2LT5jbGtfcGVyKTsNCiAJaWYgKGVycikNCiAJ
CXJldHVybiBlcnI7DQogDQotCWVyciA9IGNsa19wcmVwYXJlX2VuYWJsZShwcml2LT5jbGtfcGVy
KTsNCi0JaWYgKGVycikNCi0JCWNsa19kaXNhYmxlX3VucHJlcGFyZShwcml2LT5jbGtfaXBnKTsN
CisJaWYgKHByaXYtPmNsa19pcGcpIHsNCisJCWVyciA9IGNsa19wcmVwYXJlX2VuYWJsZShwcml2
LT5jbGtfaXBnKTsNCisJCWlmIChlcnIpDQorCQkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHByaXYt
PmNsa19wZXIpOw0KKwl9DQogDQogCXJldHVybiBlcnI7DQogfQ0KIA0KIHN0YXRpYyB2b2lkIGZs
ZXhjYW5fY2xrc19kaXNhYmxlKGNvbnN0IHN0cnVjdCBmbGV4Y2FuX3ByaXYgKnByaXYpDQogew0K
KwlpZiAocHJpdi0+Y2xrX2lwZykNCisJCWNsa19kaXNhYmxlX3VucHJlcGFyZShwcml2LT5jbGtf
aXBnKTsNCiAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHByaXYtPmNsa19wZXIpOw0KLQljbGtfZGlz
YWJsZV91bnByZXBhcmUocHJpdi0+Y2xrX2lwZyk7DQogfQ0KIA0KIHN0YXRpYyBpbmxpbmUgaW50
IGZsZXhjYW5fdHJhbnNjZWl2ZXJfZW5hYmxlKGNvbnN0IHN0cnVjdCBmbGV4Y2FuX3ByaXYgKnBy
aXYpDQpAQCAtMTY4OCwxOCArMTY5MSwzMCBAQCBzdGF0aWMgaW50IGZsZXhjYW5fcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJfQ0KIA0KIAlpZiAoIWNsb2NrX2ZyZXEpIHsN
Ci0JCWNsa19pcGcgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgImlwZyIpOw0KLQkJaWYgKElT
X0VSUihjbGtfaXBnKSkgew0KLQkJCWRldl9lcnIoJnBkZXYtPmRldiwgIm5vIGlwZyBjbG9jayBk
ZWZpbmVkXG4iKTsNCi0JCQlyZXR1cm4gUFRSX0VSUihjbGtfaXBnKTsNCi0JCX0NCi0NCiAJCWNs
a19wZXIgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgInBlciIpOw0KIAkJaWYgKElTX0VSUihj
bGtfcGVyKSkgew0KIAkJCWRldl9lcnIoJnBkZXYtPmRldiwgIm5vIHBlciBjbG9jayBkZWZpbmVk
XG4iKTsNCiAJCQlyZXR1cm4gUFRSX0VSUihjbGtfcGVyKTsNCiAJCX0NCi0JCWNsb2NrX2ZyZXEg
PSBjbGtfZ2V0X3JhdGUoY2xrX3Blcik7DQorDQorCQlpZiAoIWNsa19zcmMpIHsNCisJCQkvLyBv
bmx5IGdldCBvc2NpbGxhdG9yIGNsb2NrIGlmIGFzeW5jaHJvbm91cyBjbG9ja2luZw0KKwkJCS8v
IGlzIHRvIGJlIHVzZWQuDQorCQkJY2xrX2lwZyA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCAi
aXBnIik7DQorCQkJaWYgKElTX0VSUihjbGtfaXBnKSkgew0KKwkJCQlkZXZfZXJyKCZwZGV2LT5k
ZXYsICJubyBpcGcgY2xvY2sgZGVmaW5lZFxuIik7DQorCQkJCXJldHVybiBQVFJfRVJSKGNsa19p
cGcpOw0KKwkJCX0NCisNCisJCQljbG9ja19mcmVxID0gY2xrX2dldF9yYXRlKGNsa19pcGcpOw0K
KwkJCWlmIChjbG9ja19mcmVxID49IGNsa19nZXRfcmF0ZShjbGtfcGVyKSkgew0KKwkJCQlkZXZf
ZXJyKCZwZGV2LT5kZXYsDQorCQkJCQkiUEUgY2xvY2sgc2hvdWxkIGJlIGxlc3MgdGhhbiBDSElc
biIpOw0KKwkJCQlyZXR1cm4gLUVJTlZBTDsNCisJCQl9DQorCQl9IGVsc2Ugew0KKwkJCWNsb2Nr
X2ZyZXEgPSBjbGtfZ2V0X3JhdGUoY2xrX3Blcik7DQorCQl9DQogCX0NCiANCiAJbWVtID0gcGxh
dGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCi0tIA0KMi4xNy4x
DQoNCg==
