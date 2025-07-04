Return-Path: <linux-can+bounces-3947-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD3DAF8FA2
	for <lists+linux-can@lfdr.de>; Fri,  4 Jul 2025 12:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD641BC69DE
	for <lists+linux-can@lfdr.de>; Fri,  4 Jul 2025 10:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF1028C5B1;
	Fri,  4 Jul 2025 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="VU6n8uBP"
X-Original-To: linux-can@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011055.outbound.protection.outlook.com [52.101.125.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105AC2EE974;
	Fri,  4 Jul 2025 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751623960; cv=fail; b=dtxqIOcgPqFqYdtiszcxfF+hmCZgSxDdfcifKusPhsL5np8mR08IvD/rud5+SGScEnWRhgf6u9iE0MZ94/cGGPcnmPKRroZ+dVuHtGs7NfnL2ijc+/5z8GoameFsurIOvReKw+ihajqXeIJK4VXfzeOLREtxnzL1yNthLtx12lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751623960; c=relaxed/simple;
	bh=39Wv0XmdRfiUIKSghE5zZgJYHx9KAINw6IQQw/wvBBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ihZnldM9aPMR0yS/iAnsHbrKNjBx05aCSmb8YuBq2xHyCuzCTncCdvIX/m7VQamx/f0cEBENoP1i90CL9Y7SmysnqA3gmF3i9axmfCJl5mOPq5HOYHN2SVxGeJSvYxE8AZtxy0FRRrsn3lttgKIww5MvG0eVTCYqBF+WZflIkz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=VU6n8uBP; arc=fail smtp.client-ip=52.101.125.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZYICZA9n/J8KX0qwNKBsyZb98SbOQaejXOsSAnhAAT1M8F8TQ5cN2/XMuQWSAR45JcJD519c0MchSh9RN2a30enRTY2vGdDjP7mYtqEMRMEFnF9TYXknCJoiBHxW1ViOgWJUU6XNBaLxjzQf2u73xWMBoOoKuIPuwBqP0qZ8FOQ95k67ACFFlw/R/Ezucrol27EdZWGXhkSpDa249tgvtiO4UVpcNhrchCwFV4LqW+km07Ct9zIcCmLUHlgwukjXOvTuWvtmrmNtMLd+z4CmhgAkyYP7sID59GL1awgQGSEV/CMn5sRFtND23FkSs9XzyU9EvtHofiFFQo7I2jXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39Wv0XmdRfiUIKSghE5zZgJYHx9KAINw6IQQw/wvBBs=;
 b=czcQbbzxhl+vIkgnSzEP6DwliMSnQynp31SqAEGIhLwgb8nhp4pTQWNGbn5/ehP8emlOLCBvoBw+zVwyx7t15I4ml5kJhN5aLlPIhvSYvvdpf/z4Sg/KVV3ml7ftgKTo4y8p5qPWockRylPqXd52L+23bgsGJ153xTIFLBsNNACK+gmZSthwiFlKeTePErPVvf2jEMDhTL4+5aCCKxNb5C5BSsmhGS7Hel7Ty6rGNB6VkI9cvmE6MZUcrriLuYwcEP6vFxJ1Chlmz1K885K+0FbKQ8zkCoGYMbfIADGTb5sO0KIX7WTg96SCw79xfT0Tp8RiNJGl7gkMaXBuFYIsDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39Wv0XmdRfiUIKSghE5zZgJYHx9KAINw6IQQw/wvBBs=;
 b=VU6n8uBPJ+oJ1OLSOZYXfZsyDrwuPjWuyhpwE1RSAIsSKy6WC76oEzAnNljonZiqMtXSlSHeyYcFpTlSuENbtGyyJaHurQl22vjw7ZFYEObUXuAxDBkTtm50ftf6dxbD1rrdh+MRmRgZ73TEirnOvqG+gbNZ6vlWhP9W2Prw3a0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB12600.jpnprd01.prod.outlook.com (2603:1096:604:33a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 10:12:34 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 10:12:34 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>
Subject: RE: [PATCH 4/4] can: rcar_canfd: Replace RCANFD_CFG_* macros with
 FIELD_PREP
Thread-Topic: [PATCH 4/4] can: rcar_canfd: Replace RCANFD_CFG_* macros with
 FIELD_PREP
Thread-Index: AQHb7EkevlGLzht230qinUwh6z8i/LQhPQ+AgACBUtA=
Date: Fri, 4 Jul 2025 10:12:34 +0000
Message-ID:
 <TY3PR01MB113461B3528C3057DA03F6E808642A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250703183411.332828-1-biju.das.jz@bp.renesas.com>
 <20250703183411.332828-5-biju.das.jz@bp.renesas.com>
 <dc6d1cdf-0c93-4d7a-b3c4-722d1e58f5cf@wanadoo.fr>
In-Reply-To: <dc6d1cdf-0c93-4d7a-b3c4-722d1e58f5cf@wanadoo.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB12600:EE_
x-ms-office365-filtering-correlation-id: d5bc24b3-449f-4085-fb43-08ddbae34b8e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QThBUGl6c2FyUnJsUUZFQnNqOGNWaGJ2RURNaTRtRSs0ZGg2QVZKUGRTaHVD?=
 =?utf-8?B?SFU3a05zUG1od3U2b0JUNTlFSFZvanB4SE9BUytoUzdLZ0VBT1VYSTJYWmQw?=
 =?utf-8?B?SnVCNmIyRXdIWmJkV0R3L2U4bEVPbFFZZEIvdVZIUjlCWFgyMUZYZXE4Q01G?=
 =?utf-8?B?Qlo3NThDejIxUHc5V1BNZU9kL2phNmJBaUFWVzZxb0hyWENWZFlTRm52RTZQ?=
 =?utf-8?B?VkMyNkQ4Tm5lRnBaYXZtbHhzbTIrUjk5SjM0Yk9yVUZRbHVnUThGYXdHNWI1?=
 =?utf-8?B?YkVzOUZ1MUh1SElaYUgrQzN2Z1FDZFhsQUJ1Wk9tZjF3SEFFNWZCYmZiV3Yz?=
 =?utf-8?B?UFJmaXhneG51cjd6aGNjYjZFNE1KK0xGL3NLY213R3U3a2xRTUdzd2FES2s5?=
 =?utf-8?B?Q2hiSUh5bFhhYWJtQVl1azhPTkc2T2dCaFBXRGFJL2FzV1VCenVpSnpzS0ZD?=
 =?utf-8?B?YlNnN0l6R0FDNUlmTUtwN1FyRUtWc1NYNWpWYkRsUHgzZUUrd0VydXV3U2VI?=
 =?utf-8?B?ZEFWNmx5clRCZWtzNDFab0JKc1prcUNVVHFEenZHS2pqbUxhVlJSZjFUMktQ?=
 =?utf-8?B?NHJMMWVuTTVFbkIvRUtnRXQwMVhTbWJPZkRMVUVITW5PUXhBZmxrNlZDejRo?=
 =?utf-8?B?R2g1Y29DMzVrQzZibktHZ291enJJUmV5WUpXM0tFdGw2SlNsT1lOQmFqZTNa?=
 =?utf-8?B?MkFGSWlud1Fvb2VGKy9EUVVHYU1zd09TN2ZISzdEWlBXays1TFJkUnJKeWEx?=
 =?utf-8?B?S1NGbUlhV0lvTWVYbk9UT0p6RG9aQkdScWw1ZU1oQ1dpZTQxcmtQb2djemRM?=
 =?utf-8?B?Z0hRam0za0UwRjF1Sk0yaVA4SXlHOTJJSVByckd6ZDhSRjM4NDhSUWp5SVdQ?=
 =?utf-8?B?MkJCVGpnN1dBRjBYcVk4S3h5a01ETkVKc0ozQnJYS2FadXJrcERwVExEYUpK?=
 =?utf-8?B?T1hXUWwxQUNDMEVJSXdrYXlYeXZlODYyZzIrNmtwZEZ2dGt1NnMxNzhWb0M0?=
 =?utf-8?B?UUJJZHhEdzZsMFBWTFBqWk92ZjRDb1Zoc01wL1hGS29NMnZkZ0IzL2g5ZG9N?=
 =?utf-8?B?aVhmaFF6b2VVS3R3VC85Qmppb2NQZ1g4Y1d1TCtpNk1jNzhLOURMcm5SMy8v?=
 =?utf-8?B?YzRiY3ZnZW5iQStLWWlpc2NrN2p0UnE5WG0wVis0czhibzFySS9XL1kyaUIy?=
 =?utf-8?B?bGhldVhiQThVbTVoWFZURWhSeTBwYTd2MWdGbjFlRGFXZjNKTmNYUitzdlhQ?=
 =?utf-8?B?bGIrYjNZVkszTVZqdTZiak4xZzcyYng1a1NmSXk1Q0NDV3daS24yeVpWTExM?=
 =?utf-8?B?VThOMkVNR2N4NURxQzVmbXJJcVM2SXl0SmxOZU02eVVKZ0JEZFhZRmd6c2NH?=
 =?utf-8?B?b2s1TTF2UklFdStjbmpBVjNpQjZnaEw1RHJ2cFpXMlFEalpyQlkzOFhWWkFT?=
 =?utf-8?B?SytMM2oydVg5N28ydUp0bVFITEpKdnRBMFB4amY5Z1I5WUlrMHd0OEo1T1Jm?=
 =?utf-8?B?eWwxUk9NUmphS2ZFQlpmYThDOFdRbUlPbkhZZ0VJa0k0c2hkYThaRDExUjBl?=
 =?utf-8?B?dm1ZcUw3cXltaTFzRFl5OGRyeW9ud1dyS3ZlVTRvQk5IUmNFZVNaS2hOVU9M?=
 =?utf-8?B?RUQ1bC9SemF2N1Z3RTVJblNnaEhnblNLZExxaWozVTJTNlpZRFlTQ2dzOHpx?=
 =?utf-8?B?a3F3UWcrQmJUNEd1YVg4S3NpbkJ3dHpJMFVMT1lWREw3bE1qY1JCbG5IR2V2?=
 =?utf-8?B?TjRVSlFBQlNqSE5jQ0E4d1J1WXdwMnF2ZXZSdmZHYkswWmQ4WU11Ylp6b0Np?=
 =?utf-8?B?OGhVVlkzV0RLVVhwZko0clBIaElsNk1GSlcrZE5nbmF1S1pua0pER05GQy9J?=
 =?utf-8?B?QWdUQzMrVGJpU2t6bkhQaENta0ZkVWxBQmE0TVE4L0NFMU8vcTBvZ0RRaWpu?=
 =?utf-8?B?a1FLdVEzc3NwZE9hZmttdWY0M2ZoNndkZmRqSkxJUDdJTHl2V1YxQ05aSFo2?=
 =?utf-8?B?NXhybStUNGVBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2srRzZyQ0pRQ0NHcWVKc0xGMExaR2R1Y1htQWpSM3BRa0hGcFRaUXRqK2Ra?=
 =?utf-8?B?OUN0TS9iZEdhbm8wem1QdTgrMkxWZGZpTDZEdWNlUVRYUVdmN1htVXNoWldI?=
 =?utf-8?B?bGM0Q2tFbFBGNGt0TTRQTzFXZVFCSUF1MWJBY0ZsSkh1TjcxL0NHR0hYSTZ5?=
 =?utf-8?B?U2tKTFdEU3huNEZESEhZc2JnYndnU1pqSDNoc3pTWG8yNmJtNHIxUVRiQzM4?=
 =?utf-8?B?RFo1RjlvUnI3dnpRT1FicEN1WW5tdU1US1hyL2U1cGtaUkRZZi9KNExFbzB3?=
 =?utf-8?B?S3FKamhQS1NGendsMjRUN0ZENlk0YUNiOEtsWC9hSmVkZGJPV1B5amsvd1Iz?=
 =?utf-8?B?QTIxV1NpUkg1dmk3U2VVajZMYzd3VlMvTjluUjY1bHZTa05QM1FOWm1FcW1Z?=
 =?utf-8?B?WlFjUzBVcGpiUDhCL0xab01sdVpqWjVkNzQvQ0FaSlJMUldwWG1TSy9GZjlp?=
 =?utf-8?B?eEw2ZVhONFl2VC9hWm43VVdIdk9tLzNqZkNlUjFKRVFwdkdNQ1ZHeEF5TWpN?=
 =?utf-8?B?THJub0xORmZyNURPSkp3VDl2VWRBa3BPYWhlZ25Nc0JxMzJIWEZJOHhjaSs1?=
 =?utf-8?B?cXJxSjVmYkZpUDBBSHpBYXV5YzBrejhHU0NaRW53U0hxZ1JUcFBXb2pzdkZw?=
 =?utf-8?B?NkJkUCs1bXJZMG02SmsrNmw5c0F4cTJrWjB1WTNsY2FKWExLM1k3VlA1NkZm?=
 =?utf-8?B?dmV2cnd1dHF1QXI0M29zS2pSeGxHMUpoWVJ4VVRpWlZFYkR2TVZ0Zkx5ZDl3?=
 =?utf-8?B?dmlJTjYxdWZLaXlDMFRHYW1XV21zRkxkOWwyYThqRERlV3BFTzhnN1krN09B?=
 =?utf-8?B?MGQzc1hvWnYzS2dSYUxJSG9WdEJVMncyYmQwc0dQUVY2L0FnK3BGS0wvcDZp?=
 =?utf-8?B?ek9yU0s1cTZGbEJRV1lsTU5GTnE3b2pGK2xWbFdSdXU3dkxLNjl6VlVna2NS?=
 =?utf-8?B?UkYyZi9vdGg0MnRhSHQ3WUc5SnF5Z2NNeVpGVUZzNFBZY0JzMmo3S2hvM3dQ?=
 =?utf-8?B?aU9VZVBRYnkvYnB2d3pRMGpDejNldXRjd3lGNnVvYXFtU1c1KytOY1loSUkw?=
 =?utf-8?B?RlplZUttOE45VHhrTWs2M2RXMnNFWk5nQlVpYm1xQzQ3VjBBY1V5RnhvTXVW?=
 =?utf-8?B?a0RMejB6Z0dzSUtmaGRYbzltT2tvcUZaSG1aVmhMQU5DTWNTQjM0UW5pQUVZ?=
 =?utf-8?B?WTNsTTBra1c5U2s2M3NkbERMeGpaQU1NMzBHUVAyeEdiYytZeDY0ZURtSitF?=
 =?utf-8?B?YkhsTmZHVjNFVDFDMjJGSHQ1MkcyREp2bHFacVJ6cGE2b0Q5bDdtUVVXTUlZ?=
 =?utf-8?B?OE1TQ2NZOGJqRHh2TVB1My9OMFFkYlM3UmwvNVRrZEtoRkdzR0pCNkZnOXho?=
 =?utf-8?B?L3JTTXo4UlRyMW4rdkxDblY4Q0gxLy9Zb1dyUzlqak9rT2hoRFVqK0pBSHVU?=
 =?utf-8?B?Nlh6dmxiMkFjeXVDa3cvNi9oOWZFemRaTEV2UXdnd1V6Wk9nRlF4WTdKR2VY?=
 =?utf-8?B?NDlja2pUcmd0M1ZzcTJLdTJobGtoeEpKYllKSjNvSm1mVlk2aGY3N2l2dUtx?=
 =?utf-8?B?cTRnQnplbTRNdStYMmFndkpEa0ZabHEyNG5VMGZHQkt4aXVVWmxLYWNkNzho?=
 =?utf-8?B?V0hwaGFrUzFycEF2cW9ZL24xVFdtRkw4OUREenZKOGFtYTJVRHZqSHlsc0xW?=
 =?utf-8?B?SVlIalpoRHhubFBiRHNwMlZLU3h4QVhvem5pZ2ZiSUZXUXRicllKYis3UE1R?=
 =?utf-8?B?RXBrLzl1Z1diVzdWalFGbDA4TktGM3V2NkF5bDY3ZjdJeEJCT1dsQzQyTUM1?=
 =?utf-8?B?KzhNTnpQSEFJVEdOazBleVpVTUVTUzVGRVdpSjFRL1gyVFp6cmN2Ymd2NFZn?=
 =?utf-8?B?cUFzYnNFZGs3eUtRQUFnL1dEZjJnZTVudVV3bVJBMWx5ZHZ4OWpQNkJYNmNn?=
 =?utf-8?B?QkdXSURFVHJ3Ymo3QXhodkFxVDBhZjdhYm1iK2hhbHpCNmgvL095S3c3YXFy?=
 =?utf-8?B?TXVsKzdUbHQ2bW54eng2eHpMd01NTkhkMXBRcW9EbjhwUHQ0azUxZlRNREQz?=
 =?utf-8?B?QXlWR3dhY0h5cnhkQUxRK2dIWXByMHBiYnM4YUlseHZSajlyNzhnRk5qb3ZP?=
 =?utf-8?B?Q1dwL2ZPQTNBbHNtSFFhMnhVOVNNSHArK2dpYnFDL1FNazVQZ3JxQzhUNzlF?=
 =?utf-8?B?WXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bc24b3-449f-4085-fb43-08ddbae34b8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 10:12:34.4363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mPg9aLKByPN8GxOp6Fidmgtvg55VwmlTxXk5xgOHIcpnQ4QbMLmLkPlVkrfJkOogmfTg+Et9KNHfPptdiTeN9wc+wr7brujwk4HtoVplJ4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12600

SGkgVmluY2VudCwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmluY2VudCBNYWlsaG9sIDxtYWlsaG9sLnZpbmNlbnRA
d2FuYWRvby5mcj4NCj4gU2VudDogMDQgSnVseSAyMDI1IDAzOjI1DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggNC80XSBjYW46IHJjYXJfY2FuZmQ6IFJlcGxhY2UgUkNBTkZEX0NGR18qIG1hY3JvcyB3
aXRoIEZJRUxEX1BSRVANCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiAwNC8wNy8yMDI1IGF0IDAz
OjM0LCBCaWp1IERhcyB3cm90ZToNCj4gPiBSZXBsYWNlIFJDQU5GRF9DRkdfKiBtYWNyb3Mgd2l0
aCBzaW1wbGVyIEZJRUxEX1BSRVAgbWFjcm8uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1
IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
bmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYyB8IDEwICsrLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMgYi9kcml2ZXJzL25ldC9jYW4v
cmNhci9yY2FyX2NhbmZkLmMNCj4gPiBpbmRleCBiNWIwNTllODMzNzQuLmRkODdiNGU4ZTY4OCAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiAr
KysgYi9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiBAQCAtMTAyLDEyICsx
MDIsNiBAQA0KPiA+DQo+ID4gIC8qIENoYW5uZWwgcmVnaXN0ZXIgYml0cyAqLw0KPiA+DQo+ID4g
LS8qIFJTQ0ZEbkNtQ0ZHIC0gQ2xhc3NpY2FsIENBTiBvbmx5ICovDQo+ID4gLSNkZWZpbmUgUkNB
TkZEX0NGR19TSlcoeCkJCSgoKHgpICYgMHgzKSA8PCAyNCkNCj4gPiAtI2RlZmluZSBSQ0FORkRf
Q0ZHX1RTRUcyKHgpCQkoKCh4KSAmIDB4NykgPDwgMjApDQo+ID4gLSNkZWZpbmUgUkNBTkZEX0NG
R19UU0VHMSh4KQkJKCgoeCkgJiAweGYpIDw8IDE2KQ0KPiA+IC0jZGVmaW5lIFJDQU5GRF9DRkdf
QlJQKHgpCQkoKCh4KSAmIDB4M2ZmKSA8PCAwKQ0KPiA+IC0NCj4gPiAgLyogUlNDRkRuQ0ZEQ21D
VFIgLyBSU0NGRG5DbUNUUiAqLw0KPiA+ICAjZGVmaW5lIFJDQU5GRF9DQ1RSX0NUTUUJCUJJVCgy
NCkNCj4gPiAgI2RlZmluZSBSQ0FORkRfQ0NUUl9FUlJECQlCSVQoMjMpDQo+ID4gQEAgLTE0MTgs
OCArMTQxMiw4IEBAIHN0YXRpYyB2b2lkIHJjYXJfY2FuZmRfc2V0X2JpdHRpbWluZyhzdHJ1Y3Qg
bmV0X2RldmljZSAqbmRldikNCj4gPiAgCWlmICgocHJpdi0+Y2FuLmN0cmxtb2RlICYgQ0FOX0NU
UkxNT0RFX0ZEKSB8fCBncHJpdi0+aW5mby0+c2hhcmVkX2Nhbl9yZWdzKSB7DQo+ID4gIAkJY2Zn
ID0gcmNhcl9jYW5mZF9jb21wdXRlX25vbWluYWxfYml0X3JhdGVfY2ZnKGdwcml2LT5pbmZvLCB0
c2VnMSwgYnJwLCBzancsIHRzZWcyKTsNCj4gPiAgCX0gZWxzZSB7DQo+ID4gLQkJY2ZnID0gKFJD
QU5GRF9DRkdfVFNFRzEodHNlZzEpIHwgUkNBTkZEX0NGR19CUlAoYnJwKSB8DQo+ID4gLQkJICAg
ICAgIFJDQU5GRF9DRkdfU0pXKHNqdykgfCBSQ0FORkRfQ0ZHX1RTRUcyKHRzZWcyKSk7DQo+ID4g
KwkJY2ZnID0gRklFTERfUFJFUChHRU5NQVNLKDE5LCAxNiksIHRzZWcxKSB8IEZJRUxEX1BSRVAo
R0VOTUFTSyg5LCAwKSwgYnJwKSB8DQo+ID4gKwkJICAgICAgRklFTERfUFJFUChHRU5NQVNLKDI1
LCAyNCksIHNqdykgfCBGSUVMRF9QUkVQKEdFTk1BU0soMjIsIDIwKSwgdHNlZzIpOw0KPiA+ICAJ
fQ0KPiANCj4gWW91IGNhbiBzdGlsbCBrZWVwIHRoZSBtYWNybyBkZWZpbml0aW9uIHRvIGdpdmUg
YSBtZWFuaW5nIHRvIHRoZSBtYWdpYyBudW1iZXI6DQo+IA0KPiAgICNkZWZpbmUgUkNBTkZEX0NG
R19TSldfTUFTSyBHRU5NQVNLKDI1LCAyNCkNCj4gDQo+IGFuZCBkbyBhOg0KPiANCj4gICBGSUVM
RF9QUkVQKFJDQU5GRF9DRkdfU0pXX01BU0ssIHNqdykNCg0KQXJlIHlvdSBvayBmb3IgdGhlIGJl
bG93IGNoYW5nZSB0byByZWR1Y2UgdGhlIGNoYW5nZXMgbWluaW11bT8/DQoNCi0jZGVmaW5lIFJD
QU5GRF9DRkdfU0pXKHgpCQkoKCh4KSAmIDB4MykgPDwgMjQpDQorI2RlZmluZSBSQ0FORkRfQ0ZH
X1NKVyh4KQkJRklFTERfUFJFUChHRU5NQVNLKDI1LCAyNCksIHgpKQ0KDQpPcg0KDQp5b3Ugd2Fu
dCBSQ0FORkRfQ0ZHX1NKV19NQVNLIGFzIHNlcGFyYXRlIG9uZSBhcyB5b3Ugc3VnZ2VzdGVkPw0K
DQpDaGVlcnMsDQpCaWp1DQoNCj4gDQo+IChzYW1lIGZvciB0aGUgb3RoZXIgZmllbGRzKS4NCj4g
DQo+ID4gIAlyY2FyX2NhbmZkX3dyaXRlKHByaXYtPmJhc2UsIFJDQU5GRF9DQ0ZHKGNoKSwgY2Zn
KTsNCj4gDQo+IA0KPiBZb3VycyBzaW5jZXJlbHksDQo+IFZpbmNlbnQgTWFpbGhvbA0KDQo=

