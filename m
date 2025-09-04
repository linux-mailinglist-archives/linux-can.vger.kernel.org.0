Return-Path: <linux-can+bounces-4466-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ED2B435EC
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 10:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45FC217999A
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 08:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFA02D0C64;
	Thu,  4 Sep 2025 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X0ZFeO8m"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010046.outbound.protection.outlook.com [52.101.84.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200C82C11D9;
	Thu,  4 Sep 2025 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975043; cv=fail; b=ajQ19Zpw0uQE9KWqpY4vHfHuxVcALqp9aw84CRJxn79jU73Dg+6582uMbhvCXoN8SOag+bSCidjW+gUTw22jvENYzTxiTGcQbh+RL4T8KtwAtGqlBFtgf9XEV29Nv5OmKAPgKs9twt2mrKabCQWXRqegqgxO5u+PCnEhQH7w4wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975043; c=relaxed/simple;
	bh=942hzJl0q8NnbYFuqm/+EMPlh6Z3gBMDJ+MMZD0VO9s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tln7Q/ZPIebzqrJ3ntPuUzNk4GP/Z0oYE5s3+zueQqxeqkiwAQpE7j+ZRseNZ8u3ugDm6j/zOlS2k1ergFC3YUCukNoRvuKNXQxVxkJ0+vTs892zLMGRn0pySXd2ltZHeqZ82wpqMGe7Zrjtg7FA75II1T17XZcsh37oOkmNCkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X0ZFeO8m; arc=fail smtp.client-ip=52.101.84.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWPCzC4VhUfzhvQ5tj/Ec+CyKu0oMpJ1G8VI4+XzAEz8/V/1cZpRuZxsf03MU/MigQ1rgyieZlXj3rNwawkKm/bOb8T8ZcXPkcbb71592d+98oyDR+JlSVVJWcKznR1nP1qCm1f+jRCY3E/ICdqef88hXtRJjV5nKKRN25DorXUfumnmvlvtXs6ayNIGoVTmim/2f2txpcgqdQMhjKzCeR0P2AoGzkGTrOD+H9MtlavLgZHO4yW/b8GO8HUGmBpum/Qj5f11TRAlGNQFu1Olbs8yWgh84CqyC9mtzw/VM3IdLhbirNyqpeK9X2S3I0Zoeqn4xFaE+GkNKaUxUZcZKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3wv+9uvpjGlvjrlztM6YPk3snEJiLqjXRAhl8sXTl0=;
 b=P2hmceaozVxvkoz++S7aLkAlky8D7J0jMix6U/NHPgq5xTKPXM6DUFCDB2YgUoQx7bj8BVHEWmTfdsCHu4lLE6ZrjcgPCUTJcZ9kNJhsX0Vp/x/DzcvBXTFmSZ13z16gCVFSatyO42hT7XGZici50vHtcJxm2ZhCwgCT9DGM+qsd7i7bLBJWOzKof96zrFvuEWBd3dS8i1DebYs9V0UOcGxj5UrPHTyr9Xdiqqh9zsPgu4Kgg+nmva/kTwjjv0za7qLWgAbV2rngeWb32IMmQjkxh14+Uv1bqHBKtaKlnI74PDbUP7jDSlwxXfWF8iApYwW2uo5RwOjheLLVufqMCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3wv+9uvpjGlvjrlztM6YPk3snEJiLqjXRAhl8sXTl0=;
 b=X0ZFeO8mcnn+zWhEv13yYP9PPQUSttsY2lyCKQO0d1NhClrfspaFeP0FJ+iLw4aB0ARXbZcAN/zRRp9UAWDaicdC5XXeIo0TAo1IPymoSXY6fqbu4/PPlmsMfrI3IuyNWgAHnLRn25J1XeRJlMB/ovuT06LCrHcJSb7cGuODoVdpagBUnFc7tIdOZjv6Q4zxmhuKXKZMKZyCTjB06TRgz/5o64jaRLd9jwSrWyRPyrJRiSklAEdMhL5jD8ysCZSC9oY7LLQpHu3F17f2LL9wzBB4wNmw0Big/DsKNYXxvys+yCU821s01Xo2lD+Prm9D2zDlhfmIyUJ1ScAjuCAcTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6876.eurprd04.prod.outlook.com (2603:10a6:10:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 08:37:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 08:37:18 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 04 Sep 2025 16:36:45 +0800
Subject: [PATCH v5 2/9] phy: phy-can-transceiver: Introduce
 can_transceiver_priv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-can-v5-2-23d8129b5e5d@nxp.com>
References: <20250904-can-v5-0-23d8129b5e5d@nxp.com>
In-Reply-To: <20250904-can-v5-0-23d8129b5e5d@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756975018; l=4492;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=942hzJl0q8NnbYFuqm/+EMPlh6Z3gBMDJ+MMZD0VO9s=;
 b=gXJ9qsLGQbrgmJXWcwhRCeuZwIqTA70Xt+Mq5lfL3bji7FdJ9C6w2Wu4TPhJeOBMszyUGMvmZ
 aMy4U083/e9CsknEJdjqeKaxerodaCtteOfqxlebv37l79zj+lWHoDM
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b540f28-dd73-4259-f0e3-08ddeb8e41da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDVtMmxNMU1yczlrY0tjR3BIcEJUN1RZZXQ0OE45MzkrZUptbFBGbDg5WnBR?=
 =?utf-8?B?eVo3L21kMkEreXo0WXY4S2MzM3prNWpyUStxWkpMWXFsSUd5V2MwbEM0WHY3?=
 =?utf-8?B?aWt3RE1SYjlsMmJBZzl3SmJuc0RpMG9NVi9UOEh2cHhmYUlVVHBpZ2svRWpU?=
 =?utf-8?B?M2czSHNTSUhoM2VieTZZaFBGUFhLb2FWRFdFa0RiOWxraHF3L2UyYjByUlAx?=
 =?utf-8?B?V0lLMjdDdUt1QXdCdDh5dlMzWUszajhvSWROUHRwSForbzNRa3JXQkhuTnJ4?=
 =?utf-8?B?em1IY2pxZmZGYzBaYTNHcFZwYWY1cldaMjJvUmk0V0YzWWVFUjF3Q3dERUxV?=
 =?utf-8?B?VDZWQTBaZTdyc2xWT0JyVk9pR24xd2VyUkdpZmhjL0c0VzViU09GZ0N5Nml6?=
 =?utf-8?B?dU5qanJZVThwUVdEZnl0QzloT2QybFJuRUx3NUd1OW55N3MxT0UrZmRhK0I5?=
 =?utf-8?B?OXdHL0Zwcjl0U3NzUjdNREZFcmJ4enNoR2ZaVHdHUEVjSUxXajl4bkUxNFZE?=
 =?utf-8?B?M2lBS1ZUbkl3UlhZbmxacUE5Z3JaZU9iK3l2R1FoSlRxYlRka1U0Y1VETW1i?=
 =?utf-8?B?VUgxa0lXTy9RTElOOGlkUTNtODA3MEo2aHg1eWw3T0dxS1I1VVR1UFhoV0hM?=
 =?utf-8?B?VERiMWdGL0NmZkZTM0FQaG9ncUlmNTRJdFZITEZWanlyNUhSMkpHUjRxRytJ?=
 =?utf-8?B?aUFCeDgvRFlYUGI1S1FOYW9rQS9LZVhHbnpqUmxRZ3FkbEVodjFDNkhMK21J?=
 =?utf-8?B?RC9SV0JwUHhDZ3lFUU9VVUxGWVFIVnVPeklham8rODZUR2dwSlZXNExHUmlh?=
 =?utf-8?B?UVk0Y2poWHJtWHpHMWk1KzZPMWNNdGdsbHk5MnY2aTNCeFhLcU90V2FacHRj?=
 =?utf-8?B?cHRIOWFTeW9JRGI3ZUNHdG1GL0NOWVFhbFhKa0MvZzhWaXplL1padXBUWlZh?=
 =?utf-8?B?UU1lZElFRkVPUE4yRVBXY3lqSkdFTWpxRWNFY3RBUjVmZGozRCs1b2k3K3Bo?=
 =?utf-8?B?QldqbS90UDFGL0xTRXBPMDNHWDFTNkxnSm1kNUVFQVM3cWtCb2RFcnd4Snpp?=
 =?utf-8?B?MHdia1kyNS8wQUFydWhXYnQ1ZE9LcVNya21LR3U4ZGUxdzFBeHdpTVNXZ291?=
 =?utf-8?B?RXJYd0ZzTk5CUExBVVRzeXFPdkl4VmV1MFZUMEFTOHBVUjJOaFN1UnVSQ0xl?=
 =?utf-8?B?cVFWclBpc0VCc0trMzdaYllhZkpzanZIMWlYYndqTk41cmJQaUtpNUM5UUdN?=
 =?utf-8?B?VnBGL0VNOE50MWVZRS96QVVmV3BiM21Jb0pmREVqVjVBK3NjNzd5L292dStV?=
 =?utf-8?B?UG0xcVU1TVUxTDdNTkxCeG5kaHIxV3VxU1lXTnFEYVBGakN6SG0wMXJjcVNj?=
 =?utf-8?B?cmVBdjM0K1dkNmdFemJhOGZ1WlJnUzlnTjFBeG93WWV2Wlc4MnhkcXVBdG5p?=
 =?utf-8?B?RkNDMUt4SjI1cFB4QVNQdWpUSmRjL3ZYVDgzeXJNUTVxWFNlSXYyMnJEMXkw?=
 =?utf-8?B?R0FOTXNJdnpkN2tPMVgxdy9PSmJXQlhWZzhQOFdUN1o2T052V1JZYS9XZGYx?=
 =?utf-8?B?dDVOd3A4a1l2U0l2ZlV2Zm1XenFDMHpQNUx2dTBnZEptaDRRVlNMNkZQWWJv?=
 =?utf-8?B?SjJOSkE0eWgwc2hEVmZYSlRSTUtEclFod3JrQ1dXK1lXQmhhdGMrb0dqMmVN?=
 =?utf-8?B?clFkRWt4c2ttNFZjK2JmWVNIa211TzgxWjE3UnE2cGkrbFptNitSK29rZktu?=
 =?utf-8?B?bUdYTEl0OHdHSFJTQXI0ci9iWlo3YmU3UXVzTHVnZUpQbkIvNkFYbFUvczY5?=
 =?utf-8?B?bHJBYUFyYWplTjZLUVVjblhvbzdGQ2lRdlMvQ2d0am01SVpNYUNSZXdYMnlD?=
 =?utf-8?B?VFc1bG9IOGRvWGpNRVQ2emQ5eXprajJKQ1BrNUd2bHBaWEZyUVBZN1EyWENW?=
 =?utf-8?B?clBSZjhYU0xtUmlnSEVycWpXU3JqNGhPWW5vN1F5VTVPZTBnUExpYTJwNG5M?=
 =?utf-8?Q?8QT6/M98IheBmKQ0AkobXg5zxAcIQA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0J1ZVNyMmZKSGFRR0sxbDZSNm0vTzZBQjhYeGpCRTlxMXBiZWZ4NVNmRzM4?=
 =?utf-8?B?R2h0cSt0ZGUwNnRBWWFZdlRYbFFUbVdXbzBwaysybTMwWHdIZVlJMlF2V2Rw?=
 =?utf-8?B?M3ZEWHJhNlJoUCs3TzVHcURVS254VWkwc0FpSFhDM1V0Q1Z2UDJ6MGZaWWl4?=
 =?utf-8?B?RGZzRzlGWk04UmVmUzIwL0M4QTQwNzZabjBBZU1yUForWmo5Y3NrNkdPbEVE?=
 =?utf-8?B?bnoyaDNTRCtxdU1keFByWHpWU1ZBYjV1ZUdIVFFhWTlHNVQyTllOR2FOdUtS?=
 =?utf-8?B?dzZUM3RkSEtJVnJHYStodlVtcU1TOTd5MFRjZFMvbHBmQW5uVXg5YmthRkMz?=
 =?utf-8?B?QUhDaFpFVDE1QzJlUzVORmtkK21NRE9xaVVsZjJmNzY5RDZoalF5a2ZDYXI5?=
 =?utf-8?B?ZURHbzlEakhtcXY4NXBxVUNBdEV1OWhmV1pGOTh4WnN3b0NZWlE3bTQyRk1F?=
 =?utf-8?B?aUJYTkl0a0UzKzZKUDd0LzVaUW1STUhTdHhPWFZPTzMyNEY3anFwbHAwSUY5?=
 =?utf-8?B?S296bTVMRlE2NDNaeXphckc0K2srRkNNVmkyVVBNRzJGYkZ6cjMrV3BtdHZv?=
 =?utf-8?B?NmFQUkltZUQ2VFRNOGFsTkxtakpoekdqSmpBc3VZTHdaSzhBSitBdFR2Q2Yr?=
 =?utf-8?B?TmVDTXhGL3k3YWZXMnNQU2JOc0I3Wmtzc1ZJeFVYOFNzV0FmRnFCVndDSzVz?=
 =?utf-8?B?a05qUFZZdSt6ZHRLMmxlaU85RGJaZ3BPTzB0TW1DT2d1Qm9hTjZwa05DamlX?=
 =?utf-8?B?VHQwdWluY1doK3YvUTllK2dxRlRJSWh2NHZzVWo0VitPeGZza3hnRGtWQXVa?=
 =?utf-8?B?OWdpOEhTU1djNytYZ2hNODRJa3c0WUVZOWpyTlhoVDBpQSttalFrd1JHZVFJ?=
 =?utf-8?B?UE1UcUk0c09aZHB3R1lMN0liQkdLbXc1eFV3QU5qZUs3cXhjci9pRnVKZkNQ?=
 =?utf-8?B?b1RTY08xalpVNHU0dFNieXJTakRpemJvcXMxd1Y3Wi9rZW5BRFRpdHljelZY?=
 =?utf-8?B?eFdISmhTNlFFaE13a0Z5VEsraEkrd3F4YXkyK0E1am9xTTBGYmx5ZURBSTEv?=
 =?utf-8?B?MGJIbmEwOWJ5czU5eEJjRjJ4VFN5Wlhtc2M1d3k0dUtmbTJwem10bkV0Wms1?=
 =?utf-8?B?d2VsWTR2QXVWMTQxTm03azNCMXgvaXFjRHpmZG5FRXgwdGg3YVRPRS83Q2Zn?=
 =?utf-8?B?bjhQY045M2xTOTNyWGh2RFM4WlRkWTh6T0NZTFhRODB0a3FwcGFnUzdPUTdZ?=
 =?utf-8?B?dVVrbDdDbFl6d2xpVmVNWDV5b2lLaWhySUNvdTdrZnVUSVR0VWxtL1hsamhr?=
 =?utf-8?B?Rk1rcC9CMlc0aUdQNTJZdFJDcGYwRGhUMDVsQmh3Y2tydE9NaDZXVXlpakhK?=
 =?utf-8?B?QVYyUVBKSG9nbno0bWtBNnpqNldNcWs1SC9IRFNITnhCREJJVFlEZ2R3OG1X?=
 =?utf-8?B?TURJUWVmT00wczFtUFpUZ3BudXhQT3k2NmIrY3hqT3VvWTJEQWdyWTN6dHIw?=
 =?utf-8?B?ODRwOHFaM2dBck1laWRaVFpocmVBNHhFczRLVElId1VXVmFPMHV5T1dWOVBs?=
 =?utf-8?B?RUxNaGc2Q2FIOFNxY0xrOHVmWjZNOXpNNDR0bEZTSlNlZzY1d05MeUZlVUl3?=
 =?utf-8?B?QWkzcGNTUG1ONXE2WGlUTE9UTDcvZ2lLMEp5bUpqQk40dkRKZWdwNnhZUnFP?=
 =?utf-8?B?dm9obmxqWmhRSVdPUVVlK00vTVBObDdYSDhuQjBxdkx4d3RoV3B3SXBVLzVD?=
 =?utf-8?B?ZnNVY2xXVUhXMWlyZ0M2NThvYlRJU1JHaldXMUFhU2hMdUFxVUQwVjM3OGND?=
 =?utf-8?B?eWgyRmNIdGxRSEVyV0JiN3NoKzFtbWVCVEp2eFZOZ3pXWGhCdmxPQlVpNHU4?=
 =?utf-8?B?WWY2Rm5jUnkvajBGYzF1SHFKdDZNc1dwVm5kSlA4cHpGTTBEVHBkK2tQdEFW?=
 =?utf-8?B?NjQvM21CUk9qME9sNkpZSHNQdTZxYVRnMHc4b3lmVWpqRUJGVmg5TTBuMkg5?=
 =?utf-8?B?UzdpU2htTklsSTFQYjQ4ZTlPc3VzbzdxZEVDK0MyaVY1dHRkRDZqQjRKd0dj?=
 =?utf-8?B?WERLcnE0VUludm9sd1NBMTlGcDdBZ2tIZnpNSlBxcHNZbUJmWlMvRDRTWXVZ?=
 =?utf-8?Q?1ZydiK/nY08eV7p1T26iE/Gc/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b540f28-dd73-4259-f0e3-08ddeb8e41da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:37:18.0718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMFpNt95GGEyMSHbRrU/3Uv4gZvNPaU7nxLeGdJ1GcLwFc1NfqrXKdr15tgrNJL2Ukf1pK/NMaSkD3vYTeKHLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6876

To prepare for dual-channel phy support, introduce can_transceiver_priv as
a higher level encapsulation for phy and mux_state.

No functional changes.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 41 ++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index f59caff4b3d4c267feca4220bf1547b6fad08f95..6415c6af0e8414a6cc8d15958a17ee749a3f28e9 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -23,6 +23,11 @@ struct can_transceiver_phy {
 	struct phy *generic_phy;
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
+	struct can_transceiver_priv *priv;
+};
+
+struct can_transceiver_priv {
+	struct can_transceiver_phy *can_transceiver_phy;
 	struct mux_state *mux_state;
 };
 
@@ -32,8 +37,8 @@ static int can_transceiver_phy_power_on(struct phy *phy)
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
 	int ret;
 
-	if (can_transceiver_phy->mux_state) {
-		ret = mux_state_select(can_transceiver_phy->mux_state);
+	if (can_transceiver_phy->priv->mux_state) {
+		ret = mux_state_select(can_transceiver_phy->priv->mux_state);
 		if (ret) {
 			dev_err(&phy->dev, "Failed to select CAN mux: %d\n", ret);
 			return ret;
@@ -56,8 +61,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
 		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
 	if (can_transceiver_phy->enable_gpio)
 		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
-	if (can_transceiver_phy->mux_state)
-		mux_state_deselect(can_transceiver_phy->mux_state);
+	if (can_transceiver_phy->priv->mux_state)
+		mux_state_deselect(can_transceiver_phy->priv->mux_state);
 
 	return 0;
 }
@@ -107,7 +112,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
-	struct can_transceiver_phy *can_transceiver_phy;
+	struct can_transceiver_priv *priv;
 	const struct can_transceiver_data *drvdata;
 	const struct of_device_id *match;
 	struct phy *phy;
@@ -117,18 +122,25 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	u32 max_bitrate = 0;
 	int err;
 
-	can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy), GFP_KERNEL);
-	if (!can_transceiver_phy)
-		return -ENOMEM;
-
 	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
 	drvdata = match->data;
 
+	priv = devm_kzalloc(dev, sizeof(struct can_transceiver_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy),
+						 GFP_KERNEL);
+	if (!priv->can_transceiver_phy)
+		return -ENOMEM;
+
 	mux_state = devm_mux_state_get_optional(dev, NULL);
 	if (IS_ERR(mux_state))
 		return PTR_ERR(mux_state);
 
-	can_transceiver_phy->mux_state = mux_state;
+	priv->mux_state = mux_state;
 
 	phy = devm_phy_create(dev, dev->of_node,
 			      &can_transceiver_phy_ops);
@@ -142,23 +154,24 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
 	phy->attrs.max_link_rate = max_bitrate;
 
-	can_transceiver_phy->generic_phy = phy;
+	priv->can_transceiver_phy->generic_phy = phy;
+	priv->can_transceiver_phy->priv = priv;
 
 	if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
 		standby_gpio = devm_gpiod_get_optional(dev, "standby", GPIOD_OUT_HIGH);
 		if (IS_ERR(standby_gpio))
 			return PTR_ERR(standby_gpio);
-		can_transceiver_phy->standby_gpio = standby_gpio;
+		priv->can_transceiver_phy->standby_gpio = standby_gpio;
 	}
 
 	if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
 		enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
 		if (IS_ERR(enable_gpio))
 			return PTR_ERR(enable_gpio);
-		can_transceiver_phy->enable_gpio = enable_gpio;
+		priv->can_transceiver_phy->enable_gpio = enable_gpio;
 	}
 
-	phy_set_drvdata(can_transceiver_phy->generic_phy, can_transceiver_phy);
+	phy_set_drvdata(priv->can_transceiver_phy->generic_phy, priv->can_transceiver_phy);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 

-- 
2.37.1


