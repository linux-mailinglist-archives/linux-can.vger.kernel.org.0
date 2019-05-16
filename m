Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E14020118
	for <lists+linux-can@lfdr.de>; Thu, 16 May 2019 10:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEPIMc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 16 May 2019 04:12:32 -0400
Received: from mail-eopbgr40047.outbound.protection.outlook.com ([40.107.4.47]:36739
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbfEPIMc (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 16 May 2019 04:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KL3KRRf2t15Oj723EQ9Ucd7Oly9aHNw9CxmEGpLrWFk=;
 b=T5vh2rtnIrQwg3nLDJ0yQVvE82okTpFXKJzhK6+piZcE68e5wJ2EQZLrkQAZoP5zuh/FC/4P1Y3UKngfkzai8PD8DEelbOB4keFyr9mo5J5ob6a3UybCUX+hvdEg9PfkNgIDL3rkCd578CWziVuvY8MFBmY2FxvdZiYsXZlg+5Q=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2272.eurprd04.prod.outlook.com (10.169.137.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 08:12:27 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::3d45:6b81:13ba:88cf]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::3d45:6b81:13ba:88cf%7]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 08:12:27 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: [PATCH v2 2/2] can: flexcan: make PE clock info conditional
Thread-Topic: [PATCH v2 2/2] can: flexcan: make PE clock info conditional
Thread-Index: AQHVC78ZjcUTF6mrpkaUYyC9hvTQiw==
Date:   Thu, 16 May 2019 08:12:27 +0000
Message-ID: <20190516133556.15872-3-pankaj.bansal@nxp.com>
References: <20190516133556.15872-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190516133556.15872-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::13) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 878bdd18-b1e3-4152-1c6a-08d6d9d63bf1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2272;
x-ms-traffictypediagnostic: VI1PR0401MB2272:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR0401MB2272E8FEB6B15A248B7004EFF10A0@VI1PR0401MB2272.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(136003)(376002)(199004)(189003)(26005)(386003)(6506007)(66066001)(7736002)(486006)(25786009)(102836004)(305945005)(44832011)(76176011)(446003)(52116002)(6486002)(8676002)(81156014)(8936002)(2616005)(476003)(68736007)(1076003)(81166006)(86362001)(316002)(99286004)(11346002)(14454004)(50226002)(5660300002)(186003)(53936002)(64756008)(71190400001)(73956011)(66446008)(66946007)(66556008)(66476007)(256004)(4326008)(6436002)(6306002)(478600001)(966005)(3846002)(6512007)(6116002)(36756003)(71200400001)(2906002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2272;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b/VatOzkOBO/AJ4XlUBT5nlVYv+A4liasCL4orqNLW7eIvDjxMEh5ruHC2cKf9rhO2Pb+gBCWN+rE7K4UDkpqtOEU8/o5nN54RdS0GO6s+uPd2r/+lD4HKDvwaS499ouWWCoe58DbA2fCe7QM5HXZSJqC7dT6a7CrPYTmKV0vIFgNqdjiSqKUDz/MsrZBmzvjHWE1MIl8gIAdUqthYL/XqXFNQXmc0ywHyQOWsKFx4DvlUp/BVTVW4ssRMBbYFaSDyLJc7FPLgGPyQokIwLyCz0BKokgP4hJzH0zazHDcKe6w+8H4gDM2s3195OrWch4m7WQLtWM/4dPF6pMbQFykMn7wdpefppKOjoAOYjb3A7MAGwoBNkMoSH+5/D5O3exIbFosCjW6tq9BntSvreqBQmkY9MNZln3ijOjaj2AUsA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878bdd18-b1e3-4152-1c6a-08d6d9d63bf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 08:12:27.4051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2272
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
