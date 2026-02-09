Return-Path: <linux-can+bounces-6519-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDoNL6fAiWk/BgUAu9opvQ
	(envelope-from <linux-can+bounces-6519-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 12:10:31 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1FC10E85C
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 12:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE4C8300C03B
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 11:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A66536C0DE;
	Mon,  9 Feb 2026 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="EVIRgPwh"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023077.outbound.protection.outlook.com [40.107.162.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799D36C0D9;
	Mon,  9 Feb 2026 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770635428; cv=fail; b=jcYfo36EmVYqjcU1CdAc1P0QXta5sN9nrZYy+CfLh+mqi1tUwA+/G5pPl9YSx6F7jsKMkUbTg2EiiDvfm54Hf7qb4rEfNbIcazlzphxUluMSBcN87WbjhcANweEIV+Umiw+mb1tMcl2B/eR/l2TWgdVcGizFYBOTyQQcVCuOJnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770635428; c=relaxed/simple;
	bh=U2mlJCqC6gdvGQ0kcm0rRJBGOJVl3pgaqwp/o7ODS6U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s7nbXjSKn24rOu5sm8uinCMERTCwkgMEjGqyl2IVFS9GMTfvpRb5mvG4bEJ+lIMme8IdfvdscWfTa+TgS2tCiB88HWEeHGo2KMilUFGsDjuX6vFZwvmpDMYf2XYRYWbFZpdrxo+uVljPTRP5m0iITm3SYtYG+XNDExA9O+xVskc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=EVIRgPwh; arc=fail smtp.client-ip=40.107.162.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xW2g4szEJEUxZ9kvNS9SpGFV8pigqpquuKNiLjpkfC/vVVQraD49TJzajGeaaSwzGWYAeGotqDv+qjHTKsd+w7FMtJ9ttgsHRRt6uvArwS4sfOwvFi4fIA+OXtD39tUrzEZcgsOJYhkbee+/bm0BJXhu5QstE2wsuRUeHnLGyLE6+f7AdfK/B2m1/PfWoeFwzFF6pvVKx1SM6fPWCKCqto4xgZaRVQNNB3T/akXMRx8tDgFRzJ88hQCtJudCWVQ+ooGxhQDe5Lm6mmh1KcEvLo3O2LjqBvhyuSY/sMuVvzplTQvSlGViv9k3ZFFASlbbpNKuXN3zbOpgB7BbFoOtcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V584dm06vG98qidz3rQc62kqeHTkWi4K8lYHVQr0vhk=;
 b=Ms4I6Az4PL8JYu3CeX1tEy98SE/OL+p1pOFo5EYUnJseWUTpby1pFLz9b/OmdwgIdnD9WCN8pWqzi/UxduZnyTMMigCIOcMvRNkcpUdQSaf50KzeO1JtzQLFsEyWMWiHpJ1I7YLzqz8LxzpVb1FF3LJ8iIPkN9u3B95T0sHJG+pB+Ci1iSVPV6/MVQ0gltV2SM2KU264DN8zrLb4pKb+cx7/oTxn4HuKDtWmjxa48ZODNLseaNJy6NBbq7tRa64WhAEjCzHW6w6BHx473bgyT5np0YzpbJVuloL7LaHbS53OztsfFrkAv66snlvKjfOr5M2RkJYVxPcMI5AVAc0vKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V584dm06vG98qidz3rQc62kqeHTkWi4K8lYHVQr0vhk=;
 b=EVIRgPwhRgUbbfGV/SFbsthppoqsb7fs/9ZnWuLeM8m3xJfUA3kB4cnApJ5gIEzNkQuVqpRH1FCxXiJj5MUabXyuDFNrA+UQuAuiTA2qHerUfbcL9Xmx1jx0DHPPKO9MTkK6++EUrqPhZOF2sRQzPISYA+uXBM8EvHF1xqKwr5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com (2603:10a6:20b:5c1::5)
 by GVXPR02MB10902.eurprd02.prod.outlook.com (2603:10a6:150:14d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 11:10:22 +0000
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714]) by AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714%6]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 11:10:22 +0000
Message-ID: <bc5fbfc5-6f71-eeed-ad90-0c1b835e65ea@axentia.se>
Date: Mon, 9 Feb 2026 12:10:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 3/7] mux: add help text for MULTIPLEXER config option
Content-Language: sv-SE
To: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-3-9a3be13c1280@solid-run.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <20260208-rz-sdio-mux-v9-3-9a3be13c1280@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0000385B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:b) To AS8PR02MB9235.eurprd02.prod.outlook.com
 (2603:10a6:20b:5c1::5)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9235:EE_|GVXPR02MB10902:EE_
X-MS-Office365-Filtering-Correlation-Id: 5546f7f3-e9b1-4e4c-603f-08de67cbd130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MW45QzM3ZGQrdnY1Q3d3ZFRYL2g2eG5XRjMxNHVMalhhNEc5UG9BZVJ0NlBh?=
 =?utf-8?B?dUpqTCsxeXVRNXdrVzN3YXRvTzU0VUsxOHV3aTZ6QVNlWEx5SFp6UjVBbkla?=
 =?utf-8?B?TzN3MkNHWFFhWWMvZ0IzdElJZEZ3QXRUYmxjQ2c2ZktWWmk2K2R3dE4vMzI3?=
 =?utf-8?B?SlRmRFQ3Wlo5VHp3MWJnUEtvN2FEMWxhWnlab3Y4R3FKbUtqTHF4TDVEUng4?=
 =?utf-8?B?c29tMjg5aUJ5V25iR3lrVDAwc3U1MHJ5MGpXZG0xV3lYZ3UyWHloMXVEMG5I?=
 =?utf-8?B?NUE1bkJuWVFlUm0ycFdEZVR4dWFOZ21DZWdtNEFBcVplaTlIeE84MkNwWU4v?=
 =?utf-8?B?aWpKQ01aeFpzek1icXo5UHdoMW5kRGhDRFdVQW1aMWprYVByK1Rsa1FjSW9T?=
 =?utf-8?B?LytDUWFCMmFoZUVlTnVYT1ZteEtQalUycmxidElxMExiSXpobGh6VWhySHNt?=
 =?utf-8?B?VWxpTmc3UlFubWtpMm9Oa0hqeCtVUDJFTEJBc2NsTVhhY2pyb1Z5Z3JDZ0tN?=
 =?utf-8?B?bXkzZTllakdoT3N0OE5YUlVHWmpmc0t4TlI0a1NiRjJCU0NnRGpML1NhL0kx?=
 =?utf-8?B?a0tDcThwY1BVK3lSRW41dENWTzYvQnFldDZzZTRmWmowYVdLK2JBQjlLQzdK?=
 =?utf-8?B?OTJmWmtCM3dKcmJaV0ZmUUFTYk1UNy9EdUlBYUgwcStDMnRtM2dWalZ0RE5w?=
 =?utf-8?B?cThPTElnNVdEMzNPZXB1b0pjRzVsY1kvaks3WHMyM1lJMDFWNzEwWkk5K0p0?=
 =?utf-8?B?emZZa3A3SWNUR056eWNrelBkNDlLR1U1UWpVVWZoUk1aNXRoOEJjMXg4ZURl?=
 =?utf-8?B?d2tkZmc1ZUxDQ3dDYmlUVWE2dzNEMUJhSEp2UjRIU1ZXL05Bcm5vbGJKYzNF?=
 =?utf-8?B?OWxFZFYyVWpBRktpbjVJTFJLdldDdkxvUVhDNlRIODRVcndyLzFOUEk3RnBm?=
 =?utf-8?B?MmlaWkRmeFB4TUNTMTF4MUFsaHduR1doa1dtaFlKR3lNNXpHL29tMXZoZUM1?=
 =?utf-8?B?MEJITWt6OVl6YWRJMVZFTWY0SnZIMldvQnhYbk5TZitsTkthcUlYT0h4cU0z?=
 =?utf-8?B?RlViY0wyTlZueGhrb05nOUp0aC9Zak9wTHVNVjdyS0x0bTlrMmYrcTF3VDlr?=
 =?utf-8?B?N2tHUGg4RHBwZ25JN2o1OUhKMVV0QXN6V3VIbFQ2Rkp6WDVibmJLemtmZXVv?=
 =?utf-8?B?em5HUHFSK0d6b25iOHhWQTI4OVdIdTlxR1YwMi96bXhQODgrRWVYVTlhRFVh?=
 =?utf-8?B?dWszZjZEeHc0QUhwdG5vSmNKRVIwTkh5Ylcway9CY3hWU2pHemtuQUp4UXZL?=
 =?utf-8?B?dmVTODZVRVYzTHlHVlc3bnU3bkllRW1uTjVuOVhZcUprRjlyZ2s1azdaTFdL?=
 =?utf-8?B?dGQrUGlHU3RaMDdncy9uY01Ld2FhZnU1RE9XWUEzNUZ5QTFPMFI2NjdTUWdX?=
 =?utf-8?B?cjJEYWo3TTh3ZnhQK0o2ZWp1NDZCcVVEdEpVZDgrck54SmxsWVYyc3R5cW0z?=
 =?utf-8?B?cUdlS2dGVjZ2L3lzN0dzV2swWU1oOEU3MVNzdFFGTE9hSVBTbVl6UHdjM1Jz?=
 =?utf-8?B?RDlmOG5tZjlTN1NxemZOZHNVcEtBV0k4K2lOWEdieEY3VnFsYTRPUDI4VzBv?=
 =?utf-8?B?bjFZMnYwSWZpSXdBTHFpR1p0dS80NThYQkhHTnppc1VQZlgyeld4Z043Z0NQ?=
 =?utf-8?B?V1dSU2J2L1k3SXhvWFltQlZuMW5ROWxVaHBlU1RwS2lCbW9CUXRrVkRjWGNq?=
 =?utf-8?B?bVQ5a0NjM0g1WW9nS2Nrd2swaUV1SHd2eG9wRVU0T0lrdFhJbTNwQTlHU3hv?=
 =?utf-8?B?dUtHVFA5bFBPS3JjR1BLa1pkaElIbDJIdVFDL1JjWGEzOStNL2hibm5RSkVH?=
 =?utf-8?B?eUV3RVg5S3FvNDV4c1FQNHlzS1RMbmxvbnFZeGVNSlB4OG1IZnMvallaMHRB?=
 =?utf-8?B?V2U0Skl1cXVoblhDMnUram1oQlRQWml3QjRkL1hpUTNMUmRmWngyTkR4VmVP?=
 =?utf-8?B?andHTmtpZnE1SE4vSEpVM3dHekM0V0w3MG54ZXY1bk5pdlkySnNVVzJXYUZr?=
 =?utf-8?B?QVpSc1JiVGx4YXY1T0gzTUFacG9tcGd0REhPTjc2RWRpR1RGT1pVWEd0UWpv?=
 =?utf-8?B?R0JIQ2N0TVVVcGNpN0FlUXJDa21tYmlKY2tYdmlLRDlzYkhEWTJVKzRwVlFT?=
 =?utf-8?B?VGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9235.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3JweTQrRDk0VlNHS2MzUmdpSHpiV0FVSDlYdTNKTlVXamdaYURhVkM4Unp0?=
 =?utf-8?B?VlJqYWs4Q1dSK0o5L1hsZGh1dDRWTWlEODlQenBjaXNZbWIvaVJZTkZSeEs5?=
 =?utf-8?B?VlpyRC9RbS9QQ2JPSGhDY2ZVMkRwMUVEb2Nxa09WZExFOGpJMlVHNTJ5eDVH?=
 =?utf-8?B?VDNFVmhzUndnWnJoNHBrTkNEeU9aVjR1NFVmV2hENDFxVklRVTlNZmx0b3Fn?=
 =?utf-8?B?VFhyQldKOThFTkZZL0h1R1pzWnBQc1BNY3o3b3UrTk11c1VBTTRWemVJbzY2?=
 =?utf-8?B?cDNVbmMyVlN1T0cyNUF5eE1peisrUkVwbU5jelUxRFlEV1hHQTFoSkVrQ1Z0?=
 =?utf-8?B?WERIL3hqQzhRQk5hbFdNODV5NDNIZFRqK0R4NVBKUjhRcEZZNEJMejlrYStI?=
 =?utf-8?B?dE5TaWE1cFNYN2tPczB5ZlpYbmU2VzhGVGJSN1BoZmdsRm5aa0lsNDJxbW85?=
 =?utf-8?B?Q2U0M1dsbGlDV2pxNm9ham1pdjVCTml6aXc3Y09VZDJOQklWajF3NVVkR0V0?=
 =?utf-8?B?eUQwL3JWTzJNZFFpQU95VjNobGsyNCtTUXhnemd0RkJnY1VvYjdJNkhZYWJP?=
 =?utf-8?B?VXJwdkxwODJJTGdzSXZCcW5vYWdZQmRDcFpsS3hWUzRSWkwzaGh0YWZDSVh4?=
 =?utf-8?B?TVlWN2l6TFNGQkk2YlM5ODh1NlRWM0RvZ2Z5R3VwczhoOTJSMFU2ZWpwUkRB?=
 =?utf-8?B?NmlmeDJrN2hhWWtxejJqMDJaYTQ1WWJFK2tPTGlmNXBnM2pQZUs5MEdmdzRP?=
 =?utf-8?B?QVJSYWFpQXBEWWNOS2JuTTFUYUdMcHM0TVJHN2xxZElWd0RRVFRWVTVUWkVW?=
 =?utf-8?B?cUpqOWh6NHQ2M3dadnMzTHF0R0Z4RUpMdnIxSG5rQVIzc1NtNGEvazQya0Y0?=
 =?utf-8?B?S0gyczdVWXVoSlRrWGtXeFAvSGVWdWZtSGdheFlIaXFuTFdMaTFiODBublBV?=
 =?utf-8?B?Q3lNTlJ1VG82TzlOWkR5MERoeDVnbHBsK2Nvb3Mxd2w1elBJNzM5Q3pzZHpF?=
 =?utf-8?B?MWcyaEdNY0pGcGtrS1lWWDM4TlhPd1lnS3dDUmtFeDRIYlJZYkRwUUxROUd0?=
 =?utf-8?B?Z09pVVVuRFpqbUU0RFV2KzBLS0pZY2VYWGpQU3JWaGVQUUNVZHh1UEhLeGpr?=
 =?utf-8?B?dDZIRkdmZXc0WGhDb0pybndwOW9uNjJTcEFpeUJldmNTVWNRQkZmRGFSc1N3?=
 =?utf-8?B?Ly8rQ0VjclllK1RGR0pQbkRSempJaGpuNUFwVGt4SlJsWStDb0NXV01TYlIv?=
 =?utf-8?B?ZTJPZHN3OUg0aVFBRUtqRmFsWk94S3RkRk9FSHo4OHVGSCtjZUJTTHpmdmtL?=
 =?utf-8?B?cHVpZEYzWUxxMWh3bHJ3SXhqQkkyNW9wa2JBaVlGYVZHbE9rckZyM29NcWYv?=
 =?utf-8?B?UVl6LytJMHIvOW1iNlVWMytRQURJNHlwaEJFeFdrMCtZU2JBRkhSK01HOStZ?=
 =?utf-8?B?K0ZuVCtKWldHT052a08wd2J0ZFhVTFRRSENpazhLaVVJbVNzcFFMTEhQSEtE?=
 =?utf-8?B?Z0cyRHNuWHRpcmlSdW1yTU0wYXJPRVJodVY3QW43WDBabGZDSE5HNElncHk5?=
 =?utf-8?B?dmJrZEt3OEd6cWhMTm1DNDg3Yk1CbUxtQVFtbGp2U2RHQ0QzdXNkTUxzeXpj?=
 =?utf-8?B?ckRic3NzWEJOR2dSTkdVUUU0ZzMrNWMrUWFwY1pXMGgyYkpMU0czWUhETmk3?=
 =?utf-8?B?VGxrcC9neDBwakgrdkdvY2pRd2VmNEovcitXcHFFbW5jb3Zadmo4T0FMalk5?=
 =?utf-8?B?QjMrQnVJYk16R3VDQXdYRVNvNkVzT1UzQVdDQmllaVp2T0lILzMva0ZlSXhm?=
 =?utf-8?B?NnNTMG5ZYXdXQ0pOdGtEdDViZ3BzRTRFampYODYrMUhRT2hHK0syT3hsbmQy?=
 =?utf-8?B?Z2pwUUQ2dmpwTXlaaE8rb2VSRTlTTzZTZ3R0dFFNcVBoeTB2ZWFYZUpxeG5H?=
 =?utf-8?B?WWJoUFFJN0s2NjlvVGoycVVFSkx1ZW9FN3d1TVlVWGFXdXFyRWNCempMYi9a?=
 =?utf-8?B?Q1dMQUQveU9WWkwxbkl5cWVXQ1BlRFFPRXFrcFlsa0JnLzB6SGc0NEZ4eDE5?=
 =?utf-8?B?S0xTME5YOXdSQThtN1ZXU2lOZjAvYlIxQmNXUWwwVHFUWnhtWjdpYmZBQjB0?=
 =?utf-8?B?T0NYQjRTblRJZ0tTYW1IZXVrS0pGTk5WWG8vWS81WnExcWlHU002UGdrTlRh?=
 =?utf-8?B?anJ0K1pOL01oN2lsMjVFN3dwOXhUc3ZnU0VDWSs4RDVldUNlajh3VHBUMGFJ?=
 =?utf-8?B?MnFGaTdUc1RzRDgzbFFMcDdOWDc4aUtJQUx1VFZ1L0JITmIyd0JDeXhrVjA3?=
 =?utf-8?Q?4+kuD/gLCOvnqtv8e4?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 5546f7f3-e9b1-4e4c-603f-08de67cbd130
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9235.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 11:10:22.0506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoqZudbEIfS+Rqk9EN7PdLxCYfP+ibWdq6DbYAhmSs08Acjzj25OE3Wb2U66PEbx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB10902
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
	TAGGED_FROM(0.00)[bounces-6519-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[solid-run.com,pengutronix.de,kernel.org,linaro.org,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peda@axentia.se,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[axentia.se:+];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,solid-run.com:email]
X-Rspamd-Queue-Id: 1D1FC10E85C
X-Rspamd-Action: no action

Hi!

2026-02-08 at 16:38, Josua Mayer wrote:
> Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling this
> option thorugh the kernel configuration without explicit "select" driver
> dependencies.
> 
> Select it by default when COMPILE_TEST is set for better coverage.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  drivers/mux/Kconfig | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> index c68132e38138..4f7c6bb86fc6 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -4,7 +4,14 @@
>  #
>  
>  config MULTIPLEXER
> -	tristate
> +	tristate "Generic Multiplexer Support"
> +	default m if COMPILE_TEST
> +	help
> +	  This framework is designed to abstract multiplexer handling for
> +	  devices via various GPIO-, MMIO/Regmap or specific multiplexer
> +	  controller chips.
> +
> +	  If unsure, say no.
>  
>  menu "Multiplexer drivers"
>  	depends on MULTIPLEXER
> 

I'm not comfortable with making MULTIPLEXER a visible symbol. It is meant to
be selected when needed (and there are a dozen or so instances). The kbuild
docs has this on the subject:

	"In general use select only for non-visible symbols (no prompts
	 anywhere) and for symbols with no dependencies."

Cheers,
Peter

