Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C85319809
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2019 07:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfEJF2V (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 10 May 2019 01:28:21 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:44257
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbfEJF2V (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 10 May 2019 01:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L26p+xeL0RUz65UHM6PgbCeeBe6p5GSHy7eT3qJrh4g=;
 b=bvnamMylr0w/3U2gvLhUumXCs4k3tRJ8oI0RAGuY7cZhrN7mxDAlSbqG+NAhxNsIFqEmFihZvg/Pda7NAAhHgm6Uj/Q5cK8qgNFe/vw2XX9HqRYS9FvrFkxtcABYdNMsUIJ7m9MgqZVyqZZz/f0n40D3EA7oGaIaPooE1yY6Nzg=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2334.eurprd04.prod.outlook.com (10.169.133.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Fri, 10 May 2019 05:28:17 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7%3]) with mapi id 15.20.1878.019; Fri, 10 May 2019
 05:28:17 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: [PATCH 0/4] net: can: flexcan: can FD Format (FDF) changes
Thread-Topic: [PATCH 0/4] net: can: flexcan: can FD Format (FDF) changes
Thread-Index: AQHVBvEs1Trfh85bgECGnx5+b6LwIg==
Date:   Fri, 10 May 2019 05:28:17 +0000
Message-ID: <20190510105137.27523-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY1PR01CA0149.jpnprd01.prod.outlook.com
 (2603:1096:402:1::25) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6459729a-6e92-41b4-0f0d-08d6d5084e47
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2334;
x-ms-traffictypediagnostic: VI1PR0401MB2334:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0401MB2334F1BD3F49F367F0EEF62EF10C0@VI1PR0401MB2334.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(39860400002)(376002)(189003)(199004)(66556008)(52116002)(66946007)(305945005)(99286004)(66476007)(66446008)(2906002)(7736002)(53936002)(6512007)(6306002)(6486002)(50226002)(966005)(73956011)(256004)(6436002)(71200400001)(71190400001)(66066001)(68736007)(54906003)(110136005)(486006)(186003)(5660300002)(14454004)(44832011)(102836004)(86362001)(6116002)(3846002)(64756008)(81156014)(478600001)(81166006)(386003)(8936002)(316002)(6506007)(4326008)(1076003)(8676002)(26005)(2616005)(36756003)(25786009)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2334;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Imp9n9JMuFb9VePZRL39WNgjSMFZOgV0U0j0dtJeQe0iPzcflN4dj/H+yvTEdQGeB/XMglvHbl1JfzgppOywyLg+ucPhQX11d0pPlnmbYfcQYHoTWVSnZEIG0dekR8uYvO+5XE7kyVWk3GEfBY4hm0eXLzKTUpVJmY+LiQG2wjObwyloHHWke549zQX8pQ2rdshPzwH5gN0OgRsYcGB7plV8KMvJQXXdMZ9gguxZN+VSHsWrWQ+1LitdzPEEKN3CJsrimqZ1psAU8JeEbkOl+XHLsaEpqXyjZosn+402Hpo2SXBzej0LsjJlf0R+sjLX2tGCCraJ3/tciJUpuz3PQEl5L4duvPuI7fu6G0IMPD49qMBXq9Kd3kuhCSUvvsCz3bge4Xdavlv3y5x9ZbJdiIC7y/oM/r/Vslr/lWRPdOk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE69CB8A861C5A4B80AF492F3B93151B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6459729a-6e92-41b4-0f0d-08d6d5084e47
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 05:28:17.5343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2334
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

VGhpcyBpcyBteSBzZWNvbmQgYXR0ZW1wdCB0byBhZGQgRkQgc3VwcG9ydCBpbiBmbGV4Y2FuLiBt
eSBlYXJsaWVyIHBhdGNoZXMNCmNhbiBiZSByZWZlcnJlZCBoZXJlOg0KDQpbMV0gaHR0cHM6Ly93
d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtY2FuL21zZzAwMzQ4Lmh0bWwNCg0KU29tZSBvZiB0
aGUgcGF0Y2hlcyBmcm9tIGFib3ZlIHNlcmllcyBoYXZlIGFscmVhZHkgYmVlbiBtZXJnZWQuDQoN
ClRoZXJlIGhhcyBiZWVuIGEgc2lnbmlmaWNhbnQgY2hhbmdlIGluIGZsZXhjYW4gY29kZSBzaW5j
ZSBpIHNlbnQgYWJvdmUNCnBhdGNoZXMgbmFtZWx5Og0KDQpjb21taXQgY2JmZmFmN2FhMDllICgi
Y2FuOiBmbGV4Y2FuOiBBbHdheXMgdXNlIGxhc3QgbWFpbGJveCBmb3IgVFgiKQ0KDQp3aXRoIHRo
aXMgcGF0Y2gsIHRoZSBmbGV4Y2FuIEZEIHN1cHBvcnRzIGJyZWFrcyAoaWYgb25lIHdlcmUgdG8g
YXBwbHkgdGhlDQphYm92ZSBwYXRjaGVzWzFdKQ0KDQpUbyBmaXggRkQgc3VwcHJ0IHdpdGggYWJv
dmUgcGF0Y2gsIGkgaGF2ZSBhZGRlZCBjaGFuZ2VzIGluIHRoaXMgc2VyaWVzOg0KDQozLzQ6IGNh
bjogZmxleGNhbjogbW9kaWZ5IHRoZSBpbnRlcnJ1cHQgcmVnaXN0ZXIgaGFuZGxpbmcNCg0KVGhl
IHJlc3Qgb2YgdGhlIHBhdGNoZXMgYXJlIGZyb20gb2xkIHBhdGNoIHNlcmllcy4NCg0KQ2M6IFZh
cnVuIFNldGhpIDxWLlNldGhpQG54cC5jb20+DQoNClBhbmthaiBCYW5zYWwgKDQpOg0KICBuZXQ6
IGNhbjogZmxleGNhbjogdXNlIENBTiBGRCBmcmFtZXMgZm9yIFR4L1J4DQogIGNhbjogZmxleGNh
bjogbW92ZSBjYW4gc2V0IGJpdGl0aW5ncyBhZnRlciBtb2R1bGUgY29udHJvbA0KICBjYW46IGZs
ZXhjYW46IG1vZGlmeSB0aGUgaW50ZXJydXB0IHJlZ2lzdGVyIGhhbmRsaW5nDQogIG5ldDogY2Fu
OiBmbGV4Y2FuOiBjYW4gRkQgRm9ybWF0IChGREYpIGNoYW5nZXMNCg0KIGRyaXZlcnMvbmV0L2Nh
bi9mbGV4Y2FuLmMgICAgICB8IDMxNiArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0N
CiBkcml2ZXJzL25ldC9jYW4vcngtb2ZmbG9hZC5jICAgfCAgMzIgKysrLQ0KIGluY2x1ZGUvbGlu
dXgvY2FuL3J4LW9mZmxvYWQuaCB8ICAgNiArLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMjc2IGluc2Vy
dGlvbnMoKyksIDc4IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMTcuMQ0KDQo=
