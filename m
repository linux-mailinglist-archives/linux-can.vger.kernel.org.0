Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B847B1B01F
	for <lists+linux-can@lfdr.de>; Mon, 13 May 2019 08:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfEMGCy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 May 2019 02:02:54 -0400
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:26791
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726259AbfEMGCy (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 13 May 2019 02:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABHmtw39zTfJb3ZO5p9ireZvQG6VKZx4muSUv+l+5dQ=;
 b=V0pYeihgIqS0cjSVaMVP17xUatMoamUylOggFBJVAy2MW/lZPQILy0V42Ryp1JwQHh0UZAFgg6/tXA5Sp7JqTKxm9FcaeDVjK8uH3MGhrSJ6PGcOKzc5RUCB43c5kzg/zZbor6HZPy4hMBucWEFHXTukJkQEg1MhZE2BoUPuHhk=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2654.eurprd04.prod.outlook.com (10.168.66.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Mon, 13 May 2019 06:02:49 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7%3]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 06:02:49 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH 2/2] arm64: dts: fsl: ls1028a: add flexcan node
Thread-Topic: [PATCH 2/2] arm64: dts: fsl: ls1028a: add flexcan node
Thread-Index: AQHVCVF+qxXKE0JBqU+wKSOu6xIvOg==
Date:   Mon, 13 May 2019 06:02:49 +0000
Message-ID: <20190513112612.11036-3-pankaj.bansal@nxp.com>
References: <20190513112612.11036-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190513112612.11036-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::36) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85610163-11db-4c63-91c5-08d6d768a0c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2654;
x-ms-traffictypediagnostic: VI1PR0401MB2654:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0401MB2654C323607FD592A3F8C7C4F10F0@VI1PR0401MB2654.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(53936002)(86362001)(316002)(386003)(6506007)(1076003)(6486002)(6306002)(6512007)(99286004)(76176011)(44832011)(5660300002)(8676002)(8936002)(81156014)(68736007)(54906003)(110136005)(81166006)(71200400001)(71190400001)(50226002)(52116002)(2616005)(478600001)(66066001)(446003)(73956011)(186003)(476003)(256004)(14444005)(966005)(11346002)(66556008)(2906002)(14454004)(66446008)(66946007)(66476007)(486006)(36756003)(64756008)(6636002)(26005)(3846002)(25786009)(6116002)(7736002)(6436002)(305945005)(102836004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2654;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k4+Kfxd/eXzTVO6kCSkAxAaDUQT6Fx6lpUyZdqtukGWogIjpExGpIuONMv1LwaabajLOw2NbZU0yczSha18ZfuNxbAGXfecJpJejjFSmCspa+G12vqJG3gEdP6jTLOE5AYbF07DYY3/FupYghNJn9Xf0qPDglSl5qaYWXLE79PirtATzSoGW/urJPTCHyJTEf0/EDDwGAQe2MIdRQY7HWekvP86P2JD6R3ygYWyMZgf/DWyLE2EyRII9OGr1HEVhAtXl1kc5PNKNCOQTD2ad0cjH8xrIQTJ0N5gPLS465+FJyINbd2l92xMjFtTQSIg0KmyjqpTks6D5AjFEF3eu1cBUjxo2bBJ9GWUJwTitsJVSusu4n2ae+z+xjq8u+nMhlTax/DtwjK8LVVWuXZJ0ewkWxXW2/5TyaguuU55ozEY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85610163-11db-4c63-91c5-08d6d768a0c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 06:02:49.6434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2654
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

QWRkIGZsZXhjYW4gbm9kZSBpbiBMUzEwMjhBIFNPQyBmaWxlIGFzIHdlbGwgYXMgaW4gUURTIGFu
ZCBSREIgZmlsZXMuDQpUaGUgZGV2aWNlIHRyZWUgYmluZGluZ3MgdXNlZCBjYW4gYmUgcmVmZXJy
ZWQgZnJvbQ0KRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vZnNsLWZs
ZXhjYW4udHh0DQoNClNpZ25lZC1vZmYtYnk6IFBhbmthaiBCYW5zYWwgPHBhbmthai5iYW5zYWxA
bnhwLmNvbT4NCi0tLQ0KDQpOb3RlcyAoZHRzKToNCiAgICBEZXBlbmRlbmNpZXM6DQogICAgLSBo
dHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1jYW4vbXNnMDE1NjIuaHRtbA0KDQog
Li4uL2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRzICAgfCAxMCArKysrKysr
LQ0KIC4uLi9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcmRiLmR0cyAgIHwgMTggKysr
KysrKysrKysrKy0NCiAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kgICAg
ICB8IDIyICsrKysrKysrKysrKysrKysrLQ0KIDMgZmlsZXMgY2hhbmdlZCwgNDcgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXFkcy5kdHMgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRzDQppbmRleCAxNGM3OWY0NjkxZWEuLmMxODk1YmU1ZDUy
MyAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhh
LXFkcy5kdHMNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhh
LXFkcy5kdHMNCkBAIC0yLDcgKzIsNyBAQA0KIC8qDQogICogRGV2aWNlIFRyZWUgZmlsZSBmb3Ig
TlhQIExTMTAyOEEgUURTIEJvYXJkLg0KICAqDQotICogQ29weXJpZ2h0IDIwMTggTlhQDQorICog
Q29weXJpZ2h0IDIwMTgtMjAxOSBOWFANCiAgKg0KICAqIEhhcm5pbmRlciBSYWkgPGhhcm5pbmRl
ci5yYWlAbnhwLmNvbT4NCiAgKg0KQEAgLTM0LDYgKzM0LDE0IEBADQogCX07DQogfTsNCiANCism
Y2FuMCB7DQorCXN0YXR1cyA9ICJva2F5IjsNCit9Ow0KKw0KKyZjYW4xIHsNCisJc3RhdHVzID0g
Im9rYXkiOw0KK307DQorDQogJmR1YXJ0MCB7DQogCXN0YXR1cyA9ICJva2F5IjsNCiB9Ow0KZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXJkYi5k
dHMgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1yZGIuZHRzDQpp
bmRleCBmODZiMDU0YTc0YWUuLjdkYzc1ZDU4NGFkYSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXJkYi5kdHMNCisrKyBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXJkYi5kdHMNCkBAIC0yLDcgKzIsNyBAQA0K
IC8qDQogICogRGV2aWNlIFRyZWUgZmlsZSBmb3IgTlhQIExTMTAyOEEgUkRCIEJvYXJkLg0KICAq
DQotICogQ29weXJpZ2h0IDIwMTggTlhQDQorICogQ29weXJpZ2h0IDIwMTgtMjAxOSBOWFANCiAg
Kg0KICAqIEhhcm5pbmRlciBSYWkgPGhhcm5pbmRlci5yYWlAbnhwLmNvbT4NCiAgKg0KQEAgLTY0
LDYgKzY0LDIyIEBADQogCX07DQogfTsNCiANCismY2FuMCB7DQorCXN0YXR1cyA9ICJva2F5IjsN
CisNCisJY2FuLXRyYW5zY2VpdmVyIHsNCisJCW1heC1iaXRyYXRlID0gPDUwMDAwMDA+Ow0KKwl9
Ow0KK307DQorDQorJmNhbjEgew0KKwlzdGF0dXMgPSAib2theSI7DQorDQorCWNhbi10cmFuc2Nl
aXZlciB7DQorCQltYXgtYml0cmF0ZSA9IDw1MDAwMDAwPjsNCisJfTsNCit9Ow0KKw0KICZkdWFy
dDAgew0KIAlzdGF0dXMgPSAib2theSI7DQogfTsNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaQ0KaW5kZXggMjg5NmJiY2ZhM2JiLi4wMTYxMjFlODZk
NGQgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4
YS5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5k
dHNpDQpAQCAtMiw3ICsyLDcgQEANCiAvKg0KICAqIERldmljZSBUcmVlIEluY2x1ZGUgZmlsZSBm
b3IgTlhQIExheWVyc2NhcGUtMTAyOEEgZmFtaWx5IFNvQy4NCiAgKg0KLSAqIENvcHlyaWdodCAy
MDE4IE5YUA0KKyAqIENvcHlyaWdodCAyMDE4LTIwMTkgTlhQDQogICoNCiAgKiBIYXJuaW5kZXIg
UmFpIDxoYXJuaW5kZXIucmFpQG54cC5jb20+DQogICoNCkBAIC0yMTksNiArMjE5LDI2IEBADQog
CQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCX07DQogDQorCQljYW4wOiBjYW5AMjE4MDAwMCB7
DQorCQkJY29tcGF0aWJsZSA9ICJmc2wsbHMxMDI4YXIxLWZsZXhjYW4iLA0KKwkJCQkgICAgICJm
c2wsbHgyMTYwYXIxLWZsZXhjYW4iOw0KKwkJCXJlZyA9IDwweDAgMHgyMTgwMDAwIDB4MCAweDEw
MDAwPjsNCisJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjEgSVJRX1RZUEVfTEVWRUxfSElHSD47
DQorCQkJY2xvY2tzID0gPCZzeXNjbGs+LCA8JmNsb2NrZ2VuIDQgMT47DQorCQkJY2xvY2stbmFt
ZXMgPSAiaXBnIiwgInBlciI7DQorCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCisJCX07DQorDQor
CQljYW4xOiBjYW5AMjE5MDAwMCB7DQorCQkJY29tcGF0aWJsZSA9ICJmc2wsbHMxMDI4YXIxLWZs
ZXhjYW4iLA0KKwkJCQkgICAgICJmc2wsbHgyMTYwYXIxLWZsZXhjYW4iOw0KKwkJCXJlZyA9IDww
eDAgMHgyMTkwMDAwIDB4MCAweDEwMDAwPjsNCisJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjIg
SVJRX1RZUEVfTEVWRUxfSElHSD47DQorCQkJY2xvY2tzID0gPCZzeXNjbGs+LCA8JmNsb2NrZ2Vu
IDQgMT47DQorCQkJY2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7DQorCQkJc3RhdHVzID0gImRp
c2FibGVkIjsNCisJCX07DQorDQogCQlkdWFydDA6IHNlcmlhbEAyMWMwNTAwIHsNCiAJCQljb21w
YXRpYmxlID0gImZzbCxuczE2NTUwIiwgIm5zMTY1NTBhIjsNCiAJCQlyZWcgPSA8MHgwMCAweDIx
YzA1MDAgMHgwIDB4MTAwPjsNCi0tIA0KMi4xNy4xDQoNCg==
