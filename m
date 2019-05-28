Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1913E2C39B
	for <lists+linux-can@lfdr.de>; Tue, 28 May 2019 11:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfE1JzX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 May 2019 05:55:23 -0400
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:20878
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbfE1JzX (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 28 May 2019 05:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8cWaPdXcxyDt7nZE9kEBsmfK6vw5aEvSKwGvm1DURI=;
 b=EB2TP4GQOe1xnmeSabd7HHz6EX0UlPPOIlz9YJNH/540zW9de6AD8kBOCpxPI/nzk/vgX38vOo9YFvfZuQ5ubIGbIGeLPtMKDPD4o5FDdD5CPZXf3yjJUQLOO2BuWoDXknxM2uy7QppElbnFpRCsJkHYdi/wi7hM9vLm8T1XqQI=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2541.eurprd04.prod.outlook.com (10.168.62.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Tue, 28 May 2019 09:55:20 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::3d45:6b81:13ba:88cf]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::3d45:6b81:13ba:88cf%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 09:55:20 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     Varun Sethi <V.Sethi@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: [PATCH v2 0/4] net: can: flexcan: can FD Format (FDF) changes
Thread-Topic: [PATCH v2 0/4] net: can: flexcan: can FD Format (FDF) changes
Thread-Index: AQHVFTt1d7FuRmnnSUyImA05enXQKw==
Date:   Tue, 28 May 2019 09:55:20 +0000
Message-ID: <20190528151844.14668-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::19) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75526ba2-c4f7-473a-b7de-08d6e3529808
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0401MB2541;
x-ms-traffictypediagnostic: VI1PR0401MB2541:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0401MB25418CAD5EE1A2A651E8A524F11E0@VI1PR0401MB2541.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(476003)(68736007)(486006)(4326008)(186003)(1076003)(53936002)(6512007)(36756003)(5660300002)(316002)(66066001)(478600001)(2616005)(26005)(66946007)(73956011)(25786009)(66446008)(66476007)(66556008)(64756008)(966005)(99286004)(8676002)(81156014)(2906002)(256004)(50226002)(6506007)(81166006)(6116002)(3846002)(110136005)(54906003)(6486002)(6306002)(71200400001)(386003)(44832011)(52116002)(305945005)(7736002)(6436002)(102836004)(14454004)(71190400001)(8936002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2541;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: df3YmL9m/BXfKTGiuS0T0bzCI+W6Li8ukW/V77+CevQ5VPX8BJU34pkSImRZ0HjOzujjfE4GbowyPha2ftVDk/pbWvbYZS363yc8eFqNKM0R7ng+a/v86V3oW2H/vmoqWfwy5um2fLz4/g4dQAQsescdSmoBezvqHtYAOZaQvQ4qTRsPdIndyGabBOJfMdjWaNR2488EUDy3bhQic1TyNf+yBv4tVaQCbWUwW6gPmdOGPd07JeIC+kMPyyVqoYZOl5dN8ZGTMEv6FwC5AykDoly1EhAcpeP2f1aNZ+fk553CQyOI7hwllw6x93mwFyebKNJN6sK9urKMFs8PpB+ovRUSXty0lg304jlpUFEzLjz2Ma8xXdHztRj4XR+6K/MHFw3pZ3MYBjCU/mG4VQ3GfvLudvygDiH+haeL5LsYBGo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51DA84B75C6B2C40A6D2361668ABAEA4@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75526ba2-c4f7-473a-b7de-08d6e3529808
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 09:55:20.0628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pankaj.bansal@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2541
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

VGhpcyBpcyBteSBzZWNvbmQgYXR0ZW1wdCB0byBhZGQgRkQgc3VwcG9ydCBpbiBmbGV4Y2FuLg0K
bXkgZWFybGllciBwYXRjaGVzIGNhbiBiZSByZWZlcnJlZCBoZXJlOg0KDQpbMV0gaHR0cHM6Ly93
d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtY2FuL21zZzAwMzQ4Lmh0bWwNCg0KU29tZSBvZiB0
aGUgcGF0Y2hlcyBmcm9tIGFib3ZlIHNlcmllcyBoYXZlIGFscmVhZHkgYmVlbiBtZXJnZWQuDQoN
ClRoZXJlIGhhcyBiZWVuIGEgc2lnbmlmaWNhbnQgY2hhbmdlIGluIGZsZXhjYW4gY29kZSBzaW5j
ZSBpIHNlbnQNCmFib3ZlIHBhdGNoZXMgbmFtZWx5Og0KDQpjb21taXQgY2JmZmFmN2FhMDllICgi
Y2FuOiBmbGV4Y2FuOiBBbHdheXMgdXNlIGxhc3QgbWFpbGJveCBmb3IgVFgiKQ0KDQp3aXRoIHRo
aXMgcGF0Y2gsIHRoZSBmbGV4Y2FuIEZEIHN1cHBvcnRzIGJyZWFrcw0KKGlmIG9uZSB3ZXJlIHRv
IGFwcGx5IHRoZSBhYm92ZSBwYXRjaGVzWzFdKQ0KDQpUbyBmaXggRkQgc3VwcHJ0IHdpdGggYWJv
dmUgY29tbWl0LCBpIGhhdmUgYWRkZWQgY2hhbmdlcyBpbiB0aGlzIHNlcmllczoNCg0KMy80OiBj
YW46IGZsZXhjYW46IG1vZGlmeSB0aGUgaW50ZXJydXB0IHJlZ2lzdGVyIGhhbmRsaW5nDQoNClRo
ZSByZXN0IG9mIHRoZSBwYXRjaGVzIGFyZSBmcm9tIG9sZCBwYXRjaCBzZXJpZXMuDQoNClYyOg0K
LSBGaXggdGhlIG92ZXJmbG93IHdoZW4gc2V0dGluZyBDQU4gYml0dGltaW5ncyBpbiBDQlQgYW5k
IEZEQ0JUIFJlZ2lzdGVycw0KDQpDYzogVmFydW4gU2V0aGkgPFYuU2V0aGlAbnhwLmNvbT4NCg0K
UGFua2FqIEJhbnNhbCAoNCk6DQogIG5ldDogY2FuOiBmbGV4Y2FuOiB1c2UgQ0FOIEZEIGZyYW1l
cyBmb3IgVHgvUngNCiAgY2FuOiBmbGV4Y2FuOiBtb3ZlIGNhbiBzZXQgYml0aXRpbmdzIGFmdGVy
IG1vZHVsZSBjb250cm9sDQogIGNhbjogZmxleGNhbjogbW9kaWZ5IHRoZSBpbnRlcnJ1cHQgcmVn
aXN0ZXIgaGFuZGxpbmcNCiAgbmV0OiBjYW46IGZsZXhjYW46IGNhbiBGRCBGb3JtYXQgKEZERikg
Y2hhbmdlcw0KDQogZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4uYyAgICAgIHwgMzQyICsrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KIGRyaXZlcnMvbmV0L2Nhbi9yeC1vZmZsb2FkLmMg
ICB8ICAzMiArKy0NCiBpbmNsdWRlL2xpbnV4L2Nhbi9yeC1vZmZsb2FkLmggfCAgIDYgKy0NCiAz
IGZpbGVzIGNoYW5nZWQsIDMwMCBpbnNlcnRpb25zKCspLCA4MCBkZWxldGlvbnMoLSkNCg0KLS0g
DQoyLjE3LjENCg0K
