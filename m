Return-Path: <linux-can+bounces-6462-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDzkImjdgWmDLQMAu9opvQ
	(envelope-from <linux-can+bounces-6462-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 12:35:04 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3218CD870E
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 12:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB42A30753EA
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 11:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D628335070;
	Tue,  3 Feb 2026 11:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="TyQmVxad";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="TyQmVxad"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023118.outbound.protection.outlook.com [52.101.72.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C28428751F;
	Tue,  3 Feb 2026 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.118
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118119; cv=fail; b=JU1EkmNbMgGF3rUMYQRIqbmIpv1zZmB1AyCSZBl2U5PNj2OiGdCJApW5cUf7aEQFBWF1mzxq1gLLG09UZuz6jk73VZ+0JjXxFoGN66pYKpbeUNq/caRTwcSzH67BJCb6sJywKj4FAopb1Xkv/teBohmlTzGIzOZeHPjVAfwwccw=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118119; c=relaxed/simple;
	bh=Hd+srdi2u9uJM1YXy4t3xee02x5aqLeGhmnRhH82r7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k9pC6dhbd1gJgP++NqFpQQHR3VMga5nhTcr85kMoSy1Kh+ZjgL4d2bq4pWLpaOv212qdAiW5CEIKOMCGbnWjM0mXfWXzkvzYZK7FL5qLmREAkx5GAJDQzD3i8LmYpBcxgWZslQJTe80ANqLMrQnEwv3fG9Ds4Wxmi2x63BC+INs=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=TyQmVxad; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=TyQmVxad; arc=fail smtp.client-ip=52.101.72.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JCNg7E519stxgF8+Xz0y9UVtal+GKZ6CudQ3AohiYS/RgYHeS7BYrWOwK+0KY3YWk4IhUz5IWPNExXtO8EpaKCUS7WBNVrUNR5YG0PGYXzLq+kcd9PHTYN0sNiaN5JWnHI5UNEYO2ENJiaIIk2ycvoT80Zn7Xjm0qFBF933xX46NO68bnFGgdkOJjKfk4UmE6otGFVHInjlNGzSNUetv3fWr0cNx2cnuHXXdWe7nD7MilNuwQyGZUmj1VQMCHzSbvpzlUdoJu/sxHAiih63Kal/eeQaiM3lBUy5dpJdNBbvorV9xJxyg/5lurFJWXJh0WAMYrUiV+Psg6HsbSlilmQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hd+srdi2u9uJM1YXy4t3xee02x5aqLeGhmnRhH82r7E=;
 b=d1Tmb/eXX2jcw6D8Z8t0wL6vnBeFVwvcNN7i9LarrS/ZXGXH5aOmFEYd1SayQFaLh6n0w23RCvzXeBwsC+tkHJ38zw0bcS4kKU4/rdhSjXzOB/oR3ntucwyg77Wmd5LHwCSxqqk/I+qU3zT/huT7kn9NAC98CAcQOle2Vv3e7WvOHltO9ZSzzD8atr8rgJxVSP9+et+Eo/Y0GOnqagKuDUfl4Z7LSzCPgT5h1psv69weSWR+KDdsMtUBINT0UsdzGl+bNA06J13jJchWXFlGsmxoijj8pohAIjeKF0vq2Jx8JmWwewxW5/udW8XaD37blXKaQ8nDR6y24rwbQiS2pw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hd+srdi2u9uJM1YXy4t3xee02x5aqLeGhmnRhH82r7E=;
 b=TyQmVxadQ2BJlqsyCkNLEAq20mugzUubWY0bh5AtA2KBY7lJLQDBNKl9BAgE9LvXIA/6Pw7wGUKj+F0oLaCVyUj2lm5zdWVN0osySvAlF//IHlNExXn3sjee2f6qQI6kDqPP4uzkruAPjrJQLP5NH0q5kuKuThwynubFCBiWhz0=
Received: from DUZP191CA0002.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::12)
 by GVXPR04MB10849.eurprd04.prod.outlook.com (2603:10a6:150:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 11:28:32 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:4f9:cafe::f5) by DUZP191CA0002.outlook.office365.com
 (2603:10a6:10:4f9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 11:28:30 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Tue, 3 Feb 2026 11:28:32 +0000
Received: from emails-55162-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-224.eu-west-1.compute.internal [10.20.6.224])
	by mta-outgoing-dlp-834-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 073498008B;
	Tue,  3 Feb 2026 11:28:32 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770118112; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=Hd+srdi2u9uJM1YXy4t3xee02x5aqLeGhmnRhH82r7E=;
 b=Ixnp9HOZDOse7KBobl4JqArFg+vLpUK1ekRZX7ibh0hbvWar+OBAulOvsPEQzttCq0WbX
 WjYK/+CvOjdGRfBBm+M614SgA/2WPY+Bxj5iaq2aOuACr7P9gEuYcwSrED0bI1vGcUGGkD5
 zrxxXVLMDEijF5C3FvnWFxVdclA6WGE=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770118112;
 b=gY95THjDwEOU1AuaLmI+396h2DRLIfFNloihhE23pjYQ4XyjgAkB/irAIoopFj+eVq846
 4skZ7Bw/d6yzJzMsM/nlrubfj+Vf+VHJudJEHoQM4gtBquKhGND1SufI4rj9pFa5Rle1FWs
 WNE0w3JwzQHIq1hQ4WbdbNunI3bGbs0=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzgvqAKJoxBOKiJ15tiqTAushDN4bKKSMdZMzE5pcAkhxwQlnVI+KicNnmiqB3+5y8mKMv63UfDzpYk+BVNLk7gfB37sKvLXwKli8mfjToomRuo+7lGwwNDCBHdA/A8oG8hD4ZQUD6heQ/NdnhgFSIBddGtxftAMNOr4/ouGI6l7DDPTG5bNyuVQsROcQ1uor8DUoWmA6x79/Pn8oAV2bxmv9QwmHOi1Q9edetI67OE/u805v+TuoggiQJ7H4AUiW/AFa0fksstpcstGQ0dMpajmWxdl8Cdu2xfXlcVVlb3vbWT2JdmUu1M8Dcw4bv7xRkcH0Ws5kMqEJJbI9GYRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hd+srdi2u9uJM1YXy4t3xee02x5aqLeGhmnRhH82r7E=;
 b=bxwRKnryavtKpxIn6AzgqbB077kFL6++L7KJnXI2FoOu8fG/asHypuWUQV1tGC9KwHTH3jB7gtvyow5vxYSFedtyFrVo+6DSrIBDZAdNC4SVZTY/Jl/PqBNGAnrOzmor54bQ/i00ceY4bB3HWouNS9PK5e1ySv+nDsK/DgmPzaPEzSrpEQtTzX+9SotKr1sAeMiqkF/vf36FC9LXU6R2RLqI8Im5053eG0EMi1g98HT5PvX4OCaq0Cz9XJ6KoE7k880HlBdCHvV4NdsHDUgHAIK6N4pjV7pvWOqxp/HEpF2w4oiocAbloUHN7TtFk6UCQKWzVMZrO/44hOkUzbK9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hd+srdi2u9uJM1YXy4t3xee02x5aqLeGhmnRhH82r7E=;
 b=TyQmVxadQ2BJlqsyCkNLEAq20mugzUubWY0bh5AtA2KBY7lJLQDBNKl9BAgE9LvXIA/6Pw7wGUKj+F0oLaCVyUj2lm5zdWVN0osySvAlF//IHlNExXn3sjee2f6qQI6kDqPP4uzkruAPjrJQLP5NH0q5kuKuThwynubFCBiWhz0=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PAXPR04MB8318.eurprd04.prod.outlook.com (2603:10a6:102:1c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 3 Feb
 2026 11:28:22 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 11:28:22 +0000
From: Josua Mayer <josua@solid-run.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, Aaro Koskinen
	<aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman
	<khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
	<tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R
	<vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Yazan Shhady
	<yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, Mikhail
 Anikin <mikhail.anikin@solid-run.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org"
	<linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v7 2/7] mux: Add helper functions for getting optional and
 selected mux-state
Thread-Topic: [PATCH v7 2/7] mux: Add helper functions for getting optional
 and selected mux-state
Thread-Index: AQHckGTeQp7u3kOOpk2xNnRQI4AIhbVpUZQAgAAB9ACAATIBAIAGWhSA
Date: Tue, 3 Feb 2026 11:28:21 +0000
Message-ID: <70305238-a9eb-4803-a5ed-5a6cd4d618d2@solid-run.com>
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
 <20260128-rz-sdio-mux-v7-2-92ebb6da0df8@solid-run.com>
 <CAPDyKFrBuL+747QUJJUejtcvjm0V7Lt=vHwjvcMdCt_h4=sFwg@mail.gmail.com>
 <CAMuHMdXgLR9yeLa5JKNdAOtNEirJ8263bmn1zRNAnKnmf8F-Sg@mail.gmail.com>
 <CAPDyKFrvSp6tmhP=2=9kca1d3+b6MezvxJWwMOW=Gv6D8TKrgA@mail.gmail.com>
In-Reply-To:
 <CAPDyKFrvSp6tmhP=2=9kca1d3+b6MezvxJWwMOW=Gv6D8TKrgA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|PAXPR04MB8318:EE_|DB5PEPF00014B9D:EE_|GVXPR04MB10849:EE_
X-MS-Office365-Filtering-Correlation-Id: 9892cc19-6321-44c8-ff2a-08de63175c95
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?a3lxdGQxMmg1ODVXdE5WMUUrQ0Y0NmJUMk5WUm1SSGZXOVZ2S3c1eGswS2JP?=
 =?utf-8?B?TUtaQm9qbzNwM0NtWWVMVStvbVhiSVF6UXB1alpVMzRHN0gxS3BubUwyZGZ3?=
 =?utf-8?B?Y1BaYUQrS3F4MEtmUkJXYXYyZ0Yyb2k2TklkcWE1QTlNd2lNSGFnaXg5eGdF?=
 =?utf-8?B?Qk8zNm90U0cyeGE0cHdjT2VSNUlkaTlpSGxyMjlrZmsrRFNWdlczcDBTSkRl?=
 =?utf-8?B?ZnI4UGtJM2VOdVRDYktGNGxYRHhKcHNnYTEwTDdIRFdlVW9aTHcwb1dxeVlZ?=
 =?utf-8?B?cXdVM3B2NUduc2FCS3N4UEFRNDFBVU9RUTRBV1hvSUVJa3p2Z0tqeE1Jd1cw?=
 =?utf-8?B?YmlvWlhxOEoyU1p1enRUc0JnSjcxNTdKV1Q4bGExUVFpRFVJdmF4M0hkU1FZ?=
 =?utf-8?B?SW11VXYydkFpQ3dwWGRYb2U4R3Z2andiWkZtc3V5bUtzTzF5UTMxeGkvRWo2?=
 =?utf-8?B?bjNFVk9Tai8xZUMvR2dQbHhQRzlBazk0REpvN0xCUkplbUFucTlpSkp6bFdU?=
 =?utf-8?B?Sk1GWTNiRzRJakdET1pwWWxZeTI3L1J1ZVNlc3A1STNXN2grd0NzV21nZGN3?=
 =?utf-8?B?Q2NNRmhJNzRRZFEwK3BOM1NqRG01SGpEbkVEOGM5QWZ3cXkzNElKZHRBb0hI?=
 =?utf-8?B?a1Z0L0g0VkQ0dWhrbkE4Rkx5dTFEUk8zVWhNTFRjeTVHWWNoWVhKR1A4eWxH?=
 =?utf-8?B?VWd4QThiQzlNR1MyenlsUFM2bEtjaGZnSkt5bmpUbDhKYXBFWVBtWXJ6aEQ4?=
 =?utf-8?B?a1BaQ2RxelRaVGFrQnNzUGdKakhvSlhmSG9ZSWhwb0luQ2ZQWUVQV2JxZnNm?=
 =?utf-8?B?WWdkbC8zaEt4RTgwMmZZT3ZJUU9ld1lzbjlIRUpiQ0t6TGlUTWh3WEJJamJn?=
 =?utf-8?B?bjRIMDNCS0g5M3ZPWmxCYW9EQ24wTzdLYzgzVEpLd05ocHNzbWJIY2xZajhZ?=
 =?utf-8?B?QU0rdVdONC81bGgxMFRBVkZ5QTlLUjFhckx4bTlhRWVVN1Nra2VLUHBrTTJL?=
 =?utf-8?B?QVZtejE5cnZsYzFrL2NINmZLN2N5YWZZdXJkU2NPTFJGMm9hMG1DNnVZdkpM?=
 =?utf-8?B?T0JQaFJGRW9UYVd5KzkwdWJpbVFjK3JtVkIxQ3Fxd3lOM1RyWlE2MjVwUGkw?=
 =?utf-8?B?RDdIT05SL1BBODRZbnprc05icEdrcXZ2UkNVRks4VE43NWtBZVpxbi9ZUTdv?=
 =?utf-8?B?bDB6NWtJSnU0QVRGd3NPV2daa08wSittNU45OWhROUFxRVhmQ0hlTVlwRVo2?=
 =?utf-8?B?b0J5Q0dCUkJsZVU4RXBoUDhUYXhPR0pBWEJPalIzZ2dVM0EyNFhCSkh0L1Q3?=
 =?utf-8?B?YzRTNGdGTlg5eXg3RzVINjVMQzRsemQ3SlR0cDhiSjBZaHp0SEM3bFF0TGhp?=
 =?utf-8?B?OGJDWUJSWmJ3QmpBUDI4am03cXkyVUFvVHRnY0t1bUlnVXRnNjFGZElFeHZy?=
 =?utf-8?B?VkgrRDc1c3licXNvRVd4VTFZdnJXNXVSL0hMakR6eG1BZDYvS09UbHJBRis5?=
 =?utf-8?B?T2pTU0pXOEV4aVB4a2F4WDN4NURrUkY0V3JKbXEwcHlwTnNqMU9pblp5YzFJ?=
 =?utf-8?B?aUIvUHhoNXBpeVEvdjM4NVNXNTVMSDZSbkpJcjJId1RPalBaL3I3N1U5TmlO?=
 =?utf-8?B?RnQ5blU2TzZ1UkJBbDg5Q3l2YmVDOEI0RkY1R041SWk3cEFTU25ZSEtnTG94?=
 =?utf-8?B?Y1d3bkpib1NiWFVnY0ZWOEdCR2FsSlpveGVTb2dNaXhIdDErSE1DbXdyWm0v?=
 =?utf-8?B?dnFGNzI4L05JTXM3VjlVczBRQkVXc0dMcHJka0FQTkM3RWdkYWZUNEkwU2ZO?=
 =?utf-8?B?YjdYeE5LN3lDVUdNTWlySWRSdWZBY0xjdUl1UEN0QnhESHVJd0lUOFNPQ2pu?=
 =?utf-8?B?Q0JsVDcyTm16WUlpOU5oaEFhbjE3NGZ1M3VIM1RkWjJ2Mis3MUhzNXZRLytl?=
 =?utf-8?B?L1JSNUQyRmp0ckpwMWtZd1g4SFV4L2JnbGlaanZ2OUZTOXFWVzJuZ0hRT05F?=
 =?utf-8?B?WnhPcmtLSm9XS0hyK29DSXRUOVExdFUwdlI1UUZ3VUZ3cFRjYnh4dmJyUzJB?=
 =?utf-8?B?azFsRXBoV3VKQkkyZGVkZkhiODRRWThud2JPQzhZVDVabEhhaHRWTjdZK0t6?=
 =?utf-8?B?N0o0U3Vod3cwOGhaTXZ6M1BPMmt4ekpUcXF6L0ZGTW1EQ2VLZFIyYlpLcEdK?=
 =?utf-8?Q?BECXCmQLxda2Qd8D6AalpLk=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <F853EFBEA940A24C8833386C0671243C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8318
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 757b4c12d22c4ac6a525931a0105304d:solidrun,office365_emails,sent,inline:39dd7ade418dfae992039918e2bdea7b
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	85dfa24b-f399-4cc2-ce64-08de63175672
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|14060799003|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUUrNlFDRExaVUV6dUNlZmlacElaL09VUi95cHNiVjVjK2FmMlNOZWEwblpC?=
 =?utf-8?B?QVBJdmlCWGtWMlNadmcveU5ROUUweStrQjJMQ0JwNUU3R2hjMTJMZnVsUUZC?=
 =?utf-8?B?L1NQdldYa1NObFBJT1Q4MnczUWZsYVB2Viszckd1bVczWk9DUG1rQndnZW5n?=
 =?utf-8?B?aElBTW02ekc3VG92ZGxtdGlUa0hLYkhDb2NlZEtBVy9aQXJic1pTSWFZMlRI?=
 =?utf-8?B?bzJDZXFQL0RpbGRlUmNORWorYlpsMmZRRThiT2IxRnp4VEo1cVEyNVJGeGtC?=
 =?utf-8?B?TEo4bFZCa2hMSUJEK2NpdllRVDZXV1RmNnRwbzl6VDRzcmhPdE5UeG5ESGNR?=
 =?utf-8?B?MWxUV1dLaXAwRHVPdkoxY1JlZ3FkLzJYd21pdzRXUllwWWRFcSs0ZjM4QXJI?=
 =?utf-8?B?ZzRlYW5obXd6M1NJblk0TXlNVHMvUXUxbjAweEhMUEQ5QjJVcjhqMU5LWHVV?=
 =?utf-8?B?S29pTUs3QU1ieTkzMXBCbGs3Y0pRUER4WmdtalpGSi9YK25vN2VKWnFkNkNB?=
 =?utf-8?B?bEt2UXl5TEhkWkVPVTdKRG5VOGc5R3BCek5BV3dBdlRxVFJSVVJRSzlKSHRT?=
 =?utf-8?B?dlZjQTlGUEFNNlZGREIwZzJtbVdlQm9rV0RmODRiYmVMNG9lNkhaaFo5WWJ0?=
 =?utf-8?B?UUFYbFFDTVNkYkdHdEMwbzZmaUxrdHBnbldZOWlsY1BVNzg5TjVkbW5YaUNM?=
 =?utf-8?B?ek1DZ0UwZUJWUWNDRkM1VW9TN0RUUzFIL1B1bTVvWVc4L2lkOWVDZ2VjNU9Q?=
 =?utf-8?B?NGpaRUpZazNwamVoYkhFOEQ0TDNkeUhQZDV5b0Q4SXNNT1c5bjlIdjlkL05J?=
 =?utf-8?B?aFl6SkRiSDlTSHB1dS82VnNXSzk3aStnQnVML2I2TlZscmhLMW9QWmxPRG8w?=
 =?utf-8?B?bnplUElxTk1YeEJKWjJ1NnR6d3d0RzlYejFVR1BSaDdKWFY5V0lYajU0NE1J?=
 =?utf-8?B?YU8vWFk5K21FUDNORmQ3aXBvOXpXcUYzZnFPcS9Zb3IzSzRXOFFmb2N6elVG?=
 =?utf-8?B?VDF1RmpmdGM0ekNDb2YxNVY0R0RjNk1FbG56S2ZjQ1RBb3ZmcDVpMFpUV2pL?=
 =?utf-8?B?MHZpTjRDcDliNDVUK0xvbzFoQjd6NkNDMDIvUFMyL1dpTHhrUllPTUlscE8z?=
 =?utf-8?B?eTBjU3NlTkN2ZHdMaG5vL1BCMTJ5K3YwdGIydURtZEMwU3V3MmJ3cDY1SWxJ?=
 =?utf-8?B?KzZIRlRrQi9nUkdoRVpkWnpkQytZWVhHU0dtczI5TnhSb3lFVDV3ZklGaCtN?=
 =?utf-8?B?OWVmcUlBTmdOcTk4S1ZQU2JnL3ZqNlFYbVZ6Y2JDZkdRUGdJeGpLSFIxQkRF?=
 =?utf-8?B?dk5TY2JpZy91QnZ4ZWRITHFFMzdzaTVkdjk3ZU16Sy91N2NXNnpaKy9uVzdB?=
 =?utf-8?B?TkQ4b3UzNFFsSVAxY1ltTVNreklNSTNHMlN3OWlWb3kwc045UUNFUEhxZmhJ?=
 =?utf-8?B?bmZrQmxzSVhHa0RHNjVyUTZSK3NYKzc0RGE5Q1pvT2dma0dqTEI1ZUZpWnpx?=
 =?utf-8?B?NjBhc2NRSVh2eE50RklsOExIWFZiNzkxQzU2OU4weXN5cGNkTGZCeEtaZEx2?=
 =?utf-8?B?eFE4b3QySkxwVmJvcHlhcUw3akdseTJ1U0ZJT2xxRWU1RHFBcjVuWFVJcDJL?=
 =?utf-8?B?a2sxWE5pYWtmbWYvYyswamZxcnBYbUJtMUlwMkhlbkRKd3Q0Ui9Ram9KY215?=
 =?utf-8?B?amJ1YmM3WXVWRFNMeEZoRm1OODAveFJ0aUg1RjAvT3NJKzQ3bDZ2eFBkbThl?=
 =?utf-8?B?RDk2YjVmeFo5bG1OcXo5MzhEMnQ1TG9POTdGbWNWdC9zNXgxUVAwbTFiZ3Rz?=
 =?utf-8?B?NkhVMVNneXJJRDlSYjZMaW04T2V2WWRTVlJDc0licnMwTUYraWNld1JGS0Vs?=
 =?utf-8?B?bFdwNGJYM2F6TlJJbmFwcEUwdVd2QzVScG9GKzlWM0dsR0JsbGd1TlY0NDlj?=
 =?utf-8?B?a00xYzFXQVYweThFNXIwSmNsOU9rMEp3dEc5bEExTDlML1NYdVpQTFJ6akpX?=
 =?utf-8?B?ZTVtSGZHclN4eUl0bkVEdDlsWVBlU09Wby9TVzZDT3ErMUxpMnFTeUx4Sm0x?=
 =?utf-8?B?b3Vab2VPbVVtdWdKVElxY0ZvdDdTa1JBQkRPRnBkcHc0WG9lN2IzZWtXalB0?=
 =?utf-8?B?ZURyRUFYWnhLdXU3QkJlM0xpaDVIZjZCTnBEdWdOUDZGS29JaEhUbjlaenJO?=
 =?utf-8?B?TjZGT3paRzZ0OU5KODQyT0wxUkxLclRuYmtub3phZDAwakVBSjdvOTd2Tzhr?=
 =?utf-8?B?M0tsc3ZBOTVpR29rbGtKckdZYzdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(14060799003)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gPS2dnveII8OWXfTL3vjJjBcAowIsZ7ALu1QtzditQSwcgOBIDRfCtYb9lKSP+FisBGRCY3Ve2VkMtmyE+4uafz5D8TxbafXcOBR9yKd20SsP+H2PEEIObso/nAX0A6rFAuhqA2G2pjkaW4z1MBHAGHJWEn8onprmPp7grvRaUQjcyG+QIebSBM2OiAJvjGQ1ovdt6nO5o1O+QOEgIxghl6jPTmrCLbPei8WabKsL+JDbGUT/rBnsX6uLAHmlkH7iTLnlKpMNNA96c7M18vz5VcrPoMBPv7mL2zBKPvDDeyuj9gu+68CwaWGfrpIark9R0jB3KmCWBljgHCkpvuRL97OkhfKXfeTGrYKywrw4bHwvuq0PPIQiibhVXbpEvSYjyJW0uRqy6KmkpVscQJ7HJmpo3maC1RNuBM0EwJZNpeZfIk8Ds+oSySQR5xu/yIo
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:28:32.1500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9892cc19-6321-44c8-ff2a-08de63175c95
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10849
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6462-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linux-m68k.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,solid-run.com:mid,solid-run.com:email,solidrn.onmicrosoft.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3218CD870E
X-Rspamd-Action: no action

T24gMzAvMDEvMjAyNiAxMjoyOCwgVWxmIEhhbnNzb24gd3JvdGU6DQo+IE9uIFRodSwgMjkgSmFu
IDIwMjYgYXQgMTg6NDYsIEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+
IHdyb3RlOg0KPj4gT24gVGh1LCAyOSBKYW4gMjAyNiBhdCAxNzowNiwgVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+IHdyb3RlOg0KPj4+IE9uIFdlZCwgMjggSmFuIDIwMjYgYXQg
MTU6NDYsIEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPiB3cm90ZToNCj4+Pj4gSW4t
dHJlZSBwaHktY2FuLXRyYW5zY2VpdmVyIGRyaXZlciBoYXMgYWxyZWFkeSBpbXBsZW1lbnRlZCBh
IGxvY2FsDQo+Pj4+IHZlcnNpb24gb2YgZGV2bV9tdXhfc3RhdGVfZ2V0X29wdGlvbmFsLg0KPj4+
Pg0KPj4+PiBUaGUgb21hcC1pMmMgZHJpdmVyIGdldHMgYW5kIHNlbGVjdHMgYW4gb3B0aW9uYWwg
bXV4IGluIGl0cyBwcm9iZQ0KPj4+PiBmdW5jdGlvbiB3aXRob3V0IHVzaW5nIGFueSBoZWxwZXIu
DQo+Pj4+DQo+Pj4+IEFkZCBuZXcgaGVscGVyIGZ1bmN0aW9ucyBjb3ZlcmluZyBib3RoIGFmb3Jl
bWVudGlvbmVkIHVzZS1jYXNlczoNCj4+Pj4NCj4+Pj4gLSBtdXhfY29udHJvbF9nZXRfb3B0aW9u
YWw6DQo+Pj4+ICAgIEdldCBhIG11eC1jb250cm9sIGlmIHNwZWNpZmllZCBpbiBkdCwgcmV0dXJu
IE5VTEwgb3RoZXJ3aXNlLg0KPj4+PiAtIGRldm1fbXV4X3N0YXRlX2dldF9vcHRpb25hbDoNCj4+
Pj4gICAgR2V0IGEgbXV4LXN0YXRlIGlmIHNwZWNpZmllZCBpbiBkdCwgcmV0dXJuIE5VTEwgb3Ro
ZXJ3aXNlLg0KPj4+PiAtIGRldm1fbXV4X3N0YXRlX2dldF9zZWxlY3RlZDoNCj4+Pj4gICAgR2V0
IGFuZCBzZWxlY3QgYSBtdXgtc3RhdGUgc3BlY2lmaWVkIGluIGR0LCByZXR1cm4gZXJyb3Igb3Ro
ZXJ3aXNlLg0KPj4+PiAtIGRldm1fbXV4X3N0YXRlX2dldF9vcHRpb25hbF9zZWxlY3RlZDoNCj4+
Pj4gICAgR2V0IGFuZCBzZWxlY3QgYSBtdXgtc3RhdGUgaWYgc3BlY2lmaWVkIGluIGR0LCByZXR1
cm4gZXJyb3Igb3IgTlVMTC4NCj4+Pj4NCj4+Pj4gRXhpc3RpbmcgbXV4X2dldCBoZWxwZXIgZnVu
Y3Rpb24gaXMgY2hhbmdlZCB0byB0YWtlIGFuIGV4dHJhIGFyZ3VtZW50DQo+Pj4+IGluZGljYXRp
bmcgd2hldGhlciB0aGUgbXV4IGlzIG9wdGlvbmFsLg0KPj4+PiBJbiB0aGlzIGNhc2Ugbm8gZXJy
b3IgaXMgcHJpbnRlZCwgYW5kIE5VTEwgcmV0dXJuZWQgaW4gY2FzZSBvZiBFTk9FTlQuDQo+Pj4+
DQo+Pj4+IENhbGxpbmcgY29kZSBpcyBhZGFwdGVkIHRvIGhhbmRsZSBOVUxMIHJldHVybiBjYXNl
LCBhbmQgdG8gcGFzcyBvcHRpb25hbA0KPj4+PiBhcmd1bWVudCBhcyByZXF1aXJlZC4NCj4+Pj4N
Cj4+Pj4gVG8gc3VwcG9ydCBhdXRvbWF0aWMgZGVzZWxlY3QgZm9yIF9zZWxlY3RlZCBoZWxwZXIs
IGEgbmV3IHN0cnVjdHVyZSBpcw0KPj4+PiBjcmVhdGVkIHN0b3JpbmcgYW4gZXhpdCBwb2ludGVy
IHNpbWlsYXIgdG8gY2xvY2sgY29yZSB3aGljaCBpcyBjYWxsZWQgb24NCj4+Pj4gcmVsZWFzZS4N
Cj4+Pj4NCj4+Pj4gVG8gZmFjaWxpdGF0ZSBjb2RlIHNoYXJpbmcgYmV0d2VlbiBvcHRpb25hbC9t
YW5kYXRvcnkvc2VsZWN0ZWQgaGVscGVycywNCj4+Pj4gYSBuZXcgaW50ZXJuYWwgaGVscGVyIGZ1
bmN0aW9uIGlzIGFkZGVkIHRvIGhhbmRsZSBxdWlldCAob3B0aW9uYWwpIGFuZA0KPj4+PiB2ZXJi
b3NlIChtYW5kYXRvcnkpIGVycm9ycywgYXMgd2VsbCBhcyBzdG9yaW5nIHRoZSBjb3JyZWN0IGNh
bGxiYWNrIGZvcg0KPj4+PiBkZXZtIHJlbGVhc2U6IF9fZGV2bV9tdXhfc3RhdGVfZ2V0DQo+Pj4+
DQo+Pj4+IER1ZSB0byB0aGlzIHN0cnVjdHVyZSBkZXZtX211eF9zdGF0ZV9nZXRfKl9zZWxlY3Rl
ZCBjYW4gbm8gbG9uZ2VyIHByaW50DQo+Pj4+IGEgdXNlZnVsIGVycm9yIG1lc3NhZ2Ugd2hlbiBz
ZWxlY3QgZmFpbHMuIEluc3RlYWQgY2FsbGVycyBzaG91bGQgcHJpbnQNCj4+Pj4gZXJyb3JzIHdo
ZXJlIG5lZWRlZC4NCj4+Pj4NCj4+Pj4gQ29tbWl0IGUxNTNmZGVhOWRiMDQgKCJwaHk6IGNhbi10
cmFuc2NlaXZlcjogUmUtaW5zdGF0ZSAibXV4LXN0YXRlcyINCj4+Pj4gcHJvcGVydHkgcHJlc2Vu
Y2UgY2hlY2siKSBub3RlZCB0aGF0ICJtdXhfZ2V0KCkgYWx3YXlzIHByaW50cyBhbiBlcnJvcg0K
Pj4+PiBtZXNzYWdlIGluIGNhc2Ugb2YgYW4gZXJyb3IsIGluY2x1ZGluZyB3aGVuIHRoZSBwcm9w
ZXJ0eSBpcyBub3QgcHJlc2VudCwNCj4+Pj4gY29uZnVzaW5nIHRoZSB1c2VyLiINCj4+Pj4NCj4+
Pj4gVGhlIGZpcnN0IGVycm9yIG1lc3NhZ2UgY292ZXJzIHRoZSBjYXNlIHRoYXQgYSBtdXggbmFt
ZSBpcyBub3QgbWF0Y2hlZA0KPj4+PiBpbiBkdC4gVGhlIHNlY29uZCBlcnJvciBtZXNzYWdlIGlz
IGJhc2VkIG9uIG9mX3BhcnNlX3BoYW5kbGVfd2l0aF9hcmdzDQo+Pj4+IHJldHVybiB2YWx1ZS4N
Cj4+Pj4NCj4+Pj4gSW4gb3B0aW9uYWwgY2FzZSBubyBlcnJvciBpcyBwcmludGVkIGFuZCBOVUxM
IGlzIHJldHVybmVkLg0KPj4+PiBUaGlzIGVuc3VyZXMgdGhhdCB0aGUgbmV3IGhlbHBlciBmdW5j
dGlvbnMgd2lsbCBub3QgY29uZnVzZSB0aGUgdXNlcg0KPj4+PiBlaXRoZXIuDQo+Pj4+DQo+Pj4+
IFdpdGggdGhlIGFkZGl0aW9uIG9mIG9wdGlvbmFsIGhlbHBlciBmdW5jdGlvbnMgaXQgYmVjYW1l
IGNsZWFyIHRoYXQNCj4+Pj4gZHJpdmVycyBzaG91bGQgY29tcGlsZSBhbmQgbGluayBldmVuIGlm
IENPTkZJR19NVUxUSVBMRVhFUiB3YXMgbm90IGVuYWJsZWQuDQo+Pj4+IEFkZCBzdHVicyBmb3Ig
YWxsIHN5bWJvbHMgZXhwb3J0ZWQgYnkgbXV4IGNvcmUuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYt
Ynk6IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPj4+PiAtLS0NCj4+Pj4gICBk
cml2ZXJzL211eC9jb3JlLmMgICAgICAgICAgIHwgMTc4ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0NCj4+Pj4gICBpbmNsdWRlL2xpbnV4L211eC9jb25zdW1lci5o
IHwgMTA4ICsrKysrKysrKysrKysrKysrKysrKysrKystDQo+Pj4+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCAyNTMgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL211eC9jb3JlLmMgYi9kcml2ZXJzL211eC9jb3JlLmMNCj4+Pj4gaW5kZXgg
YTM4NDBmZTA5OTVmLi5iMDFlYzEyNmNhYWYgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvbXV4
L2NvcmUuYw0KPj4+PiArKysgYi9kcml2ZXJzL211eC9jb3JlLmMNCj4+PiBbLi4uXQ0KPj4+DQo+
Pj4+ICAgc3RhdGljIHZvaWQgZGV2bV9tdXhfc3RhdGVfcmVsZWFzZShzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHZvaWQgKnJlcykNCj4+Pj4gICB7DQo+Pj4+IC0gICAgICAgc3RydWN0IG11eF9zdGF0ZSAq
bXN0YXRlID0gKihzdHJ1Y3QgbXV4X3N0YXRlICoqKXJlczsNCj4+Pj4gKyAgICAgICBzdHJ1Y3Qg
ZGV2bV9tdXhfc3RhdGVfc3RhdGUgKmRldm1fc3RhdGUgPSByZXM7DQo+Pj4+DQo+Pj4+IC0gICAg
ICAgbXV4X3N0YXRlX3B1dChtc3RhdGUpOw0KPj4+PiArICAgICAgIGlmIChkZXZtX3N0YXRlLT5l
eGl0KQ0KPj4+PiArICAgICAgICAgICAgICAgZGV2bV9zdGF0ZS0+ZXhpdChkZXZtX3N0YXRlLT5t
c3RhdGUpOw0KPj4+PiArDQo+Pj4+ICsgICAgICAgbXV4X3N0YXRlX3B1dChkZXZtX3N0YXRlLT5t
c3RhdGUpOw0KPj4+PiAgIH0NCj4+Pj4NCj4+Pj4gICAvKioNCj4+Pj4gLSAqIGRldm1fbXV4X3N0
YXRlX2dldCgpIC0gR2V0IHRoZSBtdXgtc3RhdGUgZm9yIGEgZGV2aWNlLCB3aXRoIHJlc291cmNl
DQo+Pj4+IC0gKiAgICAgICAgICAgICAgICAgICAgICAgbWFuYWdlbWVudC4NCj4+Pj4gLSAqIEBk
ZXY6IFRoZSBkZXZpY2UgdGhhdCBuZWVkcyBhIG11eC1jb250cm9sLg0KPj4+PiAtICogQG11eF9u
YW1lOiBUaGUgbmFtZSBpZGVudGlmeWluZyB0aGUgbXV4LWNvbnRyb2wuDQo+Pj4+ICsgKiBfX2Rl
dm1fbXV4X3N0YXRlX2dldCgpIC0gR2V0IHRoZSBvcHRpb25hbCBtdXgtc3RhdGUgZm9yIGEgZGV2
aWNlLA0KPj4+PiArICogICAgICAgICAgICAgICAgICAgICAgICAgd2l0aCByZXNvdXJjZSBtYW5h
Z2VtZW50Lg0KPj4+PiArICogQGRldjogVGhlIGRldmljZSB0aGF0IG5lZWRzIGEgbXV4LXN0YXRl
Lg0KPj4+PiArICogQG11eF9uYW1lOiBUaGUgbmFtZSBpZGVudGlmeWluZyB0aGUgbXV4LXN0YXRl
Lg0KPj4+PiArICogQG9wdGlvbmFsOiBXaGV0aGVyIHRvIHJldHVybiBOVUxMIGFuZCBzaWxlbmNl
IGVycm9ycyB3aGVuIG11eCBkb2Vzbid0IGV4aXN0Lg0KPj4+PiArICogQGluaXQ6IE9wdGlvbmFs
IGZ1bmN0aW9uIHBvaW50ZXIgZm9yIG11eC1zdGF0ZSBvYmplY3QgaW5pdGlhbGlzYXRpb24uDQo+
Pj4+ICsgKiBAZXhpdDogT3B0aW9uYWwgZnVuY3Rpb24gcG9pbnRlciBmb3IgbXV4LXN0YXRlIG9i
amVjdCBjbGVhbnVwIG9uIHJlbGVhc2UuDQo+Pj4+ICAgICoNCj4+Pj4gICAgKiBSZXR1cm46IFBv
aW50ZXIgdG8gdGhlIG11eC1zdGF0ZSwgb3IgYW4gRVJSX1BUUiB3aXRoIGEgbmVnYXRpdmUgZXJy
bm8uDQo+Pj4+ICAgICovDQo+Pj4+IC1zdHJ1Y3QgbXV4X3N0YXRlICpkZXZtX211eF9zdGF0ZV9n
ZXQoc3RydWN0IGRldmljZSAqZGV2LA0KPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY29uc3QgY2hhciAqbXV4X25hbWUpDQo+Pj4+ICtzdGF0aWMgc3RydWN0IG11eF9z
dGF0ZSAqX19kZXZtX211eF9zdGF0ZV9nZXQoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFy
ICptdXhfbmFtZSwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGJvb2wgb3B0aW9uYWwsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpbnQgKCppbml0KShzdHJ1Y3QgbXV4X3N0YXRlICptc3RhdGUpLA0K
Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50ICgq
ZXhpdCkoc3RydWN0IG11eF9zdGF0ZSAqbXN0YXRlKSkNCj4+Pj4gICB7DQo+Pj4+IC0gICAgICAg
c3RydWN0IG11eF9zdGF0ZSAqKnB0ciwgKm1zdGF0ZTsNCj4+Pj4gKyAgICAgICBzdHJ1Y3QgZGV2
bV9tdXhfc3RhdGVfc3RhdGUgKmRldm1fc3RhdGU7DQo+Pj4+ICsgICAgICAgc3RydWN0IG11eF9z
dGF0ZSAqbXN0YXRlOw0KPj4+PiArICAgICAgIGludCByZXQ7DQo+Pj4+DQo+Pj4+IC0gICAgICAg
cHRyID0gZGV2cmVzX2FsbG9jKGRldm1fbXV4X3N0YXRlX3JlbGVhc2UsIHNpemVvZigqcHRyKSwg
R0ZQX0tFUk5FTCk7DQo+Pj4+IC0gICAgICAgaWYgKCFwdHIpDQo+Pj4+ICsgICAgICAgZGV2bV9z
dGF0ZSA9IGRldnJlc19hbGxvYyhkZXZtX211eF9zdGF0ZV9yZWxlYXNlLCBzaXplb2YoKmRldm1f
c3RhdGUpLCBHRlBfS0VSTkVMKTsNCj4+Pj4gKyAgICAgICBpZiAoIWRldm1fc3RhdGUpDQo+Pj4+
ICAgICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7DQo+Pj4+DQo+Pj4+IC0g
ICAgICAgbXN0YXRlID0gbXV4X3N0YXRlX2dldChkZXYsIG11eF9uYW1lKTsNCj4+Pj4gLSAgICAg
ICBpZiAoSVNfRVJSKG1zdGF0ZSkpIHsNCj4+Pj4gLSAgICAgICAgICAgICAgIGRldnJlc19mcmVl
KHB0cik7DQo+Pj4+IC0gICAgICAgICAgICAgICByZXR1cm4gbXN0YXRlOw0KPj4+PiArICAgICAg
IG1zdGF0ZSA9IG11eF9zdGF0ZV9nZXQoZGV2LCBtdXhfbmFtZSwgb3B0aW9uYWwpOw0KPj4+PiAr
ICAgICAgIGlmIChJU19FUlJfT1JfTlVMTChtc3RhdGUpKSB7DQo+Pj4+ICsgICAgICAgICAgICAg
ICByZXQgPSBQVFJfRVJSKG1zdGF0ZSk7DQo+Pj4gU2hvdWxkIHRoaXMgYmUgUFRSX0VSUl9PUl9a
RVJPPw0KPj4gIm11eF9zdGF0ZV9nZXQoKSBuZXZlciByZXR1cm5zIE5VTEwiDQo+PiBodHRwczov
L2xvcmUua2VybmVsLm9yZy8yMDI2MDEyMjEwMzYuSjBrUjc4VXctbGtwQGludGVsLmNvbQ0KPiBC
eSBsb29raW5nIGF0IHRoZSBjb2RlIGluIG11eF9zdGF0ZV9nZXQoKSBhbmQgbXV4X2dldCgpIHRo
YXQgJHN1YmplY3QNCj4gcGF0Y2ggY2hhbmdlcywgaXQgaW50ZW5kcyB0byBhZGQgYSAiYm9vbCBv
cHRpb25hbCIgYXMgaW4tcGFyYW1ldGVyLiBJZg0KPiBpdCdzIHNldCwgaXQgbG9va3MgbGlrZSB0
aGUgaW50ZW50IGlzIHRvIGFsbG93IHJldHVybmluZyBOVUxMLCB3aGljaA0KPiBtYWtlcyBzZW5z
ZSB0byBtZS4NClRoZSBpbnRlbnQgYmVoaW5kICJvcHRpb25hbCIgcGFyYW1ldGVyIHdhcyB0byBj
b25kaXRpb25hbGx5DQpzaWxlbmNlIGNlcnRhaW4gZXJyb3IgcGF0aHMgdGhhdCB3b3VsZCBldmVu
dHVhbGx5IGxlYWQgdG8NCmF0IGxlYXN0IHRoZSBleHBvcnRlZCBkZXZtXyogZnVuY3Rpb25zIHRv
IHJldHVybiBOVUxMLg0KDQpJJ2xsIHJldmlldyBteSBsb2dpYyAuLi4NCg0KPg0KPiBBbnl3YXks
IHRoZXJlIHNlZW1zIHRvIGJlIHNvbWUgYWRkaXRpb25hbCBzbWF0Y2ggd2FybmluZ3MgdG8gZml4
DQo+IGJlZm9yZSB0aGlzIGlzIHJlYWR5IHRvIGdvLg0KPg0KPiBbLi4uXQ0KPg0KPiBLaW5kIHJl
Z2FyZHMNCj4gVWZmZQ0KPg0KDQo=


