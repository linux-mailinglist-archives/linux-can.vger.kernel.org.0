Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 092071FF6F
	for <lists+linux-can@lfdr.de>; Thu, 16 May 2019 08:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEPGRb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 16 May 2019 02:17:31 -0400
Received: from mail-eopbgr00081.outbound.protection.outlook.com ([40.107.0.81]:39799
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbfEPGRb (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 16 May 2019 02:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzLy8iMcuJdbXKuDjseahyli2ZASCW+p+obAuplrIsM=;
 b=ZKFrisKSXp4bi56eMkjp9v8szgll/yEdg3QstjYLRVcjsRz8xOv4FzhXTfQ5EnLMDAXNm8NpYu6Z4f8b6IdWihFJG9OJSEdy0xpYPO+kHN8X90xMqsax1DDvw2Qu2wqbT7583mmqXQJrTprnTaQ5hggfzYKHKlxMUjnH4dFA8do=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2494.eurprd04.prod.outlook.com (10.168.65.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 06:17:27 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::3d45:6b81:13ba:88cf]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::3d45:6b81:13ba:88cf%7]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 06:17:27 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     Varun Sethi <V.Sethi@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: [PATCH v2 0/2] can: flexcan: add clocking information
Thread-Topic: [PATCH v2 0/2] can: flexcan: add clocking information
Thread-Index: AQHVC68IaQtxlxYR/UWdQE8S+x9Saw==
Date:   Thu, 16 May 2019 06:17:27 +0000
Message-ID: <20190516114057.5878-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::15) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6088069d-6458-4ff3-3053-08d6d9c62b26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2494;
x-ms-traffictypediagnostic: VI1PR0401MB2494:
x-microsoft-antispam-prvs: <VI1PR0401MB249408B75EC7DB24D76397B9F10A0@VI1PR0401MB2494.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(52116002)(53936002)(99286004)(386003)(102836004)(6506007)(7736002)(50226002)(4326008)(6512007)(26005)(478600001)(14454004)(316002)(44832011)(2616005)(476003)(486006)(186003)(110136005)(36756003)(54906003)(8936002)(81156014)(68736007)(86362001)(81166006)(2906002)(6436002)(305945005)(8676002)(66946007)(6486002)(66066001)(66446008)(66556008)(6116002)(64756008)(66476007)(73956011)(4744005)(256004)(25786009)(71190400001)(71200400001)(3846002)(1076003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2494;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iIF6TpYz9iJ3jADe0fker7UVibwPD59s8noKanOyA6o4/lSGwG++Id1CEP6qhuJUi6hOsimD+I+6oHsc49uOuoDw58QYF2AbCq/EyJXJeSkNJDkcl/Pd6xfkl97ormngbFYBZXmFPNiwRjAJmElI6BIGvBV+fc0juqbEqlEJOXXTLBei2TvoYh31ztbsXRTMaZi4W4XnutrtLIv9uXsy8kEr8WGENIieM/T2bvkdrKvUsK2cllrrKsX2H9C+3xzsrJcU12Xy4hNxEOIzKTiIgfrI+pabeRO3s7AEMHO85iO7uibGZBtOG4DTaLgWLg6eVto9Kyv+90noa0t5iECUq576sn3+jEv7t5HldA55jzvA28FF01cy22XjdRaOtG/6YJFOgqiyMmfP8c8t+jWvhg+GFD2qux4+ZZZBpVy9ogQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6088069d-6458-4ff3-3053-08d6d9c62b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 06:17:27.4932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2494
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
