Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292C42754C9
	for <lists+linux-can@lfdr.de>; Wed, 23 Sep 2020 11:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgIWJur (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Sep 2020 05:50:47 -0400
Received: from mail-db8eur05on2042.outbound.protection.outlook.com ([40.107.20.42]:27169
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgIWJur (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 23 Sep 2020 05:50:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fM6/sOQHt9ab93hY2LCzV4pAYKfNN756dZMvyiSwtPAJ3+bYmntxEJC5ZLVBNkPOZAwHrRLf7t8veRE/nJKTqAHzhiOsazynbzyEA8B1o+8/TH2oIkj36Q+hAsZqsXtbsTrI0dGx0ZaWIWwkY/EFocTjotXZfq9wqfaLCWgn2VkPk7ArVcET4upI0qB1srsB0Jc6K1nbycXZt0v68XiG07fqC2QB0ujI0C++CIDuhqKHPvRFfGkJ7DbmJ5oQmT5A+eKpcNvTFL5jCWGWfqGvMNixBTnpOkVG9KkpLm+YPgmITpEUYKA3ABWOTPixzO0meaAa1ZCHT1TI0w+l/Lbcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRDbkz/uucH5MqTpK6YLRtGIo0FXzl7H+XXvr3oPTR8=;
 b=mEFv0IvSG4zs1ZkQCOnOA+GXBaaikX21V1CVh3lmzkF5LEq4LRKjaSgLG6nhNeUtJHTiE5Y7Cl37Bg/84fKq1utvutldGfypAs00Phx4hH1bGF1bXATmzFpTYndO/y3lsayLJj1vBWYnQCk7Fh6LHllp6KXKwnA46IghAJAvNHoyM/ofhnXzxBLP6wrvYdsOqvA2s8QsVGvLrnjasZzQbSsG5WCrMYHQFLMJr5aSu9oNw49tJ+g+J6HpEXEQkzmn2XeimoEIgpkQ9Q1eRGpxCXVZ1x+YvKc7pEhwdE0d+SOQ1Frokio6PGdjG8ln9QGUbVCyY1lfUtmgiECJmBRnxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRDbkz/uucH5MqTpK6YLRtGIo0FXzl7H+XXvr3oPTR8=;
 b=aenpK4BbOlVDdv7wjp03xvJfabSVHQuOgx18mQGUDTauLY3dqjZUjv4PHHoeaAjte0sybd04+RgIw4oN9Egwgsx3BGsP+DFkw4aM/tlzwnfoILzF+r9xRQg8cEr8JwNpeBnn7x5DPVXXUYQAPwCikQYDA8UsTuc7hR4GAhwg14Y=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB4105.eurprd04.prod.outlook.com (2603:10a6:5:26::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 23 Sep
 2020 09:50:44 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::d12e:689a:169:fd68]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::d12e:689a:169:fd68%8]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 09:50:44 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Michael Walle <michael@walle.cc>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: [PATCH 20/20] can: flexcan: add lx2160ar1 support
Thread-Topic: [PATCH 20/20] can: flexcan: add lx2160ar1 support
Thread-Index: AQHWkO7pb02bDa3uBEmRZ3DevHIumql12SGAgAACdYCAAAJrAIAAAiWAgAADAbCAAApBAIAADnlg
Date:   Wed, 23 Sep 2020 09:50:44 +0000
Message-ID: <DB8PR04MB67955508817DE2D5B8B9BFEEE6380@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20200922144429.2613631-1-mkl@pengutronix.de>
 <20200922144429.2613631-21-mkl@pengutronix.de>
 <4ffe89fbb4c91a9587622862c3509180@walle.cc>
 <5b3c07ab-ca8c-d43d-f4e0-7155d358648d@pengutronix.de>
 <0e90e8234d38830749ad8de380837eb2@walle.cc>
 <8e2e2994-a3c8-cf06-012a-fcb0ac18a888@pengutronix.de>
 <DB8PR04MB67955FEC9B6A44A1A2C04DE8E6380@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <956dcdd5-b334-f5e5-dde1-bea07929f666@pengutronix.de>
In-Reply-To: <956dcdd5-b334-f5e5-dde1-bea07929f666@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7730258-4b57-4249-5d82-08d85fa623ea
x-ms-traffictypediagnostic: DB7PR04MB4105:
x-microsoft-antispam-prvs: <DB7PR04MB410549757B8C1C44A45F31DBE6380@DB7PR04MB4105.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O/spNfcg6Ba+sj92/c+mPi9/PuEATgC2Cra8nqBs1bwje/ZPM0T9W3ep0eOICJzYlmFtXHVuvhV4lkSnkdtG825ixaRDyJavCoOJTS3E9jTPe213OlH36gx9K//mKv9kNvXLT4EXNBYeLiIDc0pxikPGKont+SRopMO++z+bh2vsXAHb0NubhZ+jTr713bnch1gTFAGFUxu3R4NxH2Xp5MS2VCdOEv/um3WRlNBFLt1ci1sFXn4DWQoxIy5X1wg/A/smBNPqu4Vxa5KK/LgqeDKfHC2A3RoJGS4JjCzOct0jUocz6m464IO7xi59b+4iLEvN9Kk9fVYGGDRq1+mz+x9rkEzbCYUc8/uwvkBS7e1yVFCK3SFEyrcx41SSKbf/DgxtUfRZysOjZAhB8d3Vnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(6506007)(186003)(26005)(316002)(86362001)(83080400001)(71200400001)(478600001)(4326008)(966005)(55016002)(9686003)(33656002)(66946007)(52536014)(5660300002)(53546011)(110136005)(7696005)(8676002)(54906003)(2906002)(76116006)(8936002)(66556008)(64756008)(66446008)(66476007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4KdeoPTeTZedKQDAhoscsx0D1Aj6hsPUv86jz4o7v11MzT3lTGaunX0+/p8aOmka4rR84beRJ6W69QbKTV57myLvzbDFdTh4Ag4QLWYVUq7Wii0cHPofv5t5HwnTRXqPJrBmrPQyIH88e5hchuOyeNA/hbkiuLfNpxlP4Zj8ksuJwlD2aa/dy2BIAys6LMqwQYmlUxau06jYKPczm3aZ34BOC6k9/7SB7shCf06JLW4VgTbY3aVTBduQ8ZFAzpejU6UsvWM6WdH+bbx6a4QR0X2Dvw+AeS8lvy4rj1Cl0wD/isKQdwwitK8qFnRBLRkxRisuFH4Z/rugKbLV6817P21pA68AH545xU3NhtJDr1BpXcR/GRcFKa/viwCcpeGQqokgRoOWFG+wMBOPrw7FSeDqynW4GGxzoBsEPw++ZNf/KaaqYCaovOCfWxXiWjPrAv7rPChqfbYFuHwFI/Hz63jOFwQKmMk4AuO0jc8KC+KwRFyQ7iSqw/pUlkrAjpwnl4edQ9rPPsKWJ1LpA1E7r9qxeq9GS3O2ckekbID0ZuIKUjff/RGXRKNg1Rf5YFKLKLjRa5mF7JSbfhQ4x6qu6hbhFzQdyZLTT5dZ74mTaHoQ5bC5nrQ+fl/I5r7cBylJeGaJP9RlZo4dbxwoci6EcA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7730258-4b57-4249-5d82-08d85fa623ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 09:50:44.4219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: regGPHdpyEWPnNIAEYPx1+LC8kXW6vy+qM/pNCxp1nn7XEWlBHzRYYz/ImAsMkfQLByCMwj15nF7WaPjXgigxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4105
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjDlubQ55pyIMjPml6UgMTY6NTgNCj4g
VG86IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+OyBNaWNoYWVsIFdhbGxl
DQo+IDxtaWNoYWVsQHdhbGxlLmNjPg0KPiBDYzoga2VybmVsQHBlbmd1dHJvbml4LmRlOyBsaW51
eC1jYW5Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMjAvMjBdIGNhbjog
ZmxleGNhbjogYWRkIGx4MjE2MGFyMSBzdXBwb3J0DQo+IA0KPiBPbiA5LzIzLzIwIDEwOjMxIEFN
LCBKb2FraW0gWmhhbmcgd3JvdGU6DQo+ID4gSSBjaGVjayBsb2NhbGx5LCBmb3IgTFMxMDI4QSwg
aXQgYWxzbyB1c2VzIHRoZSAiZnNsLGx4MjE2MGFyMS1mbGV4Y2FuIg0KPiA+IGNvbXBhdGlibGUg
c3RyaW5nLCBzbyBJIHRoaW5rIExTMTAyOEEgc2hvdWxkIHJldXNlIElQIGNvcmUgZnJvbSBMWDIx
NjBBLg0KPiANCj4gVGhpcyBtZWFucyBhdCBsZWFzdCB0aGUgSVAgY29yZSBpcyBjb21wYXRpYmxl
IDopIEkgdGhpbmsgd2UgZG9uJ3Qga25vdyBmb3Igc3VyZSwgaWYNCj4gaXQncyB0aGUgc2FtZSB2
ZXJzaW9uIG9mIHRoZSBJUCBjb3JlLg0KPiANCj4gPiBJIGFtIG1vcmUgZmFtaWxpYXIgdG8gaS5N
WCwgSSB3aWxsIGFkZCBhIGNvbXBhdGlibGUgc3RyaW5nIGZvcg0KPiA+IGkuTVg4TVAsIHNpbmNl
IGl0IGNvbmZpZ3VyZXMgRUNDLCBleHRyYSBwYXRjaGVzIGFyZSBuZWVkZWQuDQo+IA0KPiBPaw0K
PiANCj4gPiBBZnRlciB0aGlzIHBhdGNoIHNldCBpcyBtZXJnZWQgaW50byBtYWlubGluZSwgSSB3
aWxsIHNlbmQgb3V0IHJlbGF0ZWQNCj4gPiBwYXRjaGVzIHRvIGNvbW11bml0eS4NCj4gDQo+IEkg
anVzdCBzZW5kIG91dCBhIHB1bGwgcmVxdWVzdCwgc28gZmVlbCBmcmVlIHRvIGJhc2UgeW91ciBw
YXRjaGVzIG9uIHRoZSB0YWcNCj4gbGludXgtY2FuLW5leHQtZm9yLTUuMTAtMjAyMDA5MjMNCg0K
T0ssIHRoYW5rcywgSSB3aWxsIHNlbmQgb3V0IHNvb24uDQoNCkJlc3QgUmVnYXJkcywNCkpvYWtp
bSBaaGFuZw0KPiBNYXJjDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAg
ICAgICB8IE1hcmMgS2xlaW5lLUJ1ZGRlICAgICAgICAgICB8DQo+IEVtYmVkZGVkIExpbnV4ICAg
ICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUgIHwNCj4gVmVydHJl
dHVuZyBXZXN0L0RvcnRtdW5kICAgICAgICAgfCBQaG9uZTogKzQ5LTIzMS0yODI2LTkyNCAgICAg
fA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiB8IEZheDogICArNDktNTEyMS0y
MDY5MTctNTU1NSB8DQoNCg==
