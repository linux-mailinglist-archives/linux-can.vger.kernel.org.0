Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3174A3E2D35
	for <lists+linux-can@lfdr.de>; Fri,  6 Aug 2021 17:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbhHFPIC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Aug 2021 11:08:02 -0400
Received: from mail-db8eur05on2137.outbound.protection.outlook.com ([40.107.20.137]:62977
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243246AbhHFPIB (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 6 Aug 2021 11:08:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eS0nwM0j6aqTmgdaKavEXzqXkZD9Xko8qqdg6RY83LIldeGK29SUGpP8I6cUWZ8h+3l5dPF1z5LRo+2T0ppI8lcAC+xRP+zvT31bG8X07VNpEyRpyiAaDL5oFqv/KnPoj67hvQC1K0SSVtXqqjNRjYJN7aJ9a/RZibCapcxl4fqjJzYWGGG3IFDT8pc6lVu7/swYwjp205GjbLoPfLYaINGpgTilxYRnO7c0Dz2Aw/ytaZk7+0KatxzQ2eFmmQ6SK/cHMP6ktEiHuIEovEJyYpbcQSHAzngkzYU8gI305PFJXBxNdmp0B0+FUu8VbGGIKodFxT1+qo/K/3is0irIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+qXWYcBDOy5YA6cEwn13lmOuVUO7BtUajzb62Wg12Y=;
 b=CdLxeZWY39GQBtOQTOqxLFBNgBcRA16vOby7LlUNaFPIbKHQqEipHftoR/2HzYC0fhUBpm4h6ZxTiHrb8Rq6kwBIL1CYMpP5X0POWETHAvpAi/a9NfHCd2Kuo/D6FgGd94zZ8tFOjqXUJZr0xTBxt55Ru4Vw0nMBOmWXf0azK1CjmLJFwy7gdM+X2oyAvb65jfBvEgZ/9CLDt2EcZdrtc1nwqqYVVYDWTWRKi0WoHFNPgkXSYB5PYo5oYZGt8jM5fyoIygyqsU56jPhI8/JbT4ESTrY/UlJW9UUR28kahTVEdhbuvd7PhLXO7oRort4Gyv2iHCSnXyPBYn0F3Maapw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+qXWYcBDOy5YA6cEwn13lmOuVUO7BtUajzb62Wg12Y=;
 b=uC9jOTb6AiVkdaSWj/bd55YogFLwmXfAgYPlV/VQMSAQDWathDdMT3rIyuLkUjEBFh0BofZtOQddyKmUQo6HSh7LwLCx/e6XvDgsYmO+moi5fJ29n7DBa7HXAVBkZ0PFCg7WdJgPVZAJ31qo2aouRjFbw0E0CSNwM23Rkq+gTZs=
Received: from AM9PR03MB6929.eurprd03.prod.outlook.com (2603:10a6:20b:287::7)
 by AM9PR03MB6738.eurprd03.prod.outlook.com (2603:10a6:20b:2dc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Fri, 6 Aug
 2021 15:07:43 +0000
Received: from AM9PR03MB6929.eurprd03.prod.outlook.com
 ([fe80::5900:9630:4661:9b0d]) by AM9PR03MB6929.eurprd03.prod.outlook.com
 ([fe80::5900:9630:4661:9b0d%6]) with mapi id 15.20.4373.027; Fri, 6 Aug 2021
 15:07:43 +0000
From:   =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <Stefan.Maetje@esd.eu>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH] mailmap: update email address of Matthias Fuchs
Thread-Topic: [PATCH] mailmap: update email address of Matthias Fuchs
Thread-Index: AQHXirCeglqz0Unlkk66HIEFwudub6tmlDoA
Date:   Fri, 6 Aug 2021 15:07:43 +0000
Message-ID: <10024d316c23d7be2ce6037f7994aa2af033208f.camel@esd.eu>
References: <20210806104833.102081-1-mkl@pengutronix.de>
In-Reply-To: <20210806104833.102081-1-mkl@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5-1.1 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3bdc086-c2b4-45ef-614e-08d958ebf106
x-ms-traffictypediagnostic: AM9PR03MB6738:
x-microsoft-antispam-prvs: <AM9PR03MB67389C0564059301F8EB5B0C81F39@AM9PR03MB6738.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L0ZofHnR8k8D3eS77buBkDwtGp0wSnbOQKvaPiNWgB65q9D8hMXMObHNYVA6sH5zbZ5mWxltQGQLoOd4gdHNgcg3HRZ9OAM+YvJwUemtFnFbgWmBIsT9dH7c7sEVSRN1gEa3pEuvqmoU6lnz7iuYy42RzmvJoeQ7/HZ/fNEu+j5flGgKB7gA3C12fQKPFYVUuce33tlunDsmCHRcmw0nbvGlGs8MzDJKriukqoTTlls7WQ7Gnx3YYZnX5OLQpwEn7LjnwuLy/fLgEB/OtwmuCq3sd//uPEQmSGMqOBHsgqKazS/p1b75STr8yZ0Z4HJOY2XmIAtqdYf6fqyRf7pe2CX8YcOz/sj9WtR9Jn+sUQ5GNN8cV+C3vAe97fNh+hlnMfh80FXWODtAhzj3SHpGNJ0MiVXl5q01cWtoTQ21xCY/UZzTb+bJ7abbaHEdoB9VtXGKgVNqfGSe//UvYkYzqS6XvvM/F7Y4zKao3mERWUkAOK+e1SzYdX7chpPjC1Piwf0bGfRVeP02kDuA2RwjqoV5pq/djSTh0oL749dLa1JoOg49fUKcwOgINwUfxbviuhxS/vPTjtXcdWbkLgCi2RXtfZB9NrMe94m51CjV5pu8N5G2ER8rG8sorZrZ+ZKs9LxF987vgiIXH21STj0qLvijqy7TJsRCpWyfOn/zo8iNVY2beBXsEwIyp9RwbvXf41qH3WbbdBacgdrM45l6gA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR03MB6929.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39830400003)(396003)(376002)(136003)(478600001)(2616005)(38100700002)(54906003)(316002)(6506007)(36756003)(66946007)(64756008)(66446008)(66556008)(86362001)(85182001)(66476007)(122000001)(4744005)(2906002)(38070700005)(6916009)(8676002)(6512007)(76116006)(8936002)(91956017)(4326008)(71200400001)(6486002)(5660300002)(83380400001)(85202003)(66574015)(186003)(15650500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3hSMGRpKzNia1lHY0VWUUIza1ZiamdtZmxORU1sYjFRNEVBRnJtc0Z2TEdG?=
 =?utf-8?B?WlFlV25idHhlS081TFhrRnV2ZXRNYm5oNG9vUTFwamdNTTZHUG9rR0lnR0JM?=
 =?utf-8?B?OGtYYzZvOGZxczE4RHdrOUJIVG5nYWdOejJ1cnYrTERvcklubGtsYklIUEFh?=
 =?utf-8?B?dXdzbGJqbDR3VXVldTJBWm4xTUdCdlRZQXQ0SmU3c25EWmJBRW5hYjlRSFA4?=
 =?utf-8?B?UkViWHlFdnFCeFpYdWo3ZDJWNmF3Myt3ZlNTZ3lZR205ZWM3MU1rSEVOQWd1?=
 =?utf-8?B?L1pGdXNCMzJLZFkzNVROQjh1MEpnb2lxMGk3WXlNS2MxRWEwV2VCY01UZjdE?=
 =?utf-8?B?c3Zhcy93WUMrczVEVDdzY3dtNVhOc3BLcEtya3dqcmdqUlRDSEp1RCs0dFpE?=
 =?utf-8?B?U200UFVuK0cyWkhYUHhDeE91OWpxK2VKdEdnN0trb2lzZEV6VmUyaUhCc0JG?=
 =?utf-8?B?QnNhS2JoNjlub0xGcUp4dWFKTWJDRWJBU1ZCazNyNTZtbGdpdTd2Ym4yK0tM?=
 =?utf-8?B?RHBiQUp3ZldmODE1cWdmSWdEeitlZDVSSE5vS0hKMHZoR2UxODk1MjJGVEZj?=
 =?utf-8?B?Uk9VR1hoRGFkamNwUlduNTUwQ25BUklkOTloUk5qNlVScUtaN25XTlgydkFF?=
 =?utf-8?B?a3pTYWowVGduOFMyQVpnU2VzSnZUbjNkNCtQVUtEVzIyeW9MNXh0cERxZldQ?=
 =?utf-8?B?TWdvRTMrWk8veUJPT2V3aC9vYi8rc1hoSjdPbDd1WWtvdEFEQ0o5a3B0L2s4?=
 =?utf-8?B?cHRpTlNZRTkvN285bWxOVWowQUNNWEVEc2k3OEpsMnR3KzBwMCtjOVVKUFd6?=
 =?utf-8?B?TkJDSUZITDdTT2JRR2t2L2Fqa3FqQ0FSazVnOWw2b045Wm9RSWtzTklpKyt3?=
 =?utf-8?B?aFhTQlc4YWt3QVh0azlJY0xmeCt0NksvcjFPdDRMdFRDMW04Q3dpRmpJMTFo?=
 =?utf-8?B?TEhFa1FzVGRXaE14TmpEQmJ3Rk9mMFVrSnZpVDZONitnMVFJMnNQL0ZGVEMr?=
 =?utf-8?B?RGhIU1lxRjFWWlZTSmJqd01rKzJiN05tcmg3L3ZZUXM5SzZDMGxpTnhOK0tE?=
 =?utf-8?B?dmp0Q1IvMjVsUlBSZ0RsemxZUmtURjNGdXZhRDZ5ZXphdFBQUmRKSVppU0Zi?=
 =?utf-8?B?R0txUXpvdHBUUFBleWFQaVdIN25JRURlWWcxRWloVDU2OTUybVpkQnBGeFo4?=
 =?utf-8?B?cmc2cWpueGVJMVFlMmtiekJmbE5WR0U2eHIxcE5hWkdFQVU4MHFGUDZUdkFa?=
 =?utf-8?B?Vjh4TVlmTzR1dnBZVjJsOFVvM1JUbTVKaVNGZXlzNWxhanJxRGh6SHZ0cGxp?=
 =?utf-8?B?UnRCakN1dlNybHNJbzhzdU53UzFXY202VHVjMWJVL2ZLS2J2bGJ6TGtKV1Aw?=
 =?utf-8?B?MVhCLzhrVXBYTHpKQVc3U0ZnNUdYV09yN2E3YkNhQi9CRWJLbW9yc1FHcU03?=
 =?utf-8?B?K1dFaXBXSVlzQnRrbERzT1pNcDhjY1ZQU3ZiUzFzOWVFWG80NjBEMzYzVjBQ?=
 =?utf-8?B?bzh1OFVOalVrd0JCOUI0M2trQ3ArOWdHMlhOUitVVitkT085eWVzY2F6em4y?=
 =?utf-8?B?eURTTU5zN0hiRWxBS2NJdnMyaUFKOXlVY0RBeVJWT3plWDFBaytFVUpRVHVH?=
 =?utf-8?B?Sm0zZi9xbU9sMHo0YmtLa0xCVjZuVGNRV3NHd01TNmFreHZNb0ljYnVBZjFk?=
 =?utf-8?B?MnVFYjVGamxyaE1BeUZZdVA3THlRUDFtVnlGTXJadURIbXNoUExBS3RyV1ZM?=
 =?utf-8?B?QnpTOHpTL01pbXZGcmExcHFTS0Q5N3RvMDcyMGsxZkw2MThJOVU5ZWxvRS8x?=
 =?utf-8?B?b3FoWTgwNTk2TFE5NE5PQ3Z2R2ppcmxWZmJEcHZHWGgrVmR1N0lrczVYcjIx?=
 =?utf-8?Q?dZo+RLJxQyK5F?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C1F12AB0F47754D9AC54620EFCF4090@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR03MB6929.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bdc086-c2b4-45ef-614e-08d958ebf106
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2021 15:07:43.2946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Imz1azu7M5l4fhUJ3fhy1ID/QO5E0kHS6qSN3kRqWAOytrCELkpbe4zmXgHkdYnPO/EhTac937neeyu2gYZs+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6738
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGVsbG8gTWFyYywNCg0KSSB3YXMgbm90IGF3YXJlIG9mIHRoZSAubWFpbG1hcCBmaWxlIGFuZCBp
dHMgd29ya2luZ3MuIA0KDQpNeSBxdWVzdGlvbiBpcyBzaG91bGQgdGhlbiBhbHNvIDx0aG9tYXMu
a29lcnBlckBlc2QuZXU+IGJlIHB1dCBpbiB0aGlzDQpmaWxlIGJlY2F1c2UgaGUgaXMgdGhlIGNv
LWF1dGhvciBvZiB0aGUgcGF0Y2ggeW91J3JlIHJldmlld2luZyBhdG0uIGFuZA0KaGlzIGVtYWls
IGFkZHJlc3Mgc2hvd3MgdXAgaW4gTU9EVUxFX0FVVEhPUigpIG1hY3JvLg0KSGUgYWxzbyBsZWZ0
IG91ciBjb21wYW55IGFscmVhZHkuDQoNCkFtIEZyZWl0YWcsIGRlbiAwNi4wOC4yMDIxLCAxMjo0
OCArMDIwMCBzY2hyaWViIE1hcmMgS2xlaW5lLUJ1ZGRlOg0KPiBNYXR0aGlhcyBGdWNocydzIGVt
YWlsIGlzbid0IHZhbGlkIGFueW1vcmUuIFVzZSB0aGUgbmV3bHkgY3JlYXRlZCByb2xlDQo+IGFj
Y291bnQgaW5zdGVhZC4NCj4gDQo+IENjOiBzb2NrZXRjYW5AZXNkLmV1DQo+IENjOiBTdGVmYW4g
TcOkdGplIDxTdGVmYW4uTWFldGplQGVzZC5ldT4NCj4gU2lnbmVkLW9mZi1ieTogTWFyYyBLbGVp
bmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gLS0tDQo+ICAubWFpbG1hcCB8IDEgKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvLm1h
aWxtYXAgYi8ubWFpbG1hcA0KPiBpbmRleCBhMzVhZTI0NGRmZGEuLjg2YTYzMGQyNmNmYiAxMDA2
NDQNCj4gLS0tIGEvLm1haWxtYXANCj4gKysrIGIvLm1haWxtYXANCj4gQEAgLTMzMCw2ICszMzAs
NyBAQCBTaHVhaCBLaGFuIDxzaHVhaEBrZXJuZWwub3JnPiA8c2h1YWhraEBvc2cuc2Ftc3VuZy5j
b20+DQo+ICBTaHVhaCBLaGFuIDxzaHVhaEBrZXJuZWwub3JnPiA8c2h1YWgua2hAc2Ftc3VuZy5j
b20+DQo+ICBTaW1vbiBBcmxvdHQgPHNpbW9uQG9jdGlyb24ubmV0PiA8c2ltb25AZmlyZS5scDAu
ZXU+DQo+ICBTaW1vbiBLZWxsZXkgPHNpbW9uQHRoZWtlbGxleXMub3JnLnVrPg0KPiArPHNvY2tl
dGNhbkBlc2QuZXU+IDxtYXR0aGlhcy5mdWNoc0Blc2QuZXU+DQo+ICBTdMOpcGhhbmUgV2l0em1h
bm4gPHN0ZXBoYW5lLndpdHptYW5uQHVicG1lcy51bml2LWJwY2xlcm1vbnQuZnI+DQo+ICBTdGVw
aGVuIEhlbW1pbmdlciA8c2hlbW1pbmdlckBvc2RsLm9yZz4NCj4gIFN0ZXZlIFdpc2UgPGxhcnJ5
c3RldmVud2lzZUBnbWFpbC5jb20+IDxzd2lzZUBjaGVsc2lvLmNvbT4NCg==
