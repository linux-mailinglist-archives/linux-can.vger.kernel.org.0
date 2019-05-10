Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2099019A8C
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2019 11:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfEJJYP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 10 May 2019 05:24:15 -0400
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:47012
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727123AbfEJJYO (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 10 May 2019 05:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/SInJLlRzHin2zT3eeoHPNSRHhbIBLG7NP5AY2DSnk=;
 b=oAOMIqefeRteggCSKPX7DEw7Za4y0OEWBxS31Jwr8VuWIIdHLpXXAFdhCoJqEbKynyjifRCtJtaEOuS196cPamnCz6uy46kYOqs2kCmZJTED1B4RzYNeM0AFoVfKGXDXIgQZzCj3CvF+ZpGZRn94JhgXurXS+AY8XBR07q/E5yM=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2318.eurprd04.prod.outlook.com (10.169.132.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Fri, 10 May 2019 09:24:10 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7%3]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 09:24:10 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH 2/2] can: flexcan: make PE clock info conditional
Thread-Topic: [PATCH 2/2] can: flexcan: make PE clock info conditional
Thread-Index: AQHVBxIfe/7hIJRxtUuybsEu5GNWxw==
Date:   Fri, 10 May 2019 09:24:10 +0000
Message-ID: <20190510144724.16447-3-pankaj.bansal@nxp.com>
References: <20190510144724.16447-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190510144724.16447-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYCPR01CA0040.jpnprd01.prod.outlook.com
 (2603:1096:405:1::28) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0a67917-f7e3-413e-5dbc-08d6d529424a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2318;
x-ms-traffictypediagnostic: VI1PR0401MB2318:
x-microsoft-antispam-prvs: <VI1PR0401MB2318D553EB3DED4A449CED0FF10C0@VI1PR0401MB2318.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(5660300002)(4326008)(2906002)(186003)(53936002)(6116002)(102836004)(1076003)(36756003)(478600001)(26005)(11346002)(446003)(2616005)(476003)(6512007)(14454004)(486006)(44832011)(3846002)(25786009)(8676002)(81166006)(81156014)(6436002)(68736007)(6486002)(54906003)(99286004)(8936002)(71190400001)(316002)(86362001)(305945005)(7736002)(50226002)(71200400001)(66476007)(64756008)(66556008)(66446008)(73956011)(76176011)(386003)(6506007)(256004)(66946007)(52116002)(66066001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2318;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oLpfAsD84TYBtu0cRXOQeVzAuAFKjMs3fc/BQ3JCCxJ45Foob7WRmb2gxapFiABDYToyy4/drperDBvv6x2QOhaS+oHX8v4fgIqEIBk8wm//Kc4lHgIv6cFoKrW2w8g/J3CghYfpE0d8sYWwpMdxeapH2LmVtDMC/dmdbhg+sSy+lpUO4/Nkm9n7fR/0MKWYhIbqXMwzz3/zfTOmBhR0Jir/WiKN1mTERvwuaeRCwUzKchHr3ylIVxj1Jim/00xitsbtZAz0gd+CKvFFm1+8x1jQvMP+YZT8q8gqYMPgqReaBJdxHOL2GeSqRlCAuSV/H5f8qed8RE+DcdmoYh5rGKRbpXFcnT6XZqmIYZf09thGotwaYhc9cvOrJ18qhXNniBaSq94XsEO9QU1+uM/8k87BiWPfHqTkTJjdDfbO3yk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a67917-f7e3-413e-5dbc-08d6d529424a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 09:24:10.5161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2318
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

UEUgY2xvY2sgaW5mbyBjYW4gYmUgc2tpcHBlZCBpZiB0aGUgc3luY2hyb25vdXMgY2xvY2tpbmcg
aXMgdG8gYmUgdXNlZA0KaW4gZmxleGNhbi4NCg0KUmVmZXIgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL25ldC9jYW4vZnNsLWZsZXhjYW4udHh0IGZvciBtb3JlDQppbmZvLg0KDQpT
aWduZWQtb2ZmLWJ5OiBQYW5rYWogQmFuc2FsIDxwYW5rYWouYmFuc2FsQG54cC5jb20+DQotLS0N
CiBkcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAxMiBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMgYi9kcml2
ZXJzL25ldC9jYW4vZmxleGNhbi5jDQppbmRleCBlMzUwODNmZjMxZWUuLjE5YWE2NDVmNzAxOCAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMNCisrKyBiL2RyaXZlcnMvbmV0
L2Nhbi9mbGV4Y2FuLmMNCkBAIC00NTIsMjEgKzQ1MiwyNCBAQCBzdGF0aWMgaW50IGZsZXhjYW5f
Y2xrc19lbmFibGUoY29uc3Qgc3RydWN0IGZsZXhjYW5fcHJpdiAqcHJpdikNCiB7DQogCWludCBl
cnI7DQogDQotCWVyciA9IGNsa19wcmVwYXJlX2VuYWJsZShwcml2LT5jbGtfaXBnKTsNCi0JaWYg
KGVycikNCi0JCXJldHVybiBlcnI7DQotDQogCWVyciA9IGNsa19wcmVwYXJlX2VuYWJsZShwcml2
LT5jbGtfcGVyKTsNCiAJaWYgKGVycikNCiAJCWNsa19kaXNhYmxlX3VucHJlcGFyZShwcml2LT5j
bGtfaXBnKTsNCiANCisJaWYgKHByaXYtPmNsa19pcGcpIHsNCisJCWVyciA9IGNsa19wcmVwYXJl
X2VuYWJsZShwcml2LT5jbGtfaXBnKTsNCisJCWlmIChlcnIpDQorCQkJcmV0dXJuIGVycjsNCisJ
fQ0KKw0KIAlyZXR1cm4gZXJyOw0KIH0NCiANCiBzdGF0aWMgdm9pZCBmbGV4Y2FuX2Nsa3NfZGlz
YWJsZShjb25zdCBzdHJ1Y3QgZmxleGNhbl9wcml2ICpwcml2KQ0KIHsNCisJaWYgKHByaXYtPmNs
a19pcGcpDQorCQljbGtfZGlzYWJsZV91bnByZXBhcmUocHJpdi0+Y2xrX2lwZyk7DQogCWNsa19k
aXNhYmxlX3VucHJlcGFyZShwcml2LT5jbGtfcGVyKTsNCi0JY2xrX2Rpc2FibGVfdW5wcmVwYXJl
KHByaXYtPmNsa19pcGcpOw0KIH0NCiANCiBzdGF0aWMgaW5saW5lIGludCBmbGV4Y2FuX3RyYW5z
Y2VpdmVyX2VuYWJsZShjb25zdCBzdHJ1Y3QgZmxleGNhbl9wcml2ICpwcml2KQ0KQEAgLTE1MzEs
MTggKzE1MzQsMzAgQEAgc3RhdGljIGludCBmbGV4Y2FuX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQogCX0NCiANCiAJaWYgKCFjbG9ja19mcmVxKSB7DQotCQljbGtfaXBnID0g
ZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJpcGciKTsNCi0JCWlmIChJU19FUlIoY2xrX2lwZykp
IHsNCi0JCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJubyBpcGcgY2xvY2sgZGVmaW5lZFxuIik7DQot
CQkJcmV0dXJuIFBUUl9FUlIoY2xrX2lwZyk7DQotCQl9DQotDQogCQljbGtfcGVyID0gZGV2bV9j
bGtfZ2V0KCZwZGV2LT5kZXYsICJwZXIiKTsNCiAJCWlmIChJU19FUlIoY2xrX3BlcikpIHsNCiAJ
CQlkZXZfZXJyKCZwZGV2LT5kZXYsICJubyBwZXIgY2xvY2sgZGVmaW5lZFxuIik7DQogCQkJcmV0
dXJuIFBUUl9FUlIoY2xrX3Blcik7DQogCQl9DQotCQljbG9ja19mcmVxID0gY2xrX2dldF9yYXRl
KGNsa19wZXIpOw0KKw0KKwkJaWYgKGNsa19zcmMgPT0gMCkgew0KKwkJCS8vIG9ubHkgZ2V0IG9z
Y2lsbGF0b3IgY2xvY2sgaWYgYXN5bmNocm9ub3VzIGNsb2NraW5nDQorCQkJLy8gaXMgdG8gYmUg
dXNlZC4NCisJCQljbGtfaXBnID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJpcGciKTsNCisJ
CQlpZiAoSVNfRVJSKGNsa19pcGcpKSB7DQorCQkJCWRldl9lcnIoJnBkZXYtPmRldiwgIm5vIGlw
ZyBjbG9jayBkZWZpbmVkXG4iKTsNCisJCQkJcmV0dXJuIFBUUl9FUlIoY2xrX2lwZyk7DQorCQkJ
fQ0KKw0KKwkJCWNsb2NrX2ZyZXEgPSBjbGtfZ2V0X3JhdGUoY2xrX2lwZyk7DQorCQkJaWYgKGNs
b2NrX2ZyZXEgPj0gY2xrX2dldF9yYXRlKGNsa19wZXIpKSB7DQorCQkJCWRldl9lcnIoJnBkZXYt
PmRldiwNCisJCQkJCSJQRSBjbG9jayBzaG91bGQgYmUgbGVzcyB0aGFuIENISVxuIik7DQorCQkJ
CXJldHVybiBQVFJfRVJSKGNsa19pcGcpOw0KKwkJCX0NCisJCX0gZWxzZSB7DQorCQkJY2xvY2tf
ZnJlcSA9IGNsa19nZXRfcmF0ZShjbGtfcGVyKTsNCisJCX0NCiAJfQ0KIA0KIAltZW0gPSBwbGF0
Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KLS0gDQoyLjE3LjEN
Cg0K
