Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1257A1B01D
	for <lists+linux-can@lfdr.de>; Mon, 13 May 2019 08:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfEMGCt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 May 2019 02:02:49 -0400
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:26791
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726259AbfEMGCt (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 13 May 2019 02:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdHCYk/RI22Zk3ve9kuwK4A23FO3k67diWtQm1+OQJQ=;
 b=NJT6yPSDO7xh+GKdkZsfwzXbKpyoKaOcVejXDe4UzG6ITqlFjlKhlCI1rZ/WrQ2xa3D9J14TcMQnw1trbjIpSomjDVaBLGAtvuoFJTwCww0Tr8NaYxFoTLqoj4NZDS5uVp8NqwwCxfwj6w7mVWNnirmXDZqowCQEgU5OIFY3t7s=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2654.eurprd04.prod.outlook.com (10.168.66.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Mon, 13 May 2019 06:02:46 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7%3]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 06:02:46 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: [PATCH 0/2] arm64: dts: fsl: add flexcan nodes in layerscape SOCs
Thread-Topic: [PATCH 0/2] arm64: dts: fsl: add flexcan nodes in layerscape
 SOCs
Thread-Index: AQHVCVF8S3wmHv+gikKSOl+dndrPZg==
Date:   Mon, 13 May 2019 06:02:45 +0000
Message-ID: <20190513112612.11036-1-pankaj.bansal@nxp.com>
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
x-ms-office365-filtering-correlation-id: 37541ab6-5d26-4733-6b39-08d6d7689e77
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2654;
x-ms-traffictypediagnostic: VI1PR0401MB2654:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0401MB2654AA2525CAEB474F501F05F10F0@VI1PR0401MB2654.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(53936002)(86362001)(316002)(4744005)(386003)(6506007)(1076003)(6486002)(6306002)(6512007)(99286004)(44832011)(5660300002)(8676002)(8936002)(81156014)(68736007)(54906003)(110136005)(81166006)(71200400001)(71190400001)(50226002)(52116002)(2616005)(478600001)(66066001)(73956011)(186003)(476003)(256004)(966005)(66556008)(2906002)(14454004)(66446008)(66946007)(66476007)(486006)(36756003)(64756008)(6636002)(26005)(3846002)(25786009)(6116002)(7736002)(6436002)(305945005)(102836004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2654;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SZSozUtQzCr8XxEiX21q5FuzvsbRQcqdk5aK/MBwq9kWKELv1txZuO6cXPO/U3eqmKGJsjWLFlylv3ZhfXdgx558ZbtdAp0Z3YW1UwJywEuCBQzuYhNZf0tMbWP9M5WQMqjT33k+Akpl1/hpIJsQD/TRrb8JPDoSCamjN79wgL3xVRRqAviPzxRiZQuQAUrDOyDCmHFhk8/i14a+oQz9UD0QrdPR4TsHNGrqsUHoyZslzN/g4kaz4kMKNP/SXYYXon+nn/qgWUMnAPa9Sf/tyFxOjwPfUlb1vScx6B6DZV7OseRHNc8t/ke0DvFeHPWafs5OKH95fR2xB7TAfAScfB5EpB9A5ev6nUfHA323GjhMPRq9DEWhG2aZePD4ZWhmS/Ad/Yl73D0oCKHgGPqiy/6YKy6ONoRY5uMqyZBMXJ0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37541ab6-5d26-4733-6b39-08d6d7689e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 06:02:45.9895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2654
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

TlhQIExheWVyc2NhcGUgU09DcyBMWDIxNjBBIGFuZCBMUzEwMjhBIGJvdGggY29udGFpbiBmbGV4
Y2FuIG5vZGUgY2FwYWJsZQ0Kb2YgRkQgbW9kZS4NCg0KQ2M6IFZhcnVuIFNldGhpIDxWLlNldGhp
QG54cC5jb20+DQoNCkRlcGVuZGVuY2llczoNCiAtIGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xp
c3RzL2xpbnV4LWNhbi9tc2cwMTU2Mi5odG1sDQoNClBhbmthaiBCYW5zYWwgKDIpOg0KICBhcm02
NDogZHRzOiBmc2w6IGx4MjE2MGE6IGFkZCBmbGV4Y2FuIG5vZGUNCiAgYXJtNjQ6IGR0czogZnNs
OiBsczEwMjhhOiBhZGQgZmxleGNhbiBub2RlDQoNCiAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2Zz
bC1sczEwMjhhLXFkcy5kdHMgICAgfCAxMCArKysrKysrKy0NCiAuLi4vYm9vdC9kdHMvZnJlZXNj
YWxlL2ZzbC1sczEwMjhhLXJkYi5kdHMgICAgfCAxOCArKysrKysrKysrKysrKy0NCiAuLi4vYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kgfCAyMiArKysrKysrKysrKysr
KysrKystDQogLi4uL2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1xZHMuZHRzICAgIHwg
MTAgKysrKysrKystDQogLi4uL2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1yZGIuZHRz
ICAgIHwgMTggKysrKysrKysrKysrKystDQogLi4uL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9m
c2wtbHgyMTYwYS5kdHNpIHwgMjAgKysrKysrKysrKysrKysrKy0NCiA2IGZpbGVzIGNoYW5nZWQs
IDkyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4xNy4xDQoNCg==
