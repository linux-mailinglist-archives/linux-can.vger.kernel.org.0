Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7B6E04FA
	for <lists+linux-can@lfdr.de>; Tue, 22 Oct 2019 15:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbfJVN3L (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Oct 2019 09:29:11 -0400
Received: from mail-eopbgr00048.outbound.protection.outlook.com ([40.107.0.48]:57927
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387488AbfJVN3K (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 22 Oct 2019 09:29:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEaby9D34gYYxhDVhq4/vwwGNKGGIcxW6dj5GHIAuZp2A8a9qABPdcaRJrLujdvq2OagaOgBec33s+Yjmm3/O+G28BuBIS77T3aTaD8h4Q84R1ftB/iGcowyg2p96n4JH7yXSH4KKjxXigfVen2jkZDaW7R3nnI3D1JDyOsxwDhy8ghpIQTnW6xvDzWJzYq6j34J4XlnMzQOUm9qroCygcAnLSjE2aBsY7dXnXvZcuSdeWNJ8FDvQd0KM1S8T1GRj/Me1AhFSfQkvCHrQ4f300ekcnAIdSfN9oA61z/KJNY4YXnS4ue7hCw8JSri5tKoOofJbKZvukprECYMtRooiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2F9+zLNPVrsJgY2++L21LW7YAByYeTOEMklEAqvCTV8=;
 b=WH/xFmDQcUv+z62LvwPuBp+rHfoFk1pRo8v2AAqC+xJRMUM9eybaYocMUnhCSsQeGy1EEgVkGdhZfnClxAHn0elolU1ZnNQq8sPMI79B3IN9GOJNrOZ0kbI2OhcPQNsobuVnMPyLb76SsIcjHLkhY7IxVTrI5zSkbTE+0vJbUo5IQYCLCXDi72eUFvMWvn145JsmlTFsdInBEKPfuHBGWam3qUYTLV4DH1OBwIrqniwfFx+ER268fFSVplWUTy9Y1ckWI6bSI2Ss5FWTWpgTv8w1tJOrDxHTk/E2L41XwiJku4SQ1W8P8sqX4zi4Q9y2/qPW+Lsv2r1OnO1Ge2CXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2F9+zLNPVrsJgY2++L21LW7YAByYeTOEMklEAqvCTV8=;
 b=ZaNLcEZzjb/W1owY2+rTmxlllcSifwbB/aB96Hf7741skhMvxCS0DsbZ9q7epwOA8+9fG9kdAnG/5TchdCmOZGbzekpBowdYsIYZbJ65lE/zPUbMWq+AF0Qg0naLXXiWFoWTGWMX8+zm+1/uverkRKUUVKrJafaU4hUlQmBBRZc=
Received: from AM6PR03MB4006.eurprd03.prod.outlook.com (20.177.37.97) by
 AM6PR03MB4805.eurprd03.prod.outlook.com (20.177.199.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 13:29:07 +0000
Received: from AM6PR03MB4006.eurprd03.prod.outlook.com
 ([fe80::e93e:a46a:3c6a:c0f7]) by AM6PR03MB4006.eurprd03.prod.outlook.com
 ([fe80::e93e:a46a:3c6a:c0f7%7]) with mapi id 15.20.2347.028; Tue, 22 Oct 2019
 13:29:07 +0000
From:   =?utf-8?B?U3TDqXBoYW5lIEdyb3NqZWFu?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: RE: [PATCH 2/2] can/peak_usb/pcan_usb: add support of rxerr/txerr
 counters
Thread-Topic: [PATCH 2/2] can/peak_usb/pcan_usb: add support of rxerr/txerr
 counters
Thread-Index: AQHVfbPIskM4lsaY10OX0UftlC6fNqdQjXSAgAsbXvCACxUWwA==
Date:   Tue, 22 Oct 2019 13:29:06 +0000
Message-ID: <AM6PR03MB4006585791DD38A32C401BA2D6680@AM6PR03MB4006.eurprd03.prod.outlook.com>
References: <20191008083545.4569-1-s.grosjean@peak-system.com>
 <20191008083545.4569-3-s.grosjean@peak-system.com>
 <4416597c-6db7-057d-36b5-dc4b2c15117f@pengutronix.de>
 <AM6PR03MB4006315428304DA4419935E4D6930@AM6PR03MB4006.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB4006315428304DA4419935E4D6930@AM6PR03MB4006.eurprd03.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=s.grosjean@peak-system.com; 
x-originating-ip: [185.109.201.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 609c52d2-3fbf-4dcb-9079-08d756f3d090
x-ms-traffictypediagnostic: AM6PR03MB4805:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM6PR03MB4805ED2BD8379F4AF593381FD6680@AM6PR03MB4805.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(366004)(39840400004)(199004)(189003)(13464003)(256004)(14444005)(446003)(186003)(26005)(102836004)(11346002)(6506007)(53546011)(76176011)(15974865002)(486006)(476003)(66066001)(7696005)(66574012)(52536014)(85202003)(316002)(5660300002)(966005)(14454004)(508600001)(71190400001)(71200400001)(25786009)(305945005)(74316002)(8936002)(81166006)(85182001)(81156014)(86362001)(8676002)(7736002)(229853002)(4326008)(6246003)(99286004)(3846002)(2906002)(64756008)(55016002)(9686003)(6306002)(66446008)(76116006)(66946007)(66476007)(66556008)(6916009)(6116002)(6436002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB4805;H:AM6PR03MB4006.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: peak-system.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O70JlsPWKWXdJ/lkqWvYr9xTzPacqqTadYqJM+ZeyfM5MNdZ70b9YUVU7G2aZocwwKLpW2vWQCEEHa1EyJSLTxsns4EGjVohoRH5gE0LAfQfz1XsCj8SSf7RWEqupiscjS15tJ8MCpSRWdBPHlEOrGnmj80U2Am8LbRC/rxFEsfJnw46SnFdgUoFqnxxRZQW3EJ8oI8wcG9PB927to5+XpenIKQ237wHuoXrWBBLfshIAdZ0lgsc5H+FIbcGC5ys+OArPwEplwiel7yMjaDtZNxQbGGmrK96Jl0XFMFGLfyPv8SnUAYWsUUpaueCnWjKFBtmHrJZYh9cVUB6N+nqpEpN5tzu/eXc31LBcKR0d2WO33N+jztjkUATsiWWlAw7aHB4y57kJHAKxdpOHMjGko2OKjFH2wztn5zUOuFqmYwWszxvxN/5ydPzgGBLHcWDqNOLLjCewRShBuFLpEx10roJYgfStcvLDPGmn/rhefI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609c52d2-3fbf-4dcb-9079-08d756f3d090
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 13:29:06.3636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D6n82MXAx+EBcuWpwS+zdJrZbR5Y1opVIxgMdmlqkmxT7A+6BI+a9h6cWDZtCh8aVCrzMMgghKd3jtM0MTLyqUkaEgipIjZP2XsL4tupSjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4805
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

UGluZw0KDQoNCuKAlCBTdMOpcGhhbmUNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBTdMOpcGhhbmUgR3Jvc2plYW4NCj4gU2VudDogbWFyZGkgMTUgb2N0b2JyZSAyMDE5
IDE0OjIxDQo+IFRvOiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBD
YzogbGludXgtY2FuIE1haWxpbmcgTGlzdCA8bGludXgtY2FuQHZnZXIua2VybmVsLm9yZz4NCj4g
U3ViamVjdDogUkU6IFtQQVRDSCAyLzJdIGNhbi9wZWFrX3VzYi9wY2FuX3VzYjogYWRkIHN1cHBv
cnQgb2YgcnhlcnIvdHhlcnINCj4gY291bnRlcnMNCj4NCj4gSGVsbG8gTWFyYywNCj4NCj4gU2Vl
IG15IGNvbW1lbnRzIGJlbG93Lg0KPg0KPiBUaGFuayB5b3UsDQo+DQo+IOKAlCBTdMOpcGhhbmUN
Cj4NCj4gPiA+ICAvKg0KPiA+ID4gICAqIHN0YXJ0IGludGVyZmFjZQ0KPiA+ID4gICAqLw0KPiA+
ID4gIHN0YXRpYyBpbnQgcGNhbl91c2Jfc3RhcnQoc3RydWN0IHBlYWtfdXNiX2RldmljZSAqZGV2
KSAgew0KPiA+ID4gIHN0cnVjdCBwY2FuX3VzYiAqcGRldiA9IGNvbnRhaW5lcl9vZihkZXYsIHN0
cnVjdCBwY2FuX3VzYiwgZGV2KTsNCj4gPiA+ICtpbnQgZXJyOw0KPiA+ID4NCj4gPiA+ICAvKiBu
dW1iZXIgb2YgYml0cyB1c2VkIGluIHRpbWVzdGFtcHMgcmVhZCBmcm9tIGFkYXB0ZXIgc3RydWN0
ICovDQo+ID4gPiAgcGVha191c2JfaW5pdF90aW1lX3JlZigmcGRldi0+dGltZV9yZWYsICZwY2Fu
X3VzYik7DQo+ID4gPg0KPiA+ID4gK3BkZXYtPmJlYy5yeGVyciA9IDA7DQo+ID4gPiArcGRldi0+
YmVjLnR4ZXJyID0gMDsNCj4gPiA+ICsNCj4gPiA+ICsvKiBiZSBub3RpZmllZCBvbiBhbnkgZXJy
b3IgY291bnRlciBjaGFuZ2UgKi8NCj4gPg0KPiA+IERvZXMgdGhlIGRldmljZSBvZmZlciB0aGUg
cG9zc2liaWxpdHkgdG8gcmVhZCB0aGUgZXJyb3IgY291bnRlcnM/IElmDQo+ID4gc28gcGxlYXNl
IGRvIGl0IGluIHBjYW5fdXNiX2dldF9iZXJyX2NvdW50ZXIoKS4NCj4gPg0KPg0KPiBOb3BlISBU
aGUgdmFsdWUgb2YgdGhlIGVycm9yIGNvdW50ZXJzIGNhbiBvbmx5IGJlIG9idGFpbmVkIHRocm91
Z2ggdGhlDQo+IGJlbG93ICJidXMgZXJyb3IiIG5vdGlmaWNhdGlvbiBtZWNoYW5pc206DQo+DQo+
ID4gPiArZXJyID0gcGNhbl91c2Jfc2V0X2Vycl9mcmFtZShkZXYsIFBDQU5fVVNCX0VSUl9FQ0Mg
fA0KPiA+ID4gKyAgICAgUENBTl9VU0JfRVJSX1JYRVJSIHwNCj4gPiBQQ0FOX1VTQl9FUlJfVFhF
UlIgfA0KPiA+ID4gKyAgICAgUENBTl9VU0JfRVJSX1JYRVJSX0NOVCB8DQo+ID4gPiArICAgICBQ
Q0FOX1VTQl9FUlJfVFhFUlJfQ05UKTsNCj4gPg0KPiA+IEJldHRlciBvbmx5IGVuYWJsZSBidXMg
ZXJyb3JzLCBpZiB0aGUgdXNlciBoYXMgcmVxdWVzdGVkIHRoZW0uIFNlZToNCj4gPg0KPiA+DQo+
ID4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9kcml2ZXJz
L25ldC9jYW4vc2phMTAwMA0KPiA+IC9zamExMA0KPiA+IDAwLmMjTDE1Mg0KPiA+DQo+DQo+IE9r
LiAgQnV0IHRoaXMgYWxzbyBtZWFucyB0aGF0IHRoZSByeC90eCBlcnIgY291bnRlcnMgd2lsbCBh
bHdheXMgYmUgMCBpZiB1c2VyDQo+IGRpZG4ndCByZXF1ZXN0ICJiZXJyLXJlcG9ydGluZyBvbiIu
IElzIHRoaXMgb2s/DQo+DQo+ID4gPiAraWYgKGVycikNCj4gPiA+ICtuZXRkZXZfd2FybihkZXYt
Pm5ldGRldiwNCj4gPiA+ICsgICAgIkNBTiBidXMgZXJyb3IgY291bnRlcnMgbm90IGF2YWlsYWJs
ZSAoZXJyICV1KVxuIiwNCj4gPiA+ICsgICAgZXJyKTsNCj4gPiA+ICsNCj4gPiA+ICAvKiBpZiBy
ZXZpc2lvbiBncmVhdGVyIHRoYW4gMywgY2FuIHB1dCBzaWxlbnQgbW9kZSBvbi9vZmYgKi8NCj4g
PiA+ICBpZiAoZGV2LT5kZXZpY2VfcmV2ID4gMykgew0KPiA+ID4gLWludCBlcnI7DQo+ID4gPiAt
DQo+ID4gPiAgZXJyID0gcGNhbl91c2Jfc2V0X3NpbGVudChkZXYsDQo+ID4gPiAgZGV2LT5jYW4u
Y3RybG1vZGUgJg0KPiA+IENBTl9DVFJMTU9ERV9MSVNURU5PTkxZKTsNCj4gPiA+ICBpZiAoZXJy
KQ0KPiA+ID4gQEAgLTkwNiw0ICsxMDUwLDUgQEAgY29uc3Qgc3RydWN0IHBlYWtfdXNiX2FkYXB0
ZXIgcGNhbl91c2IgPSB7DQo+ID4gPiAgLmRldl9lbmNvZGVfbXNnID0gcGNhbl91c2JfZW5jb2Rl
X21zZywNCj4gPiA+ICAuZGV2X3N0YXJ0ID0gcGNhbl91c2Jfc3RhcnQsDQo+ID4gPiAgLmRldl9y
ZXN0YXJ0X2FzeW5jID0gcGNhbl91c2JfcmVzdGFydF9hc3luYywNCj4gPiA+ICsuZG9fZ2V0X2Jl
cnJfY291bnRlciA9IHBjYW5fdXNiX2dldF9iZXJyX2NvdW50ZXIsDQo+ID4gPiAgfTsNCj4gPiA+
DQo+ID4NCj4gPiBNYXJjDQo+ID4NCj4gPiAtLQ0KPiA+IFBlbmd1dHJvbml4IGUuSy4gICAgICAg
ICAgICAgICAgICB8IE1hcmMgS2xlaW5lLUJ1ZGRlICAgICAgICAgICB8DQo+ID4gSW5kdXN0cmlh
bCBMaW51eCBTb2x1dGlvbnMgICAgICAgIHwgUGhvbmU6ICs0OS0yMzEtMjgyNi05MjQgICAgIHwN
Cj4gPiBWZXJ0cmV0dW5nIFdlc3QvRG9ydG11bmQgICAgICAgICAgfCBGYXg6ICAgKzQ5LTUxMjEt
MjA2OTE3LTU1NTUgfA0KPiA+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2ICB8IGh0
dHA6Ly93d3cucGVuZ3V0cm9uaXguZGUgICB8DQoNCg0KLS0NClBFQUstU3lzdGVtIFRlY2huaWsg
R21iSA0KU2l0eiBkZXIgR2VzZWxsc2NoYWZ0IERhcm1zdGFkdCAtIEhSQiA5MTgzDQpHZXNjaGFl
ZnRzZnVlaHJ1bmc6IEFsZXhhbmRlciBHYWNoIC8gVXdlIFdpbGhlbG0NClVuc2VyZSBEYXRlbnNj
aHV0emVya2xhZXJ1bmcgbWl0IHdpY2h0aWdlbiBIaW53ZWlzZW4NCnp1ciBCZWhhbmRsdW5nIHBl
cnNvbmVuYmV6b2dlbmVyIERhdGVuIGZpbmRlbiBTaWUgdW50ZXINCnd3dy5wZWFrLXN5c3RlbS5j
b20vRGF0ZW5zY2h1dHouNDgzLjAuaHRtbA0K
