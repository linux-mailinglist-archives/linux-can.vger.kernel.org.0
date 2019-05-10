Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DED219819
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2019 07:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfEJFd5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 10 May 2019 01:33:57 -0400
Received: from mail-eopbgr10080.outbound.protection.outlook.com ([40.107.1.80]:16263
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726934AbfEJFd5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 10 May 2019 01:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZXmZii+/88JpOnwe2CiPAWRGIUwaaMuO5WVjVqfkt8=;
 b=le8oZHqPuNuDmC/b0W39Cm207ygkVS+kwdXZfH4MfX2BTxCQSSA/k8q0wjno5e/YuJrKYn3ohlK3X1csmfo6AeEpiTXl59ouWqmj/8kJ8ORVOjU8sxf1ojFxUDMOB0yFc4xH4+91kwtoUT5qd6U2EF/jSqp2kzznRdiZcn6Sbvk=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2334.eurprd04.prod.outlook.com (10.169.133.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Fri, 10 May 2019 05:33:53 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7%3]) with mapi id 15.20.1878.019; Fri, 10 May 2019
 05:33:53 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [PATCH 0/4] net: can: flexcan: can FD Format (FDF) changes
Thread-Topic: [PATCH 0/4] net: can: flexcan: can FD Format (FDF) changes
Thread-Index: AQHVBvEs1Trfh85bgECGnx5+b6LwIqZj1Q6A
Date:   Fri, 10 May 2019 05:33:52 +0000
Message-ID: <VI1PR0401MB2496B9C6F88EA090EA58A58EF10C0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 6101cd4d-80be-4d9c-8ca7-08d6d5091699
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2334;
x-ms-traffictypediagnostic: VI1PR0401MB2334:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0401MB23344120F24DE0A40BBF5577F10C0@VI1PR0401MB2334.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(136003)(39860400002)(13464003)(189003)(199004)(5660300002)(14454004)(52536014)(186003)(486006)(86362001)(102836004)(6116002)(64756008)(3846002)(44832011)(76116006)(110136005)(54906003)(6246003)(11346002)(26005)(446003)(476003)(25786009)(81166006)(81156014)(478600001)(4326008)(8676002)(8936002)(6506007)(316002)(53546011)(53936002)(7736002)(55016002)(9686003)(6306002)(76176011)(66946007)(229853002)(7696005)(66556008)(2906002)(66476007)(99286004)(305945005)(66446008)(74316002)(66066001)(966005)(14444005)(33656002)(68736007)(6436002)(73956011)(256004)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2334;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E5VScJrXHKhVEfmUEH/sHTiNtSouWR6Me9hVSTRiO2ISnXmJ8TCRWC2n6qdckf3vufz4G61Id3N7GtsiFFeRn3nyfcOkkP6XvfmeSofBMa6UJTEzD1mwL928jh7BtTbPhpewcb0dAxmHDRVFMSeQT19BSw7fl7LkoU374trnwAE1Nvo5K646jbL57sOG/rPqFeuv7p6E0b4DR9YJAKH8Bl7LwmF2WBG0k8sAWU0VloHoow6kgraFZY63qxdpCK47jFmZh9NkwCcOh02L+bSg8QW406w6kxJwUwyxcR52JcihoV+iKQfDJbip8HxsIGbKSErHSy5T7E9qp/6t+lEIB5DUjIiLJrVXEsHcf/5eexWA0CSluPoe54sC1dqnuDBw+wMS3Haomwap6J6PjNXC6xj9Xt+oq0uKjRco56SenM4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6101cd4d-80be-4d9c-8ca7-08d6d5091699
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 05:33:52.8466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2334
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgTWFyYyBldC4gQWwsDQoNClRoZXNlIGNoYW5nZXMgYXJlIHBlbmRpbmcgZnJvbSBhIGxvbmcg
dGltZSBhbmQgdGhlIHJlZ3VsYXIgY2hhbmdlcyB0byBmbGV4Y2FuIGNvZGUNCm1ha2UgaXQgdmVy
eSBoYXJkIHRvIG1haW50YWluIHRoZXNlIGNoYW5nZXMuIEkgcmVxdWVzdCB5b3UgdG8gcGxlYXNl
IHJldmlldyB0aGVzZSBjaGFuZ2VzDQphbmQgbWVyZ2UuIEkgd2lsbCBwcm9tcGx5IHJlcGx5IHRv
IGFueSBxdWVyaWVzIHlvdSBoYXZlLg0KDQpSZWdhcmRzLA0KUGFua2FqIEJhbnNhbA0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhbmthaiBCYW5zYWwNCj4gU2VudDog
RnJpZGF5LCAxMCBNYXksIDIwMTkgMTA6NTggQU0NCj4gVG86IFdvbGZnYW5nIEdyYW5kZWdnZXIg
PHdnQGdyYW5kZWdnZXIuY29tPjsgTWFyYyBLbGVpbmUtQnVkZGUNCj4gPG1rbEBwZW5ndXRyb25p
eC5kZT4NCj4gQ2M6IGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmc7IFBhbmthaiBCYW5zYWwgPHBh
bmthai5iYW5zYWxAbnhwLmNvbT47IFZhcnVuDQo+IFNldGhpIDxWLlNldGhpQG54cC5jb20+DQo+
IFN1YmplY3Q6IFtQQVRDSCAwLzRdIG5ldDogY2FuOiBmbGV4Y2FuOiBjYW4gRkQgRm9ybWF0IChG
REYpIGNoYW5nZXMNCj4gDQo+IFRoaXMgaXMgbXkgc2Vjb25kIGF0dGVtcHQgdG8gYWRkIEZEIHN1
cHBvcnQgaW4gZmxleGNhbi4gbXkgZWFybGllciBwYXRjaGVzIGNhbg0KPiBiZSByZWZlcnJlZCBo
ZXJlOg0KPiANCj4gWzFdIGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LWNhbi9t
c2cwMDM0OC5odG1sDQo+IA0KPiBTb21lIG9mIHRoZSBwYXRjaGVzIGZyb20gYWJvdmUgc2VyaWVz
IGhhdmUgYWxyZWFkeSBiZWVuIG1lcmdlZC4NCj4gDQo+IFRoZXJlIGhhcyBiZWVuIGEgc2lnbmlm
aWNhbnQgY2hhbmdlIGluIGZsZXhjYW4gY29kZSBzaW5jZSBpIHNlbnQgYWJvdmUgcGF0Y2hlcw0K
PiBuYW1lbHk6DQo+IA0KPiBjb21taXQgY2JmZmFmN2FhMDllICgiY2FuOiBmbGV4Y2FuOiBBbHdh
eXMgdXNlIGxhc3QgbWFpbGJveCBmb3IgVFgiKQ0KPiANCj4gd2l0aCB0aGlzIHBhdGNoLCB0aGUg
ZmxleGNhbiBGRCBzdXBwb3J0cyBicmVha3MgKGlmIG9uZSB3ZXJlIHRvIGFwcGx5IHRoZSBhYm92
ZQ0KPiBwYXRjaGVzWzFdKQ0KPiANCj4gVG8gZml4IEZEIHN1cHBydCB3aXRoIGFib3ZlIHBhdGNo
LCBpIGhhdmUgYWRkZWQgY2hhbmdlcyBpbiB0aGlzIHNlcmllczoNCj4gDQo+IDMvNDogY2FuOiBm
bGV4Y2FuOiBtb2RpZnkgdGhlIGludGVycnVwdCByZWdpc3RlciBoYW5kbGluZw0KPiANCj4gVGhl
IHJlc3Qgb2YgdGhlIHBhdGNoZXMgYXJlIGZyb20gb2xkIHBhdGNoIHNlcmllcy4NCj4gDQo+IENj
OiBWYXJ1biBTZXRoaSA8Vi5TZXRoaUBueHAuY29tPg0KPiANCj4gUGFua2FqIEJhbnNhbCAoNCk6
DQo+ICAgbmV0OiBjYW46IGZsZXhjYW46IHVzZSBDQU4gRkQgZnJhbWVzIGZvciBUeC9SeA0KPiAg
IGNhbjogZmxleGNhbjogbW92ZSBjYW4gc2V0IGJpdGl0aW5ncyBhZnRlciBtb2R1bGUgY29udHJv
bA0KPiAgIGNhbjogZmxleGNhbjogbW9kaWZ5IHRoZSBpbnRlcnJ1cHQgcmVnaXN0ZXIgaGFuZGxp
bmcNCj4gICBuZXQ6IGNhbjogZmxleGNhbjogY2FuIEZEIEZvcm1hdCAoRkRGKSBjaGFuZ2VzDQo+
IA0KPiAgZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4uYyAgICAgIHwgMzE2ICsrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLQ0KPiAgZHJpdmVycy9uZXQvY2FuL3J4LW9mZmxvYWQuYyAgIHwg
IDMyICsrKy0NCj4gIGluY2x1ZGUvbGludXgvY2FuL3J4LW9mZmxvYWQuaCB8ICAgNiArLQ0KPiAg
MyBmaWxlcyBjaGFuZ2VkLCAyNzYgaW5zZXJ0aW9ucygrKSwgNzggZGVsZXRpb25zKC0pDQo+IA0K
PiAtLQ0KPiAyLjE3LjENCg0K
