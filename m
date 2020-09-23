Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9698C27533A
	for <lists+linux-can@lfdr.de>; Wed, 23 Sep 2020 10:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgIWIbQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Sep 2020 04:31:16 -0400
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:34117
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbgIWIbO (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 23 Sep 2020 04:31:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/d1dS+FZXFZa+k6Xq48b3opwaduENsz1Yg4XOcpghAqtOPPdCDhfmFRRCuMXORS8ltviH9020+Y6CYK7NVLgaH0idaH0pnhYCwjGA+kNVYbAKpOLPMSuXWAo0CUod5JFKfFMxYCoop1Vgyimv09LYNxHx/pkCM9dC2Oavf1hD2vBjt5DjJVFkgTmjgngWEaDPPv6IZdpcC4wrObBUBaSuhnEWeu5ETypo8ZRlhIX8C9PSotuAHDNyy/eVtVU4OahWVNCeoNnv6i9OAvgO0a22SQPTvG8hW7Vus1hmB0nrmawI/P7xa+0KChueN9agyoFNUY3tEfEzstRfAWbh79xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwXB1YD2aL1wAaML81NFBcO6BWeyOJ98EjoyVzr1Zlw=;
 b=jePyajtXSp3dfdd9v0bq0zq5h2JYij/wxNYlkV4tPEfLRuXpYJD7C3lT1F2bFgrVK2OY9s9MiljBv9+3cMUt9vYDnWueTTWXLH8hu2/VFZoHRtMVuDdU0Ju9E6vg0QwT7KiIPdNKGCror6NE8S20F2a0qIGBEENAXymlehrJN6WRkHuUyNfMomdUe/osHW87R/VmiXb5YIUjn2tHVBU3bgdxzRp6F0TrPZcyLglRqLgovUkCeynuw9joSVXveXZSMeED3KgaWd+PKFYeJDQ4N2xZcenGYiSR/65lGFKk9ey8P51MTaAHOyTfGOdPcc0OcI+K0tRhhI1LvdwvZM/CeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwXB1YD2aL1wAaML81NFBcO6BWeyOJ98EjoyVzr1Zlw=;
 b=ThJkoos6aMnOt0DETKJFqpc9jv8P5nf/yZWjjtlqTb8Rkc60MlB3UV8fp3GfeOnhUDPJ5d1fzkLvO22hFaL6qbhrXKv2ZZelPDyXQqg/M7nG7nXuMOFZE6+Ok5/NNk96h1axsveLWZsmOzEAfg4wMejuj+BdbryRaZlj+whtZw0=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0402MB2901.eurprd04.prod.outlook.com (2603:10a6:4:99::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 23 Sep
 2020 08:31:10 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::d12e:689a:169:fd68]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::d12e:689a:169:fd68%8]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 08:31:10 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Michael Walle <michael@walle.cc>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: [PATCH 20/20] can: flexcan: add lx2160ar1 support
Thread-Topic: [PATCH 20/20] can: flexcan: add lx2160ar1 support
Thread-Index: AQHWkO7pb02bDa3uBEmRZ3DevHIumql12SGAgAACdYCAAAJrAIAAAiWAgAADAbA=
Date:   Wed, 23 Sep 2020 08:31:10 +0000
Message-ID: <DB8PR04MB67955FEC9B6A44A1A2C04DE8E6380@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20200922144429.2613631-1-mkl@pengutronix.de>
 <20200922144429.2613631-21-mkl@pengutronix.de>
 <4ffe89fbb4c91a9587622862c3509180@walle.cc>
 <5b3c07ab-ca8c-d43d-f4e0-7155d358648d@pengutronix.de>
 <0e90e8234d38830749ad8de380837eb2@walle.cc>
 <8e2e2994-a3c8-cf06-012a-fcb0ac18a888@pengutronix.de>
In-Reply-To: <8e2e2994-a3c8-cf06-012a-fcb0ac18a888@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a37eaae8-905a-4c97-72bb-08d85f9b064f
x-ms-traffictypediagnostic: DB6PR0402MB2901:
x-microsoft-antispam-prvs: <DB6PR0402MB2901275C25E7194DDDD9F0C2E6380@DB6PR0402MB2901.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i9ElhFAcviC0PDWVnEZPh+yoxfw0fiZYhngs4yn8L4IBqllm8kd48cx2LV3T8+/aKHpb+0TKQpu8Ie3q5bQoqrm93MNta//d8sS/TH8oxHrkH+0FXgbDQCfbWtOzXNj1+770ZvjlKbYTJh0MbwmvvUGx9oLwxWhOUisbvYHoUPBdoor7GXI5YQAU9FZgmAJthhyfR4JsxFESPznt9zL7dyAwxKxvCFjHyFOyT/CBTA+MIsPHUjtGjE8Y5txk38ESj2Nddk4LWaNY548txCE9V6mTSdFVmp5wrWk8Cot83o8LcPKn9ncPNsY6LbhB//uytyng34zlLQ1IjVrcgUa7chrW6FH52yJZr3VPlRNS7P4D9/ykF5uGnnbRpJSMmNrLfgJjSFnf/YBWRlGyslL6Ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(83080400001)(8676002)(52536014)(2906002)(5660300002)(86362001)(55016002)(71200400001)(83380400001)(6506007)(9686003)(53546011)(8936002)(316002)(110136005)(64756008)(66446008)(33656002)(76116006)(66476007)(4326008)(26005)(54906003)(66556008)(186003)(66946007)(966005)(478600001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: EaJvuGicSr17l78qrWkn5E/F5GazqnV+tCAd8Q855g218Iak7S1VQDfRM4Xrlxe1/qPXCJavUIrP/I260P18Synk24WBVPTAJQ26JQ/FLxvH5VnRdssbLv6yiQd73L57bJ534z9kv6Aeoa+mzTj5lhXMe5z347xaG4obyKvtNzb2wlpd6gLAHDHkZ74W3O+MjTzliYkJUJiooOKr7YABpVqosiJBkMng0ddBBok5rF/dzSk5THIxoB8P3gaF3mytlssfAw7e17pNlFmZYzaDjPgLNa7VS9JC7RqDPdFIs74d0UZSqzeLH5aLQaiZ6cn8BB+M5EjS8ooEeISRIjSms5qlVKwGpFvzWeF0dwCm1skn98w8pVV/jVm/jzFhfrTmv+NvQRvCwP+aRN+qAP8kMGx4IthsZJllLEymah0BVt7DlajSsBYTTREUSHQUU5FyxrOEQkrAHkVmRWLG1ZKrFlQKDL/nNLyzoNLOGYgoIiw+/mv6hoYZ0AACEUExqhIFCc/qHwTqWsqYEq426UMqjJ6h1z6/bTjf8NNGQbTJXZf987ka1oy2vj0ldU+8V0dVWs7yaG4Pq2cdgtkbLnbjpf+aFSXkJCGQdsnCG9molNUSTu4HSO/yHgDjwsv0LoZUIEqu0Z2M1oTT16VpwZBj8g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37eaae8-905a-4c97-72bb-08d85f9b064f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 08:31:10.2518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K51RQal+rL4igsRinlFpL3vsyB1riGfOSvIxynguxLABhD+7sr3l3Yea6b9DOXIEio9EmUpWoDisDOrv/aIw5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2901
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjDlubQ55pyIMjPml6UgMTY6MTENCj4g
VG86IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+IENjOiBKb2FraW0gWmhhbmcg
PHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBsaW51
eC1jYW5Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMjAvMjBdIGNhbjog
ZmxleGNhbjogYWRkIGx4MjE2MGFyMSBzdXBwb3J0DQo+IA0KPiBPbiA5LzIzLzIwIDEwOjAyIEFN
LCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBbLi4uXQ0KPiANCj4gPj4gVGhlIGNvbXBhdGlibGUg
b2YgeW91ciBjYW4gZGV2aWNlIG1hdGNoZXMgdGhlIG9uZSBsaXN0ZWQgaW4gdGhlDQo+ID4+IGRy
aXZlci4gU28gdGhlcmUncyBubyBuZWVkIGZvciB0aGUgImZzbCxsczEwMjhhcjEtZmxleGNhbiIN
Cj4gPj4gaW4gdGhlIGRyaXZlci4NCj4gPj4NCj4gPj4gSWYgaXQgdHVybnMgb3V0LCB0aGF0IHRo
ZSAiZnNsLGxzMTAyOGFyMS1mbGV4Y2FuIiBuZWVkcyBkaWZmZXJlbnQNCj4gPj4gaGFuZGxpbmcg
dGhhbiB0aGUgImZzbCxseDIxNjBhcjEtZmxleGNhbiIsIHdlIHdvdWxkIGFkZCBpdCB3aXRoDQo+
ID4+IGRpZmZlcmVudCBxdWlya3MgdG8gdGhlIGRyaXZlci4NCj4gPg0KPiA+IFRoYXQgd2FzIHdo
YXQgSSB3YXMgYXNraW5nLiBJZS4gaWYgSm9ha2ltIGFscmVhZHkga25vd3MgYW55IGFuZCBpZiBp
dA0KPiA+IG1ha2VzIHNlbnNlIHRvIGhhdmUgc29tZSBhZGRlZCByaWdodCBub3cuDQo+IA0KPiBB
Q0ssIEkgZG9uJ3Qga25vdyBvZiBhbnkgZGlmZmVyZW5jZS4NCj4gDQo+ID4gQW5kIG1heWJlIHlv
dS9oZSB3YW50IHRvIHNlZSB0aGUgTFMxMDI4QSBhZGRlZCB0byB0aGUgdGFibGUgaW4gdGhlDQo+
ID4gaGVhZGVyIG9mIHRoZSBmaWxlLiBJJ3ZlIGhhZCBhIGxvb2sgYXQgdGhlIHZlbmRvciBtYW51
YWwgYnV0IGNvdWxkbid0DQo+ID4gZXZlbiBmaW5kIHRoZSBJUCB2ZXJzaW9uLiBTZWVtcyB0byBt
ZSB0aGF0IG9ubHkgSm9ha2ltIGlzIGFibGUgdG8gZmlsbA0KPiA+IG91dCB0aGF0IHJvdyA7KQ0K
PiANCj4gUmlnaHQsIHRoZSBtb3JlIElQIGNvcmVzIGluIHRoZSB0YWJsZSBhcmUgYXBwcmVjaWF0
ZWQuIEkgZG9uJ3QgdGhpbmsgdGhlIElQIGNvcmUNCj4gdmVyc2lvbiB1c2VkIGluIHRoZSBTb0Nz
IGlzIGF2YWlsYWJsZSB0byB0aGUgcHVibGljLiBKb2FraW0sIGZlZWwgZnJlZSB0byBhZGQgYSBs
aW5lDQo+IGZvciB0aGUgbHMxMDI4YXIxIGFuZCB0aGUgaW14OG1wLg0KDQpIaSBNYXJjLCBNaWNo
YWVsLA0KDQpJIGNoZWNrIGxvY2FsbHksIGZvciBMUzEwMjhBLCBpdCBhbHNvIHVzZXMgdGhlICJm
c2wsbHgyMTYwYXIxLWZsZXhjYW4iIGNvbXBhdGlibGUgc3RyaW5nLCBzbyBJIHRoaW5rIExTMTAy
OEEgc2hvdWxkIHJldXNlIElQIGNvcmUgZnJvbSBMWDIxNjBBLg0KDQpJIGFtIG1vcmUgZmFtaWxp
YXIgdG8gaS5NWCwgSSB3aWxsIGFkZCBhIGNvbXBhdGlibGUgc3RyaW5nIGZvciBpLk1YOE1QLCBz
aW5jZSBpdCBjb25maWd1cmVzIEVDQywgZXh0cmEgcGF0Y2hlcyBhcmUgbmVlZGVkLg0KQWZ0ZXIg
dGhpcyBwYXRjaCBzZXQgaXMgbWVyZ2VkIGludG8gbWFpbmxpbmUsIEkgd2lsbCBzZW5kIG91dCBy
ZWxhdGVkIHBhdGNoZXMgdG8gY29tbXVuaXR5Lg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhh
bmcNCj4gcmVnYXJkcywNCj4gTWFyYw0KPiANCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAg
ICAgICAgICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAgICAgfA0KPiBFbWJlZGRlZCBM
aW51eCAgICAgICAgICAgICAgICAgICB8IGh0dHBzOi8vd3d3LnBlbmd1dHJvbml4LmRlICB8DQo+
IFZlcnRyZXR1bmcgV2VzdC9Eb3J0bXVuZCAgICAgICAgIHwgUGhvbmU6ICs0OS0yMzEtMjgyNi05
MjQgICAgIHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgfCBGYXg6ICAgKzQ5
LTUxMjEtMjA2OTE3LTU1NTUgfA0KDQo=
