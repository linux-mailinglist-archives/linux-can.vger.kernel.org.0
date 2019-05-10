Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D42441980B
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2019 07:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfEJF2c (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 10 May 2019 01:28:32 -0400
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:53838
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726561AbfEJF2c (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 10 May 2019 01:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzdT6J4VMYr/6bH3lpMT5F4nMKwo9R17SGcbEncw9vc=;
 b=a35Q/PZsIsloiaR0TC8TOUMUspTBm6eHxmfbRHMKNnRpmTylz0HHc6/TfTS/fHfu3JRDqaEGXYQ5qoGqJietJ9x5XjezGg1+Xb9P3WFogeRRGZq+6zxDMaD/zjfg3Z62/7916Y85f/Oip27JqAGUblQGGGyksdHFMneQ5scOb8Y=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2334.eurprd04.prod.outlook.com (10.169.133.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Fri, 10 May 2019 05:28:23 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7%3]) with mapi id 15.20.1878.019; Fri, 10 May 2019
 05:28:23 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH 2/4] can: flexcan: move can set bititings after module control
Thread-Topic: [PATCH 2/4] can: flexcan: move can set bititings after module
 control
Thread-Index: AQHVBvEvlNHowv7PjUq/OTb5hEI9qQ==
Date:   Fri, 10 May 2019 05:28:23 +0000
Message-ID: <20190510105137.27523-3-pankaj.bansal@nxp.com>
References: <20190510105137.27523-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190510105137.27523-1-pankaj.bansal@nxp.com>
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
x-ms-office365-filtering-correlation-id: 01bda1af-dd16-4a6a-9eb6-08d6d508520d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2334;
x-ms-traffictypediagnostic: VI1PR0401MB2334:
x-microsoft-antispam-prvs: <VI1PR0401MB2334B31B3DADECDD4D204CF2F10C0@VI1PR0401MB2334.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(39860400002)(376002)(189003)(199004)(66556008)(52116002)(66946007)(305945005)(99286004)(66476007)(66446008)(2906002)(7736002)(53936002)(6512007)(6486002)(76176011)(50226002)(73956011)(256004)(6436002)(71200400001)(71190400001)(66066001)(68736007)(54906003)(110136005)(4744005)(486006)(186003)(5660300002)(14454004)(44832011)(102836004)(86362001)(6116002)(3846002)(64756008)(81156014)(478600001)(81166006)(386003)(8936002)(316002)(6506007)(4326008)(1076003)(8676002)(11346002)(446003)(26005)(2616005)(36756003)(25786009)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2334;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xY3Ih+wv/vFX29KVR4kMpnvNrgWGgi0bWZ/XGfrEJUGDDsUMLvv7dMEKERzvFuSwHavf8ZdwYxXugjH1QUnxLiB+MFTy8Jr+EuD1412Zv2NeJVIeVIkIfbH15OijGXVJxn4CtSOfb3zpEcfoRj8YKzZyk7f2/s8R7qhjRXdKlEGWJyaQ7ACkRRECMOfR6RRzMVskTG74CpnI68gr3JTxgU9had32wUMMruvRtV30AzGYTwMWjfsA6l/gQUqmj7VETfMvBKCOeupLNyxFMi7SFK8pYoj2UbTPEoLlSHZ+lIKLAWnHbOuNsqkv2a7iuU0lpOCbdDoxwZVStq7TzLUWMwNLNtaDlmHGlP5LnbEN85MCnkTbHXJL9qzO6c5LlI1X7s+r3IE8gChjvfDtTPuX6gShyuF5j/oz9v6e6rDOA4A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bda1af-dd16-4a6a-9eb6-08d6d508520d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 05:28:23.7987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2334
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

VGhlIGNhbiBiaXRpbWluZ3MgYXJlIGFmZmVjdGVkIGJ5IGJpdHMgc2V0IGluIENBTiBNQ1IgcmVn
aXN0ZXIuDQpUaGVyZWZvcmUsIG1vdmUgdGhlIHNldGJpdGl0aW5ncyBhZnRlciBNQ1IgcmVnaXN0
ZXIgaGFzIGJlZW4gc2V0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBQYW5rYWogQmFuc2FsIDxwYW5rYWou
YmFuc2FsQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jIHwgNCArKy0t
DQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMgYi9kcml2ZXJzL25ldC9jYW4vZmxl
eGNhbi5jDQppbmRleCAyYzVhZDE5NGI1OTMuLjhkMTE1Mzk5OWY0NSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMNCisrKyBiL2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMN
CkBAIC0xMDE1LDggKzEwMTUsNiBAQCBzdGF0aWMgaW50IGZsZXhjYW5fY2hpcF9zdGFydChzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2KQ0KIAlpZiAoZXJyKQ0KIAkJZ290byBvdXRfY2hpcF9kaXNhYmxl
Ow0KIA0KLQlmbGV4Y2FuX3NldF9iaXR0aW1pbmcoZGV2KTsNCi0NCiAJLyogTUNSDQogCSAqDQog
CSAqIGVuYWJsZSBmcmVlemUNCkBAIC0xMDY0LDYgKzEwNjIsOCBAQCBzdGF0aWMgaW50IGZsZXhj
YW5fY2hpcF9zdGFydChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KIAluZXRkZXZfZGJnKGRldiwg
IiVzOiB3cml0aW5nIG1jcj0weCUwOHgiLCBfX2Z1bmNfXywgcmVnX21jcik7DQogCXByaXYtPndy
aXRlKHJlZ19tY3IsICZyZWdzLT5tY3IpOw0KIA0KKwlmbGV4Y2FuX3NldF9iaXR0aW1pbmcoZGV2
KTsNCisNCiAJLyogQ1RSTA0KIAkgKg0KIAkgKiBkaXNhYmxlIHRpbWVyIHN5bmMgZmVhdHVyZQ0K
LS0gDQoyLjE3LjENCg0K
