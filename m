Return-Path: <linux-can+bounces-6524-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DavIXfeiWnGCwAAu9opvQ
	(envelope-from <linux-can+bounces-6524-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 14:17:43 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D32110F88F
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 14:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AFE7302F39F
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 13:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9543783D7;
	Mon,  9 Feb 2026 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="l23ag6Dk"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023118.outbound.protection.outlook.com [40.107.159.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A58F374161;
	Mon,  9 Feb 2026 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770642970; cv=fail; b=eu8NC6nuxT443fQv2u6hhMkRhAZYoHhchuIZN9rcKRCSuqdSUOtMYZI0fu+Vb8wBCVwfRKjwwNau38Ful325Kvs3awzRmtCvAHGpxFj19MmSZuvFC0JOvPjKRee23D2f6ZbsaUD1OOqdOKqHcJlfSfuUg/1N9x/OCLQIxsYMayg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770642970; c=relaxed/simple;
	bh=kfqxqrNruGOmEoe9a7FHORR1Z/oaTKY5Vxn/442Lqfo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qhPCubXnTyj7CHxoeEaat0BsHho1Q74M2culzuLMwHYn2Af9n2I8BRA+IYGRblmOH5jGh9j/abwKEHHAKXzW3bTobUyb/AZ8uxGdqcDwg1NdfF2HsKGYH1wEY1+VXKwtuPY6z6TT2UiCneGGzCLJrp9fSUKTB2ERoQPvL9pRJ2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=l23ag6Dk; arc=fail smtp.client-ip=40.107.159.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rzk8X6tN2XH/OU59Pw7XuBGxd8l8ux7aZvN4JSy4+i0D5JV8lNU1mR52JZCWHHQYza/tYr/PhUwGHp1ChCdlbKmKyrmBL8FgTarVVq8JzWRWVGYL389qmOjHd+qtvceNfD0V54UI/QM1r9QmJcvcgtdQyCPzBQAXm3i3okA0Wh5B90VpIZc8YaS/mh1GlFY0yhYcAFSezehCMPndafU6vIa08RfGHn/GhuQ/MGKiPEDf30Ci7bls8NlS0TUb5Z8I1x0/RAtR1cjqs5B+Swa/x5Z+IGCdy4flu/624qPbugE80l9rSj839I9290KqCM8i0F6Dmjfo33rj7Q4e1Jb67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yF6yCaz0ZaQEikb90NgthYeTNuTffFfRENlLkDpN7o=;
 b=EjyD8GQKtfhhP5SjBjJBDr0MFzNPDzmgpiqGI+wjqiH1haVozV/MUg9KnxGQ6xWSWZorovuXO1r5ojdXEAM2N2UNkbxuTH0b4aVG8hjQbB9SeSe8cMthWrMr1kWYTWCnTKirH9kf3eryjCsHVeEUKZLIPPr7FXMtxqc+iXaktUqpQsUnUCMvvvcGfsOdZdEnMGytLJP0MbjZhQCQtfOxpKgzeKEESB5iU3WI4zt4mE8qECexKIFcrsw9x2saHHTjo5QKfo6pVlmjaLlQ3tucYNWdrLYfALZzaWwhIGgnTX61UDjryyvBiffUJhWo9zom9At0PXWAmgQvwwwjp1G7Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yF6yCaz0ZaQEikb90NgthYeTNuTffFfRENlLkDpN7o=;
 b=l23ag6DkYPl0dw/a9cXPkV2uAErShBY9kvB4Hh0LxsmfPrilXgLESEdQucnv6/L2eoUcVGcBGfPY/MH3IECd6PY21i3sCKQ72MPl2qMib+TLWVAfVU8lT7MN0nXXWqzwOiir+2P/j1g1lZCaaTKAsXVKE+5wDb8JZNdzYl66YZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com (2603:10a6:20b:5c1::5)
 by VI0PR02MB11941.eurprd02.prod.outlook.com (2603:10a6:800:339::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 13:16:05 +0000
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714]) by AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714%6]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 13:16:05 +0000
Message-ID: <9f49bf4d-48ab-cb8e-db39-3f573d20bcff@axentia.se>
Date: Mon, 9 Feb 2026 14:16:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
Content-Language: sv-SE
To: Ulf Hansson <ulf.hansson@linaro.org>, Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton
 <jon@solid-run.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>,
 linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0048.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::10) To AS8PR02MB9235.eurprd02.prod.outlook.com
 (2603:10a6:20b:5c1::5)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9235:EE_|VI0PR02MB11941:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b1b56f-adfa-486f-3365-08de67dd619e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0JFd2x6QTA1ZGs4R1VJY3VERFlvRXhLd3VicTlRdkIrWUhKNkoxOW5hMW5F?=
 =?utf-8?B?MktCZWlDWTFkUDI4YkdwK0U3U0lEM0pydkZoVm5TL3pJZE5CY2l1WkU2YUFS?=
 =?utf-8?B?ZkVDWFdwajB3cUtOMWt6cnd1SnFQYWVEdWpDNGNCM0pXVGF6M2J4RzlwSU00?=
 =?utf-8?B?MEdjOUNSbjNkaE40c05MSjQxSnp1UURyTnhLeVRzOVBWaGh6S0pnT3FqQldT?=
 =?utf-8?B?d0JVQ2FRWkNhblRYT2p3ZWRHQWNWMDZoUlBzci9INWdPUjhONFlGMGVKRzFa?=
 =?utf-8?B?OWQ2L1haNzNMZ2p2Q3czWEhBb0VPZEJxdkJSb1NkaVNKQ1d3bkt2dk9nU0RB?=
 =?utf-8?B?U2lRS2pJN2hSV3cvYUZxdEI5YkxiRGxDK3N0bHA4NDdFSXhNT00wQ3dzdmhp?=
 =?utf-8?B?SUdLNjZwNkQ2TkQ4cUp3b2JpQU1kYjh0RjVhUWJ6MTVuUHBLMU1wenJWV0Nt?=
 =?utf-8?B?UUdIRVFteVhrKzJCY3FuTngvUzNxemZsWERTWFRiUWFiRTRySEMwSkZNdjJr?=
 =?utf-8?B?d2FtVDdaaDQ1cFdJdEM2bHRRcFNUdVNqNTk4b05xSG9GbnR4bmJxSlB5UmF5?=
 =?utf-8?B?bjMxWjB0OXhnR0NVR1RRckVzZ2dweXZMdWNTaWZ5ckR0dU5VR3VvR2lGb0hC?=
 =?utf-8?B?K0grUU5DdWlOUGI5c2FUa3p6SXI5WXdpbHpsR2pDNUczOHY4OGs5cE00Vk9s?=
 =?utf-8?B?b1lISmV6UDN0TG1BK0o4UG1IUWFhNGZRb0pLTWlGc1p1RGFpTm9EMTZUaGJD?=
 =?utf-8?B?RWtFdjVTU1NLa1dwRi84MWNUWjNzYlR5K1B2b2FoSGg4Um9hT09FQi9WOGxs?=
 =?utf-8?B?OGZGcmx4Mk1ZL05xRE5TM1F6Wngrd0pUeGlKbVg1UTZUVkxQb1FCcDNvMDhl?=
 =?utf-8?B?TWkzVzg5V25UbElmd0M1RUtXTG5JampwOHdUNW9LSjJNZ1FON2FHb2RoMnFk?=
 =?utf-8?B?SEpVVFVaWCtZc09EbGErWWxMOGhNRFpjTHlGYXVBRXBSVFA3MlQzeGJQeHRD?=
 =?utf-8?B?bkl3SGhjL2ppUTZnVndqTkNaQm9yd1dRVXlFWG1xcWR6UG8vSGgyNFRiYmNu?=
 =?utf-8?B?MlVkWjJ6TWtXNlRyUlpiVzN6SUF4SmhGTm1tRXZvSTI0Qy9vd2RXZ2pWaEM3?=
 =?utf-8?B?Z2RISlRKUVcwbHUrckhVUmZlNWlvcEZsOTJ4dXVKdFI3b1dpVUQ3Q1g3KzY3?=
 =?utf-8?B?VnNsWFI0V2UrZlEyMmwxOVpNQ1RQRVJTVTE3c1o2MUtESFNQVG93dm1nb1V2?=
 =?utf-8?B?S1ZyQXR0U2hFR3p1VWZrc1k3dkM1cnlpNDRJM3JDQ21TK2V0NnB1c2c1THlV?=
 =?utf-8?B?TzFSSDFiT0t6dFFvUmM5bkdDVjBndEM3R29UaXo0UWhDdUVVYmhqR0hXZE9l?=
 =?utf-8?B?Wkh0azNCSVdKVW9keURyYzZoY1pSeHROOVBlSlRlS043SnBKaTJpS1lvWm12?=
 =?utf-8?B?UndZNlAvQmx6S1BDSHJ6WmVWRkFzbkc1TGlFMUtIZlRXRVpwSmQwVHZQeUdP?=
 =?utf-8?B?VitVMmJVcTdVQURBZStjeHhlTWg2cmo0bVFWY09GT0xNaWNHWXNxcjFBSnpj?=
 =?utf-8?B?TlIxSmdidk1xSmx0bjA5bGRjWUxoZXVOSGt3UHlPTjBMTjhYRWc1amloRks2?=
 =?utf-8?B?bUJBcldYbi9zMEMzTGZyWkowNFkwdWRiTnNBekhYeEhIZWxvdkE2WGxqa2x4?=
 =?utf-8?B?TDg3SWZOZ1piczkvOCtLandYTmVITitrMk5RNW9HalgvZjNrdGJ4UWpDdmxZ?=
 =?utf-8?B?S3E0NUZXVyt5ZFhQVGtIWk03WXh6cHhnRHQ5eTR1elh4QktGcnZHVVhQcFVi?=
 =?utf-8?B?V2c3SDhmOWxvUWRocjl3Tm9qQjZka3VaOHZUenVRWXNRTWVFb3pMb1ZOUm9Z?=
 =?utf-8?B?OFlsN3p6STVHS3hTM2pwQlFta041RG5zWnNLZkMzcTg1U3BOSjBJM05vVFg3?=
 =?utf-8?B?K0xUYWF3N1pIem1DYUZvUEJ5TkUzY0c3anF0RUlqTFcyUGtjUERHYm1kdVlr?=
 =?utf-8?B?Tmg3YklncUdYSVV6a2JtazJTWVRkZk4yVkdtY0pTT0V3TnVTdW1IbVBEWDIw?=
 =?utf-8?B?NDJnOFBhbVZ2cm5VcThhMWZQT0kvMjgyUU40bVYrYTFlMlFWQTk3WjU0Y2hZ?=
 =?utf-8?Q?Reg4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9235.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGZVVC9mN0NWWTFZNDVYTm41eEN6UytwSDcyQkhrdU5XVmRwSkdIWWphYUtz?=
 =?utf-8?B?RGl2NGtndFdFaENjT2l5cldDVXArZWE1bTFnWlIzYXFSdnliN0xuYi83NVBH?=
 =?utf-8?B?VkJOUmZqUXdaQkQ4NjJWUXRwMm94OVV3VzFRdERRYXhKRlBIN3hCeGQxZVIr?=
 =?utf-8?B?TG95NzhBaXB2dUJlL3laQVp6K1M1T3pUdFEreU5JT3RET1BrWXFrYlMwWmpI?=
 =?utf-8?B?d3BWZVhNc1c2YUVhOVlYTGx0UHlSNTNhakhZYVp1bW9vQWplM3JLZnVtSFpl?=
 =?utf-8?B?U0xaMDZQeDJBTFhUZlh5UU04Z1c1OFl3TTB6cHVDdXZ2YldDdzEvMmlSKzVr?=
 =?utf-8?B?QXFST1ZPeWN2a2RZdFg4RUxVTVdqZ1UySHcxa1krZU4wRTVJMURPRzNDVElR?=
 =?utf-8?B?VU5OaVlML0lzbVZZUSt3SkREM0N1ZDhJdjlzTUVZS0E4YWh3dzVscnR6K2hB?=
 =?utf-8?B?ekFXUUJ1R21xeDYrQS9BNTN2QWVLU2JQQ3MwWFErRVFrcFhQMVM3MmZjSnQ3?=
 =?utf-8?B?K2E0S05Sc095dTNWWkhMWWJhdU5Ta1V2WlpCeWdjOGdTNXo1OXpmbGQzZjBY?=
 =?utf-8?B?V09kQUdhRENvOFl2MHkxYWlWVWlwSGo5a2VkZWo3cDRPS3pPTGhDY3NiOU1P?=
 =?utf-8?B?UFVSeTJLelg0eTNEUjBBNEFZN1RMM1h3MWlBb3dQZDE0UTAvc3Q4L3lrWHBX?=
 =?utf-8?B?L25RQ1FQcXdlcDRtZkNqMGV6RXJWUERONGZZSDN1blI4Mk9LekJaMG4vUFdW?=
 =?utf-8?B?M01ydTlSd01WR1VSNlBKQmZ0WnJQMkwzaWwwMGZpaGhtUzRjcHYwb0NGSk03?=
 =?utf-8?B?ZytadHhwYUhvWHo3TDEvYVRqWFhUUzRMSEdJWE15c2RvbzcweDNrYjVlM28x?=
 =?utf-8?B?UTdjcVJZdlhCYlZ5RnFPUTlaU0NzTnpYejZodmNuNHdDWVFIdmk3bGttY0VR?=
 =?utf-8?B?TlE2ZE1FTk1YNTl6OHhIVjh6aFp1OU9zT2ZjMWlMZGNoMklMdTlTY2pCMDY4?=
 =?utf-8?B?bVdnWkVJZmdvcjdoUE9QVm85eStaNUUwN005bHV6OHVjL2xpbVhkaE9WN2VR?=
 =?utf-8?B?cVJBQ052eWNiRXAyRW83MjlJQUE3d0d5bXhWOWNLUVBucGxSK3JBMnVkYXZB?=
 =?utf-8?B?ZUhKL25tbCttcW15YWR5RUN0aTVXZWlYUGlwdE1EWmhVVktPUHdWeHhLVkw5?=
 =?utf-8?B?UW5CQ2tDOGE3VjBQMy94QTlJSFg3MVFZRlFyek1iWFUxZ0NYZC9DVzU5aFY2?=
 =?utf-8?B?ano1L1k4TG56OFRKSk5mVGJxRzc5aXpsQlkxd2E2bnd6ZTRqMWtnTUZWM0xt?=
 =?utf-8?B?a29yTFBPL0NKSnlSbUtrMlhZL1ZXQmwwYWVwQjVYR1ZqWHJZRVlhellrL2Vk?=
 =?utf-8?B?T05mUDNmNkJXdHdLckRZOE1aQUZKTzB2QUROOHdqYTNEYjdoSGI1MmgvUXFD?=
 =?utf-8?B?NHpOQnBtRDRLZWx4WisvMDVQcmt2ejJVRVoxd1lPWXNvWnJjTGYxYjNtSTVu?=
 =?utf-8?B?TEVyS01UOUxaNFNlUEZKSVA2dG9BWVMvTWEwRkxDR3NOUWtuSnNDL0VtNE9G?=
 =?utf-8?B?NEgwZjlCL2p1NFpWRFBPQUlpeWk5Wkk1aFJqWjZWOHY2Qmh6bHNQUUV2Qnor?=
 =?utf-8?B?NEw0RVhqSVpCYkxUWVZYUTdKOXM5VThVZGtjcU1yb055K3IzV2dmZnk1UVNk?=
 =?utf-8?B?R1ZpRXNSM2JIOFNNYjJNWjJHTkJoTHdLU1pLbXZIaUFvTmIvaTlWTVBIWEFX?=
 =?utf-8?B?VlFlWmhMNEFPa0FuT0loVXlzRkxuYWl2cGxvNEQ5all6UDJ4c0pVclVPQ2tB?=
 =?utf-8?B?dVVUWGFQTklmVTJob1kwTFVpRmlBR1ZLZ1hxdmV5ZkxYWTJnZThZZ3ZVa2ZG?=
 =?utf-8?B?UXZWSUNyRXUrVmUrRk5GVFpwR3ArZEJSclAwTTNaL2lCMDNaL1EvNFY3OUMw?=
 =?utf-8?B?NG1sNnZBUWI4UDJrOFZLc0dNNEJqZlJ1dGdPWDFVOXBpdGRNZlZPRlVqV2F0?=
 =?utf-8?B?cm5uajZxUFpIMVVFbmdEOXVrZVhPOFBCdFozZ2haa2plNGJmYnhMT05tTExU?=
 =?utf-8?B?KzU3M3NkK0x3cytmTm5YQVpNRTRMUytjd0V4SVJtTWU2d0xOSmN6T2Qvd0dT?=
 =?utf-8?B?MjAzYklZeC9XZEc0N1ZJWmxJdU9zY29BOEV1WCtwa1hTakN2cGhmanVMVmwy?=
 =?utf-8?B?MmY4SzNqS0NhOUpFS3crb1lFWkVrbVhPN0NTYjZrUG9jM0FXbm5DVjNsUTc5?=
 =?utf-8?B?Y2RINTBwUjg5RUFaYkoyNUdPVTBKTFVLbEZhNnRwM1NmaE51aHozYkJKU1ZI?=
 =?utf-8?Q?zPs2/Ad4oEix4/eG/T?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b1b56f-adfa-486f-3365-08de67dd619e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9235.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:16:05.7721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHBO4PO42tGzCurkTQUXwRgPGCfjNtUXYooxpi43adxRaxrwiMDcuqk9JyQvDN73
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB11941
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[axentia.se,none];
	R_DKIM_ALLOW(-0.20)[axentia.se:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6524-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[axentia.se:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peda@axentia.se,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,axentia.se:mid,axentia.se:dkim]
X-Rspamd-Queue-Id: 2D32110F88F
X-Rspamd-Action: no action

2026-02-09 at 10:57, Ulf Hansson wrote:
> I have already applied for v8 and it's going to be in my pull-request
> for v7.0 in a few hours.
> 
> Please send incremental fixes on top instead of a new version of the
> series, then I can pick them as fixes for v7.0.

Hi!

Sorry for being late with this, but as the mux maintainer I'm not
fond of

028ec00381f5 ("mux: add help text for MULTIPLEXER config option"

and would not like to see it in rc1. Can you prevent that some way?

Cheers,
Peter

