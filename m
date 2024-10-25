Return-Path: <linux-can+bounces-1760-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2B29AF7A2
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2024 04:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F122814E7
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2024 02:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96013FBA5;
	Fri, 25 Oct 2024 02:49:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2094.outbound.protection.partner.outlook.cn [139.219.17.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8AA54727;
	Fri, 25 Oct 2024 02:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729824556; cv=fail; b=hA2STOOvcV6xRdl5Z3ErkSWo3e++LkBnibrsGPbjoX5RdLdtrypbulPNQHfvXnSZu/skaETp+lK/3IQjKrM7rjACtGG1GGjuU8TnBJMkHxBpP20ocAZMqvtCkQ6gPrUMwXh41FYaWi/Pd6RYdpbQoq93a8mDeBnQmN012wwkiMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729824556; c=relaxed/simple;
	bh=osQPJozO32lCIbWxjj6TRKMUy1jghkzN0XwLXCJkOTQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ef9CgnysNlpKKZvaIaTVyR5t/k6/dkbWOY9+M5VTcf+RRR2q6am5Ojj1M7FchZEP7p+OgtY3Ea0WrEbFR61BnS0f5LObrwqGlKWWvcdJNgoSrU+U3YxiY0K9qumwrAn8OXmL+D2m0alpLJwMzDe1W2wHL6bAXOnBi3dd0WG3DrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djPSxtmlsRp/RAFA5n+NtxVSuiFddBQaTK3/Z1jC4QwwGwirqw79HyYS5xLgesANzetpGxjQI7z6gwAcT7BADw6egAMzhnFn6HjfL8ZBCXTXENuEb2kEaeQPqTxMoT6DMTBJ9I3sYC55pWk98UnvkpsZY2bWGSkAoI7V6wbG9ne/kj4UB9gJYix1HVAvFqRhXwREYUbDFacThtWhUsrpPFIi98uMAlPHnkkdEEP3sRreJrEQ8abg1jdU1wQeHE6AYMZEt6wdRkYD14Qsw4dMjvZRj9dcIEiucZZLyNVvU1o1BawjqcuIObJ2+iYBIY+5lFcYlAkwO1aF1NuQUMfUgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osQPJozO32lCIbWxjj6TRKMUy1jghkzN0XwLXCJkOTQ=;
 b=lsiESdwKQIYuMhJqQ4r4U1RIuW0hV2Z/eXRdVE3cbwXDDo5PkViP7YjWcSXLVu7DKIEts45AG3JHkmINcjjbCbTWgRS7cvJ2FIjcvo02JVs54Nb8d/bp9qOF885A3yeFP+mJdk1bxcRAJk4UmnE1ljsbATYFYM6OW9WuLQ5i4depxVoZmjXj5JTsG99clAVp8H9nrwfJjONODCiB0TEv/A38oB2y2qIyhOPNLT1rakVVUA99DSTWI/rcUR7FI0mfuO957HsG87wBtT7QJEryVIIGUQqCzeZAoQljuS5sTD85how8Ze07CqDa0lPZDMFF7x3AcW6DF+ShgEmyCiD9uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1273.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:10::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.32; Fri, 25 Oct
 2024 02:49:11 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8069.031; Fri, 25 Oct 2024
 02:49:11 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, Hal Feng
	<hal.feng@linux.starfivetech.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Emil
 Renner Berthing <emil.renner.berthing@canonical.com>, William Qiu
	<william.qiu@starfivetech.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] can: Add driver for CAST CAN Bus Controller
Thread-Index: AQHbDP78QyTswaw7pki8MOjaOJeAtrKHr+qUgAHiDdmADWK8kA==
Date: Fri, 25 Oct 2024 02:49:10 +0000
Message-ID:
 <ZQ2PR01MB130747EE09D3CF9B2290B08FE64F2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1273:EE_
x-ms-office365-filtering-correlation-id: 8ba113ad-7489-4ec7-fc5a-08dcf49f9a8a
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|41320700013|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 2hG00ziR9Iwr8yaD/Hl5a9dE7AG8JHwHVGAOAgM6WHlC2pJfWS7Os0CSxaS9Q1b14dBqT/FeAyleJFSsnk6i92mFbydnk8VXEu7QaVqC7FNLB06S0rJsdET5+ZrX1+535wdvSctGpwBEoluKNH2S/ACRrOvNUpQSJoj9TDOkMIerd0gkjH3mkGebXy9ZZYTh0V4pRW4X39j+iMHKXTuXZjtsVvR3wBtINyNdI+xQ1XOvRpKq7uDt3zGZmYptieriwgmpmXZsho65BQ1zExlMhL1L1AVPo4V85NYgCs6J6SrTSp0r7+B05vqH0I48IpAw7hSDSktJFsumAB7txqlF3gY+rEWZvMcDI4dn+RIgQkI6eWrtYNaIME6MLKjM3DvmIRS4fJ6ep/7DgU1UmG18uey9ZVfL0FSmAEbwjlcBdi1Ketz+yoxstNld741Yr+S+I0ZCW+8Yc2A41Dwswxp5N92NRCv5lUoPHQN8vZwCmCRItgLSekEZvEJmB/4OcjtcM18LG853PvsCLWz8ZPo4qb4Wtg0hZmovxp0rTJD876FTmuBipHmdic6dCJn+DCj666PVwCIRYoUqqzPxnTTWCJeNABI6iXgJunhLDlTwbnD62HCynD4MDVycNwXe9BF7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTlLak9BdzJiSE9qekhjcmVVR0kyVWQyeUk0NjFiWGhLakN4Ry9LV0JuMk5H?=
 =?utf-8?B?Vi9ZMnpTMFcrZnQ4OTdwV2tBTm9NeTFiYW5uZ2ZLSDRTWXczZjVWQVBHTXU5?=
 =?utf-8?B?WG0yYXhYQ1lBM3dSWS9ma0U1MlVoT1hCZnVFU1J6Y3o4cnN0YktOdWNQRlVq?=
 =?utf-8?B?STBjd2oyaDF0b1pXSlNheUl0K2dPNEJrMWNGeW40dlJCOVZ2b0FScUNYMzFx?=
 =?utf-8?B?bW5GbjNsZVZIdGw4RFBIOWhRUVB2aGVZNUpqVjNTb3Y2TzIyRVIxUjVHbUIv?=
 =?utf-8?B?TkNSVHVmYWQvc2h0Tzhad0tZanZIK2FFS29hOHRGVFA1dEJzNkNGL0tUUUVj?=
 =?utf-8?B?dG1rbHpVQXY0SzBoUDdXdUpKOWpmazFBSFBHNWtzYUxtU1V2S3dqdVJRNWt6?=
 =?utf-8?B?b3h6akZBOHpEQ1lOcVhNeFErc2w3blQxK0lHNUg4TEowUUJYaHVaWGF6UGZz?=
 =?utf-8?B?N1VMY1p2cisvYmIyWDBTcnZ0RTZpLzFpazdzMGtyRC9MaDlnUWppQXF3Q0Nl?=
 =?utf-8?B?V0tQUDBkV0ltWVU1cWJHVFoyNUV0a1hRVENsUTZqL2U4SDZmYUtYSWEzNXdK?=
 =?utf-8?B?cGlBbzQ1cFAwaHVvYlNNa0FvSmhjZytEdldCQi9WYWxCZVdMUkNnaDRXQVhy?=
 =?utf-8?B?SmI4OFdkbUVpbkZneE0vVUcyY0tKNTUzUmtXbk5OdlFBUUZxU3RweVdYYUgx?=
 =?utf-8?B?c1dHZ1lHd3lxNGgzK3d1NDVZeHAyNTJYVXlkMTA5dW9xamJjVVJCWjhVMWVQ?=
 =?utf-8?B?OGJ3dnFrWlRqVHBtN0ZtcUpYd1dVNll3WmxnODlYTENFSTVwSjVTQUw0VGV3?=
 =?utf-8?B?TEpxL3pBZi8vRlU3UmtGQ1pXUWJpTm9MekJ5VDQrcHcxd3YzRHdETTZKcURT?=
 =?utf-8?B?ZXIvR0ZiZlFsUUdhS2tSbGwwdG53Mll4Yk9Yamp0b21LMGdtQk1RY3BpTDMw?=
 =?utf-8?B?RnZ5R3pSeWZJNEhtTDFvM09RdzRyTmc4S0oyc29lM09hZW9hOXdiQlFMNWRN?=
 =?utf-8?B?bGdJSXJleVFuanZRZFpRSVcyR212SWpFWVYyYVc3T0ZMZmdsS0ExUWVQNFV3?=
 =?utf-8?B?Z3gyMFhveUhLTFRiaHJ5YWl5S3AzamU1dW1BQUZvL3NsLytGZHRBSUhtL0w2?=
 =?utf-8?B?VlZEamJ4S2lJUVl1WVp2KzlpSTVIa0VUNlhRU003cG5kYWJWYk1tTVRlRkVh?=
 =?utf-8?B?QUhaM0pqNE1RMzBISlZ6elFGVy9vaW4xdmFmTDRsTnRqdUdIN0ZiYktZeXNW?=
 =?utf-8?B?TlhOOEZSRElKTE9yajBSVHZSc2F6T3h6N2g3RGNYd3V3RmR0YW1xQ3cvNndD?=
 =?utf-8?B?TEE4SUoyeWZhdHVhM1JZWlZoTEpRNit6QXVtK1lpdGxaTVRFQzF0QlBtZXJ1?=
 =?utf-8?B?d1FROEUxVHNYcHFEQUVsK3VFL3gvZ25TMWhPajNRQnI3ZGF3UTlJUTFyTms0?=
 =?utf-8?B?NTVQZFR1SHdKMkZlYXQzejV4YkNFUHVqN01zTUJFNHU3SEJWOHIrMDUrN2M1?=
 =?utf-8?B?RkVid2lHajVMNDdVREcrTm0zNVQ4NUMwZDNUUjB3Vk1RT2tYMTMrdzREaXlv?=
 =?utf-8?B?QkdmMzlqRWRsMUhDVU5PMWVGeE5tRy80Tk1vanJUYXpkV201RWJtNDdXVXZ1?=
 =?utf-8?B?c2NJTy9DU3BRREZCTFkwVkpzNnVKTE1xNlFzMDhZSXBKaXR6TU9rNHdOUlVS?=
 =?utf-8?B?eDJwSUs4amxMRWlvMkN2UnAvdVlIdU41amZtcUNyeUVrWlhMR0tYQUltUXVh?=
 =?utf-8?B?SC8xNE54K25wVWUvSjN6bjFqR1JMM0kvUEMvNmJEeVZiWEt6M0R1SWk4Z0to?=
 =?utf-8?B?dzRLbEtrU1IxWE1qWkhWNzFBY3NmZGlKbEthRkxhTG1UUkszT2lJdmNBNmI4?=
 =?utf-8?B?NnF5Ti9yTy8xMzFIQ1BNWWg5dCtRT3BoTkM3WnA2RXVCbnZRb0ZwYXY4WmNC?=
 =?utf-8?B?UkxaWXRJT2Q4L2RIWmtXSjIwMmtLYUgyZzNWVmoyeENuTjNQdVMvaWpkcGNE?=
 =?utf-8?B?QTlzSzZtcjFBdXJ1d3lLZjNOd2FxbkJjbHJ2RlhTam51U2lhYkNwMnp0Wkll?=
 =?utf-8?B?Z3I0T1ZiOUc4Q2lPc3VRNUQydkhTODdDVE80ZDB2MWYvZDl3NUhWNTFOQitQ?=
 =?utf-8?Q?EQ9FIHaVAblsWGznocvTYW0Ml?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba113ad-7489-4ec7-fc5a-08dcf49f9a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 02:49:10.9264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yr5SW64YL6nX7njidP6apN2z4wr+OH299/kRdiaFhUtylIRi0FlOVu/E8eqtEF5rg+5A8XiqaTbcZjelnux6xMxbHPYaU8RrBnyXYRNFdjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1273

PiBPbiAxNi4xMC4yNCAyMjoxNiwgVmluY2VudCBNQUlMSE9MIHdyb3RlOg0KPiBPbiBXZWQuIDE2
IE9jdC4gMjAyNCBhdCAxNDowNSwgVmluY2VudCBNQUlMSE9MDQo+IDxtYWlsaG9sLnZpbmNlbnRA
d2FuYWRvby5mcj4gd3JvdGU6DQo+ID4gT24gVHVlLiAxNSBPY3QuIDIwMjQgYXQgMTg6MzMsIEhh
bCBGZW5nIDxoYWwuZmVuZ0BsaW51eC5zdGFyZml2ZXRlY2guY29tPg0KPiB3cm90ZToNCj4gPiA+
IE9uIDkvMjMvMjAyNCAxMTo0MSBBTSwgVmluY2VudCBNQUlMSE9MIHdyb3RlOg0KPiA+ID4gPiBI
aSBIYWwsDQo+ID4gPiA+DQo+ID4gPiA+IEEgZmV3IG1vcmUgY29tbWVudHMgb24gdG9wIG9mIHdo
YXQgQW5kcmV3IGFscmVhZHkgd3JvdGUuDQo+ID4gPiA+DQo+ID4gPiA+IE9uIE1vbi4gMjMgU2Vw
LiAyMDI0IGF0IDAwOjA5LCBIYWwgRmVuZyA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4g
d3JvdGU6DQo+ID4gPiA+PiBGcm9tOiBXaWxsaWFtIFFpdSA8d2lsbGlhbS5xaXVAc3RhcmZpdmV0
ZWNoLmNvbT4NCj4gPiA+ID4+DQo+ID4gPiA+PiBBZGQgZHJpdmVyIGZvciBDQVNUIENBTiBCdXMg
Q29udHJvbGxlciB1c2VkIG9uIFN0YXJGaXZlIEpINzExMA0KPiA+ID4gPj4gU29DLg0KPiA+ID4g
Pj4NCj4gPiA+ID4+IFNpZ25lZC1vZmYtYnk6IFdpbGxpYW0gUWl1IDx3aWxsaWFtLnFpdUBzdGFy
Zml2ZXRlY2guY29tPg0KPiA+ID4gPj4gQ28tZGV2ZWxvcGVkLWJ5OiBIYWwgRmVuZyA8aGFsLmZl
bmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiA+ID4+IFNpZ25lZC1vZmYtYnk6IEhhbCBGZW5nIDxo
YWwuZmVuZ0BzdGFyZml2ZXRlY2guY29tPg0KPiA+ID4gPj4gLS0tDQo+IA0KPiAoLi4uKQ0KPiAN
Cj4gPiA+ID4+ICsNCj4gPiA+ID4+ICsgICAgICAgaWYgKHByaXYtPmNhbnR5cGUgPT0gQ0FTVF9D
QU5fVFlQRV9DQU5GRCkgew0KPiA+ID4gPj4gKyAgICAgICAgICAgICAgIHByaXYtPmNhbi5jdHJs
bW9kZV9zdXBwb3J0ZWQgPQ0KPiBDQU5fQ1RSTE1PREVfTE9PUEJBQ0sgfCBDQU5fQ1RSTE1PREVf
RkQ7DQo+ID4gPiA+PiArICAgICAgICAgICAgICAgcHJpdi0+Y2FuLmRhdGFfYml0dGltaW5nX2Nv
bnN0ID0NCj4gJmNjYW5fZGF0YV9iaXR0aW1pbmdfY29uc3RfY2FuZmQ7DQo+ID4gPiA+PiArICAg
ICAgIH0gZWxzZSB7DQo+ID4gPiA+PiArICAgICAgICAgICAgICAgcHJpdi0+Y2FuLmN0cmxtb2Rl
X3N1cHBvcnRlZCA9DQo+IENBTl9DVFJMTU9ERV9MT09QQkFDSzsNCj4gPiA+ID4+ICsgICAgICAg
fQ0KPiA+ID4gPg0KPiA+ID4gPiBOaXRwaWNrLCBjb25zaWRlciBkb2luZyB0aGlzOg0KPiA+ID4g
Pg0KPiA+ID4gPiAgIHByaXYtPmNhbi5jdHJsbW9kZV9zdXBwb3J0ZWQgPSBDQU5fQ1RSTE1PREVf
TE9PUEJBQ0s7DQo+ID4gPiA+ICAgaWYgKHByaXYtPmNhbnR5cGUgPT0gQ0FTVF9DQU5fVFlQRV9D
QU5GRCkgew0KPiA+ID4gPiAgICAgICAgICAgcHJpdi0+Y2FuLmN0cmxtb2RlX3N1cHBvcnRlZCB8
PSBDQU5fQ1RSTE1PREVfRkQ7DQo+ID4gPiA+ICAgICAgICAgICBwcml2LT5jYW4uZGF0YV9iaXR0
aW1pbmdfY29uc3QgPQ0KPiAmY2Nhbl9kYXRhX2JpdHRpbWluZ19jb25zdF9jYW5mZDsNCj4gPiA+
ID4gICB9DQo+ID4gPg0KPiA+ID4gT0suDQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBBbHNvLCBk
b2VzIHlvdSBoYXJkd2FyZSBzdXBwb3J0IGRsYyBncmVhdGVyIHRoYW4gOCAoYy5mLg0KPiA+ID4g
PiBDQU5fQ1RSTE1PREVfQ0NfTEVOOF9ETEMpPw0KPiA+ID4NCj4gPiA+IFRoZSBjbGFzcyBDQU4g
KENDKSBtb2RlIGRvZXMgbm90IHN1cHBvcnQsIGJ1dCB0aGUgQ0FOIEZEIG1vZGUNCj4gc3VwcG9y
dHMuDQo+ID4NCj4gPiBTbywgQ0FOX0NUUkxNT0RFX0NDX0xFTjhfRExDIGlzIGEgQ2xhc3NpY2Fs
IENBTiBmZWF0dXJlLiBTdHJpY3RseQ0KPiA+IHNwZWFraW5nLCB0aGlzIGRvZXMgbm90IGV4aXN0
IGluIENBTiBGRC4gRG8geW91IG1lYW4gdGhhdCBvbmx5IHRoZQ0KPiA+IENBU1RfQ0FOX1RZUEVf
Q0FORkQgc3VwcG9ydHMgc2VuZGluZyBDbGFzc2ljYWwgQ0FOIGZyYW1lcyB3aXRoIGEgRExDDQo+
ID4gZ3JlYXRlciB0aGFuIDg/DQo+ID4NCj4gPiBJZiBub25lIG9mIHRoZSBDbGFzc2ljYWwgQ0FO
IG9yIENBTiBGRCB2YXJpYW50cyBvZiB5b3VyIGRldmljZSBpcyBhYmxlDQo+ID4gdG8gc2VuZCBD
bGFzc2ljYWwgQ0FOIGZyYW1lcyB3aXRoIGEgRExDIGdyZWF0ZXIgdGhhbiA4LCB0aGVuIHRoaXMg
aXMNCj4gPiBqdXN0IG5vdCBzdXBwb3J0ZWQgYnkgeW91ciBkZXZpY2UuDQo+ID4NCj4gPiBDb3Vs
ZCB5b3Ugc2hhcmUgdGhlIGRhdGFzaGVldCBzbyB0aGF0IEkgY2FuIGRvdWJsZSBjaGVjayB0aGlz
Pw0KPiANCj4gSSByZWNlaXZlZCB0aGUgZGF0YXNoZWV0IGZyb20gYSBnb29kIHNhbWFyaXRhbi4g
V2l0aCB0aGlzLCBJIHdhcyBhYmxlIHRvDQo+IGNvbmZpcm0gYSBmZXcgdGhpbmdzLg0KPiANCj4g
MS8gWW91ciBkZXZpY2UgY2FuIHN1cHBvcnQgQ0FOX0NUUkxNT0RFX0NDX0xFTjhfRExDOg0KPiAN
Cj4gVGhpcyBpcyBzaG93biBpbiB0aGUgZGF0YXNoZWV0IGF0Og0KPiANCj4gICBUYWJsZSAzLTUy
IERlZmluaXRpb24gb2YgdGhlIERMQyAoYWNjb3JkaW5nIHRvIHRoZSBDQU4gMi4wIC8gRkQgc3Bl
Y2lmaWNhdGlvbikNCj4gDQo+IERMQyB2YWx1ZXMgOSB0byAxNSAoYmluYXJ5IDEwMDEgdG8gMTEx
MSkgYXJlIGFjY2VwdGVkIGJ5IHRoZSBkZXZpY2UuDQo+IFdoZW4gc2VuZGluZyBhbmQgcmVjZWl2
aW5nIHN1Y2ggZnJhbWVzLCBjYW5fZnJhbWUtPmxlbiBpcyBzZXQgdG8gOCBhbmQNCj4gY2FuX2Zy
YW1lLT5sZW44X2RsYyBpcyBzZXQgdG8gdGhlIGFjdHVhbCBETEMgdmFsdWUuIFVzZSB0aGUNCj4g
Y2FuX2NjX2RsYzJsZW4oKSBhbmQgY2FuX2dldF9jY19kbGMoKSBoZWxwZXJzIGZvciB0aGlzLg0K
PiANCj4gDQo+IDIvIFlvdXIgZGV2aWNlIGNhbiBzdXBwb3J0IENBTl9DVFJMTU9ERV9URENfQVVU
TzoNCj4gDQo+IFRoaXMgaXMgZG9jdW1lbnRlZCBpbiB0aGUgZGF0YXNoZWV0IGF0Og0KPiANCj4g
ICA4LjggVERDIGFuZCBSREMNCj4gDQo+IFRoaXMgd2lsbCBhbGxvdyB0aGUgdXNlIG9mIGhpZ2hl
ciBiaXRyYXRlcyAoZS5nLiA0IE1iaXRzL3MpIGluIENBTi1GRC4NCj4gWW91IGNhbiByZWZlciB0
byB0aGlzIGNvbW1pdCBmb3IgYW4gZXhhbXBsZSBvZiBob3cgdG8gaW1wbGVtZW50IGl0Og0KPiAN
Cj4gICBodHRwczovL2dpdC5rZXJuZWwub3JnL3RvcnZhbGRzL2MvMTAxMGE4ZmE5NjA4DQo+IA0K
PiANCj4gMy8gWW91ciBkZXZpY2UgY2FuIHN1cHBvcnQgQ0FOX0NUUkxNT0RFXzNfU0FNUExFUzoN
Cj4gDQo+IFRoaXMgaXMgY2FsbGVkIHRyaXBsZSBtb2RlIHJlZHVuZGFuY3kgKFRNUikgaW4geW91
ciBkYXRhc2hlZXQuDQo+IA0KPiANCj4gNC8gWW91ciBkZXZpY2UgY2FuIHN1cHBvcnQgQ0FOX0NU
UkxNT0RFX0xJU1RFTk9OTFk6DQo+IA0KPiBUaGlzIGlzIGRvY3VtZW50ZWQgaW4gdGhlIGRhdGFz
aGVldCBhdDoNCj4gDQo+ICAgMy45LjEwLjIuIExpc3RlbiBPbmx5IE1vZGUgKExPTSkNCj4gDQo+
IA0KPiA1LyBZb3VyIGRldmljZSBjYW4gc3VwcG9ydCBDQU5fQ1RSTE1PREVfT05FX1NIT1Q6DQo+
IA0KPiBUaGlzIGlzIGRvY3VtZW50ZWQgaW4gdGhlIGRhdGFzaGVldCBhdDoNCj4gDQo+ICAgNi41
LjMgU2luZ2xlIFNob3QgVHJhbnNtaXQgVHJpZ2dlcg0KPiANCj4gDQo+IDYvIFlvdXIgZGV2aWNl
IGNhbiBzdXBwb3J0IENBTl9DVFJMTU9ERV9CRVJSX1JFUE9SVElORzoNCj4gDQo+IFRoaXMgaXMg
c2hvd24gaW4gdGhlIGRhdGFzaGVldCBhdDoNCj4gDQo+ICAgVGFibGUgMy0yNCBFcnJvciBDb3Vu
dGVyIFJlZ2lzdGVycyBSRUNOVCAoMHhiMikgYW5kIFRFQ05UICgweGIzKQ0KPiANCj4gDQo+IDcv
IFlvdXIgZGV2aWNlIGNhbiBzdXBwb3J0IENBTl9DVFJMTU9ERV9QUkVTVU1FX0FDSzoNCj4gDQo+
IGMuZi4gdGhlIFNBQ0sgKHNlbGYgYWNrbm93bGVkZ2UpIHJlZ2lzdGVyDQo+IA0KPiANCj4gU28g
eW91ciBkZXZpY2UgY29tZXMgd2l0aCBNQU5ZIGZlYXR1cmVzLiBJIHdvdWxkIGxpa2UgdG8gc2Vl
IHRob3NlDQo+IGltcGxlbWVudGVkIGluIHlvdXIgZHJpdmVyLiBNb3N0IG9mIHRoZSB0aW1lLCBh
ZGRpbmcgYSBmZWF0dXJlIGp1c3QgbWVhbnMNCj4gd3JpdGluZyBvbmUgdmFsdWUgdG8gYSByZWdp
c3Rlci4NCj4gDQo+IFBsZWFzZSBsZXQgbWUga25vdyBpZiBhbnkgb2YgdGhpcyBpcyB1bmNsZWFy
Lg0KDQpJIHdpbGwgY29uZmlybSB0aGUgYWJvdmUgZmVhdHVyZXMgd2l0aCBteSBjb2xsZWFndWVz
LiBJZiB0aGVzZSBmZWF0dXJlcyBjYW4NCnJlYWxseSBiZSBzdXBwb3J0ZWQsIGxldCdzIGltcGxl
bWVudCB0aGVtLiBUaGFua3MuDQoNCkJlc3QgcmVnYXJkcywNCkhhbA0K

