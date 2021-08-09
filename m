Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB85C3E4595
	for <lists+linux-can@lfdr.de>; Mon,  9 Aug 2021 14:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhHIM1q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Aug 2021 08:27:46 -0400
Received: from mail-eopbgr80115.outbound.protection.outlook.com ([40.107.8.115]:41305
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233445AbhHIM1p (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 9 Aug 2021 08:27:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ulk+y5kRV7NlQnKCVumKVuyYgg8E3IOvbP29ufwCE5pjaX4StKFZnruK7SWQ7wkRO4zjG+s9eTPP27Ya2jgiPu0lI2VY22pgjUb22/7ZTMeUI9eLnxGjNOkuA1hsvH6Ijn3R5xXo8oO/YwK/qRNxg78dnELDaj5DVys9dmHoIDBypbhGOAFMUi5cVbNf9iWfhgzwOlLLa8m7cxl1PHuEf6vZ8QwHen7LfYM6TYzj1uSLgJSrJN87RuqoFQYgZTXYhKJwiyqN8EF411kqELdd0MdDsg0ZwRLXqZaXEiiry83bLAZeLHGelsnd52maX6azTnz/gXft0sjj00z8OLIn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UrY8UIxc6HBOvcu9Yi3xYkK15KI02J+XRoUSWi/Lfo=;
 b=i0x53cGsOBvZw9iPVLLLRsu+NyRuROpzvk1Bq2p0ogXJtv27lnxk/X18ymHomlmUtA1tdtaH/FYZXgz7J4aj+U+DovXz7Wntnf+EhP6qdQ8Jp7GUdGQVaJATYCvKaYozt9nQo3s19YWKGgGOheAGDIAmrDvmC5nHyd+vCG+l2yMIGPYHViV73gDTHbBlldPE7xwfBCmG4aMdBFSM+MwNw6ngb+Ynevv2tMSnC8INwvltddEhjvUBHiiuf5Ua5+d80SngXy4R9TTtxb1sw610GMlLGkJ/+Guyx863DpRTO2NjMYYR2FkKbMAU2QqWlfwZUkDT6cS4EiT9vczueLRh+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UrY8UIxc6HBOvcu9Yi3xYkK15KI02J+XRoUSWi/Lfo=;
 b=lIlEhQgUG2atH0qC6iezhcUgUMGrV0XMIA2oazgsO3Gb2rVfmG9R1P47gSoA2roJarLSKh1Twxe7yvg0IakLGTpd325hLI9M574Whluju5GYCLFI7JBLmS4HVPqIVVpJqY82So22ILtE2yfKaj4YpMNk3Nv4kAeFBkH3xWExy4E=
Received: from AM9PR03MB6929.eurprd03.prod.outlook.com (2603:10a6:20b:287::7)
 by AM0PR0302MB3473.eurprd03.prod.outlook.com (2603:10a6:208:6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Mon, 9 Aug
 2021 12:27:22 +0000
Received: from AM9PR03MB6929.eurprd03.prod.outlook.com
 ([fe80::1846:f0d4:5710:e65d]) by AM9PR03MB6929.eurprd03.prod.outlook.com
 ([fe80::1846:f0d4:5710:e65d%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 12:27:22 +0000
From:   =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <Stefan.Maetje@esd.eu>
To:     "mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
Subject: Re: [RFC PATCH v4 3/4] iplink_can: print brp and dbrp bittiming
 variables
Thread-Topic: [RFC PATCH v4 3/4] iplink_can: print brp and dbrp bittiming
 variables
Thread-Index: AQHXbDSCn/Bl8ZqU7ESUUZPdia3lYas3w1qAgALdDICAMLr9gA==
Date:   Mon, 9 Aug 2021 12:27:22 +0000
Message-ID: <ef0300efaf54edb82918ded0ef61f1f838e777eb.camel@esd.eu>
References: <20210628154402.1176099-1-mailhol.vincent@wanadoo.fr>
         <20210628154402.1176099-4-mailhol.vincent@wanadoo.fr>
         <0f23c1e5e4bcfcc7d8077c859788031b0e7214b4.camel@esd.eu>
         <CAMZ6RqKyL81CK_U9K-NZ4sNCLt8bKVWZ8mhcPd=p=cVHMO5RjQ@mail.gmail.com>
In-Reply-To: <CAMZ6RqKyL81CK_U9K-NZ4sNCLt8bKVWZ8mhcPd=p=cVHMO5RjQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f85580d0-9c0b-40b9-cad7-08d95b3109d2
x-ms-traffictypediagnostic: AM0PR0302MB3473:
x-microsoft-antispam-prvs: <AM0PR0302MB3473C2438B80D38194E9A71081F69@AM0PR0302MB3473.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JG6CpQ3vNSvasehBuBtJ6OosZxRl7K2cqKQekQCLTMr6eILyLOkArtzXJjMY9BTNAjKxgkz2IrEfj57tnCP5wefWEo+gv1PbPd2CYvQgkP/ZMsj2wtx0XmPywMn6Kaekp4nWITBx5QeDGpIvxz2SvshAzISOEy6dhS3JG4TP1h3Y6oZxdfDzIvV9k5Sp+hl0cjohFvvabcH5OZnVwPyWicu2gkYDVUgce2Llke3AHbdJSl+UOQRCfIGJ5UYUY4pp+rewwNnPeO6DA3S656O5wa+gTcW8yPnM7fI96Uuucdy3xObv05Fdc3YP8Z5XjQUnM60lZyxeSu5d068gUThE+GC5alOYiBI3vTMYJxYKFpots1Z+HpGUkTejmnu1h9tTLPPzGAcrsCRlvHFGET1oHPRu6+QrgPkSyzO7U3f0UpK08KyRpXUzE3JBUEDJidgnsJXYqwIAJuga3Z+LL3Lq2qEbzoSlypQj4B+0jNpifAA39r1+OA/zRMcjAuti12pRADkaH3PXiyDNmaNImqU12byQVz9tJ9WWLQpxjAsR+tL958a++if98EbjVn0IQrRvEH/cLPDM894wyT1DzgLBFy5R1DigVZWSywpVvaw8N2h06hSR8mVSh9R3rUotGSRrvZQwkIKYiU0tHB8ICfgsPPC5p1ttlDIObNXn5pH41x2OnRqSzNCRMjngvFT+ndoYB1Sk8M8ND8332qwu7YviF2mzsgiMBwPNEGATwcFg8uc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR03MB6929.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(396003)(136003)(39830400003)(66476007)(66556008)(66946007)(64756008)(76116006)(4326008)(85202003)(2906002)(66446008)(91956017)(5660300002)(8936002)(6506007)(8676002)(186003)(38070700005)(6916009)(478600001)(122000001)(6512007)(2616005)(71200400001)(6486002)(26005)(38100700002)(83380400001)(85182001)(316002)(86362001)(36756003)(54906003)(66574015)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3g1cTYzVXlrZHVEb1h0MGU0ZXhIN0RhV1c1WUhFZk02eXZFV1F3YUw1Uzd0?=
 =?utf-8?B?TGVOelJJeWFUZk16bWE5U2lPL2x0cjNJSG1hQnFOWG9HcFZiQjFlbWk5Qy9t?=
 =?utf-8?B?azdKcXhDS3ZPZXQxbnF5YUhRUFJ4ZytrZmgzQk04RlBybEk0THU3ZktDY09V?=
 =?utf-8?B?bWFiWnBFcVh2OFVKbmxRbDU3SGVwUUJNRXFiUnhjWmx2ZElEYkFHMitwOHk1?=
 =?utf-8?B?QU9qNXRPcGRaVVBTT2pvblVwVHRDbUNVZkpCckljWjkvWlBuUm1IWWUrTnlZ?=
 =?utf-8?B?c2gxaVpsaVd2aFI5b0EzaFYxMzlUdU5MTUJpT0JYVnNEQXhyc1F2M1llWWtI?=
 =?utf-8?B?Ty9MMUx6WTRFd2tPcjM0d3ltSEhLMytiMUFIYVVWZmhJbmladmdnZkhHbmxh?=
 =?utf-8?B?UFRoQ3JIVjI2U0Z0Ty9IbVl0L0ltdnlOR1RXSVpXODBYcmpGeG1KM0VmbWg3?=
 =?utf-8?B?RGhBbThkdUZPTHBRck5OdWMrSlpjTGlrR2hOUG9oRkVKYnBZWm1RUlcvUWJa?=
 =?utf-8?B?OXUyOXZjS09zaXhvNkNxcEtvZVU4eXZUV3FsR0FoUXJUTGwrOFFRb2NXTnkv?=
 =?utf-8?B?NGx5Y24zMEExRVhhc3V2YkN1bUJrbTlwUCtBZERIMUVBOFhoa3ZPVllUa3R2?=
 =?utf-8?B?K1lGUHlNR2VOcVNZMVBmd3dKamZyQ3phaUpnNW9zL2xQMm9JOFNubG52MWQ4?=
 =?utf-8?B?RUhTZHFSRHlPcXBNRmpKcG1GdDJTNnBSOUFnZ0s1NGd6MXgxVWJFL3VVb2NU?=
 =?utf-8?B?WGw3UmdmMGFTUDVKMVJzYnZudFFRd3NrYkFwdWVJdnFVd2hMbDNkQjhqa0wy?=
 =?utf-8?B?LzJxdmtXbXRnMWdxMFhwTEdYN1NSdUM1Q3Y5SWFYeTBaWHl2SlcyYk4wa0VQ?=
 =?utf-8?B?N09FQjBJWXR1SkxSanU0YUQ3alMzcHpjUlZIaXkvdkY2U0tEYkJveGdDdnNn?=
 =?utf-8?B?NHhRTkZMcDdSZVJiQXp2NTJ1RTU1U3VkYzJFOTFJNDF2YndVQW9Mc0RRNmFp?=
 =?utf-8?B?THFwS2NQcXRVTUhjZ3h5THppbWRWdXVIajlaenlHUEFwU0VxbkhuS2NrV1R0?=
 =?utf-8?B?UWJzWXpXQzN1SjBCRFdBMFJkQkdmRy95dnBybFhvR3ZtM0E3bXhTRzhGS2NO?=
 =?utf-8?B?a2FQekxnS3BjcFEyYjNoMzBGeUNGMGZDNHk4aHBnRHdRNG9ZbW5KU0hXR2dp?=
 =?utf-8?B?TmdSNGdJdjdJc25VY0lrY1BySkMvR3RUSnBQVmxTK240dzdwdHNTcE9zMTkw?=
 =?utf-8?B?bEpTR3BXNVJFOUhZNi81cURRenh2QmQwOWlSeDlBZkVJU1hvMEIvcUZyc2U4?=
 =?utf-8?B?VnIzRzVITUJBVXA5c2NpVmRsN1pBRUhqVjJNbmJwRlVvNENUeGZvT3dPQnFH?=
 =?utf-8?B?WGt4a2JidFc4NEVhTWJlVzF2U3A2Q1VhOC9xT1pjaStaaytpNU5tY0ZJak1q?=
 =?utf-8?B?aFFrZ013SGxNRDVKaDZMODY4UDVxcUNnTHBZVENJQnRDcWVDR1h6cjlHU0JY?=
 =?utf-8?B?amtRM2cwT0g1OHNoVnozS3VqaXd6STJ1NWVOL2xibzdPLzRCUzJkWlRNd28x?=
 =?utf-8?B?YnhCbzFxV21OUGlqNVk5SzFSbDRyL1NYd0ZyM0sxSTd0Q2Fwc0RtVFA3dDc0?=
 =?utf-8?B?RmFZQXFIZENGTlZIME82Y2YrYUQwdzhNR0E5MlNIYjNmUlg2cnFQVFFHVkNN?=
 =?utf-8?B?bkNaWlFuSHhqQmo4UkZNeU5UYmt5UUN1U1VkV1dHaGFMdmZlZkFEa3RCMG5u?=
 =?utf-8?Q?GrrPxDWgjA/0ZMVGJvThJqRxsa4ZqxxsptYPFk7?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E869CEFD29EA347A849A6149087985B@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR03MB6929.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85580d0-9c0b-40b9-cad7-08d95b3109d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 12:27:22.4148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63yE4MlOrd+Eu4iRoURvGGFmRh2X84dCecIcFvlTGgM0wSgM9DqOzSeO1BtgKmNER5rYfY4BxRH5aj5n1rUA/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0302MB3473
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

QW0gRnJlaXRhZywgZGVuIDA5LjA3LjIwMjEsIDE0OjE3ICswMjAwIHNjaHJpZWIgVmluY2VudCBN
QUlMSE9MOg0KPiBPbiBXZWQuIDcgSnVsIDIwMjEgYXQgMTg6MzMsIFN0ZWZhbiBNw6R0amUgPFN0
ZWZhbi5NYWV0amVAZXNkLmV1PiB3cm90ZToNCj4gPiBBbSBEaWVuc3RhZywgZGVuIDI5LjA2LjIw
MjEsIDAwOjQ0ICswOTAwIHNjaHJpZWIgVmluY2VudCBNYWlsaG9sOg0KPiA+ID4gUmVwb3J0IHRo
ZSB2YWx1ZSBvZiB0aGUgYml0LXJhdGUgcHJlc2NhbGVyIChicnApIGZvciBib3RoIHRoZSBub21p
bmFsDQo+ID4gPiBhbmQgdGhlIGRhdGEgYml0dGltaW5nLg0KPiA+ID4gDQo+ID4gPiBDdXJyZW50
bHksIG9ubHkgdGhlIGNvbnN0YW50IGJycCB2YWx1ZXMgKGJycF97bWluLG1heCxpbmN9KSBhcmUg
YmVpbmcNCj4gPiA+IHJlcG9ydGVkLiBBbHNvLCBicnAgaXMgdGhlIG9ubHkgbWVtYmVyIG9mIHN0
cnVjdCBjYW5fYml0dGltaW5nIG5vdA0KPiA+ID4gYmVpbmcgcmVwb3J0ZWQuDQo+ID4gPiANCj4g
PiA+IEFsdGhvdWdoIGJycCBpcyBub3QgdXNlZCBhcyBhbiBpbnB1dCBmb3IgYml0dGltaW5nIGNh
bGN1bGF0aW9uLCBpdA0KPiA+ID4gbWFrZXMgc2Vuc2UgdG8gb3V0cHV0IGl0Lg0KPiA+ID4gDQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBWaW5jZW50IE1haWxob2wgPG1haWxob2wudmluY2VudEB3YW5h
ZG9vLmZyPg0KPiA+IA0KPiA+IEkgdGhpbmsgaXQgaXMgYSBnb29kIGlkZWEgdG8gZGlzcGxheSBi
b3RoIGJycCBhbmQgZGJycCB2YWx1ZXMgYmVjYXVzZSBpdCBtYWtlcw0KPiA+IHRoZSBkaXNwbGF5
ZWQgYml0cmF0ZSBzZXR0aW5ncyBjb21wbGV0ZS4gRXZlbiBpZiBpdCBjb3VsZCBiZSBjYWxjdWxh
dGVkIGZyb20gdGhlDQo+ID4gZGlzcGxheWVkIGNsb2NrIGFuZCB0cSB2YWx1ZXMuDQo+IA0KPiBZ
b3VyIHJlbWFyayBpcyB0cnVlLiBJIGFsc28gcmVhbGl6ZWQgdGhhdCBCUlAgY2FuIGJlIGNhbGN1
bGF0ZWQNCj4gZnJvbSB0aGUgb3RoZXIgcGFyYW1ldGVycyBidXQgYmVjYXVzZSBJIGFtIGxhenks
IEkgbGlrZSB0byBoYXZlDQo+IGl0IHJlcG9ydGVkIHNvIEkgd3JvdGUgdGhpcyBwYXRjaC4gSSB3
aWxsIGFkZCBhIG5vdGUgaW4gdGhlIHBhdGNoDQo+IGNvbW1lbnRzIHRvIHJlZmxlY3QgdGhhdCB0
aGlzIHZhbHVlIGNvdWxkIGJlIGNhbGN1bGF0ZWQgYnkgaGFuZC4NCg0KQSBsYXRlIGNvbW1lbnQg
b24gdGhpcyAuLi4NCg0KSSBkaWRuJ3QgbWVhbiBpbiBhbnkgd2F5IHRoYXQgdGhlIEJSUCB2YWx1
ZSBzaG91bGQgbm90IGJlIHNob3duIGJlY2F1c2UgaXQgDQpjb3VsZCBiZSBjYWxjdWxhdGVkIGZy
b20gdGhlIG90aGVyIGRpc3BsYXllZCB2YWx1ZXMuDQoNCkJ1dCBJJ20gaGFwcHkgd2l0aCB0aGlz
IGNoYW5nZSBiZWNhdXNlIHRoZSBDQU4gY2xvY2ssIEJSUCwgcHJvcCBzZWcgYW5kIA0KdHNlZ1gg
dmFsdWVzIGFyZSB0aGUgaW5wdXQgcGFyYW1ldGVycyBmb3IgdGhlIENBTiBiaXRyYXRlIGNvbmZp
Z3VyYXRpb24uDQpUaGVzZSBhcmUgdGhlICJyZWFsIiBwYXJhbWV0ZXJzLg0KDQpUaGUgdHEgbGVu
Z3RoIGFuZCBiaXRyYXRlIGFyZSBvbmx5ICJkZXJpdmVkIiBvciBjYWxjdWxhdGVkIHZhbHVlcy4g
VGhlc2UNCnZhbHVlcyB1bmRlcmxpZSByb3VuZGluZyBhbmQgdHJ1bmNhdGlvbiBlZmZlY3RzIGFu
ZCBhcmUgdGhlcmVmb3JlIGxlc3MNCiJ3b3J0aCIgZm9yIHRoZSBkZXNjcmlwdGlvbiBvZiB0aGUg
Yml0cmF0ZSBjb25maWd1cmF0aW9uLg0KDQpUaGVyZWZvcmUgaXRzIG15IG9waW5pb24gaXRzIGJl
dHRlciB0byBoYXZlIHRoZSAicmVhbCIgaW5wdXQgdmFsdWVzIGJlDQpzaG93biBmcm9tIHdoZXJl
IGFsbCBvdGhlciB2YWx1ZXMgY2FuIGJlIGRlcml2ZWQuDQoNCkJlc3QgcmVnYXJkcywNCiAgICBT
dGVmYW4NCg0K
