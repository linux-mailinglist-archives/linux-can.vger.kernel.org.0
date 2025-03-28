Return-Path: <linux-can+bounces-3286-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E90EA74DFF
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 16:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16BE3B408D
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FC71C4A13;
	Fri, 28 Mar 2025 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="hj3TNBkF"
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010025.outbound.protection.outlook.com [52.101.229.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A54B5FEE6;
	Fri, 28 Mar 2025 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743176830; cv=fail; b=muOnuMHyaTHrB+LgtF6ZWdS0fklPILTISfbKbI7NAs6yBaJe7tMCJKCCShpqu32ltssk+K35dEGz3Qyda+Gchm5RdMRFC58n34elwIF0Fj2x8rniQlcT0zJ5FhMQU61MvSlWVJZo6MTjufAvdCrmEM4zxhj2UEmVUROSQWF/CD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743176830; c=relaxed/simple;
	bh=i01Wd7/2LLNhhUCGvzuJcKT1bosAfJzIYwy/60MIiFs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TVLK74OLV7yaandV7iCGsifMUEBdtib6KNtRR0z0DZ0sidrmRKSvB3tu9ycIUq2Zdz/1Wyx5AOQW4JTzK8f8qgZyUcZL7zA6fsgdiXOxyZ9dliZpixz21Dvf334tcBzzlBJKr1tZfP+zN3L7HwWBP/+ED6T5G1drosFthuD2j7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=hj3TNBkF; arc=fail smtp.client-ip=52.101.229.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aA37J3azGAB4perDbnyGfhztEWiAs3aN6wrfAQ5rNv4jUk1VV7XYVKDYPGvabQO8xfAZV5xSHXvXHJQ0cD6ilh74rlns+QNsDgqBhKK4csFc5tQmMGwvmuZfb7jQl529lMdrQvTiV/dliHDy2u8DDq8RuEWpDjzzjqUFSal+pd5CnCEvTU92wA9qLXOW4pglleE7knNPveLjNAisr4EKPa4MywCVDxDLcvcu3cEVP4FmrLcw/UW8p3zrRnv882OQF0t0KURKYRxU1qAEnoakBf5fvaT/WyZGfDN6lvVllDHkj53NEvz3opxlRJPTbLfEmLEbKhOxzRaqwkGiYsDgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i01Wd7/2LLNhhUCGvzuJcKT1bosAfJzIYwy/60MIiFs=;
 b=ZOjYDT19Ct9JpDBYkuFRYWH7r3714iJNnuqp1f1ImTiLiZN18XKGGdObrGw36Jp8UHXCHnrGEh5RyZLEVfAat1ebqg56Fd4RrX7pyAN7OFYQqmUHdZGIIY8duyhQzlO6n2rn2JgBNH7wMc88XWKEhGz3eeTMaZNVlkF/7ZD6brrqwnLxyO9jCzEAR6fwtUSoiXumRCYdELdXAtUhaA3KPxRXfcpmEsIwKQX10SqVS/bMbuEehK9gmw8oPo3QfvCTcFQ9ar0E1qAkL8JDrhK1PAXdyvq5i88DhDoMtmRpYOV/kOl4kx7FELVCAkp6LSu1I3V6UbU2wLm8/AMrwHQ/lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i01Wd7/2LLNhhUCGvzuJcKT1bosAfJzIYwy/60MIiFs=;
 b=hj3TNBkFxOgcyGveRLfWjvV83kup15RsH7+xqkQ001iIdCOQ/wJ0ZFkhiZlL7szVlb26S+jGdXcY43l6raKZwtQ9leo4haxGnvGyNfbh90X0ZDajq8cojQUeplgDRHYr0DcbswOPBXrpaWBR535BT+jDpyOaig0Sqff6GCW3kuU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB15281.jpnprd01.prod.outlook.com (2603:1096:604:3ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.28; Fri, 28 Mar
 2025 15:47:02 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 15:47:01 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros
 in RCANFD_GERFL_ERR
Thread-Topic: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros
 in RCANFD_GERFL_ERR
Thread-Index:
 AQHbnkl63JoFqVndWE+hQB80zsNhELOIReiAgAAAqiCAAAbcgIAAAW/wgAAHzICAAACyUIAACHcAgABUTuA=
Date: Fri, 28 Mar 2025 15:47:01 +0000
Message-ID:
 <TY3PR01MB11346B6BEC91661525DA9AA1A86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-6-biju.das.jz@bp.renesas.com>
 <40392a70-3be4-4d11-8614-eebd5d9d24a8@wanadoo.fr>
 <TY3PR01MB11346C091544B49A6C160712E86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <deffdc35-86cf-4282-ba6d-f36890bf9fcd@wanadoo.fr>
 <TY3PR01MB11346DA97D5F685D96A638DB086A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdUacYqUd_iPk95C3+bc64SeMbDj1=zdfLvuMHFbTRS39w@mail.gmail.com>
 <TY3PR01MB113464539C208D4A1AAF403A286A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <b486255e-4699-4ca2-a783-9c164eef3f24@wanadoo.fr>
In-Reply-To: <b486255e-4699-4ca2-a783-9c164eef3f24@wanadoo.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB15281:EE_
x-ms-office365-filtering-correlation-id: 6f438f57-4a5e-4dd7-b436-08dd6e0fc819
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N21CZUhLeXVaTFdVUnUrS1dZUDZMQ01oeWVhWGlod3VCa1ZRMmcyRVVjc0pV?=
 =?utf-8?B?eDNWUkl2K1ZjdlpoaCs1QjE0bzhMTWFDSmRneXVpa2NQeUQ1Y0pLWVJ3UkFB?=
 =?utf-8?B?ZytoZnBSdnViVURwTDNESHc2VlIybnlqOFowMDREa1cwcEg3c09kVHFJaGR1?=
 =?utf-8?B?R1VnODFPWDVXSlVUN1M5dE01UytFWUd5TERxSjVFL21jT3EvQm0zZjhiS1Zp?=
 =?utf-8?B?aU5wa0swNHJwd3d6ckRCMURIUlBmWnhQTkRGdVUrLzV5bWpVZVF5blFnemc0?=
 =?utf-8?B?M2Q1bk1XeWhERFpaOWVlM2d1Y3h6S2JacEdZRHdyMzlVNk9FaTE4S3RGTTFj?=
 =?utf-8?B?ejlKZ1VxdFdFVzU4elNmL2pWWnpwUGJNaXVEbmpQdGFVYXNhZEN4K0laT2RC?=
 =?utf-8?B?RUpmTlNiSUt3Z2R3WGZwMjVwdlgwZUptRkllWllMdzZRWk1meDZCcmYrNzNR?=
 =?utf-8?B?U3gwcjRaM0hZTXhnVEVuY0JOeTJZbk9OTHBQVGFib0dYNys3ODFzTlNZdmFv?=
 =?utf-8?B?eTJPaGxWTWo1WlhrS1NEYlNHZ2Y5RFl5UFh2cUVQZnlZN01GbTJDTktyQ0lS?=
 =?utf-8?B?cVBVNWF5WlhTd2ljNXpBMTc3SkhNTHRkamN0R0t0OGJWd3pKeVMxSXlzdlp6?=
 =?utf-8?B?WU9wUnJ4c2R1WGdJcE9OVk1BclpQR3B1Sy96ZnMvVGVOM2NDdytNYXVOeEFu?=
 =?utf-8?B?QVZHQkxZVithYkRMeXhBVm9tMFdnWHZ4aEZ6VkdCSmhvU1hSSlkzeTAwcm0w?=
 =?utf-8?B?RjdYRUVRaFQ4blBvUzhENmdJdG9CRlRhYzFWQmZkTGd5eDlnZjU4R1NLQkY5?=
 =?utf-8?B?cDl0MGVDZkxkSmtjdnhCdE0rOVVsOGtZR1RhWWFZL2h0UTNZajgxeHQyMW9q?=
 =?utf-8?B?SXBhdEJyL3pxWXBlM29RL2hTZkdFa0lFWnNMT0R5VWt4T2R0cUFZUGtYbS9p?=
 =?utf-8?B?R3RXYTh3bHZEYTk4cnlmWVJSYzZmelJ3WThDamRseFZsU1RPQmh5dlpGNlpD?=
 =?utf-8?B?Z25YRmdpeXRFUkdKeFVrQTIrMG83cWhPMU5oNGFHaEJOdkxHeERuZEM1dUNF?=
 =?utf-8?B?eVF2YmZueXJHZE5TNVlWekhFcGJ1MGFKNUU5NmFYQTJWM3RIUVRsdzFRYysz?=
 =?utf-8?B?VW9VOE5CMFNJK25RQXNMMVhscHdPN3FBQzR1a0VlR2w1czBINGdhRXRqRUVx?=
 =?utf-8?B?c1dRVnhQd1Vha2ZoaFUyZlVVb1pabytDUndwcDdnNFZpQ2FSQ2FDZ0J1MVpU?=
 =?utf-8?B?ODAySGVPYjMvaE5MN0ZOYkxCYzY4cHdpSjU4RU9qNkpYMjl6U21qb05IbjFO?=
 =?utf-8?B?Q3JKNzZ4dW5uM21UaEhoSW5hRnM1RlF4TTNVb1FyZktyS05ROUJJdGg5MUZr?=
 =?utf-8?B?VEJlZExYS3pXRHBhV0kzM2pYdVNjN3h6RGVCUlBrSWxwNGlIQ0RXVTJJRE9I?=
 =?utf-8?B?UkxEaEl2bEFkaWh5UTUvTmRFQ3JsL0JIcE5lMGNnVmppRjZaQkp0SGdCc0Jx?=
 =?utf-8?B?SUlzajNNaU0wVzFXTE1aN3lRTmNLbFkzUmJkcXhva05sTGtKVjd1azY3QXFx?=
 =?utf-8?B?eG5Xa3FQbldWOEZlc2hDak82bzBmS3JQV2htbGlKYytZWmhsSkpJcXlTSzJK?=
 =?utf-8?B?NjdPQkNSdzFYa2R0SHdYRlBFdGdYWU5jTXN6NnNjTksxQzZOZm4vcWNCM1hE?=
 =?utf-8?B?TU5ycGZuRWV4NFZjMGx0UzJxb2ZlMXVNZTZZOUtac1ExUjdTa0ZWeGpJYzUr?=
 =?utf-8?B?MlFlSUVmM29RQjN6anZjVlgzT3QzYld5VEZQTWZ1NDVtN2RFNEVYcERCaVMx?=
 =?utf-8?B?RnAzV0NFTkJ5NVFFeUwwZkxsMm0yRXpoZGR5TFlOTXZKSFBxb0daV3lPZkx0?=
 =?utf-8?B?VkFWN1FMVE1raTZ6TXRSZEc5NEpEQmNKeW0zeXZieXVLZUpxSTg5Z09WREN0?=
 =?utf-8?Q?bmKB6coC3E7oHlveVjltLuStbtAMuMcn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QndmUG5LQkp2QzFWYk9tMHJQZmhLcEE1aWx4aHpDWktHUU44T2xJVjBNL3Nh?=
 =?utf-8?B?Q3VLZVdscnVBQk8vZzFPeW84c1Y0MEx6cFAyaCtVd1Q4d2E3S2tvY2tYcGtm?=
 =?utf-8?B?ME9Ka2tXekozdndGRjhhNUZPUUNEQjV1OUpmQm53b3hiOGZrZUQ4aGRkYktP?=
 =?utf-8?B?TG1MWVZsajFHNWg2WkFNYW1uVUtqWkRBNnc5ODhVeUY5L3BjRWJiZlVWbU93?=
 =?utf-8?B?Ums1WTN6U2ZaUjRUdTQ5YkdubjAySFFvaUJ0VU1CdkJCak8xcjVETmwzWTJR?=
 =?utf-8?B?dEliWjI1K3hmMjBqY21zMlNaY3JaOWQ1QW82TWdPeEl1Y3NvWnVtYWViUlF5?=
 =?utf-8?B?Y2sxSmI0MEl5RFZ2QURRcFBZYnVtTUxTMGJCT3RUMWtBbnZWdC84TGFySkUw?=
 =?utf-8?B?blp2RUJYQWV0c0JaR1NRMHZEb0Nxa1RtNjlaampjNWpJMkswUVdDZXZyZVZl?=
 =?utf-8?B?NVZsK3dnRzV6QXJMWlJ5dlNES0Jub1dGYndSRUVPZXphdm82d05tSngzUW9y?=
 =?utf-8?B?RnVTMlBOa2haSkJKK3BGZkpBSEcwb1pNOTVDb20xNisrQThKVWcvUzJNSGVB?=
 =?utf-8?B?b2dZWnBpamQrQ2l0anVway91ajkwSm8rK1RuRW5ISmdlbHROWXd0RnNaWFIr?=
 =?utf-8?B?ejVCV2hSL29Xa1hFRDVwblZSMU40MW84SkxEc2RlMWNzRkorYlFEL3F4eU51?=
 =?utf-8?B?V2hTMHJoRmhrNTE5UFF1U2JoTEZYRmp4dzd1emptSytFZ2JJWGhydHNlbzFt?=
 =?utf-8?B?S2tFTDZDMTUvM0ZCL3RBSHJxWStYalRKdjU1dUVUaFBQNmJxT2psa1F6ajRX?=
 =?utf-8?B?UGNTWTM2SHlLWE52bTB2bnA4RnNld3ZuNkpXWUo0RjZCR3BqZDh3ZUxhOVAr?=
 =?utf-8?B?Y1NNbGsrY081anhKay9qK2lJNEE0N3U4Z0h3T1NJSFV0NEQ0WUo5YzRKcVJO?=
 =?utf-8?B?UlU0NnQvUUNuWElBbDlDRHJRcGRnQytqdmplVlRKeWVNSVBYSEdEZVVxTExl?=
 =?utf-8?B?d0xUQUFvUS9ZbU1WaVRiVFhpakJaSzNHUXZNdTVMRmFGTjU4MkplQVdsUTA2?=
 =?utf-8?B?RTI0aldWd2dhSXVhSVo3K2dVVzBrUmozL0FBd1VCV25mMkpXMVpLQmx5Z1FJ?=
 =?utf-8?B?Y0xWdlZXY2I0KzhlUlZKNWF6TmpLV1BDZ3gyb3l0UitldFc0YXE0NFBYS2hw?=
 =?utf-8?B?NHhnb29Dd0ZZU1JzeDlxK1FnQkFsenF4UFZvRG55bFYyVkZ6bGtMR1VMV3V0?=
 =?utf-8?B?Q0FxaUY0M1dzK3R4bXN6UGxxQkN1RmovTS9HVG5XQkV0akZGSFQvOFNnQW51?=
 =?utf-8?B?dG5oOTZnaVVPTHhieHZwSkJPWmN5WkY5dnc5dTdDbVhYZGgxazF2UmFXSHpM?=
 =?utf-8?B?bzB1ekR4aGowd1d0UnFOMFVzMWdQR2lHd0lVd0NveTBHb2VxMUhJdVJlRXdD?=
 =?utf-8?B?NHdja28zbWExUG9VL3dRY3ovUHJYd085Z2g3bUFtMWZpMVJKQWlkYlhHbW0w?=
 =?utf-8?B?TVRRcVVuMCtUemV0VStLVDRnbTh0d3JVZmhvTXZEaUowOHRYVzRuUy9yUThY?=
 =?utf-8?B?SldhY3Y3MGJEZHBVc0syd1hEN0hGb1kySndDRmpucWczZU92aHlkNWFwQmxM?=
 =?utf-8?B?cFBCK2FFZXNkSndNUFFiVnpkK3A2Yms0TWNJR0NEL2pkS241SDNZWWR0cnRH?=
 =?utf-8?B?U0s0Tk8zVlhOK2VUZ0pxb3ppMFRwQkZabzhBclJ6U1NKMUpIR2VYbGMwWWt6?=
 =?utf-8?B?UXZSYVdpSFRRUGVQN2pWa2NBTUNEYi9tY0dEL3czRDIxd2ZwQ2xBZE96bnlC?=
 =?utf-8?B?TlNkdGJSRnc1TVRYeFMyb3c3NnpubmFjSzNJTHY1NVhBRWVmblR4ZFpEVVIr?=
 =?utf-8?B?eGpucE0zdzFnZzNDTEFvNkxsY1k4ckxpaWd6WG5YczUzd3ZYNVlWQzA0dGVQ?=
 =?utf-8?B?TzhiOEpaN3JmTWVISWpoODVjRXFlMURYYnVaM0gyYkp1VmRlbGVwaTJTNEg1?=
 =?utf-8?B?UlYvQXAyQncyZWRvU2JmRWduUVZCWkNvL0hwOUFZNTAxRG1GNkwwN25sRnA2?=
 =?utf-8?B?RTlBZFljSjlsTzdpUDdiMWtVZ1NmZ0MwQ1h2ODJWVG5hREMzc1NCOFRscEFZ?=
 =?utf-8?B?RkdPQWV1ZERKd29GeVE1d2hoSWxud1dHM0pQWkFxbGlMdnZlQUIzOW1LUWxy?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f438f57-4a5e-4dd7-b436-08dd6e0fc819
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 15:47:01.6815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8apAe3cD3rrYZQbpCyvv1vh3Tbxr8m/tirHoMNczPnCM90M9YkbCi/V8lEqKOTldq0PSti9AbgYIX01x5bznWlEUR/7ATTlXxbyYSOdGxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15281

SGkgQWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpbmNlbnQg
TWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+DQo+IFNlbnQ6IDI4IE1hcmNoIDIw
MjUgMTA6NDMNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAwNS8xOF0gY2FuOiByY2FyX2NhbmZk
OiBEcm9wIFJDQU5GRF9HRVJGTF9FRUYqIG1hY3JvcyBpbiBSQ0FORkRfR0VSRkxfRVJSDQo+IA0K
PiBPbiAyOC8wMy8yMDI1IGF0IDE5OjE1LCBCaWp1IERhcyB3cm90ZToNCj4gPiBIaSBHZWVydCBh
bmQgVmluY2VudCwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBG
cm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiA+PiBTZW50
OiAyOCBNYXJjaCAyMDI1IDEwOjEwDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMDUvMThd
IGNhbjogcmNhcl9jYW5mZDogRHJvcCBSQ0FORkRfR0VSRkxfRUVGKg0KPiA+PiBtYWNyb3MgaW4g
UkNBTkZEX0dFUkZMX0VSUg0KPiA+Pg0KPiA+PiBIaSBCaWp1LA0KPiA+Pg0KPiA+PiBPbiBGcmks
IDI4IE1hciAyMDI1IGF0IDEwOjUxLCBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5j
b20+IHdyb3RlOg0KPiA+Pj4+IEZyb206IFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50
QHdhbmFkb28uZnI+IE9uIDI4LzAzLzIwMjUgYXQNCj4gPj4+PiAxODoyMSwgQmlqdSBEYXMgd3Jv
dGU6DQo+ID4+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+Pj4gRnJvbTog
VmluY2VudCBNYWlsaG9sIDxtYWlsaG9sLnZpbmNlbnRAd2FuYWRvby5mcj4NCj4gPj4+Pj4+IFNl
bnQ6IDI4IE1hcmNoIDIwMjUgMDk6MTANCj4gPj4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcg
MDUvMThdIGNhbjogcmNhcl9jYW5mZDogRHJvcA0KPiA+Pj4+Pj4gUkNBTkZEX0dFUkZMX0VFRiog
bWFjcm9zIGluIFJDQU5GRF9HRVJGTF9FUlINCj4gPj4+Pj4+DQo+ID4+Pj4+PiBPbiAyNi8wMy8y
MDI1IMOgIDIxOjE5LCBCaWp1IERhcyB3cm90ZToNCj4gPj4+Pj4+PiBUaGUgbWFjcm9zIFJDQU5G
RF9HRVJGTF9FRUYqIGluIFJDQU5GRF9HRVJGTF9FUlIgY2FuIGJlIHJlcGxhY2VkDQo+ID4+Pj4+
Pj4gYnkNCj4gPj4+Pj4+PiBncHJpdi0+Y2hhbm5lbHNfbWFzayA8PCAxNi4NCj4gPj4+Pj4+Pg0K
PiA+Pj4+Pj4+IEFmdGVyIHRoaXMgZHJvcCB0aGUgbWFjcm8gUkNBTkZEX0dFUkZMX0VFRjBfNyBh
cyBpdCBpcyB1bnVzZWQuDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBSZXZpZXdlZC1ieTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gPj4+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4+DQo+ID4+
Pj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4+Pj4+Pj4g
KysrIGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4+Pj4+Pj4gQEAgLTc0
LDcgKzc0LDYgQEANCj4gPj4+Pj4+PiAgI2RlZmluZSBSQ0FORkRfR1NUU19HTk9QTSAgICAgICAg
ICAgICAgICAoQklUKDApIHwgQklUKDEpIHwgQklUKDIpIHwgQklUKDMpKQ0KPiA+Pj4+Pj4+DQo+
ID4+Pj4+Pj4gIC8qIFJTQ0ZEbkNGREdFUkZMIC8gUlNDRkRuR0VSRkwgKi8NCj4gPj4+Pj4+PiAt
I2RlZmluZSBSQ0FORkRfR0VSRkxfRUVGMF83ICAgICAgICAgICAgICBHRU5NQVNLKDIzLCAxNikN
Cj4gPj4+Pj4+PiAgI2RlZmluZSBSQ0FORkRfR0VSRkxfRUVGKGNoKSAgICAgICAgICAgICBCSVQo
MTYgKyAoY2gpKQ0KPiA+Pj4+Pj4+ICAjZGVmaW5lIFJDQU5GRF9HRVJGTF9DTVBPRiAgICAgICAg
ICAgICAgIEJJVCgzKSAgLyogQ0FOIEZEIG9ubHkgKi8NCj4gPj4+Pj4+PiAgI2RlZmluZSBSQ0FO
RkRfR0VSRkxfVEhMRVMgICAgICAgICAgICAgICBCSVQoMikNCj4gPj4+Pj4+PiBAQCAtODIsOSAr
ODEsNyBAQA0KPiA+Pj4+Pj4+ICAjZGVmaW5lIFJDQU5GRF9HRVJGTF9ERUYgICAgICAgICBCSVQo
MCkNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+ICAjZGVmaW5lIFJDQU5GRF9HRVJGTF9FUlIoZ3ByaXYs
IHgpIFwNCj4gPj4+Pj4+PiAtICgoeCkgJiAocmVnX2dlbjQoZ3ByaXYsIFJDQU5GRF9HRVJGTF9F
RUYwXzcsIFwNCj4gPj4+Pj4+PiAtICAgICAgICAgICAgICAgICAgUkNBTkZEX0dFUkZMX0VFRigw
KSB8IFJDQU5GRF9HRVJGTF9FRUYoMSkpIHwgXA0KPiA+Pj4+Pj4+IC0gICAgICAgICBSQ0FORkRf
R0VSRkxfTUVTIHwgXA0KPiA+Pj4+Pj4+ICsgKCh4KSAmICgoZ3ByaXYtPmNoYW5uZWxzX21hc2sg
PDwgMTYpIHwgUkNBTkZEX0dFUkZMX01FUyB8IFwNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBUaGUgcHJl
dmlvdXMgUkNBTkZEX0dFUkZMX0VFRjBfNyBtYWNybyBkb2N1bWVudGVkIHRoYXQgdGhlDQo+ID4+
Pj4+PiByZWdpc3RlciB3YXMgZnJvbSBiaXQgaW5kZXggMTYgdG8gYml0IGluZGV4IDIzLiBIZXJl
LCB3ZSBsb29zZSB0aGlzIHBpZWNlIG9mIGluZm9ybWF0aW9uLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+
IFdoYXQgYWJvdXQ6DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gICAgRklFTERfUFJFUChSQ0FORkRfR0VS
RkxfRUVGMF83LCBncHJpdi0+Y2hhbm5lbHNfbWFzaykNCj4gPj4+Pj4NCj4gPj4+Pj4gRm9yIGFs
bCBTb0NzLCBFQ0MgRXJyb3IgZmxhZyBmb3IgQ2hhbm5lbCB4IChhLmsuYS4gRUVGeCkgc3RhcnRz
IGZyb20gQklUIHBvc2l0aW9uIDE2Lg0KPiA+Pj4+Pg0KPiA+Pj4+PiBCeSB1c2luZyBncHJpdi0+
Y2hhbm5lbHNfbWFzaywgd2UgYWxsb3cgb25seSBlbmFibGVkIGNoYW5uZWxzIGFuZA0KPiA+Pj4+
PiA8PA0KPiA+Pj4+PiAxNiBzYXlzIGl0IGlzIGZyb20gQml0IHBvc2l0aW9uIDE2Lg0KPiA+Pj4+
DQo+ID4+Pj4gWWVzLCBpdCBzdGFydHMgYXQgYml0IDE2LCBidXQgYXQgd2hpY2ggYml0IGRvZXMg
aXQgZW5kPw0KPiA+Pj4+DQo+ID4+Pj4gVGhlIEdFTk1BU0soKSBoZWxwcyB0byBkb2N1bWVudCB0
aGUgcmVnaXN0ZXIgbmFtZXMuIE9mIGNvdXJzZSBpcw0KPiA+Pj4+IHdvcmtzIGlmIHlvdSByZXBs
YWNlIHRoZSBGSUVMRF9QUkVQIHdpdGggYSBsZWZ0IHNoaWZ0LCBidXQgeW91IGFyZQ0KPiA+Pj4+
IHJlcGxhY2luZyBzb21lIG1lYW5pbmdmdWwgaW5mb3JtYXRpb24gYWJvdXQgdGhlIHJlZ2lzdGVy
IG5hbWUsDQo+ID4+Pj4gcmVnaXN0ZXIgc3RhcnQgYml0IGFuZCBlbmQgYml0IGJ5IGp1c3QgYSBz
dGFydCBiaXQgdmFsdWUuIFNlZT8gWW91DQo+ID4+Pj4ganVzdCBsb3N0IHRoZSByZWdpc3RlciBu
YW1lIGFuZA0KPiA+PiBlbmQgYml0IGluZm8uDQo+ID4+Pj4NCj4gPj4+PiBGSUVMRF9QUkVQKCkg
aXMgbm90IG9ubHkgYWJvdXQgZG9pbmcgdGhlIGNvcnJlY3Qgc2hpZnQgYnV0IGFsc28NCj4gPj4+
PiBhYm91dCBkb2N1bWVudGluZyB0aGF0IHlvdSBhcmUgcHV0dGluZyB0aGUgdmFsdWUgaW50byBh
IHNwZWNpZmljIHJlZ2lzdGVyLg0KPiA+Pj4+DQo+ID4+Pj4gV2hlbiByZWFkaW5nOg0KPiA+Pj4+
DQo+ID4+Pj4gICBGSUVMRF9QUkVQKFJDQU5GRF9HRVJGTF9FRUYwXzcsIGdwcml2LT5jaGFubmVs
c19tYXNrKQ0KPiA+Pj4+DQo+ID4+Pj4gSSBpbW1lZGlhdGVseSB1bmRlcnN0YW5kIHRoYXQgeW91
IGFyZSBwdXR0aW5nIHRoZQ0KPiA+Pj4+IGdwcml2LT5jaGFubmVsc19tYXNrIHZhbHVlIGludG8g
dGhlIEdFUkZMX0VFRjBfNyByZWdpc3RlciBhbmQgSSBjYW4NCj4gPj4+PiBncHJpdi0+bG9vayBh
dCB0aGUgZGF0YXNoZWV0IGZvcg0KPiA+PiBkZXRhaWxzIGFib3V0IHRoYXQgR0VSRkxfRUVGMF83
IGlmIEkgd2FudCB0by4NCj4gPj4+DQo+ID4+PiBHZW40IGhhcyA4IGNoYW5uZWxzIChHRU5NQVNL
KDE2LCAyMykgRzNFIGhhcyA2IGNoYW5uZWxzDQo+ID4+PiAoR0VOTUFTSygxNiwgMjEpIFY0TSBo
YXMgNCBjaGFubmVscyAgKEdFTk1BU0soMTYsIDE5KQ0KPiA+Pj4gVjNIXzIgaGFzIDMgY2hhbm5l
bHMgKEdFTk1BU0soMTYsMTgpIEFsbCBvdGhlciBTb0NzIGhhcyAyIGNoYW5uZWxzDQo+ID4+PiAo
R0VOTUFTSygxNiwxNykNCj4gPj4+DQo+ID4+PiBTbyB5b3UgbWVhbiwgSSBzaG91bGQgcmVwbGFj
ZSBSQ0FORkRfR0VSRkxfRUVGMF83IHdpdGggYQ0KPiA+Pj4NCj4gPj4+IEdlbmVyaWMgb25lIFJD
QU5GRF9HRVJGTF9FRUYoeCkgR0VOTUFTSygxNiwgMTYgKyAoeCkgLSAxKSB0byBoYW5kbGUNCj4g
Pj4+IHRoaXMgZGlmZmVyZW5jZXMNCj4gPj4+DQo+ID4+PiBXaGVyZSB4IGlzIHRoZSBudW1iZXIg
b2Ygc3VwcG9ydGVkIGNoYW5uZWxzKGluZm8tPm1heF9jaGFubmVscykNCj4gPj4+DQo+ID4+PiBh
bmQgdGhlbiB1c2UNCj4gPj4+DQo+ID4+PiBGSUVMRF9QUkVQKFJDQU5GRF9HRVJGTF9FRUYoeCks
IGdwcml2LT5jaGFubmVsc19tYXNrKQ0KPiA+Pg0KPiA+PiBKdXN0IHVzZQ0KPiA+Pg0KPiA+PiAg
ICAgI2RlZmluZSBSQ0FORkRfR0VSRkxfRUVGICAgIEdFTk1BU0soMjMsIDE2KQ0KPiA+Pg0KPiA+
PiBhbmQNCj4gPj4NCj4gPj4gICAgIEZJRUxEX1BSRVAoUkNBTkZEX0dFUkZMX0VFRiwgZ3ByaXYt
PmNoYW5uZWxzX21hc2spDQo+IA0KPiBBY2suIFByZXR0eSBjbG9zZSB0byBteSBpbml0aWFsIHN1
Z2dlc3Rpb24gb2YNCj4gDQo+ICAgI2RlZmluZSBSQ0FORkRfR0VSRkxfRUVGMF83ICAgICAgICAg
ICAgICBHRU5NQVNLKDIzLCAxNikNCj4gICBGSUVMRF9QUkVQKFJDQU5GRF9HRVJGTF9FRUYwXzcs
IGdwcml2LT5jaGFubmVsc19tYXNrKQ0KPiANCj4gPj4gQXMgY2hhbm5lbHNfbWFzayBjYW4gbmV2
ZXIgaGF2ZSBiaXRzIHNldCBmb3Igbm9uLWV4aXN0aW5nIGNoYW5uZWxzLA0KPiA+PiBhbGwgcmVz
ZXJ2ZWQgYml0cyBhYm92ZSBFRUYgaW4gdGhlIEdFUkZMIHJlZ2lzdGVyIHdpbGwgYmUgemVyby4N
Cj4gPg0KPiA+IEFncmVlZC4gV2lsbCBhZGQgdGhpcyBjaGFuZ2UgaW4gbmV4dCB2ZXJzaW9uDQo+
IA0KPiBUaGFuayB5b3UgOikNCg0KDQpJIHdpbGwgZHJvcCB0aGUgcmVkdW5kYW50IG1hY3JvDQoN
Ci0jZGVmaW5lIFJDQU5GRF9HRVJGTF9FRUYoY2gpCQlCSVQoMTYgKyAoY2gpKQ0KDQpBcyBzYW1l
IGNhbiBiZSBkb25lIHdpdGggRklFTERfUFJFUChSQ0FORkRfR0VSRkxfRUVGLCBjaCkNCg0KQ2hl
ZXJzLA0KQmlqdQ0K

