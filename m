Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 828652C39C
	for <lists+linux-can@lfdr.de>; Tue, 28 May 2019 11:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfE1Jz2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 May 2019 05:55:28 -0400
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:20878
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbfE1Jz1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 28 May 2019 05:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff8G6mNTWTrnCWMd3U+/SBh2DFj7lpLaPsOt521FhiE=;
 b=gNbSg2N8Jc5LU6aq6apnMYzdnYSFvVEgMcd1om4+xbhTQppN4vRCOgJoxT9qAMwrquN6mdydom/8WTF0iFhoREcG9RqU2/kn+qiFbtrPNQTVmYNC0MJekqD91scFB4G/g18lzAZbWVxFeNu1dE4Uld10pC0NVTEnkxOtSsyGigQ=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2541.eurprd04.prod.outlook.com (10.168.62.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Tue, 28 May 2019 09:55:22 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::3d45:6b81:13ba:88cf]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::3d45:6b81:13ba:88cf%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 09:55:21 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: [PATCH v2 1/4] net: can: flexcan: use CAN FD frames for Tx/Rx
Thread-Topic: [PATCH v2 1/4] net: can: flexcan: use CAN FD frames for Tx/Rx
Thread-Index: AQHVFTt2DW/1Ia/ir06eguyJvG1z8A==
Date:   Tue, 28 May 2019 09:55:21 +0000
Message-ID: <20190528151844.14668-2-pankaj.bansal@nxp.com>
References: <20190528151844.14668-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190528151844.14668-1-pankaj.bansal@nxp.com>
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
x-ms-office365-filtering-correlation-id: cadd5c2a-32f0-48fa-4e52-08d6e35298e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0401MB2541;
x-ms-traffictypediagnostic: VI1PR0401MB2541:
x-microsoft-antispam-prvs: <VI1PR0401MB254121F3E08016B248218AAEF11E0@VI1PR0401MB2541.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(476003)(68736007)(486006)(4326008)(186003)(446003)(1076003)(53936002)(6512007)(36756003)(5660300002)(11346002)(316002)(66066001)(76176011)(478600001)(2616005)(26005)(66946007)(73956011)(25786009)(66446008)(66476007)(66556008)(64756008)(14444005)(99286004)(8676002)(81156014)(2906002)(256004)(50226002)(6506007)(81166006)(6116002)(3846002)(110136005)(6486002)(71200400001)(386003)(44832011)(52116002)(305945005)(7736002)(6436002)(102836004)(14454004)(71190400001)(8936002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2541;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vyqgx3DLKXIt/amATktV/KfQTJsvO1VD7AN+OSelF1kaiF+2X+uy8YjYa0kqJ4tiaOgUwpBvsT+wl49BrGjUkVlPvZsz3O1TqKhOh4KAg4x405ld2Maj7Upy0RN4y+EZEOCzCp5fXmqYl3UVxX3UAFTm27q+7Bb3p6pffhp/aPR57dAnGzrg5Hdd+fxiN5BvUV4zBBm8LV+Axo+V7KGTEF0xV6BV0mqrgtsczokCyauPo4wbuHu9mK44WBqdd541f3c0IofIcRO6rUanTvKaT0Nr9aP+Dsppp1RBNwz5nl7vyk1LLh6eLaGBcshgtAq25r7ob+4rxxLoVxFlVg1dD4thgocdQ+Q3RaIFettU32PYvNUTZlZCeONG8YZ7Qxz5WVGsnM40QbOD/ReCp5HnUSzbIVTSJzoIdSaSkcPQYCw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cadd5c2a-32f0-48fa-4e52-08d6e35298e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 09:55:21.8823
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

VXNlIGNhbiBGRCBmcmFtZXMgZm9yIFR4L1J4IG9wZXJhdGlvbnMuIFRoaXMgd291bGQgYmUgbmVl
ZGVkIGluIHVwY29taW5nDQpTT0MgTFgyMTYwQSwgd2hpY2ggc3VwcG9ydHMgQ0FOIEZEIHByb3Rv
Y29sDQoNClNpZ25lZC1vZmYtYnk6IFBhbmthaiBCYW5zYWwgPHBhbmthai5iYW5zYWxAbnhwLmNv
bT4NCi0tLQ0KDQpOb3RlczoNCiAgICBWMjoNCiAgICAtIE5vIGNoYW5nZQ0KDQogZHJpdmVycy9u
ZXQvY2FuL2ZsZXhjYW4uYyAgICAgIHwgMzYgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0NCiBkcml2ZXJzL25ldC9jYW4vcngtb2ZmbG9hZC5jICAgfCAzMiArKysrKysrKysrKysrKysr
KysrKystLS0tLS0tDQogaW5jbHVkZS9saW51eC9jYW4vcngtb2ZmbG9hZC5oIHwgIDYgKysrKyst
DQogMyBmaWxlcyBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMgYi9kcml2ZXJzL25ldC9jYW4v
ZmxleGNhbi5jDQppbmRleCA0NDI1OGNjODcxYjMuLjkzMWVmZmZiOGZhMiAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMNCisrKyBiL2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2Fu
LmMNCkBAIC02MDksMTAgKzYwOSwxMCBAQCBzdGF0aWMgaW50IGZsZXhjYW5fZ2V0X2JlcnJfY291
bnRlcihjb25zdCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LA0KIHN0YXRpYyBuZXRkZXZfdHhfdCBm
bGV4Y2FuX3N0YXJ0X3htaXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5ldF9kZXZpY2Ug
KmRldikNCiB7DQogCWNvbnN0IHN0cnVjdCBmbGV4Y2FuX3ByaXYgKnByaXYgPSBuZXRkZXZfcHJp
dihkZXYpOw0KLQlzdHJ1Y3QgY2FuX2ZyYW1lICpjZiA9IChzdHJ1Y3QgY2FuX2ZyYW1lICopc2ti
LT5kYXRhOw0KKwlzdHJ1Y3QgY2FuZmRfZnJhbWUgKmNmZCA9IChzdHJ1Y3QgY2FuZmRfZnJhbWUg
Kilza2ItPmRhdGE7DQogCXUzMiBjYW5faWQ7DQogCXUzMiBkYXRhOw0KLQl1MzIgY3RybCA9IEZM
RVhDQU5fTUJfQ09ERV9UWF9EQVRBIHwgKGNmLT5jYW5fZGxjIDw8IDE2KTsNCisJdTMyIGN0cmwg
PSBGTEVYQ0FOX01CX0NPREVfVFhfREFUQSB8IChjYW5fbGVuMmRsYyhjZmQtPmxlbikgPDwgMTYp
Ow0KIAlpbnQgaTsNCiANCiAJaWYgKGNhbl9kcm9wcGVkX2ludmFsaWRfc2tiKGRldiwgc2tiKSkN
CkBAIC02MjAsMTggKzYyMCwxOCBAQCBzdGF0aWMgbmV0ZGV2X3R4X3QgZmxleGNhbl9zdGFydF94
bWl0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZQ0KIA0KIAluZXRp
Zl9zdG9wX3F1ZXVlKGRldik7DQogDQotCWlmIChjZi0+Y2FuX2lkICYgQ0FOX0VGRl9GTEFHKSB7
DQotCQljYW5faWQgPSBjZi0+Y2FuX2lkICYgQ0FOX0VGRl9NQVNLOw0KKwlpZiAoY2ZkLT5jYW5f
aWQgJiBDQU5fRUZGX0ZMQUcpIHsNCisJCWNhbl9pZCA9IGNmZC0+Y2FuX2lkICYgQ0FOX0VGRl9N
QVNLOw0KIAkJY3RybCB8PSBGTEVYQ0FOX01CX0NOVF9JREUgfCBGTEVYQ0FOX01CX0NOVF9TUlI7
DQogCX0gZWxzZSB7DQotCQljYW5faWQgPSAoY2YtPmNhbl9pZCAmIENBTl9TRkZfTUFTSykgPDwg
MTg7DQorCQljYW5faWQgPSAoY2ZkLT5jYW5faWQgJiBDQU5fU0ZGX01BU0spIDw8IDE4Ow0KIAl9
DQogDQotCWlmIChjZi0+Y2FuX2lkICYgQ0FOX1JUUl9GTEFHKQ0KKwlpZiAoIWNhbl9pc19jYW5m
ZF9za2Ioc2tiKSAmJiAoY2ZkLT5jYW5faWQgJiBDQU5fUlRSX0ZMQUcpKQ0KIAkJY3RybCB8PSBG
TEVYQ0FOX01CX0NOVF9SVFI7DQogDQotCWZvciAoaSA9IDA7IGkgPCBjZi0+Y2FuX2RsYzsgaSAr
PSBzaXplb2YodTMyKSkgew0KLQkJZGF0YSA9IGJlMzJfdG9fY3B1cCgoX19iZTMyICopJmNmLT5k
YXRhW2ldKTsNCisJZm9yIChpID0gMDsgaSA8IGNhbl9sZW4yZGxjKGNmZC0+bGVuKTsgaSArPSBz
aXplb2YodTMyKSkgew0KKwkJZGF0YSA9IGJlMzJfdG9fY3B1cCgoX19iZTMyICopJmNmZC0+ZGF0
YVtpXSk7DQogCQlwcml2LT53cml0ZShkYXRhLCAmcHJpdi0+dHhfbWItPmRhdGFbaSAvIHNpemVv
Zih1MzIpXSk7DQogCX0NCiANCkBAIC03NjAsMTIgKzc2MCwxMyBAQCBzdGF0aWMgaW5saW5lIHN0
cnVjdCBmbGV4Y2FuX3ByaXYgKnJ4X29mZmxvYWRfdG9fcHJpdihzdHJ1Y3QgY2FuX3J4X29mZmxv
YWQgKm9mZg0KIH0NCiANCiBzdGF0aWMgdW5zaWduZWQgaW50IGZsZXhjYW5fbWFpbGJveF9yZWFk
KHN0cnVjdCBjYW5fcnhfb2ZmbG9hZCAqb2ZmbG9hZCwNCi0JCQkJCSBzdHJ1Y3QgY2FuX2ZyYW1l
ICpjZiwNCisJCQkJCSBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KIAkJCQkJIHUzMiAqdGltZXN0YW1w
LCB1bnNpZ25lZCBpbnQgbikNCiB7DQogCXN0cnVjdCBmbGV4Y2FuX3ByaXYgKnByaXYgPSByeF9v
ZmZsb2FkX3RvX3ByaXYob2ZmbG9hZCk7DQogCXN0cnVjdCBmbGV4Y2FuX3JlZ3MgX19pb21lbSAq
cmVncyA9IHByaXYtPnJlZ3M7DQogCXN0cnVjdCBmbGV4Y2FuX21iIF9faW9tZW0gKm1iOw0KKwlz
dHJ1Y3QgY2FuZmRfZnJhbWUgKmNmZCA9IChzdHJ1Y3QgY2FuZmRfZnJhbWUgKilza2ItPmRhdGE7
DQogCXUzMiByZWdfY3RybCwgcmVnX2lkLCByZWdfaWZsYWcxOw0KIAlpbnQgaTsNCiANCkBAIC04
MDIsMTcgKzgwMywyMSBAQCBzdGF0aWMgdW5zaWduZWQgaW50IGZsZXhjYW5fbWFpbGJveF9yZWFk
KHN0cnVjdCBjYW5fcnhfb2ZmbG9hZCAqb2ZmbG9hZCwNCiANCiAJcmVnX2lkID0gcHJpdi0+cmVh
ZCgmbWItPmNhbl9pZCk7DQogCWlmIChyZWdfY3RybCAmIEZMRVhDQU5fTUJfQ05UX0lERSkNCi0J
CWNmLT5jYW5faWQgPSAoKHJlZ19pZCA+PiAwKSAmIENBTl9FRkZfTUFTSykgfCBDQU5fRUZGX0ZM
QUc7DQorCQljZmQtPmNhbl9pZCA9ICgocmVnX2lkID4+IDApICYgQ0FOX0VGRl9NQVNLKSB8IENB
Tl9FRkZfRkxBRzsNCiAJZWxzZQ0KLQkJY2YtPmNhbl9pZCA9IChyZWdfaWQgPj4gMTgpICYgQ0FO
X1NGRl9NQVNLOw0KKwkJY2ZkLT5jYW5faWQgPSAocmVnX2lkID4+IDE4KSAmIENBTl9TRkZfTUFT
SzsNCiANCiAJaWYgKHJlZ19jdHJsICYgRkxFWENBTl9NQl9DTlRfUlRSKQ0KLQkJY2YtPmNhbl9p
ZCB8PSBDQU5fUlRSX0ZMQUc7DQotCWNmLT5jYW5fZGxjID0gZ2V0X2Nhbl9kbGMoKHJlZ19jdHJs
ID4+IDE2KSAmIDB4Zik7DQorCQljZmQtPmNhbl9pZCB8PSBDQU5fUlRSX0ZMQUc7DQogDQotCWZv
ciAoaSA9IDA7IGkgPCBjZi0+Y2FuX2RsYzsgaSArPSBzaXplb2YodTMyKSkgew0KKwlpZiAoY2Fu
X2lzX2NhbmZkX3NrYihza2IpKQ0KKwkJY2ZkLT5sZW4gPSBjYW5fZGxjMmxlbihnZXRfY2FuZmRf
ZGxjKChyZWdfY3RybCA+PiAxNikgJiAweGYpKTsNCisJZWxzZQ0KKwkJY2ZkLT5sZW4gPSBnZXRf
Y2FuX2RsYygocmVnX2N0cmwgPj4gMTYpICYgMHhmKTsNCisNCisJZm9yIChpID0gMDsgaSA8IGNm
ZC0+bGVuOyBpICs9IHNpemVvZih1MzIpKSB7DQogCQlfX2JlMzIgZGF0YSA9IGNwdV90b19iZTMy
KHByaXYtPnJlYWQoJm1iLT5kYXRhW2kgLyBzaXplb2YodTMyKV0pKTsNCi0JCSooX19iZTMyICop
KGNmLT5kYXRhICsgaSkgPSBkYXRhOw0KKwkJKihfX2JlMzIgKikoY2ZkLT5kYXRhICsgaSkgPSBk
YXRhOw0KIAl9DQogDQogCS8qIG1hcmsgYXMgcmVhZCAqLw0KQEAgLTEyNjIsNiArMTI2Nyw3IEBA
IHN0YXRpYyBpbnQgZmxleGNhbl9vcGVuKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpDQogCXByaXYt
PnJlZ19pbWFzazFfZGVmYXVsdCA9IDA7DQogCXByaXYtPnJlZ19pbWFzazJfZGVmYXVsdCA9IEZM
RVhDQU5fSUZMQUdfTUIocHJpdi0+dHhfbWJfaWR4KTsNCiANCisJcHJpdi0+b2ZmbG9hZC5mZF9l
bmFibGUgPSBmYWxzZTsNCiAJcHJpdi0+b2ZmbG9hZC5tYWlsYm94X3JlYWQgPSBmbGV4Y2FuX21h
aWxib3hfcmVhZDsNCiANCiAJaWYgKHByaXYtPmRldnR5cGVfZGF0YS0+cXVpcmtzICYgRkxFWENB
Tl9RVUlSS19VU0VfT0ZGX1RJTUVTVEFNUCkgew0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nh
bi9yeC1vZmZsb2FkLmMgYi9kcml2ZXJzL25ldC9jYW4vcngtb2ZmbG9hZC5jDQppbmRleCAyY2U0
ZmE4Njk4YzcuLjU1NmIyODBhYTQ2YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9yeC1v
ZmZsb2FkLmMNCisrKyBiL2RyaXZlcnMvbmV0L2Nhbi9yeC1vZmZsb2FkLmMNCkBAIC01NSwxMSAr
NTUsMTEgQEAgc3RhdGljIGludCBjYW5fcnhfb2ZmbG9hZF9uYXBpX3BvbGwoc3RydWN0IG5hcGlf
c3RydWN0ICpuYXBpLCBpbnQgcXVvdGEpDQogDQogCXdoaWxlICgod29ya19kb25lIDwgcXVvdGEp
ICYmDQogCSAgICAgICAoc2tiID0gc2tiX2RlcXVldWUoJm9mZmxvYWQtPnNrYl9xdWV1ZSkpKSB7
DQotCQlzdHJ1Y3QgY2FuX2ZyYW1lICpjZiA9IChzdHJ1Y3QgY2FuX2ZyYW1lICopc2tiLT5kYXRh
Ow0KKwkJc3RydWN0IGNhbmZkX2ZyYW1lICpjZmQgPSAoc3RydWN0IGNhbmZkX2ZyYW1lICopc2ti
LT5kYXRhOw0KIA0KIAkJd29ya19kb25lKys7DQogCQlzdGF0cy0+cnhfcGFja2V0cysrOw0KLQkJ
c3RhdHMtPnJ4X2J5dGVzICs9IGNmLT5jYW5fZGxjOw0KKwkJc3RhdHMtPnJ4X2J5dGVzICs9IGNm
ZC0+bGVuOw0KIAkJbmV0aWZfcmVjZWl2ZV9za2Ioc2tiKTsNCiAJfQ0KIA0KQEAgLTEyMiwxOSAr
MTIyLDIzIEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqY2FuX3J4X29mZmxvYWRfb2ZmbG9hZF9v
bmUoc3RydWN0IGNhbl9yeF9vZmZsb2FkICpvZmZsb2FkDQogew0KIAlzdHJ1Y3Qgc2tfYnVmZiAq
c2tiID0gTlVMTDsNCiAJc3RydWN0IGNhbl9yeF9vZmZsb2FkX2NiICpjYjsNCi0Jc3RydWN0IGNh
bl9mcmFtZSAqY2Y7DQorCXN0cnVjdCBjYW5mZF9mcmFtZSAqY2ZkOw0KIAlpbnQgcmV0Ow0KIA0K
IAkvKiBJZiBxdWV1ZSBpcyBmdWxsIG9yIHNrYiBub3QgYXZhaWxhYmxlLCByZWFkIHRvIGRpc2Nh
cmQgbWFpbGJveCAqLw0KIAlpZiAobGlrZWx5KHNrYl9xdWV1ZV9sZW4oJm9mZmxvYWQtPnNrYl9x
dWV1ZSkgPD0NCi0JCSAgIG9mZmxvYWQtPnNrYl9xdWV1ZV9sZW5fbWF4KSkNCi0JCXNrYiA9IGFs
bG9jX2Nhbl9za2Iob2ZmbG9hZC0+ZGV2LCAmY2YpOw0KKwkJICAgb2ZmbG9hZC0+c2tiX3F1ZXVl
X2xlbl9tYXgpKSB7DQorCQlpZiAob2ZmbG9hZC0+ZmRfZW5hYmxlKQ0KKwkJCXNrYiA9IGFsbG9j
X2NhbmZkX3NrYihvZmZsb2FkLT5kZXYsICZjZmQpOw0KKwkJZWxzZQ0KKwkJCXNrYiA9IGFsbG9j
X2Nhbl9za2Iob2ZmbG9hZC0+ZGV2LA0KKwkJCQkJICAgIChzdHJ1Y3QgY2FuX2ZyYW1lICoqKSZj
ZmQpOw0KKwl9DQogDQogCWlmICghc2tiKSB7DQotCQlzdHJ1Y3QgY2FuX2ZyYW1lIGNmX292ZXJm
bG93Ow0KIAkJdTMyIHRpbWVzdGFtcDsNCiANCi0JCXJldCA9IG9mZmxvYWQtPm1haWxib3hfcmVh
ZChvZmZsb2FkLCAmY2Zfb3ZlcmZsb3csDQorCQlyZXQgPSBvZmZsb2FkLT5tYWlsYm94X3JlYWQo
b2ZmbG9hZCwgb2ZmbG9hZC0+c2tiX292ZXJmbG93LA0KIAkJCQkJICAgICZ0aW1lc3RhbXAsIG4p
Ow0KIAkJaWYgKHJldCkNCiAJCQlvZmZsb2FkLT5kZXYtPnN0YXRzLnJ4X2Ryb3BwZWQrKzsNCkBA
IC0xNDMsNyArMTQ3LDcgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpjYW5fcnhfb2ZmbG9hZF9v
ZmZsb2FkX29uZShzdHJ1Y3QgY2FuX3J4X29mZmxvYWQgKm9mZmxvYWQNCiAJfQ0KIA0KIAljYiA9
IGNhbl9yeF9vZmZsb2FkX2dldF9jYihza2IpOw0KLQlyZXQgPSBvZmZsb2FkLT5tYWlsYm94X3Jl
YWQob2ZmbG9hZCwgY2YsICZjYi0+dGltZXN0YW1wLCBuKTsNCisJcmV0ID0gb2ZmbG9hZC0+bWFp
bGJveF9yZWFkKG9mZmxvYWQsIHNrYiwgJmNiLT50aW1lc3RhbXAsIG4pOw0KIAlpZiAoIXJldCkg
ew0KIAkJa2ZyZWVfc2tiKHNrYik7DQogCQlyZXR1cm4gTlVMTDsNCkBAIC0yNzMsNiArMjc3LDgg
QEAgRVhQT1JUX1NZTUJPTF9HUEwoY2FuX3J4X29mZmxvYWRfcXVldWVfdGFpbCk7DQogDQogc3Rh
dGljIGludCBjYW5fcnhfb2ZmbG9hZF9pbml0X3F1ZXVlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYs
IHN0cnVjdCBjYW5fcnhfb2ZmbG9hZCAqb2ZmbG9hZCwgdW5zaWduZWQgaW50IHdlaWdodCkNCiB7
DQorCXN0cnVjdCBjYW5mZF9mcmFtZSAqY2ZkOw0KKw0KIAlvZmZsb2FkLT5kZXYgPSBkZXY7DQog
DQogCS8qIExpbWl0IHF1ZXVlIGxlbiB0byA0eCB0aGUgd2VpZ2h0IChyb3VudGVkIHRvIG5leHQg
cG93ZXIgb2YgdHdvKSAqLw0KQEAgLTI4Niw2ICsyOTIsMTUgQEAgc3RhdGljIGludCBjYW5fcnhf
b2ZmbG9hZF9pbml0X3F1ZXVlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIHN0cnVjdCBjYW5fcnhf
b2ZmbG8NCiAJZGV2X2RiZyhkZXYtPmRldi5wYXJlbnQsICIlczogc2tiX3F1ZXVlX2xlbl9tYXg9
JWRcbiIsDQogCQlfX2Z1bmNfXywgb2ZmbG9hZC0+c2tiX3F1ZXVlX2xlbl9tYXgpOw0KIA0KKwlp
ZiAob2ZmbG9hZC0+ZmRfZW5hYmxlKQ0KKwkJb2ZmbG9hZC0+c2tiX292ZXJmbG93ID0gYWxsb2Nf
Y2FuZmRfc2tiKG9mZmxvYWQtPmRldiwgJmNmZCk7DQorCWVsc2UNCisJCW9mZmxvYWQtPnNrYl9v
dmVyZmxvdyA9IGFsbG9jX2Nhbl9za2Iob2ZmbG9hZC0+ZGV2LA0KKwkJCQkJCSAgICAgIChzdHJ1
Y3QgY2FuX2ZyYW1lICoqKSZjZmQpOw0KKw0KKwlpZiAodW5saWtlbHkoIW9mZmxvYWQtPnNrYl9v
dmVyZmxvdykpDQorCQlyZXR1cm4gLUVOT01FTTsNCisNCiAJcmV0dXJuIDA7DQogfQ0KIA0KQEAg
LTMyOSw2ICszNDQsNyBAQCB2b2lkIGNhbl9yeF9vZmZsb2FkX2RlbChzdHJ1Y3QgY2FuX3J4X29m
ZmxvYWQgKm9mZmxvYWQpDQogew0KIAluZXRpZl9uYXBpX2RlbCgmb2ZmbG9hZC0+bmFwaSk7DQog
CXNrYl9xdWV1ZV9wdXJnZSgmb2ZmbG9hZC0+c2tiX3F1ZXVlKTsNCisJa2ZyZWVfc2tiKG9mZmxv
YWQtPnNrYl9vdmVyZmxvdyk7DQogfQ0KIEVYUE9SVF9TWU1CT0xfR1BMKGNhbl9yeF9vZmZsb2Fk
X2RlbCk7DQogDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9jYW4vcngtb2ZmbG9hZC5oIGIv
aW5jbHVkZS9saW51eC9jYW4vcngtb2ZmbG9hZC5oDQppbmRleCA4MjY4ODExYTY5N2UuLmQwMWVi
MzU2NjkyYyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvY2FuL3J4LW9mZmxvYWQuaA0KKysr
IGIvaW5jbHVkZS9saW51eC9jYW4vcngtb2ZmbG9hZC5oDQpAQCAtMjMsMTAgKzIzLDEzIEBADQog
c3RydWN0IGNhbl9yeF9vZmZsb2FkIHsNCiAJc3RydWN0IG5ldF9kZXZpY2UgKmRldjsNCiANCi0J
dW5zaWduZWQgaW50ICgqbWFpbGJveF9yZWFkKShzdHJ1Y3QgY2FuX3J4X29mZmxvYWQgKm9mZmxv
YWQsIHN0cnVjdCBjYW5fZnJhbWUgKmNmLA0KKwl1bnNpZ25lZCBpbnQgKCptYWlsYm94X3JlYWQp
KHN0cnVjdCBjYW5fcnhfb2ZmbG9hZCAqb2ZmbG9hZCwNCisJCQkJICAgICBzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiLA0KIAkJCQkgICAgIHUzMiAqdGltZXN0YW1wLCB1bnNpZ25lZCBpbnQgbWIpOw0KIA0K
IAlzdHJ1Y3Qgc2tfYnVmZl9oZWFkIHNrYl9xdWV1ZTsNCisJc3RydWN0IHNrX2J1ZmYgKnNrYl9v
dmVyZmxvdzsNCisNCiAJdTMyIHNrYl9xdWV1ZV9sZW5fbWF4Ow0KIA0KIAl1bnNpZ25lZCBpbnQg
bWJfZmlyc3Q7DQpAQCAtMzQsNiArMzcsNyBAQCBzdHJ1Y3QgY2FuX3J4X29mZmxvYWQgew0KIA0K
IAlzdHJ1Y3QgbmFwaV9zdHJ1Y3QgbmFwaTsNCiANCisJYm9vbCBmZF9lbmFibGU7DQogCWJvb2wg
aW5jOw0KIH07DQogDQotLSANCjIuMTcuMQ0KDQo=
