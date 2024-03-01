Return-Path: <linux-can+bounces-349-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD1D86E124
	for <lists+linux-can@lfdr.de>; Fri,  1 Mar 2024 13:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F082285B35
	for <lists+linux-can@lfdr.de>; Fri,  1 Mar 2024 12:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A43A1385;
	Fri,  1 Mar 2024 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="Nw4OehNN"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2116.outbound.protection.outlook.com [40.107.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4991115
	for <linux-can@vger.kernel.org>; Fri,  1 Mar 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296635; cv=fail; b=k44jW3pFuKJJ10hF4pVKcn8Guv5seUVALdIbOv3KhIESpyGwn8dXFrE/HeoX/r5cZaOwFVlnIEkYahhogMGYRY2Rpydr50THUt/qYVMnLqkNJimcqxREeYkOjEayEi/WmZFj8OVNi/68/dqokLQr9fXExgGnlRVRZIfy41gRfYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296635; c=relaxed/simple;
	bh=Wa74qDlHo+wZ3Qk9eACiUmAFfRhPq2XrXHDE8J3pEXA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a2L0W6LkNJI9McDkag8A3nGkgzzyjc+ie7265ahf4RVaTe6X3F0n+hrDDMWy1QhxZ6/wGCZCytsXb+AtokILjd5z8oV7N+E/NVcpm23SHbqB2qWDXxSrH4kxZDVUKU7xAfxPkcnTWz6z6QkKLj0IQAb/cGADM9K0r6joboicZdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=Nw4OehNN; arc=fail smtp.client-ip=40.107.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeLzeS+EnXWbWxbDj8Us5fHOCO9PkIGfDy8ZSiiuMlFS9FHrhX4tQA0/W01/79SI99vPTa37uS484GmbY6Ynm0/9Wu9xCXdGgFdx6UHhOgXjm9tiyaOHYV+XNvIOMszHG7Gw167QzS++Oa8j9WXDvEGQXa4zEzmZp47BzersfeLCwg0WFBtOhQvJH/PWlAst8iV0uuRpBeI9JfIfWEoSd/uXnPheeRJTSBOb3kOIE/7ln5n5TTnTlEo1CPfzBgqZ8V6qHRFqHltATP5+93h7GE7QFxn/Cq3UqwZtxuZ27IcVZTp93NZPkBDSwe9UxiyJVbQjrkRYPIQnZJHp3FrQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wa74qDlHo+wZ3Qk9eACiUmAFfRhPq2XrXHDE8J3pEXA=;
 b=jHCOZEL+rvCyWPZSYVyyZDNyzBzR1/S1+WLMsC4o7Pg00ES/Cpkgc/oXF8UgpjUmUvRDxxNhw9c0RNexHdXh3OTuo4tghFpneY6d9Sg8Qx1iq/WeWxlB5Ks8TEvVM2dqgQYlRC+C4fAKsDmpopWLLeTee4YauCiS0+UMnLMOMar+NXopUNMBoYMp6xWjdwrr3SeH9ipGDl/32JxOSSimVD8m6yLj/iCJO8mI2F6HIAo2ilg58zF5hcHeq+9s8NX8DtZxgn/KP0stY9lBQUK+nwYSbs603yhsNps3c3SHp2UY7YiYBg+yqvU94g2PSkjf1wO2jlpD7Pc0ZwxfpYajSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa74qDlHo+wZ3Qk9eACiUmAFfRhPq2XrXHDE8J3pEXA=;
 b=Nw4OehNN9Pb3vL43y95K518G16btjl7sUDHpLfOWIJcpZwhFAtP7yPr8pT8m3IRzOwMdO6tiHdYXdl6U48NkHJ0kUWkKLeqw56bdqJayjCg05nPa1CUb22/RmWQK+BTToz24deoH7NFGAMB7c16Vd6vbveWrVEpUJAL0uqEuGZE=
Received: from VI1P193MB0559.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:144::17)
 by PA1P193MB2468.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:461::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 12:37:08 +0000
Received: from VI1P193MB0559.EURP193.PROD.OUTLOOK.COM
 ([fe80::2c3f:a538:fce3:55cf]) by VI1P193MB0559.EURP193.PROD.OUTLOOK.COM
 ([fe80::2c3f:a538:fce3:55cf%4]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 12:37:08 +0000
From: =?utf-8?B?TWFydGluIEpvY2nEhw==?= <martin.jocic@kvaser.com>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"mkl@pengutronix.de" <mkl@pengutronix.de>, "mailhol.vincent@wanadoo.fr"
	<mailhol.vincent@wanadoo.fr>
CC: Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH] can: kvaser_pciefd: Add support for Kvaser PCIe 8xCAN
Thread-Topic: [PATCH] can: kvaser_pciefd: Add support for Kvaser PCIe 8xCAN
Thread-Index: AQHaa9UsbEFQUgvGvUe5U1UOna9D2A==
Date: Fri, 1 Mar 2024 12:37:08 +0000
Message-ID: <2b2c720a788e1904283e354abb320adb5b631d26.camel@kvaser.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1P193MB0559:EE_|PA1P193MB2468:EE_
x-ms-office365-filtering-correlation-id: 9508cdf0-ccda-4aab-d9d8-08dc39ec4f6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yaT+mmCKSVKlWKw5H82sh7Foy+r/9BbcBPyJyvyXUx9cow/MgGccGz/aoZBeiMXjio9BkhCD8fNMu5hPLGFoIfYSfNp7GwhGupr5JEBgBGv+fMkVj6JU8mCAw33Q8O6MTGfJnug4olAgKOJmDBG/3yGqwb594fltoK4m5RBXtlaCRJTH42sEYUf9gQodo+6syd0cHZA6R8z6Jv69r3+38Z+4VbU7uAtB0i0m+5MBChgUHKRSjPTu/Cz6IuIFidxbcKIVNNORApuDBzPxsFM5PB+wa44W1pIvaO4w25Cb1Rg1drkdU8S9tLKFlhECNG2hNkj9D3WNJfR4HJ/EvM3tQ1O580p9VybhIaVFrb7oieiSmQwYiDCBhbmWQAi3H7Y9s8OTMsJlmIZIPyq+DCJsV2y1IPzwsDQ8pZTXH9L3qYluUTlNWnYLVuf3w+s42Qak8udNkJwy8AR3/zX9VOHPaCt0T3wXlB7OgdMOwMLBnw8OL7VWeI2LIZjw0C5oF4xrRYtjiIGVMxrmaZPvNsRD5bQXHCy/LIGUtJRkalksWIPfsx4CX0Vd08Dpb+kH/1Zwa1owIeSHH6/llOSa+0ZyHUo+JtAsmfjCv/sYr2IhAczSiuER+tcAdmhVFlpLcSGFUd+aRY/dUk0anCU7ZNPFjOI1oU3YUJdZcgvvoVBH8QjgPEVKVAz9b8RO9EEMajvWvg8gv7AiqM17hzsrPawRPw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0559.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vm1YQ3JyWkZEY3p0KzhMcllZeHl1Q3dUMkVrY1d6K1BvcnUwd0JySzBYQVA0?=
 =?utf-8?B?RGQ2Y3FUbWJXMnU2UlpoNy9Pd1UzLzdRbnE5ME83YXlITzRDejNQR0NUOXVE?=
 =?utf-8?B?QTYxYVk4ZkpWRXVmNnVpZ0lNM2FWYnhZZTkwdmdna3dpWGUyVG9tVExSVFE3?=
 =?utf-8?B?U1pBWE5LVDlMdFBmem1QL25xYi9SUTZjR0toU3dML0VPb1ZIRURKN09VdUxy?=
 =?utf-8?B?Y05BbDljWkxtbFkrKzEwSDFHZ0JHTlZOOGhmL2xJQjFZUS92U1J3VTRwNzc5?=
 =?utf-8?B?R3U2TFM1ejU4UnlSY1hvSGttMXlkeTdRY08zV2xYZmVEbWdBeWpDdklaQ2po?=
 =?utf-8?B?ZWZsSGtGWkVTdTIyZzQ0YVFTaVVDRWY2L0lIejViNExHVm9OYTlNc1QwZU1J?=
 =?utf-8?B?bkRIeldZcGt4ZkNFYXpHMXdzekFTSFJCRUhIaTN3ODVMUVdOSVYwNVhvc2JH?=
 =?utf-8?B?MGdLUlFycm9LaGZCdGFpUG9pVVlSRm12ZTB5SGg4aC9JVXdrY29aRWRXeFZU?=
 =?utf-8?B?aWJSR2gvcjlNVHFrdlhXb1hDSnNab3lHWXhTd0VqOXJsTldlMnFKWS83QzRj?=
 =?utf-8?B?REdCM2t1dVpycVA4RFBEcEZzajZuOGFDWXB3RkNTMlpBdmRvVWorU0JhVVc1?=
 =?utf-8?B?RWRRaHdBNTFvcUk5ejIxM2ljV2dMR2J0V09tOFo1cHdlb1lhYldwckRtdTQ1?=
 =?utf-8?B?dlNMM2QvTjNTTmx5YkxoeHlxOFVMbzRNSzBlSFRDR01JQnljdWIyMnJDTjZB?=
 =?utf-8?B?bHllWFdNaU4vaEFDcFhaUzc5dUlrMzhaUHI1L3VYMVNvRWlaamtWeENleEt4?=
 =?utf-8?B?QjFJRE1rM1hOS1lncytIV1RLQncvRzZwSHZuK2pmT2tRSnBNQ2h1NWptVlFz?=
 =?utf-8?B?a0x1ZDcyUHVDWGR4T0ZIR2hCNTVES3luVmk4VklIS0ZXb0ZHT0tFVExKZjh1?=
 =?utf-8?B?b1pGSVZhQkpRdGI1SE5Zb0lKektnMUpUQXJ4bFpQdEFVcGdnUUV0UytHV2t4?=
 =?utf-8?B?UkpjNXlQalVZcFkyZGt5NGN1aG5PQkVXOGVMaklxN0o1SzEyV2xhUGsrekVV?=
 =?utf-8?B?TzJQZEVpUlVJR0Jndkp3VDJtMGxPaHl1bDIraTRjaHNNWGIrejExdGo3TTBP?=
 =?utf-8?B?Z05EU25SZFpKcm54NjB5THJCVER4ZVlRdWsyUGtTYTlScUlRTXBGdEFoYVc3?=
 =?utf-8?B?Q1BwRStTdjBxVU5XUTVxeEVPUFVReC9zUU1vN3pqaTFmK2VrcGZTN2svMVBZ?=
 =?utf-8?B?ZStsSEJGV29Sa1dMamdhN2FVL1ArdXN1dW16MlpreWcvOFRUYXJmUHlGYU9h?=
 =?utf-8?B?aFJvWHBJdkQrdGplQTU1cG5oYkxKVDM3MXZHTE1RSk4zb3NtaWYyOWtFSm1v?=
 =?utf-8?B?czFKN2prcXRxOTVSNEtmQnFhMlNVK2M2alJPWFd3OVlDSStGU1NGY0ZCTFlZ?=
 =?utf-8?B?YzdWS0JOaE1IZlY1dzBrQjhTd01RZ0h4YllHV2RkYmMxZ3Bpa2l4L29namgx?=
 =?utf-8?B?K1BTRGhvaG5jM2Fpak9oWTM1YzZxOTF2R3lwL2dlejhMcm56Y3dVcXBQWmF4?=
 =?utf-8?B?Y3o4TjZ1ZzFweFB5eXJrSGJLS1RhcWtWZGJKS1NjWkl6S0I0TE1sYmJVVVpH?=
 =?utf-8?B?cjJsWkdGMllDYlBTYmNQa1lKVStQT3h2RGxTMmY2aitDbkJBQ0N5L1dRcHBi?=
 =?utf-8?B?QmVuRUdWV3VTVTA1YnY2cjl4T0h0RG5lR0U4ZVhyeFRVOHlpSnpUSzVxNFg3?=
 =?utf-8?B?eXpTb2dsUVZvUTlSSHBUcy9VbmZLcmxUTWRHQWxKWklZS0srZVZPdGZoZWti?=
 =?utf-8?B?UEJDbDhvUEsrLzdvKzZKRUVxMWg3ZTNDWWtMZ3hzWVdGUm5LUzdFK1A2UmpU?=
 =?utf-8?B?ZldLSWdScWR6RHpaeXNnUWdnVTRHbFQ4YWdvM0didzlpYkVIV0FlNndNa3ZO?=
 =?utf-8?B?dDJuQm5UK3dBWm0ray9aNHNtRXdSaGZ6U1ZuWlV1TVlEVVlVVXBqeSthamFj?=
 =?utf-8?B?UGlUcWQramR1Sm5CNDhHNlQ0TC9vNWZVUGkwd09GN2VxOCtYdGNKWVFiN0lx?=
 =?utf-8?B?NXRUMGo5Z1Y0eHZGOTRuUVYvQXRxT1RZOUcvUnd5eTFnZWFoOTE0K2FPMmlo?=
 =?utf-8?Q?spbssb9Fnu7zW2XGRDhz1J/QS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7BBC8C478A1E545B51B9D85C60022DD@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0559.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9508cdf0-ccda-4aab-d9d8-08dc39ec4f6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 12:37:08.7166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRRX8g8QtszwgRFq/GRZOAJA1ciuAYdt0eIQOf4cn68Jrtxs/tScrqKLU+bItwkYXJfvpJN8I6lz5R7cMHLqig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P193MB2468

QWRkIHN1cHBvcnQgZm9yIG5ldyBLdmFzZXIgcGNpZWZkIGRldmljZSwgUENJZSA4eENBTiwgYmFz
ZWQgb24gWGlsaW54IEZQR0EuDQoNClNpZ25lZC1vZmYtYnk6IE1hcnRpbiBKb2NpYyA8bWFydGlu
LmpvY2ljQGt2YXNlci5jb20+DQotLS0NCiBkcml2ZXJzL25ldC9jYW4vS2NvbmZpZyAgICAgICAg
IHwgMSArDQogZHJpdmVycy9uZXQvY2FuL2t2YXNlcl9wY2llZmQuYyB8IDcgKysrKysrLQ0KIDIg
ZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9jYW4vS2NvbmZpZyBiL2RyaXZlcnMvbmV0L2Nhbi9LY29uZmlnDQpp
bmRleCA2MjA3NjZlYjZiYzEuLjJlMzFkYjU1ZDkyNyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0
L2Nhbi9LY29uZmlnDQorKysgYi9kcml2ZXJzL25ldC9jYW4vS2NvbmZpZw0KQEAgLTE2OSw2ICsx
NjksNyBAQCBjb25maWcgQ0FOX0tWQVNFUl9QQ0lFRkQNCiAJICAgIEt2YXNlciBNaW5pIFBDSSBF
eHByZXNzIDF4Q0FOIHYzDQogCSAgICBLdmFzZXIgTWluaSBQQ0kgRXhwcmVzcyAyeENBTiB2Mw0K
IAkgICAgS3Zhc2VyIE0uMiBQQ0llIDR4Q0FODQorCSAgICBLdmFzZXIgUENJZSA4eENBTg0KIA0K
IGNvbmZpZyBDQU5fU0xDQU4NCiAJdHJpc3RhdGUgIlNlcmlhbCAvIFVTQiBzZXJpYWwgQ0FOIEFk
YXB0b3JzIChzbGNhbikiDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvY2FuL2t2YXNlcl9wY2ll
ZmQuYyBiL2RyaXZlcnMvbmV0L2Nhbi9rdmFzZXJfcGNpZWZkLmMNCmluZGV4IDQxNmYxMDQ4MGI0
MC4uZjgxYjU5ODE0N2IzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvY2FuL2t2YXNlcl9wY2ll
ZmQuYw0KKysrIGIvZHJpdmVycy9uZXQvY2FuL2t2YXNlcl9wY2llZmQuYw0KQEAgLTI3LDcgKzI3
LDcgQEAgTU9EVUxFX0RFU0NSSVBUSU9OKCJDQU4gZHJpdmVyIGZvciBLdmFzZXIgQ0FOL1BDSWUg
ZGV2aWNlcyIpOw0KICNkZWZpbmUgS1ZBU0VSX1BDSUVGRF9CRUNfUE9MTF9GUkVRIChqaWZmaWVz
ICsgbXNlY3NfdG9famlmZmllcygyMDApKQ0KICNkZWZpbmUgS1ZBU0VSX1BDSUVGRF9NQVhfRVJS
X1JFUCAyNTZVDQogI2RlZmluZSBLVkFTRVJfUENJRUZEX0NBTl9UWF9NQVhfQ09VTlQgMTdVDQot
I2RlZmluZSBLVkFTRVJfUENJRUZEX01BWF9DQU5fQ0hBTk5FTFMgNFVMDQorI2RlZmluZSBLVkFT
RVJfUENJRUZEX01BWF9DQU5fQ0hBTk5FTFMgOFVMDQogI2RlZmluZSBLVkFTRVJfUENJRUZEX0RN
QV9DT1VOVCAyVQ0KIA0KICNkZWZpbmUgS1ZBU0VSX1BDSUVGRF9ETUFfU0laRSAoNFUgKiAxMDI0
VSkNCkBAIC00OSw2ICs0OSw3IEBAIE1PRFVMRV9ERVNDUklQVElPTigiQ0FOIGRyaXZlciBmb3Ig
S3Zhc2VyIENBTi9QQ0llIGRldmljZXMiKTsNCiANCiAvKiBYaWxpbnggYmFzZWQgZGV2aWNlcyAq
Lw0KICNkZWZpbmUgS1ZBU0VSX1BDSUVGRF9NMl80Q0FOX0RFVklDRV9JRCAweDAwMTcNCisjZGVm
aW5lIEtWQVNFUl9QQ0lFRkRfOENBTl9ERVZJQ0VfSUQgMHgwMDE5DQogDQogLyogQWx0ZXJhIFNl
ckRlcyBFbmFibGUgNjQtYml0IERNQSBhZGRyZXNzIHRyYW5zbGF0aW9uICovDQogI2RlZmluZSBL
VkFTRVJfUENJRUZEX0FMVEVSQV9ETUFfNjRCSVQgQklUKDApDQpAQCAtNDk2LDYgKzQ5NywxMCBA
QCBzdGF0aWMgc3RydWN0IHBjaV9kZXZpY2VfaWQga3Zhc2VyX3BjaWVmZF9pZF90YWJsZVtdID0g
ew0KIAkJUENJX0RFVklDRShLVkFTRVJfUENJRUZEX1ZFTkRPUiwgS1ZBU0VSX1BDSUVGRF9NMl80
Q0FOX0RFVklDRV9JRCksDQogCQkuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpJmt2YXNl
cl9wY2llZmRfeGlsaW54X2RyaXZlcl9kYXRhLA0KIAl9LA0KKwl7DQorCQlQQ0lfREVWSUNFKEtW
QVNFUl9QQ0lFRkRfVkVORE9SLCBLVkFTRVJfUENJRUZEXzhDQU5fREVWSUNFX0lEKSwNCisJCS5k
cml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkma3Zhc2VyX3BjaWVmZF94aWxpbnhfZHJpdmVy
X2RhdGEsDQorCX0sDQogCXsNCiAJCTAsDQogCX0sDQotLSANCjIuNDAuMQ0KDQo=

