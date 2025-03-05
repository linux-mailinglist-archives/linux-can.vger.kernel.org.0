Return-Path: <linux-can+bounces-2981-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B80A50079
	for <lists+linux-can@lfdr.de>; Wed,  5 Mar 2025 14:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9153B2065
	for <lists+linux-can@lfdr.de>; Wed,  5 Mar 2025 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C43248878;
	Wed,  5 Mar 2025 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="kIeSatCO"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011033.outbound.protection.outlook.com [40.107.74.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FD31EDA0E;
	Wed,  5 Mar 2025 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180781; cv=fail; b=bGbgzAL3HTb1r/Dxy/IXpd1vjr2OLeYcScCwbd4K34vMMCN/GN4bPpJP6op3eY4rW1WMGjUW2ASVoyA0vr74MRsx1Op/ullH66x2CcFwRo8SiGeSEgVHqV9Ltq2ipyXhuXZIchmFIYd1rEn/e2T+QsGBl74gtFoHI1Um4A5KSs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180781; c=relaxed/simple;
	bh=blsXpXscmUudEAq85GTJHyP8VxE7cOHY1HNwYJW3X/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LuGCOLX2zpoXT7EjrbhvCaNNyjG17PVQ7vmsuCXPozjWWCyHwqX0GzpVoFUn+bCyhI6ki42H72GnME3VhWIOfdX/y20kF27dKJ4ks2E9xRqvrPAHiS8mciVhy6EEeXbCz2nR4QSpaESkeAW0qPjJ2oRxwjeiysfpIq4P/sR2lWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=kIeSatCO; arc=fail smtp.client-ip=40.107.74.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9M5IqoidrtMOHOGHx7S+pQOahd132OA8QJa0VL3q9LCF7w1WU95qCkW360pN70n1IXHHgBi2Koj/kquNsKwl5q/bI6EgMvUm8yK4QvGIZjBVFyOwrwZouwyg91kSCLCI9Zyb8H+PMEv2l30Q8C0ZezVOXhbbvElXm3eGglN++Ndf8mlt6Epsg65VwgI9sJDYHuiZZ5sDo4yE53Z2xvM9lPRdfiit/IS/sQl3wZRsdmXA13qn2Ij+RYrbCoR1PUBEOOnjEyApUjIhszed2fKw1mnhn1iJsU99DELOi/lqE6+2F8PHcn/APzURru20CTzKKzrF83DoXQw4CP/0D6KIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blsXpXscmUudEAq85GTJHyP8VxE7cOHY1HNwYJW3X/M=;
 b=PqriGjJtaQbWAztUoZEWQTL+qKdTSmPWFC0VXo45oXN2XIu50TiEWR9RNfzvWHLVCI8veQgvlnmWCfi0eX1sb7IxGXtJSacbbkfVlZaxTg2RC6KbtxxOeBRUoA4nRFCQjb4jALZqePE0yxfMAqBm8RJkCqPcgsI5Rhcqy9ab8v9nQV9Sx/S0ySJmbgMRyDAEdAJZY35SelbajHurP+IXGn1L7kM6j8tmAFPj8+QBs0Rqaki4LbEAF6Dmd+hwjI2NGSgMZX662UJGfyUJ9brVaWPCsQXYszLmrrx7Tm2I6fn86SqrYXdGsS62H2IlfMBdFyw4f3yWWdPG98UOrWTv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blsXpXscmUudEAq85GTJHyP8VxE7cOHY1HNwYJW3X/M=;
 b=kIeSatCO73lgW5o/s6/zSB5TEmjxmgyqOim75ZfWKTGIpZaM+pyyRMlN+Q7CEzRxg0uckI3q9doYCHF8gEOqIi7m2nptKCp0OrB1e1Kyj13qYMiQQ3OxcPHOFgoiR7v10ZCNoqQLQ2UIJZGqlVerQrxc93xPonFkBafelJZZsLc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB9829.jpnprd01.prod.outlook.com (2603:1096:400:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 13:19:36 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 13:19:36 +0000
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
Subject: RE: [PATCH v3 07/11] can: rcar_canfd: Add mask table to struct
 rcar_canfd_hw_info
Thread-Topic: [PATCH v3 07/11] can: rcar_canfd: Add mask table to struct
 rcar_canfd_hw_info
Thread-Index: AQHbh5vAsmr0wT43O0axGbhGuQSGM7NYKqGAgAxoj6A=
Date: Wed, 5 Mar 2025 13:19:36 +0000
Message-ID:
 <TY3PR01MB11346D38938DD4AD956D1A7C986CB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250225154058.59116-1-biju.das.jz@bp.renesas.com>
 <20250225154058.59116-8-biju.das.jz@bp.renesas.com>
 <20250225-athletic-graceful-jaguar-4a0486-mkl@pengutronix.de>
In-Reply-To: <20250225-athletic-graceful-jaguar-4a0486-mkl@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB9829:EE_
x-ms-office365-filtering-correlation-id: 938d97fb-f2f6-45ee-bd95-08dd5be8605b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkhzZVU3LzhRbnVhTUdBZDk3OEF6U3hwdTYwR3d5dWsyLzNwSEkwVC9Gczhh?=
 =?utf-8?B?cXFQeGZpWVE2MUZRQk1qWjR5UFRzZWREcFZ5Qk4wVHlxY0lDaGwvQ29xNmRW?=
 =?utf-8?B?c0xDTGRSRHM4dkFHTVdBVU1vUjF4ODlHb3RWVXpRZlVlWjh0Nk5vdDF1eHlY?=
 =?utf-8?B?eGYyeTUyYThnODF6TXJLUlVIOFR5WHpnVmVvU3J5OUxNN0ZBZEQzOFI4andq?=
 =?utf-8?B?K3BwNHMvYTZ2dVdraEtnUWhlM3FueWY0M0dUTzc1dytPUEJJOVlZM2pCRG5N?=
 =?utf-8?B?NDNTTDBqNXdGaFp3MUFyQmVaN3Q5dVJWOUsvUFh6UTc1ZmdZUW5WUUFMRkNn?=
 =?utf-8?B?ajcyMHVTOUpwUzFJQWpkZUUxNlliNHpsby9QQUx0MXVSVVRFRkhBakZPMnBV?=
 =?utf-8?B?czVFMDZZQ3N3c3E4eGlMRmlYNG0vekdkMm1PUjhQY1RNQWNxbnRYTC9kN2Q3?=
 =?utf-8?B?WkpBaE03RzNCMGRKVTYrWVBoa2ZmS05aOEZaMWhIeGxncTdNb3EwOFdDdTJa?=
 =?utf-8?B?NGFzeUoza2ZVb2ZhbWRIQk5PMzNaU2EvQUU4UnNJekZGNzVuandUeG9TZWxy?=
 =?utf-8?B?T2h0NHR4N1cvNHBYeFc3aWFyTGJDanBEbWJHR2lvcFZKZllibi8yUm10NzEy?=
 =?utf-8?B?aVZNdVF1b0tURElsOFpHdnRwOFdzSlc2TElySnVOYS9OS2ZLUUNqUlpnWDJ1?=
 =?utf-8?B?U3V0NlZIb0RDS3U3eGVLOEpFbVNOZVBCQ3B1YWxTc1cxMzV6NjNna1RiZ3Er?=
 =?utf-8?B?emUwL0lRZzR2SkhhMkhIYnpzSGtmQkVVbE9LQnVvcCs3c2lMZHhOcUE2MUtl?=
 =?utf-8?B?Zm55bUptdm8ydnJvNWJZUlp3UjhnT2VWUytydndKdG51SnB1S0RIbFlXZDVw?=
 =?utf-8?B?bU9PTE41QW1ubU9GK25QRmp3SnV6QnQyeXJUMjY1OE1FS2xHQUFYc1hybWpO?=
 =?utf-8?B?eEcxZlVFMWpYMGtzazJ0T1Y5Mi9DMnRQeWw5eGJmdGhIQ1lmbDRlbkFEQnF6?=
 =?utf-8?B?S0xRYzFsc1ZFWGtrNmJKWGNWWk11Q1ErZVJBQ2lyaDJ4NEhzVm5iZ0d2bXU2?=
 =?utf-8?B?MXRvMFBLdVBVVWFhN2hiQjlWaThqWjBuQXY0SHlGQjZrZGpxM09kK1JsVEF6?=
 =?utf-8?B?OFkvNlh4Lys5UTA1VzRvWHlreTYwKzRWOGt6Y2xQejdzaXJTeUpPNE9Na3dO?=
 =?utf-8?B?RkF4b1I4ZDJJdGU2dG01aUpvVERia3NsTEMxZWU4bXBZcUhZeXZaU3lnQXVC?=
 =?utf-8?B?Z2o0SzhiZHpqTkJGMjM5M1FEZFVJemJtQUM4TE1Qc2hlWmUvNEhpQnY0ak8y?=
 =?utf-8?B?eTZhbDl3OHhtRWM4azgxcGFPRHVLYzV4Wi9CYjN6Ym9DMmU3cU9rNE9jNERN?=
 =?utf-8?B?dFRwWnRhT0RvU25oTlZhcWtXdXdkV0RxSDVSMHpTMHZJSDE3b0dBcmZ4eEF6?=
 =?utf-8?B?QVVteHNBRTlDUkUxMVlkR3dYcVNzU3lyOVFjTFBmNXVVZk90WitwWjVuSk55?=
 =?utf-8?B?SVF3SVN4Vm5nWFU1NFJ6STd1bkFvMFRaYm9wVFNrbGc0a0pMTkZUd005eEUw?=
 =?utf-8?B?S01SeFpEVXVPRE1veVo3eEpublQ2a3pVSzlvckF5djhXZlNjeThqV3I2SmFG?=
 =?utf-8?B?SGtWTk82UCs0S2pkbHUyNkQxZllkclp2b1Y2QUtlUTFGcDdJelFkOFdSN0hZ?=
 =?utf-8?B?OGpmWmJrMmVTVXNEMHlSTVcxOEdMMm9mZURaNEU3RDUrN0lvMXd5K01uV3M3?=
 =?utf-8?B?NU5YYk9SVW1YQ1ltbEdCRmxuUzZqTW9qRUpYRThVUnNlZngrSjd1QkNMaWJ6?=
 =?utf-8?B?dGZnclozQWdkd1JyZVplTi84MnlMZTF1bk9ZNk9DSkFjR1JWUzRyWFNScnNL?=
 =?utf-8?B?am1yeHE5SGhueXpIb3FqWXdyekhIUzlTQVVIajBsWW9zVThiekRaWEhKYzlh?=
 =?utf-8?Q?8sEKy3gi4+mLDw93CY8YP47Uikz/gH8g?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmtTUHdSMlI2cWRKZi9xOHQxYlRmZkxrOE5OeWxOVnNVdWRvU0lyR3VTNVEr?=
 =?utf-8?B?U1JyOTNFRGdWQkE4M0hveFlQU3BsNlE2bWs2UlpGbVA4UHhpM3E1SnZiV2hL?=
 =?utf-8?B?a21PNWhuenZ4R1BHYVdVQmFzTGs1UCtiU3pxRkdCdktINHp6aEF2bkp4ZUc2?=
 =?utf-8?B?b011OEFOQWd2L2JtUEdwQ3B5WWcrZkV1UFFwVWt1aWJvMkhISFVSTkgwQTQv?=
 =?utf-8?B?K2RFamJKZEJCMFlFSmcrZWVJM1VhSGJtMDkxaFJVbmVSRjBHQ01pNjJtOXBY?=
 =?utf-8?B?eUhUcFdVUTdLd3VXNFBtVEZCQ0drS0Q2c1dvdGxDSW5qZmt5akZweDJTQ2Js?=
 =?utf-8?B?N1BELzNnMnIwa3NTdW1TZGF1aG9HbkRGT1YrUGhBYnNjZEJNdXZORjVrRnd1?=
 =?utf-8?B?RGlHVVNXdldBendhTTNDazJELzNjaGE0OTVIUElEMW5zK0IyUllYYUplbWh5?=
 =?utf-8?B?MVRTU3pqcXQyaFcyV3BzZjA4L2U5RDNLSndNa0dJQmdybXhXMDVEMkhoN2lq?=
 =?utf-8?B?R05qdzFEOHMzWUR6a3VXOFg2ZER5TkdBSDFUZU0rbVFSMEpvNURiVHg0QW1x?=
 =?utf-8?B?Vm10VGpEc2ptbEk4SkN1bjVtYjFPZGl0SmhpQ0VVR1Z1SEhjTEVFRlM5bXJj?=
 =?utf-8?B?YkZDakthNUo1U1V6enpHWnRUaEZDd1ZyQmJJakp5YU9YT3IzczFvNmEvU2Rz?=
 =?utf-8?B?a2RwOWI4cXJBZWF5eWlMVzlIT0VBblplb3NqNnd5UjBvbng4SVlteTZ6K1hF?=
 =?utf-8?B?Wk1tQTNuc01HZDFhREFMbnExRWR5SWVHc0ZNSkFVUzk3WEN0aHBCOXp4NFRt?=
 =?utf-8?B?ZjJtSlNMcjVmcTdIWm5adys4b2w0c0pqeW1qU2NYQ3dwTjQyWUxGSXp3NThx?=
 =?utf-8?B?ZHNlR2MrbTRlN3ZLZ2tpZnQ0YXMyT3EvSnpHVmlrZkRzVlBNa3Z6Nkpxd1k0?=
 =?utf-8?B?SkwyQS9tMElBeHB3a3ZNdlc2czdNdEdxMTUxaWNhK0JVMXkzdjFyRTRKQnJR?=
 =?utf-8?B?ODJWT2UrcVQ2dEROcnhEMk9FRnZLOHdpdjVReWEzbUhjM21kbVlmNlVDeDRo?=
 =?utf-8?B?aFprcWhmT21iM2xBQk1LSDJJTHFRY0FZbG56NjNwMGp3WVcxd1NTTk1KTkZL?=
 =?utf-8?B?RUpIY1BFSzhqcTBqaTJVallRdVdKaU5KRHhBRFRQdmQwT09QRi9JU3RHYkRS?=
 =?utf-8?B?a1AvYytRT09yL0NBS0xJM2lLS09JUlRwamxBRmJRaEFqUE9NY2toSzFKZG4v?=
 =?utf-8?B?LytZS3pKSWwyNUtMN2V2RWk1UllMNElja2Z0TDFQeGdENytBVWh6RnVlUG40?=
 =?utf-8?B?QitoQUZPY1ZLZlowMXQyV2xlOWhLZXFQN3VaWHMybCtiZmtvaWthTkZwRzBm?=
 =?utf-8?B?bXZNZWxxS25VTVRVZzBUSG5KMWZvTUt4SGRNSnUrRHpaRXJsNWRzUE1vTVJn?=
 =?utf-8?B?M2tLTTg5VzhNQXBPY05jazlWakRXNjhuK2U5Uy8veDJSL2daOTJCU0k4ZkN3?=
 =?utf-8?B?Q0pCZWpUSVZjMlNtWXJnQlZsdDBCTTU1TUxTV0VpdkhSdUFkcURoUkNqV04v?=
 =?utf-8?B?Nm52MFdTZ0laVEM2NFR2Nk01TGp3ckU1NE9NMTUreTB6U0gzZmp0YU8yNktK?=
 =?utf-8?B?S0FpWWZvSGN3Rklzc2hUczBSTkt6cFBNaFpWMjBldXhycHdpKzVYelVXT0Vq?=
 =?utf-8?B?MDRPaGVETnR6OEhNVW01Z0l3emQ2QWJHSHNKSythZ3Zlcnk5QUc5MnFZc3c4?=
 =?utf-8?B?azdHTHh5TmZudTVVYWt4QlBiRnZPY3NrRFZONkxGTmVaeVZ1UDlBMTdOQUxX?=
 =?utf-8?B?bTJuQ3h6VW5POUVJTENIQ3JqMEkrVjBHYVFxN29PZ3R0TmJjVEM5K095MnU0?=
 =?utf-8?B?M1Rrc1k1YzFBZDNHMU9DdGJiaDBmQUlwSGkxZnVjQnkyWHhlVjNBT2tjZEQ4?=
 =?utf-8?B?cGdkcjBKcWJlcWYvSlVJR0xiM3VVVUl2N09pWlpHM2xsUmUvOGxoN0Zyb3Q5?=
 =?utf-8?B?a1hsb2dFUUZIVDN1UkhmNjVsR0RCOXhucTA0dXpRTlVWMHhpZVJFN2V4bFRV?=
 =?utf-8?B?WmV6Y1BOWDY1bktGZTRlYVQ3SG5iZ0MrY2t2OXl5WHdIdkpaWWtuY1VRRGlL?=
 =?utf-8?B?TWZzSi9oMjlBYnB0bk1tVUtBQ0JaYkdZbFZubEZtYzJsY0pMbGMzT0srUnBn?=
 =?utf-8?B?TXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 938d97fb-f2f6-45ee-bd95-08dd5be8605b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 13:19:36.3193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Jg90eZHwiJt+GOTdCkPc4r8yGEbhouedcJA0hG7zOzRPyT35PaippCQZREsXpKt+31+iU2BbCAm02V3qyHlOGnZd79LPg4x35tQcjCDG6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9829

SGkgTWFyYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEts
ZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyNSBGZWJydWFyeSAyMDI1
IDE1OjUwDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDcvMTFdIGNhbjogcmNhcl9jYW5mZDog
QWRkIG1hc2sgdGFibGUgdG8gc3RydWN0IHJjYXJfY2FuZmRfaHdfaW5mbw0KPiANCj4gT24gMjUu
MDIuMjAyNSAxNTo0MDo0NiwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gUi1DYXIgR2VuMyBhbmQgR2Vu
NCBoYXMgc29tZSBkaWZmZXJlbmNlcyBpbiB0aGUgbWFzayBiaXRzLiBBZGQgYSBtYXNrDQo+ID4g
dGFibGUgdG8gaGFuZGxlIHRoZXNlIGRpZmZlcmVuY2VzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+IHYz
Og0KPiA+ICAqIE5ldyBwYXRjaC4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvY2FuL3JjYXIv
cmNhcl9jYW5mZC5jIHwgNjgNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4g
PiBiL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+IGluZGV4IDI2OGI5Yjg4
MzVjNC4uZmNmNWNiOTNmNTdjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9yY2Fy
L3JjYXJfY2FuZmQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQu
Yw0KPiANCj4gPiArZW51bSByY2FyX2NhbmZkX21hc2tfaWQgew0KPiA+ICsJRUVGX01BU0tfSUQs
CS8qIEdsb2JhbCBFcnJvciBGbGFnICovDQo+ID4gKwlSTkNfTUFTS19JRCwJLyogUnVsZSBOdW1i
ZXIgZm9yIENoYW5uZWwgKi8NCj4gPiArCUFGTFBOX01BU0tfSUQsCS8qIEFjY2VwdGFuY2UgRmls
dGVyIExpc3QgUGFnZSBOdW1iZXIgKi8NCj4gPiArCU5UU0VHMl9NQVNLX0lELAkvKiBOb21pbmFs
IEJpdCBSYXRlIFRpbWUgU2VnbWVudCAyIENvbnRyb2wgKi8NCj4gPiArCU5UU0VHMV9NQVNLX0lE
LAkvKiBOb21pbmFsIEJpdCBSYXRlIFRpbWUgU2VnbWVudCAxIENvbnRyb2wgKi8NCj4gPiArCU5T
SldfTUFTS19JRCwJLyogTm9taW5hbCBCaXQgUmF0ZSBSZXN5bmNocm9uaXphdGlvbiBKdW1wIFdp
ZHRoIENvbnRyb2wgKi8NCj4gPiArCURTSldfTUFTS19JRCwJLyogRGF0YSBCaXQgUmF0ZSBSZXN5
bmNocm9uaXphdGlvbiBKdW1wIFdpZHRoIENvbnRyb2wgKi8NCj4gPiArCURUU0VHMl9NQVNLX0lE
LAkvKiBEYXRhIEJpdCBSYXRlIFRpbWUgU2VnbWVudCAyIENvbnRyb2wgKi8NCj4gPiArCURUU0VH
MV9NQVNLX0lELAkvKiBEYXRhIEJpdCBSYXRlIFRpbWUgU2VnbWVudCAxIENvbnRyb2wgKi8NCj4g
PiArCUNGVE1MX01BU0tfSUQsCS8qIENvbW1vbiBGSUZPIFRYIE1lc3NhZ2UgQnVmZmVyIExpbmsg
Ki8NCj4gPiArfTsNCj4gDQo+IFBsZWFzZSBhZGQgYSBjb21tb24gcHJlZml4IHRvIHRoZSBlbnVt
cywgaS5lLiBSQ0FORkRfLg0KDQpPSywgd2lsbCBmaXggdGhpcyBpbiBuZXh0IHZlcnNpb24uDQoN
CkNoZWVycywNCkJpanUNCg==

