Return-Path: <linux-can+bounces-3212-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066ABA715AD
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 12:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3163BF5FA
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 11:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1081CF284;
	Wed, 26 Mar 2025 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="CLCj4OAZ"
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010051.outbound.protection.outlook.com [52.101.229.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FAA1C84B5;
	Wed, 26 Mar 2025 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988185; cv=fail; b=iUwEIrFOhA1fDVG2rTrYGcr/K3TbT2SBwSSkN/zTf+H5EcP5cYYlggE6fXxslOpEQ/2/JXA4JWpQk9kt4R4MPAv3FGzc0KGyUItKFzwW2FnoIcPuujJ2Bh6rsrp0RnkNSU2UqzWUiSn05waWZHMMgksTdTnyQR+2JuLb06wagmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988185; c=relaxed/simple;
	bh=NYfj4H1G4f7/bH+8LH6+2hcERgJ75Rms48FqfZitvxU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ChyX4GCDzpta/ILhH4WufLyE4tkjq+vLTS4BSaOpbaaVCQqNam7EOarM2w3vwUiXrSnlyGjuqpTf7esCw0f3SvpZUVCjfIpQRoBYaYHzEmKa90COv6st9JYdwkl0tnp7giyloFWd9ni7kQz8kdf/DfLwKPYxsbnXtswqESqrsD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=CLCj4OAZ; arc=fail smtp.client-ip=52.101.229.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRJMdhp0V3RWpUd2NhZdV35WiyMt9bMHuKNe5vesEG2hnKEMm7OjyRh2iFqLAtFVVwgcMSKr7wkVM9zrOjlyyxlcVlIa+n2mXdBkIBQ7HUOkqWTjbB0chQ6Uk3zOCidugj6pKT3Mjakx8JZACEF2rjYuW8+VEzezDZJobZZSWzJQV3f8ZuZz10xxf9NC/BFGAze9JHSuWzwmXM6cbNWGLyZkMAZN5FGlaOHNCOr9VziYG4eEjOCtADY9Lt8+aw4gR6NVuNC+smMUuGtC1wi8VQF7h1uOJvmk+khO8enMsn1mcyYTfCl47G5GRzATG84DPcvJxhB026sUdSDdHktxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYfj4H1G4f7/bH+8LH6+2hcERgJ75Rms48FqfZitvxU=;
 b=Bu9BOWDNqE+ht6oWgwVg/vuTodqloWBe3dYjb93Fm7TiNaeaGWk0yT8r7X4kg8ypxONLa7ud+KqNHic3T3G5X2wNycaYhlDbMNd5Hibd6BEA8FgH8S25TRAqnnD66dboax2CSpbsT4Pg+vFR6aqA3v79pQX3nVVo8vplGRaHH7nGVhS8gmq5mE00zdH7/izpeMtnOXQ6GsPd7/Op42xOGUOPIufavcAtlJMlw8QvFavlCs2JsIb/Z4YB70/wm9hnQnQmbj5zeC4OsWSD8OsddhUhP1tfTnE1RTSLA5zg20MhWaf6xMFKVb7aJ4iNyhmFfBUDmvr9dYoaT1OODbrZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYfj4H1G4f7/bH+8LH6+2hcERgJ75Rms48FqfZitvxU=;
 b=CLCj4OAZSIThyMdrB0HS1La59nrjXiPJTmPTgqT6VbZi8frj/HVyuV6/pu1ErXdRy0KwRsAwwr2ip7hO1JX/MCLlepQLWO+zerkG6uWZMd9Whlua+BtV7zadgTPkY3bWJ3rLJLkWSTd53Pi+gPj+jNpDBpjbOjeujlUXjCcYaas=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB14544.jpnprd01.prod.outlook.com (2603:1096:405:240::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 11:22:59 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 11:22:59 +0000
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
Subject: RE: [PATCH v6 11/18] can: rcar_canfd: Add {nom,data}_bittiming
 variables to struct rcar_canfd_hw_info
Thread-Topic: [PATCH v6 11/18] can: rcar_canfd: Add {nom,data}_bittiming
 variables to struct rcar_canfd_hw_info
Thread-Index: AQHbmXggU/r8KM1HbEurfuJ4kkOr9rOFM0IAgAAcfeA=
Date: Wed, 26 Mar 2025 11:22:59 +0000
Message-ID:
 <TY3PR01MB11346B0E1D47571CA3445C81A86A62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250320091101.33637-1-biju.das.jz@bp.renesas.com>
 <20250320091101.33637-12-biju.das.jz@bp.renesas.com>
 <CAMuHMdVVtR8FiP3_k0zwqDpp_-pkm5J0Xh=KPedcf1-cRhBpwg@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVVtR8FiP3_k0zwqDpp_-pkm5J0Xh=KPedcf1-cRhBpwg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB14544:EE_
x-ms-office365-filtering-correlation-id: 6b76c8f5-2298-4da6-4ec7-08dd6c58909d
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MEtIWTBKeFhzQUJMNmtreS9tVXhOL1ZsUVhpcTZsZnVGZ2g4eHUxQXN4YzdD?=
 =?utf-8?B?T1BKNXdqTlp4TmFTbnVUb3kwaGUzSldLdzN1a1dESFVNTXVHOUtsajFCWGlK?=
 =?utf-8?B?a3dpTk10VnZNZTRhOVpuaVVnTmh0enRKamtlQUk5VDZtWGgwM2ljd0xyTkJS?=
 =?utf-8?B?azBPWCtzTlVBYTB2eTFGVVlObmgyMEl6SDlPT0ZDUGJmWU5mazU4NzBoY1hL?=
 =?utf-8?B?QVlJRXZkT0pLRkExd1NOQWtaL01zeEhLdjl2VmkvQm1hdTVuUHVyei94Z3RX?=
 =?utf-8?B?U0ZueDg2RSs0cUU5R1pDcWh5SFNGaFZiOVFIM1Nac200OE8zaHgzcytuR29N?=
 =?utf-8?B?YldqaGM5UlJKODZHREhqV0Z0ZHpJMzRRK2pRUGp0all4bTRDRC9QaUhvY292?=
 =?utf-8?B?eEIvSDE2ZzNYNUZDZ0NxS09kSURoSnpQOFpRN0Y4eW1jblNBbDBoZ3ViYURr?=
 =?utf-8?B?dTZkc1pPazNNbkdlQjFHQkE4L2pCOEx3MnM4aTZFN09JR3BpU3FWWW5MbW1R?=
 =?utf-8?B?a2NSNlR1RjF5TEh6b1RPOG8xMnkrd0Vwb1p5RXljN0pOaFd3OC81SE1pY0tN?=
 =?utf-8?B?UVVOVng0bmRoLzBWUU9SSGdXQVk2N2l6ekVKT3p2RTlyRStXMHU0NzljVi9M?=
 =?utf-8?B?Q2ZJQUdwV3B1UlBtTHV3U3ZBN0hKZ2d0aGxOb2ZSL2NiQzhSWFF6Z04xd3FL?=
 =?utf-8?B?VHY0WE5PTkp5N2xPYzFmT0RSN1VaSXNtM2tWRUtyd1l5azh0TUZXc09JMURH?=
 =?utf-8?B?akJGNlJGQXlRQVBxOTNrbUVZSVVzU2sxaVJxajlvYTRoeFo2NHFVNy9HWmVJ?=
 =?utf-8?B?UFZ6bHpST21TVlA1YmVSaDBvWmt0YVp3MTJwalB1YWJualdMaDhGVzRCY3pk?=
 =?utf-8?B?K3hpYnhUZzRVYm9uTUNVeDBLZ1dPU2hVdFRhQWlWbU5aRUoyQ1dZT2hSRStp?=
 =?utf-8?B?ZG45TE9oemhmNkw4d01DWkp1R0dXME4wTjBkc0RtUnM4NzNlYUNHMUFKK0tE?=
 =?utf-8?B?ZlpTczROUFRPQXBPTFlGa2ZvUUlxRXI5WXNoZ3ZSb0I2dW45TXJJQzRtUjRX?=
 =?utf-8?B?UXJWM294QmtWM245b1IxWFg1WGllM1ZDc1kyYjljdFZzdU1KYnM2NVFuaTUv?=
 =?utf-8?B?VXNVNSt5LzBSd0l0Y0hmbWg3Q3dONnFaYzRQdm5GdlVzL0QwU3ZwK0FYUlBs?=
 =?utf-8?B?b0dhc2NUVGZFZnBwc2hrRHYvN2liWHF1cERrd0NEV3dRVXhNN1hVanRncURN?=
 =?utf-8?B?OXRSdGNpU0FraWpnanc5UTFjYTUrU1Q4NW9UQnhia3FwK3VFL1VaRnhsZHRS?=
 =?utf-8?B?ZjJzZVM4SksyUGQ3MDUwc2M4U1dCZzJVY3JhbUx4U2tHSElqMVA0VG9nbEhV?=
 =?utf-8?B?K2RYWmtwMjdVanhpT0ZRQWpBTEpoQUpmcGVzR1hkMFpXb0VTMnI2SytITlMx?=
 =?utf-8?B?dEpSaVFSTFpGcmZFQWJYZ1ZMV1ZacW9LQlBjSDF1TFhDUy9tYmx4VERXUjNy?=
 =?utf-8?B?Uy9SQzI4aHMxYzRna0JrSzFRYmM1Z1pXditjdllDVDJ4cGsyME8zZ1BvTEts?=
 =?utf-8?B?eWRQZlB2K2hHcXFlcHlUMVNhQmlHOHdDS1QzRTF3eWZOaDliMGVBQUw4Zzky?=
 =?utf-8?B?VGlObytnVzMvRHRGeFRGSWxqRXBjenBRd0VhRGxNQjVKbmlhdUN6UzlKU0Fn?=
 =?utf-8?B?dG8xUjdXbWxPWXB2V1kxNjFSRnRxTTJJRDdKaS9keDlQaXhXTVBobjhERUxv?=
 =?utf-8?B?Z2k1NGZVbHA5WHUrVFJ3SVNQMlFWcm05OTZBUElzcUorK3h6U0NmQWhHZ2NG?=
 =?utf-8?B?SThkTlhTNjlsTzRERWIwWXA1RDJSUDd1TjVvMEJramR3bVUzZE1mc2Y5VzlN?=
 =?utf-8?B?MkJ1cnVscEZ5bGtWb0JXOEx5VnFic29VcUtVVjZOZFVKa1BVa1U1UVZOZTF5?=
 =?utf-8?Q?Q7OksFhPaRlYxYpi/TXNjcJZNVh41a2Q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTlwREp6Y2htZ0dzR01WMzhRdkt2L1ZwenBYaWRNRU5yZk15alh3TjBIYmhi?=
 =?utf-8?B?RHNIeXRyaDVqMDI2UVlYcXIySmtUSmphNWMxSEo0ZUk2NC9SQmFlOTdKWFRM?=
 =?utf-8?B?NENwVGRyNjNjcnZXWWhLbWdvWGZPK3dHby80MnlJdng3dHlIK05ySThWSXUw?=
 =?utf-8?B?alE3VjBlVWx5Y0hRNVVNT3pLSHE1OS9XNFFza2F1NTFXQVd4N0FXZ1FlamZu?=
 =?utf-8?B?bTJnZ3JpZ1k3UmxkNE9yMHNmcHdUY2hrY3RhT3NuWjlJWEJWSVUrSStZZDhR?=
 =?utf-8?B?NkI3QVFIT2RXMDZDSyswaHpPUDhub1g3d1JJWmowdVNBQ2ljVVVvWTIxcWUy?=
 =?utf-8?B?RmZnWFF2V3JtN0hjN3FiVys3WUVOU2xKbmJUOU9rVGdOWUtGRUF2RFd6aHEx?=
 =?utf-8?B?eUJ0SStOc0l2R3ZMYTZRVCtQUUMxZkRESHYyRlJnRW1kKytPMUt1dUdaMXB6?=
 =?utf-8?B?cXEvaHl2bzNrNjMxY2VhZlhqVktsd2IyeFVxSkdMWks1S1FEQml6Qit2cXVz?=
 =?utf-8?B?U0dOT3JuUHN1ajBkTWcvdWg3cVI3S25pak1tVFBudCtsVmU3QWFHUWxDUWlJ?=
 =?utf-8?B?Y0dPMUM3TWdYTFBRbG96SWlCQ1o2cmorVDZscUxYTlpxeDlaaVkrU0tZWjVM?=
 =?utf-8?B?aXZIMm5pR2xZMjREZkl6WWRQOGhZdHpUSUlQRVdzU3VLVmY1S0Nnd3VCQTRH?=
 =?utf-8?B?djhpMmpVaFAzUVM0UnVzanFBK05DeXdiOTdVNXpCbkswMzJrVjZxVWJPaHFW?=
 =?utf-8?B?Z0NDL3hHV3BPWW9iaVFSbUhUMjhqOEI2U0x4NWhleFRBQU1ld2NQdk5ZVDZz?=
 =?utf-8?B?Q2E0V09UcnZoem1mSGJuUmpVSXQ0M1lwWmdEeDdLZGFCejlmUWtsejhCdFdT?=
 =?utf-8?B?b2JzbHU3NUpjc0ZQblpwL2MydU9NQmpDSVRoWDNNbjFIcTczalJpSXhuRU9o?=
 =?utf-8?B?enpFeEN2aGZVc2Z1aWxoTEYzZEUwd3NXTHduQ0g2L3UybVVOUW12cWxoMUxs?=
 =?utf-8?B?eUFDbUNtNzUwZm1kTy80QU9TL3NuWXRhR1l1UTFGZ0UrOE13NG5SK00wVUJG?=
 =?utf-8?B?dTAzcjhaRDZpL0dXdXA3LzhXTzBaRHphbkxPTGpiNDArT2FzMkt6NFlHV3pU?=
 =?utf-8?B?WEg2YjRCaWZyZGoyTDZuOUpqMWRTN21UTHM1ajZ5NTV3bVFGTnhncjluRER5?=
 =?utf-8?B?dlBmVGZ3L0NmcDQ0MGl6VG51NEdBcE1rdXBsdEZzK2RqbTM2b3VQWndIR0JL?=
 =?utf-8?B?cjgrOGp5TUFtcW8zeVJnUTdWZjExZzdBMXlDK0lDVUtYZm5KN252TjJmcmtC?=
 =?utf-8?B?akp1VmJWdjNRejMvbmU1ZG1wSXpDRDczU29pb2lvQnRuWlgwV3ZTYTEvUCtp?=
 =?utf-8?B?QmE2VWI5aURNb1VHQkd5SUdGUy8xRU5Zd2xQdjBnUnhFblIrVEIwMy94MWlZ?=
 =?utf-8?B?REt1UzN3MFBTNnF5M2NaQjJJNGMxUzNDTmdXU1pWbk0vNmxybzZjVDVzT0tD?=
 =?utf-8?B?K25BVlUxU1lpMmsrQmVFZm41ay91cnBiTGMyYnRSbzhKbFRBcU9HeTJvYm9I?=
 =?utf-8?B?TEJaYVMyTkZXK09pUlZlZ2FKSVNZRjlyalRhYUtCNUR3NGs0QzNxSFVGSHlC?=
 =?utf-8?B?Ly9kTFdRV1BjQzhmanN6d1NOY1ZtTWk1YVIrNDdtbWtWUGZod3dkRXBDUmJy?=
 =?utf-8?B?d3dUSnBoOG5YSWtJSXQzT1hBYlVZVmZUZERIcXZBVm5yM2Q2c01NcENidGQy?=
 =?utf-8?B?YmZrSi9XME9JNVBXRlVwcGJUeEUzdVB6VGZQaVBNV0luNkM4bjJvbVQvUEN2?=
 =?utf-8?B?S3p3djYrMytxS3F2a3ZXOTM5UGZkUHY1bVhuM0xNek45UWVpTzZVV1lxcjQ2?=
 =?utf-8?B?NlBHWEZMT25KLzdyVjJhZ0lMVThIcFdYb3lQVU02dFpVWGRyT29MK0Q5Y3Iv?=
 =?utf-8?B?czQrRjVqRFpjU0J2VjE3VUttMGoyRThMdnl2WDIwU2xBVHFyTmRxa2l6YTdi?=
 =?utf-8?B?RThSWTAwQyt2Y3BCVDBlTUU3dU9Vb09WSW5GOWFqMHJKYW5FdkFiRXVNRHZa?=
 =?utf-8?B?MWpxMlVuaDNuUkZsTHp2a2pGQ29JeCtmdHdzd1ZXYXczWDdaOEVwR0ZScGcv?=
 =?utf-8?B?aUZrRTVZZTBCWnNpL1JYekxldGhHS3p4aVBIbHRQR3RyRzV0T1krZGtzT0dG?=
 =?utf-8?B?eVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b76c8f5-2298-4da6-4ec7-08dd6c58909d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 11:22:59.5445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JdWvoej6nWe6OpcOi0wsDkUtSNJGnj2KpGHYqWbD4O658kr7iQDOPhBEzzh/m8cye9way60hs8Fbj1ZJaqdx9WBIBG+ts4R7iOJxZ8qs3g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14544

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDI2IE1hcmNoIDIwMjUgMDk6NDANCj4gVG86IEJpanUgRGFzIDxiaWp1
LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gQ2M6IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVu
Z3V0cm9uaXguZGU+OyBWaW5jZW50IE1haWxob2wgPG1haWxob2wudmluY2VudEB3YW5hZG9vLmZy
PjsgV29sZnJhbSBTYW5nDQo+IDx3c2ErcmVuZXNhc0BzYW5nLWVuZ2luZWVyaW5nLmNvbT47IFV3
ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAYmF5bGlicmUuY29tPjsgbGludXgtDQo+
IGNhbkB2Z2VyLmtlcm5lbC5vcmc7IFByYWJoYWthciBNYWhhZGV2IExhZCA8cHJhYmhha2FyLm1h
aGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPjsgYmlqdS5kYXMuYXUNCj4gPGJpanUuZGFzLmF1
QGdtYWlsLmNvbT47IGxpbnV4LXJlbmVzYXMtc29jQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHY2IDExLzE4XSBjYW46IHJjYXJfY2FuZmQ6IEFkZCB7bm9tLGRhdGF9X2Jp
dHRpbWluZyB2YXJpYWJsZXMgdG8gc3RydWN0DQo+IHJjYXJfY2FuZmRfaHdfaW5mbw0KPiANCj4g
T24gVGh1LCAyMCBNYXIgMjAyNSBhdCAxMDoxMSwgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJl
bmVzYXMuY29tPiB3cm90ZToNCj4gPiBCb3RoIFItQ2FyIEdlbjQgYW5kIFItQ2FyIEdlbjMgaGF2
ZSBkaWZmZXJlbnQgYml0IHRpbWluZyBwYXJhbWV0ZXJzDQo+ID4gQWRkIHtub20sZGF0YX1fYml0
dGltaW5nIHZhcmlhYmxlcyB0byBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIHRvDQo+ID4gaGFu
ZGxlIHRoaXMgZGlmZmVyZW5jZS4NCj4gPg0KPiA+IFNpbmNlIHRoZSBtYXNrIHVzZWQgaW4gdGhl
IG1hY3JvcyBhcmUgbWF4IHZhbHVlIC0gMSwgcmVwbGFjZSB0aGF0DQo+ID4gYXN3ZWxsLg0KPiAN
Cj4gYXMgd2VsbA0KDQpPSyB3aWxsIGZpeCB0aGlzIGluIHY3Lg0KDQpDaGVlcnMsDQpCaWp1DQoN
Cj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMu
Y29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNh
c0BnbGlkZXIuYmU+DQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhl
cmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+
IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBj
YWxsIG15c2VsZiBhIGhhY2tlci4gQnV0IHdoZW4gSSdtIHRhbGtpbmcgdG8NCj4gam91cm5hbGlz
dHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K

