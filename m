Return-Path: <linux-can+bounces-3933-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E4EAF13EE
	for <lists+linux-can@lfdr.de>; Wed,  2 Jul 2025 13:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FB33AB131
	for <lists+linux-can@lfdr.de>; Wed,  2 Jul 2025 11:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1D626057C;
	Wed,  2 Jul 2025 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="um6lSCID"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011050.outbound.protection.outlook.com [40.107.74.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0FB246781;
	Wed,  2 Jul 2025 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455912; cv=fail; b=RcUDDLHkRtZbRPTOXT9JVGshe0maRiNP3+WjtkEMPeHWdQOx9vMzJ2l683K626RZa/wlwyRBebdG4bmxKUG8Gi9QcqFtkrw4WWpmeRgKgMjywAMsuYTkDr3vJ1Wceoha69F6cepALAzVHNm2PfLiqlvXiHMsVtMbebdLl0tOxjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455912; c=relaxed/simple;
	bh=VuXgY6i2MGYKzTgRniIKvFpKn6SVHJXO1RuLH/Gm7mg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dvlL0is46mBFbJC9yeQ8e5+vS/lzjbvv43PrEVNWWvWNN+6cCBSa63Wp0rpNtYcOoCYNFixLq7TH3yIynllVmWRx8sC5ytV5OT2A7n4Xh3jEI7Dymd2qrXIbR3vkjOJBtS0/Wg51xH97v4jsOdFK+rjPjcAnSvHKQOcyJiXziMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=um6lSCID; arc=fail smtp.client-ip=40.107.74.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxQDZmMqoAFTRa87C/L3k/aZWQxyvxwPMnEDcxO2b+SIu/28XcS4MnH49/mJA/MqaZMVB4FFOhjeAKyquKNKeCraUOWMYG0GFGBDXlfC+7wgElOykHDHiHQnPir5Yda+JM/uaH0JaphthDXi7i+9m54xMBNvuQjkRm+v6s+JzqQzMZAqPD3IulajxNhKrPSvLlqeE9as1KXP6kfgerkZxoFd+bbs9SQvVi2meFKMeKtwipFXJJ04+M+YCTPY2Q398nfYFhXCU3hyUmK8xC+/jLr+YTFaS/cjEWdQXvo8krT/wnCgfifHzx7GQdLGnMPtLb7BEA5TF5hc9m0QWPQnnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuXgY6i2MGYKzTgRniIKvFpKn6SVHJXO1RuLH/Gm7mg=;
 b=UvFfl9AGtqc6tWtyLbXf6TYWPTqZhq4FKyEKuyCqLig/IWEdVdqzKNZZG1ig6oNFwZZayHWr/4ZBGRCS2o6DLyUsST5/oLCIi/TOv2UjyS3fejmrI0r5XKV0bnAOdAAP6abjOxeQFQ1GWtdvRcMZAuZMCiAiTuvbUGKf1JsDTHokIuK4V1rvBXwl3Ts68duDQ/CvOvV0yA9qv/VRogqiWwA/MztBrra++v/HUmaDHj+QIboebEnhw9IXnOhqj7kb9aoueuSb665hUfim1zoJXPk9hL62B39MXVkTIBSfqx+sMeOURorkPWXZgXdzWbvnKl30OP17tvPgOiO+Rp1DEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuXgY6i2MGYKzTgRniIKvFpKn6SVHJXO1RuLH/Gm7mg=;
 b=um6lSCIDxTowxE4ROHwNjq6e5DjIjMDms1O2dklbgZkjj5UxsZ2KdVtJ8adKj8rGQbs+8JW3b3DCCJvuE/wz/fryT/C2Dr67sqCkHBkx1bIplE2u6f29dpIe0rNEDvsFh78/pKMLZXfbj1DB+zbWdwEtWMvepQr+xeOuXYLV8w4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB12110.jpnprd01.prod.outlook.com (2603:1096:400:449::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Wed, 2 Jul
 2025 11:31:45 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 11:31:44 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Magnus Damm
	<magnus.damm@gmail.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH] can: rcar_canfd: Drop unused macros
Thread-Topic: [PATCH] can: rcar_canfd: Drop unused macros
Thread-Index: AQHb6QcZAMGsFD8KbkOy5jLau1TaSLQedkYAgAAiHDCAAAYHgIAAFbyAgAADN6A=
Date: Wed, 2 Jul 2025 11:31:44 +0000
Message-ID:
 <TY3PR01MB11346E9BC53FC2AEBC0E37CFE8640A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250629150417.97784-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdXK9ZBpgPSE32Zya-nVBXQw25=2-g5pnixjFOoyOkrrvg@mail.gmail.com>
 <TY3PR01MB113463762D1EC916BDE1B7BA28640A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdUcTbM_pbxmbb-kuWf7Kgb=94QtPzRVJZaUrezL3wwN6w@mail.gmail.com>
 <b0e1655d-1efc-419c-8acf-f9a6243e56d0@wanadoo.fr>
In-Reply-To: <b0e1655d-1efc-419c-8acf-f9a6243e56d0@wanadoo.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB12110:EE_
x-ms-office365-filtering-correlation-id: 576f8db0-0878-44b5-492e-08ddb95c062d
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ry9ydUdoYnRJZytDNi9vY2phSk13OU1OM1ZwNktjTGdzdzBpdkh3SnYvUWtS?=
 =?utf-8?B?K1E4MUFOUTl1VWZ4Snd3L2RvRVdzMld0Vm9jdWtKWnFkdXVwcGt2ZUNGWkZ6?=
 =?utf-8?B?eWtrY1ZrZWJNUFV4MWhKRzVJVWpuUTltYjVoMFNrRWVGZlI1YmtWdU1SMnpn?=
 =?utf-8?B?UXRMaGVNbWI1UENmVDdSYXJFSXhMWHp5R3REd0Fnd2tMVGdSVzY0UE1zWXZr?=
 =?utf-8?B?UlkxWXZTMnVqWjVHeTZsdndwVGxKL3RwcUpxbi9GK1F2dHZvbVhPTkdBR3JI?=
 =?utf-8?B?dlZZMWJ6OWpUUUVVVHR3R2tJY0paNWU4SnZiZmNIekdvTnEremcvcUQyOHY4?=
 =?utf-8?B?WlRhZkY0WTlWV1IxYXA1Q3l0MkxnMUNiMnlUYnE1YTA4N2picXBFc2FsMjcy?=
 =?utf-8?B?WXFxZ1RUc2lRMkpwdUtBZTA1Q3ZNcmtLK1dHUFBZQTJIUkp5dWFmRnhqeWF3?=
 =?utf-8?B?OGZDdE5wbzBmREkyTjQ2ZnJWQVVUeEg4N1RaeGtIMUpGKzVHbGlNSWw2K3FN?=
 =?utf-8?B?bTduM3E4eXpucTdFcTJoVUdtM054UWwydkJ1bitkTU1heGNiNXdRcXJ4SWla?=
 =?utf-8?B?dzB1K1Bud3ljTERSNFJ4V01NWGVVN1FkZGFqNDVqbVEwcDgwQW1MRStBdC9o?=
 =?utf-8?B?clFpNExuQjV3S2h1Z2ZTOUNhSzVnK1B2b0MvSnd5NzRONjVFeS9ESmRSRjlE?=
 =?utf-8?B?Z0xyd0xQOFZGcXBDZXQvemJtZnZJejZ1ZUZxSVU4YUEzakNGR1ppd0MrK3Rq?=
 =?utf-8?B?azlPamkyQ0lRMjZWcVoyK1M2bVBMRjdIb1pqeTlQMzdxd0pLVHlzL2pWNWNK?=
 =?utf-8?B?L3JVL0FMd0JtNHZ0WHJMcWRKMk5sS3ZlVTlDZlpOdmlNS0FIVndDdUQ4U2lh?=
 =?utf-8?B?bkM0QW16ekRIMDJMTzByTTB4YlBGQkljQUNMYmJNRVdCck4yUUg5TXVNeEZV?=
 =?utf-8?B?RnRSMDNRTUdLcW8xc3FUSWQ4U1djbUp3eHpHR2hGR2NvL243ZkFNVmZHcElI?=
 =?utf-8?B?aDRNR09LcHg3Ym5aRXpDcTczUGpob3VzaWlvbk15dmh6S1l0UzMxZDMxd3pR?=
 =?utf-8?B?S3BpT0l5Qy9HS2NzZ3RLUTlQMDVkSWhidTFybENZQUN5SElldXZORFl4eVlT?=
 =?utf-8?B?RW50eTBBZmsreUNUR002b25QNEJOdXFRNGlXV09BS3FkK3I1OHNHR2xIZHVo?=
 =?utf-8?B?NlhxaDJWK3VocHpKampKVmpaVjBITmhnRzkvSTFsS0tNeDZNdlAzblVZU1NI?=
 =?utf-8?B?MHQ1Q1BxUDI4U1RCaUJYRVh1UlNGZ3Exbjg3bW1ZZnlxNEpPUUxsOWk0b21q?=
 =?utf-8?B?UXRBT0RZekx1NjRzb1k1MTFSOWZpbVVHTXVTVEZlRFZkRmcxejhsQ2l3TGYr?=
 =?utf-8?B?QkpXOExaNThXTjQwWjBvOFJKaGNqWVl5UXpGZXFYb203UnM5aEhKL29MT0JH?=
 =?utf-8?B?V1llbGIwL0ZVcm5OTEJrb3owb3JXRWYyRGdiVmNjOXZhMlZtK0NHSThoTll6?=
 =?utf-8?B?N3hoVUVTOStvcGduVmdBVnZFaEZuNzdXQThqa3EweVZjSTdSNVF1Y0k5UW9z?=
 =?utf-8?B?a043Z1FPNUUycVhPUW9ScDlzeGhjSnFEaEs0U1BxdjIxOS9kTjkxSDZNc294?=
 =?utf-8?B?b2xLTkVKUFdETFhPSFpnQ0tGeDk1ZFJxNGNuN3JSS3Z3OU1xdDlvRWRGc2Nj?=
 =?utf-8?B?UDBWdnlCSE11T3pvZm9lZ1BHM1pMUUlGUnJXREdTVUJmUHFQa205cmtrUWZ1?=
 =?utf-8?B?eEY3M0dRNFhpdnVYRTFMamdOYjlLYWNPa3RNQWRoR1ErTDc0ajNIcFhQekJ5?=
 =?utf-8?B?ZnZDY0pXWloxVmd6a1g5bkl6YkQ2WUF0dTNvUEUzUlR1dzM4TFg3UWpBOXkv?=
 =?utf-8?B?SHdlcVp0N21tNDQyTlEvMWpQUWZOb2FBT1FtQ201Y0lRdENibHFaWWFiUXdn?=
 =?utf-8?B?RUpFbTZrTy9Bc1JyTERjUFNlRkprbTgyVzh4RksreGlNeGFvNjI5M1hjZytI?=
 =?utf-8?Q?hSB6AbPFML72vte+YL8iRDQAoBm6DM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXR4OHdmYmFDejIvaEM1YzJQbjBnRlZPQkdRbzZvZEhoUHdaVlp5SHZFN3VG?=
 =?utf-8?B?RmZuOG9BbEt1ZC9JZk5SZGlKUUNpV3J6UXk0OUFSUzFDeVdPQTB4S0tFcVB1?=
 =?utf-8?B?T3JobXRrUUJBdFl4cGN6ZUJUYzBuWFJpZFhtYU52RHZXeTRURGZ3dzdLWmFY?=
 =?utf-8?B?QkJ0MGk3dmVzWmlEMytPZjRNMU92ZHFGR0NJdW5UUlFOdlQzK3Bwckg0Sm5l?=
 =?utf-8?B?TkQ4Qi9Id3FBWVVkSUUxZlF3TStHTDRJR1dSRFNQL2F0N3VXOE9iMy9sbjBM?=
 =?utf-8?B?UTR3Ris5RmxUZ2dSNGRldnpyNE5TU0tBT0lKTW9nbHVYUFVJZ1hlMWpnYzVp?=
 =?utf-8?B?U2dTNDBZOUcxQ1J2WDNRUkZhZS9vYzlybnZKTzJPWGphbnhISjVjQ2lQK2dn?=
 =?utf-8?B?OFRkOEJKVzBkanl6dkx0ZU9XYTlVOWJQZnZnUGxReVlpcjcxbWtDUlQrMEpw?=
 =?utf-8?B?cXQ5WTNsblV5SHpFL1hhNHZ5QlBNc05hU3dRRDVxQ3hnbTZZMEZibjU0L2Iv?=
 =?utf-8?B?NS9jajd5Z3RBdUVjTkFUL1czczZiMG9pS0M2L3BFZnM0WXpMR1g2cVY0a242?=
 =?utf-8?B?ZVNNczNKOCtkcXN5N1dGNjlLZERHeHVXeHRWQUw2ekVlNDhXUDNZMHZ0MXBK?=
 =?utf-8?B?cnBHRTJnTTJRUTlHL3dOcVBVbkxVK2VpbHNxbTNJUTlqSzAzcWNUaFdGTUNW?=
 =?utf-8?B?eG5jUFZTUGZFa29Na1prUExZSHlJdlIwekpkemR6RWsrWXNzYU96L3VaaGdE?=
 =?utf-8?B?UDlpaWFnZkl0T2J3WHlWWmtyY3RmcEkyRW00Uk9wR0wya1ZrdTRWZVh3YzdJ?=
 =?utf-8?B?R3lsdWZMTXk3QVF3blZGbUh5dVI3UmczeG1wdWU5SG1qd2lVNXdTT0ZZblRP?=
 =?utf-8?B?QWJUdWd3Ri9CZkRxZ2ROY1Q4TDhQTnhXNEMxQS8rUXgxR2Vycm5lUEIwdDhp?=
 =?utf-8?B?YVVZQWcyUGM4UE9BNm03NGUwajZGZlY4OUh5dkZnT1lVVTFVQWJZNnRBS2Vs?=
 =?utf-8?B?KzQxQnpoeGFndkxUZkVHSTdhYmlMbVhwemgzRnJPdmpGNHJkaTVjMGV3WGNq?=
 =?utf-8?B?QU5uSVdQZ0IzQXRrUnNHZmIxMlBFd3EwYXR6K1Nka3dwZVlLTWdPZEE0OTNQ?=
 =?utf-8?B?SUFTaE10Nk5LWC84SDZIckRVcE5LamluOVlDYUlIWXBCanI3K2t3OTdnRFZQ?=
 =?utf-8?B?QkJscnZOdEx3TDZjNmIwK2ZpZmZuL1g3NHRDbVdlbUVHamlLUDBJQlBBNWt0?=
 =?utf-8?B?NXJ0MVBmN0ZKRmV5Z2JLT1k2cFRTRG56TXZ5TXlwR1I4U282U0RYbFF6YlVG?=
 =?utf-8?B?VXdoT1gxeEhqeEN1dHhtS2FQTlgwSCtpd2lCcjVNaGUvVnhncGd5c2RIdlNr?=
 =?utf-8?B?ZHpTc1I2cmZ1ZkdiUmorV2N2cWZmS1c1NkpLeEFHT3UzQzI4cTZVVVFBcWND?=
 =?utf-8?B?M3NWN2tmd3RMdEtCRlhyRDlURlhiSzFQaUQwY3BRcXN4ZE13OGY0bVM0K1dI?=
 =?utf-8?B?b0dYYkdkUXU0U0VVekJsaUtpcjQrbExBcWR5ZjU4eVV1Z2tJbDRXQkltNFFp?=
 =?utf-8?B?WXE4NU4xVWl1K3ArYjFvUVNaa29wdjBTWkYvOVFwd0Ewdk9MdEVhOGIwZWd6?=
 =?utf-8?B?Zk5hUjZjV1BLVXlVWmUxdEVNZHpvRnRrR3hCRXZGM0FURFFiWWN4bEJUM1FG?=
 =?utf-8?B?ZVdaZ01tdWdlK0ZLTGYxcVFPL1RVWEdxSHFwWEw5Y0QrS2NIUWRXVXJnT1Iz?=
 =?utf-8?B?b0ZRN0RSbC9JWVhzUG9VeTd6Y1Q1ZW5uNU96UWgxVzhVWTBkM1BpSUtLVFVO?=
 =?utf-8?B?bFZOUnR6TW52MW8zK29tU05Rc2ZaN3dRSmdlWGdEWlBsTndJSHRYcmtvV3g4?=
 =?utf-8?B?Z2d2RWtsOUtRRWZwSG91MTNJTVpnckFrblJsQ25uWGJ3OUg3ZGJEVUEyUkkx?=
 =?utf-8?B?YTJmdTh3a3luWmNXNTVCeVExbmh2THpRb2R2Wit1RUIrTUE1aDFqYnFNa2J3?=
 =?utf-8?B?aUw1Qm1PeHRHWUlwNU9wNjFLbkNrUnNjem5SOXEwOGxYTUNVMXpNRHhhbGIr?=
 =?utf-8?B?RGVBcmNQUkI4d09ocmgxVTNGeEtKT1lGQy9oNk5FVytMS2drbk5jZmJPWjha?=
 =?utf-8?B?OGFqclpMb2duZjBWMGl3NTR2a3doOWRHanBpQllzb0lmTXh0cWJhb1ZBb2xr?=
 =?utf-8?B?b1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 576f8db0-0878-44b5-492e-08ddb95c062d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 11:31:44.7767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ipz+6DXswpPg7GRZ2Uh9Vy/Yf8A9g1TkSPUxnSNiFzD+RqEkfs86bPBqhI3cGqzOwCQkk7L843bd++Jwq5R73jIhIlFYnatzK+BwtndnX4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12110

SGkgR2VlcnQvVmluY2VudCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBWaW5jZW50IE1haWxob2wgPG1haWxob2wudmluY2VudEB3YW5hZG9vLmZyPg0KPiBTZW50OiAw
MiBKdWx5IDIwMjUgMTI6MTkNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gY2FuOiByY2FyX2NhbmZk
OiBEcm9wIHVudXNlZCBtYWNyb3MNCj4gDQo+IE9uIDAyLzA3LzIwMjUgYXQgMTk6MDEsIEdlZXJ0
IFV5dHRlcmhvZXZlbiB3cm90ZToNCj4gPiBIaSBCaWp1LA0KPiA+DQo+ID4gT24gV2VkLCAyIEp1
bCAyMDI1IGF0IDExOjQ2LCBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdy
b3RlOg0KPiA+Pj4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9y
Zz4gT24gU3VuLCAyOSBKdW4gMjAyNQ0KPiA+Pj4gYXQgMTc6MDQsIEJpanUgRGFzIDxiaWp1LmRh
cy5qekBicC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4+Pj4gRHJvcCB1bnVzZWQgbWFjcm9zIGZy
b20gdGhlIHJjYXJfY2FuZmQuYy4NCj4gPj4+Pg0KPiA+Pj4+IFJlcG9ydGVkLWJ5OiBWaW5jZW50
IE1haWxob2wgPG1haWxob2wudmluY2VudEB3YW5hZG9vLmZyPg0KPiA+Pj4+IENsb3NlczoNCj4g
Pj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvN2ZmOTNmZjktZjU3OC00YmUyLWJkYzYt
NWIwOWVhYjY0ZmU2QHdhDQo+ID4+Pj4gbmFkDQo+ID4+Pj4gb28uZnIvDQo+ID4+Pj4gU2lnbmVk
LW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+DQo+ID4+
PiAgICAgI2RlZmluZSBSQ0FORkRfUkZQVFJfUkZETEMgICAgR0VOTUFTSygzMSwgMjgpDQo+ID4+
Pg0KPiA+Pj4+IEBAIC0yOTgsMTYgKzI1NiwxMCBAQA0KPiA+Pj4+ICAjZGVmaW5lIFJDQU5GRF9H
U1RTICAgICAgICAgICAgICAgICAgICAoMHgwMDhjKQ0KPiA+Pj4+ICAvKiBSU0NGRG5DRkRHRVJG
TCAvIFJTQ0ZEbkdFUkZMICovDQo+ID4+Pj4gICNkZWZpbmUgUkNBTkZEX0dFUkZMICAgICAgICAg
ICAgICAgICAgICgweDAwOTApDQo+ID4+Pj4gLS8qIFJTQ0ZEbkNGREdUU0MgLyBSU0NGRG5HVFND
ICovDQo+ID4+Pj4gLSNkZWZpbmUgUkNBTkZEX0dUU0MgICAgICAgICAgICAgICAgICAgICgweDAw
OTQpDQo+ID4+Pg0KPiA+Pj4gTm90ZSB0aGF0IHJlbW92ZWQgcmVnaXN0ZXIgb2Zmc2V0cyB3aWxs
IGJlY29tZSBhbm9ueW1vdXMgZ2FwcyB3aGVuDQo+ID4+PiB0aGUgcmVnaXN0ZXIgb2Zmc2V0cyBh
cmUgcmVwbGFjZWQgYnkgQyBzdHJ1Y3RzLCBjZnIuIGNvbW1pdA0KPiA+Pj4gYWIyYWE1NDUzYmI4
M2QwNQ0KPiA+Pj4gKCJjYW46IHJjYXJfY2FuZmQ6IERlc2NyaWJlIGNoYW5uZWwtc3BlY2lmaWMg
RkQgcmVnaXN0ZXJzIHVzaW5nIEMgc3RydWN0IikuDQo+ID4+DQo+ID4+IE9LLiBCdXQgcmVtb3Zp
bmcgdW51c2VkIHJlZyBvZmZzZXQgaXMgbm90IGFuIGlzc3VlIGF0IHRoZSBtb21lbnQsIEkgZ3Vl
c3M/Pw0KPiA+DQo+ID4gTm8sIGl0IGlzIG5vdCBhbiBpc3N1ZSBhdCB0aGUgbW9tZW50LCBhcyB0
aGV5IGFyZSB1bnVzZWQuICBSZS1hZGRpbmcNCj4gPiByZWdpc3RlciBtZW1iZXJzIHRvIGEgQyBz
dHJ1Y3QgbGF0ZXIgaXMganVzdCBtb3JlIHRlZGlvdXMsIGFzIHlvdSBoYXZlDQo+ID4gcmVtb3Zl
IGdhcHMgb3IgYWRqdXN0IHRoZWlyIHNpemVzIChsb2wsIG1pbmQgdGhlIGdhcCA7LSkuDQo+ID4N
Cj4gPiBJSVJDIFZpbmNlbnQncyBiaWdnZXN0IGdyaXBlIGlzIHRoZSB1c2Ugb2YgZnVuY3Rpb24t
bGlrZSBtYWNyb3MsIG5vdA0KPiA+IHRoZSBkZWZpbml0aW9uIG9mIHVudXNlZCByZWdpc3RlciBv
ZmZzZXRzIGFuZCBiaXRzPw0KPiANCj4gQ29ycmVjdC4NCj4gDQo+IE15IGNvbW1lbnQgcmVhbGx5
IGNhbWUgZnJvbSB0aGUgZmFjdCB0aGF0IEkgZGlkIG5vdCB1bmRlcnN0YW5kIHdoeSB5b3Ugd2Vy
ZSBvbmx5IHJlbW92aW5nDQo+IFJDQU5GRF9HQUZMQ0ZHX0dFVFJOQygpIHdoaWxlIGtlZXBpbmcg
dGhlIG90aGVyIHVudXNlZCBtYWNyb3MgaW46DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvN2ZmOTNmZjktZjU3OC00YmUyLWJkYzYtNWIwOWVhYjY0ZmU2QHdhbmFkb28uZnIvDQo+
IA0KPiBUbyBiZSBob25uZXN0LCBJIHdvdWxkIHN0aWxsIHJhdGhlciBwcmVmZXIgdG8gc2VlIHRo
b3NlIHVudXNlZCBtYWNyb3MgcmVtb3ZlZCwgYnV0IGl0IGlzIHNvbWV0aGluZw0KPiB0aGF0IEkg
YW0gdG90YWxseSBmaW5lIHRvIGxlYXZlIHRvIHlvdXIganVkZ2VtZW50Lg0KPiANCj4gS2VlcGlu
ZyB0aGUgdW51c2VkIG1hY3JvIGlzIHRvdGFsbHkgbmVnb3RpYWJsZSBpZiB5b3UgcHJlZmVyIHRv
IGRvIHNvIDopDQo+IA0KPiBNeSBuby1nbyBpcyBpbmRlZWQgb24gdGhlIHByb2xpZmVyYXRpb24g
b2YgZnVuY3Rpb24tbGlrZSBtYWNyb3MuDQoNClRoYW5rcywgSSB3aWxsIGZpbHRlciBvdXQgdGhl
IHVudXNlZCBtYWNyb3MgYXMgcGVyIHRoZSBkaXNjdXNzaW9uLg0KDQpDaGVlcnMsDQpCaWp1DQo=

