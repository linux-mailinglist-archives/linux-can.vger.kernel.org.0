Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB5D2D0703
	for <lists+linux-can@lfdr.de>; Sun,  6 Dec 2020 20:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgLFT4y (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 6 Dec 2020 14:56:54 -0500
Received: from mail-eopbgr80109.outbound.protection.outlook.com ([40.107.8.109]:57801
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbgLFT4x (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sun, 6 Dec 2020 14:56:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dG334ie4Ly4VUiygfnfYhqxJJnZky/x1FABinr61iolHhtlHTLpok+zPckVu3YLFLwLBs0JwbBUpfZvm36X/DR1J6LEiBRuUOXK4oKxB4uK/bTbiVbFRgGDHkmE6MF6Jnv6z4DUVVWazwa+bWfVMLU+tTlZJA8VIjUlWN4yp7Syo0k4//a8LkiTy1N3UGZ/TRD6L/Apgz+CZ5MsNGeTLE+Ov1okbDbUJ/KEBdgzuccGfluG2JkopwODZftUJuH5DAbO5yCeCiME6tkI6H465Q8iOuTdLYf9PR0N/qBt8OX0ek5tCQvadpKTv3vecsF6O/PBY/SJix8XMWw+lsnnWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqwI8llnN4EsjNjOZ20DmgxrmlBTNey3vDnWrtLgVQE=;
 b=mLNppm9boX36n++eTjhjtBa6C2r8z9TzQYfE80ges2VdSN+Ph2aF7vJF5ZGbnq2k50WXGEbNYIEig4YhJy4C1x844mIucmKZeujyVIl1bmb7mUxImKg6H0C3A6XHB6bn8bsaAC4RIBZjdXz91xfNUyE/Mts+hFRLGqj51Jo84f6RHi80z6x2zvbijccsLy+O8L6icvM4QZIqqU4AAK3ok2kBAxaBAPplmJyDEj7mHh4xr2nahIk0s7wDuD5myvUC6WmmlJAnkId5jj8fa1nUIM8q409t0gsNUCIKyrOQub2DdeNpDFgng/AIY2oEmh3U1j1H3YK+yfXIVpP+XYljuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqwI8llnN4EsjNjOZ20DmgxrmlBTNey3vDnWrtLgVQE=;
 b=f7e1exVgM4hpayY0AN8wiIhapRiStpEdZTWzR34Hdf+8EzwWbXs4jLdwjLnNJXS5ofeIO/TDcWxQhJ2VeQG6nJ9rA9LLTS9NU60xUiVUowSEXIc9EBM2Gk/AOqLiqGwHpQLHKgs/j6k9Xag7T8ddrNPbq7qKonLPY0akOpUou00=
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:12d::21)
 by DB6P190MB0438.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:31::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Sun, 6 Dec 2020 19:56:03 +0000
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::14dd:59d7:acaf:be4a]) by DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::14dd:59d7:acaf:be4a%4]) with mapi id 15.20.3632.023; Sun, 6 Dec 2020
 19:56:03 +0000
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: AW: mcp251xfd No Oscillator (clock) defined
Thread-Topic: mcp251xfd No Oscillator (clock) defined
Thread-Index: AdbLuKAjW6Ey/8Z7T1qzpJx8c3rFuwAAn6qAABKkP4AAAEmcgAAApmFQ
Date:   Sun, 6 Dec 2020 19:56:03 +0000
Message-ID: <DB8P190MB063437FAE61F7457D031DC1FD9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
References: <DB8P190MB0634231494D3D788E87DCE54D9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <611813e9-943a-33be-4e9b-5cb1397ac5d9@pengutronix.de>
 <20201206192625.GB15319@x1.vandijck-laurijssen.be>
 <79e6ef83-2779-1a4a-29a1-8c34a3b52a40@pengutronix.de>
In-Reply-To: <79e6ef83-2779-1a4a-29a1-8c34a3b52a40@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=schleissheimer.de;
x-originating-ip: [62.153.209.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 629090f4-d7da-4ca3-8505-08d89a20f693
x-ms-traffictypediagnostic: DB6P190MB0438:
x-microsoft-antispam-prvs: <DB6P190MB04380565395DCCDA532753E0D9CF0@DB6P190MB0438.EURP190.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iHnrLof5gG0tho4OJYPzwQR7zi/uzcca5sBf23ufzbO1SIyFTRmXNbu/zI9gvs7xyQnqqZSBZn3w01V/mUDytLGvik8M14ooVOj5+se0XIw5xLSZkNvgxIWFGQ1X9gNrTVaO1ItCFwX0MmBZZPN2ObOgyDTLggwZP75iwJBeYrLcByGrtXR1fre30FBEkL6D+K+L9zqTnBY1mPRgpMI2OH5B+eTNgD8oWLZD+o8AjvbNFE+2MNXAMF4q2mljGrqCeppmqPk8Y9CT3AZ9XO/lSekw8GkGibcDhSwhpoawoDA2h3Ab+FVs0ZeFnbzsgaFu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P190MB0634.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(376002)(39830400003)(396003)(186003)(6506007)(316002)(71200400001)(110136005)(33656002)(53546011)(9686003)(55016002)(66476007)(66556008)(8676002)(5660300002)(76116006)(52536014)(66946007)(64756008)(26005)(66446008)(478600001)(8936002)(86362001)(7696005)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aU9XV0hFQTBKb2hhQUJ0cHNiQnQ3Ly9VSG1nbVBUMUcxdjQ2L2lLcDBqeEYz?=
 =?utf-8?B?eEo4YndyTEJWQ3BGdGRnTFBCQWNtRHZpckFRZGxVNWtaOTNDSkZmTnZqTmFW?=
 =?utf-8?B?NHQwNXR0YmZQcU5yUWRLcnNXM2hlckhLRFR4ZTNQRy81bEI3cGdzRTZMVWJC?=
 =?utf-8?B?RkJaditkd0FGU0V2b0laUktzdGFubUgraGFZVmVRS0V3NFhmOHU3Vjd0TWJo?=
 =?utf-8?B?QW55S0R0eUNOVVlUNXdEQmpyL2tZekZsazQ0Z1pPd3dHcUd5RVlFeHpYNzJN?=
 =?utf-8?B?dlIwZ1JLUDFiblQvQUY3dGtXZmZueURZMFBiOTR4M0pOSGpWaTk1N0lHeldt?=
 =?utf-8?B?MnpId3hGYUY0YXRVYTRISmtFUnRub1hBR0lXMWFlTHFYdjZGOVUyZjUweW9n?=
 =?utf-8?B?Nk9kNDZIMFBNY2FaUWorTThkNEtoLzRlTU1XaDVnVUpKay9VTkd4VUllbGhp?=
 =?utf-8?B?TEx4OTBlNUw2ZHo2NjY1MW1OT3F3QlR0OFJXd002dWRoU1NqNGt4NGJ0Nmto?=
 =?utf-8?B?TEpQTDVCWDk5NXFyOVgzeGdKei9PcjUrRkNRbk1GVHprdEV6RXFnNlR0RndR?=
 =?utf-8?B?YVNQNExIemFiM0s3ZFMrL1M1YXVHdTE5NlR1eThuU2hCMmd2cmlrU0hDQllB?=
 =?utf-8?B?clBNVzBJYXN1UTRJTW1EU3VvNGpYSk1YeDVuWnY2WG14STdPWnFkbkhETSs2?=
 =?utf-8?B?Vkh2RHZTOTdncGYzaFNDN1gyVXl1V2pHd3NyQzRJazNnZVJ2c3RwTkhiOWNS?=
 =?utf-8?B?TFk4YXl0N1FFQVYrWmVZMkx0WEZsQkNUNHVlRWVQWXpOb0dGK3dUczZyVjB1?=
 =?utf-8?B?Y0VlU2FvbTBpYjlIWGNEUUswYS9nUHlmdDZ1aFVjRE1mM0t0TkQram5OK3NU?=
 =?utf-8?B?LzdmZTc0ZHJNMk1wUWNQZVo1YnFTM0lFbVZBcUJKVEg4dS8zZWRrVjMvWUpX?=
 =?utf-8?B?UFh5WkUwSSs1WDhNU0Y1bUQ1dlN0Sy9zbHE3V1ZNNVV2SlVPV1NIK3p2TjAx?=
 =?utf-8?B?b3VaUTlNb3BaYmVkeWhxdm5sTlcvVTN3MnN2V1ROdXFweFFNTndvV0JzM3pk?=
 =?utf-8?B?MitaVU1WTm00MjNCcDBYN0xJWGRGaUM4Tlk1cHR4eTdoaHQwelU3ZDAxWnI4?=
 =?utf-8?B?UTZYd0lsT0ptYktUa2Q2NjhhN1hHNUxBYndISTZNMnRvQTlSNmdRdXI2TTU4?=
 =?utf-8?B?a2NPaWVCZExUU2w1TVRwMmZSRTRsWUorZWlRalZDWTlZVkVzSU1BSTFIRk5V?=
 =?utf-8?B?bERmbnp6TzgrNFVIY1hKWXREendrazZyRkhBeSttYU83cXZ6VHh3UnFjOXFY?=
 =?utf-8?Q?/YhOmx1ygz1PE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 629090f4-d7da-4ca3-8505-08d89a20f693
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2020 19:56:03.8543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3tJz6wtG6oXNu0aavtNtTtO0mzsH5i1gcSX9B9tk7uGJoPxVJ0tojf8IE36UI2L8ngmYJ7mZckkTXUmyKQDiq8B/CrmanD3FyaOChr5Y+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6P190MB0438
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiAtLS0tLVVyc3Byw7xuZ2xpY2hlIE5hY2hyaWNodC0tLS0tDQo+IFZvbjogTWFyYyBLbGVpbmUt
QnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gR2VzZW5kZXQ6IFNvbm50YWcsIDYuIERlemVt
YmVyIDIwMjAgMjA6MzUNCj4gQW46IFN2ZW4gU2NodWNobWFubiA8c2NodWNobWFubkBzY2hsZWlz
c2hlaW1lci5kZT47IGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmcNCj4gQmV0cmVmZjogUmU6IG1j
cDI1MXhmZCBObyBPc2NpbGxhdG9yIChjbG9jaykgZGVmaW5lZA0KPiANCj4gT24gMTIvNi8yMCA4
OjI2IFBNLCBLdXJ0IFZhbiBEaWpjayB3cm90ZToNCj4gPiBPbiBTdW4sIDA2IERlYyAyMDIwIDEx
OjMyOjM5ICswMTAwLCBNYXJjIEtsZWluZS1CdWRkZSB3cm90ZToNCj4gPj4gT24gMTIvNi8yMCAx
MToxOCBBTSwgU3ZlbiBTY2h1Y2htYW5uIHdyb3RlOg0KPiA+Pj4NCj4gPj4+ICQgc3VkbyBkdG92
ZXJsYXkgc3BpMC0xY3MgY3MwX3Bpbj0yNA0KPiA+Pj4gJCBzdWRvIGR0b3ZlcmxheSBtY3AyNTF4
ZmQgc3BpMC0xIG9zY2lsbGF0b3I9NDAwMDAwMDAgc3BlZWQ9MjAwMDAwMDAgaW50ZXJydXB0PTE4
DQo+ID4+DQo+ID4+IEJldHRlciBhZGQgdGhlIG92ZXJsYXlzIHN0YXRpY2FsbHkgaW4gdGhlIGJv
b3Rsb2FkZXIgdmlhIGNvbmZpZy50eHQ6DQo+ID4NCj4gPiB3aHkgaXMgaXQgYmV0dGVyIGluIHRo
ZSBib290bG9hZGVyIHRoYW4gZnJvbSBsaW51eD8NCj4gPg0KPiA+IEkgcGVyc29ubmFseSBmYXZv
ciBsb2FkaW5nIG92ZXJsYXlzIGZyb20gbGludXgsIHdoZXJlIHRoZXJlIGFyZSB3YXkgbW9yZQ0K
PiA+IHBvc3NpYmlsaXRpZXMgdG8gZGV0ZXJtaW5nIHdoaWNoIG92ZXJsYXlzIHRvIGxvYWQuDQo+
IA0KPiBJIG9ubHkgdGVzdGVkIHRvIHNldHVwIHRoZSBvdmVybGF5cyBmcm9tIGNvbmZpZy50eHQN
Cj4gDQo+IEFzIGl0J3Mgbm93IHdvcmtpbmcgaW4gZ2VuZXJhbCwgU3ZlbiBjYW4gdGVzdCBmcm9t
IHNldHVwIHVuZGVyIExpbnV4Lg0KDQppZiBJIHRyeSB0byBsb2FkIHVuZGVyIGxpbnV4IHdpdGg6
DQpzdWRvIGR0b3ZlcmxheSBtY3AyNTF4ZmQgc3BpMC0wIGludGVycnVwdD0yNQ0KDQpJIGdldDoN
ClsgICAzNi4xNTQ1NDhdIENBTiBkZXZpY2UgZHJpdmVyIGludGVyZmFjZQ0KWyAgIDM2LjE1ODY0
NF0gbWNwMjUxeGZkIHNwaTAuMDogTm8gT3NjaWxsYXRvciAoY2xvY2spIGRlZmluZWQuDQoNCiAg
U3Zlbg0KLS0NClN2ZW4gU2NodWNobWFubg0KU2NobGVpw59oZWltZXIgU29mdC0gdW5kDQpIYXJk
d2FyZWVudHdpY2tsdW5nIEdtYkgNCkFtIEthbGtvZmVuIDEwDQo2MTIwNiBOaWVkZXItV8O2bGxz
dGFkdA0KR0VSTUFOWQ0KUGhvbmU6ICs0OSA2MDM0IDkxNDggNzExDQpGYXg6ICs0OSA2MDM0IDkx
NDggOTENCkVtYWlsOiBzY2h1Y2htYW5uQHNjaGxlaXNzaGVpbWVyLmRlDQo=
