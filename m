Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B30112C39D
	for <lists+linux-can@lfdr.de>; Tue, 28 May 2019 11:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfE1Jza (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 May 2019 05:55:30 -0400
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:20878
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbfE1Jz3 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 28 May 2019 05:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQh+Yz8aZhVna7IsAlG4lmmRruUn398lPxnX61A40ps=;
 b=pq800XCOZSsNx3RMsJq5HAjahbHSkUfiYTyQepWcnF21TUoCgRoNpnVgXZ4DW6HOrKAOg1Xbx/ou9T/kqdfQ2VpR96jBisAqWNpLpvVX5TNqQkIuSNZKQiBZoMx+bll3hZlUujQD2vgegBWIzeqL93/TeymZbLUviN931RJfDX0=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2541.eurprd04.prod.outlook.com (10.168.62.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Tue, 28 May 2019 09:55:24 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::3d45:6b81:13ba:88cf]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::3d45:6b81:13ba:88cf%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 09:55:24 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: [PATCH v2 2/4] can: flexcan: move can set bititings after module
 control
Thread-Topic: [PATCH v2 2/4] can: flexcan: move can set bititings after module
 control
Thread-Index: AQHVFTt3Wy2IIHfg8k6SPtYVyHXjpw==
Date:   Tue, 28 May 2019 09:55:23 +0000
Message-ID: <20190528151844.14668-3-pankaj.bansal@nxp.com>
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
x-ms-office365-filtering-correlation-id: 6fad4dcb-2fd6-4def-17b6-08d6e35299fc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0401MB2541;
x-ms-traffictypediagnostic: VI1PR0401MB2541:
x-microsoft-antispam-prvs: <VI1PR0401MB2541DAE51E34CAD895303668F11E0@VI1PR0401MB2541.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(476003)(68736007)(486006)(4326008)(186003)(446003)(1076003)(53936002)(6512007)(36756003)(5660300002)(11346002)(4744005)(316002)(66066001)(76176011)(478600001)(2616005)(26005)(66946007)(73956011)(25786009)(66446008)(66476007)(66556008)(64756008)(99286004)(8676002)(81156014)(2906002)(256004)(50226002)(6506007)(81166006)(6116002)(3846002)(110136005)(6486002)(71200400001)(386003)(44832011)(52116002)(305945005)(7736002)(6436002)(102836004)(14454004)(71190400001)(8936002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2541;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5QZleu02TSqm7pkrslUqwaQT2qavakCqlbliH2XiFr4NDwvZKA0q1Yk3eCfXfLZtU7DfHKfHeZZ/G/3wuyzQ8RNZrWl3lD78o1qZ0NSHPBDqJJGxLaK86lYNf7JzYP1fOY+8kOd1/7C3Wao0vXpAUgyPYVPXXfBWTzEHKmYtBoF0ix8RRt/ZhRlOAm1mWwe3dN1sDqfY2RI5ACahZVRGamS8hgt1syndyu+8wVt3S1mLYDaUy3hrTx5Hp/4r1cKtMzPEcswuOenD2VQjXDJYLKZ0iFjzdhUhTiIe5FE7Xd0lHpVb3F25CaB41UOv/1cUiWu7o+rDGniwISoRSlTav6zeN7GH62WCE+Hk6QoFipwXmHEG/4FvvWqmZejLBtVUeiPw+H7bhT4W3P8Jg7g4qrPGkfFMefvXgrAH1z/wMj8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fad4dcb-2fd6-4def-17b6-08d6e35299fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 09:55:24.0211
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

VGhlIGNhbiBiaXRpbWluZ3MgYXJlIGFmZmVjdGVkIGJ5IGJpdHMgc2V0IGluIENBTiBNQ1IgcmVn
aXN0ZXIuDQpUaGVyZWZvcmUsIG1vdmUgdGhlIHNldGJpdGl0aW5ncyBhZnRlciBNQ1IgcmVnaXN0
ZXIgaGFzIGJlZW4gc2V0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBQYW5rYWogQmFuc2FsIDxwYW5rYWou
YmFuc2FsQG54cC5jb20+DQotLS0NCg0KTm90ZXM6DQogICAgVjI6DQogICAgLSBObyBjaGFuZ2UN
Cg0KIGRyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvY2FuL2ZsZXhjYW4uYyBiL2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMNCmluZGV4IDkzMWVm
ZmZiOGZhMi4uZjA5M2Q4YTE1YmIyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvY2FuL2ZsZXhj
YW4uYw0KKysrIGIvZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4uYw0KQEAgLTEwMzQsOCArMTAzNCw2
IEBAIHN0YXRpYyBpbnQgZmxleGNhbl9jaGlwX3N0YXJ0KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYp
DQogCWlmIChlcnIpDQogCQlnb3RvIG91dF9jaGlwX2Rpc2FibGU7DQogDQotCWZsZXhjYW5fc2V0
X2JpdHRpbWluZyhkZXYpOw0KLQ0KIAkvKiBNQ1INCiAJICoNCiAJICogZW5hYmxlIGZyZWV6ZQ0K
QEAgLTEwODMsNiArMTA4MSw4IEBAIHN0YXRpYyBpbnQgZmxleGNhbl9jaGlwX3N0YXJ0KHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYpDQogCW5ldGRldl9kYmcoZGV2LCAiJXM6IHdyaXRpbmcgbWNyPTB4
JTA4eCIsIF9fZnVuY19fLCByZWdfbWNyKTsNCiAJcHJpdi0+d3JpdGUocmVnX21jciwgJnJlZ3Mt
Pm1jcik7DQogDQorCWZsZXhjYW5fc2V0X2JpdHRpbWluZyhkZXYpOw0KKw0KIAkvKiBDVFJMDQog
CSAqDQogCSAqIGRpc2FibGUgdGltZXIgc3luYyBmZWF0dXJlDQotLSANCjIuMTcuMQ0KDQo=
