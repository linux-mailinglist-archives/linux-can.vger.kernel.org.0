Return-Path: <linux-can+bounces-2839-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304E5A39B23
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 12:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189B51893C8F
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 11:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A1823C8BF;
	Tue, 18 Feb 2025 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="g7je9lbU"
X-Original-To: linux-can@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011029.outbound.protection.outlook.com [52.101.125.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BEF23C385;
	Tue, 18 Feb 2025 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878819; cv=fail; b=Jk4kPWuzxaNiAvtADwKJbPYACsQbCavHlNkhQqiuZYVUHgY/M2suyEoLYPe35uMnTreQtESDMUdcfk+wzld01c+NeaYsDiL1IerYeKlPysmELz+lf3aW/l50WnAcsWWYdKQAJHeHhiv3rMdTs25So+Pwvw43GFs1EiRM60w8x0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878819; c=relaxed/simple;
	bh=aJb11v1ZpN+RzdXOr20Ttm/cnZratszco8wF2pPlcAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cHHn2iIrHjVL3FlKE2hZ+d/GRv9CcjwPrQok4ulK0scZ3iQS2QIZFAnv5IPpmToL1MSkcqnysehV6/UiTUDPp2LfxBhiiWldYdLWDttss5VrErgCChiSnA8R3TOY0QN0leOgyYw//5YIyr5GnITaoXbpCR084l6NJTnkDRWJz2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=g7je9lbU; arc=fail smtp.client-ip=52.101.125.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUn11RzhdyI4HN5uS0Qq1fVJ7qoM58UuoA2RgbFzpQAN8dnwKhrI42qmhlo7B5zxoeZuQCt/9zOtX4KrtAMpc8ZTQGHAA+NNp8Dv3EVz6ykYKwGo5Zpd+KTJJdAaV4iV9nxynGu/AzNvq9sbbQ4IaiSIwOZUr9czsYzzxZ/S8chbBUufReML0anSpV4VuTCmdC+NyQHyJpxW4aXat7ZLmbW1wVdIacIwYWaTlTfRi5U24+L/weZWs8w7O7xCUBw48D+PwpfAPnkBSOIuT4i5e8olQiP3Cqf4dINAcCMsMFYMEh8w5CJ83fbFNxWQg1yvITIG/0nLKc18FeLCBnYGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJb11v1ZpN+RzdXOr20Ttm/cnZratszco8wF2pPlcAA=;
 b=t0D2PRovPG45b5h3q3Wp8ljmVPcHacE2qEWFXDxIHtKL96SvwH783IUQ8dr48tUhMDEwCFe94dUTAAHK0o6hxYtiVgqoS2RLA7lPR5VjNTlnPYhiTdWnfMRRJwxZJ19Q3IPJHsN7+CAfHXLKf8Sar+kcTBmGYUtjaulrVsu1lmibQsxLa+eE80RL11er6w1f7581+Ui6NvK45rwCl109/gzs8hfjMmunmlftBoMHvJA0EJiQEIeJuL4AnBRp7ic4urh4UmVrhADg7U3hT2umCn2Q3H6H+WVW2SiB9l3gaIuJawvKDRylTZwnKPWnp1odkxcf7glkR8Wcaap3XC9lcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJb11v1ZpN+RzdXOr20Ttm/cnZratszco8wF2pPlcAA=;
 b=g7je9lbU/sFjahSASUBZUTwa2pU2owpjl/r4LWGcNzundEdjUwV29EDaVP1aLU4cQ47yRdUpjuokNgv4yF7e86rvZ6vs78eU9LNcbcvWyTTV/AwGVUc/f/MzWVDA9xLtTgnS9RFTn6t9z8/S6J+d1B/4ByvVv1dmTTViT9xvqIg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB15173.jpnprd01.prod.outlook.com (2603:1096:405:27b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 11:40:11 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 11:40:11 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 09/11] can: rcar_canfd: Add RZ/G3E support
Thread-Topic: [PATCH 09/11] can: rcar_canfd: Add RZ/G3E support
Thread-Index: AQHbgfL6a05DN6esc0iFKPSK7jEG5rNM6sWAgAABajA=
Date: Tue, 18 Feb 2025 11:40:11 +0000
Message-ID:
 <TY3PR01MB11346C280850B3EF33C052F6086FA2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250218105007.66358-1-biju.das.jz@bp.renesas.com>
 <20250218105007.66358-10-biju.das.jz@bp.renesas.com>
 <20250218-voracious-wise-rabbit-ec8e49-mkl@pengutronix.de>
In-Reply-To: <20250218-voracious-wise-rabbit-ec8e49-mkl@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB15173:EE_
x-ms-office365-filtering-correlation-id: 8600d6d1-d31b-4f99-36ea-08dd5011009b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QWI2Ylk0eG9WMUZuY0YzS0xFM1RYMjJKVDlNZzEvbnJaQ25YYVVSTmdNREJI?=
 =?utf-8?B?dnhxTENRY1U2MEp6R0MrZWtPMVJHTGdxVG9ITHZkMUtJWDBESTlYOGpvVEw2?=
 =?utf-8?B?ZjAyVTgvR2ZUVmYrWEUrMlExS3FGMy9TRE5pQTd1akRVY3NBQnlQYWVVdzh4?=
 =?utf-8?B?TjNpUGtnYjRDRHBKanFhZW9ld3dsRlRNSEtPaUg2dXJRVjJBcHBnMVFOc0ox?=
 =?utf-8?B?MFlMaEhGanF4N2pWVzcyb1FDY0R0VjJ3bXo0emJ3WERVSkZvWklhK014cTVh?=
 =?utf-8?B?UjE0RFZ0TEZrWmRsNDVlSUlOd0RaRHVncSt2bXZyYWk4VHBsMXRkWjAzSzJP?=
 =?utf-8?B?QUljZTkzKy9KbGpNdGFmVk9DRlY0TFloazFuM29hMkw1cHFPVlR6YW51UXUv?=
 =?utf-8?B?LzVmWEIybnprTGZUdW1oQ044RUhTY3VOMkVxSHFpVjF2dTJwZS9PSzZsdnhy?=
 =?utf-8?B?c2xtQXhGZWEzU3NjOUdRY1dTeXhvZmxad2dwaTM0dHNmamZFSTJmaS94aGdx?=
 =?utf-8?B?TGVXTjRDYzZMOThvNGdjL1UrU25uYUROU21mUVBWMWJvOUhiL1NNWXh0MnBS?=
 =?utf-8?B?MkgzdzdjSmpZejhDYm1NeWdDaGE1OTljS0lkS2NNOUphcGUvb2lPSkdNNEhK?=
 =?utf-8?B?NENOREpWcEUwcjN0UXRjcWJhcG5CbkFGa1pIODdIOG5NM0UzeTRpSmJsY3Ux?=
 =?utf-8?B?NVdWSmp0eUE4Q3BaVHd2cGhURk9BYUlSQzVNamVvVjFtc2ovdXRUL0Y1RkdV?=
 =?utf-8?B?YXBnTFFGSm9VQVFvdm1rZExlUG1pVWJBSDNFd0VESHBMdXBDZnY4U3lML1RB?=
 =?utf-8?B?VG55c3FPY3JuN1BzTkpNWVRCYlpWRklNNHJYY1p5c3E4VzZ5dmFybGxWbi9o?=
 =?utf-8?B?SnN0Sk5sYzJGRlk1M1U3b09HK1BWaExEUk8rak42N2EvRmdLK1N6Zytsb2F3?=
 =?utf-8?B?dFhGbEF6eUNXK3AzYlptSkJDc2hPdkdlRWFLZFEra083RXZwKzVsYWprcEJj?=
 =?utf-8?B?ZHBoVlVUN2ZDdHVOZXhHVlZ2ZXJXOXNNTnNyNFEyeE56N1pEbSt4RGlScmI3?=
 =?utf-8?B?Q3JSbjkwcXVXQVVRVHFxUEorSlNWU291a0lWTkxCUWtKYnVqN1J3YjloQ01p?=
 =?utf-8?B?MnhVd0pYQWNBOTBhOHlWRmxid200QnliN2NydVZBcUxoSzBGcVVwaEtDbE5P?=
 =?utf-8?B?dTVLYytSWWV6MXE3emIxcHNNNXRhMGRmU0RFcUdJUTR1Tk5UenFObkdTMEpl?=
 =?utf-8?B?OU9ocVZhRGxEbkUxU3VEcGxIMWZ5STQ2aWpDdXZzYzNRRGJWWE00UXNYQjdT?=
 =?utf-8?B?YmtNcE12bWs3VXVvVHJudnBTZ01PcFFpaTFsVlhCemRHUDVvLytmRFhyUGwy?=
 =?utf-8?B?QlhpY0hibTB3ZzVZdEU0c09zYXM4QWl2Z1c4UXVIZXorMDRobXR4UC9MMXYw?=
 =?utf-8?B?SCtuZmpSVjkvUXpGKy9FaFB4c1BIWkNoQTdUSEdoZjcrckUxait5aVJyUEJp?=
 =?utf-8?B?M0RkRTA3WW1BWU1pT3NhWERkU21IVGhkSVRvK3lFeG15KzJhbGNrMlhmUnVI?=
 =?utf-8?B?MG5iTWNTT2RqL1prZW0yQnhQNHV3R0JxdFZXeUhUeE5VeGExNzNiOHkyTXJ2?=
 =?utf-8?B?dHQzaUUzbENhbi9zSVY3YWN0V1JNVnYvbGlERXd2Qm9SbTJ3VVJXWmpoTHJB?=
 =?utf-8?B?OVBpQURzaHJUSW5FSHNxdEJ4OS9NSmdXRmRBeFNPd1dhNnpHenp2Ull2Zm5s?=
 =?utf-8?B?cDNqVW5pMG9YaWNwbXBTVXp4TEc4bUl4WllUbkhjYUo2ZGo5dHl1Q2RncVYy?=
 =?utf-8?B?V0pyQklaV0UrTjdqbVhxT2hXSVZtMGEycnE5Q0oxNHdWSmFjODJOL3pvOC9C?=
 =?utf-8?Q?toCa6b5epAXPc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dldDODRPekh5TXM5S0hqTDMzTE5iSEx2QTZ0bm92UTFvQWJycEE4aVVsbDFI?=
 =?utf-8?B?UXRVaDNGeEZZeXpUWnJFNWlsaVZrVXNmYm82RlNXRTNVUTVaYW9XWit0ZjVp?=
 =?utf-8?B?Z0h3U0xRMTA1ZTJJOWt3ZW9rTjJSMlBkejMwY2hjVERPbmFZSUJjK0lJVGJh?=
 =?utf-8?B?TExsR1B5TEpoUkdJdm8vQ2ZROUgySGF2SXFobU9NN0xCOFMvZFZxQ2J1OEFj?=
 =?utf-8?B?bnNYU2RYV3ZaU1pPRVgwQ2FMaS9CQVpzYmpqeDhqYjZTTmxPeUxPTk9Ea2ds?=
 =?utf-8?B?L2VSdXVhNWc0anh6aTY5d3RmbkFzc0ZRVmpkWUIxKzVwYzJES0JKOTFDeThO?=
 =?utf-8?B?eWxZdVNhL0QzNTZib2Y0ZElwa2V4Z2VTUjB6NTFvZWsyQXpIRU5vV3d3WW9s?=
 =?utf-8?B?NHJ3K2c0KzBzb3dYa0h4d2NPQ0U3T2lVa1RXSS83S0RTbytPUktDRHE5dXp4?=
 =?utf-8?B?S2U1U1djaHFxSGZxazMyT1Vtd0o1Q3ZmT2cxVzFtSUIvc0RudWY5d1NXWXZC?=
 =?utf-8?B?UTc0TlVpdzBjTjMwdmZHU3E1RUR3NmNLRVc2eDdZdEErbDlpQ0Z4NWM4U1Fi?=
 =?utf-8?B?THFFSnBkWWt4SFRvSVNpUVdvUkxYdGVQWVlGMkxGQjJHR3pSQW9SWVZRT2lq?=
 =?utf-8?B?d1dJSk1ZbG1XbFZyaGRwcWRPQzRVcTY3VWh5dDNBQ3BPbTZ1djkyNXc2V3U5?=
 =?utf-8?B?Mm1JTkRLcVhOamU3TjVXMU9hRXdBdmtNY1VjckUxZ0w5VTl2MDFteGJwelA4?=
 =?utf-8?B?a2ZwU0VQNFcyR0NBckRVTmg0RXJMQnFid1dSYzZjUnlCZWhIUmN3NzJEMEtk?=
 =?utf-8?B?ZVNEQzl5ZUlQUzg3dm80N2sxZnVHbDdZL2JyU08xcVMvSzhCdE9hTXhNbiti?=
 =?utf-8?B?NjljM21oMDloUDZyY1FCMGdJMDFWWXhkM1hTVVZWekxUNVVONjdMYkQ2MFpJ?=
 =?utf-8?B?aVd2NncxaDNMQS9ONm5RaFNGdHNkaDl4c1BmT3RIek51QTNDRXpTUnhtN1d0?=
 =?utf-8?B?RSs1TStkc2xvVXUrR0VzS3F5dUVWbi9vdU1RTEgydXpBVEFxYWJkZHpmSnFr?=
 =?utf-8?B?OWE5dGxHOXJBejYybFR6S3R4dEpSQ055ay9MNnhlSnpiWXk4cGNyZ2pMWU16?=
 =?utf-8?B?QXdIbWFoNURzcERndENtWS9Udnl1Y3U1d2xrVTlyc25hQk9uS09WWDMxSVg0?=
 =?utf-8?B?cVlqU2VsSmNnQTBvaGgrK2pRQ0lleWVsWWx1QS9tN3hsNkVaRllodjQvbDNq?=
 =?utf-8?B?UytvMSt3YTdpZHJlZHYyazB0ZWJ0VWwyTEoyZ0tTOFl0dW5mN3F2QWV2dzdD?=
 =?utf-8?B?c3AvU0E1d2dHWHpiME11eEdIYzZCYzM4bjk0NHNtbmJPWVJmN2IveXZyMVNH?=
 =?utf-8?B?RGJlbHlvMGUxdE9LaGU3a2MwRmhGL3VONnRwSzh2ZzgraTlHREZkc3VyZTk4?=
 =?utf-8?B?eWp3T2lVakxVMUovUENiTzNoUG5mU0U5SVIzZWJvVDBPaGVOalNVY1A5d2E5?=
 =?utf-8?B?ZzdUcmQ0NFZ3SUVQdVdSTmJJRkRQUmhqWUVXMk42VHBXTkpSaWtlWnBCT1Zq?=
 =?utf-8?B?dlliZmRqdFBRWXBjT3VHRU5QWXBGM29BZXBNci84Sm14MDhsNElreWcvUG9h?=
 =?utf-8?B?T0dBU1AxSVJqRkZTV1VvbmRlTTRwS0pBbk84WmlzTGorVHp6ZjlrWVB6WWxY?=
 =?utf-8?B?TExzWUdZQzdVVHZBL2xtT2JUWmlXZG0xcitueXZzK1RuR2E1d3luaEFhcmJ4?=
 =?utf-8?B?Vld4Um5pZ2hVUENuelJZQlJSMnBqR1QyK0E0NW1ySTFraVkzbUs3WEdva0tj?=
 =?utf-8?B?SnJTM1dtcytXUHBVSXhqSThoVWJ3RDVabWtaR08rSU92dFlFY1BWcTd5RFlo?=
 =?utf-8?B?djl0ZGs4Z3ZZcTkxeUthMFFkYklXNElJTisycS9wTFBSVGNwNHpucWtxVWVK?=
 =?utf-8?B?Y0QvcVY5OVpiLzZMa3Rna3BkazBJSTc0YWtLMEJlV0NOSU5FYUcrS0dLM25n?=
 =?utf-8?B?cFFWSVNsMnZYQXZFVDFDMzBIcTZvZUsvVXJRK050cFJXWUhGNzMxMS9nS3gy?=
 =?utf-8?B?RGY4Y09ZeHBNSGVjWUtUaGNUWTNDdTZYNDA5OU5xTkZHd29mZDg0ZXg5Mm1V?=
 =?utf-8?B?WmpKa0o2WEl3S0FjQUIvcE03OWpvTjhtTWJTbUx1bEp5VG1LbmljMC9KYitY?=
 =?utf-8?B?VXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8600d6d1-d31b-4f99-36ea-08dd5011009b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 11:40:11.0888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tRlvY77BKsWvqc+nrBr5Ve8c6Tfg1EbfP8aeD+uRBtcdSvCVrQRgiBFGG8jNzgbw6NB2hT2Hp+AIlfGAZsaAdAQhAftFal7niC7V/LKhUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15173

SGkgTWFyYywNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5k
ZT4NCj4gU2VudDogMTggRmVicnVhcnkgMjAyNSAxMToyMg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDA5LzExXSBjYW46IHJjYXJfY2FuZmQ6IEFkZCBSWi9HM0Ugc3VwcG9ydA0KPiANCj4gT24gMTgu
MDIuMjAyNSAxMDo0OTo1OSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gVGhlIENBTi1GRCBJUCBmb3Vu
ZCBvbiB0aGUgUlovRzNFIFNvQyBpcyBzaW1pbGFyIHRvIFItQ2FyIEdlbjQsIGJ1dCBpdA0KPiA+
IGhhcyBubyBleHRlcm5hbCBjbG9jayBpbnN0ZWFkIGl0IGhhcyBjbGtfcmFtLCBpdCBoYXMgNiBj
aGFubmVscyBhbmQNCj4gPiBzdXBwb3J0cyAyMCBpbnRlcnJ1cHRzLiBBZGQgc3VwcG9ydCBmb3Ig
UlovRzNFIENBTi1GRCBkcml2ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8
YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2Nh
bi9yY2FyL3JjYXJfY2FuZmQuYyB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+IGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9j
YW5mZC5jDQo+ID4gaW5kZXggZDZkN2JhM2U5Y2ExLi42OWNjZDY5ZjY4ZGQgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gKysrIGIvZHJpdmVy
cy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gQEAgLTYwNyw2ICs2MDcsMTQgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8gcnpnMmxfaHdfaW5mbyA9IHsNCj4g
PiAgCS5tdWx0aV9jaGFubmVsX2lycXMgPSAxLA0KPiA+ICB9Ow0KPiA+DQo+ID4gK3N0YXRpYyBj
b25zdCBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIHI5YTA5ZzA0N19od19pbmZvID0gew0KPiA+
ICsJLm1heF9jaGFubmVscyA9IDYsDQo+ID4gKwkucG9zdGRpdiA9IDEsDQo+ID4gKwkubXVsdGlf
Y2hhbm5lbF9pcnFzID0gMSwNCj4gPiArCS5nZW40X3R5cGUgPSAxLA0KPiA+ICsJLm9ubHlfaW50
ZXJuYWxfY2xrcyA9IDEsDQo+ID4gK307DQo+ID4gKw0KPiA+ICAvKiBIZWxwZXIgZnVuY3Rpb25z
ICovDQo+ID4gIHN0YXRpYyBpbmxpbmUgYm9vbCBpc19nZW40KHN0cnVjdCByY2FyX2NhbmZkX2ds
b2JhbCAqZ3ByaXYpICB7IEBADQo+ID4gLTE4NjEsNiArMTg2OSw3IEBAIHN0YXRpYyBpbnQgcmNh
cl9jYW5mZF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJdTMyIHJ1
bGVfZW50cnkgPSAwOw0KPiA+ICAJYm9vbCBmZG1vZGUgPSB0cnVlOwkJCS8qIENBTiBGRCBvbmx5
IG1vZGUgLSBkZWZhdWx0ICovDQo+ID4gIAljaGFyIG5hbWVbOV0gPSAiY2hhbm5lbFgiOw0KPiA+
ICsJc3RydWN0IGNsayAqY2xrX3JhbTsNCj4gPiAgCWludCBpOw0KPiA+DQo+ID4gIAlpbmZvID0g
b2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRldik7IEBAIC0xOTUwLDYgKzE5NTksMTEgQEAgc3Rh
dGljDQo+ID4gaW50IHJjYXJfY2FuZmRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCj4gPiAgCQlncHJpdi0+ZXh0Y2xrID0gIWdwcml2LT5pbmZvLT5vbmx5X2ludGVybmFsX2Ns
a3M7DQo+ID4gIAl9DQo+ID4NCj4gPiArCWNsa19yYW0gPSBkZXZtX2Nsa19nZXRfb3B0aW9uYWxf
ZW5hYmxlZChkZXYsICJyYW1fY2xrIik7DQo+IA0KPiBUaGlzIHdpbGwga2VlcCB0aGUgY2xvY2sg
ZW5hYmxlZCwgZXZlbiBpZiB0aGUgaW50ZXJmYWNlIGlzIGRvd24uIERvIHlvdSBjYXJlIGZvciBh
IG1vcmUgZmluZSBncmFpbmVkDQo+IGNsb2NrIGhhbmRsaW5nPw0KDQpJIGtlcHQgc2ltaWxhciBo
YW5kbGluZyBhcyAiZmNrIiwgd2hpY2ggYWx3YXlzIGVuYWJsZWQgY29tcGFyZWQgdG8gZmluZSBn
cmFpbmVkIGNsb2NrDQpoYW5kbGluZyBsaWtlICJjYW5fY2xrIiB3aGljaCBlbmFibGVzL2Rpc2Fi
bGVzIGR1cmluZyBvcGVuL2Nsb3NlLg0KDQpJIHRob3VnaHQgcHJvdmlkZSBzaW1wbGUgaW1wbGVt
ZW50YXRpb24gZm9yIGluaXRpYWwgZHJpdmVyIHN1cHBvcnQNCnRvIGF2b2lkIGFueSBwb3RlbnRp
YWwgcmFjZXMgd2l0aCBjbGsgYW5kIHRoZW4gbGF0ZXIgcGxhbiB0byBlbmhhbmNlIGl0DQpsaWtl
IG1vcmUgZmluZSBncmFpbmVkIGNsb2NrIGhhbmRsaW5nLg0KDQpDaGVlcnMsDQpCaWp1DQoNCj4g
DQo+ID4gKwlpZiAoSVNfRVJSKGNsa19yYW0pKQ0KPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2Jl
KGRldiwgUFRSX0VSUihjbGtfcmFtKSwNCj4gPiArCQkJCSAgICAgImNhbm5vdCBnZXQgcmFtIGNs
b2NrXG4iKTsNCj4gPiArDQo+ID4gIAlhZGRyID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291
cmNlKHBkZXYsIDApOw0KPiA+ICAJaWYgKElTX0VSUihhZGRyKSkgew0KPiA+ICAJCWVyciA9IFBU
Ul9FUlIoYWRkcik7DQo+ID4gQEAgLTIxMTIsNiArMjEyNiw3IEBAIHN0YXRpYyBTSU1QTEVfREVW
X1BNX09QUyhyY2FyX2NhbmZkX3BtX29wcywNCj4gPiByY2FyX2NhbmZkX3N1c3BlbmQsDQo+ID4N
Cj4gPiAgc3RhdGljIGNvbnN0IF9fbWF5YmVfdW51c2VkIHN0cnVjdCBvZl9kZXZpY2VfaWQgcmNh
cl9jYW5mZF9vZl90YWJsZVtdID0gew0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJyZW5lc2FzLHI4
YTc3OWEwLWNhbmZkIiwgLmRhdGEgPSAmcmNhcl9nZW40X2h3X2luZm8NCj4gPiB9LA0KPiA+ICsJ
eyAuY29tcGF0aWJsZSA9ICJyZW5lc2FzLHI5YTA5ZzA0Ny1jYW5mZCIsIC5kYXRhID0NCj4gPiAr
JnI5YTA5ZzA0N19od19pbmZvIH0sDQo+ID4gIAl7IC5jb21wYXRpYmxlID0gInJlbmVzYXMscmNh
ci1nZW4zLWNhbmZkIiwgLmRhdGEgPSAmcmNhcl9nZW4zX2h3X2luZm8gfSwNCj4gPiAgCXsgLmNv
bXBhdGlibGUgPSAicmVuZXNhcyxyY2FyLWdlbjQtY2FuZmQiLCAuZGF0YSA9ICZyY2FyX2dlbjRf
aHdfaW5mbyB9LA0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJyZW5lc2FzLHJ6ZzJsLWNhbmZkIiwg
LmRhdGEgPSAmcnpnMmxfaHdfaW5mbyB9LA0KPiANCj4gTWFyYw0KPiANCj4gLS0NCj4gUGVuZ3V0
cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAgICB8
DQo+IEVtYmVkZGVkIExpbnV4ICAgICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0
cm9uaXguZGUgfA0KPiBWZXJ0cmV0dW5nIE7DvHJuYmVyZyAgICAgICAgICAgICAgfCBQaG9uZTog
KzQ5LTUxMjEtMjA2OTE3LTEyOSB8DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2
IHwgRmF4OiAgICs0OS01MTIxLTIwNjkxNy05ICAgfA0K

