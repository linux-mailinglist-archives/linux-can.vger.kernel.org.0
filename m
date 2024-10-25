Return-Path: <linux-can+bounces-1759-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4816D9AF751
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2024 04:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E53BBB21BB7
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2024 02:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6643C6BA;
	Fri, 25 Oct 2024 02:18:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2131.outbound.protection.partner.outlook.cn [139.219.17.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59C13FC2;
	Fri, 25 Oct 2024 02:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729822715; cv=fail; b=VAyHdXzKz+oP6RFXzetLMICvtTYMQUpLnNEPpkRD0j9hiAGCCQ3Ow6EN9C2triwtPrO894XiGfIYlPJeJ8CITdn3yWIj/fGQzzhES/wsdlKL8tYoYoqKKX+9g2E3TH07Hpczxk0wpG80vp5iIj4wBtmdHIBj3OdbB8zj+aDGHms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729822715; c=relaxed/simple;
	bh=sHTi5w7ptCjM+3SSXZN5ci9YrfILlnSH8rHDqUt1C+U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mriuiND226wg5ZTiCdKWz2yE8iGqk7koCHQ4K/Ca/tqOYA+sNS30mQiSup3EN45gZmOugv5LF3bgOWUc6ol9M9mWMO/8ISe4ClKjgFmOwfEytxGMLw3Idc26FuTW9upc5hIx5V8XN6v+LOQyevOM3Ox9W+DtUffLM2et6QoKjAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxU0+x8Lf5NXU3P+xeG0cXTEDtLl8K0hALxpE42c0iGSGlg7gO+wZa6WCbD2I+ncvDPngUizRmy7kBNTESVnzBUhSB87H4rsGdmjuFE1EoiUodFzv4GxvkeVDP9ICD6Qpm71v71lzvgdE1m7XN9svhRY7/QAiVMwgnlDZvsPyn2kaG6BMbSHdX7y68NDYg7Bj2fje9/W2oQFPJsflkdfrY/r6J6A8VltMGRRB6Am8/RFPAq/PRZi1RPxh4q2xUejuppR3X6SFyt32N5PaDBdx2p3PPSKRrxqIFGddLkTC+5XKv82IkQUM6GLophZAb4ry/MsiKbdWLZzvbxUoiqddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHTi5w7ptCjM+3SSXZN5ci9YrfILlnSH8rHDqUt1C+U=;
 b=Dqr4wvwDp1YDlJPBgXmKd3W4eftLeyJgfaEXLCIUGvimnQ4GgzMulnlhQ67z7SlA/VsEPGAaX68GPttrUZusupRlcDgW1WWuPX4KLma4/2S5tIxR+iwskkgiNPxSOFdvih02Lzcf/N+MEMeOYEkudB0jKJLtSyedPNC9tDQWomWBG/v8BjT3ACWRz+xvRuBMAJbWFnoexyIe0tvA/3IpJltBtBsKs4mhlgh/TnvgVYLPVzaVT2W687Db9xX9NGtnyKmdGIrD2dh9WKugW8R4Dliiam61Zn5dA6aXpu7izW/9g0uwEm47tp1I8VxzDuqZLAWOm3YZe5LH0klJ5bzD2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1226.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.32; Fri, 25 Oct
 2024 01:45:30 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8069.031; Fri, 25 Oct 2024
 01:45:30 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, Palmer Dabbelt
	<palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, William Qiu
	<william.qiu@starfivetech.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] can: Add driver for CAST CAN Bus Controller
Thread-Index: AQHbDP78QyTswaw7pki8MOjaOJeAtrJkTp4AgCRvd8A=
Date: Fri, 25 Oct 2024 01:45:30 +0000
Message-ID:
 <ZQ2PR01MB1307D96BB8AC0B6BB78C97C9E64F2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1226:EE_
x-ms-office365-filtering-correlation-id: 6a65dc46-24da-45b1-e273-08dcf496b55d
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 rbot1znoCX4lvo14Y705IxrheROiys5AxFF/LHPGoamt0YT1bi+wbIm6XTZ3ZqHIh+zFBzS+P5Ds5ul8qZOt75KN42bz4BEg/iAxgt2+R02NZvTiLUVb154T4sfiDAJCiDAGdhGwFlnUG0lX75iJmUZ7TQFIwT19+Lom0rg3o5andpyXyK3wuXjhaaPhfMTnG0m8jI8qhJZf0TU8a5SAacwm+p01muRjnmOQVrmAbJQ/J+Ok+GxKtg71FU8AcSH+s+rddisyeyTVFF/p6DIvfWmj7NTiZP/8dkeNo7i2yy1rc8x7Ifulvq0+okjo3vKjJI9ZumROs0ITxj2qfczzurAZPHzQiAHlyHFxV1xfUy3m4sTQPWAgz4YOhrWj+xQZlZORmJvBVdm5Su2R/Y5Hq2plPkUUQDk3ivzBp2j0jBtgZHRHoQ5zkE+RFDmWqBXzAdqkFcwohery220hAtP2pnFbWA5wGuq85EGBYGicqxjUcYsxZH5lGU9yr+ukNEPMKVzP5Hlq3ESkEjLGNcjWehaut9mIXVNt2mrfQgPMlgNlhdp6rAVAejEvNgjH9Ctl0bz5/Lj50mkOUusFUCEs/V+b4yHWFlvzmcYyWXfgXb6VtgsMmbM1vzU6RbjdNBkI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mmt0bDNLUHQzUFFTdTdHT2gxalgrd3pUTm5vOHE4T2ZDODR6bVFOa3k3YmJW?=
 =?utf-8?B?c1dsbzIrYk9uKzJXakEwdDB2KzkzeXRaWEM5M1BldS9oUlpnbUlDZU16M0M0?=
 =?utf-8?B?OENRQUJacXp5UTBTZmJJVEVSeWhuUm5TbStodWY1c291WDU3ZXRUS0tIN0ZT?=
 =?utf-8?B?TlVvb1VZUEJGbEhtTFA1ZTBUejV4SUtVRmREOWw3aWtWbUpxOTVVc3o3YlVY?=
 =?utf-8?B?c1VFdkgwbFd5MEY1Mnh3NVI3RGdGVjRDcmhDWHc2ZWhNMTVOSTlGaGR6R2Vm?=
 =?utf-8?B?bTl4SVM3YWtjbDZhUm1hL09uYkVKQ1NoNU9PVHZaajBrTmJsTnhQRHdzNFJu?=
 =?utf-8?B?M3ZvVXBGM1NPUGFKeTJDSGE5c1hhYTlRckIzSU1LTW13T2ZyYWRSQnhmQ3lD?=
 =?utf-8?B?Yk92VHo1RE5nS1RLcVNxd2E3UjEzNTFGTG5Hak4vMjFMMEdrRE1pTXN6bFBx?=
 =?utf-8?B?VUJ0cFhjQm1valpna3JsbXIvMVNRTkE0NTBKQjl4S3pXZmRkd2xPRHM4TlB0?=
 =?utf-8?B?eXZCVG1oVTlRODk2Snl1bUJIZlpUZmdOb1ZsVW1oNmlaNkkzYUFGVFZveGRq?=
 =?utf-8?B?NzRYVnkxNzRYUjh0R3hGNmowVUo5YXVkM3lLMVJVc0NTUlBrTGltek91YVZ3?=
 =?utf-8?B?aGxYa1JXUmwxa2xLK2VPSjRaaDJPSWd4REFoaFV2dW9zZVorNDBUd2FES2RK?=
 =?utf-8?B?dHVSUW9DUks2MkR4SU5YUm5QWkIyY3NmMkwxZC9DeEVFN0lhMEJsdmg1YTZU?=
 =?utf-8?B?bThFNTZ3ZUxudmZlMGxKeUo4c3BZUEdrZXBmbHJYeVp2Tm5zYjRsTFlmRXVj?=
 =?utf-8?B?czcrRkZGem54REpxdkgzaHVPbmkrcU5WQm9HOUpVVGNuYzNLNGpoYTNrMVVr?=
 =?utf-8?B?bFhwV014SFJNTlpUWEtWZGZvL1ZwM0lSK292YW05R0lNc2ZhWUk3T2ZhbHFI?=
 =?utf-8?B?dnRWVUdaZXZwUlI3NTZjUVVlbVBJbDhOMFFSSkZ2OUowRnJqL0VTMjEveGcy?=
 =?utf-8?B?NG1DUVBBMG1WandTQm9tMFBLekZkclhpYlRObDlxZCtZeFcweFdZeFRmb1VL?=
 =?utf-8?B?ODY4Nkc3RWVGMys3ZW9SemtVZVdod1hVVnhpRXpUNmRNRUs2bU14bVRUeit2?=
 =?utf-8?B?YzUwK0dFR3lqeUlEc2owaE5zRnd5QzE0UUZ2QXNNQnlNY1NZS3pMbkU3Q05n?=
 =?utf-8?B?MjB1VHdOZGFNaHZmOTN4ZUVhZUNuT0ZCMUo3bU1heWlrNXcvbGVPM3VsOTd4?=
 =?utf-8?B?YjJoSWJkeW41c0hVM3Bid01JNTBkSis2Snp4aExwblNJNi9zNHFDd1ZPRkhD?=
 =?utf-8?B?anRtVDFJRWZLT2RNNEJnY1J5TUE0ZmlqNzRUU3czUytSZWNVZWpmREg3aE5O?=
 =?utf-8?B?eE4zejFuSkFINU4yTUxUSlpOVDNYQzJ6MjI4NWp2cHBqWEtQaGVKNEx5eVg2?=
 =?utf-8?B?WEZYZWp3SW4yWGVnS2luTENKdy8wNjIwQUJNQ3NTR0xhT1BySkEva0xoVkxZ?=
 =?utf-8?B?NFExZjBJNDcvdkhZK1A5aFh4b3ZLdk9pQ1FNeDhXUHRQMHJSVnZ0V2hHeWhS?=
 =?utf-8?B?Zkw3ZC9tcGYxeEhGZ2t3VEJhM3hXMkREQmVUdjd6MUZiVzhGR0czR2VmNUVU?=
 =?utf-8?B?ZnZJTUFKM1hVSnl4NTNmYTBEM01KTmZvVlUvcURtN1pibG1FSHE0YjlwV3U4?=
 =?utf-8?B?NFlJMC8yZUUwb1dYVUJLWjNVTk9sZU1Cc0gycDY4NFNkRDJ4a0FwWUkxT2RC?=
 =?utf-8?B?aVJrdndZVTg4N2J0bHVOSTI2WDJHK2NDVFYrdG45T0lkTmJqQWNmUllNRTdo?=
 =?utf-8?B?dUR1RTRzMXZOSnJNclAwcE91K1pZRGVFcXRySFFnWXgvdTJOQUhtM0hLeVE4?=
 =?utf-8?B?ZzFNZFpBK29KNy8wZzdFTFpkVkd5dTh2dHgzMndpS2RlZFNWTTk4ZTVDYVhq?=
 =?utf-8?B?YVNpenJrY0xrdGNheTRNdGt0YnJJR2pKclUyUEdkZk5BdS9JWm5lNTlxNVJh?=
 =?utf-8?B?ZktkSFkxb3JMZG9nRWthUWJ4WFlaVDlDZGtPN0pxbG5lUHVmbXFCN2xpa3gr?=
 =?utf-8?B?R1h2QzZzdnQvaVJqRit6SSsrdm5nTVh1dEJwL0VqenNsOHpEbUVVdkhlZGxt?=
 =?utf-8?Q?G7MgvhC1ZZxWXZjt//f/O2fcV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a65dc46-24da-45b1-e273-08dcf496b55d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 01:45:30.4352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 79nhMMr6xVCni026s1iCs7U8Z6DOAveML4QVqSGGu6w/2ZTxvZNlgPbDCpxgBMwoA2I48gjgeoJu00fZh3DOC8Zy2iL9IDG0ij27e84dp5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1226

T24gOS8yMy8yMDI0IDU6MTQgQU0sIE1hcmMgS2xlaW5lLUJ1ZGRlIHdyb3RlOiANCj4gT24gMjIu
MDkuMjAyNCAyMjo1MTo0OSwgSGFsIEZlbmcgd3JvdGU6DQo+ID4gRnJvbTogV2lsbGlhbSBRaXUg
PHdpbGxpYW0ucWl1QHN0YXJmaXZldGVjaC5jb20+DQo+ID4NCj4gPiBBZGQgZHJpdmVyIGZvciBD
QVNUIENBTiBCdXMgQ29udHJvbGxlciB1c2VkIG9uIFN0YXJGaXZlIEpINzExMCBTb0MuDQo+IA0K
PiBIYXZlIHlvdSByZWFkIG1lIHJldmlldyBvZiB0aGUgdjEgb2YgdGhpcyBzZXJpZXM/DQo+IA0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDAxMjktem9uZS1kZWZhbWUtYzU1ODBl
NTk2ZjcyLQ0KPiBta2xAcGVuZ3V0cm9uaXguZGUvDQoNClllcywgSSBtb2RpZnkgYWNjb3JkaW5n
bHkgZXhjZXB0IHVzaW5nIEZJRUxEX0dFVCgpIC8gRklFTERfUFJFUCgpLCB1c2luZw0Kcnhfb2Zm
bG9hZCBoZWxwZXIgYW5kIHRoZSBzaGFyZWQgaW50ZXJydXB0IGZsYWcuIEkgZm91bmQgRklFTERf
R0VUKCkgLyBGSUVMRF9QUkVQKCkNCmNhbiBvbmx5IGJlIHVzZWQgd2hlbiB0aGUgbWFzayBpcyBh
IGNvbnN0YW50LCBhbmQgdGhlIENBTiBtb2R1bGUgd29uJ3QNCndvcmsgbm9ybWFsbHkgaWYgSSBj
aGFuZ2UgdGhlIGludGVycnVwdCBmbGFnIHRvIDAuIEkgd2lsbCB0cnkgdG8gdXNpbmcgcnhfb2Zm
bG9hZCBoZWxwZXINCmluIHRoZSBuZXh0IHZlcnNpb24uDQoNCkJlc3QgcmVnYXJkcywNCkhhbA0K

