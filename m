Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA7D3BEC50
	for <lists+linux-can@lfdr.de>; Wed,  7 Jul 2021 18:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhGGQgk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Jul 2021 12:36:40 -0400
Received: from mail-eopbgr60116.outbound.protection.outlook.com ([40.107.6.116]:25062
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229975AbhGGQgk (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 7 Jul 2021 12:36:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=af+QYJut8tjnbBHj25VHdi3wZpb5KMCTsMNPI4ywxfF9Wwx7BERk42LRqb/dnpguGieapWMfVdxIDA0btTiAEJJaYhhfjXryroarwaT2TuaJ2p4FJiqUqnh7M1Y+UwGoPkM+8w+rhzSvCbI9uJ+EQY8LfD2PHmz91HeacD5dXrN1ztha+bG42DoDMWvctnjXWuRb0S5imcSpMFNLep5Z8VsIbZ/jGSzTkxM6Y9+2jfnDvs69IQvAUd/R6L7/BZSHPQmw1cTcYxQvKaF6UpYG9MFGDDl0nfAvnphLDBz0uBm2SaZ/f9WJXgpwRnxs+xTjhzbbSFcbUgBN4RuZw2Z9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r6Lc9lXXvHyaXB2qUYDTTXL8eURpiS5/yjlCRtwECc=;
 b=Q55KyyNN+7yCBdGSOR4l77vS4O80gZt1g7GoCsYbKvhBcxjUtTkZPXbeMuvyGPZ4eOWos8vsIstO3oJRmZtUXReRM3oorM3MslZA2i9h/Hl7Z6A1ceSZY+wtdVcxxWo1c7FI9l+XXSKVkQPqY53o3JuMEHETn3mYHdx44DdulmF6Lx/HyIbhO0lAO6EQH1E6qbdd6HwYx7osmC8vsMlXuLE7LauTYdah0Eiz3pvvToQ284H0x3HQ5bUPdQKWRbntzlki0HvzyU729wbdsx+jR7oHP1bLpMtAm38Xu5Oay8fZ+mgO1K2b2sLMcN+ednfyGapoj/XLlSpw405+tHbfqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r6Lc9lXXvHyaXB2qUYDTTXL8eURpiS5/yjlCRtwECc=;
 b=l01q+FV5P17gzzsVxKvYln6lBr0/GFy4lqd9A4Fg1aqh/dO5rFUzWewlbOhaPowDmowWu0i/85+Yc+QQeVLeuEeM0DE7tcvzxMchX1Mwn91QxNi50yMKu7a3+yNb6eRJ3gsYCnUrR+XLfH45PjCByzhkHJpPtK7I36KAAsCEt9o=
Received: from AM9PR03MB6929.eurprd03.prod.outlook.com (2603:10a6:20b:287::7)
 by AM9PR03MB6946.eurprd03.prod.outlook.com (2603:10a6:20b:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Wed, 7 Jul
 2021 16:33:58 +0000
Received: from AM9PR03MB6929.eurprd03.prod.outlook.com
 ([fe80::6872:4ae0:6563:df20]) by AM9PR03MB6929.eurprd03.prod.outlook.com
 ([fe80::6872:4ae0:6563:df20%3]) with mapi id 15.20.4308.021; Wed, 7 Jul 2021
 16:33:58 +0000
From:   =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <Stefan.Maetje@esd.eu>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
Subject: Re: [RFC PATCH v4 3/4] iplink_can: print brp and dbrp bittiming
 variables
Thread-Topic: [RFC PATCH v4 3/4] iplink_can: print brp and dbrp bittiming
 variables
Thread-Index: AQHXbDSCn/Bl8ZqU7ESUUZPdia3lYas3w1qA
Date:   Wed, 7 Jul 2021 16:33:58 +0000
Message-ID: <0f23c1e5e4bcfcc7d8077c859788031b0e7214b4.camel@esd.eu>
References: <20210628154402.1176099-1-mailhol.vincent@wanadoo.fr>
         <20210628154402.1176099-4-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20210628154402.1176099-4-mailhol.vincent@wanadoo.fr>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51cd5c6f-5045-442a-7a96-08d94165050b
x-ms-traffictypediagnostic: AM9PR03MB6946:
x-microsoft-antispam-prvs: <AM9PR03MB6946133AB6740E7FAF5DC5A6811A9@AM9PR03MB6946.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oguf7OIK/YDmwF+GrfbtmU69sJqPa8i/dMCBTgrnN3zCKZqpg6pXNjQbtlGjs1ruGH2ysKt+jO5oOQ6OYAHEn8pnEQ/QnWdRr7Wb7mElPzPnkcYkMM95eW26IM/EnxYHexbU8OJI6VNbVLLAZkoKG0cdIOEgBZFy32rqhywLEpahKFwPNI3pH3Sk4JfI3rS3gCJu4LuzYOMX3lQ6JQjL/G1i73LYFMae26xTCJjufCYi2H156/+txdQZpUrrs24upmcx8zw5+WdfJtQ3ztOBU6Ce2NFhBXQQdgDbb/zWh/uAS7GFRxt/V+5tHD/Yw9GG+2uJzw3ox1tb2frslQhiYuliILu4tD2io3dUst0scY+LIIFRxbz4R7BUSKMQHRmNnAl5tvd9Co/HSdCGZcCUeHn2FIoPE3D07cV0utEvex1doJAf2s32i4uUQrtJlBzm7ck5GtfqB1hFJr4neUQd2OvKPL75Wz9P5Mi+rlx8LdWovClNQ0r2BQwEVSTUDAEsZPoRJFjsPQrEijabbU6hn8X9mWbmSxzwQtwgA+erkf2iwcn3iYkvOfWjxpCl6eDiAsBOugvmIRtjAr5GlSFBfPPafBAzTEopTLFrZMIw3UWU5EM98V/q7De4x/fpZADWFSQII6LA8rhCngTGGRpU+KYGzLTwpQ7+zsUv3lPbWOByaagOiqyfUxMEqKCv8PzWi+aMymr2xrgfPdy7PhuKwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR03MB6929.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(39830400003)(396003)(66446008)(85202003)(26005)(64756008)(122000001)(110136005)(38100700002)(66946007)(8676002)(66556008)(83380400001)(66476007)(2906002)(71200400001)(2616005)(316002)(6512007)(6486002)(36756003)(76116006)(5660300002)(85182001)(91956017)(8936002)(86362001)(478600001)(186003)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXMxdEdQdXdvZXhVWXNOVzY5bW5QSTRBZm9sZTUvSnQzODJna2NJeVB1T3FC?=
 =?utf-8?B?bEthbjRzcnFIbTJ3WnAydHB5eHhVR09oU3MrMTdTZHJ5N04wdW53akxFNzMr?=
 =?utf-8?B?MGdRSjRCbHFQeWprcnVyUXFTU1RjMEpzdkdwQjZwVmVMbFJoUys5REtxUDZw?=
 =?utf-8?B?Q09pUGozcFNXcG9EVEszNjBCOXJSbTdZZHQ1VGRWbmgzM25YampzK2QxL0pW?=
 =?utf-8?B?Tm1CN1dRL0Vqbm1SdXN6M2EvYVZtM0JLNlloVFNDUC83bmFzbzVrcUZiVDVu?=
 =?utf-8?B?clA4NzZJdFByV2VCWmZqU3NKTVBYdlZzMGIwV29jdndjWU1Gd252VVVEc0ZX?=
 =?utf-8?B?M0Z6S1p5UGpmQXpBYWRMT3AydkdJcnZKMGhneCs2YUZQZE44NjBBOFRCb3J6?=
 =?utf-8?B?K3VlVk4wMUxMWTNuTnZ1TnR3SWNuUEZIMGx1SkZ5TGpFT0NoVGVLc3dENVhk?=
 =?utf-8?B?WTZWYXpRQWVlY3cyVGlORmhVZEpzRlVxZ1JCQXQ5NmVuSE9XYnZYYjNMMFZG?=
 =?utf-8?B?WUtGR2ppanphbWpFdkd0anJCOSs3cW1Hc1VRYmlXWkp6b1JwaGp0K2dtS1NK?=
 =?utf-8?B?YnZ0OWhTZUdoUDFmaVI3cGNqTTdOZ1E1bmJyenlEZ0dKTGJESjd6MmtwcmVw?=
 =?utf-8?B?cENNS0UwMXdmdXY2Q1B0bW0rdndxQkpzeUJpN051YWRTQ1R4UU16WmVpT3Bi?=
 =?utf-8?B?UGJBWGYwY2o3SGhQZ25KQVM4ZEV4VjdmcEdDVEdtWEVKVUNTR0N4dk5tZ0Jl?=
 =?utf-8?B?VHVsU0hkY2VSVHB0ZzExeldWVFYzWlNNTnRraDQyMURST01BR05qck8yTkJt?=
 =?utf-8?B?cGRLV3ZyWjZlZE4xOVNaZnJtTnFZdzdpTS80Rjd6M3hkKzRtQW9Cd3ZBMmhW?=
 =?utf-8?B?ZjdhS09nNDI4N3RVM3NuZFRrdE9GeXdRUWNYZTNhRU5YcVRHZWkvTURaQUU5?=
 =?utf-8?B?aW9GMkNrNmZoQlJYTkY4VE9QUlFwRVZZbjVpdFRBTnhoL2ZIZ1VEMklZYzJj?=
 =?utf-8?B?QXczVi9rMkNFb3hUTjF5UzdIYVlGM3QydUdvU3o0L0daQ2lBNElOVmJTRW1k?=
 =?utf-8?B?QU10blp1WEdvNVZUUXVEa25WVzB6bjNTMkxNdzVoS1N6SVc2T3JySHgwM0xw?=
 =?utf-8?B?NGdYSk0xUFNPRm1qamh2OVd6Q0xxL01NZ05td20vK01DUEJXdk9sMHVhQldJ?=
 =?utf-8?B?cE9DVmVNcG85N1dzVnJsYVFZK3RqaGZyYzVIQ1FDN0J4SnpyckFRR29zblpB?=
 =?utf-8?B?aHh0Z3VKd0ZQamVUNVVNYk1ud2F2NGFIcXFCY1JlUkhEWC9tUVNJaUIrR05Z?=
 =?utf-8?B?UkxiVXFpanhFK2ZGcUUzNFNOL3RKZUJqUm1NZ3UraC9nUHY5Q3c1dEI0a0NP?=
 =?utf-8?B?VHlvd1Eza3RWL0drem1GcHZyQWY0eXBXMWJjR2tlRTMxL2RPRzRESGxrUERy?=
 =?utf-8?B?UHczcGlXZUhIcWs0SmU5eWtIRlpzNWdkd2dUbHQyVnNKTHhORDd1UCtJT1NJ?=
 =?utf-8?B?UFZuMnZZOE5SSlF5ZW54c0cvTGUyTllQUTF4NEwvUFgzOHo0WGFaRUpaRHZZ?=
 =?utf-8?B?UUg3ZnVPUE83ZHJBdlpUbzFZVHdTSXpTU2VGaE4zU3hvNW00aDErb2NkMWJr?=
 =?utf-8?B?NlZ1RlhLQ3FQOVdNTjFQM1JhVjBuS3FBZDg0SWFyNzBaRkhSR2JNOWtkRW5M?=
 =?utf-8?B?clJ3ZDdrMzF0SHZPbHpLYjVDU2ZtZDFUMDZwUm83OFZzZHp4eGpkUzJrbXNP?=
 =?utf-8?Q?xBbamh8b4tRS5eGEedB4U993XX+C/wZniyJ3Jad?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EB0E2493375C549901F33839CA0FA3B@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR03MB6929.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cd5c6f-5045-442a-7a96-08d94165050b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 16:33:58.0611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7YbIpRT3aJIPg0s9hBCo8duY/ztSsWHXhws2nfOrDvE13B4koutOkNdKTFhQPg/nfmj3M6CFsq1EoIDF2WzvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6946
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

QW0gRGllbnN0YWcsIGRlbiAyOS4wNi4yMDIxLCAwMDo0NCArMDkwMCBzY2hyaWViIFZpbmNlbnQg
TWFpbGhvbDoNCj4gUmVwb3J0IHRoZSB2YWx1ZSBvZiB0aGUgYml0LXJhdGUgcHJlc2NhbGVyIChi
cnApIGZvciBib3RoIHRoZSBub21pbmFsDQo+IGFuZCB0aGUgZGF0YSBiaXR0aW1pbmcuDQo+IA0K
PiBDdXJyZW50bHksIG9ubHkgdGhlIGNvbnN0YW50IGJycCB2YWx1ZXMgKGJycF97bWluLG1heCxp
bmN9KSBhcmUgYmVpbmcNCj4gcmVwb3J0ZWQuIEFsc28sIGJycCBpcyB0aGUgb25seSBtZW1iZXIg
b2Ygc3RydWN0IGNhbl9iaXR0aW1pbmcgbm90DQo+IGJlaW5nIHJlcG9ydGVkLg0KPiANCj4gQWx0
aG91Z2ggYnJwIGlzIG5vdCB1c2VkIGFzIGFuIGlucHV0IGZvciBiaXR0aW1pbmcgY2FsY3VsYXRp
b24sIGl0DQo+IG1ha2VzIHNlbnNlIHRvIG91dHB1dCBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+DQoNCkkgdGhpbmsg
aXQgaXMgYSBnb29kIGlkZWEgdG8gZGlzcGxheSBib3RoIGJycCBhbmQgZGJycCB2YWx1ZXMgYmVj
YXVzZSBpdCBtYWtlcw0KdGhlIGRpc3BsYXllZCBiaXRyYXRlIHNldHRpbmdzIGNvbXBsZXRlLiBF
dmVuIGlmIGl0IGNvdWxkIGJlIGNhbGN1bGF0ZWQgZnJvbSB0aGUNCmRpc3BsYXllZCBjbG9jayBh
bmQgdHEgdmFsdWVzLg0KDQo+IC0tLQ0KPiAgaXAvaXBsaW5rX2Nhbi5jIHwgMiArKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2lwL2lwbGlu
a19jYW4uYyBiL2lwL2lwbGlua19jYW4uYw0KPiBpbmRleCA5ZGJlNmFmZC4uMDBmNTg1YzYgMTAw
NjQ0DQo+IC0tLSBhL2lwL2lwbGlua19jYW4uYw0KPiArKysgYi9pcC9pcGxpbmtfY2FuLmMNCj4g
QEAgLTM0Nyw2ICszNDcsNyBAQCBzdGF0aWMgdm9pZCBjYW5fcHJpbnRfb3B0KHN0cnVjdCBsaW5r
X3V0aWwgKmx1LCBGSUxFICpmLA0KPiBzdHJ1Y3QgcnRhdHRyICp0YltdKQ0KPiAgCQlwcmludF91
aW50KFBSSU5UX0FOWSwgInBoYXNlX3NlZzIiLCAicGhhc2Utc2VnMiAldSAiLA0KPiAgCQkJICAg
YnQtPnBoYXNlX3NlZzIpOw0KPiAgCQlwcmludF91aW50KFBSSU5UX0FOWSwgInNqdyIsICIgc2p3
ICV1IiwgYnQtPnNqdyk7DQo+ICsJCXByaW50X3VpbnQoUFJJTlRfQU5ZLCAiYnJwIiwgIiBicnAg
JXUiLCBidC0+YnJwKTsNCj4gIAkJY2xvc2VfanNvbl9vYmplY3QoKTsNCj4gIAl9DQo+ICANCj4g
QEAgLTQyMSw2ICs0MjIsNyBAQCBzdGF0aWMgdm9pZCBjYW5fcHJpbnRfb3B0KHN0cnVjdCBsaW5r
X3V0aWwgKmx1LCBGSUxFICpmLA0KPiBzdHJ1Y3QgcnRhdHRyICp0YltdKQ0KPiAgCQlwcmludF91
aW50KFBSSU5UX0FOWSwgInBoYXNlX3NlZzIiLCAiIGRwaGFzZS1zZWcyICV1IiwNCj4gIAkJCSAg
IGRidC0+cGhhc2Vfc2VnMik7DQo+ICAJCXByaW50X3VpbnQoUFJJTlRfQU5ZLCAic2p3IiwgIiBk
c2p3ICV1IiwgZGJ0LT5zancpOw0KPiArCQlwcmludF91aW50KFBSSU5UX0FOWSwgImJycCIsICIg
ZGJycCAldSIsIGRidC0+YnJwKTsNCj4gIAkJY2xvc2VfanNvbl9vYmplY3QoKTsNCj4gIAl9DQo+
ICANCg==
