Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39A1219A8A
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2019 11:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfEJJYK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 10 May 2019 05:24:10 -0400
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:47012
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727097AbfEJJYK (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 10 May 2019 05:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXjo0oOzYAhrCGGVnQlZDUhRKaOA3/N6uH/rFB+cFwY=;
 b=JaTJ5vv7axcwNJiSeaD5ffTmdKbKeg9cEjebQBjOW91kHHegPYogOmi8Axo3i8MWyh7Eo3kVnbQRGFGrcLiiWXd1ZJWCW7abbE5mKejnEopnBAqehYeMjo0R4l22IQdKT7mFO6MmuGfWIv5cszMwADt2R+T/JC2GC/+uUa3r/NY=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2318.eurprd04.prod.outlook.com (10.169.132.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Fri, 10 May 2019 09:24:04 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7%3]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 09:24:04 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: [PATCH 0/2] can: flexcan: add clocking information
Thread-Topic: [PATCH 0/2] can: flexcan: add clocking information
Thread-Index: AQHVBxIc32e9Suxso0usQOUY69PgyQ==
Date:   Fri, 10 May 2019 09:24:04 +0000
Message-ID: <20190510144724.16447-1-pankaj.bansal@nxp.com>
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
x-ms-office365-filtering-correlation-id: 0d341c8f-36fe-4044-6e6e-08d6d5293e9a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2318;
x-ms-traffictypediagnostic: VI1PR0401MB2318:
x-microsoft-antispam-prvs: <VI1PR0401MB231894A7C46BB1420A8B36B0F10C0@VI1PR0401MB2318.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(5660300002)(4326008)(2906002)(186003)(53936002)(6116002)(102836004)(1076003)(4744005)(36756003)(478600001)(26005)(2616005)(476003)(6512007)(14454004)(486006)(44832011)(3846002)(25786009)(8676002)(81166006)(81156014)(6436002)(68736007)(6486002)(54906003)(99286004)(8936002)(71190400001)(316002)(86362001)(305945005)(7736002)(50226002)(71200400001)(66476007)(64756008)(66556008)(66446008)(73956011)(386003)(6506007)(256004)(66946007)(52116002)(66066001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2318;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k80bFkyTO0YomLuyT5jSMG25/lbExi95yueJXa5WOqZ/ZrCS1Y1OLpo+eK6Cusx/iFCfP99ELflbnrPu9UBpb38QZ71CIx3pSYMTfPf9U0OEoxyAIPJF8qrsT02uGZHPeRkuatdYqBpmC1npV7fH0AyN3LCYuCfzqydQz3naqGMW07QB17PaLvCJyBBgk6Si0sxJJbjBuXB1vb/fAcbkbRNH49AL2nxkCKyDnimgBnExbitwqUtcwX5ZPUoOJxBDPt6SE38xL4UL7+XC4egU+6KfQq3k/DnfWmgSpWfp5dgg8VURF6SomuKXyyTM7io/XeuDPVVfZKgc29sGOzVEWjph0E6Xd5W0qEOSWCLse/xvbAVC9c/LaPfLebDiP4JC4k8z6LRJ9YXS6nJ35X7IaUGnnpdY8ITK2H/pQ4PfZkE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d341c8f-36fe-4044-6e6e-08d6d5293e9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 09:24:04.5261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2318
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

VGhlIGNsb2NraW5nIGluZm9ybWF0aW9uIGlzIG1pc3NpbmcgZnJvbSBmbGV4Y2FuIGRldmljZSB0
cmVlIGJpbmRpbmdzLg0KVGhpcyBpbmZvcm1hdGlvbiBpcyBuZWVkZWQgdG8gYmUgYWJsZSB0byB1
c2UgZmxleGNhbi4gRG9jdW1lbnQgdGhlIHNhbWUuDQoNCkJhc2VkIG9uIHRoZSBpbmZvcm1hdGlv
biBpbiBkb2N1bWVudCwgbWFrZSB0aGUgUEUgY2xvY2sgcGFyc2luZyBjb25kaXRpb25hbA0KaW4g
ZmxleGNhbiBkcml2ZXIuDQoNCkNjOiBWYXJ1biBTZXRoaSA8Vi5TZXRoaUBueHAuY29tPg0KDQpQ
YW5rYWogQmFuc2FsICgyKToNCiAgRG9jdW1lbnRhdGlvbjogY2FuOiBmbGV4Y2FuOiBBZGQgZmxl
eGNhbiBjbG9ja3MnIGluZm9ybWF0aW9uDQogIGNhbjogZmxleGNhbjogbWFrZSBQRSBjbG9jayBp
bmZvIGNvbmRpdGlvbmFsDQoNCiAuLi4vYmluZGluZ3MvbmV0L2Nhbi9mc2wtZmxleGNhbi50eHQg
ICAgICAgICAgfCA0NyArKysrKysrKysrKysrKysrKystDQogZHJpdmVycy9uZXQvY2FuL2ZsZXhj
YW4uYyAgICAgICAgICAgICAgICAgICAgIHwgMzkgKysrKysrKysrKy0tLS0tDQogMiBmaWxlcyBj
aGFuZ2VkLCA3MyBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjE3LjEN
Cg0K
