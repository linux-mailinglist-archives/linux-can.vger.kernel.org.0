Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15CB9FAA9B
	for <lists+linux-can@lfdr.de>; Wed, 13 Nov 2019 08:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfKMHFZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Nov 2019 02:05:25 -0500
Received: from mail-eopbgr20066.outbound.protection.outlook.com ([40.107.2.66]:25476
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbfKMHFY (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 13 Nov 2019 02:05:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e21+pvLWreVHIcruXnfdD4YbmRgk3DrcxWw64dMTfEeQtQYRL31TvyHl0rib2jCZ3+sLyKFBp8kNU2IMtBz4oBfNKbIrwXtD5o2JQRsv9y6Pp+h5mkr/E0IDTlcEZJWzb+FNMYhkjqzqGEeekbQeurl3b3FtCE3cRJTiF+Mjxmz/jXlo84VPOk1Hu1LO278EQNQA66bNxvtBNNfzMXPv+0azzdLgPSInESv63yYKv6v0taXJWKu2k38jgZ0h1YA/TII34HKgAGBklG192H2K2mZnwjDGLI/cOx1aOXjBK/3M0PY30GqafYYYQhIjoXESMMAgg7zbRu9/ubt/sQ6IGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xInor9Ozo4KqYGsahwEp4aYfVgih5IaoEZWMHFUWXDA=;
 b=eh/mbIuJ0rVKYarOokd73AAUW3M1R+TL+2lG+7PchIY46RwzeItP7Nt+LTQ6AV8LpZgXm5IngIsbSYvQE1dytPcdw95Bn4J2rsBDEZ2oTVZyjLvQc4sRHcFeRBiyznbCG6dO764LeGIbBP1ERABS12qdfyXieYR/b76ANhI2P1IpZVeQKB1DWw+dR4zIVUE9K1ecjJwW2Nc7fgV8VBQ4ImGPAzmaSOjeoLJdOKVc7/QCzVIhJzA5wdg22/2I9stZJcwkuMVNkOTi+7QUlyQjLrI2oK6u+9P+6DYs+QICsTug659o9WB5js1ucTtkzR94G+TWNcwOOcMvZcGYpGfmSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xInor9Ozo4KqYGsahwEp4aYfVgih5IaoEZWMHFUWXDA=;
 b=P2cfESxkuJhSE9waM1Bb1Q3AYhdAa/LPUVhfyHsydptxi8la5+TrSSqDvv6eMYouAJD8CDZlFBB2Z8iCspwtagi3SXVHUwbPbQuawXB38XQnbK8g2RFoeeZaA9ipFyiC6MR85XYlbpHjVpVBbMx9VB+LlXZJTfVsAX7gBbaZRXU=
Received: from VI1PR04MB4622.eurprd04.prod.outlook.com (20.177.57.151) by
 VI1PR04MB2958.eurprd04.prod.outlook.com (10.170.229.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 07:05:21 +0000
Received: from VI1PR04MB4622.eurprd04.prod.outlook.com
 ([fe80::88a2:6e00:c95:4804]) by VI1PR04MB4622.eurprd04.prod.outlook.com
 ([fe80::88a2:6e00:c95:4804%5]) with mapi id 15.20.2430.028; Wed, 13 Nov 2019
 07:05:21 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "sean@geanix.com" <sean@geanix.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Topic: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Index: AdWYdOEh/tYWI8MXSASMqe9cVeZH0AAAx0KAACvRiZAAA1AVAAAAc9fQAACXyQAAAWdfoAACB6aAAAAdeDAAAY+JAAAneXGQ
Date:   Wed, 13 Nov 2019 07:05:21 +0000
Message-ID: <VI1PR04MB46224BC6B3809341A0403244E6760@VI1PR04MB4622.eurprd04.prod.outlook.com>
References: <DB7PR04MB4618BF9DE9152B2F1D49A702E6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <bcbae072-3aec-34f7-9b7e-58d78000bd39@pengutronix.de>
 <DB7PR04MB4618061107733A9D53F75FA3E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <a232c1f6-cd91-8526-6fc9-163e9500bdf9@pengutronix.de>
 <DB7PR04MB4618BCC08EE8A9BDDA208C2AE6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <65288408-c12b-8a5f-9b56-132f0f4b3057@pengutronix.de>
 <DB7PR04MB4618C4D57D79DF5CE1CE5FBBE6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <ea3765aa-25ab-fe12-3c95-8444a75641dc@pengutronix.de>
 <DB7PR04MB4618888D202DAC80E6CC1BE6E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <80526cf4-b4f3-c559-ef70-a5dc8629406e@pengutronix.de>
In-Reply-To: <80526cf4-b4f3-c559-ef70-a5dc8629406e@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbc7f600-d78e-411f-7524-08d76807d944
x-ms-traffictypediagnostic: VI1PR04MB2958:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB2958E7F7099D09AEBF84C0FCE6760@VI1PR04MB2958.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(13464003)(189003)(199004)(2906002)(86362001)(229853002)(25786009)(6116002)(3846002)(478600001)(966005)(8676002)(52536014)(14454004)(2201001)(76116006)(81156014)(81166006)(2501003)(66946007)(66476007)(66556008)(64756008)(66446008)(256004)(8936002)(14444005)(561944003)(76176011)(7696005)(6506007)(186003)(26005)(476003)(486006)(102836004)(33656002)(6246003)(11346002)(53546011)(6306002)(9686003)(446003)(55016002)(6436002)(305945005)(71200400001)(71190400001)(7736002)(66066001)(110136005)(5660300002)(99286004)(74316002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB2958;H:VI1PR04MB4622.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DXKo+c+mt+220+4H2mZho7P/f02lzcQse0EIzdxmCc2cqwlmBl/04o+Fb2bspoDf8QpkYjst8h1uq1RZnBLVXpwDfjGcrwp3q+FfQbDVzERWfSWjBaOshiAy4E68KX+Op9eivElfZZFGXNTiFDezRinnoHWoouc3ASwlXDZ0nxdaPIJLhrJYSEQ0MZqUWPlbaUN9J/h2D2KNxb67fUGmhDTrNTodsSGsHRThvJ+P+e0FVok8qlVsRbXXb3y6X46D2XkJ9jZ2XAw/tXu1lafOphxNYVrdCeMbBsLx2wDqqXlrwi7qRt46J3hrTzLPhCnsYPRTybEPNIVg/E8tCrnG+CpoFhhdD2fKMzN3wSK2B7jQbwKIQJtTbiBvDgtukEkil72ddHuwsuqswN35rxOfNnSkU+3Fkdz5zJFtBN5wO/ERRPAufKPlqAg3bdr6qOu4e9UZaV/z6dXkODV6URNoBfSVMhhhzKMpcH1cbmfNrJ8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc7f600-d78e-411f-7524-08d76807d944
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 07:05:21.4397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hb+vwqT84NLDaJaqKnaOq476hN+c7Az2rcAZPTXbN2AZ2WNGd/9GDTcXzbdefLLmvXFOaqladAJ06z3rhCFTSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2958
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMTnlubQxMeaciDEy5pelIDE5OjM0DQo+
IFRvOiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsgc2VhbkBnZWFuaXgu
Y29tOw0KPiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBXYWtlIHVw
IGlzc3VlIGFib3V0IEZsZXhjYW4gZHJpdmVyIGluIHY1LjQga2VybmVsDQo+IA0KPiBPbiAxMS8x
Mi8xOSAxMjowMiBQTSwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+PiBJIHN1Z2dlc3QgdG8gc2V0
IGEgZmxhZyBpbiB0aGUgc3VzcGVuZCBoYW5kbGVyIGFuZCBldmFsdWF0ZSB0aGUgZmxhZw0KPiA+
PiBpbiB0aGUgaW50ZXJydXB0IGhhbmRsZXIuIElmIHRoZSBmbGFnIGlzIHNldCwgd2UgaGF2ZSB0
byBpZ25vcmUgdGhlIHRpbWVzdGFtcC4NCj4gPg0KPiA+IE5vdCBxdWl0ZSB1bmRlcnN0YW5kLCBj
b3VsZCB5b3UgZXhwbGFpbiBtb3JlPyBUaGFua3Mg8J+YiQ0KPiANCj4gV2l0aCBhIHdha2V1cCB0
byBJUlEgbGF0ZW5jeSBoaWdoZXIgdGhhbiB0aGUgdGltZSBzdGFtcCBjb3VudGVyIG92ZXJmbG93
DQo+IHRpbWUgd2UgY2Fubm90IHJlbHkgb24gdGhlIHRpbWVzdGFtcHMgb2YgdGhlIENBTiBmcmFt
ZXMgaW4gdGhlIGZpcnN0IElSUQ0KPiBoYW5kbGVyIHJ1biBhZnRlciB3YWtldXAuDQo+IA0KPiBN
eSBwcm9wb3NhbCBpcyB0byBzZXQgYSBmbGFnIGluIHRoZSBzdXNwZW5kIGhhbmRsZXIsIGUuZy4N
Cj4gcHJpdi0+aWdub3JlX3RpbWVzdGFtcCA9IHRydWU7DQo+IA0KPiBGb3Igbm93IG1ha2UgYSBj
b3B5IG9mDQo+ICAgICBjYW5fcnhfb2ZmbG9hZF9pcnFfb2ZmbG9hZF90aW1lc3RhbXAoKQ0KPiBj
YWxsIGl0DQo+ICAgICBjYW5fcnhfb2ZmbG9hZF9pcnFfb2ZmbG9hZF9pZ25vcmVfdGltZXN0YW1w
KCkNCj4gcmVwbGFjZQ0KPiAgICAgX19za2JfcXVldWVfYWRkX3NvcnQoJnNrYl9xdWV1ZSwgc2ti
LCBjYW5fcnhfb2ZmbG9hZF9jb21wYXJlKTsgYnkNCj4gICAgIHNrYl9xdWV1ZV90YWlsKCZvZmZs
b2FkLT5za2JfcXVldWUsIHNrYik7DQo+IA0KPiBJbiB0aGUgSVJRIGhhbmRsZXIsIGNoZWNrIGlm
IHRoZSBmbGFnIGlzIHNldCwgY2FsbA0KPiAgICAgY2FuX3J4X29mZmxvYWRfaXJxX29mZmxvYWRf
aWdub3JlX3RpbWVzdGFtcCgpDQo+IGFuZCB1bnNldCB0aGUgZmxhZy4NCj4gDQo+IENoZWNrIGlm
IHRoYXQgaGVscHMuDQoNCkhpIE1hcmMsDQoNClRoaXMgY2FuIHdvcmsgYXQgbXkgc2lkZS4gVGhh
bmtzLiBUaGUgcmVhc29uIGlzIHRoYXQgUENJZSBsaW5rIHRyYWluaW5nIGluIHRoZSBEV0MgUENJ
ZSBub2lycV9yZXN1bWUgY29uc3VtZWQgbW9yZSB0aGFuIDFzLg0KDQpjYW46IGZsZXhjYW46IGZp
eCBkZWFkbG9jayB3aGVuIHVzaW5nIHNlbGYgd2FrZXVwDQpjYW46IGZsZXhjYW46IGFkZCBMUFNS
IG1vZGUgc3VwcG9ydCBmb3IgaS5NWDdEDQpUaGlzIHBhdGNoIHNldCBoYXMgYmVlbiBwZW5kaW5n
IGZvciBhIGxvbmcgdGltZSwgY291bGQgeW91IHBsZWFzZSByZXZpZXcgaXQ/IEFmdGVyIHRoYXQs
IEkgY2FuIHNlbmQgYSBwYXRjaCB0byBmaXggaGlzIGlzc3VlIG9uIHRoZSB0b3Agb2YgaXQuDQoN
CkJlc3QgUmVnYXJkcywNCkpvYWtpbSBaaGFuZw0KPiBNYXJjDQo+IA0KPiAtLQ0KPiBQZW5ndXRy
b25peCBlLksuICAgICAgICAgICAgICAgICB8IE1hcmMgS2xlaW5lLUJ1ZGRlICAgICAgICAgICB8
DQo+IEVtYmVkZGVkIExpbnV4ICAgICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0
cm9uaXguZGUgIHwNCj4gVmVydHJldHVuZyBXZXN0L0RvcnRtdW5kICAgICAgICAgfCBQaG9uZTog
KzQ5LTIzMS0yODI2LTkyNCAgICAgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4
NiB8IEZheDogICArNDktNTEyMS0yMDY5MTctNTU1NSB8DQoNCg==
