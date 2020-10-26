Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCB2298A0F
	for <lists+linux-can@lfdr.de>; Mon, 26 Oct 2020 11:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769165AbgJZKJZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Oct 2020 06:09:25 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:54648 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbgJZJuT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Oct 2020 05:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1603705819; x=1635241819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bj1H3g+sNBqGT++M5s0gyvOEXLMKJbkejJbJS45eMAQ=;
  b=zG0xjTY2bIHuHvkcClonurkQ7vXbnr6FL3wbI8OZXvVy3laBnHPYR9VX
   S7E0LqG64CHixG8mpcTaDWwdTHA3bypo619fnEfZfmmMbqpvntuNgpJHz
   o29tVkbstXmkqR2/6vGFRx5RK/IPUS/i7KInDiMmj0CEryp2bU5+gmnqb
   pazVAqsCRbaS/SiBEihupolBHyPh20JhPHnSG2Hm2asUouVZAh11WeUQD
   i+KROtX2JHhbSIELpGVujTe+9K0sDqsfJIqzaAIJK8wVGFzg/UF5QJzn5
   9X8Ka4wYO6mJlR9Vpqm6OWSEG1EfB9chuqck2EtUq1qVkI/OHedpb/RxW
   A==;
IronPort-SDR: pEnc9tZD9Agb3WS3fENEkYQNv9pSFGmAm2Y7cS2wLNneLrFaXrYQWsH24y1VhwIAl04hORV/+l
 /Dp9RobBaEgwTRq13vb6hSeKtum/QimFIILuvZRwexkb6i7eeVH6gDjd9l3cXvTGIm2x/aGNZN
 JiUO8ZARqv8L9IADB7QyWkIa7fwT3iDfaZoc2bo93i0TtNDO+XKkqB47q4qSQDTLlM4sQxCUsf
 IBFunm2R6ahof9GahZMRAq5pxMeHshvX+rY4HZWU1CYExSe3uDaV9GWBYYkvJTG4+hQBcmYDES
 kqI=
X-IronPort-AV: E=Sophos;i="5.77,417,1596524400"; 
   d="scan'208";a="95933888"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2020 02:50:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 26 Oct 2020 02:50:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 26 Oct 2020 02:50:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGpjpNjpq+klTingu3OqFBQF9H9jQe8HszHwZ2P9gAZunfaTR1psqIDbYihklwiVaNmjV9VU3IG7Qi33MHTyhQYO4A1gaalFtdKmHAIEPDAYpTVlzyAi6ADjAlO5scrXnD2U1kmsAzj0T/btL2mNW15vXVhM2wYPWt+CziHrmkHUTz4+1Ib+dClR9Yr2T/kVHVjCqGkMfL34Ze7nN2cdbgP3BFPQIgS1RgiwuxbFLBUqRgeAW6uKL/Nt+M+IotOE1BdbBKkG+7forRcv/+Lb84qiEeCQiSEobTvc2wnJHmbSJigHC3dvfhKtVhuhvEsPNPd11lPJUr05GZ0ARffEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj1H3g+sNBqGT++M5s0gyvOEXLMKJbkejJbJS45eMAQ=;
 b=hWS6rlCqhDVq5XrchMctVsLCdw6NpOuKhWU8J9fQ42SB1TIsjLUJNbsIuXht87m9HTOG/AGdiy4Ok+w9eCfjfSBk427N8vFKWv724S2uGN02zQXhfZPM4CRS412eOWCCHg5yXutfsgg25pAbMfgQ67h+S2FB/z1cp/kXa4X6Re9/Vqmm2FvYhBWoq7KxR1thNyLISl8LCry94eWiaIETOn7wCkWDLmz0m4wTK8bA3s2k+U0dEp6Q1B2PaxAqKRzlBN86SCjj5mTt78yHrxfOdMdsSK+xgMXnQUGXlO9Oigm072W56qSnDBugvAuNQas8eSSmjVg88JH2+CEvSzkzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj1H3g+sNBqGT++M5s0gyvOEXLMKJbkejJbJS45eMAQ=;
 b=pBe6GDRai8IpQNjFGhSuDk57lbwBLkGAmqws8eLpMwrxRkZ2Lls6GIO9BGtcageCQaBMKqkyj2lELTecw56H1YQ/n6TDPm1NVXW03q+Zmf+ca6T3l+F0cLnE5NKXYO5w8DX84l32VhEyfaO3JUrOiB6LjpssmClkLP8y99cfPSQ=
Received: from DM6PR11MB4283.namprd11.prod.outlook.com (2603:10b6:5:206::32)
 by DM5PR11MB0025.namprd11.prod.outlook.com (2603:10b6:4:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 09:50:17 +0000
Received: from DM6PR11MB4283.namprd11.prod.outlook.com
 ([fe80::e97c:9647:f0c8:e603]) by DM6PR11MB4283.namprd11.prod.outlook.com
 ([fe80::e97c:9647:f0c8:e603%5]) with mapi id 15.20.3477.029; Mon, 26 Oct 2020
 09:50:15 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
CC:     <mas@csselectronics.com>
Subject: RE: [PATCH v2 1/3] can: mcp251xfd: mcp251xfd_chip_wake(): renamed
 from mcp251xfd_chip_clock_enable()
Thread-Topic: [PATCH v2 1/3] can: mcp251xfd: mcp251xfd_chip_wake(): renamed
 from mcp251xfd_chip_clock_enable()
Thread-Index: AQHWo/4/M2H6SR5xhUmdMFLxjP9hrKmh/5xg
Date:   Mon, 26 Oct 2020 09:50:15 +0000
Message-ID: <DM6PR11MB4283BE357EAC1D1D1FF08D60FB190@DM6PR11MB4283.namprd11.prod.outlook.com>
References: <20201016205211.1141590-1-mkl@pengutronix.de>
 <20201016205211.1141590-2-mkl@pengutronix.de>
In-Reply-To: <20201016205211.1141590-2-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [93.241.63.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69052793-5f51-4189-c3c0-08d879948a6a
x-ms-traffictypediagnostic: DM5PR11MB0025:
x-microsoft-antispam-prvs: <DM5PR11MB0025CB38321E5C963146C67DFB190@DM5PR11MB0025.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: svMMc9ohEIO68vaO/j1pLINXHm2XFqT0hlIsEkiIDTIQ7cn1Lstr+wOlmS1dmKj+deJAwXYqQ4yUkOKZbq8lrjhoX/Nfd5e1qYUjih1LdkU6G5lHb73YQVOkV2vldLC9yBXhvvJz8fDZXJCIop3DxtmrEFKyoGugGBT2rX8xmqnqhYUUVIzajnqin1FvguJbB9DqUHq/ZJOrNuM1Ay0hWV2ELg68suPr5dgzUbTiEuWSA3EgsnUQY4sqjvN8pPgJJGJ3reUwJpvWBddjAfvrkmU0cgC7SseYlDB7LB0fYO9rn3xjOrKekFRg6NTu8kp/x3rMswgInkqIvxMwp23WxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(396003)(366004)(39860400002)(76116006)(8676002)(8936002)(316002)(478600001)(26005)(53546011)(186003)(2906002)(55016002)(6506007)(64756008)(9686003)(66446008)(66476007)(66946007)(66556008)(5660300002)(52536014)(110136005)(83380400001)(33656002)(86362001)(7696005)(4326008)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: RNnHi2n4dAxxENTxLEvUJlkO2aervTs1999GWCz1sVukjxCkxRIkRvpRcB6lAFE6uHmiakC3Gx26jTVzosfSFNGr+HN9jRl+e68v1041/CW+JpBN4QYH1WWRZ7uPT/MqHwP2wUuLkyqfD6YIgwud8cR3cjn6fYc/ZKiW3A5q/1ThUNn+CN1aLzeothz4xRt4paJ7i3bCg3HqqqYiP6rhatvO5QoXwyzSFnTS7rA1r885CB0jRHyRJpFlhOwnzr5Zf5SZIEnuVrXINqIicCXH9qj9Bisb4IJUYkcKYd3TtkvKCJgWb4D6lnwbizsU2VRgFzLKJfS3Vt+mZizrOaBb1zir5n0cBTV4ADkFYTZchxco4AZZp7YRW3hQ5QXqBWlNHwC5nDm8RUCZl2DtXpPkY6YHSlQZCxjWyhc93EyLRNLZNwL0nekIHPQr/Ujb1eWCg/k056TQPfbBPcJnuaulZtLw2SrS9n0T3uQrNERemAQ3cQ6xyWghdtd5pMJf3GblFVSrz/gQmyDePZKXkrrznjYJVVld32tU7Ng6t2AVNoTkT9B2ux+WwqYxAXXuBwDhfUIABdEGQYLImhjxA9jrJ6qAlXwNQgumiK8YtDh2AdgY984DGc8iyDGZT2Bl+g/jRxRydMvh/hXT6HUPherGNg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69052793-5f51-4189-c3c0-08d879948a6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 09:50:15.6249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gi9iyVqql9URie7smr7tdRVms6inlPB/U+FdDs2bnvGpvbUIwwX5mj2HkL37JMQLzexk+VY/XBpJOXtYkxuYsfRilnC/T601GwJuTZhxPHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0025
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBG
cmlkYXksIDE2IE9jdG9iZXIgMjAyMCAyMjo1Mg0KPiBUbzogbGludXgtY2FuQHZnZXIua2VybmVs
Lm9yZw0KPiBDYzogTWFnbnVzIEFhZ2FhcmQgU8O4cmVuc2VuIDxtYXNAY3NzZWxlY3Ryb25pY3Mu
Y29tPjsgTWFyYyBLbGVpbmUtDQo+IEJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFN1Ympl
Y3Q6IFtQQVRDSCB2MiAxLzNdIGNhbjogbWNwMjUxeGZkOiBtY3AyNTF4ZmRfY2hpcF93YWtlKCk6
DQo+IHJlbmFtZWQgZnJvbSBtY3AyNTF4ZmRfY2hpcF9jbG9ja19lbmFibGUoKQ0KPiANCj4gQ28t
ZGV2ZWxvcGVkLWJ5OiBNYWdudXMgQWFnYWFyZCBTw7hyZW5zZW4gPG1hc0Bjc3NlbGVjdHJvbmlj
cy5jb20+DQo+IE5vdC1TaW5nZWQtb2ZmLWJ5OiBNYWdudXMgQWFnYWFyZCBTw7hyZW5zZW4gPG1h
c0Bjc3NlbGVjdHJvbmljcy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvY2FuL3NwaS9tY3Ay
NTF4ZmQvbWNwMjUxeGZkLWNvcmUuYyB8IDE1ICsrKysrKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9jYW4vc3BpL21jcDI1MXhmZC9tY3AyNTF4ZmQtY29yZS5jDQo+IGIvZHJp
dmVycy9uZXQvY2FuL3NwaS9tY3AyNTF4ZmQvbWNwMjUxeGZkLWNvcmUuYw0KPiBpbmRleCBjM2Y0
OTU0M2ZmMjYuLmMzNmY1ZjE0ZDUwYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL3Nw
aS9tY3AyNTF4ZmQvbWNwMjUxeGZkLWNvcmUuYw0KPiArKysgYi9kcml2ZXJzL25ldC9jYW4vc3Bp
L21jcDI1MXhmZC9tY3AyNTF4ZmQtY29yZS5jDQo+IEBAIC01MTksMTMgKzUxOSwxNiBAQCBzdGF0
aWMgaW5saW5lIGJvb2wgbWNwMjUxeGZkX29zY19pbnZhbGlkKHUzMiByZWcpDQo+ICAgICAgICAg
cmV0dXJuIHJlZyA9PSAweDAgfHwgcmVnID09IDB4ZmZmZmZmZmY7DQo+ICB9DQo+IA0KPiAtc3Rh
dGljIGludCBtY3AyNTF4ZmRfY2hpcF9jbG9ja19lbmFibGUoY29uc3Qgc3RydWN0IG1jcDI1MXhm
ZF9wcml2DQo+ICpwcml2KQ0KPiArc3RhdGljIGludCBtY3AyNTF4ZmRfY2hpcF93YWtlKGNvbnN0
IHN0cnVjdCBtY3AyNTF4ZmRfcHJpdiAqcHJpdikNCj4gIHsNCj4gICAgICAgICB1MzIgb3NjLCBv
c2NfcmVmZXJlbmNlLCBvc2NfbWFzazsNCj4gICAgICAgICBpbnQgZXJyOw0KPiANCj4gLSAgICAg
ICAvKiBTZXQgUG93ZXIgT24gRGVmYXVsdHMgZm9yICJDbG9jayBPdXRwdXQgRGl2aXNvciIgYW5k
IHJlbW92ZQ0KPiAtICAgICAgICAqICJPc2NpbGxhdG9yIERpc2FibGUiIGJpdC4NCj4gKyAgICAg
ICAvKiBGb3Igbm9ybWFsIHNsZWVwIG9uIE1DUDI1MTdGRCBhbmQgTUNQMjUxOEZELCBjbGVhcmlu
Zw0KPiArICAgICAgICAqICJPc2NpbGxhdG9yIERpc2FibGUiIHdpbGwgd2FrZSB0aGUgY2hpcC4g
Rm9yIGxvdyBwb3dlciBtb2RlDQo+ICsgICAgICAgICogb24gTUNQMjUxOEZELCBhc3NlcnRpbmcg
dGhlIGNoaXAgc2VsZWN0IHdpbGwgd2FrZSB0aGUNCj4gKyAgICAgICAgKiBjaGlwLiBXcml0aW5n
IHRvIHRoZSBPc2NpbGxhdG9yIHJlZ2lzdGVyIHdpbGwgd2FrZSBpdCBpbg0KPiArICAgICAgICAq
IGJvdGggY2FzZXMuDQo+ICAgICAgICAgICovDQo+ICAgICAgICAgb3NjID0gRklFTERfUFJFUChN
Q1AyNTFYRkRfUkVHX09TQ19DTEtPRElWX01BU0ssDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICBNQ1AyNTFYRkRfUkVHX09TQ19DTEtPRElWXzEwKTsNCj4gQEAgLTU2OSwxMCArNTcyLDEwIEBA
IHN0YXRpYyBpbnQgbWNwMjUxeGZkX2NoaXBfc29mdHJlc2V0X2RvKGNvbnN0DQo+IHN0cnVjdCBt
Y3AyNTF4ZmRfcHJpdiAqcHJpdikNCj4gICAgICAgICBjb25zdCBfX2JlMTYgY21kID0gbWNwMjUx
eGZkX2NtZF9yZXNldCgpOw0KPiAgICAgICAgIGludCBlcnI7DQo+IA0KPiAtICAgICAgIC8qIFRo
ZSBTZXQgTW9kZSBhbmQgU1BJIFJlc2V0IGNvbW1hbmQgb25seSBzZWVtcyB0byB3b3JrcyBpZg0K
PiAtICAgICAgICAqIHRoZSBjb250cm9sbGVyIGlzIG5vdCBpbiBTbGVlcCBNb2RlLg0KPiArICAg
ICAgIC8qIFRoZSBTZXQgTW9kZSBhbmQgU1BJIFJlc2V0IGNvbW1hbmQgb25seSB3b3JrcyBpZiB0
aGUNCj4gKyAgICAgICAgKiBjb250cm9sbGVyIGlzIG5vdCBpbiBTbGVlcCBNb2RlLg0KPiAgICAg
ICAgICAqLw0KPiAtICAgICAgIGVyciA9IG1jcDI1MXhmZF9jaGlwX2Nsb2NrX2VuYWJsZShwcml2
KTsNCj4gKyAgICAgICBlcnIgPSBtY3AyNTF4ZmRfY2hpcF93YWtlKHByaXYpOw0KPiAgICAgICAg
IGlmIChlcnIpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiANCj4gLS0NCj4gMi4y
OC4wDQoNClRoaXMgcGF0Y2ggc2VyaWVzIHdvcmtzIGZpbmUgb24gbXkgc2V0dXAgKFJQSTQsIE1D
UDI1MThGRCwgZXh0ZXJuYWwgNCBNSHogY3J5c3RhbCkuIEdvaW5nIHRocm91Z2ggdGhlIGNvZGUg
SSBub3RpY2VkIHRoYXQgdGhlIE1pbiBzcGVjaWZpZWQgT1NDIGZyZXF1ZW5jeSBpcyBzcGVjaWZp
ZWQgZnJvbSAxIE1IeiB0byA0MCBNSHouIFRlY2huaWNhbGx5IHRoZSBEUyBvbmx5IHNwZWNpZmll
cyA0LDIwIGFuZCA0ME1IeiBhcyBjcnlzdGFsL3Jlc29uYXRvciBvcHRpb25zIGFuZCAyTUh6IGlu
cHV0IGFzIHRoZSBtaW5pbXVtIGV4dGVybmFsIGNsb2NrLiA0IHdpdGggUExMIGFuZCA0MCBkaXJl
Y3QgYXJlIHRoZSBwcmVmZXJyZWQgb3B0aW9ucyBmb3IgQ0FOLUZELiBJIHRoaW5rIHRoZSBjb2Rl
IGlzIGZpbmUsIGdpdmVuIHRoYXQgdGhlIGRlZmF1bHQgaXMgNDAgTUh6IGFuZCBpdCdzIHRoZSB1
c2VyJ3MgcmVzcG9uc2liaWxpdHkgdG8gZGVzaWduIGluIHRoZSBwYXJ0IGFjY29yZGluZyB0byB0
aGUgRFMuIFdlIGNvdWxkIG5hcnJvdyBkb3duIHRoZSBwbGwgY2xvY2tjaGVjayB0byBvbmx5IGFs
bG93IDQgTUh6IHRob3VnaC4NCg0KQWxsIDMgcGF0Y2hlcyBpbiB0aGlzIHNlcmllczoNClRlc3Rl
ZC1ieTogVGhvbWFzIEtvcHAgPHRob21hcy5rb3BwQG1pY3JvY2hpcC5jb20+DQoNCkJlc3QgUmVn
YXJkcywNClRob21hcw0KDQo=
