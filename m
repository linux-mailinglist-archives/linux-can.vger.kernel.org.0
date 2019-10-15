Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9263D7661
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2019 14:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfJOMVq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Oct 2019 08:21:46 -0400
Received: from mail-eopbgr50041.outbound.protection.outlook.com ([40.107.5.41]:6055
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725810AbfJOMVp (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 15 Oct 2019 08:21:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7yDy3x3x8xPSWgUVzc2S2ZKm7J9seANGrvhPFIoQGNAlGuKxi4lyd1P2RrLvBoTZYE801BlnBHxSjjwWVUnLSZn4ZOAS8ED4zgyzs5tQ5skpiYudIV2R9qbY91rcpGfDbjydGrrV1UbeMxWP4Xoozleb0fM2x1hIoRfJ3j5oKhIZHkfjrRHExmsZ+8Zz2jOmHKndXnDQFHWBzYT0jL2uWAInPtWGoefcEFCTHWNy1gfI5c0KHB0aTR216W8cJX4rcjb7/WLKvqXTl0cf4/dunKlYspfjIkw5bBsiHxIEhFVbpwCGi6EPVYpOgDfzrJ9wcrm2BYGkbFOhhuMWNh74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFAlHuJgEW4q5VtlsMvzDOdOFVZay/U+AryAZM+zWr8=;
 b=T9cXRgG4MjtxVBuDzHDv4fM9Dzk+IgkAIrXSziwjKeyqn/z/+sB4kVjijymw1yeB1mnATWdC/OmaisARBhT9Z50wNCzwMJtxufww4j0BIOCLIaz/m2LkHcQ5cpt5IJtYM3ugaq2pXJOfiKW8kxmJT2SJVVJL82xrcFEaWoq5C9CfOL/PIrySxVJt9A0ireCSqf9tQjSMRbrCMc/t2STZ5HHUXgUxGEKg8G4klzQ3eYl2IltCCru1lQU27JNvggUwpz9JoTwMe4VabdOigZexbGieqi+br/toImNpdTxKEKpFRMMdSkqa+9/0lCLvrEbpQWNLL2PYLtYJSiX0e8Vqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFAlHuJgEW4q5VtlsMvzDOdOFVZay/U+AryAZM+zWr8=;
 b=OqrU7C8+r5ZVW4JVGBoEnKjS5bowpbFAZnO4d+kDfNjSJS81PRCiceYgDR3Jee17x0dunXEl3zwePYtWbJB4YaYUZLXZYtLfrG8or1cp+2I/HKTTojDzBnJ99f7ynXHtLgocLpJ5mKoxzVSqd8cgnETmBCqmpDkcebG9L1yN6yY=
Received: from AM6PR03MB4006.eurprd03.prod.outlook.com (20.177.37.97) by
 AM6PR03MB3816.eurprd03.prod.outlook.com (20.177.39.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 12:21:23 +0000
Received: from AM6PR03MB4006.eurprd03.prod.outlook.com
 ([fe80::e93e:a46a:3c6a:c0f7]) by AM6PR03MB4006.eurprd03.prod.outlook.com
 ([fe80::e93e:a46a:3c6a:c0f7%7]) with mapi id 15.20.2347.021; Tue, 15 Oct 2019
 12:21:23 +0000
From:   =?utf-8?B?U3TDqXBoYW5lIEdyb3NqZWFu?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: RE: [PATCH 2/2] can/peak_usb/pcan_usb: add support of rxerr/txerr
 counters
Thread-Topic: [PATCH 2/2] can/peak_usb/pcan_usb: add support of rxerr/txerr
 counters
Thread-Index: AQHVfbPIskM4lsaY10OX0UftlC6fNqdQjXSAgAsbXvA=
Date:   Tue, 15 Oct 2019 12:21:22 +0000
Message-ID: <AM6PR03MB4006315428304DA4419935E4D6930@AM6PR03MB4006.eurprd03.prod.outlook.com>
References: <20191008083545.4569-1-s.grosjean@peak-system.com>
 <20191008083545.4569-3-s.grosjean@peak-system.com>
 <4416597c-6db7-057d-36b5-dc4b2c15117f@pengutronix.de>
In-Reply-To: <4416597c-6db7-057d-36b5-dc4b2c15117f@pengutronix.de>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=s.grosjean@peak-system.com; 
x-originating-ip: [185.109.201.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffcd74ad-686e-4ae2-38c4-08d7516a3141
x-ms-traffictypediagnostic: AM6PR03MB3816:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM6PR03MB38168D1E55E0B99C3EB553A4D6930@AM6PR03MB3816.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(76176011)(8936002)(66574012)(5660300002)(6916009)(6306002)(446003)(11346002)(55016002)(76116006)(71200400001)(71190400001)(486006)(66446008)(476003)(14444005)(256004)(9686003)(33656002)(99286004)(6506007)(102836004)(74316002)(14454004)(66476007)(66556008)(64756008)(966005)(6246003)(4326008)(7696005)(66066001)(305945005)(2906002)(186003)(6116002)(7736002)(86362001)(15974865002)(26005)(3846002)(8676002)(229853002)(81156014)(316002)(81166006)(6436002)(85202003)(66946007)(508600001)(52536014)(85182001)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB3816;H:AM6PR03MB4006.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: peak-system.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GVWv3ePPFz10PJMzVcDNafZAblCeppVINN7KcZOPxHpBCYqGh5PM99GPV9v7AFF7GWJ5Inc5DyljrU7fzxIgdFhldra1+tjUdcD4zWZ4zWwbL8qMqBWMcbehfPA2ACeTxGTqtAfFvF0gjkzjl354xzhgWIHKqg+nXFFQMxMLw80dv8gm1K78yyjM80JECRd1rgeEawEM6arC2VAUQtTka7H6mRdEMc+3/+BSwXDi2jmhHET9aTALBZ+cPNFpx4WORi8+7lnmadqu1O7ovs1A4tgLfhK4KrtwnD56ZBX1Jy3aAqzRpLM2wq8C9V/5jzuHyvZymeqrwh01MnXhAtmZOcniWNaVH7SUbzN9Jw1ZgEFO3jwyIF0H4N8Hv+OZ0/eCMyeU4uoaycAPHfmO5BwQHsygIOJ2wqZEDb4ckR5DiYdSHaHopUAh3Ot2zU3BMpWYv/rB9DG7wrDO3B+NgEpYrQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcd74ad-686e-4ae2-38c4-08d7516a3141
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 12:21:22.9706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EBiGG6/aIV3eTiJ9hS55TMrt37DbyRznzQhOTwuL9IqH0r94SwR7wriCvgNmr8DsZy5CQiePFPV6BGl3TTd8gnBA7Icr7Sa96QFnFdHg7+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3816
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGVsbG8gTWFyYywNCg0KU2VlIG15IGNvbW1lbnRzIGJlbG93Lg0KDQpUaGFuayB5b3UsDQoNCuKA
lCBTdMOpcGhhbmUNCg0KPiA+ICAvKg0KPiA+ICAgKiBzdGFydCBpbnRlcmZhY2UNCj4gPiAgICov
DQo+ID4gIHN0YXRpYyBpbnQgcGNhbl91c2Jfc3RhcnQoc3RydWN0IHBlYWtfdXNiX2RldmljZSAq
ZGV2KSAgew0KPiA+ICBzdHJ1Y3QgcGNhbl91c2IgKnBkZXYgPSBjb250YWluZXJfb2YoZGV2LCBz
dHJ1Y3QgcGNhbl91c2IsIGRldik7DQo+ID4gK2ludCBlcnI7DQo+ID4NCj4gPiAgLyogbnVtYmVy
IG9mIGJpdHMgdXNlZCBpbiB0aW1lc3RhbXBzIHJlYWQgZnJvbSBhZGFwdGVyIHN0cnVjdCAqLw0K
PiA+ICBwZWFrX3VzYl9pbml0X3RpbWVfcmVmKCZwZGV2LT50aW1lX3JlZiwgJnBjYW5fdXNiKTsN
Cj4gPg0KPiA+ICtwZGV2LT5iZWMucnhlcnIgPSAwOw0KPiA+ICtwZGV2LT5iZWMudHhlcnIgPSAw
Ow0KPiA+ICsNCj4gPiArLyogYmUgbm90aWZpZWQgb24gYW55IGVycm9yIGNvdW50ZXIgY2hhbmdl
ICovDQo+DQo+IERvZXMgdGhlIGRldmljZSBvZmZlciB0aGUgcG9zc2liaWxpdHkgdG8gcmVhZCB0
aGUgZXJyb3IgY291bnRlcnM/IElmIHNvIHBsZWFzZQ0KPiBkbyBpdCBpbiBwY2FuX3VzYl9nZXRf
YmVycl9jb3VudGVyKCkuDQo+DQoNCk5vcGUhIFRoZSB2YWx1ZSBvZiB0aGUgZXJyb3IgY291bnRl
cnMgY2FuIG9ubHkgYmUgb2J0YWluZWQgdGhyb3VnaCB0aGUgYmVsb3cgImJ1cyBlcnJvciIgbm90
aWZpY2F0aW9uIG1lY2hhbmlzbToNCg0KPiA+ICtlcnIgPSBwY2FuX3VzYl9zZXRfZXJyX2ZyYW1l
KGRldiwgUENBTl9VU0JfRVJSX0VDQyB8DQo+ID4gKyAgICAgUENBTl9VU0JfRVJSX1JYRVJSIHwN
Cj4gUENBTl9VU0JfRVJSX1RYRVJSIHwNCj4gPiArICAgICBQQ0FOX1VTQl9FUlJfUlhFUlJfQ05U
IHwNCj4gPiArICAgICBQQ0FOX1VTQl9FUlJfVFhFUlJfQ05UKTsNCj4NCj4gQmV0dGVyIG9ubHkg
ZW5hYmxlIGJ1cyBlcnJvcnMsIGlmIHRoZSB1c2VyIGhhcyByZXF1ZXN0ZWQgdGhlbS4gU2VlOg0K
Pg0KPg0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2Ry
aXZlcnMvbmV0L2Nhbi9zamExMDAwL3NqYTEwDQo+IDAwLmMjTDE1Mg0KPg0KDQpPay4gIEJ1dCB0
aGlzIGFsc28gbWVhbnMgdGhhdCB0aGUgcngvdHggZXJyIGNvdW50ZXJzIHdpbGwgYWx3YXlzIGJl
IDAgaWYgdXNlciBkaWRuJ3QgcmVxdWVzdCAiYmVyci1yZXBvcnRpbmcgb24iLiBJcyB0aGlzIG9r
Pw0KDQo+ID4gK2lmIChlcnIpDQo+ID4gK25ldGRldl93YXJuKGRldi0+bmV0ZGV2LA0KPiA+ICsg
ICAgIkNBTiBidXMgZXJyb3IgY291bnRlcnMgbm90IGF2YWlsYWJsZSAoZXJyICV1KVxuIiwNCj4g
PiArICAgIGVycik7DQo+ID4gKw0KPiA+ICAvKiBpZiByZXZpc2lvbiBncmVhdGVyIHRoYW4gMywg
Y2FuIHB1dCBzaWxlbnQgbW9kZSBvbi9vZmYgKi8NCj4gPiAgaWYgKGRldi0+ZGV2aWNlX3JldiA+
IDMpIHsNCj4gPiAtaW50IGVycjsNCj4gPiAtDQo+ID4gIGVyciA9IHBjYW5fdXNiX3NldF9zaWxl
bnQoZGV2LA0KPiA+ICBkZXYtPmNhbi5jdHJsbW9kZSAmDQo+IENBTl9DVFJMTU9ERV9MSVNURU5P
TkxZKTsNCj4gPiAgaWYgKGVycikNCj4gPiBAQCAtOTA2LDQgKzEwNTAsNSBAQCBjb25zdCBzdHJ1
Y3QgcGVha191c2JfYWRhcHRlciBwY2FuX3VzYiA9IHsNCj4gPiAgLmRldl9lbmNvZGVfbXNnID0g
cGNhbl91c2JfZW5jb2RlX21zZywNCj4gPiAgLmRldl9zdGFydCA9IHBjYW5fdXNiX3N0YXJ0LA0K
PiA+ICAuZGV2X3Jlc3RhcnRfYXN5bmMgPSBwY2FuX3VzYl9yZXN0YXJ0X2FzeW5jLA0KPiA+ICsu
ZG9fZ2V0X2JlcnJfY291bnRlciA9IHBjYW5fdXNiX2dldF9iZXJyX2NvdW50ZXIsDQo+ID4gIH07
DQo+ID4NCj4NCj4gTWFyYw0KPg0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAg
ICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAgICAgfA0KPiBJbmR1c3RyaWFsIExpbnV4
IFNvbHV0aW9ucyAgICAgICAgfCBQaG9uZTogKzQ5LTIzMS0yODI2LTkyNCAgICAgfA0KPiBWZXJ0
cmV0dW5nIFdlc3QvRG9ydG11bmQgICAgICAgICAgfCBGYXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTU1
NTUgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiAgfCBodHRwOi8vd3d3LnBl
bmd1dHJvbml4LmRlICAgfA0KDQoNCi0tDQpQRUFLLVN5c3RlbSBUZWNobmlrIEdtYkgNClNpdHog
ZGVyIEdlc2VsbHNjaGFmdCBEYXJtc3RhZHQgLSBIUkIgOTE4Mw0KR2VzY2hhZWZ0c2Z1ZWhydW5n
OiBBbGV4YW5kZXIgR2FjaCAvIFV3ZSBXaWxoZWxtDQpVbnNlcmUgRGF0ZW5zY2h1dHplcmtsYWVy
dW5nIG1pdCB3aWNodGlnZW4gSGlud2Vpc2VuDQp6dXIgQmVoYW5kbHVuZyBwZXJzb25lbmJlem9n
ZW5lciBEYXRlbiBmaW5kZW4gU2llIHVudGVyDQp3d3cucGVhay1zeXN0ZW0uY29tL0RhdGVuc2No
dXR6LjQ4My4wLmh0bWwNCg==
