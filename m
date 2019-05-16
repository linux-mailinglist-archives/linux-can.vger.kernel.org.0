Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A9C20115
	for <lists+linux-can@lfdr.de>; Thu, 16 May 2019 10:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfEPIM2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 16 May 2019 04:12:28 -0400
Received: from mail-eopbgr40047.outbound.protection.outlook.com ([40.107.4.47]:36739
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfEPIM2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 16 May 2019 04:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzLy8iMcuJdbXKuDjseahyli2ZASCW+p+obAuplrIsM=;
 b=JhZyuvPbZeaJbHHuX5Bnfm+lWxVDwu/fQk26+d9A+etHYlxwOppuWdMveJz4BeEbm3d+73h6FoiZ+XC/Qiwtv+sgZ/sbZDHuHKZfvcyv8aXuZJUD31/mH0ZF4pvgXxfEoANKlt19w5bvaG2VoGqxBj7+/HtQ/g6yz/JiZa4Rsms=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2272.eurprd04.prod.outlook.com (10.169.137.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 08:12:24 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::3d45:6b81:13ba:88cf]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::3d45:6b81:13ba:88cf%7]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 08:12:24 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     Varun Sethi <V.Sethi@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: [PATCH v2 0/2] can: flexcan: add clocking information
Thread-Topic: [PATCH v2 0/2] can: flexcan: add clocking information
Thread-Index: AQHVC78XR4ac/8HeNkGXIScQvjhi0A==
Date:   Thu, 16 May 2019 08:12:24 +0000
Message-ID: <20190516133556.15872-1-pankaj.bansal@nxp.com>
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
x-ms-office365-filtering-correlation-id: dabaff48-3647-4c79-3940-08d6d9d639ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2272;
x-ms-traffictypediagnostic: VI1PR0401MB2272:
x-microsoft-antispam-prvs: <VI1PR0401MB2272B830B0B1C2C718548F70F10A0@VI1PR0401MB2272.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(136003)(376002)(199004)(189003)(26005)(386003)(6506007)(66066001)(7736002)(486006)(25786009)(102836004)(305945005)(44832011)(52116002)(54906003)(6486002)(8676002)(81156014)(8936002)(2616005)(476003)(68736007)(1076003)(81166006)(4744005)(86362001)(316002)(99286004)(14454004)(50226002)(5660300002)(186003)(53936002)(64756008)(71190400001)(73956011)(66446008)(66946007)(66556008)(66476007)(256004)(4326008)(6436002)(478600001)(3846002)(6512007)(6116002)(36756003)(71200400001)(2906002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2272;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2ONqVbCR4CxYVZ+BqvZBgb4oXdLqDMOxayUFsTgPqso4jF3DPgBxbbZbaaGEnvBd7T7UeV65YdrNnLFtDak7tChRKy92QlxIuYZPJD0j9Gfn/fi8bcwxJlV3cuOHSL44xTkDEov1Uu29NsWs3NMgBYq307f9zS+L1z7o4MHfBkDvoI3xglcipCrAlm1IRX2dSeimr8Hu76OPJvYio4Ec3D8FNUtRZJPu2Chx7HtXqMJvW2A8AFrZMqMdjNeEAuBA9nn1skME+YZHLI0SU9kK4fKq5aDnZeYm/OMJW9ocQZPLmV4SyYOKGjH2UH3WrnUqNDXyvtqCEB8W3aG6Y/k5nmh9mz36P9h9N6NAjP4btjg1LfaG0V4m36ukImgjPcmRJbFKy5LN9zjyvZOAnkb2Q7YM12QpI3bGQpgT/WLAfaM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dabaff48-3647-4c79-3940-08d6d9d639ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 08:12:24.2918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2272
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
ICAgICAgICAgfCA0NiArKysrKysrKysrKysrKysrKystDQogZHJpdmVycy9uZXQvY2FuL2ZsZXhj
YW4uYyAgICAgICAgICAgICAgICAgICAgIHwgMzkgKysrKysrKysrKystLS0tLQ0KIDIgZmlsZXMg
Y2hhbmdlZCwgNzEgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4xNy4x
DQoNCg==
