Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1D91B01E
	for <lists+linux-can@lfdr.de>; Mon, 13 May 2019 08:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEMGCw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 May 2019 02:02:52 -0400
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:26791
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726259AbfEMGCw (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 13 May 2019 02:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKhv4k0hZct89q2YhqXJmou4BaPK7CKzb6+Gn/ubcRw=;
 b=kDjFNLK8EdN43nJ37ATB+MihwQeJlGyBzphnBsFZA9hobVxzDbtr44D4ivAulcM90oCGelKj5PiP6Nj2ngxhXuocuwoWpzdBC7F5xYJ/w7F6DZRTOlNCaLjyJbFT7fTfFSW70i17pl47Zji+UD3Z0XhbvLPWbALJmXJFTnLlDRo=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2654.eurprd04.prod.outlook.com (10.168.66.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Mon, 13 May 2019 06:02:48 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7%3]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 06:02:48 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH 1/2] arm64: dts: fsl: lx2160a: add flexcan node
Thread-Topic: [PATCH 1/2] arm64: dts: fsl: lx2160a: add flexcan node
Thread-Index: AQHVCVF9+LNMwm+eXEGY/yAe26EOBg==
Date:   Mon, 13 May 2019 06:02:47 +0000
Message-ID: <20190513112612.11036-2-pankaj.bansal@nxp.com>
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
x-ms-office365-filtering-correlation-id: 0fe3c838-6250-4fe7-dfa4-08d6d7689fa4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2654;
x-ms-traffictypediagnostic: VI1PR0401MB2654:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0401MB265431A979D6916265ACB175F10F0@VI1PR0401MB2654.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(53936002)(86362001)(316002)(386003)(6506007)(1076003)(6486002)(6306002)(6512007)(99286004)(76176011)(44832011)(5660300002)(8676002)(8936002)(81156014)(68736007)(54906003)(110136005)(81166006)(71200400001)(71190400001)(50226002)(52116002)(2616005)(478600001)(66066001)(446003)(73956011)(186003)(476003)(256004)(14444005)(966005)(11346002)(66556008)(2906002)(14454004)(66446008)(66946007)(66476007)(486006)(36756003)(64756008)(6636002)(26005)(3846002)(25786009)(6116002)(7736002)(6436002)(305945005)(102836004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2654;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3mmk6XrfCm/Q96yh5B1mElH1Q8aoL58P1f5hdHD9bCqzm58t/rcQ5n2iUrGXBHRVFXSmEoKPmrRQgvVI0fTvoLZMR6Ss1JoNakgT9LJ3wyJrvKtWuJ26vMrk8qk3TOLfwFTtBu+B8xGPnHY37KdbyolSGs8jngNqGOS3P/m3gPf8+dnF7QyI4sN8MLXwDYyw11wGFun6O3LTcwFK8f9PJ5tWKwj7klE4KfLiUzUHaYAmGuc6zaINYaztqnzxKHW6ChhbUUDpPBaCUlWLmxMAiS3aDBLW9UrYab5WvV68xHHNhgnWlPdZ5pN/tM5+ASvxv1LURm3bdEh7NOph3ofwaHIs5DH17iEcAMoFt1wGftW/gg48x5m3/eHNfHR1X4rbx1UBdFztogvtt3URAf3VEqNj5a4ysMuaj7KSsdW1CKE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe3c838-6250-4fe7-dfa4-08d6d7689fa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 06:02:47.8720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2654
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

QWRkIGZsZXhjYW4gbm9kZSBpbiBMWDIxNjBBIFNPQyBmaWxlIGFzIHdlbGwgYXMgaW4gUURTIGFu
ZCBSREIgZmlsZXMuDQpUaGUgZGV2aWNlIHRyZWUgYmluZGluZ3MgdXNlZCBjYW4gYmUgcmVmZXJy
ZWQgZnJvbQ0KRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vZnNsLWZs
ZXhjYW4udHh0DQoNClNpZ25lZC1vZmYtYnk6IFBhbmthaiBCYW5zYWwgPHBhbmthai5iYW5zYWxA
bnhwLmNvbT4NCi0tLQ0KDQpOb3RlcyAoZHRzKToNCiAgICBEZXBlbmRlbmNpZXM6DQogICAgLSBo
dHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1jYW4vbXNnMDE1NjIuaHRtbA0KDQog
Li4uL2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1xZHMuZHRzICAgfCAxMCArKysrKysr
Ky0NCiAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXJkYi5kdHMgICB8IDE4ICsr
KysrKysrKysrKysrKy0NCiAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kg
ICAgICB8IDIwICsrKysrKysrKysrKysrKysrLQ0KIDMgZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXFkcy5kdHMgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9mc2wtbHgyMTYwYS1xZHMuZHRzDQppbmRleCA5OWEyMmFiYmU3MjUuLjg0OWVkYWMy
N2I2MSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIx
NjBhLXFkcy5kdHMNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIx
NjBhLXFkcy5kdHMNCkBAIC0yLDcgKzIsNyBAQA0KIC8vDQogLy8gRGV2aWNlIFRyZWUgZmlsZSBm
b3IgTFgyMTYwQVFEUw0KIC8vDQotLy8gQ29weXJpZ2h0IDIwMTggTlhQDQorLy8gQ29weXJpZ2h0
IDIwMTgtMjAxOSBOWFANCiANCiAvZHRzLXYxLzsNCiANCkBAIC0zMSw2ICszMSwxNCBAQA0KIAl9
Ow0KIH07DQogDQorJmNhbjAgew0KKwlzdGF0dXMgPSAib2theSI7DQorfTsNCisNCismY2FuMSB7
DQorCXN0YXR1cyA9ICJva2F5IjsNCit9Ow0KKw0KICZjcnlwdG8gew0KIAlzdGF0dXMgPSAib2th
eSI7DQogfTsNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wt
bHgyMTYwYS1yZGIuZHRzIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2
MGEtcmRiLmR0cw0KaW5kZXggOWRmMzdiMTU5NDE1Li45N2NiZTllNjdhYmYgMTAwNjQ0DQotLS0g
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1yZGIuZHRzDQorKysg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1yZGIuZHRzDQpAQCAt
Miw3ICsyLDcgQEANCiAvLw0KIC8vIERldmljZSBUcmVlIGZpbGUgZm9yIExYMjE2MEFSREINCiAv
Lw0KLS8vIENvcHlyaWdodCAyMDE4IE5YUA0KKy8vIENvcHlyaWdodCAyMDE4LTIwMTkgTlhQDQog
DQogL2R0cy12MS87DQogDQpAQCAtMzEsNiArMzEsMjIgQEANCiAJfTsNCiB9Ow0KIA0KKyZjYW4w
IHsNCisJc3RhdHVzID0gIm9rYXkiOw0KKw0KKwljYW4tdHJhbnNjZWl2ZXIgew0KKwkJbWF4LWJp
dHJhdGUgPSA8NTAwMDAwMD47DQorCX07DQorfTsNCisNCismY2FuMSB7DQorCXN0YXR1cyA9ICJv
a2F5IjsNCisNCisJY2FuLXRyYW5zY2VpdmVyIHsNCisJCW1heC1iaXRyYXRlID0gPDUwMDAwMDA+
Ow0KKwl9Ow0KK307DQorDQogJmNyeXB0byB7DQogCXN0YXR1cyA9ICJva2F5IjsNCiB9Ow0KZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpDQppbmRleCBm
ZTg3MjA0ODUwYjUuLjc1YzM1MDkyN2RjMCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kNCkBAIC0yLDcgKzIsNyBAQA0KIC8vDQogLy8gRGV2
aWNlIFRyZWUgSW5jbHVkZSBmaWxlIGZvciBMYXllcnNjYXBlLUxYMjE2MEEgZmFtaWx5IFNvQy4N
CiAvLw0KLS8vIENvcHlyaWdodCAyMDE4IE5YUA0KKy8vIENvcHlyaWdodCAyMDE4LTIwMTkgTlhQ
DQogDQogI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0KICNpbmNsdWRlIDxkdC1i
aW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQpAQCAtNTgxLDYgKzU4MSwy
NCBAQA0KIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQogCQl9Ow0KIA0KKwkJY2FuMDogY2FuQDIx
ODAwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAiZnNsLGx4MjE2MGFyMS1mbGV4Y2FuIjsNCisJCQly
ZWcgPSA8MHgwIDB4MjE4MDAwMCAweDAgMHgxMDAwMD47DQorCQkJaW50ZXJydXB0cyA9IDxHSUNf
U1BJIDIxIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KKwkJCWNsb2NrcyA9IDwmc3lzY2xrPiwgPCZj
bG9ja2dlbiA0IDc+Ow0KKwkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOw0KKwkJCXN0YXR1
cyA9ICJkaXNhYmxlZCI7DQorCQl9Ow0KKw0KKwkJY2FuMTogY2FuQDIxOTAwMDAgew0KKwkJCWNv
bXBhdGlibGUgPSAiZnNsLGx4MjE2MGFyMS1mbGV4Y2FuIjsNCisJCQlyZWcgPSA8MHgwIDB4MjE5
MDAwMCAweDAgMHgxMDAwMD47DQorCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIyIElSUV9UWVBF
X0xFVkVMX0hJR0g+Ow0KKwkJCWNsb2NrcyA9IDwmc3lzY2xrPiwgPCZjbG9ja2dlbiA0IDc+Ow0K
KwkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOw0KKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7
DQorCQl9Ow0KKw0KIAkJdWFydDA6IHNlcmlhbEAyMWMwMDAwIHsNCiAJCQljb21wYXRpYmxlID0g
ImFybSxzYnNhLXVhcnQiLCJhcm0scGwwMTEiOw0KIAkJCXJlZyA9IDwweDAgMHgyMWMwMDAwIDB4
MCAweDEwMDA+Ow0KLS0gDQoyLjE3LjENCg0K
