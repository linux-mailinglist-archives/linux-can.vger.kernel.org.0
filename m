Return-Path: <linux-can+bounces-3098-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D080A630B8
	for <lists+linux-can@lfdr.de>; Sat, 15 Mar 2025 18:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942DD179451
	for <lists+linux-can@lfdr.de>; Sat, 15 Mar 2025 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B24D202984;
	Sat, 15 Mar 2025 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="EGWuaPTz"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010056.outbound.protection.outlook.com [52.101.228.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A5417995E;
	Sat, 15 Mar 2025 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742059589; cv=fail; b=iPxQAPU8SYzVNdh6/5pX/qDckQuysbII2Zf+knJMbxvTrgyQ4ArlpvWDRs4vki5orMPXmYxxyw+QAR9YCOWUlGJDBEZSk+wWqEbXgtspPnp7fIZV2y/FIVUHkc4cJ7nVMRDgwwrPgDYm0XyualSFzcviBp911nOuRE7iZAZ+fNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742059589; c=relaxed/simple;
	bh=xpxQfn+I3ClsOHReDXMh8GQMoCKpCl3Laz2TJ/DCAdc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OW34JqpEQlKQyYAxSgR2mGyORWp0xtSbFKvlpeTeS40+9Of0qqfMg7tfeTA+l0Mmf4Bwu1jgp/zckRIHeInS3dQvoEPFtz+brMOPkMMhczSJTO2BzGFJ5RZdYsJsQFSjb7rNNiXYFHyjX+ssWxxr4+fjgO0xa9V/8Q/DKBha8Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=EGWuaPTz; arc=fail smtp.client-ip=52.101.228.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDAf29jfyvjG+GYzCfjK9hZCmcno2/cktBJrQz8/CRK2tT59opFbHjf1UA8a0NWRXvco5GebUYan0hkX6I3JDq9sGTv+tQaAuylbO8FbH32i/pnKAn2E+8FGOI2k3/cuggeqeK9bc/IDbUJB59N+I18DtiwuMZqboKQiCR5vnnWRhiWq25DkrTvXYE1cixF7QY8LGCkoFJQUpBAjEQ4tXNkz9ez1krn8R7wDUTXpcI1vIA4q6pgMXN1xGVZCjLDW8xwOj9gPUwrIiEyDqrYKt11m6FMjRHChWGM+FW5xOWUEcXJZHKNtgXoYnnKQLrxrL1uUlBgtqtmWthJF3gDh7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpxQfn+I3ClsOHReDXMh8GQMoCKpCl3Laz2TJ/DCAdc=;
 b=BzNANLPcrEM02OULQmStB/yPW8E9RlPCDZVBFJVPGXeyChNqyBMsF3Dcv49DEdfQ5OxAPSd9PabWlo5NO2DKCgIx1GMzENJ4LCV9kR80RR9AVzlcxik3E+LhI6Zg12pNR5Dq0XhQEy1+8e78d/qocIym9Cti3vsU4uprjIxQeuiVPM8jRXUOTExMWM0iK+yOVE/fbagT9YjyzQJaeACQq+5IyXeBp5tbGTEemX2pKFou9MPsj8+d73lR4LvO+Fk1B09eiam3Xn3nF7VInss6zNmdyI1qAV43xCYSnbMKDSPQjVoqRHwjr0mYd9m3W81npscLtF3+0OjTAMSbHsurGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpxQfn+I3ClsOHReDXMh8GQMoCKpCl3Laz2TJ/DCAdc=;
 b=EGWuaPTzJsPCKHWWFFfAi+lopsA6C1qcC07H7cUmwth7xX+GGiuTX86Bb3f0NaHFiTLe35IE0biQHNr47EKOhd8yD/lD17tgDXWsC/SbWVsjgqPGNlMx83eX1Qgh2DAzMq3fdkQUgUUA4TguK5vyEh73IM/zqEimBVnLGSBlTJ0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8193.jpnprd01.prod.outlook.com (2603:1096:604:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Sat, 15 Mar
 2025 17:26:24 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 17:26:24 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 06/11] can: rcar_canfd: Add register mapping table to
 struct rcar_canfd_hw_info
Thread-Topic: [PATCH v4 06/11] can: rcar_canfd: Add register mapping table to
 struct rcar_canfd_hw_info
Thread-Index: AQHbjpVcJUCErPHnwUKCHDG2Pbp7/7NywqsAgAG+t8A=
Date: Sat, 15 Mar 2025 17:26:24 +0000
Message-ID:
 <TY3PR01MB113460652A397915A89850B7086DD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
 <20250306124256.93033-7-biju.das.jz@bp.renesas.com>
 <CAMuHMdVP6H3VkZN3ZbxK=HiGi544nzujVs6sKnUX585r6kScEw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVP6H3VkZN3ZbxK=HiGi544nzujVs6sKnUX585r6kScEw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8193:EE_
x-ms-office365-filtering-correlation-id: 5792b519-25ec-4026-532b-08dd63e682c3
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFlxbGlmRjJ2ODRCRFgvMWN1cjV1Ynh0U09RMjhxa3dNcXZ6eXlkcHVZL0dq?=
 =?utf-8?B?amEvaU8zbXBud1Bac1kzZ0d2djVJQjZiZlF2Mi8wTnFoMUpPU3VXN21mZ05S?=
 =?utf-8?B?RU9JWTRNTlc3cTVNcmhBWitqSlZHWkpiVHNhVExhVjRHUzZub0JwY2JQTVlT?=
 =?utf-8?B?UTlnYTFnbytrb3NLamYvS1Q2d2RPaGpEb201RWxnQmM0Ky9hbjBBRkJWMWRD?=
 =?utf-8?B?TkRFWURZNXNreGZYVkwxWmFYdCtkSEpCVXV3WnNJODhsQVNpdks0VkVUbGRh?=
 =?utf-8?B?Rnlwc2IwdkUxYkM0dEpqTk0valUwS3RtVUk4ODF5N21sZnZ0dHlBR2NSa01T?=
 =?utf-8?B?QW10NU1rL09ydWpIZHhLaUtsRDM3ZzhJdFozWktJUFM1NG5sdURjK3hKTGoy?=
 =?utf-8?B?R21BOWpoRkhqeW9XNGViTTdDMDQxSXhPYzVjRXBpbEI0U0swUUhGdVBCMUhO?=
 =?utf-8?B?Z1FSRnpBWEF3U2J6YS9oMURCU3ZkSVhJbHlCSzUxNFcwM2s2MkRVVXVlQWhv?=
 =?utf-8?B?cktnOGJYVVkzZXprN0J5LzFYcWVTVi95TWJKd2Z3cm9DZDFpc2xML2MvWS80?=
 =?utf-8?B?cEJhOEVLdHVXdytTZFA0aUYzU2pGTWFSYWtOeXh5VWhEb05aV2VNTFRzOVQx?=
 =?utf-8?B?VTlWQm5RdUYydzYxaWlNMEVwU04vR3BYbFRtTGZ2WGUwNDJHdkVHcjkyaGhZ?=
 =?utf-8?B?VUw5YWRvOCtva01hTmMxS3hNOXBja1Q3WUkwS3ZaVXhCdFV6bFN6cS9pcVd3?=
 =?utf-8?B?UHJkVFhmckp4cGwrSG9VVkJEZDE2ZzA1eXhGamt6cWhlNjlVQzI2L0VWU044?=
 =?utf-8?B?TDhLZTJRMVdqU050Tkc1NTRPZ1k4RWJic3BscmNRSGFqQTg4ZkdZMGRDNzEw?=
 =?utf-8?B?aEV4cFNkK0RrVFN6a25rb1lMNFhBZnVwYy9BamtrcWkxb1BqeFVIWHlLSXk5?=
 =?utf-8?B?bDdMUmJNTWRXUUFrbTFxbW1tbEpCeFdVUlVad04wQVcwUjVlU0NEaVpmeXd1?=
 =?utf-8?B?OHF3c2pKeDg5MmlIRExGdC9PanVPSU5yeUhTZlFTMkF3ZU5ySXR4UWh6N3Zz?=
 =?utf-8?B?Q1dUMW9RVGx2NFJEVVhINVVwTld3bFA1aXAvVmJIZGJkSEVvV3RTdFpjZWYz?=
 =?utf-8?B?b0FTdXRhQks4cWFqTG9kcHJOcm9kUjZCVXAvZUorZUxWdzdpVHN5ZU4zRjFG?=
 =?utf-8?B?ZlZDcld1dWF2RkY4WnBGWG1hNWVkOXhaQnUwcjVodGRSVHhTejF2M0twUm5p?=
 =?utf-8?B?b1h2SitDcXI0RHZmTkZHRVV6cWRXQ0dqY1hYTjNpWFJHbjVGTGUwZ1R6NjRZ?=
 =?utf-8?B?T0hFTEdZeUI0TGpFMHZKb09Oc1BDQUVMOTBkZ1FHbjZRNSttaEk1NkNxSnd2?=
 =?utf-8?B?SDZUbUU1S0NHUWsrMitNcThoaTBLaE12dzhxd2ZRRTdFdEsyaWNyeTNHSlg4?=
 =?utf-8?B?dDZ6WnBBK2RXUWc4WGEvZTB1TEpackp5KytZaUlQYTNTV3EvSmxUMXluQVc2?=
 =?utf-8?B?bnlqb0dDa0xyeDA0dmtPKzZFdVc1bS83djhwWmxaK0hsdUZteFhaWktJWXZx?=
 =?utf-8?B?SHlFU25CeGM3MHRnWmYxdW8zcGdTNUZRcUJRalAzdDdScUNMYXFML0FMaVR3?=
 =?utf-8?B?TEhicTlWdm85MHNBbUdVTWwvZ2QrcGh1aFdYUHc0RnFlNlAwdlZ2ZVBXdDVJ?=
 =?utf-8?B?QVhpTytQazZnOW41ODh5RW02T25FclFlM3JTY2lsMzk5d21Ic01Xb1dMTjF1?=
 =?utf-8?B?OWIyNXJEa3pxVXMyTUh5bEQzaElpanFWR2RVdlczaGI0bDRBanNJbm5IVkE0?=
 =?utf-8?B?RzNWQzVKN2xjRjhFVE5KSUZ0NkJHOXprT1YreHhWb2kzRTBiOUhmeDdYK1pE?=
 =?utf-8?B?SDlvVmN5ZGZ4RFFUak1EdkF1Q1V6V0FzTzQvYnJnUkU1RUphcDBjQTFTcjY2?=
 =?utf-8?Q?p+52T2dG4BQa+CtOFAbBkg/TGjk3CMY6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVQzRVJMVzh1aG1UTXRrMXIrYS9hRktld3dpNk9kQ016NW00ODJwcnhTWWRK?=
 =?utf-8?B?UGlSNDVrMGxmQXRwYkhZa1ZRc3F0UGYxbkdlMlNFY01UZ1ZPa3pMSk9TdWl0?=
 =?utf-8?B?eW8xQTFuNFVXT2dJM1ZmR1luSjVwN1BabzBhdjdscm1ibUhEaVp1S0QxMjJB?=
 =?utf-8?B?UHVGcTdUcnVzMGpiU2VGdVRSQzNabXhnWGFsS3VOM3BIV2hJb1pPNzIrRFlo?=
 =?utf-8?B?U3lNS2ZuQnlVYU5uKzJrdGNRakgvZVJlenoxYS9ONXVOaVRZKzdBUWpzOE01?=
 =?utf-8?B?N25MUXFqalBIOGdmN1JkL2ZxYWxuanM3RmhOSTRaVXhwUEpybG8wWmhWY3l6?=
 =?utf-8?B?cWxIQ0RoYkFqdHRBTzJzRW1zSllRVUFOU3BYeVJVUGdRUENMWGZMMWl1ak9n?=
 =?utf-8?B?L0NMYlN1VXd1cUFOMTRjMjhycWo3b0J6TmwzVmtGWGFhWUw3S2MzRS9GUC9q?=
 =?utf-8?B?K003VTlTMkxHU1NBOXpmZ2NsekY4dExVcGVnNmRqY09VQUVzUjNodnBHc3Q1?=
 =?utf-8?B?M044Umoycmh0eXlpa1pQLzVlQm10MHFBL1N6dTg2Ykk4QWtPTkhrazNocWdW?=
 =?utf-8?B?SWZzME8xeWFibjJxY2E0d0JPUkxxTVdNcWZOZ0hMV2ZFRUM4YXlVbW82N1NM?=
 =?utf-8?B?cWd3NHA0eldKeklvL3kxS0ZWQWU4UHFEZGZTL1dRVXJNajBqckhQNVk3WHQr?=
 =?utf-8?B?S2dJcDMwMDJra2VFaEFCRjRtM25UR0YyOXY3WGZVbVVHS3RhUjZ2VUdtbE1t?=
 =?utf-8?B?bjFzY3I4em9Hd0pzRGVJZU9xVk4reG90Q1RKMXZiM0tRdnRKOE9JRS9tcGNh?=
 =?utf-8?B?QXRYVlFFRDNwU3lGSDRGOEk5N0FWMno3ajBQQThSTGFQa2o0TUJTeVFENXlS?=
 =?utf-8?B?UCtUWFVVYmJsZDBDTHFHZzJmY2llRlVKUmdSMHR4TW4ya1A0V2oxaXhBTm1H?=
 =?utf-8?B?QjRubE5TWWhUR25BUzllSStYanRoeldzbUM5U2ZmbWJiQ3o5RzQvSkdpRDZi?=
 =?utf-8?B?ZjRJRndrYkJRU1p3Slo1Vldha1hNVlNOTXRjQXpBQ1Mxc3JpNUs3UEN1WkM1?=
 =?utf-8?B?RENhT3pCU2ZWZGRpTU42Wjh2OW1CY25rVmpCMWN5V2ZPeXdUSUFCUm9TcHY4?=
 =?utf-8?B?VldLSVdKOXBxQURFeHg4bGhJbUNUQXd4L0Vtelp0bzFqYmlDL0p1dzZNZTdE?=
 =?utf-8?B?cEpyeFd6K09JNy9wczRZdmR4bTJSOHdiMjFUVitRbGdVa0NCYzdHUTA1enZr?=
 =?utf-8?B?aUJ2MGhDMFoxME5hTk1Ga0R6bmFRT29TMnFHN3VHQ0Izd3ZwSHI1cXlEd3Qx?=
 =?utf-8?B?d0pBYmIyMVhRZWVKdDRYTVhSeVJUS0hReUNDR0JYS2I5MWExWGgyUlFsK2Ny?=
 =?utf-8?B?d2YrOFFyZ1RGSXUwczNheGJJVmJQR0w3ejZOYktyVytSTXdkWVZpWGI1cGpX?=
 =?utf-8?B?UHFtK0lwTGRqQnNyc3lwRDVqbWpzaXJ1dFhNRHI3L1c2QTFwRFhCMytDblpM?=
 =?utf-8?B?RW1BTVNsTm5zdzFXanpUN2xJQitxY3FWVmlvR1FWQlh4OXR6QkVYTGtDM1pG?=
 =?utf-8?B?Y0YxZ2hzZHFtYS9xelZwdHhSSkcvVWN1ZE1remltbVZwM0dVSisyRk1UNEpB?=
 =?utf-8?B?S0xhanZJcDN3WTVkbDhBcnFzS1FJSTJNWVJCRzhwaklZSmVqUUw0RW1qU1I5?=
 =?utf-8?B?ZGtPYllqZ1ZtOXJocDJsMG4renV3RXJTZnZYalZDVjhiM1dKZ0tibWJRNVZG?=
 =?utf-8?B?N3prTEI4dENxTWZwUktWT0d5VFJ4SjYydHNObmxYVmNSVWhPenA2K3cwU0xo?=
 =?utf-8?B?V2IrSHFBUVRDcUJzTm5XOVlFbVQxbXBOQXBHTGVtYkc4WGp3ZXl3a1pTQkVU?=
 =?utf-8?B?SnBXcFFLTys2Nmo3eVF3aUxDNUpwWHpSb29aTTlRZmhQQWxMWVN3WFo5YXNn?=
 =?utf-8?B?RGluMm5XViszaU5nVDZFMjhrZ1U3ZnRYcGpsTmlYY1BiVFNqSFkzRDVodjdn?=
 =?utf-8?B?Rm9tbEpNc2VoSDZRdlFmbGdZdHkvNUM0ejMzdGJtZE11TmNHUzZqekxFak9I?=
 =?utf-8?B?N0pyTFZlanhpc09Qd2p5ZW1qVU12Zmp1TXFEajNLOFdYWDhTRm84dHFHUi9w?=
 =?utf-8?B?cUhTcyt1eUcyOVJiaFBLNmdRVkdZVUJyMVlpZHNmQmtCZ2VPdkJyTUlKSXpj?=
 =?utf-8?B?M0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5792b519-25ec-4026-532b-08dd63e682c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2025 17:26:24.3444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bUkTRWPT1lvObEIVEiqCmV3Tbb6wfAMbuSIAo4JVhV3bZ/agCZyYwOF5S3Y9FcV5D9ivBRujtz9TglfOUodO5GhOhFZJnG8orNnhanQ+dmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8193

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogMTQgTWFyY2ggMjAy
NSAxNDo0Nw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDA2LzExXSBjYW46IHJjYXJfY2FuZmQ6
IEFkZCByZWdpc3RlciBtYXBwaW5nIHRhYmxlIHRvIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8N
Cj4gDQo+IEhpIEJpanUsDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiBPbiBU
aHUsIDYgTWFyIDIwMjUgYXQgMTM6NDMsIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2Fz
LmNvbT4gd3JvdGU6DQo+ID4gUi1DYXIgR2VuMyBhbmQgR2VuNCBoYXMgc29tZSBkaWZmZXJlbmNl
cyBpbiB0aGUgcmVnaXN0ZXIgb2Zmc2V0cy4gQWRkDQo+ID4gYQ0KPiANCj4gaGF2ZQ0KDQpPSywg
d2lsbCB1cGRhdGUgY29tbWl0IGRlc2NyaXB0aW9uLg0KDQpDaGVlcnMsDQpCaWp1DQoNCg==

