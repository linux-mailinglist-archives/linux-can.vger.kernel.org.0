Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED6D19ADB
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2019 11:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfEJJl1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 10 May 2019 05:41:27 -0400
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:34946
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727136AbfEJJl1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 10 May 2019 05:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uu/etyROp3dWBsDWv1O6WgY58oUG7e8PeeFtQQMpjvc=;
 b=rv76wfTjetqsJy9U3oOvz1cIxoqXC/0jqtIZrTzMNMTjkqJQxDnNAI+05SaEwFysuhx4TruhNAtUmlr7VggEvZghxdP+aoWlORgZncKR7Hdf3A52McsDu1vrZUVoLiJwN5iTk4VHEfDs+IZjIyxG7FYvqPxRT26evW2+dBvhYFU=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2381.eurprd04.prod.outlook.com (10.169.134.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Fri, 10 May 2019 09:41:23 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7%3]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 09:41:23 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Pankaj Bansal <pankaj.bansal@nxp.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Leo Li <leoyang.li@nxp.com>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [PATCH 0/4] net: can: flexcan: can FD Format (FDF) changes
Thread-Topic: [PATCH 0/4] net: can: flexcan: can FD Format (FDF) changes
Thread-Index: AQHVBvEs1Trfh85bgECGnx5+b6LwIqZkGxUA
Date:   Fri, 10 May 2019 09:41:23 +0000
Message-ID: <VI1PR0401MB2496FE867FD6FFC17314DF01F10C0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
References: <20190510105137.27523-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190510105137.27523-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [92.120.0.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d7287c3-bb5a-4ec8-9672-08d6d52baa0f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2381;
x-ms-traffictypediagnostic: VI1PR0401MB2381:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0401MB238103B37FA9BBA0F08719C3F10C0@VI1PR0401MB2381.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:499;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(366004)(13464003)(189003)(199004)(81156014)(33656002)(71190400001)(6506007)(99286004)(64756008)(966005)(68736007)(66446008)(8676002)(66476007)(66556008)(102836004)(6246003)(86362001)(8936002)(3846002)(7736002)(6116002)(110136005)(14454004)(81166006)(52536014)(6436002)(4326008)(486006)(476003)(26005)(6636002)(256004)(316002)(53936002)(74316002)(25786009)(53546011)(44832011)(71200400001)(5660300002)(446003)(11346002)(7696005)(229853002)(478600001)(76176011)(55016002)(76116006)(73956011)(66946007)(54906003)(6306002)(2906002)(66066001)(186003)(305945005)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2381;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: txtki5c9WhSwVuRlN2B8jPheFKP9WTQ7MRZGPw65yi/OWImOQw3jF2gkXNFG0DmyHOyUaDpRzxNtbV12+npG+QS0lgsyTcXyRx2ACRVO+JXgaZd55iSmfwWJWwUM6yFs5kuXw+xxoqewhgSGyAjVmAM4chjwdtZ6yRrAyEV995+g178lZ8SiaL294SDBi2ooxSn11dvBz9cLh62ufhxM4HS+96lcffR13LQ0Zy+qPm/5z1XQ9tz4qL4fd49CD+13BXY2BbCKfyshVEM7cOb3TsPLu25UajbZyJMD3bO3YcZE9g4AMcvyT+xH7RQ4CVHgCIhJ6TbznWf8EgqT7TJyx700y5ywSZF9m6WNdkLA/JTnMblfz45pC6t2rAWtPjNNZFxNS+JELcB3p5/ksFvjaWpFdwoGhynhoGn5lxSaQiM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7287c3-bb5a-4ec8-9672-08d6d52baa0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 09:41:23.1270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2381
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

KyBMZW8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW5rYWogQmFu
c2FsIDxwYW5rYWouYmFuc2FsQG54cC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgMTAgTWF5LCAyMDE5
IDEwOjU4IEFNDQo+IFRvOiBXb2xmZ2FuZyBHcmFuZGVnZ2VyIDx3Z0BncmFuZGVnZ2VyLmNvbT47
IE1hcmMgS2xlaW5lLUJ1ZGRlDQo+IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IENjOiBsaW51eC1j
YW5Admdlci5rZXJuZWwub3JnOyBQYW5rYWogQmFuc2FsIDxwYW5rYWouYmFuc2FsQG54cC5jb20+
OyBWYXJ1bg0KPiBTZXRoaSA8Vi5TZXRoaUBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMC80
XSBuZXQ6IGNhbjogZmxleGNhbjogY2FuIEZEIEZvcm1hdCAoRkRGKSBjaGFuZ2VzDQo+IA0KPiBU
aGlzIGlzIG15IHNlY29uZCBhdHRlbXB0IHRvIGFkZCBGRCBzdXBwb3J0IGluIGZsZXhjYW4uIG15
IGVhcmxpZXIgcGF0Y2hlcyBjYW4NCj4gYmUgcmVmZXJyZWQgaGVyZToNCj4gDQo+IFsxXSBodHRw
czovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1jYW4vbXNnMDAzNDguaHRtbA0KPiANCj4g
U29tZSBvZiB0aGUgcGF0Y2hlcyBmcm9tIGFib3ZlIHNlcmllcyBoYXZlIGFscmVhZHkgYmVlbiBt
ZXJnZWQuDQo+IA0KPiBUaGVyZSBoYXMgYmVlbiBhIHNpZ25pZmljYW50IGNoYW5nZSBpbiBmbGV4
Y2FuIGNvZGUgc2luY2UgaSBzZW50IGFib3ZlIHBhdGNoZXMNCj4gbmFtZWx5Og0KPiANCj4gY29t
bWl0IGNiZmZhZjdhYTA5ZSAoImNhbjogZmxleGNhbjogQWx3YXlzIHVzZSBsYXN0IG1haWxib3gg
Zm9yIFRYIikNCj4gDQo+IHdpdGggdGhpcyBwYXRjaCwgdGhlIGZsZXhjYW4gRkQgc3VwcG9ydHMg
YnJlYWtzIChpZiBvbmUgd2VyZSB0byBhcHBseSB0aGUgYWJvdmUNCj4gcGF0Y2hlc1sxXSkNCj4g
DQo+IFRvIGZpeCBGRCBzdXBwcnQgd2l0aCBhYm92ZSBwYXRjaCwgaSBoYXZlIGFkZGVkIGNoYW5n
ZXMgaW4gdGhpcyBzZXJpZXM6DQo+IA0KPiAzLzQ6IGNhbjogZmxleGNhbjogbW9kaWZ5IHRoZSBp
bnRlcnJ1cHQgcmVnaXN0ZXIgaGFuZGxpbmcNCj4gDQo+IFRoZSByZXN0IG9mIHRoZSBwYXRjaGVz
IGFyZSBmcm9tIG9sZCBwYXRjaCBzZXJpZXMuDQo+IA0KPiBDYzogVmFydW4gU2V0aGkgPFYuU2V0
aGlAbnhwLmNvbT4NCj4gDQo+IFBhbmthaiBCYW5zYWwgKDQpOg0KPiAgIG5ldDogY2FuOiBmbGV4
Y2FuOiB1c2UgQ0FOIEZEIGZyYW1lcyBmb3IgVHgvUngNCj4gICBjYW46IGZsZXhjYW46IG1vdmUg
Y2FuIHNldCBiaXRpdGluZ3MgYWZ0ZXIgbW9kdWxlIGNvbnRyb2wNCj4gICBjYW46IGZsZXhjYW46
IG1vZGlmeSB0aGUgaW50ZXJydXB0IHJlZ2lzdGVyIGhhbmRsaW5nDQo+ICAgbmV0OiBjYW46IGZs
ZXhjYW46IGNhbiBGRCBGb3JtYXQgKEZERikgY2hhbmdlcw0KPiANCj4gIGRyaXZlcnMvbmV0L2Nh
bi9mbGV4Y2FuLmMgICAgICB8IDMxNiArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0N
Cj4gIGRyaXZlcnMvbmV0L2Nhbi9yeC1vZmZsb2FkLmMgICB8ICAzMiArKystDQo+ICBpbmNsdWRl
L2xpbnV4L2Nhbi9yeC1vZmZsb2FkLmggfCAgIDYgKy0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMjc2
IGluc2VydGlvbnMoKyksIDc4IGRlbGV0aW9ucygtKQ0KPiANCj4gLS0NCj4gMi4xNy4xDQoNCg==
