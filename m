Return-Path: <linux-can+bounces-3156-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36637A6787E
	for <lists+linux-can@lfdr.de>; Tue, 18 Mar 2025 16:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7ECD3AE8AE
	for <lists+linux-can@lfdr.de>; Tue, 18 Mar 2025 15:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1CE20E033;
	Tue, 18 Mar 2025 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="wkz02MWP"
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010018.outbound.protection.outlook.com [52.101.229.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE62718A959;
	Tue, 18 Mar 2025 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313410; cv=fail; b=uybzvxRfaM4wm8oZfYBU5SCweJw8jb6guyeIp/mEP4TaS2ntMENA3SS9zRS2IdSLKbYsTSLw2bYQOIbSJ0lnYQLwhIpn/tvRNf4t+ZW5mOctyI/ypIa+LhW3lwZsT0E6RdQjb9bQjBktTjXLK5kxV+RuRzk/ZJWImHfas8DW+Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313410; c=relaxed/simple;
	bh=oQNt49w8zwKy3cui4PHxoIEUgUc1S5EbkLP44X5/oz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o1rLSDHIaGvX9YNR1CUAy3g+Srfx8yNMmHquWhWO41EN0noHCmdFPb/TT9skrFdyyKtnkLyV9D6xpj0mFTjes5A/KpN4RhqlmgdB/z8TnncgKaGKsRDh2PKbqaBWguHKCzdijYSUuFtf5/leP5ZkVsx+rUix+GxBOOb4L8YAMiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=wkz02MWP; arc=fail smtp.client-ip=52.101.229.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzS8WOSppZC8jByU3RK6+nOCoJXOKmRJG6+JImwV8mRJOm8V6TWsx6ET1IXkzgMoZdDy6TX9UfGsOVF8Ee2/USN8PBxtGQmbyOKgefbWOGI/EXMqwKVl9qepnkqz0SGThTINBSgoW8OgrfYfPnnzQhRBTFMzCJHw+xvgGA7+c2eXIK25k6eKqJo9r+k7CM6oqqr5ZPx1i/jaL0UB9UmeSDuQjeJKUYhMQD+G7dX5JzzHWrkCTe8Axhe+2vtBUk+YlWck/enfXl2n6AoLaWNICw68+mZcEwhmWF5Z99/nuG/DeDdt1GEB1e6PVMJZcdqCSSXQGeEhUEGFS1pNtjvLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQNt49w8zwKy3cui4PHxoIEUgUc1S5EbkLP44X5/oz4=;
 b=D6WMHcDbXpG5p/R0iW273ihE4DenmIjky0Y8fD0zuch+9LDEjulncZSs5xryNJ2JIaEBjAAzBT85bhHQAUK1sEAtIT72PISckIPwvaAixQcj/uBZfHIX2oTONmac+qI//cleOyzkvG61udRUfYIr9RnrPevpeD0AgyabcruIpK2A85OPIRaajeSDzUngBUJPQb2ex/Ipkuf698mDE5q3NHiLahbi3+4WE4D/vWgar5JaSB9irNZGi/yw7yuuluRRUtJ1zgfwB6Ww1+jZzATq1IeInLPzW1mGuxpgill3DW8kjCuuoHbfLw0xrw7JcWqjADSZL2OGDsNAu2BgdnIOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQNt49w8zwKy3cui4PHxoIEUgUc1S5EbkLP44X5/oz4=;
 b=wkz02MWPrwAWJOqK0hW3AO7AneJ/wzEn6YmZx0csTDQeEGJx3GvsKVl5rhk0ByXDSNzOasoYw73tLXIVSXa9+rFB9/IQVJBknfZsM4ctVJYP9kihC0UIRQ8W7avdHtH2YkiCUk18lM+J+Lc6Bm/mjof0OM4vRW9/CCFcC0bQiCo=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB9375.jpnprd01.prod.outlook.com (2603:1096:400:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 15:56:38 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 15:56:38 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: RE: [PATCH v5 12/16] can: rcar_canfd: Add mask table to struct
 rcar_canfd_hw_info
Thread-Topic: RE: [PATCH v5 12/16] can: rcar_canfd: Add mask table to struct
 rcar_canfd_hw_info
Thread-Index:
 AQHblzlRqz9AKXyTHEGDaGzuM2Z5HrN3XvaAgAAGwaCAAAdpgIAAEBGggAEwseCAABteAIAAQ/gw
Date: Tue, 18 Mar 2025 15:56:38 +0000
Message-ID:
 <TY3PR01MB11346C0A2ACF4B6288A1279F886DE2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
 <20250317123619.70988-13-biju.das.jz@bp.renesas.com>
 <CAMuHMdVbcNqeNXnLRAhS-1g+VrTEwzfLiyNt+WCfuJDuF-Hacg@mail.gmail.com>
 <TY3PR01MB113466DCECC55DDE9913833F186DF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdXbk8gqhd4FFGmFNQRrEwbOToQvr-00LE2pZWoZq65GGg@mail.gmail.com>
 <TYCPR01MB1133298C8595B3CA5D890289486DF2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <TY3PR01MB113465F5D2C480EE3F0B47FA986DE2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20250318-inventive-aardwolf-of-security-5934f1-mkl@pengutronix.de>
In-Reply-To:
 <20250318-inventive-aardwolf-of-security-5934f1-mkl@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB9375:EE_
x-ms-office365-filtering-correlation-id: b2a95caa-5b55-452b-b49d-08dd663577ef
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aENzT1BqbVdLUHcrQ1BPTnhYbGc2d3VSUVZCalZmTml1Vjk4OXJRcXdwWGJM?=
 =?utf-8?B?VHZZRlRIMVZ4N013MjEzYWdZQkJ4Z1VCV2RlZ3dqM3B6WVpoNGVlSFlCREdN?=
 =?utf-8?B?NTRZQUlhQXN6eWxocFB2U21HUU10U2RrS05sYkd6aWNVZGs2MDJBaC91Z2xD?=
 =?utf-8?B?MVdrM29rSk9SZ3k0RFpEaEJHeGtabXdvNWdMenZmLzVxeXZ5M0U5S1pWR3RK?=
 =?utf-8?B?RTNKajk3VVNQL21YVlRZVWp4ZGFOTnIzaHFNQ2xXRlI5aytPYlh6YzRqRFBH?=
 =?utf-8?B?dmNZMEd0NklhMWNYR1VPMjRBbmtLdzYxVFhMbnVsM1I2b1hCQ2FnSGxWK1Vo?=
 =?utf-8?B?RTN5SzBmd1d3alp1RDNDb0VCTmhVU3BsMWZMWmtBQTY0NGJ1S0xUV0wrWUd0?=
 =?utf-8?B?YUsrQTgramJHNkxhM211VHZzV3EvQ2F2d1dlUUdOUEx6U3hHZzRyMmxYRUhC?=
 =?utf-8?B?WlhnK28wdzgyeHVnY3EvL3BZZDJyZXFSZTc3RmtvTGdDUGRZYlU5aXp6bVZp?=
 =?utf-8?B?L3l1dFlaNUtuTjI0OUJubi9iZmlmbTc1eXBKN2FGL2lhV0lYU1Z0eFR3WWJ1?=
 =?utf-8?B?SDY0MDdHUFVROUV4N2NYSmFpc3JaNnpHV3AvOCtJSldJQ0tETFVqdFhFd1BC?=
 =?utf-8?B?MzlxcC8yUnd3WFNQK2FUTUIwc1UvdmY4VDZCVjZqK1BEeHJBcU1KeU1DbXhl?=
 =?utf-8?B?RitDSDRaL093NjJxQkhLekl3UzBCMktLdTBvcmgwRkorTFpTWmpxK3NGM1Jt?=
 =?utf-8?B?MVhMU244ZmpSa25aV2xMbGRobFJQUnVyampYUTAvVGZTWHNDMFRhWS9hNGhW?=
 =?utf-8?B?RjRpUTdPRnJFTjZFeDhMU1VnU081Ry9nMkNQZHNvdEh2d0t0RGtqU2gzVk5r?=
 =?utf-8?B?dUE0cmRVNTU3WTVwYk9NK3VubDh3eW9KZlZzcmE4WVZTYzRIdk1YTEN2VFc5?=
 =?utf-8?B?K1NOUmxjRDZMUndOM2MrcGdoN2FOSERBeHNtZC9Qd2pla2d0RVJjT2RoNEsw?=
 =?utf-8?B?UnRsWDdCaWVKc0dIZ29jeFd6czdEOFJlZk0rVXZPNGZWVktlOWlKK3BZQzJB?=
 =?utf-8?B?RzZWUlpZTGxFMmhqMC84M3hEMk1HU0JqOTRNdTlFZ2xUMWhEa2tqNUJPMTVy?=
 =?utf-8?B?dHlhdmdBV1c2VytZWGxSd2RocnB3WkNKa2ZjdDU2RFd0UG1GcWhMZ0JULzZr?=
 =?utf-8?B?R0twU0VQR3Qvc2N4WlJ1TWJxZ2JSQlpGL3JMeUFqUDNLVjBsTWxIM0dYRzJ1?=
 =?utf-8?B?OXdWU2p6ajlIOGNVQlBBVU9jZXBibVE1UDcvd0hIanptU1IxQU9VcXFWUmVP?=
 =?utf-8?B?amErTGVTQ25QN2dqMytEakVjRlhrQTdhYitBMVd2NVI1QmRTek9mMUhiSDla?=
 =?utf-8?B?RXZBOGZmVElUUjhNcGpQVzE5ZkZzYWNQZXlPSTN2OUZXUWdRVHBxR2NOeklI?=
 =?utf-8?B?QTJrME5IT2NQOXExSHZlNGpMamVXSDNRbHR6QnFNSXFuOTBSTG9NbUlJWG1X?=
 =?utf-8?B?b3V0dldrZ2l5dkNSb3V2UTgyUUhBeGVYMnlSNWJTL2R3LzNsektCdENvWUtP?=
 =?utf-8?B?SWRLSDVSM1k2QWs1aFJKNVZpY2pqZVk1cnlHc1h1QTdrOEh1cXZzMWQ4eVhX?=
 =?utf-8?B?NWxPWkJiZUFrZjRXY0ZUWS83SDJIRlRqcW8vOXdmdlBTL2IzdTc4VVVoREMv?=
 =?utf-8?B?cnlIS0RKOHhSdlNwbFBMdnhLYU1jSHl0U1VPZzRic1ZKVHYrS0Q3QW1SSEwr?=
 =?utf-8?B?ekxIUllMV3VIQTdYbEFpc1R4RldkRnh3S0ZRVU40MldXUjV5ek00Y3ArNG1u?=
 =?utf-8?B?S3hzMklLeDU4a3MraDJjdHNudjNZVjBGaEhVNUhXK0JCTnZUQ2I0RjJad2t5?=
 =?utf-8?B?ZWdJZE9uMkJBdlJzNXZJUmFPMExRUUF1NHlWOS94VnhWSEV4OHdvVTFqY2Jo?=
 =?utf-8?Q?cNNz/YnGZhNCzS9t47JJ2UXGlkoBeYbn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmdTSjlaWGplYVg3MUQ1VVlpaVFDdTl3bHlpc0xJa3ZlNDN5WkRWTDFzU3N6?=
 =?utf-8?B?UXJ5UnppOXhtQTYzLyt4blRDKzhuNlRSMzVPUFBhUmd3OXBNMFdkZkRpSTFU?=
 =?utf-8?B?VVdvQXVrd21MUHdqSEtnVURLWThKNXM4MUVvQ2Z6U0NGdWhUSDc0MVhDa0tN?=
 =?utf-8?B?b29IeXBER2VOZ3VCUXZnNGpDanpLN21penRlM1BGby9KVnY4cHp6eGhqUDNo?=
 =?utf-8?B?RHRaQ05YMjVWRXdEekRKWlJ5SEk4a3ZMQi9QWUsrdVVjREVUdlgxL05UL2NC?=
 =?utf-8?B?YzlEdCtoclE0VHdMUmI0UmlaQ0V1OG5xYlY0YXRqMW0zVXBuaHUzaklscGw0?=
 =?utf-8?B?ajMxNUFNbWRoVkNOWTlCM0dQcDh1cXJabVU3eWVqSE5HcDkrS0FYZFIyMHNn?=
 =?utf-8?B?bEIxQklkOGxXdGVIUFU0U0g2cjhLS3NGQnMrY2lPbnp3K1lLSDFCOEdrWWY4?=
 =?utf-8?B?TjE1blFhbzdZZ1ZDYzJMOUVmYWp5ZHZMQ3VHM3ZuR1dGYkxwdG1sM0Z5eE1p?=
 =?utf-8?B?WnVkdFE5UUUxeE5qTGhyQUo5MG5MOUZ5ZTg4N2owZHl6a25tT3dCZ2xxWTNm?=
 =?utf-8?B?SElHOWR5aVdmazJpVTUvR3Y5NG1md0grNTQ2ZFc3NFd6WDVINVpiendwQnN0?=
 =?utf-8?B?dXlUM3F4RE0vN3NEN29rNzMwRmU5UEtlRlByYlpoSVNFUDZGTTB2a0dXRU9x?=
 =?utf-8?B?MHZHandnZTYwbEhIei9MMEZxZEhJVUlXZmI0YUJKOXhoVkJNTkk0bWVFalFJ?=
 =?utf-8?B?UCtDNlBLc0FFSmRXUzhJdXdON2ZWRnlQdjlaaVhPOTJhZXBXSDNJeVl5a3cw?=
 =?utf-8?B?V2hNbWlBSFZjM290TUhkVkR2V0dvdjlTeDA2ZndXUWxUU0U0TmRwM2d4UFBK?=
 =?utf-8?B?c0FHZ2pzczRrbzFENUxkYTJCaWZYZjQ3cFFGMUdZWFlqU3diNmtpdld2N29y?=
 =?utf-8?B?QWZPY08rYU03Vjg5Z1hUbHVhcTNaOW9LT1pkNXVLMG5MVmFRajZCaU41eVFD?=
 =?utf-8?B?b0FqYTlXWm5IV3NMNHJCYXBWZnFHeXZBWlUrZGRLcmJSV1gzUC9Sb05SS1Nu?=
 =?utf-8?B?WDhob0lFY2NtdGpzT1FVb28zdWxwZkxKUUJDeEY3d2NDdGpEZlJOR2puYkpy?=
 =?utf-8?B?b29wcHNuWEpoN1VWL01IczRyWDAxT1lZTmh5WExVYUVrbzNkS2U1cU1KYVEy?=
 =?utf-8?B?ZVEvUitvOVA0TE5zRk1heTlucUNxVytodlFNTlJJSHp3MlFBNHBxZXRyV0x1?=
 =?utf-8?B?STEwZThoUStmYSsrZVg3QjRJKzVPRzBCSmhocjBuZmVFeng3SXBZT1RPVU41?=
 =?utf-8?B?QnZsR04xYWtuSnVacHRNNkxnNjlZSERWbkNlR0pVYjlBVzVGSHZ3RU9IQ09C?=
 =?utf-8?B?V3VhbzFLNmpNdnpMTlBXQkRBMm4rR1NaODY2Zi9reWFXMnJFM2N6NnMwc1A1?=
 =?utf-8?B?QmlmOTFxb3p0SlIxUmhRV2JoVHJOTWUyU3FSWDRtU1JDZHRWZ0cvSXdXQXlp?=
 =?utf-8?B?bm5adWxEWTZ0V2prSjFZYXloZ3ZVWmkwSHFDajdhRHJYWEJvRkMvMUZLWGh1?=
 =?utf-8?B?YXdoRW5BUU9VQmwvRFlJZFhlMVZybTNjNHlZakdmbEsvZ2tURmh2VHltb1BG?=
 =?utf-8?B?cHFRYktQQTVueTZXMDdtN3h0RWgwODNLeUk1YkIwekgyNWVqQThwZmloTVUw?=
 =?utf-8?B?a2R2TWU3MmM1c09KeC9MK2E2Y21qQWV5eDkyMm5veHJYbGFjSk05TlNuMVJE?=
 =?utf-8?B?Um1yektaQkpwT0NIb2cyZ05TaDVxQ0szNGtRc09sUEpJVXFQdmx5cjVSVkl3?=
 =?utf-8?B?eUJLaW16RXQ5WDB4U2drRDZ0alpXdjRqVkpETGh5M0hkamoxWThxaTVPZUNo?=
 =?utf-8?B?OHRHZHNrVFR3dVEyU2IxKys3ZjAxWitFWnZ3WG5TU3JmckRUQktUQlhVWTZY?=
 =?utf-8?B?YXQyNE5TZVdRaERRZVlqY0dSRmtidC9WR3M1MjcxWXgveU1vRi91aWJrdDY4?=
 =?utf-8?B?QlRlRG1LNVlIWDdOWGR4R29VcGMxelhvVnRqWFJCUGg2YThzNmJ4YVpzanVT?=
 =?utf-8?B?ZHI4KzBsKzdJclB4MDVRVkFtcDRKNXB0YU5FWGNNZ0xDVUpyd0p1OURxSURT?=
 =?utf-8?B?eDNQMlZhYmlEbXVSTlJpYUV2dGRtRVRUQmRuT1dLU05JMHU5bzQwTHFSWmpk?=
 =?utf-8?B?TkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a95caa-5b55-452b-b49d-08dd663577ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 15:56:38.7806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5QLvv3bjKcRqm3J0mseOSzCEsuFC2pS6GGQU1ad6egVEkcBt2dCQfdXfZSRNY6o4iqQDF46db7C/B9VUS3lssz8T36bkwk4a73j9uQP0x+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9375

SGkgTWFyYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEts
ZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAxOCBNYXJjaCAyMDI1IDEx
OjUwDQo+IFN1YmplY3Q6IFJlOiBSRTogW1BBVENIIHY1IDEyLzE2XSBjYW46IHJjYXJfY2FuZmQ6
IEFkZCBtYXNrIHRhYmxlIHRvIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8NCj4gDQo+IE9uIDE4
LjAzLjIwMjUgMTE6MjY6NTQsIEJpanUgRGFzIHdyb3RlOg0KPiA+IEhpIEdlZXJ0IGFuZCBNYXJj
LA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQmlq
dSBEYXMNCj4gPiA+IFNlbnQ6IDE3IE1hcmNoIDIwMjUgMTY6MjQNCj4gPiA+IFN1YmplY3Q6IFJF
OiBbUEFUQ0ggdjUgMTIvMTZdIGNhbjogcmNhcl9jYW5mZDogQWRkIG1hc2sgdGFibGUgdG8NCj4g
PiA+IHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8NCj4gPiA+DQo+ID4gPiBIaSBHZWVydCwNCj4g
PiA+DQo+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IEdl
ZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+ID4gPiA+IFNlbnQ6IDE3
IE1hcmNoIDIwMjUgMTU6MDQNCj4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxMi8xNl0g
Y2FuOiByY2FyX2NhbmZkOiBBZGQgbWFzayB0YWJsZSB0bw0KPiA+ID4gPiBzdHJ1Y3QgcmNhcl9j
YW5mZF9od19pbmZvDQo+ID4gPiA+DQo+ID4gPiA+IEhpIEJpanUsDQo+ID4gPiA+DQo+ID4gPiA+
IE9uIE1vbiwgMTcgTWFyIDIwMjUgYXQgMTU6NDYsIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5y
ZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4gPiA+ID4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhr
Lm9yZz4NCj4gPiA+ID4gPiA+IFNlbnQ6IDE3IE1hcmNoIDIwMjUgMTQ6MTMNCj4gPiA+ID4gPiA+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTIvMTZdIGNhbjogcmNhcl9jYW5mZDogQWRkIG1hc2sg
dGFibGUNCj4gPiA+ID4gPiA+IHRvIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8NCj4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiBPbiBNb24sIDE3IE1hciAyMDI1IGF0IDEzOjM3LCBCaWp1IERhcyA8
YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBSLUNhciBH
ZW4zIGFuZCBHZW40IGhhdmUgc29tZSBkaWZmZXJlbmNlcyBpbiB0aGUgbWFzayBiaXRzLg0KPiA+
ID4gPiA+ID4gPiBBZGQgYSBtYXNrIHRhYmxlIHRvIGhhbmRsZSB0aGVzZSBkaWZmZXJlbmNlcy4N
Cj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhv
ZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiA+ID4gPiA+ID4g
LS0tDQo+ID4gPiA+ID4gPiA+IHY0LT52NToNCj4gPiA+ID4gPiA+ID4gICogSW1wcm92ZWQgY29t
bWl0IGRlc2NyaXB0aW9uIGJ5IHJlcGxhY2luZyBoYXMtPmhhdmUuDQo+ID4gPiA+ID4gPiA+ICAq
IENvbGxlY3RlZCB0YWcuDQo+ID4gPiA+ID4gPiA+ICAqIERyb3BwZWQgUkNBTkZEX0VFRl9NQVNL
IGFuZCBSQ0FORkRfUk5DX01BU0sgYXMgaXQgaXMgdGFrZW4NCj4gPiA+ID4gPiA+ID4gICAgY2Fy
ZSBieSBncHJpdi0+Y2hhbm5lbHNfbWFzayBhbmQgaW5mby0+bnVtX3N1cHBvcnRlZF9ydWxlcy4N
Cj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGFua3MgZm9yIHRoZSB1cGRhdGUhDQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gQWxsIG1hc2sgdmFsdWVzIGFyZSBqdXN0IHRoZSBtYXhpbXVtIHZh
bHVlcyBvZiB2YXJpb3VzIHBhcmFtZXRlcnMuDQo+ID4gPiA+ID4gPiBIZW5jZSB0aGV5IGNvdWxk
IGJlIHJlcGxhY2VkIGJ5IHRoZSBsYXR0ZXIsIGxpa2UgeW91IGFscmVhZHkgZGlkIGZvciB0aGUg
Uk5DIG1hc2suDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBCdXQgdGhpcyB3aWxsIGluY3JlYXNlIG1l
bW9yeSBzaXplLCByaWdodD8gQ3VycmVudGx5IHdlIGhhdmUNCj4gPiA+ID4gPiByY2FyLWdlbjMg
YW5kIGdlbjQgdGFibGVzDQo+ID4gPiA+ID4gMiB0YWJsZXMgdXNlZCBieSA0IGhhcmR3YXJlIGlu
Zm8gdmFyaWFudHMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJZiB3ZSBkcm9wIHRhYmxlcyBhbmQg
dXNlIHZhcmlhYmxlIHdpdGggbWF4IHZhbHVlcyBsaWtlIFJOQw0KPiA+ID4gPiA+IE1BU0ssIHRo
ZW4gdGhpcyB3aWxsIGJlIGxpa2UgNCB0YWJsZXMgZm9yIDQgaGFyZHdhcmUgaW5mbyB2YXJpYW50
cywgcmlnaHQ/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBQbGVhc2UgY29ycmVjdCBtZSBpZiBteSB1
bmRlcnN0YW5kaW5nIGlzIHdyb25nLg0KPiA+ID4gPg0KPiA+ID4gPiBJdCBkZXBlbmRzIHdoZXJl
IHlvdSBzdG9yZSB0aGUgcGFyYW1ldGVyczogaW4gdGhlICh0d28pIHRhYmxlcywgb3INCj4gPiA+
ID4gaW4gdGhlIChmb3VyKSBoYXJkd2FyZSBpbmZvIHN0cnVjdHVyZXMuLi4NCj4gPiA+DQo+ID4g
PiBPSywgeW91IG1lYW4gcmVwbGFjZSBtYXNrX3RhYmxlLT5tYXhfdmFsX3RhYmxlLA0KPiA+ID4g
cmNhcl9nZW57Myw0fV9tYXNrX3RhYmxlLT5yY2FyX2dlbnszLDR9X21heF92YWxfdGFibGUNCj4g
PiA+IGFuZCAqX01BU0stPipfTUFYX1ZBTD8/DQo+ID4NCj4gPiBUaGUgYmVsb3cgcGFyYW1ldGVy
c1sxXSBoYXMgbWFzayA9IG1heF9wYXJhbWV0ZXJfdmFsIC0gMS4NCj4gPg0KPiA+IEkgd2lsbCB1
cGRhdGUgdGhlIHRhYmxlIGFzIGJlbG93LiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhlcmUgaXMg
YW55IGlzc3VlLg0KPiA+DQo+ID4gc3RydWN0IHJjYXJfY2FuZmRfaHdfaW5mbyB7DQo+ID4gLSAg
ICAgICBjb25zdCB1MzIgKm1hc2tfdGFibGU7DQo+ID4gKyAgICAgICBjb25zdCB1MzIgKnBhcmFt
czsNCj4gPiB9Ow0KPiA+DQo+ID4gLWVudW0gcmNhcl9jYW5mZF9tYXNrX2lkIHsNCj4gPiAtICAg
ICAgIFJDQU5GRF9OVFNFRzJfTUFTSywgICAgIC8qIE5vbWluYWwgQml0IFJhdGUgVGltZSBTZWdt
ZW50IDIgQ29udHJvbCAqLw0KPiA+IC0gICAgICAgUkNBTkZEX05UU0VHMV9NQVNLLCAgICAgLyog
Tm9taW5hbCBCaXQgUmF0ZSBUaW1lIFNlZ21lbnQgMSBDb250cm9sICovDQo+ID4gLSAgICAgICBS
Q0FORkRfTlNKV19NQVNLLCAgICAgICAvKiBOb21pbmFsIEJpdCBSYXRlIFJlc3luY2hyb25pemF0
aW9uIEp1bXAgV2lkdGggQ29udHJvbCAqLw0KPiA+IC0gICAgICAgUkNBTkZEX0RTSldfTUFTSywg
ICAgICAgLyogRGF0YSBCaXQgUmF0ZSBSZXN5bmNocm9uaXphdGlvbiBKdW1wIFdpZHRoIENvbnRy
b2wgKi8NCj4gPiAtICAgICAgIFJDQU5GRF9EVFNFRzJfTUFTSywgICAgIC8qIERhdGEgQml0IFJh
dGUgVGltZSBTZWdtZW50IDIgQ29udHJvbCAqLw0KPiA+IC0gICAgICAgUkNBTkZEX0RUU0VHMV9N
QVNLLCAgICAgLyogRGF0YSBCaXQgUmF0ZSBUaW1lIFNlZ21lbnQgMSBDb250cm9sICovDQo+ID4g
LSAgICAgICBSQ0FORkRfQ0ZUTUxfTUFTSywgICAgICAvKiBDb21tb24gRklGTyBUWCBNZXNzYWdl
IEJ1ZmZlciBMaW5rICovDQo+ID4gK2VudW0gcmNhcl9jYW5mZF9wYXJhbWV0ZXJfaWQgew0KPiA+
ICsgICAgICAgUkNBTkZEX05UU0VHMiwgICAgICAgICAgLyogTm9taW5hbCBCaXQgUmF0ZSBUaW1l
IFNlZ21lbnQgMiBDb250cm9sICovDQo+ID4gKyAgICAgICBSQ0FORkRfTlRTRUcxLCAgICAgICAg
ICAvKiBOb21pbmFsIEJpdCBSYXRlIFRpbWUgU2VnbWVudCAxIENvbnRyb2wgKi8NCj4gPiArICAg
ICAgIFJDQU5GRF9OU0pXLCAgICAgICAgICAgIC8qIE5vbWluYWwgQml0IFJhdGUgUmVzeW5jaHJv
bml6YXRpb24gSnVtcCBXaWR0aCBDb250cm9sICovDQo+ID4gKyAgICAgICBSQ0FORkRfRFNKVywg
ICAgICAgICAgICAvKiBEYXRhIEJpdCBSYXRlIFJlc3luY2hyb25pemF0aW9uIEp1bXAgV2lkdGgg
Q29udHJvbCAqLw0KPiA+ICsgICAgICAgUkNBTkZEX0RUU0VHMiwgIAkgIC8qIERhdGEgQml0IFJh
dGUgVGltZSBTZWdtZW50IDIgQ29udHJvbCAqLw0KPiA+ICsgICAgICAgUkNBTkZEX0RUU0VHMSwg
IAkgIC8qIERhdGEgQml0IFJhdGUgVGltZSBTZWdtZW50IDEgQ29udHJvbCAqLw0KPiANCj4gQW5v
dGhlciBvcHRpb24gaXMgdG8gZXZhbHVhdGUsIGlmIHlvdSBjYW4gdXNlIHByaXYtPmNhbi5iaXR0
aW1pbmdfY29uc3QgYW5kIHByaXYtDQo+ID5jYW4uZGF0YV9iaXR0aW1pbmdfY29uc3QgaW5zdGVh
ZC4NCj4gDQoNCkxvb2tzIHRoYXQgaXMgcG9zc2libGUsIGFzIHdlIGp1c3QgbmVlZCB0byBwaWNr
IHRoZSBtYXggdmFscyBmcm9tIGJlbG93IGdwdi0+aW5mby0+Kl9iaXR0aW1pbmcNCnZhcmlhYmxl
cy4NCg0Kc3RydWN0IHJjYXJfY2FuZmRfaHdfaW5mbyB7DQorICAgICAgIGNvbnN0IHN0cnVjdCBj
YW5fYml0dGltaW5nX2NvbnN0ICpub21fYml0dGltaW5nOw0KKyAgICAgICBjb25zdCBzdHJ1Y3Qg
Y2FuX2JpdHRpbWluZ19jb25zdCAqZGF0YV9iaXR0aW1pbmc7DQoNCnN0YXRpYyBjb25zdCBzdHJ1
Y3QgY2FuX2JpdHRpbWluZ19jb25zdCByY2FyX2NhbmZkX25vbV9iaXR0aW1pbmdfY29uc3QgPSB7
DQorc3RhdGljIGNvbnN0IHN0cnVjdCBjYW5fYml0dGltaW5nX2NvbnN0IHJjYXJfY2FuZmRfZ2Vu
M19ub21fYml0dGltaW5nX2NvbnN0ID0gew0KDQpzdGF0aWMgY29uc3Qgc3RydWN0IGNhbl9iaXR0
aW1pbmdfY29uc3QgcmNhcl9jYW5mZF9nZW40X25vbV9iaXR0aW1pbmdfY29uc3QgPSB7DQorICAg
ICAgIC5uYW1lID0gUkNBTkZEX0RSVl9OQU1FLA0KKyAgICAgICAudHNlZzFfbWluID0gMiwNCisg
ICAgICAgLnRzZWcxX21heCA9IDI1NiwNCisgICAgICAgLnRzZWcyX21pbiA9IDIsDQorICAgICAg
IC50c2VnMl9tYXggPSAxMjgsDQorICAgICAgIC5zandfbWF4ID0gMTI4LA0KKyAgICAgICAuYnJw
X21pbiA9IDEsDQorICAgICAgIC5icnBfbWF4ID0gMTAyNCwNCisgICAgICAgLmJycF9pbmMgPSAx
LA0KK307DQorDQoNCnN0YXRpYyBjb25zdCBzdHJ1Y3QgY2FuX2JpdHRpbWluZ19jb25zdCByY2Fy
X2NhbmZkX2RhdGFfYml0dGltaW5nX2NvbnN0ID0gew0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgY2Fu
X2JpdHRpbWluZ19jb25zdCByY2FyX2NhbmZkX2dlbjNfZGF0YV9iaXR0aW1pbmdfY29uc3QgPSB7
DQoNCitzdGF0aWMgY29uc3Qgc3RydWN0IGNhbl9iaXR0aW1pbmdfY29uc3QgcmNhcl9jYW5mZF9n
ZW40X2RhdGFfYml0dGltaW5nX2NvbnN0ID0gew0KKyAgICAgICAubmFtZSA9IFJDQU5GRF9EUlZf
TkFNRSwNCisgICAgICAgLnRzZWcxX21pbiA9IDIsDQorICAgICAgIC50c2VnMV9tYXggPSAzMiwN
CisgICAgICAgLnRzZWcyX21pbiA9IDIsDQorICAgICAgIC50c2VnMl9tYXggPSAxNiwNCisgICAg
ICAgLnNqd19tYXggPSAxNiwNCisgICAgICAgLmJycF9taW4gPSAxLA0KKyAgICAgICAuYnJwX21h
eCA9IDI1NiwNCisgICAgICAgLmJycF9pbmMgPSAxLA0KK307DQorDQoNCisgICAgICAgICAgICAg
ICBwcml2LT5jYW4uYml0dGltaW5nX2NvbnN0ID0gZ3ByaXYtPmluZm8tPm5vbV9iaXR0aW1pbmc7
DQorICAgICAgICAgICAgICAgcHJpdi0+Y2FuLmRhdGFfYml0dGltaW5nX2NvbnN0ID0gZ3ByaXYt
PmluZm8tPmRhdGFfYml0dGltaW5nOw0KDQoNCkNoZWVycywNCkJpanUNCg0KDQoNCg0K

