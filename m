Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476EB2D0D1C
	for <lists+linux-can@lfdr.de>; Mon,  7 Dec 2020 10:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgLGJf5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Dec 2020 04:35:57 -0500
Received: from mail-am6eur05on2131.outbound.protection.outlook.com ([40.107.22.131]:25408
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726402AbgLGJf5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 7 Dec 2020 04:35:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOoZnJCanYkCC67k4STz5wzdxVZeFiYJLNCzNKwDhz0lRpUR/1m8vJtiyF+AuMJKRdaTsimZS+uNfKACzQdacCo96KpBD27kVthD3swuf8ODHaUdE1EeTPR1sc+nyl3Jh+mH9uaeNBMKMvRNRbYKQohZg80VYVMfLYVHcj/vXDXNBCeb/GjnHwtztjqKvqdVQRPTnlSkVB2ZskNa32OpWhLLWaaa+dPAKK/Eb+Gr5l5vPVUDpNn/E1wq5MkQXxKilSwZB4HhRyfEgoQCk1dvDS3OIGksa0KtUjxjdYiPO4uBDHpbwFmkFPS/ge1zVKoFnkmXBAr+n7XUYJLgciAk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4DqSgvW6aGcfdb3JJlXxoGVBVCTp8AeojYfubvAaDo=;
 b=Fhkrx5XDFGpLoGH6ov+NAoiRGxLDOzI5KKXpGJX9dyayDGMYxDVkHU0kjaWCQ6Zkb2sCbFnHTf2z9ZfD0hdkbE0dtL3Twxy+jTy38LTfW+7s/4Yfj14I+6nyK1K7qVefXgK/BFfUihEbRa2A66ouZiW6f+HHlQxUP9JUQYWGaYK6pnTZBI057TXxKl/0d0r/WY/a+C8gKj513taGBI8S5CFyiWyTSGDcJhTi1fNVZku/4bgq+2pH3bfP+Rdx3pvT0VnZeN3QJiT0Yv8SsZ5qfXMbpebZ6/c2OFZCMeVFHyiNTBJ52PDgO+JQZC+SqZlQD9eYGjpV3NDv7yW7JOJi1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4DqSgvW6aGcfdb3JJlXxoGVBVCTp8AeojYfubvAaDo=;
 b=EK9WYBSw2dKm7p5QXCekL3AdOxhR7vUHCj8xKnOE8B3Lci+A7fgvnLuEVq+hHbQ5eyBHhhe8wxJrN39JQASqCXWt3SafDURtT75aU/FCkVbwoiS6L9QS+PcoNXBVYUEaoENvYjfGOkwHB81cqLxCWHA/bvkht2fTr9qFGIzi7B0=
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:12d::21)
 by DB6P190MB0215.EURP190.PROD.OUTLOOK.COM (2603:10a6:4:88::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.20; Mon, 7 Dec 2020 09:35:07 +0000
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::14dd:59d7:acaf:be4a]) by DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::14dd:59d7:acaf:be4a%4]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 09:35:07 +0000
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: AW: AW: AW: AW: mcp251xfd No Oscillator (clock) defined
Thread-Topic: AW: AW: AW: mcp251xfd No Oscillator (clock) defined
Thread-Index: AdbLuKAjW6Ey/8Z7T1qzpJx8c3rFuwAAn6qAABKkP4AAAEmcgAAApmFQAAC/jIAAALi2cAAAdocAAAEpmeAAAVwSgAAYKRGA
Date:   Mon, 7 Dec 2020 09:35:07 +0000
Message-ID: <DB8P190MB0634F1FA767B1F45298B2D04D9CE0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
References: <DB8P190MB0634231494D3D788E87DCE54D9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <611813e9-943a-33be-4e9b-5cb1397ac5d9@pengutronix.de>
 <20201206192625.GB15319@x1.vandijck-laurijssen.be>
 <79e6ef83-2779-1a4a-29a1-8c34a3b52a40@pengutronix.de>
 <DB8P190MB063437FAE61F7457D031DC1FD9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <576867c2-613f-da3a-655d-beedd3027169@pengutronix.de>
 <DB8P190MB0634B660BCFD655ED5D96E9FD9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <95c71974-290a-89c5-2297-827a3081a84e@pengutronix.de>
 <DB8P190MB06345524F4EB1E411B4CE3D1D9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <09e12bd1-8698-6a8a-0ed4-6fa7e03c0f7e@pengutronix.de>
In-Reply-To: <09e12bd1-8698-6a8a-0ed4-6fa7e03c0f7e@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=schleissheimer.de;
x-originating-ip: [62.153.209.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2883b05-72e3-4565-2925-08d89a936255
x-ms-traffictypediagnostic: DB6P190MB0215:
x-microsoft-antispam-prvs: <DB6P190MB0215F29FA6961F37F30162BFD9CE0@DB6P190MB0215.EURP190.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2DuHYqMYp4THh2fMORYmqDQ9ibtxlX12W0jIFjtoKWONPlMoaBXHq12CqflMcYn7nxGOcsvI4zsDNk6ER2NIMuu+iYY9wkgvfh1pCG/BV8MvSWdL9zYC4UkT/aVX+qk/HmuayUWAAOyBE96jInUAO+bajgnFGF4km2WSpCN0io9PLRxOURsKepf21pg7Ien81WMNlTtWw6Wc9TE1+O9bfWzS7du/GpHM4Zz+MDB14uouNiJUe78LdKpiRrbZbSA4YiZ7asTlzNsb2UxIXXfruJcsnHslJ8J8rsDcjHFpKFIWCxqnXxHX/UBQvkycCNP+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P190MB0634.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(39830400003)(376002)(396003)(136003)(366004)(478600001)(110136005)(64756008)(66946007)(33656002)(8936002)(5660300002)(8676002)(76116006)(26005)(7696005)(52536014)(66446008)(66476007)(186003)(66574015)(6506007)(86362001)(2906002)(71200400001)(66556008)(316002)(4744005)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WW9Sbk5tdFVUNmlVa1Mzb1JxU3VjRkdqZ09ublljdWxJSjZOS1YzVFhiTkxC?=
 =?utf-8?B?c1RRd2h3WlA5SitVME9TZ0U2YmFKQ2ZGeFFIZjhCRm9sZURwckRCeWZZWVgv?=
 =?utf-8?B?V05FeXBIalJOSkQyaGRIcTEyNHIzNkVXaERWcjU0QjlWQUlLSGNnQzFiN3c2?=
 =?utf-8?B?OG9wMDJNUlIrVktyK2FzdE92MVlhYXF0M0kzK0pQNEhFK3F4S3hpS3BMOFRF?=
 =?utf-8?B?clJmMkI4cmV4MytzWTEzcXdEY1NpdTYxakhuN080cXFLRk91cG1IMS9WM3A0?=
 =?utf-8?B?Q0NxbWgwb2MxMzEzaGdzUlpocUl1WmlhKzlrYndDRzA2NXp3bTYxNDYyQlFm?=
 =?utf-8?B?YXRIN05aMmsrTXgzelk5N2RldExwM01SUlJkRlZab2MyTkc5bHVuWVpGSjZj?=
 =?utf-8?B?cGVmK0pxS0Rsdmw5Qk5PcWQzd28vK3lMSncxNEpHSXY5QjdBcDdvemtweThV?=
 =?utf-8?B?S21VYUhJb25CbmFBK2c0YUJTQSt4L1pnQSs1WDB6aU8xbWFFeHUwUUxoaVRn?=
 =?utf-8?B?RFpHS3VHQWV1SHRuS0ZXNDF5eHdIZnp1Z1M5Q0p0TlZPbGYrZFBPM1I0K0NB?=
 =?utf-8?B?bUJ4bGVaMEFkU0NpNEJLQlkvZVpvMHFJWDRrMlVpbVFzN05RVUUyZ3dJRWJn?=
 =?utf-8?B?elprbEhVdnJXVlZ2Qm5JcFlPUytHYm91UFZjUTBuaHFWM0dSSEZYRHU3TkNI?=
 =?utf-8?B?bWk0QVRHVlgwRjRXeXJwbkNqUjRVdU9xNjF6YjMwNFRlYlpDRUhJcGJEUWYy?=
 =?utf-8?B?WUNKM0t6RlhiZC9PbWM4aXJQa01vTEc0Y1pkVXA3aFAzT3lHOE5tSkVSMi8w?=
 =?utf-8?B?ZVptR0VFMWIrS0VSd2R3YTJySnArek93TnBQZUZyWDh1dnJCSDRLK00vVjdV?=
 =?utf-8?B?OFREMzhQSVYxOWNWSm9lVDdHSVEwOC9EdFk3OGpzcnd2RmVSSlc2R3JaK0lV?=
 =?utf-8?B?bHlrZ0ExeWVBaHJLektwZ1ByTGp3VmJZSUpKUkh0T1lEYk9Xem80TjRyc3hu?=
 =?utf-8?B?SjZDYTlFbWEwT3pXT0xqbmc5dVdGQUpBdnY4VEppdGU0eThEKzZsZjdkaHlD?=
 =?utf-8?B?UDgwZFQ4SzIwYmoxSmQ1cFNYY3NVczVFejR6TnQwcWxMMjZscWNuUzZDdDdX?=
 =?utf-8?B?Nzl1YnRBL011cGtXWnh0ZlgrS3VwOUY2QVRVbHZmVWFqWmhjVk5IRi9rWU10?=
 =?utf-8?B?UHJ6eTg2bUdOZm95QWdKeHJkTmN4UXZhSmNPYWdRNkFYTmpIR2lCY3ZHblUr?=
 =?utf-8?B?Tkt3amxjczZDaElZVGFyN2pFejA2RGg4ZXQ5cEI1SUFNUjdmRmNBWnpBZnJJ?=
 =?utf-8?Q?xrTp1MA6wAu6k=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b2883b05-72e3-4565-2925-08d89a936255
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 09:35:07.2746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rqp+38nEjVoPSMmGpCIguTXxolgr9VRzv+3oPnIGpoYN0kVtYg+gfUE3ZA/cP3G12XIlQbHrtoPEJ5MpnedRWYRjvn1/CuAiWtMrxSKe2uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6P190MB0215
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiAtLS0tLVVyc3Byw7xuZ2xpY2hlIE5hY2hyaWNodC0tLS0tDQo+IFZvbjogTWFyYyBLbGVpbmUt
QnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gR2VzZW5kZXQ6IFNvbm50YWcsIDYuIERlemVt
YmVyIDIwMjAgMjM6MDENCj4gPiBUaGUgZGlmZiBzaG93cyBubyBkaWZmZXJlbmNlLCB0aGUgb3V0
cHV0IGlzIGFsd2F5czoNCj4gDQo+IEhtbSwgaXMgdGhlIGNsayBmcmFtZXdvcmsgb3ZlcmxheSBh
d2FyZT8gSSB0aGluayB0aGlzIGlzIG5vdCBhIENBTiBzcGVjaWZpYw0KPiBpc3N1ZS4gTWF5YmUg
b3BlbiBhbiBpc3N1ZSBvbiB0aGUgbGludXgtcnBpIGtlcm5lbCBvciB0cnkgdGhlIGxhdGVzdCBy
cGkNCj4gbGludXgtNS4xMCBrZXJuZWwuDQo+IA0KIA0KU29ycnkgdG8gc2F5LCBJIHdpbGwgbm90
IGRpZyBhbnkgZGVlcGVyIGluIHRoaXMgc2luY2UgY29uZmlnLnR4dCBpcyB3b3JraW5nIHF1aXRl
IHdlbGwgZm9yIG1lLg0KDQogIFN2ZW4NCg0KLS0NClN2ZW4gU2NodWNobWFubg0KU2NobGVpw59o
ZWltZXIgU29mdC0gdW5kDQpIYXJkd2FyZWVudHdpY2tsdW5nIEdtYkgNCkFtIEthbGtvZmVuIDEw
DQo2MTIwNiBOaWVkZXItV8O2bGxzdGFkdA0KR0VSTUFOWQ0KUGhvbmU6ICs0OSA2MDM0IDkxNDgg
NzExDQpGYXg6ICs0OSA2MDM0IDkxNDggOTENCkVtYWlsOiBzY2h1Y2htYW5uQHNjaGxlaXNzaGVp
bWVyLmRlDQoNCg==
