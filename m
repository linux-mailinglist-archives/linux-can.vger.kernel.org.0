Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F181C3C26A0
	for <lists+linux-can@lfdr.de>; Fri,  9 Jul 2021 17:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhGIPKH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Jul 2021 11:10:07 -0400
Received: from mail-eopbgr20110.outbound.protection.outlook.com ([40.107.2.110]:32214
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232244AbhGIPKG (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 9 Jul 2021 11:10:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGpR/o5oOdYnjhu8YhEPDpnOFmgYMqOm+xrmAF2W+aLUjnoLbM91VEIYTfNY+YM96Kk2xIKkPYV37K/R/v/aDbelWX9V22c2FFMYNl5NonSwj8ONSjKSwxnnNuL+ssA+TG/IulmlYHtVcr4F6oKyJqv2mpZ4NCTHEmImXzFVx4XoNxy1c3rwaOsCiFZAz8CP/awRfNY9y6t6itIPzIEKQFXsBf/QUzAh3oKZBob4PJELwZfhcmJpw+ITGsidF1aWvgKie5QPO0d7eene2S7MB1UGBMNQmbTcYBsbUexqXca+qTwhMSUnWjAHqaHv/P3fDOHbomq/U/RCQ/vC23Cmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbsjDK8BK5WRjfCRgXwd/b0fVuH6UcynXt63/fp+Rmk=;
 b=GN6wl2dNBut5L4yptW8nAR6eVN7+v7Pm/k5rFTyMOktS+bF4G6wUDb7Dnj+0FSnbzDAQawNxB/ZwCmri3FQPS4L7dGKwy1yuaQ8Elc+Fjuv/dfBx6ekpiV4u8zUW85Ma3QT4tYitdMIVI7QKiORARD4WYCWuTUGpHn/QsVDpw+KfxMXvRdnVFXFySKgrluvRM+/A5P2lGsardYWSA+vaFe/iO6MYLoiAJHbx0aSJTHhEiq80UxBlSxnYEjGrn5rqbWM41rrkz4+vKUgbCzDl2kX6O0n1rL58KX0C4LRhuqSTLaov3HbiER18HDCmu8FTiiuO/k1iPcJhzrU0Ka+hyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbsjDK8BK5WRjfCRgXwd/b0fVuH6UcynXt63/fp+Rmk=;
 b=Qe4M5C3N4L557/1RlYhW3+USaN+/adfvrmXxCWJvb4s8AegtIGfBNeHrCaIZJQXy6t2vpzvtbM6ww6noYQxS0LNkYZIx3x+tNl44I5BXee4QnskLeSdMT5s5HNloe+xGJOBzBjiGRILCtOz0vH7q5eGecrT7ys6GWzKFrz7m2I8=
Received: from AM9PR03MB6929.eurprd03.prod.outlook.com (2603:10a6:20b:287::7)
 by AM0PR0302MB3362.eurprd03.prod.outlook.com (2603:10a6:208:3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Fri, 9 Jul
 2021 15:07:20 +0000
Received: from AM9PR03MB6929.eurprd03.prod.outlook.com
 ([fe80::6872:4ae0:6563:df20]) by AM9PR03MB6929.eurprd03.prod.outlook.com
 ([fe80::6872:4ae0:6563:df20%3]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 15:07:20 +0000
From:   =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <Stefan.Maetje@esd.eu>
To:     "engnfrc@gmail.com" <engnfrc@gmail.com>,
        "mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: ip link valid options checking
Thread-Topic: ip link valid options checking
Thread-Index: AddzV6mHoqDJXZTYR7O82+vlM/59OABYmgkAAAaCsoA=
Date:   Fri, 9 Jul 2021 15:07:20 +0000
Message-ID: <b1da5bb9b940c7cb262184ec828568a38af8f5af.camel@esd.eu>
References: <002501d77357$d93c36b0$8bb4a410$@gmail.com>
         <CAMZ6RqLWLPtviMJHOXQJEc430cUPnZeP3N8BdvnV6_dLHYFTpg@mail.gmail.com>
In-Reply-To: <CAMZ6RqLWLPtviMJHOXQJEc430cUPnZeP3N8BdvnV6_dLHYFTpg@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5d1b934-c422-4be2-7aa0-08d942eb3fd0
x-ms-traffictypediagnostic: AM0PR0302MB3362:
x-microsoft-antispam-prvs: <AM0PR0302MB336202936E12229FF6D909D281189@AM0PR0302MB3362.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b7ukM/VVnxkkc6wM+DkYhHVofOU+DH6hD+m1GGCoNWGzUxBQ8FqxWoegm49ggFfmGFR4MTDEMdTZS6/MKmvY8RlUDeqdI5X3yiKEV7tnANqDScZFq+XhR6BhFwRYwqQtuL2VEdBU1jwIz+7OEBw+BS6EzvAqCQYeLncBrUbapmsH5e/C/J9Y5BJhlE/oTjqz5m5F/JVi2m+1M8t65uf7Q403B6FCG23gB2cEV5yD/DPghNB920AXwmnVZaNjI8MfSYxXbRn71Cto5k6NH2p2aIffN+k/d4N+uthWnPnRMj6w5SC9W7xKw06aSjdEUpIGNeb0IKOpolh8c3XcWl41by7B+wwJ8Z6Elqzpct9s4fHnfDWumqj5bzETSbhIfpi8+HJ4oqYcIzn1AV99cWHHXjICSw8WaVoEP1s/u2pC1dDHR0Sy19FoxCqPkmUIMtZNL8Q8AVMCDEgpNx883wrhvbVrhLE8QBfyKZAxT0k8hT4YIGBnPZ4/9dYFnlxDc1mXlRDTZt9INicGuJibLiQQuWjU68CnQyxS8ftrDCrVETY9yAPPk89UpONEeCjuIAmDWEia0+3revRX5dS6ARin0GoTVo8vb4+ZlSFkFU8vJ1mDApTj22sNniwjKhNrht25PxbG5tKPc8L3j1wbR97n/z86Nb/A1yKOm6gxUPfNsGMIw3hJBbXA6Upm525//a1ht7N8zkIU9Ee+WyaP1Rcji/bUfxIZA0zj15aZpkEk5XpZEYuIOgP439tArQ/EbLGegeLD3NkCZTClYnihXaIudVA+yd3Kny0hr5aQHEtf+/g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR03MB6929.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(346002)(376002)(39830400003)(6512007)(6506007)(478600001)(71200400001)(83380400001)(8676002)(86362001)(8936002)(64756008)(66446008)(186003)(316002)(6486002)(66556008)(966005)(26005)(2906002)(4326008)(36756003)(122000001)(76116006)(5660300002)(66476007)(66946007)(85202003)(2616005)(85182001)(110136005)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1dsdmJ5M09tQ3ArRCttUm5sSjNtaG9JVlFKM05hdHkxWURMa0FDMXVMeXN0?=
 =?utf-8?B?czBmTTNoM25hQmZmWURML2svV1g2US9CNm5YeG1xb1dodGY1NjY3QUNHckMy?=
 =?utf-8?B?d2RqWFBwdUwzNmdwc0w3Y3JZV0JHQlYwUDdURWhGNWxlb2ZRYnRicGhJQkI2?=
 =?utf-8?B?SGdoaWdlQlNnQlk4aldLc2ZkY0t4T242TmtIK0I1ODZwQTZmcFI2QjlLU3oy?=
 =?utf-8?B?ZUo2SWdjbU5ncVBaQWo1b1ZIU2V2ZmNxQzdsUndHTS9FZ1FxQmExdXErR1No?=
 =?utf-8?B?VlBiUVFWVXJvL0VSbi8vdGZXSEo0YnAwc3hLUG82UEtYeDVLUEExaGtPTHFm?=
 =?utf-8?B?eER1T1BOdDhzREsrS2hmWXFBSU1LT09EUXlPVWhVdHNJWTFrdkZJUVNvc1lv?=
 =?utf-8?B?SmJyUE81ZTlZNnlvL0pVNURXWGY5cWVwMm5EMTFrNUJmekY4OU95TTUvU0ZS?=
 =?utf-8?B?M0hrYXZZZGUrMXdiYkNoc1g5M0xnVDZIck5ncnk5V2JpSHVoMjdyMVdhZ0c3?=
 =?utf-8?B?UXdHN0ZpcngzZGxBckkrbGt5dGY0QVZpRDJvRGhrOWhWbVRVUVk4WFdVK1dD?=
 =?utf-8?B?UmVtaGxYWThrdXZMbG5HSm1YVTFlaXRsU0JIVDVtMjlCYldXR2I1ODJFQU5m?=
 =?utf-8?B?a0RzZjFxNmpWaWNmMFZuNTNqejArd1prMkF6RjVVSExwQWhMQTV0ZGVHTUc4?=
 =?utf-8?B?R3lKbm8yeDJuUVFpRTU5N3JnTkMwd3JtdjM1eW1WWW1Xb3YxYXpwelMza3I2?=
 =?utf-8?B?MHRDMXFMN1VaUU5wQndBZjBtSEFaZUNzOHNoVjMyeW1EeWFFQ2FNellRNmtH?=
 =?utf-8?B?dUxRdjV5dHl5K1IwYTRDcDk3clNWbVhWTHdmSHNSVnd5YXBRQWRrOGJKTjA5?=
 =?utf-8?B?MGdQaFdrTzU0bHFNbDR1ZlEvakpzdGQ3UldDbGpxOHl0RWgyTDNMd0MxRUV3?=
 =?utf-8?B?NzhsMjBTbkZNandYZ2s0YUgyTHVyTXhDUUNSSnJzQVk5dUpKVTdpVzRXeURE?=
 =?utf-8?B?RXJkYjJkWjdubGcwaVd5U2t0N0luN3RNdGZyZDlaaEx5Q0dOdlppV0hnYThY?=
 =?utf-8?B?dmNGYUNVMEZiZVRENVFCQjF4V290MUVFVHAzSi9vTE0yUHJtOTRScXkxcFRH?=
 =?utf-8?B?WiswOTlHV284Zm54N0ZPS0ZjTHdZTTc5eFZCRUIrZXB3dVU0TlhqSlgzWVo4?=
 =?utf-8?B?TU54VFhrWWFycmV6QktSNGFjWTRZMzFodDdzdnFGM0oxT2djZ2ZYbzBCZEJv?=
 =?utf-8?B?QnVEZjdwbTJyTm9yd1lnSmhYMkViamRITUpFelpIakpXNXJUT2FYVGJWUWYv?=
 =?utf-8?B?UUJpNFVLTDFTUTUzT0FkTlNlZ1cwM2dHbHAzRzlLR3dtZFlQN1JpZ05EMDE4?=
 =?utf-8?B?SURWdzg4eWJhNXNEUm43aXlKMnh5c2hKOGxoekhFZStKaHBTbWYrdXRXWHEz?=
 =?utf-8?B?eHBzQ2xCallhMFY3eUpIYUo5V1lCWFZWckNnREN1ZmdqWkVPUTlQK2dQUWdO?=
 =?utf-8?B?MEJnai9LQ2hSOGwvb20zejlFb3luMDZwTnVEbmZaaFFxYStzOWVZcGRHZWZD?=
 =?utf-8?B?M250S2hNSU1UOGdnQUN1OVp1dWh4aFFYS2VwYmc4YTV2L0wxeGtiQnVOcnBU?=
 =?utf-8?B?UmFWNHQweHl6citmZlZIZ2JmQUg2ZEYraEJlQVNMK3dsQk85SmpKRXlhb2Rn?=
 =?utf-8?B?SlVYZmFNenRKVlVwSlRUTE56aGZhWGIxc3hFWmRJNVdYMHl6ZDRNOEdjWU0v?=
 =?utf-8?Q?FdnAzKHV8tX3mN2MUBvOqKzjHSpjEMx22XNRWm1?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <43BABC2BA6CF804C945E6D01F3560999@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR03MB6929.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d1b934-c422-4be2-7aa0-08d942eb3fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 15:07:20.3497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XkblUpOz7+ZCEohhz7/bMQ+pd3LCepIFfWV8Yuf1HiqWF3h2o31V98uv6/w7XYtbvLm0DEhDqrPlPurNnQhQnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0302MB3362
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

QW0gRnJlaXRhZywgZGVuIDA5LjA3LjIwMjEsIDE0OjAwICswMjAwIHNjaHJpZWIgVmluY2VudCBN
QUlMSE9MOg0KPiBPbiBXZWQuIDcgSnVsIDIwMjEgYXQgMTk6NDUsIEpvc2h1YSBRdWVzZW5iZXJy
eSA8ZW5nbmZyY0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+IEdvb2QgQWZ0ZXJub29uLA0KPiA+IA0K
PiA+IERvIGFueSBvZiB5b3Uga25vdyBhIHdheSB0byBjaGVjayB3aGF0IG9wdGlvbnMgYXJlIHZh
bGlkIHdoZW4gc2V0dGluZyB1cCBhDQo+ID4gQ0FOIGRldmljZSB3aXRoIHRoZSBpcCBsaW5rIGNv
bW1hbmRzLCBlaXRoZXIgZnJvbSBiYXNoIG9yIHRocm91Z2ggQysrPyBJJ20NCj4gPiB3b3JraW5n
IG9uIGEgcGllY2Ugb2YgY29kZSB0aGF0IHdpbGwgZ2V0IHVzZWQgb24gc3lzdGVtcyB3aXRoIHZh
cnlpbmcgQ0FODQo+ID4gZHJpdmVycyBhbmQgZm9yIGluc3RhbmNlIG9uZSBvZiB0aGVtIGRvZXNu
J3Qgc3VwcG9ydCBDQU4tRkQsIHNvIGhvdyB3b3VsZCBJDQo+ID4gYmUgYWJsZSB0byBrbm93IHRo
YXQgc2V0dGluZyB0aGUgZmQgZmxhZyBvciBkYml0cmF0ZSB2YWx1ZSB3b3VsZCBmYWlsIGJlZm9y
ZQ0KPiA+IGNhbGxpbmcgdGhlIHNldHVwIGNvbW1hbmQgYW5kIHNlZWluZyBpdCBmYWlsPw0KPiAN
Cj4gSSB3b3VsZCBzdWdnZXN0IHRvIHVzZToNCj4gPiBpcCAtLWRldGFpbHMgbGluayBzaG93IGNh
bjANCj4gDQo+IFlvdSBjYW4gdGhlbiBwYXJzZSB0aGUgcmVzdWx0cyB0byBjaGVjayBpZiB0aGUg
ZGF0YSBiaXRyYXRlDQo+IGluZm9ybWF0aW9uIGlzIHByZXNlbnQuIElmIHNvLCBpdCBtZWFucyB0
aGF0IEZEIGlzIHN1cHBvcnRlZC4NCj4gQWxzbywgdGhlIG91dHB1dCBtaWdodCBiZSBlYXNpZXIg
dG8gcGFyc2UgaWYgZm9ybWF0dGVkIGluIGpzb246DQo+ID4gaXAgLS1kZXRhaWxzIC0tanNvbiAt
LXByZXR0eSBsaW5rIHNob3cgY2FuMA0KPiANCj4gQWx0ZXJuYXRpdmVseSwgaW5zdGVhZCBvZiB1
c2luZyB0aGUgY29tbWFuZCBsaW5lLCB5b3UgbWlnaHQNCj4gcHJlZmVyIHRvIGRpcmVjdGx5IHVz
ZSB0aGUga2VybmVsIG5ldGxpbmsgaW50ZXJmYWNlIHRvIGRpcmVjdGx5DQo+IHJldHJpZXZlIHRo
ZSBkaWZmZXJlbnQgbW9kZXMgc3VwcG9ydGVkIGJ5IHRoZSBjb250cm9sbGVyLg0KPiBZb3UgY2Fu
IHJlZmVyIHRvIGlwcm91dGUyIHNvdXJjZSBjb2RlIGZvciB0aGUgaG93LXRvOg0KPiANCmh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9uZXR3b3JrL2lwcm91dGUyL2lwcm91dGUyLmdpdC90
cmVlL2lwL2lwbGlua19jYW4uYyNuMjgyDQo+IA0KDQpVbmZvcnR1bmF0ZWx5IHRoZSBuZXRsaW5r
IGtlcm5lbCBpbnRlcmZhY2UgZ2l2ZXMgYWNjZXNzIG9ubHkgdG8gdGhlDQpJRkxBX0NBTl9DVFJM
TU9ERSBkYXRhIHdoaWNoIGJvaWxzIGRvd24gdG8gYW4gYWNjZXNzIG9mIHRoZSBuZXRkZXZfcHJp
dihkZXYpLQ0KPnByaXYtPmN0cmxtb2RlIGZsYWdzIHNldCBpbiB0aGUgZHJpdmVyIChzZWUgYWxz
byBpbiBhIExpbnV4IHRyZWUgdW5kZXINCmRyaXZlcnMvbmV0L2Nhbi9kZXYvbmV0bGluay5jKS4g
QnV0IHRoZSAiY3RybG1vZGUiIGZsYWdzIHJlcHJlc2VudCBvbmx5IHRoZQ0KY3VycmVudCBzZXR1
cC4gU28geW91IGNhbiBzZWUgaWYgQ0FOLUZEIG1vZGUgaXMgY3VycmVudGx5IGVuYWJsZWQuDQoN
CkJ1dCBJIHRoaW5rIHRoZSB0aHJlYWQgb3BlbmVyIHdhbnRzIHRvIGtub3cgaW4gYWR2YW5jZSBp
ZiB0aGUga2VybmVsIGdpdmVzIHVzDQp0aGUgaW5mb3JtYXRpb24gd2hhdCBtb2RlcyBhIGNlcnRh
aW4gZHJpdmVyIHN1cHBvcnRzLiBUaGF0IGlzIGVuY29kZWQgaW4NCm5ldGRldl9wcml2KGRldikt
PnByaXYtPmN0cmxtb2RlX3N1cHBvcnRlZCBhbmQgbmV0ZGV2X3ByaXYoZGV2KS0+cHJpdi0NCj5j
dHJsbW9kZV9zdGF0aWMuIEJ1dCBmb3IgdGhlc2UgZmxhZ3MgdGhlcmUgaXMgbm8gbmV0bGluayBp
bnRlcmZhY2UgdG8NCmludGVycm9nYXRlIHRoYXQgc2V0dGluZ3MgYXQgdGhlIG1vbWVudC4NCg0K
U28geW91IGNhbid0IHNlZSBpbiBhZHZhbmNlIGlmIGEgQ0FOIGRyaXZlciB3b3VsZCBzdXBwb3J0
IGZvciBpbnN0YW5jZSB0cmlwbGUtDQpzYW1wbGluZyBvciB0aGUgQ0FOX0NUUkxNT0RFX0NDX0xF
TjhfRExDIG1vZGUuIFRvIGtub3cgaXQgeW91IG11c3QgdHJ5IHRvIHNldA0Kc3VjaCBvcHRpb24g
YXRtLiBJIHRoaW5rLg0KDQpCZXN0IHJlZ2FyZHMsDQogICAgU3RlZmFuDQoNCg==
