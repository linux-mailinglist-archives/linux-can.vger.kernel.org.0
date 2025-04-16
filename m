Return-Path: <linux-can+bounces-3416-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13101A90867
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 18:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DBF5A3292
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 16:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4097211276;
	Wed, 16 Apr 2025 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="SabzfSYv"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011020.outbound.protection.outlook.com [40.107.74.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252EB20DD40;
	Wed, 16 Apr 2025 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819815; cv=fail; b=u5XkSSmP7+C0+t+0yn81qngpo4IznEXcTzBzRQD9ayJemjYMjHYvMikjgQ/syJphJvNitgvr0Peq63pJgqcvbWKoQpS4arL6Lo+ppxOdueclhOkO0J4bxPdZHGXztNZPbYCaA+FJizljScC1VXTezftSk5eO2D3h7ycuTY9sPrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819815; c=relaxed/simple;
	bh=55gsN8CPlnJeppr3c1ANtFNELmD2QJaiEoMUdYKK6II=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=alnfszizRz6b6SN+6/LPzCBqIIFhxH54eN5REInPfqBjPAC1B/vzXPdW6hR7LQyBoWUsBOY2d5on9Ptl59q6TJ7zWel9McO7p8GKFNpZgto8m19pOutcumpJfA4jiPLd8gNy5NhJMqwSQWv7JQcBk0ws2WGXTiK9IcUfYjf8v14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=SabzfSYv; arc=fail smtp.client-ip=40.107.74.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLM7jAMHWMhKt8WGRKVx5QBnIHhKuZyJ1Zz3/KUOgtByknEumdzfMGBJjCag1HAuFymjrsc8iaFeqo5tJYxWdd5Tyhb7Y9aSbBX7/0WhYbqyPCKfRIWCyylMd2kePQRjRCP6WWDaULWdc85b3f6zFoSvd5xwkCB0D6D+VTH3t4Ttq+tH3lEYFE8TLo3FlHLnz0sUgWJbIynESwcUn9IVTSujOKeYVtHfw4fakw+XVqwpAlMuiS2n4nXRl+SX8fOfXzuiPelzIc9jIDlL0yqHUYNvYJWvwY56uH9lu6hECllLUwJG+d5vjNDpxQpefi0q2aZt/o15WT08ONqhbn3fhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55gsN8CPlnJeppr3c1ANtFNELmD2QJaiEoMUdYKK6II=;
 b=pnNNP0P0q4tNMEkdAqEUy1dIJb7ibJro0ntUCMU15yUuFgXEROVS8l6Lk24U+7//MCKFGq01dl0bkaGDGXkfOZgBIjqs32VY8nqxg9XH/fJsmVaXvMX+psK43X8V0icZr3fciJdqHOqtGDIQhn58dvZ3aa9OzilmgsxcTnc7P4oSIp043bbndtEKjk5xH/so0kFpySedZzTMeC918tTe6SEePRob36DOmwrCTv8Nb5bYq7t8OFM8/+02Y3HT8x+AL9YNOE7c4nohg+B1kfH81AoeeaX9ZOV43Iyjn6kn2ZJ0kFfozqKGtRUu2CzdtSxr/QMqKeaua3lCwGkLwphKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55gsN8CPlnJeppr3c1ANtFNELmD2QJaiEoMUdYKK6II=;
 b=SabzfSYvup2ALVLUpmpCJ0IUPBu70eRKv/WNETDD7tYspcSuG6wAj6xE0x0T99OgjsR9pKzAb8kq8zaSjGiuS+w/zHpzj3OIQ/LEM0kPMN2MM/+3d+qN8XSHWzLt/TPuQqiYK50AYUw7r/CItzf5z7Gz/qBVJ45amMl4YJ4Avmo=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB7801.jpnprd01.prod.outlook.com (2603:1096:604:17b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Wed, 16 Apr
 2025 16:10:06 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 16:10:06 +0000
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
Subject: RE: [PATCH v8 15/19] can: rcar_canfd: Add struct rcanfd_regs variable
 to struct rcar_canfd_hw_info
Thread-Topic: [PATCH v8 15/19] can: rcar_canfd: Add struct rcanfd_regs
 variable to struct rcar_canfd_hw_info
Thread-Index: AQHbo7lIX1XOD6wsTkWFdJ1DWNFd/rOmZmIAgAAl3qA=
Date: Wed, 16 Apr 2025 16:10:06 +0000
Message-ID:
 <TY3PR01MB11346E23F6496CB99C4A9AA8886BD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250402102226.28032-1-biju.das.jz@bp.renesas.com>
 <20250402102226.28032-16-biju.das.jz@bp.renesas.com>
 <CAMuHMdU=mssA0pW_CX6V5BzhfQ9RA_OXmBTJ6TfA0uJntTFXOg@mail.gmail.com>
In-Reply-To:
 <CAMuHMdU=mssA0pW_CX6V5BzhfQ9RA_OXmBTJ6TfA0uJntTFXOg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB7801:EE_
x-ms-office365-filtering-correlation-id: 284565ef-a8be-450d-f4aa-08dd7d012767
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T0d0bGdJSUlLdFZEZXVIaHpmS1l4UU1BQmF5NDl1MmJIemF6aldaeEJoTFV0?=
 =?utf-8?B?bnRrV1BOTUFnU1FoS0JhRUFRTEpVQ3FTaXFRQkI1T0JrQXJUT0tlSmkrcml5?=
 =?utf-8?B?bk9wRXFnT2MyaVAweCtHRmh6dElBeVh6aFgvS1hPYit0NXNIMTBKWCtwQmg5?=
 =?utf-8?B?OEdNbjNjcUJJdEdMZE5WVFROQXdOR2MrRWhPQStTUVNkUm9rSFdsUU00NmpK?=
 =?utf-8?B?UDM1b1JTRjdHYmhMM0w2OFJycTU3ZTByQkZpQS82S2ZVWFVqQ016ajMzei9n?=
 =?utf-8?B?MnFJbFlSaUQzYTBjZEl2dTRBOWRkeUVNY21kZUVDN1laVzdXbEs0OVBYTEVO?=
 =?utf-8?B?YWNoWURwR2c5a2NqbGxqcnBuZUJRdVRXL1dhNG52ejZPNU9maGdkN1VmeXRo?=
 =?utf-8?B?V2NTSUM1dEcxeWI1TDBvL1RtMFc4U1BZZ2F0cmxyZ0VXeWhYNHlqQkhkY0h5?=
 =?utf-8?B?dnJtNVF4Y3l6c3N2bjIyVEQrZWhmY29aTmZ4QnBPSDN3eVNySktYWWFIZWor?=
 =?utf-8?B?dzloUlFoTFlrajQrR1JqaWJ4alB6ZXZhMHBjQ0swK0Q0ZnpjVjAxREtkTkNt?=
 =?utf-8?B?R0xPSWwvV0N2SWxkQm5LS1lVL1dLaGxUazlkWGcrdTN6UTZOTFc4SFVSZGJS?=
 =?utf-8?B?bW9lOXhidlZjYmw2OUdXK3BscE0xSFJ0aFdGYVFBUUkrand3czVSeGpaWmFs?=
 =?utf-8?B?ZkRnbEhhNUJpZGxvN2hHQngvZy85dWsxR0lFR3lBUnE1dEFGUzZJV3R1ZXc4?=
 =?utf-8?B?VmNLWkNITGszMmFxR09MM01HK0xtT3BpczFUYWQraWZuS0s1RW9UUFJPNTU2?=
 =?utf-8?B?YUxFRzNwVDVIbkVUbE9NeS8xS25jR3VZUEtmK0hjb1kyNDNXRGhhdEhaRzF4?=
 =?utf-8?B?aERYYzJrVXQ2TkIrSk9WSXJMZVJRdG9NMzVSZjREbVEra0xJUjFpc2xROVNH?=
 =?utf-8?B?YW9XUFVxbUNXODNVUlRXeVpRL1ZWZU1kSUJhMDZCTkVGQVBQdnJFOUtGbTcv?=
 =?utf-8?B?TlpNL0N0UlZLRHROSzdGR2xzREpnQVNZRFdkaGN6ckZWckFSNnFTc2YycWdt?=
 =?utf-8?B?Tm1IWDM3Vy95cUhwNjF3c0NGYU5ER0UzTDdOTmo0MERLME00cU81bEs3NHc0?=
 =?utf-8?B?bEVtSUlZSVAwQXpVV0hCS1NGMm1GUWN5T3Y5NFQyQmN6cnF3Y3RMTnVtWEpO?=
 =?utf-8?B?Y2pYUnIzQlEzblB5THZvaldicDBkeGhoUHhQSVpjNW4wcWZCRytSaDJITDVu?=
 =?utf-8?B?ZW5TQ08rL3pIQklYVzNTOEhnSFlzQnMyZGxGd29aNHZuYWlQK01idEZWVTNB?=
 =?utf-8?B?TUQrOXR5N1drbzZLZlpxZXRXcU9DRnZLRHY4R0xDaVBoZDIzSmlGOGd0WEhH?=
 =?utf-8?B?YWJOL2svandQdWVDQjJENm84VldUOVd5SENwN01tTVpjcExKNkpGMDBSdnFw?=
 =?utf-8?B?UXdhN20wTlpFSXdlZ2RkYm9vMmdiRHN6ZEtRSWlicnIzSTI3aVkvNGg2Zkxi?=
 =?utf-8?B?RFEvemEwUVNWRHA5MUp3aGhhVC9jTjduWVNKVXlseGQzenFUK2tnWFpBelRu?=
 =?utf-8?B?NmY4RExxTTZydlJ0b2VzZHRPTVNiaHFyRG95eURQZ3A5VTdPWXFLbUo2bzhq?=
 =?utf-8?B?LzJMd1pFNU8zZVZ3NzA0VC9VMEhSOExEWHBkTjZQbFdBd3BDQ0tUcXc5NlVn?=
 =?utf-8?B?YVFDbWlFcVBNanBXVW5IWDlQbzZvQitLSkhUUlFTU2xYNkpFNVNZTlFYcDJh?=
 =?utf-8?B?ZGRVTVVKQ3c2TWRDQ0RsbVh5bTIwWmRnRi84WFgxYU9meHRtOUFGKzZLSzh0?=
 =?utf-8?B?Uk9yMnJLZGhKRnQ5VS9SZ0lPUTYwcDZXa1AzazJCd2htUGljVlRTTHk3Ujdj?=
 =?utf-8?B?YSswU3BnUVRqYkxXOFNzdlA3Vnh1MWMzRmsyZ1ptaFowRUJTWkw4b0JMd1pN?=
 =?utf-8?B?c0dmNzFFOUJHWjNGemwyNXVIVVFYeUxlVi8xemZUSTRpMGtaYW95ekg2WjNa?=
 =?utf-8?B?Uk4vMEI5Z2J3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?amJTVHBYc29weStQb2pxeUppbkpML0tvOG1TNDJ3cExxUVF4Ylo4bm1BYm54?=
 =?utf-8?B?dDZOU2dDNkdFUmpBK2F2UElDU1BuOGlsMHdvVjdtTW5MeEVnQkcxVjMxOGtm?=
 =?utf-8?B?bDEwanE1dkUwM2paditqTGxKWGlUcmk0ODh6TU43cm8xbXRZSUVvQXAzYita?=
 =?utf-8?B?MTBZeWtnVjRRbEtHWExZOVJZMUdjVDcxbFlFMXJVbXJqd2tBUERKR0hxNytx?=
 =?utf-8?B?YnFMR2NHYzJBK3ZFUVVHd3NvM0orbVBJWEd2OE5PRld0TDY5QU4xV3pnWGhy?=
 =?utf-8?B?aHFRMllLQnRBKzFFOWczaUM5aHI5bFd2aWxPQmRaZGg3OCs2K2RWbkt6OG4x?=
 =?utf-8?B?aHhJbzlJeFM0Y0RNL3dxVXBjTVEycVkyaEhpSUx3NGJHUWlmNVoxbWFZellv?=
 =?utf-8?B?Z1ZUMldoMG1HYnZlcjhmaytxNUFQc2t0eTU3SnRsQmt2MTlyREgzWW9RbEl1?=
 =?utf-8?B?YUVhcjhtNTEvUkZXR3dnMzdGemdoWWZJMTQyL3lHbnM5ckFvdnFZRHFVSVpO?=
 =?utf-8?B?VlZzYWZPc2lsS2x4SXRhM3RGenU0UmVsYitvaWk5dGFoM0U1d1U1NEZuS0Q4?=
 =?utf-8?B?MnVOdExOMXUrMm03UzBwOWdiMFMzaHc0K1Vva0tUN0NDMjRZTUJxU3J2U1Ir?=
 =?utf-8?B?UEZ6bVVxaDBEdGd2MTcvMC9oRTk2WXF2OThSb3NLNFRYR1NlcXZ4QXFkUHlF?=
 =?utf-8?B?cmtrSldhNTdzZm1iSEZzbGxVd0pEaXJLYll5Ui8vanQ1b051N24xZXpwMjR3?=
 =?utf-8?B?TG1rSWswWFdrYlNUYTRJZjViVU0ySDFHUlgvWTEvdTB2R2wwVXFoMHdBbFVI?=
 =?utf-8?B?bGtqbTJOUGRaZGg0R1Nkc1N1ZFlqMlNmTWt4MEJDMFJsc1ZycFg2TFZENk5i?=
 =?utf-8?B?WmN0aE16cEQvUldFQ0x3TXpNVWp3Ymx1MmR2MmVISzcycDRSdUlvR3lSeGFI?=
 =?utf-8?B?VExYeGpuOXlrLzlIdzh4NEJXSGRCMXhyRFQ0Y211NHhZUDF1MFVuODJBTEUz?=
 =?utf-8?B?R2VPMGhPMHdiV0ViMFBCSnovaUo4aWJaUUs0eXdaZDVkekZ2TmloVjZQYUc1?=
 =?utf-8?B?ajBoY1c0NGY5R2FoZU9WT2d6cmZoL0hDTk04cDdNb1BURVJ4ajV6bzcydmFQ?=
 =?utf-8?B?MnB4RXovUk5PUVRxaTkwa3o2RTZDUVBwSkRCcHduV1dDTmVCWVZNOSt3Q3Ax?=
 =?utf-8?B?T0ZBQUdTbGJtbzhRZlErYjN0Q2xnL3hSWkxqZTN2RTB1QzRDVjJNQTFRT2Ex?=
 =?utf-8?B?WmdqQUxyMnUzNGtSbVN5MWxwTk5pM3kwV2lnRkJLTlc1Z3UrOE5HL25Uc2ZZ?=
 =?utf-8?B?MEdOKzNaWnd3MFlIT3FtcExXZkJEWkdrcndYNVZja3FhM01jL3VDZzBYUmVu?=
 =?utf-8?B?TzF1c2FQVHVmK3pESUhtUHB3bFJpSzgzc0FGVVQzcnorWDVnRkJ5MVFGcUpF?=
 =?utf-8?B?R09ETWtZUnU3anRPdm92Qy9zWGdxQzRYV1pUL01zVTZrOUlpcE1ycnR6TEdN?=
 =?utf-8?B?bWdGV01nL3orbUdvbXU4MU1OZVBTY1JrdTlBK0pzZGZlellwcGxLMFY2anls?=
 =?utf-8?B?MThINUJqa21UOWVUN0xyazZmeXBsRXJUYTZiYTVRMXh5TkxPbkxFRUxyRnhj?=
 =?utf-8?B?bmxiQ0QxNTczV09yQUNjcXB5Smlzb0hUcjZVaUt3VWNyRlFLV0tPNGFZZnRl?=
 =?utf-8?B?UnNLWHBKc1p3MFU4NE90aFgxUzlDUzE0MjB6MHdQdWpwckhuWjhnYlk5cXRw?=
 =?utf-8?B?cVBmKzNFc2tXRUd5SXV3REdEQU1YVU9yWDlKZVNsT29kRlBLVTY0N0xPbDc1?=
 =?utf-8?B?aVplMllTYUVDcGwwZjBLWDBwcXB4MkdPeHNzVUJGOWx5aG1iQitrM25mdzlO?=
 =?utf-8?B?R1RzeXNvcW90bXhvcFBxaXMwZ1hTZnZhZlRWcVY1TjZwZEJ1VTh1UzhJWnNv?=
 =?utf-8?B?LytQeWkyM3NKRFoxUGNJZWpUVXMvcjBwcldkOWNXaTh0WjhFbzdLa2d0U3NU?=
 =?utf-8?B?TVhzSlVJUkpPSHlBdy8rOEF1aUZreWRucmFsb1ViRDB4MnZMYjlMdG04OENq?=
 =?utf-8?B?TktEUk1aMEY3V0ErdkxHQ04wdGFzcTUxRjcwRGdwM2NST1h1SGUvT1dWN3RL?=
 =?utf-8?B?SUt2UkZUYjk3eTdrNW93RmhNVk9lSTFJbWt5WjRkd2tHM0lQVmxwVVNQOWZU?=
 =?utf-8?B?RFE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 284565ef-a8be-450d-f4aa-08dd7d012767
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 16:10:06.5556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6eEqLAHK90BxTkY+zkfL4yjSHVSjLLKx43e7rm+xbKSkATkVTaNIH8oxNuzlsCIf1mLHpo9DyGEX/SFRuucRu+CU6jKZ7flzvX91XSknblo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7801

SGkgR2VlcnQsDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHZWVy
dCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50OiAxNiBBcHJpbCAy
MDI1IDE0OjUzDQoNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDE1LzE5XSBjYW46IHJjYXJf
Y2FuZmQ6IEFkZCBzdHJ1Y3QgcmNhbmZkX3JlZ3MgdmFyaWFibGUgdG8gc3RydWN0DQo+IHJjYXJf
Y2FuZmRfaHdfaW5mbw0KPiANCj4gT24gV2VkLCAyIEFwciAyMDI1IGF0IDEyOjIzLCBCaWp1IERh
cyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+IFItQ2FyIEdlbjMgYW5k
IEdlbjQgaGF2ZSBzb21lIGRpZmZlcmVuY2VzIGluIHRoZSByZWdpc3RlciBvZmZzZXRzLiBBZGQN
Cj4gPiBhIHN0cnVjdCByY2FuZmRfcmVncyB2YXJpYWJsZSByZWdzIHRvIHN0cnVjdCByY2FyX2Nh
bmZkX2h3X2luZm8gaGFuZGxlDQo+ID4gdGhlc2UgZGlmZmVyZW5jZXMuDQoNCkkgd2lsbCB1cGRh
dGUgdGhpcyBhcw0KDQpBZGQgc3RydWN0IHJjYW5mZF9yZWdzIHZhcmlhYmxlIHJlZ3MgdG8gdGhl
IHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8gdG8gaGFuZGxlIHRoZXNlIGRpZmZlcmVuY2VzLg0K
DQpDaGVlcnMsDQpCaWp1DQoNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1
LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiB2Ny0+djg6DQo+ID4gICogU3Rh
cnRlZCB1c2luZyBzdHJ1Y3QgcmNhbmZkX3JlZ3MgaW5zdGVhZCBvZiBMVVQuDQo+ID4gICogVXBk
YXRlZCBjb21taXQgZGVzY3JpcHRpb24uDQo+ID4gICogRHJvcHBlZCB0YWcNCj4gDQo+IFJldmll
d2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiAN
Cj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVy
dA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51
eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwg
Y29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNr
ZXIuIEJ1dCB3aGVuIEknbSB0YWxraW5nIHRvDQo+IGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInBy
b2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==

