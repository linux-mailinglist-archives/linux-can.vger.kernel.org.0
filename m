Return-Path: <linux-can+bounces-3094-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33908A61459
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 15:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BB33A3022
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D61201027;
	Fri, 14 Mar 2025 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="kpNj0xRN"
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010044.outbound.protection.outlook.com [52.101.229.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4031DD0F6;
	Fri, 14 Mar 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964379; cv=fail; b=XvEAFLzwqYRPE1vzdC9dteYFk+JHX6b6x1xq0+qMSoQeSov5/n8m+FD6unmOi42+LDwBQt7Ht/ET7qM2l8olVxcPhr6Xm/+v9T8BfuzooXZLaSXrTXhDa/qn+lwFC24lC76q/WsMvd9b8RdhGdmUx9fUHi6NlM1kvSUkEQNtqr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964379; c=relaxed/simple;
	bh=SV8SgZ14xozIfChkafD4T9aY7QmdklA4DISTKH4hbzw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U4mXd6JHrJ/rgX8KXGcOfluv2DblOtd9vfTJoOx1Nj8OLXTpNudOh6AGgnd+8rggjMczAmuwmVuhOhYfgY7G6Ke+/7Fs7/gd/DyrttLNYa+hIQDVDrkquLJseJgMgbC6VpcI3r2mSqbMN8WwB9nZ5nOPirT8RZlWsCwEnDMVntw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=kpNj0xRN; arc=fail smtp.client-ip=52.101.229.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwggToXUwahYagwooSd65Pht1kDXoPCAqgqh3CsUc0GDhWNhJsUQulEL4D/6EY9e1sPDqF7Oo9iyBJiDevXKsHnB5LV1W4Dg5KsRgc2baFMtGCa64mVCJ0VE9ofacwVWxo6SnTvpJth4mNvGGfWmrEg/w3imtEZ/UZ5mhI1YvJ89NXEuzqiQNEKogTCFHbl+5w3i5YYR3pp6jBjx/p1zxBSW0ghSlrJsrhrC/8+H8iHeSiOWUgzXSIKJXF8Opf4HAcsv3CFhucYKi2K7kiU/2EJjiPOWgPjXEuvuAzm72H0epE4dqhRbYhJK3BEHnagiTpEypuT8DZVaafPl19Bl5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SV8SgZ14xozIfChkafD4T9aY7QmdklA4DISTKH4hbzw=;
 b=W/p1Z+/YLi7ZcvjhRR5CL67cIk0NpEACABDkQ9gLlXpwvmYgMBkxZHUhv+Y38VFqP3sfEzMu5YnaqslP84kXrbJd3oeInGR8luwPT271+yuypRpnIFQnsH3Dcz9iWBUSTqwI8Qg6OfqYCu/MT+EIYpg9suJe3eGTWMMA2lP0YuY7tTnVr/GxCfHo6vhsgT3SalcsHAMr69eDsHqcCV8eui3X8C/Iot9/Rghu4NENnwBDjZTNJdRjfHe9o2HvhFhUe7U4UiE387Vrx/65jD3peKbKxaWIaWqu+85Daj+Wb7cXoth/GSVcq9Mz8z5aEaU1Q0EsTByES+1bThiNmXFbFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV8SgZ14xozIfChkafD4T9aY7QmdklA4DISTKH4hbzw=;
 b=kpNj0xRNyI2FXi+JA92Y+08R/VG7z/FaoMPCD0CWX7YTJAuV8XQHY2WxcPseHdfwZMG87VBiWvA+dvQ08dsJPl9BOJeRWfm8aJbClg51U//HmUt/ulsT3MCLbRITZYrZbyepDYiahwRLpuuoyAVw9aL8T3vX84dxXPbTKlfIL94=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB14521.jpnprd01.prod.outlook.com (2603:1096:405:242::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 14:59:32 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 14:59:31 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 11/11] can: rcar_canfd: Add RZ/G3E support
Thread-Topic: [PATCH v4 11/11] can: rcar_canfd: Add RZ/G3E support
Thread-Index: AQHbjpVn270mDzoVs0ys81MOM3vjvLNyww0AgAABu5A=
Date: Fri, 14 Mar 2025 14:59:31 +0000
Message-ID:
 <TY3PR01MB113467E7730F505783F3E642286D22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
 <20250306124256.93033-12-biju.das.jz@bp.renesas.com>
 <CAMuHMdX_SxAh-T0UzGvJ2rZ=6r3uyDrpHmyVgn1Fv5r51Tpyog@mail.gmail.com>
In-Reply-To:
 <CAMuHMdX_SxAh-T0UzGvJ2rZ=6r3uyDrpHmyVgn1Fv5r51Tpyog@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB14521:EE_
x-ms-office365-filtering-correlation-id: 4dbb87ea-024b-4305-2f37-08dd6308d387
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OUZYMXN2WW81M1VkUWZ1MCtyb0lueGpzeDdFaTA0YkRMRzRjWWxhbUNRRVJL?=
 =?utf-8?B?WnZ2NWlOWU9TR0QyMk0xRGwwRzJsVko2a1k1cnc0aFdWSFViOGROalFJL2d4?=
 =?utf-8?B?RlEzYmhDL1JuSlpiaWFVOWV4SVAwMC9Ya1NwSVk2NjhOT2JrSlVjaWxIMkZm?=
 =?utf-8?B?WmltTU9xQXJFcmRUK1BBVzFpVmIvYnd6c3c5Y2I0SFcwYlNsWGJmVDZvOHN0?=
 =?utf-8?B?aFozWmZKNXI0UjRHeW9ET1JiYkNwYkg1N2I1eDRQdVF4YTJ5UklOaWI3TXg3?=
 =?utf-8?B?YUljNGk2SlBMNDhzRUNRNGJZaWZQWFg1RGJOd2VBbTl2akE3YXBZSkt5VDhi?=
 =?utf-8?B?ZVd1VGVhRlNzZnlTd1BBUzhIaTB0ZHdlZFlOK1VYVUEzMWsvMlVDb1FudU1E?=
 =?utf-8?B?RnNmTlVZMitSRGFpWjhnOEVrRXJRN0owRjNJMEpqN21INndBVTFsbjFqVVdS?=
 =?utf-8?B?aDZBOXU0dWxSV0ZWSVVpR0VPcFFhd2FNNllqVlNialV3b3cvOGVWbWk2MWhN?=
 =?utf-8?B?V0NGM0NJaGJaQWYySWpHUUp2bTRXYXVOQUhvekZVSW5YUlA3d1RVQU1hVm15?=
 =?utf-8?B?bXFaNENndXQzUjducnpsTmNTY3l3aEIwOHhiNS9PM1FqY0Nic1VBWDU1YU1r?=
 =?utf-8?B?djVZcS9rZDVPMGxMWFg2VlpGMWNHS2Ezei85SGJjMXdqdXJqcUZoa0dXcU1i?=
 =?utf-8?B?TW8xWEw5R3A0K25ncXFxc1dTZmw3SjFNMnhUUHNWN3JmZldja0ViUnkvMzVx?=
 =?utf-8?B?ODRCR0lJS2xwa0tDWEZ6TWpvMVNEU3pVakh1WmVVR3VlN1lWWGtHQXMzYWJt?=
 =?utf-8?B?V0haWUVHQVlGbkJlc01TTmhSL2p1TVNHL2YvWkJPdWJia2xLM3NqdnFMMm5E?=
 =?utf-8?B?aFNsd2FScUxHV0U4VGNGUXNBUzcyS3B1ZnV1eThrUWpoMGp5bzRScUhqYUpq?=
 =?utf-8?B?UVJxcWdQWkxzNEJ2SURkMUxkait5bGcvOFJicjdqUkwyNnQzRWgyUGRMTEIx?=
 =?utf-8?B?QzJDTnFiOHl3MlJMOVJmL1JuQzRrdUM4a1NrNTRKUXFwaHhBWEtiT1o2WDR1?=
 =?utf-8?B?ZW1UaTYvOHNkWnI1SGVIR1hqZlBISkNuMS9mLzRiMmpDclY2Ukdqck54ejk3?=
 =?utf-8?B?ZktqQ3FiRTJWZXBUejI1blhaZEREOC8rK0lmV0dHMGViNHhCRHB5STFPa1M4?=
 =?utf-8?B?dVdBR2RqcGJTUUVqakhVWjR4bWVsQkh0WHZucUloK2ZzT0JmTXptSDJsU2ZD?=
 =?utf-8?B?eWlmLzZDOE5GWW1INmt0NHB6aXBqQkN5TlJoNTYveklrdnZVbUk2ZmxocDkx?=
 =?utf-8?B?VGJFMHJrTWQ0UVFVeW0wcCsxTUc0QTN1M1k4bThtdnMxekVlZUNHRWZRRk9j?=
 =?utf-8?B?dnNWcXhZYkhieWZ0N1A1cEh1TlIwemJFVXBzN1FRTmdtRFVNSXRONjUvc1Iv?=
 =?utf-8?B?N0hjZkFEZlBPMUJON0NpN0lUVi9hcW1IdEtBeXZKUkI3NmFjNmdyd1FxWDNw?=
 =?utf-8?B?dTg2Wk9obU1VeUpjdkZ5VGVLWHdxQUtlSHJLNXlCRGs4MXNtQ20zWVNaK1Jt?=
 =?utf-8?B?R0dyT1hKRExJMDdtUlR5a3pzUHljd1lhcmtQY1d5Q3d6UndtM1VNYXplM0hR?=
 =?utf-8?B?RXhodWhmYXl1ek80WCswM0JMUlovSGd5cVc0S0VuWDRFMjVwV2hkczNBYSs4?=
 =?utf-8?B?OVkvcXhkUGpqOUVIN3B4T3dyZUVNbEpweDdVWDJsazgzQ1o0YlVPMFlHbk9P?=
 =?utf-8?B?VXkrMFVMOFRYbnRvUU5oMGtaNzZBVWRyRWRWQ0FKQUZYM2JPTGFJSFA0TUN5?=
 =?utf-8?B?eVhnK1NRRTR0cmFPektWb1pVdThxVTc0SHU4VEpuL1AveFlLQ2hPMDNha0Er?=
 =?utf-8?B?N3R4N2RzNEhBVGJ4VU1ZSHpNU05KYWF3T1NDNXZ6SDRvZEM1cUZXNk9UM0lE?=
 =?utf-8?Q?uo2qwO32QvKOjCUMyMOmlOny6bvstiTu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWU1Z25BTmdBc2Ryd2oraFV2UFgwcS8rYW0yS2UwNGRVa1g0VUY4VzFPcDUy?=
 =?utf-8?B?eUlmQXY2QXhzK3FmUytHenkyRTNiRkhiS0I0ZnFFaEhkZjlpUlJ6bWZLM2Mx?=
 =?utf-8?B?Uk5vMStOUVNJSFF1Y3pqckdUUXlYQlVDcEhRbmVIZkNzeURibUtSQWpxSll3?=
 =?utf-8?B?NUVWR3NVdHpsZHJBVjJmeGFPeFNPYnk1YkFITkNqUmhWekdGUUNvOFJpVXUy?=
 =?utf-8?B?a1hiWTVjM2NlVit0ME9XL2FzTzZ2WGc4aTVZY2dCMUJVRnlTTDkrUm9aVFJk?=
 =?utf-8?B?RzJXanppbC9QUlZ3bU9aSmtaR2ErN2ZkTFdaK0s2enFqMjU2UXBpZ0x3b0Zw?=
 =?utf-8?B?MW5iVys1WVFjRG1Td0xOVEhVT2xsSERDemNZcTRQbXhRcnFyMzZueHl2a0JU?=
 =?utf-8?B?VEh2QUdLRHFEbXBtcEJpVWFNUGhuNkhxN0IxWXRzalRaSTllRWpDSSs3amcr?=
 =?utf-8?B?SHh2MnlGN0RxQlFZWmRjTGIrWHBwNFZCanpRWWUxZDhaNzJTa0NmS05haEd6?=
 =?utf-8?B?TVdveEZzZlVjbVd6dzZFUmtJY1UxZFFNeDlKYmNhbDVQUzhmUVNTK05ML01I?=
 =?utf-8?B?WSswNXR2VTBZK3BDUGRwclJHdnp4d1N0UFRqbVlmQW53L3grOFliamZlWGYx?=
 =?utf-8?B?MGlLT25YcDJBUTJIamRjY25oVHZaQXFvOXAzOHFPSXFFSTRrTHRuQlFOYnJ5?=
 =?utf-8?B?OTNPb0NIeTNKNTZBNkFET3FtWEZVWTJRYlA0Y3c1RjU5dVZEMEQ3UWpyU3Nz?=
 =?utf-8?B?K0Y4SVM5SVJobkhxT1B6ZStvamZLTkVMYWZvWGV3c1NnRDJQSjQwR1gweCtU?=
 =?utf-8?B?a1dwSVNpQTdsL0FIb0ViUHJLR3F1TDFHR2JwQjBUTDVydVV3K2VpLzl6L1JS?=
 =?utf-8?B?M1U1OWZ2U0NEVkYzL1l5VGYxdmptZ3dIbURDeVVIYlVTSzR5WjVlczlQUXQw?=
 =?utf-8?B?K0JuSWtKSDZidURxSUYrUmErSWN4QUF6ZHdUTXJzSVd5VVp4WERmUUQ4NjA4?=
 =?utf-8?B?VEFaVFNLOEdwdVRuVVczQVhQSlFCY0hzN21rRmRQbmFnYklTS0JWRTNFSU1s?=
 =?utf-8?B?a1hvK1orTmplV3FtNFM1alB5QmZyVUtqbENxa1g1cWxueUFWT3d6T2JBTWF1?=
 =?utf-8?B?eWhoZHN3ZGMzd21oMHRxUEk2Q2VkcGpHMjJJd093UVZOR25vamdwcVhjYUo4?=
 =?utf-8?B?Z3N0Q1puM2ZHbnQzTElwMlBHdHE2OFpERm8rdnBlVmNiRFBDd1FGYXAxUWtm?=
 =?utf-8?B?WDRPbHc3dlFtSWhEMTlSN1lwdy9UWTF5OGZWZ2F4QXBSUi9LOERiV2tvL1Jv?=
 =?utf-8?B?NnNCUUZ6Z29zN3EvYzhwN2NYVlRIQmtqTThjcmViMDJvV2NDTTN2STFuci9s?=
 =?utf-8?B?RkRId1d2ZXFGS1NMT2FYVHY2V054M0ovMnFZYXpnRVJES0VUQVFaaFZicC90?=
 =?utf-8?B?TURraFZzVFQzbU5UM09BbWxsYzBlaWF5NTRZMkRYdWEydFl5OHBwZGg0bkpp?=
 =?utf-8?B?QmxtRGxlb0JpR0VHVEFQWUxsSkRCM3YwMXV1WnJVWDYvZ01NR1QzK0oxcW5Y?=
 =?utf-8?B?SHJHKzFQK2ZWRVE2WWx5dVhPMGtKWlZTVkZHN3VUYVJ2ZWk5ZGU5LzZubHZw?=
 =?utf-8?B?YldvRFZCMlUrRkxKM3Z5bXpnd3BFREpEaDdGRFRJemd6S01BbHZXZVFnRktk?=
 =?utf-8?B?UUhzTXRBdjRzSUtBUklOaFNPbVdDdFI5T1h6eTZnOHFIMkl0OTlJeks2Z3Rk?=
 =?utf-8?B?Z1lGT0lHeU9hRzl0WmU4aVlVUWRSdE5WSVlteVBrem40L1ZxY082cSs4TTgv?=
 =?utf-8?B?UWExTGpTUTUrancvTFZuQUMyZTY0cmRDa3VGMzBnWmJQSXlHV0ZSQmdMeU1X?=
 =?utf-8?B?eVpucnhiUXVsRWdtalZKTnlKdzU5ZUpaTU5uRjNYby9GVGsvMkZ2MEd6ZzBy?=
 =?utf-8?B?VHVIR0RwV3NTZ0MzYVlSa1RxZTBSSFFhQitTQ2VYWk1RVTZ5dG8zZUkvZlBX?=
 =?utf-8?B?N0JwRjZwcE5NcVBEdktJZkxNdGQzUjgycW4wU0RDNE1XQVVrankyMkU1dVRK?=
 =?utf-8?B?c2hqek1sTjlpODV1MzROSStFbkdYTkVzWVBpNERueXZKcWFnQXR5TlRoSjBO?=
 =?utf-8?B?RWhHc01mcDMrRlBxRDk2M1BwOUN2LzlFTHhlbDBheUY2cVprQnZMb1hNWFI1?=
 =?utf-8?B?TEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbb87ea-024b-4305-2f37-08dd6308d387
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 14:59:31.6122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +jp74PcafJYr/+kURkr9ViBjB9eH4ktLY4ttp0K5TsL6b1SfTYUtc6fEx7MJG1LSrmDpVfIw4BqbsihZ5OOTf+2sl4He54i+1xjplNMqxA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14521

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDE0IE1hcmNoIDIwMjUgMTQ6NDgNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NCAxMS8xMV0gY2FuOiByY2FyX2NhbmZkOiBBZGQgUlovRzNFIHN1cHBvcnQNCj4gDQo+IEhp
IEJpanUsDQo+IA0KPiBPbiBUaHUsIDYgTWFyIDIwMjUgYXQgMTM6NDMsIEJpanUgRGFzIDxiaWp1
LmRhcy5qekBicC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gVGhlIENBTi1GRCBJUCBmb3VuZCBv
biB0aGUgUlovRzNFIFNvQyBpcyBzaW1pbGFyIHRvIFItQ2FyIEdlbjQsIGJ1dCBpdA0KPiA+IGhh
cyBubyBleHRlcm5hbCBjbG9jayBpbnN0ZWFkIGl0IGhhcyBjbGtfcmFtLCBpdCBoYXMgNiBjaGFu
bmVscyBhbmQNCj4gPiBzdXBwb3J0cyAyMCBpbnRlcnJ1cHRzLiBBZGQgc3VwcG9ydCBmb3IgUlov
RzNFIENBTi1GRCBkcml2ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8Ymlq
dS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+
IA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+IEBAIC0xOTc5LDYgKzE5OTEs
NyBAQCBzdGF0aWMgaW50IHJjYXJfY2FuZmRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gPiAgICAgICAgIHUzMiBydWxlX2VudHJ5ID0gMDsNCj4gPiAgICAgICAgIGJvb2wg
ZmRtb2RlID0gdHJ1ZTsgICAgICAgICAgICAgICAgICAgICAvKiBDQU4gRkQgb25seSBtb2RlIC0g
ZGVmYXVsdCAqLw0KPiA+ICAgICAgICAgY2hhciBuYW1lWzldID0gImNoYW5uZWxYIjsNCj4gPiAr
ICAgICAgIHN0cnVjdCBjbGsgKmNsa19yYW07DQo+ID4gICAgICAgICBpbnQgaTsNCj4gPg0KPiA+
ICAgICAgICAgaW5mbyA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOyBAQCAtMjA2OCw2
ICsyMDgxLDExIEBADQo+ID4gc3RhdGljIGludCByY2FyX2NhbmZkX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICAgICAgICAgICAgICAgIGdwcml2LT5leHRjbGsgPSAh
Z3ByaXYtPmluZm8tPm9ubHlfaW50ZXJuYWxfY2xrczsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+
ICsgICAgICAgY2xrX3JhbSA9IGRldm1fY2xrX2dldF9vcHRpb25hbF9lbmFibGVkKGRldiwgInJh
bV9jbGsiKTsNCj4gPiArICAgICAgIGlmIChJU19FUlIoY2xrX3JhbSkpDQo+ID4gKyAgICAgICAg
ICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihjbGtfcmFtKSwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImNhbm5vdCBnZXQgcmFtIGNsb2Nr
XG4iKTsNCj4gPiArDQo+IA0KPiBjbGtfcmFtIGlzIHVudXNlZC4NCg0KY2xrX3JhbSBpcyBsb2Nh
bCB2YXJpYWJsZSBhbmQgaXMgdXNlZCBmb3IgZXJyb3IgY2hlY2tpbmcuDQpkZXZtX2Nsa19nZXRf
b3B0aW9uYWxfZW5hYmxlZCgpIGlzIGRldi1yZXMgbWFuYWdlZCBjbG9jaw0KYW5kIHRoZSB3aWxs
IGJlIGVuYWJsZWQgZHVyaW5nIHByb2JlKCkgYW5kIGdldCBkaXNhYmxlZCBkdXJpbmcgdW5iaW5k
IA0Kc2ltaWxhciB0byAiZmNrIi4NCg0KQW0gSSBtaXNzaW5nIGFueXRoaW5nIGhlcmU/DQoNClBs
ZWFzZSBsZXQgbWUga25vdy4NCg0KQ2hlZXJzLA0KQmlqdQ0KDQo=

