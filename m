Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4C22D0721
	for <lists+linux-can@lfdr.de>; Sun,  6 Dec 2020 21:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgLFUhr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 6 Dec 2020 15:37:47 -0500
Received: from mail-eopbgr60101.outbound.protection.outlook.com ([40.107.6.101]:53002
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726731AbgLFUhq (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sun, 6 Dec 2020 15:37:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Se4h9Od0oU7Add7botagZqYuhr1yDVs/icIM5bRC2O32vVZ6KeAzREB3JPXxkc8U5i6lI6Y2qytG0WfZkQgKJi8m7T/o9Zh1lJfr4kpYfezt77y63XcWwg1T5ipd62iIYdPYUCFa8wg/NfDhEFMYyXD8QnmAV96RoMZzxoHB9LgvSlpb4l8kM5fE63QKNmvd0+2Rfa5qZ/1w9hgl+yIxoGpWiyKwq9FV6D/xdMwOFNGNlPJ1869ZbMuF18EsNdAFIvWvpc27Z+evgb29Be/bMGkM3LyPvag8DINDdfVI7wzSQQufk5SxbC99UhwYEzHCkY74jUps9Uu3IthE32LS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKdR8FomoptI6zAqgiIUc7VYeO1iRA9UMnvnIAfg5VU=;
 b=b+E0Nhf37Za/OLlQjOZWjHuJ46kCGUX6oOaRM/mYkzpS3nJqUmqCyf1VdINEcLcH89a5kTMTmYqL09R9Ky8518dSoDfs71m8pCDn5JGnw2MqqgCWmGQC9SwUMXq/S1p5zOErszlQBkwrNPCwucuY1UjwZa9mHHCVHqrmmBRyuOaGgxtSZPRvYaxvSklJFVCwAnKwSGb2FjXRNduEXC7FTgRoTx16Mp/Qsm54oUvypBAzqakw4uHhpMomElF1TjCsZ9vVjxr+bBenK/JvOm9mbW8HOdQT6MVoR48kZCnXxFdGvv6ETV0L0ZLjrQh6r8+2prYZi4DOXRspPSh43QiN5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKdR8FomoptI6zAqgiIUc7VYeO1iRA9UMnvnIAfg5VU=;
 b=UlEQgsC/nWNwt+hx2xD1ZUr01pngDLD3gzlG62II1sKv2WVOJ7QLRWpHsrX7gwwiR79XLtbkccms0sYDaptNnITyocrKzZg32lewlYKFsxdcytxzHZVkHCTzC+zdX8MJVOkZZJcr7RXcFV/esX/IXlwdN8NKvobGTbBg1MpwWaM=
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:12d::21)
 by DB6P190MB0326.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:31::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21; Sun, 6 Dec 2020 20:36:56 +0000
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::14dd:59d7:acaf:be4a]) by DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::14dd:59d7:acaf:be4a%4]) with mapi id 15.20.3632.023; Sun, 6 Dec 2020
 20:36:56 +0000
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: AW: AW: mcp251xfd No Oscillator (clock) defined
Thread-Topic: AW: mcp251xfd No Oscillator (clock) defined
Thread-Index: AdbLuKAjW6Ey/8Z7T1qzpJx8c3rFuwAAn6qAABKkP4AAAEmcgAAApmFQAAC/jIAAALi2cA==
Date:   Sun, 6 Dec 2020 20:36:56 +0000
Message-ID: <DB8P190MB0634B660BCFD655ED5D96E9FD9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
References: <DB8P190MB0634231494D3D788E87DCE54D9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <611813e9-943a-33be-4e9b-5cb1397ac5d9@pengutronix.de>
 <20201206192625.GB15319@x1.vandijck-laurijssen.be>
 <79e6ef83-2779-1a4a-29a1-8c34a3b52a40@pengutronix.de>
 <DB8P190MB063437FAE61F7457D031DC1FD9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <576867c2-613f-da3a-655d-beedd3027169@pengutronix.de>
In-Reply-To: <576867c2-613f-da3a-655d-beedd3027169@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=schleissheimer.de;
x-originating-ip: [62.153.209.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8093e4b0-c177-4a48-38dc-08d89a26ac98
x-ms-traffictypediagnostic: DB6P190MB0326:
x-microsoft-antispam-prvs: <DB6P190MB0326DEC7D89B8B1C62EA17B0D9CF0@DB6P190MB0326.EURP190.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OWtXja66iX1pPjp8wy6R5nA/Yi3bp63B9XLQ0e2/UiaI1NA8IypruUBo+udvbu1PYNdT0bBVsE+IQRIw0cBGFEjtBODVOr/oXHCXdBAEiU5cI8wcdC6v/49xarhuXb87QBDKxooShlUGBIhkPcFeiX69w8naNPk8HZhTY8UbYjcEGaDsYTfw/+bRQgcqVV5zGavMY47+KMUi69VeUzyzu3XZkZE72XDTB6rThK4PaElAS/d/I/5etWOyMi6BtRwCBo7K4iGzdQ1PhPxZx8+9QueSsuL1McZr7Sj0cHdEnhuNSAo4H7o8lDl9hzt/ejWJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P190MB0634.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(136003)(396003)(39830400003)(66946007)(110136005)(2906002)(33656002)(66574015)(83380400001)(26005)(76116006)(64756008)(6506007)(186003)(52536014)(7696005)(86362001)(8936002)(478600001)(55016002)(9686003)(8676002)(316002)(66556008)(5660300002)(66476007)(71200400001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Zk1FUVllRDdDSng1bzR2NlM1YWpBZGxTSW1CVFFNUVhTYlA1ckI3QWhrblBj?=
 =?utf-8?B?UUhKeHFTYXA0SG1yMDdPL01yNWRsNysxZVhQQkxvdmgxTXBNYWh1bkVoOGR0?=
 =?utf-8?B?bDAvM3MyVjlhZHZ4MkxrcHZORWk5cXk0dkJ1ekNLdEI2OU1mc1hMMW9KQjFB?=
 =?utf-8?B?QVlINXNmREZJVE5NUnNtM09TZFB3diszMDFReSszQlpRMXVZMk53UWg0a0Uv?=
 =?utf-8?B?UEdTemtwckY5WHMyckF5YVorOUc2VndWd1ZiSGJXdGdaUFVaYVo4TTlWSHBu?=
 =?utf-8?B?OXpwL3orZUZEYmFnY2JlZWVUNmduMWx0elRqZE5td3Vxb24vMTNtNXhaVlp4?=
 =?utf-8?B?U0hDdGJCRFRFTFlpcU04TzRHeitkR1JHRjZoSzFJaFEwc3hrdXBSVGYzQndt?=
 =?utf-8?B?eVMwL3VsT1NkdHNCeHR4NUVWbnpRNVE1M0J1STFXQ0hzS0F5bWhJQk5yL2Fj?=
 =?utf-8?B?ZGRRK3AzS3g2Y01vdlFLYnpzNUFiSThQNktsSkhZUHU1Y09oQVhnaGVrSUpy?=
 =?utf-8?B?Y3dYZUk1blo2RnZCWHM2aCtrVDBTNUgxM3BoTU9yUFVMRlpERDhibkFyNU1v?=
 =?utf-8?B?T2g1aXRhVy9QVXJrTmkxVXBheXp5TmFmNzJFT3NmS25FWnZWZVpETDFlQits?=
 =?utf-8?B?bXJHeGNaS2dHQjJDQUhoaVp6MnovQk9xVS9aM3NnRlU1cFdUcTNMN3NPRVh6?=
 =?utf-8?B?YjJwWU03ZUxBdnBBbnNqRm11QW1FRS9qZWlRNUNNTC9TbENYcW5wU3NIQlQ3?=
 =?utf-8?B?S0lkc0orRlNpalRGWTlNNFJpR1BIK3RTMmhYb1RQeEsrdThxbk9rUVkzbXIx?=
 =?utf-8?B?MXpIUEJNMHZ5clJVN3dmK3hiaCsvYmZoa0Z6U2FSRDBxNE1zYmtvM01lSkFu?=
 =?utf-8?B?ZHlrbFo0TlRTaHQ5NDQ1YVNvUFlGRndqeHdvVVc3RmtKbmZqc203eUE4eEVR?=
 =?utf-8?B?TlNFdVNlWnlGMEZrUUkwNEk0MDB4elY5a1BEcGh5QWkxdEtBSjNEc1I2Ylgy?=
 =?utf-8?B?RCtLdmRrWHRxUENJdmN5bEIwd1lraG1FdG9hemJ0NGx0WWVXbG5JMlpobk02?=
 =?utf-8?B?WUUwU3F4WHJkM3RhSmVQMHluQ2lzcWt1UTRBakE1L3huSWFhWU1OT3ZOSFBn?=
 =?utf-8?B?UmJ5UWEyb3NIYUJzamJMbkRYV2FvZ3lHdVVOeWRtZWp4TnFhSVM3cktmbHpn?=
 =?utf-8?B?MWVVNThwdTdlZ0JGWFVNaFd3MlVyZVZQQUdJcC8rWnVXaUlqb21JNDEyT05q?=
 =?utf-8?B?NE41N0pRTE9HRzdaRlJqV0FzUTFPVWRQMGhDc2VmNEViSUc5Z05sVm4rTThE?=
 =?utf-8?Q?Pu0+VLJGpPdoU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8093e4b0-c177-4a48-38dc-08d89a26ac98
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2020 20:36:56.5547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2CJ+AuwcatILN7q9r4xP3udyiPVu0KXmU9qT29km++W8euraF4/rDn0xJBkAVTR96oKcRD3n8kwLEfH7HdIv75J0ar6HTP+oMs2sd0CTN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6P190MB0326
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiAtLS0tLVVyc3Byw7xuZ2xpY2hlIE5hY2hyaWNodC0tLS0tDQo+IFZvbjogTWFyYyBLbGVpbmUt
QnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gR2VzZW5kZXQ6IFNvbm50YWcsIDYuIERlemVt
YmVyIDIwMjAgMjE6MTUNCj4gPj4gQXMgaXQncyBub3cgd29ya2luZyBpbiBnZW5lcmFsLCBTdmVu
IGNhbiB0ZXN0IGZyb20gc2V0dXAgdW5kZXIgTGludXguDQo+ID4NCj4gPiBpZiBJIHRyeSB0byBs
b2FkIHVuZGVyIGxpbnV4IHdpdGg6DQo+ID4gc3VkbyBkdG92ZXJsYXkgbWNwMjUxeGZkIHNwaTAt
MCBpbnRlcnJ1cHQ9MjUNCj4gPg0KPiA+IEkgZ2V0Og0KPiA+IFsgICAzNi4xNTQ1NDhdIENBTiBk
ZXZpY2UgZHJpdmVyIGludGVyZmFjZQ0KPiA+IFsgICAzNi4xNTg2NDRdIG1jcDI1MXhmZCBzcGkw
LjA6IE5vIE9zY2lsbGF0b3IgKGNsb2NrKSBkZWZpbmVkLg0KPiANCj4gVGhlIGNsb2NrIGlzIG1p
c3NpbmcuIExldCdzIHNlZSBpZiBpdCBpcyBhZGRlZCB0byB0aGUgRFQuDQo+IA0KPiBEbyBhIGRp
ZmYgb2YgdGhlIERUIGJlZm9yZSBhbmQgYWZ0ZXIgYXBwbHlpbmcgdGhlIG92ZXJsYXkuDQo+IA0K
PiB8IHN1ZG8gZHRjIC1JIGZzIC9wcm9jL2RldmljZS10cmVlIC1vIGJlZm9yZQ0KPiB8IHN1ZG8g
ZHRvdmVybGF5IG1jcDI1MXhmZCBzcGkwLTAgaW50ZXJydXB0PTI1DQo+IHwgc3VkbyBkdGMgLUkg
ZnMgL3Byb2MvZGV2aWNlLXRyZWUgLW8gYWZ0ZXINCj4gfCBkaWZmIC11IGJlZm9yZSBhZnRlcg0K
PiANCj4gU2VuZCB0aGUgb3V0cHV0IG9mIHRoZSBkaWZmLg0KSGVyZSBpcyB0aGUgZGlmZjoNCi0t
LSBiZWZvcmUJMjAyMC0xMi0wNiAyMDozMTo0MC40MzAzNjExMTkgKzAwMDANCisrKyBhZnRlcgky
MDIwLTEyLTA2IDIwOjMyOjM1LjkzOTY1NjI0MyArMDAwMA0KQEAgLTM1LDYgKzM1LDEzIEBADQog
CQkJY2xvY2stZnJlcXVlbmN5ID0gPCAweDMzN2Y5ODAgPjsNCiAJCX07DQogDQorCQltY3AyNTF4
ZmQtc3BpMC0wLW9zYyB7DQorCQkJY29tcGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7DQorCQkJI2Ns
b2NrLWNlbGxzID0gPCAweDAwID47DQorCQkJcGhhbmRsZSA9IDwgMHhkZSA+Ow0KKwkJCWNsb2Nr
LWZyZXF1ZW5jeSA9IDwgMHgyNjI1YTAwID47DQorCQl9Ow0KKw0KIAkJY2xrLXVzYiB7DQogCQkJ
Y29tcGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7DQogCQkJI2Nsb2NrLWNlbGxzID0gPCAweDAwID47
DQpAQCAtMTAyOSw2ICsxMDM2LDEyIEBADQogCQkJCWJyY20sZnVuY3Rpb24gPSA8IDB4MDQgPjsN
CiAJCQl9Ow0KIA0KKwkJCW1jcDI1MXhmZF9zcGkwXzBfcGlucyB7DQorCQkJCWJyY20scGlucyA9
IDwgMHgxOSA+Ow0KKwkJCQlwaGFuZGxlID0gPCAweGRkID47DQorCQkJCWJyY20sZnVuY3Rpb24g
PSA8IDB4MDAgPjsNCisJCQl9Ow0KKw0KIAkJCXVhcnQxX3BpbnMgew0KIAkJCQlicmNtLHBpbnM7
DQogCQkJCXBoYW5kbGUgPSA8IDB4MTUgPjsNCkBAIC0xNTQ2LDYgKzE1NTksMTggQEANCiAJCQlk
bWFzID0gPCAweDBiIDB4MDYgMHgwYiAweDA3ID47DQogCQkJcGluY3RybC1uYW1lcyA9ICJkZWZh
dWx0IjsNCiANCisJCQltY3AyNTF4ZmRAMCB7DQorCQkJCWNvbXBhdGlibGUgPSAibWljcm9jaGlw
LG1jcDI1MXhmZCI7DQorCQkJCWNsb2NrcyA9IDwgMHhkZSA+Ow0KKwkJCQlpbnRlcnJ1cHQtcGFy
ZW50ID0gPCAweDBmID47DQorCQkJCWludGVycnVwdHMgPSA8IDB4MTkgMHgwOCA+Ow0KKwkJCQlw
aGFuZGxlID0gPCAweGRmID47DQorCQkJCXJlZyA9IDwgMHgwMCA+Ow0KKwkJCQlwaW5jdHJsLTAg
PSA8IDB4ZGQgPjsNCisJCQkJc3BpLW1heC1mcmVxdWVuY3kgPSA8IDB4MTMxMmQwMCA+Ow0KKwkJ
CQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KKwkJCX07DQorDQogCQkJc3BpZGV2QDEgew0K
IAkJCQljb21wYXRpYmxlID0gInNwaWRldiI7DQogCQkJCSNhZGRyZXNzLWNlbGxzID0gPCAweDAx
ID47DQpAQCAtMTU1Nyw2ICsxNTgyLDcgQEANCiANCiAJCQlzcGlkZXZAMCB7DQogCQkJCWNvbXBh
dGlibGUgPSAic3BpZGV2IjsNCisJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCQkJI2FkZHJl
c3MtY2VsbHMgPSA8IDB4MDEgPjsNCiAJCQkJI3NpemUtY2VsbHMgPSA8IDB4MDAgPjsNCiAJCQkJ
cGhhbmRsZSA9IDwgMHhhNiA+Ow0KDQogIFN2ZW4NCg0KLS0NClN2ZW4gU2NodWNobWFubg0KU2No
bGVpw59oZWltZXIgU29mdC0gdW5kDQpIYXJkd2FyZWVudHdpY2tsdW5nIEdtYkgNCkFtIEthbGtv
ZmVuIDEwDQo2MTIwNiBOaWVkZXItV8O2bGxzdGFkdA0KR0VSTUFOWQ0KUGhvbmU6ICs0OSA2MDM0
IDkxNDggNzExDQpGYXg6ICs0OSA2MDM0IDkxNDggOTENCkVtYWlsOiBzY2h1Y2htYW5uQHNjaGxl
aXNzaGVpbWVyLmRlDQo=
