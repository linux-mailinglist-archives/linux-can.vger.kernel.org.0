Return-Path: <linux-can+bounces-3028-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB409A578C1
	for <lists+linux-can@lfdr.de>; Sat,  8 Mar 2025 07:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2420171279
	for <lists+linux-can@lfdr.de>; Sat,  8 Mar 2025 06:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF25A18FC74;
	Sat,  8 Mar 2025 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="cX/KRtc0"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011065.outbound.protection.outlook.com [40.107.74.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711AB17583;
	Sat,  8 Mar 2025 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741415401; cv=fail; b=Ij8kLJnx/5yV3441SxjTf2nY2iiQYPZJBng6ElTxJ6LNc883Kre/VuiEtBqEauelKa6AzMpkiJwv44S8wMxKRgl1LQ8J1uRaWZNtAjXc/2Vxg/1cf9aHoYg0K3NU8x0o1P5shGuux+8CzbkYPOQQ4oXCRdIRrqfVADzRfjUacrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741415401; c=relaxed/simple;
	bh=8QcMG5gZa0/iUcSClOjYNofzZ7O4wirwOCKU//aFQ5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YvPD+yu+WA8xtNHBRT7sM46NjEkmmZdZeIwgxAS0+GjVQUcIGNeJ4vkIDa+TKaLe4MewIPMBn0JYjk82AwEaEgdrovjeCO1pEd9fcFcnx5I23GGt7ECPwO6u8x4Zd+hSHvXB+WYNsCpnEXIW4Y2K39VVEqJ8kT4Hkd2v3BLo7I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=cX/KRtc0; arc=fail smtp.client-ip=40.107.74.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIWVaGCG0AndsTWvpOgtj4ADezV3OH7CmEi9dVwH+qTGUzOwqKwt05Y6jjIFnS53o1CVzBd3ItiUgdIixL9+K07oMkgb2e0r7JjeBxtmMH58C9AbqNmGu3W7VtF3kAEQ/U/H/QlLkzlBjSzuew6IkRjAeDYVhHdq8ciM8KHb11s17tJkeQ5Ta+538SZvIZlyG1C3NIhpflhOvBMaQxGLJJ6nmjk6Ro1t6xcZFyz4qykg+gPgcJgg91r29Wxs1gQLOypA/XbY6GDuk/bjSGDqayLoHXgiitvpCZtkiLWBWTHxjE5VM+a0qRi83SQ/FMWHC/B5d9EoxFnIiKcZPzjVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QcMG5gZa0/iUcSClOjYNofzZ7O4wirwOCKU//aFQ5I=;
 b=N2uDpvocfKG9Nu735Glk+/6MlWC05bBWw0TZtb6Fehnf8ygjQ8CXr3OukaE4V/LCoD3w85ddJB5WqVQW2EJEGv6zt+gKxnRQZVksffId0aAPDbmoFNIULCRmwhvhSO4zReV+3T1RS5PCmZ/1TwQm05xQou4Mcm1EdB0P7pth36nV/d1Oxsi8VGS0TrPEBq+fX4IaaZBfug7xNM4PlyEGxUhpzUPfRG248/e3yv+mhJDabaXzyjrukjIwYtLeoSaozFvmUVFrx/lWKQB/6f7RdhplZNhGbSD8NisovqT2uEA+blSDPMjTVuQ/JNwtBF9J21unhkeExqPderQXvRkX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QcMG5gZa0/iUcSClOjYNofzZ7O4wirwOCKU//aFQ5I=;
 b=cX/KRtc0qzzrzILaV3BBOVmmU0rWuGogoBpNRuJluT3eOlW+WYo5EGabxrlu3P8QhQequE7vnDy735s0YzP34eZXj2gyaPyU5KXd8oMgaLGeTzmmjpIQJu4dpjiCia11/OTHAVq4w2B/1Bzn6e5eLfw74HykpYSAdoBb5lIGzAU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSOPR01MB12152.jpnprd01.prod.outlook.com (2603:1096:604:2da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.24; Sat, 8 Mar
 2025 06:29:51 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8511.019; Sat, 8 Mar 2025
 06:29:48 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, Rob Herring <robh@kernel.org>, Ulrich Hecht
	<ulrich.hecht+renesas@gmail.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] can: rcar_canfd: Fix page entries in the AFL list
Thread-Topic: [PATCH v2 2/2] can: rcar_canfd: Fix page entries in the AFL list
Thread-Index: AQHbg3wwxySbXtRqN0i0VotwnX4XtLNn1ygAgAEFZsA=
Date: Sat, 8 Mar 2025 06:29:48 +0000
Message-ID:
 <TY3PR01MB113462D6EF7BDDFE403FD0DC286D42@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250220094516.126598-1-biju.das.jz@bp.renesas.com>
 <20250220094516.126598-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdUs=+niOyBW0us=UjZTnqeYjVsLWZSmROndCO8azER=3g@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUs=+niOyBW0us=UjZTnqeYjVsLWZSmROndCO8azER=3g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSOPR01MB12152:EE_
x-ms-office365-filtering-correlation-id: 11c7efb2-43b4-48f7-ceef-08dd5e0aa02a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SDY5Sk9FZjFjTEE4eUluOXN5eFlQRVp3N0dYNmUySlc2dlo0d0hLclVxMVQy?=
 =?utf-8?B?aXhxcEw1bk1sOXVyamEwQW1JbGI2ZmFMY2g3UDlJQ05ybU9wMW1nOTNqdkY4?=
 =?utf-8?B?REtMR1BtbW1WVk4vVmFTSGY5b0FnejJEajQxbTQ0VlJ5VWdOcnpSTTcwVndy?=
 =?utf-8?B?eExCSGN3NjNFb295UCsvLytTalFzeW0vQlRVOXk4S0huRjgycTAvTGtUZFNw?=
 =?utf-8?B?cFl3bjI5azlqTWkxZ0YrMzRkdzd1VU16R2NjcjRHM0Q4R2JDNGQwUXB5ZjN3?=
 =?utf-8?B?elNueGgzbEdaL3FTZUY4Z2ZJdHU0MUJ6TE1TYUNOQUtQalZNTkJlUUUyVEt5?=
 =?utf-8?B?Z01tMFNPNDNEOWtJdkVuM040QmpqWXlWQ3BoekdNMWJnZ1ZFOVRCQm93Wk1Y?=
 =?utf-8?B?YVJCVTFWcThVa2NtMTBTZEROdGlWNS9icjJkS1lETkNRNlVIbmxoSUMwclhW?=
 =?utf-8?B?RjNrT2JabG5xbXVKbCtLYTdjM3hHUkFpcmRKcU9GR2NGK1JEdzFkdnhtQkY0?=
 =?utf-8?B?MU1OZ3Jod1NDTVNlREI2Qm9Gc2NZWkQrc1p2Vm5SNU5BSmxWd0dOdmN6VXdk?=
 =?utf-8?B?aXdDeUYveExTMUFWaGVFYWtESXE2MDQ5a1J2Rmo1QmlYeXlWNU0yeHlLakpr?=
 =?utf-8?B?RWI0NkJtNnR4U2ZXblhYMXdBVDArMzU1WjBYd3BQM1RCaEdXQzVJWk5kbUpF?=
 =?utf-8?B?ZVd1RFJaRDYyeU9ZTzU1ejF5VFVvRFNtSVZUOGcyNjFtSnh4S3lOVHFFQ0VM?=
 =?utf-8?B?dGtEa01DZW1UQ2ZNZ1YyLy8zYVFtQmg2OWZreGptVXc2ZkhDemVEMm4rQVdF?=
 =?utf-8?B?L0NrQnFLelgrUWwvaGplWldxWkVBcWJVUkI3eUFCY0N3M3h6bzQ2SHRqR2dC?=
 =?utf-8?B?WU5wUmJuT2ZhVGJ1NGx6NGhVQ3Bubnp6RHhxMUJ2TGsramVOV0gvTG1wNEw5?=
 =?utf-8?B?czVlT0xwcnhFcGVYaGdBQ0tVVUVtSTkwRE5KV0svNkpHZU9ESDBOL0VpKzUz?=
 =?utf-8?B?clk2MTl2SnZmdVdVWFRmUVAxMlozREN6MWlvMVZkR2RhdWp5eVM5SGdqN3JX?=
 =?utf-8?B?TjBTakFtbnM3ZlZ4d3Y1Q1R3K29Sbkd6TmN2Y090dFdyQmsrSFN3NGFXVkVa?=
 =?utf-8?B?MmlTcGRCVXFoWjZnUitqa253UERHTDdVcWJaOEUzeEtjN2R5dlBPeDZCQi92?=
 =?utf-8?B?d0FFN0pNeEFNZm5CTWdYeFpwcVpyb2c5VkxDQ2pObEZZWGlNR1BZZzl4NWN3?=
 =?utf-8?B?SUZHc3h4V0FGeGZOQkRNbHZaZXFnMFIrV2hGaE53ZlYyNEZqZnNzRHBCWll2?=
 =?utf-8?B?QnFQaktIL0V1N1BOWEs2RkxYTGpqZE05b3Naai9RT3h0L3hENW5NV0ZJbXR0?=
 =?utf-8?B?cDc2djFxWmUwQmM2WmJPZm5PajU0QmRBdGFaNjhKVUdkVHU1dTkyZ3pJRHhj?=
 =?utf-8?B?MjRKMHBXUUVTTFRMbytLT3ZVaGRqbS9TQTVOdTFwMWpmM3pueHRhMkVaVmY5?=
 =?utf-8?B?NjN5QWtmTlEyWitML2VZQmFmRDkvREhtYWdkMWRSaWJaaGFVSXVnNHR3T0Ra?=
 =?utf-8?B?NVBBNXl6aHR3dFV1S3NXN1JPem5UTEpWTUhrVm92M291aUJMWFBScXJXYkZX?=
 =?utf-8?B?TmJDY1Q1L2RFTWpnMFhybkZta2ZRRzkvQVFFVGM2cXVMdmRpZ2NMa0R5MXV3?=
 =?utf-8?B?ci9TWUI5aDhxYUhjSkNNbjhqL3JuZmR6M2ExMzJlMEtCVGJQMGtTdDdOZzl2?=
 =?utf-8?B?MHpsSG54dEtFRURuNmsvSXB6d204R2g3UFNPd2UrazhhOWVaZTNwem9saXJM?=
 =?utf-8?B?SytkSFE2c1FHY2NXVDNJbUFOSnYwS0xPRENDMnlsNGJTMC9vZURzM1o1SXZj?=
 =?utf-8?B?NDZRSi81V0VURXVJdml0L1FoQXlSSWowWE1JZXRiNW54QTZCZkR1WFhSNnhw?=
 =?utf-8?Q?SQc6LVaumGBl/fOfHLCk7IG5qM70ssRQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2tmVk1YODhmQTU4Qk8rcHZWYUNEaHhHU2pVNTAxc0hjbFo5MmNSb1NDbUhG?=
 =?utf-8?B?azl5WTV4SkZFRVd6S3U4UXlnWHBncFJEQU1rKzdqa25MeXFteVR0ZGFiaW1l?=
 =?utf-8?B?UlNyQVlqcGR4TmF1NS8zS25Gbms0dnIzanZIc2FPNFphNmhPUGVvTVV4eDgr?=
 =?utf-8?B?WGplUWpjeUtUelpaWUpHQThPNkFiTUxhR1NuVUY4MnJPV2xzd21yNklwUTdq?=
 =?utf-8?B?aWl3UnhOVnNsVGV0SEN4YWJZUUlqQlloNEFMRSsydXZjNjJ2cVlLVmIwTlZr?=
 =?utf-8?B?dDNJdDdLTXpxTGFxN0JBTUlITUwvak51ZjlzOHhZdW5ES0JQV1F5OGczL2tS?=
 =?utf-8?B?M1ZQay81NzFFTDR4OFY2WGE1Kzl4RTFid1pmUm0yaXozOVVKWi9XVVdkTFlT?=
 =?utf-8?B?MzBqTTNVZytPOS94SXl2MmNnWWQ3Y2tGcGp2bTVsUlBLSVl6L2pFekdQdE5a?=
 =?utf-8?B?RmZkbEM1SzZ2M21EemRmdXFaWjhFZjVLUG0vaTI3UFcxRjlqdVQrbXhxNXR5?=
 =?utf-8?B?aU9wU3Y0VlRUdm5qbzBPNkFDSXhNMzZRNHhlVVAvRW11RU83YWN6UkRrM3lV?=
 =?utf-8?B?R2FwUjVhMURPRWtTR1p4dXh2Z2VaY1ZjU21neWdxL0lkNWlITXN1TCtQRmdp?=
 =?utf-8?B?QUJIUkswcHRqQzNIbVdhZE9wSWN5TC9lQW9EUWUxM1R4MHRTcmM0Y2xicWRN?=
 =?utf-8?B?V2tQRG9jNlBZSjVsWFU5ak1DUG9oVkUzNEZCeEVHbEZVNytCNmFFVnhCZTBX?=
 =?utf-8?B?bDBOeWc4TDliRnlMcUttNnlmc25HNWcvOW00aXE2cHVKOVYxVUIyZEtTQ0VJ?=
 =?utf-8?B?Rmp6QVhKeFlPSmRUaWxQNWFoaHdzRTI2amZSM29lay9uTElvM3RoMS9DTlBH?=
 =?utf-8?B?YnJrMDdYRTdIWTFOTUNOWWp4bW9ZbnZnUEE5Q0oyZEFhL21TS3VGcjY2TFdz?=
 =?utf-8?B?UU51Y29DdnVYcWZ4amcvMzVzMFdWZDU1NTRNREJIUnpmL1FITkhxem0zT29z?=
 =?utf-8?B?dGdta1FKblpMTHdpc2JYQU5scDJlOHZ1c3J4N3VCazZrK05DbDMvLzUyRjRN?=
 =?utf-8?B?aFlXNG1MRlNFSW5iNk1wSXZMa2d6aHI0aFA3eWRHZUd5M09EVnhTU0p0SDNr?=
 =?utf-8?B?djNnTDhTSVJ5R1RqZ0pWcGJKTlRtcE1oVCtUNkpuRWxvVityMEhzWmJRNmlM?=
 =?utf-8?B?RXFWeUxyaUROQnFKeFNmU2NiZHROSDRSYVJiWXA1T1ZmNXFQUW11YlBnQTVY?=
 =?utf-8?B?TFBYTUhQUHdzZ0FWM3RubVMxMEplMUU2bG8xYko3cmpYRm5BeDZ4SG96TkFZ?=
 =?utf-8?B?ZUhhRUREbVlMSm5neEp1WDV6U0xXbnpXNm82bU53dTBiWEpvdi9Pc0FVQlZy?=
 =?utf-8?B?Um8xbi9kb2NmZzF2K0UwNU94UHZjWk9DUU5VRXhvbDdrZWVXMGJ0Y3FOTk5m?=
 =?utf-8?B?bGxYaUR2QnBSZGx5R25Tbm1ZczR3QkpnVlluMTg1dGhNL1ZYeVQ1cUJTTWoy?=
 =?utf-8?B?VE4xYXNvRnhROWlabjFYODRQcnE3VGl0cHJBdVFPN1lqY3JNcTdsZE9iMlBN?=
 =?utf-8?B?NFdVZEdVdVkwM2FnSTYyUFE4S3JqV3U1T20yUitWYVFQcG5FMzUraG1DdnJN?=
 =?utf-8?B?Mjg2V3lCRllYejlqRWZLRGpBTHB6QU5BZjMzK2NOVU0yNjB3bklKcGI4ZGZj?=
 =?utf-8?B?OTJMZjFncllwS0NYeFRHNFRrcDlGVFB6VUpqQ25Ha1B4bDVzMlFNbEZ1dTZl?=
 =?utf-8?B?NzFVU1NNWE05bTI2MTIzckFzTjZCQzJOOXk5WjExYnNTcGJlOFlNYnBBNldl?=
 =?utf-8?B?MGhqZnNYSjJSby9NMFVuTzdRMEs2TVhyUkZiK1V2WnBudUd4eE5vNGNpL1M0?=
 =?utf-8?B?RkorNTdsNWJqclJINXJrbFJzRXNnd2MxaERXajJxdWNnZ1hFYk1VS0xjMit4?=
 =?utf-8?B?TFE5WEtjKzVHTlRxdEJjTlR1ZjQyZlVjYitybG9vcVduWTh0VzFLS2xlTzBi?=
 =?utf-8?B?YS90SlNZVmk5UWt2QmlXRFBOMzBRVnJiZTJSK2VKSlUxa3k2STBZWGVqN2dQ?=
 =?utf-8?B?Zk8yS0lVMDNwcmhSS2xZRDN3S3NjNWtYUlMzRHNpdCtMWHBnVnZ3MDlZYmtL?=
 =?utf-8?B?b05Ncm9pNjBGYkFVQTA2ampPT05PTWpma0dhbnpPa0I5UHBwOWxsZElqT2dX?=
 =?utf-8?B?Y1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c7efb2-43b4-48f7-ceef-08dd5e0aa02a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2025 06:29:48.6275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4avG0+UqK3u6HbfJpLZdOg2JSHzOfGcg1cCSZA++1oBX731s9h86re2LmAUmBOQD4hUoqzjI4LW+53rIztLVuKfF1uCCCCwbgOwhIH1aZUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12152

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogMDcgTWFyY2ggMjAy
NSAxNDo0Mg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvMl0gY2FuOiByY2FyX2NhbmZkOiBG
aXggcGFnZSBlbnRyaWVzIGluIHRoZSBBRkwgbGlzdA0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IE9u
IFRodSwgMjAgRmViIDIwMjUgYXQgMTA6NDUsIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5l
c2FzLmNvbT4gd3JvdGU6DQo+ID4gVGhlcmUgYXJlIGEgdG90YWwgb2YgOTYgQUZMIHBhZ2VzIGFu
ZCBlYWNoIHBhZ2UgaGFzIDE2IGVudHJpZXMgd2l0aA0KPiA+IHJlZ2lzdGVycyBDRkRHQUZMSURy
LCBDRkRHQUZMTXIsIENGREdBRkxQMHIsIENGREdBRkxQMXIgaG9sZGluZyB0aGUNCj4gPiBydWxl
IGVudHJpZXMgKHIgPSAwLi4xNSkuDQo+ID4NCj4gPiBDdXJyZW50bHksIFJDQU5GRF9HQUZMKiBt
YWNyb3MgdXNlIGEgc3RhcnQgdmFyaWFibGUgdG8gZmluZCBBRkwNCj4gPiBlbnRyaWVzLCB3aGlj
aCBpcyBpbmNvcnJlY3QgYXMgdGhlIHRlc3Rpbmcgb24gUlovRzNFIHNob3dzIGNoMSBhbmQgY2g0
DQo+ID4gZ2V0cyBhIHN0YXJ0IHZhbHVlIG9mIDAgYW5kIHRoZSByZWdpc3RlciBjb250ZW50cyBh
cmUgb3ZlcndyaXR0ZW4uDQo+ID4NCj4gPiBGaXggdGhpcyBpc3N1ZSBieSB1c2luZyBydWxlX2Vu
dHJ5IGNvcnJlc3BvbmRpbmcgdG8gdGhlIGNoYW5uZWwgdG8NCj4gPiBmaW5kIHRoZSBwYWdlIGVu
dHJpZXMgaW4gdGhlIEFGTCBsaXN0Lg0KPiA+DQo+ID4gRml4ZXM6IGRkM2JkMjNlYjQzOCAoImNh
bjogcmNhcl9jYW5mZDogQWRkIFJlbmVzYXMgUi1DYXIgQ0FOIEZEDQo+ID4gZHJpdmVyIikNCj4g
PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFz
IDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBwYXRj
aCENCj4gDQo+IFRoaXMgZmluYWxseSBmaXhlcyBDQU4yIGFuZCBDQU4zIG9uIHRoZSBXaGl0ZSBI
YXdrIGFuZCBXaGl0ZSBIYXdrIFNpbmdsZSBkZXZlbG9wbWVudCBib2FyZHMgYmFzZWQgb24NCj4g
Ui1DYXIgVjRIIHdpdGggOCBDQU4gY2hhbm5lbHMgKHRoZSB0cmFuc2NlaXZlcnMgZm9yIENBTjQt
NyBhcmUgbm90IG1vdW50ZWQpLCBzbw0KPiBUZXN0ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8
Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQoNClRoYW5rcyBmb3IgdGVzdGluZy4gDQoNClNvLCB0
aGUgZml4IG5vdyB3b3JrcyBvbiAzIGRpZmZlcmVudCBib2FyZHMgd2l0aCBjaGFubmVsIG51bWJl
ciA+IDINClJaL0czRSBTTUFSQyg2IGNoYW5uZWxzKSwgV2hpdGUgSGF3ayBhbmQgV2hpdGUgSGF3
ayBTaW5nbGUgZGV2ZWxvcG1lbnQgYm9hcmRzIGJhc2VkIG9uDQpSLUNhciBWNEgoOCBDaGFubmVs
cykuDQoNCj4gDQo+IFVuZm9ydHVuYXRlbHksIGl0IGRvZXMgbm90IGZpeCBDQU4yIGFuZCBDQU4z
IG9uIHRoZSBHcmF5IEhhd2sgU2luZ2xlIGRldmVsb3BtZW50IGJvYXJkLCB3aGljaCBpcyBiYXNl
ZA0KPiBvbiBSLUNhciBWNE0gd2l0aCA0IENBTiBjaGFubmVscy4NCg0KDQpRMSkgRG9lcyBpdCB3
b3JrZWQgd2l0aCBkb3duc3RyZWFtIEJTUD8NClEyKSBEb2VzIGl0IGJ5IGNoYW5jZSBpcyBpbiBz
dGFuZGJ5IG1vZGU/DQpRMykgRG9lcyBpdCB3b3JrIGlmIHlvdSBqdXN0IGNvbmZpZ3VyZSBzaW5n
bGUgY2hhbm5lbCBieSBjb25uZWN0aW5nIHRvIGFuIGV4dGVybmFsIENBTiBkZXZpY2U/DQpRNCkg
aWYgeW91IGFyZSB0ZXN0aW5nIGluIGxvb3BiYWNrIG1vZGUsIGlzIGZhaWx1cmUgaGFwcGVucyBD
QU4yLT5DQU4zIG9yIENBTjM+Q0FOMj8NCg0KPiANCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4v
cmNhci9yY2FyX2NhbmZkLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2Nh
bmZkLmMNCj4gPiBAQCAtNzg3LDEwICs3ODcsMTEgQEAgc3RhdGljIHZvaWQNCj4gPiByY2FyX2Nh
bmZkX2NvbmZpZ3VyZV9jb250cm9sbGVyKHN0cnVjdCByY2FyX2NhbmZkX2dsb2JhbCAqZ3ByaXYp
ICB9DQo+ID4NCj4gPiAgc3RhdGljIHZvaWQgcmNhcl9jYW5mZF9jb25maWd1cmVfYWZsX3J1bGVz
KHN0cnVjdCByY2FyX2NhbmZkX2dsb2JhbCAqZ3ByaXYsDQo+ID4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHUzMiBjaCkNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdTMyIGNoLCB1MzIgcnVsZV9lbnRyeSkNCj4gPiAgew0K
PiA+ICAgICAgICAgdTMyIGNmZzsNCj4gPiAgICAgICAgIGludCBvZmZzZXQsIHN0YXJ0LCBwYWdl
LCBudW1fcnVsZXMgPSBSQ0FORkRfQ0hBTk5FTF9OVU1SVUxFUzsNCj4gPiArICAgICAgIHUzMiBy
dWxlX2VudHJ5X2luZGV4ID0gcnVsZV9lbnRyeSAlIDE2Ow0KPiA+ICAgICAgICAgdTMyIHJpZHgg
PSBjaCArIFJDQU5GRF9SRkZJRk9fSURYOw0KPiA+DQo+ID4gICAgICAgICBpZiAoY2ggPT0gMCkg
ew0KPiANCj4gVGhlIG91dC1vZi1jb250ZXh0IGNvZGUgZG9lczoNCj4gDQo+ICAgICAgICAgICAg
ICAgICBzdGFydCA9IDA7IC8qIENoYW5uZWwgMCBhbHdheXMgc3RhcnRzIGZyb20gMHRoIHJ1bGUg
Ki8NCj4gICAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgICAgICAgLyogR2V0IG51bWJlciBv
ZiBDaGFubmVsIDAgcnVsZXMgYW5kIGFkanVzdCAqLw0KPiAgICAgICAgICAgICAgICAgY2ZnID0g
cmNhcl9jYW5mZF9yZWFkKGdwcml2LT5iYXNlLCBSQ0FORkRfR0FGTENGRyhjaCkpOw0KPiAgICAg
ICAgICAgICAgICAgc3RhcnQgPSBSQ0FORkRfR0FGTENGR19HRVRSTkMoZ3ByaXYsIDAsIGNmZyk7
DQo+ICAgICAgICAgfQ0KPiANCj4gQWZ0ZXIgeW91ciBjaGFuZ2VzIGJlbG93LCAic3RhcnQiIGlz
IHNldCBidXQgbmV2ZXIgdXNlZC4NCj4gDQo+IExvb2tpbmcgYXQgdGhlIGFjdHVhbCBiZWhhdmlv
ciBvZiB5b3VyIHBhdGNoLCB0aGUgc2FtZSBjYW4gYmUgYWNoaWV2ZWQgYnkgdXBkYXRpbmcgc3Rh
cnQsIGJ5IGFkZGluZyBhDQo+IHNpbmdsZSBsaW5lIGhlcmU6DQo+IA0KPiAgICAgc3RhcnQgKz0g
KGNoICYgLTIpICogbnVtX3J1bGVzOw0KDQpzdGFydCBpcyBub3QgcmVhZGFibGUgYXQgYWxsLiBJ
IG5lZWQgdG8gd29yayBvdXQgZnJvbSAiIDEwMl91Y2lhcHJjbjAxNDBfSVBTcGVjX3YxcDA2X3Iy
LnBkZiINCnNlY3Rpb24gNy43IHRvIHVuZGVyc3RhbmQsIHdoYXQgaXMgcGFnZSwgcnVsZV9pbmRl
eF9lbnRyeSBldGMuLi4NCg0KQ2hlZXJzLA0KQmlqdQ0K

