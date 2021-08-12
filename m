Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE283EA50E
	for <lists+linux-can@lfdr.de>; Thu, 12 Aug 2021 15:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbhHLNBl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Aug 2021 09:01:41 -0400
Received: from mail-vi1eur05on2116.outbound.protection.outlook.com ([40.107.21.116]:37984
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232356AbhHLNBk (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 12 Aug 2021 09:01:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjrSng8KdX9jfB06NK3k0WHN38JPoJXtdeFdengcq8HmyArbI2EFcCbb1MjsGJQ3nT1yAwGCnpG8NyIk/BPpl3l/kVB4KbtSQEvDGTbqCSuR8LR3fLCGI13wewKh+cTn52bDC6ZfF9yd1wmITiGRWIEVirQJbAU1W3bXcub2z5gF/B67mR0GFGvxLEZKWKBdU1YGXkOHrDCBEEyPowXOVFh+6uSM1WotTvPBjMQOlKbGn2CCg9VShlRrj3yc2YtxYH/1FMePXMDCx7qMda1Zqcj9d8UWKgGmoTrz/3BoUBdTZht0kDwD3TkMGxTZ920To4xiKt9nNCVIYiKultNSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpXIwVPx77WsJydxOGgBN53wr7QvjSDrEv8p7x+sazs=;
 b=Hb5s532J+WcZDZ4HMUMHVa9LPFhYZjmUbKXJKZp6UYzz/0YzqtW+yILiuNvvbS8rGArXdgMjuiGIIya850Msp5G/kY/ffDAZVauf5fCMycr0IQgM5sT/utD04WUZzOajOxlBVB18AuLTGirRUfhl1RTr+VQJnD5BlBgIdfqpkuLQEmJZrl6Y8tPbvSFUxKMqrV/mfPv008pvsndumLTqPCzNpU87JE77nVXcXriLlDc7+2no4tWKNYtkEz3b0coTc7XhNqhcItgOu6GGMbowp5/hVomQ5wqEcRY7tGSDFdD7zN1bF6lgYqRD0NfjVat9t2mMUm2TXLZSHpRwRGJ38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpXIwVPx77WsJydxOGgBN53wr7QvjSDrEv8p7x+sazs=;
 b=Y69V0jRj53WBrdY/OjjQUy+IR0HbJddjCGck/683DS7HOX/0ABMjOpRqmhaSLPGvyMsAzANfUmJDATIiCBjASkG1cAL5OueNd0wdwJHWloTwZNWzUoqWeal3FRYhCRiVxFKVo/c+xFMPuHSC6LaHhMHa9jUAaeZF/xKHjtuJ/yI=
Received: from AM9PR03MB6929.eurprd03.prod.outlook.com (2603:10a6:20b:287::7)
 by VI1PR0302MB3358.eurprd03.prod.outlook.com (2603:10a6:803:1a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Thu, 12 Aug
 2021 13:01:12 +0000
Received: from AM9PR03MB6929.eurprd03.prod.outlook.com
 ([fe80::1846:f0d4:5710:e65d]) by AM9PR03MB6929.eurprd03.prod.outlook.com
 ([fe80::1846:f0d4:5710:e65d%5]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 13:01:12 +0000
From:   =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <Stefan.Maetje@esd.eu>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "joe@perches.com" <joe@perches.com>
Subject: =?utf-8?B?UmU6IFtQQVRDSCB2M10gbWFpbG1hcDogdXBkYXRlIGVtYWlsIGFkZHJlc3Mg?=
 =?utf-8?B?b2YgTWF0dGhpYXMgRnVjaHMgYW5kIFRob21hcyBLw7ZycGVy?=
Thread-Topic: =?utf-8?B?W1BBVENIIHYzXSBtYWlsbWFwOiB1cGRhdGUgZW1haWwgYWRkcmVzcyBvZiBN?=
 =?utf-8?B?YXR0aGlhcyBGdWNocyBhbmQgVGhvbWFzIEvDtnJwZXI=?=
Thread-Index: AQHXjUhG3mIttoh8gkG1s5jIQBQWVqtv2a8A
Date:   Thu, 12 Aug 2021 13:01:12 +0000
Message-ID: <cc4f84df2a2512ea3b2d93d665fb28413aea09bf.camel@esd.eu>
References: <20210809175843.207864-1-mkl@pengutronix.de>
In-Reply-To: <20210809175843.207864-1-mkl@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5-1.1 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6419b080-703e-4fb1-7f89-08d95d914327
x-ms-traffictypediagnostic: VI1PR0302MB3358:
x-microsoft-antispam-prvs: <VI1PR0302MB33582E9AE5446F4E4D8BE83681F99@VI1PR0302MB3358.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fZaLHYur70qtNfKANdsiXX0d9JWVHFO7S+Sp/e/FGTvVZW3ZCieL2d4b0cfu5+AS39vCL3TPWHqH0mSpmJgLN8S6r81JmFRb4Yro1b0MGvb8mTlmPmaUGEPhFIToL6r9yfBJhgi4Q0rE8FkTPkmApwwa9+WX95H0AnOb+bqjD21WWRIdrAGzxoztNzArJiJcDiYYadPuWgql0OBtXu3lzwXU84dldIegTE3a/pJW6ZtH2Q1vLy99d3sygqO+rgHSQk5oDTXFkE6TdSce8uSVR7AYFv7/dtjhx2q1ZFS4FdbrKCHzciGzatYyl6LpKWLxbosbl1ih2qvxe2R1qPmIRADvXW7Fu3/9b+7u/66Y+OqWFE7Bd1jdHAsjXxnT/Xokw5+4l+aBJNM8X7T7ZkHJH0L6xvOMQsyJQ8xtE0UVxy8SbkQusrN7VsMwMDhLmPb2E2evLsSlwr+lU4aelRnZbWPQJfSRSXVOdSLesKljXCIVBTfvT5GNtjOfSFrmzkURZu/A+Gc54Cr7fhRACz7GfIU1KfyR/I8HiwggxUW7GWU8XPkanshL9pe9FrVFi0D8OcHm7uyXTxJX3SMbH7Mfct02KPQh02QlIOhJLt0uUi1Qzn/H0N3y1qUqSCrG/RoHU0QnKg8nHlQ1i8EqFPnRX5lV9Ak3UHtnrjq6ZJR6/Vxi54vcHvAJrS4IW8fnARCBs7Nt7tIxyANlCOPedxzOJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR03MB6929.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39830400003)(366004)(396003)(2616005)(85182001)(6486002)(38070700005)(15650500001)(4326008)(8936002)(6512007)(38100700002)(110136005)(224303003)(316002)(36756003)(85202003)(6506007)(71200400001)(478600001)(122000001)(83380400001)(2906002)(186003)(5660300002)(66574015)(86362001)(66476007)(66446008)(64756008)(4744005)(66946007)(76116006)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzZDcWp5NC9TY2FOTDhZb3hTK2xxbEZQUys5QTl4THVOWEJzclgrcXBYMWY4?=
 =?utf-8?B?eDl5Wmg4WFYrVUZpZXE4WHVFalRNeGpRT21EdTZZb0FwL0l5SmQzWjVhUVpa?=
 =?utf-8?B?dVJaeDlCUHJlek1EUC9pY3Y1ZGdhblRRN0JOclR3NDdaSW45bHJCRVNybG9R?=
 =?utf-8?B?TTc0RWhtWm9ZM09TcHBHOW5vM2NuSWFDTjMyNGZoaHhHR2NNNXdkSFI3Nito?=
 =?utf-8?B?VUxpRG5TeFVDazNtVDZFeGh1T0dzT3pLcHMwYVdGQkxOcEZTdFljWnVMRU5G?=
 =?utf-8?B?T24yazNqMzhJRTgwUWNLbHZQK09weU9BZnpacjZIZy9taDZQK1QwRGNKWHgy?=
 =?utf-8?B?VGx6RG01TVIyeFVVMG9VN01OKzBFaGl1Z0JRYVcycmpQVGRHMnQ0Rjd0UFp6?=
 =?utf-8?B?bVEwejBHM3o0YWlENUpmbXZRaUlHRy9pUGpYdGRzNVNQWkdGUGJZSUhrNXZa?=
 =?utf-8?B?MkFwcHNRVHU1dy9jelZvbjN5SUdNRHVLUHN5TmM0Q0hDaktrQWFINkh4SEFR?=
 =?utf-8?B?THFKNjlVYXVjOS94cnl5anVXcUdnNUhnQWdEV1pPQjNCOHVFb1NLUTRPMjZz?=
 =?utf-8?B?QmFzakhEQjdQdU44M3pYN2hIbFIrUmJxb0JMajArbXJyWENvdXdlQWZGUUUy?=
 =?utf-8?B?bXNQa2lkV1VMaEpGZjNxUG1JcGZDdUZwVG1MTHBMYXY1c3dnNmNzZ01IN2Q3?=
 =?utf-8?B?ZXVUdVp2Y2JrQVh1MVlubHF3OEJ0QzVpQ2RXVG5oN2E0T3Z6bTRWWW9PSjk1?=
 =?utf-8?B?UDBrcVdybkF1YXFSTmdJRHlUVHhRM1lLWE8yV3BZWXI4TTBqK0F0eFF2WkJw?=
 =?utf-8?B?OWwxYUxrVWpValJReTMwZkdpV0g0RTd0ZDRUU1NsYUw5S25nck43bUJrVGNK?=
 =?utf-8?B?Zk93bmhHSC9qV0ZvWlV2RWprOURNSTdWd08vSFBIM0RhcG1uV3VwZnlUeGhK?=
 =?utf-8?B?YlZ3MXFZdmZLanZDWTk4QWVhQmNTTko1Y1lWOFBya0ltWmxidDdtQ1F4ZlR2?=
 =?utf-8?B?TGJRMXN4a044bkRZM3A5VlI4U082RnV6dmNLREVNK2xvQ1J6ZGdPRU5wcmg3?=
 =?utf-8?B?Z0MyZXZHVjNKcXdESzlhK0ZZT21iWjN1cWZhMUJEaUdSMUxiN0pFSDVpOStZ?=
 =?utf-8?B?VHBsUVBWb1pFNGpxMEZmNWxna1FOMjBsR2MzU1RsRXlMMC9SV2ZqeDB0UVph?=
 =?utf-8?B?M3FJUFBFMFhwZmJHRHJaSEtvZmZYYWtFWEhqaHBqZTFqQldkQmcyZTFVdWUz?=
 =?utf-8?B?T0wwZGZVNDNwNUk5SnZsOVBQR01zY1hkK3h2RmVvUzFLRkNoOEYzTjkwV0VG?=
 =?utf-8?B?Q041QzFmZ3FrWmpERnpuQnplanF1ejhEaklIRmI1THBRS0RkbU5LWk9KVEJC?=
 =?utf-8?B?dHlydm1vS1FBT1puZ055ZzVmOEd6MlYxekhOMWRUV1RINDR0RzdONHZSeDFY?=
 =?utf-8?B?WUZqWUdJL2JaM1hTaDBiMnoyTFhSb1hHUWhEYytDdnc0ZitLUVFDM1pQZjNC?=
 =?utf-8?B?QVB1SFJHeXdOVW1CQWRUTkkrS3pLQWdxVTlqMGw2dFVGa01tSit5TGVPYm03?=
 =?utf-8?B?ZlJCZW9ISHRqU2tSQkQzc0orM0RIMW5HN3F3dDBsejYwZmcwZHVPN2crSkh4?=
 =?utf-8?B?NXNRTEgxK3NwSXNLNWIxWDJvSWxvVi94aTQ2NE5aZzVKUUpTNzEzSjJNS0xI?=
 =?utf-8?B?K2VSNUhtbkw1WFduWTJhdVVJZ3diNUhDM0ZQdnJwa0Izc2hYOE5ZbmVGMTNw?=
 =?utf-8?B?YTFSbHpNY1E3TlJLWXN3VWw0ZUJNaEhXai8rbUo2WEV0cGtVSGk1WTE0WDhP?=
 =?utf-8?B?S1ZLc2Q4QjhMSXRsSGZNZmRIbXpnNTYvVlFZSUdjWnhiVXlyWkpzVkRMRUhs?=
 =?utf-8?Q?DIFtOlQYjrQij?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <251199B56E2FBC4D80BD8ACF32C884F3@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR03MB6929.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6419b080-703e-4fb1-7f89-08d95d914327
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 13:01:12.7122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZ77fkiHRgx8qxDgbgndqbPSyawkcsFAoF1luJgw7W4RkPB4snsKt94D5nwQMYsqqZX8WIkKxyWTHRMWqO8fyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3358
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

QW0gTW9udGFnLCBkZW4gMDkuMDguMjAyMSwgMTk6NTggKzAyMDAgc2NocmllYiBNYXJjIEtsZWlu
ZS1CdWRkZToNCj4gTWF0dGhpYXMgRnVjaHMncyBhbmQgVGhvbWFzIEvDtnJwZXIncyBlbWFpbCBh
ZGRyZXNzZXMgYXJlbid0IHZhbGlkDQo+IGFueW1vcmUuIFVzZSB0aGUgbmV3bHkgY3JlYXRlZCBy
b2xlIGFjY291bnQgaW5zdGVhZC4NCj4gDQo+IENjOiBzb2NrZXRjYW5AZXNkLmV1DQo+IENjOiBT
dGVmYW4gTcOkdGplIDxTdGVmYW4uTWFldGplQGVzZC5ldT4NCj4gU2lnbmVkLW9mZi1ieTogTWFy
YyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gLS0tDQo+IENoYW5nZXMgc2lu
Y2UgdjI6DQo+IC0gdXNlIG5hbWUsIG5vdCBvbmx5IGVtYWlsIGFkZHJlc3MgKHRoYW5rcywgSm9l
KQ0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiAtIGFsc28gcmVwbGFjZSBUaG9tYXMgS8O2cnBlcidz
IGVtYWlsDQo+IA0KPiAgLm1haWxtYXAgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvLm1haWxtYXAgYi8ubWFpbG1hcA0KPiBpbmRl
eCBhMzVhZTI0NGRmZGEuLjZlODQ5MTEwY2I0ZSAxMDA2NDQNCg0KQWNrZWQtYnk6IFN0ZWZhbiBN
w6R0amUgPHN0ZWZhbi5tYWV0amVAZXNkLmV1Pg0KDQo=
