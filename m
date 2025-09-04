Return-Path: <linux-can+bounces-4469-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91B0B435F5
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 10:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A151759F2
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 08:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661642D239B;
	Thu,  4 Sep 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f+c1+BI4"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F4B2C375E;
	Thu,  4 Sep 2025 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975061; cv=fail; b=GF6uNAayTZ3kOZq6GsVw6vA0DZzE8DKukq22mEl5lHqG08HPqZIdBHTqhQtAvN68ujDIFsu6W0MVw/BBqjT/S5aaoBK8scv0V2vadb0FPT17NILe23XuMUfBP+cJltg/yHSsMYGD566DipwlmGGVUbsmelJu65kC9945Ircoh2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975061; c=relaxed/simple;
	bh=pF+jouIkeYmJSyZoQoUEnCe0G/+Ul+cB+2qVcjJz1E0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jAiI5MYIVCqbLpVLVXeRi8W/yjaptm2fTQR/sgWFX4fcSZO2hiW7780FZhm0/k12G5YBPwOnVNWM0DXLkJFllMKynpm27XSZX3nNGq3RS6lE7FpukzsiXucs/SOv/nlkh1t0DJ7BQRK9hxWKnHZFGbwFaimCycY1RP1I8/FqeBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f+c1+BI4; arc=fail smtp.client-ip=52.101.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvzyMA0fvMDLqD9eDdyzb2I8eVWy+lF0i8gIQeqNHitT8UNUwj92XW3lQRH0HjYa3lxXTZj+ZjCgereQ9+gH3pGFNgu3EBcLHOHZZ591ngnKjMHa9NnNm4BDos5JhtvYiR8oNlAfCD+lks5UXUxb0FIDLG78A0XrCowbM0IyQRX27G2iY5C8iUODT5ERvyy978Y7iUy0ngh/rBWO/ormicWh1rNMTNc82obNZe7bmfZXnXLYDdgPqxJvZxE09ed3k47s312jbZX9xgnoAYTXN+FVBP+FbI50ooN8pURfCWgz72CuUfx0AJce3MViQBBK6hkvEgez/bXrKZkKTAdZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZibS4RfxPoIxnYLjXkqSiyXVdTFMXMyid+4zJnt1hM=;
 b=L6BR0QOuX8vtLl9iq/4ZgJMNw04VI89g4EBsoq5i1zxhVAl4g+Tu7SQopv9Ci1ekufemqNHlcIhpXkclvPB9nD+Ht7N9/y+W37cUG7PsABo8sJugFwppzi2lV6URLas63lTl2iG4k4Z5V26+L6aP1BHUhHACZGH5nddmOCSJxCK+p4NgGWZw/Os+1aJXedFFESa5m1rheuMgWL+5Ar77iz8PrKvLEXc7480gPeMdqYJRnT1KOdoNPNjkt6EbbYgEmZd5uV4ZlyRgvvK9TufzxOlA9WXZ68X1zgzGIFr5rQmb9T8mSsWhrgteCpZhQlgBjHcT64+fR8t5tW/uaGUZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZibS4RfxPoIxnYLjXkqSiyXVdTFMXMyid+4zJnt1hM=;
 b=f+c1+BI4DiNxj23kIueMcTiudp1SQoPUBCLPrdE+OevGkyX89BOPS+zCATgiiinyJJAM+9RHMa1+3LtPhA8TXgXJr2QTsF1OVQN93NIE2zc0U3NO8OpBfK3PPPTu3j1+mms2zAjX638dAfILiT7tan3Xrn2nPAk2++Z+1S1w7SJtY9QZWoyLDprslzOT1bamqv8IyxG+3dtDRSxd/AEUYvwcBQba5xo7NgX6U0lIFotFU0CfI3R6IJz5s4epkEsu/cZoSTurIHQCimB5jdEvIoRZ7MOJWHp3zdPCDEy7Fiy28Neo/ztwLKQ7jbpAHCFcnWINlczCAz2iQbi9wB82PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6876.eurprd04.prod.outlook.com (2603:10a6:10:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 08:37:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 08:37:35 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 04 Sep 2025 16:36:48 +0800
Subject: [PATCH v5 5/9] phy: phy-can-transceiver: Propagate return value of
 gpiod_set_value_cansleep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-can-v5-5-23d8129b5e5d@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756975018; l=1793;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=pF+jouIkeYmJSyZoQoUEnCe0G/+Ul+cB+2qVcjJz1E0=;
 b=TFEJNStnyv/u7ot1mpOZu8gL4QFXJwtR+iu8YdCrBzLud8THeYRDkv5zICNoiCk4h5LVSIwz8
 ziQSrOP2zlbBRZ3jLUqayk4HdlG/Gzny/b7tCnS+5xfC++2+2NmPcBJ
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
X-MS-Office365-Filtering-Correlation-Id: 2941bcdd-8f78-4c7e-f0e3-08ddeb8e4c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWJscW93UDZDTnlmWWZyUlQ4emEyaTdRSnRpb0NoZCtrUHRFRHIrTGNTMHNI?=
 =?utf-8?B?MGRKYUh2THJUMjRrM290NW1pd0JiZjhMcVpLbVBTNGF3cVVBSCs5ZDNEU2cx?=
 =?utf-8?B?U1g2b0xobFlDYzF4LzFIaWE4OWpFY2lvMGY1UTRYZzYvdWc2NVhaWVd2SXhs?=
 =?utf-8?B?bWJYR3lINndRV2NFN3ZQK2tpbEF3NmI2bWVzOFVIT2JDVzNaREFhcWFWRWpD?=
 =?utf-8?B?T3hrbEt4ZFVvSkxxT0VLWXBMY1RMdS8vMDRKMUJndWNudGJMSUQyQ1dTRnVL?=
 =?utf-8?B?K05tem1ackhnNHAweks5YkZLSC9aa1RXQTgrTkh0OU5IMStlNmZEV2xxVVJI?=
 =?utf-8?B?MGZVT2dRb0JNWGtFZmRscFBiMzVyVUVER0VoeWpsanJXcEwzcnFFU3ZKa3lt?=
 =?utf-8?B?anN0b3E0VERTM2ovZm0xRXkrODd1dEVEbEdjUWhUcnBRNkMwc3I3VEdZejhr?=
 =?utf-8?B?VjBkL1crWXBrMlZGUVlaRkxpNmptR25TMnB6UXJudTVHQ2tzbVFUUmxQcnFn?=
 =?utf-8?B?d0x3RVVDOHFQVkUyUjNUMTdnWlNyejYxRzZIZnB3bldkZlViQWkxZm9jbjlo?=
 =?utf-8?B?djBhRndPWkhpYmh0Y2M2dW55QUZxSk5CbGJScnZSRmRSSW5rUUdIbVYxbVlL?=
 =?utf-8?B?ckFuYUh6TEtDOUlRNzZmMzdmTTRjTmRhSnhUSjlxQkFnNTh0ZEhwT01HRndT?=
 =?utf-8?B?cXN4NGlucGhqWnUxaENrSUhoV09pRzFlamFzczdLZ1hETXlNY2RrNlgwT1ZF?=
 =?utf-8?B?ZHhUTnZWRjBWQ09aWE1iYlhod2pBL3ZiT1VtQVFHTXFPSllFS3Q3UVZyS1Ft?=
 =?utf-8?B?YU9sdWFpRXdJWW9Zc0k0WDkxQ0pPZWxscDR5UnJkTzYrZ0svV2g5ZEhEbzdk?=
 =?utf-8?B?dHBsRUpaUTM5eHlPYitoS0dnYXBpYmdFQ3l6RCtCRldMOVg2S2RJT0RRMzFa?=
 =?utf-8?B?N2tIQWJRK2FCcE0zM2wyYXlLZHEzUXFxMi8xZkg0OGdrNXRKS0dJdjlaMXhy?=
 =?utf-8?B?aXJRdDdGS01tcllHRmJ1UHp0cG1xZVh4QXR5NjJ2VW5oVk1aOG5aSkFEdDFZ?=
 =?utf-8?B?b1p2OWRiZFgxTmdsYWhGelQwM1RibDhsNmpDRitQbkF4NFI3aVhPZnFBRmxY?=
 =?utf-8?B?dWVLdHRVbzFSUjk2YS9jSE02dVBkNDRNeklnNE93dTZvOUkyUnRvREloa3o5?=
 =?utf-8?B?ZFpOTDUyQm5nYS92WHpuZ2t6QWdRYjdrVkw2OHRGc1dTMnFWck0wS2IvT3E1?=
 =?utf-8?B?NUxuOWxpWG9JZVZPSnVGdTU0Z1NoMjlxK2hvK0lIRmZXS2lNK25Fd01KTnJY?=
 =?utf-8?B?QTVxenBSTVUwenpCWnVEV3MwZmlqMW1IeHRzdkhkTS9YODNXSkNtak5zU3Rx?=
 =?utf-8?B?cDMzWXIzcUlxZ3V4N3pJT29XcmJjU1NFU3A2Q2FGSHpMYWRXcmJZak9RZ2Nt?=
 =?utf-8?B?MjRiNHdWZnFjM1JaL0phZUN1aEgzdWw1K0RObkpaUEhTVk9XZk1yYmI0clNq?=
 =?utf-8?B?VHB1a2ozbzdWakNldUh1VEdUKzRmNGxlZjVvUHg5Uzl4R0RTM1Jndnd5NWVK?=
 =?utf-8?B?dmlOWGdsOVBXVUlzV0lSWE1aV3dlWlo2c1dPZ3hYL0RDNGxVTG1HODZvM1ZD?=
 =?utf-8?B?YTdQZGJRWjFUUTM0ck9UNEVtSEZMaWhNdmw3ZkJPQXYxVHBDQTJmb1l4U2Ey?=
 =?utf-8?B?RzlzcUw2QW5qZmRHS3pRTWZyell1WlpaczdmQkxjSWtEZXFMSkhWbTRWRnpv?=
 =?utf-8?B?dFNDUzd5UlU2OWpYOTk3bzk5V0RzMzIrU1JxU3J5a29IdW5US3c5QVRRWmUw?=
 =?utf-8?B?YUF1bk1tRkRpVys4TjdabFl4Zy9IUHc0UGc4b1BXSnBUV2NBT1pMYjRJSTZM?=
 =?utf-8?B?Y3JQUWxrR3pjcUhEaGxEcVoyNGxUL2FiMFU5TjUxMjRCU2JMSGlqWmZwOHhu?=
 =?utf-8?B?dHN3RHNtNDY2T1NkVTU4bFZSc1MweE41eFhYOS9LSC9xMzJ6WmwzZ3UyamJ2?=
 =?utf-8?Q?GCl7jXxcrMK85af6UWiBUr1ycGiUKM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0lWQThBeVpHMHhuZ1JkaGw2b1dxcVhub2RCVFlvak9MdnhzbG1uMmpHMEtE?=
 =?utf-8?B?Rm9VUHJOZ1pGOUdLODBwR3RCdkV4RHhzakJZSzVwVjJyaFFHMm1qWC9EeWxO?=
 =?utf-8?B?QjZjd2pCVk4wZkNhekthUHdpcEVObjhZQmwzS0xrNElxMG5TTU5PUC93ZkFS?=
 =?utf-8?B?bUpNS09lS084cnFqV0RXSmVmc0tnUklHT1ZLNnd4cGlzM0ZxOGh4M3Ixa0E4?=
 =?utf-8?B?VFlPdWpDWURzVUxVL3oreUZpRTNQSW01cENRQTA1ZjIxc0p2b0p0b1dmajFU?=
 =?utf-8?B?K0hLakhndEhWRldwMmZ5QUlYQitiYS96T2ZaMHdyTk50VXhGVFZocElzRDZ1?=
 =?utf-8?B?M1hmdmh4aEdyWWNsbVJkSUFVRlVxMzkxSzR5N2VUdGJNdzkwcEFXN2NLOGRU?=
 =?utf-8?B?bk9odGJqNXVNTzY3amNjbkd3WHlvamwwT2R1U1ZUd1dXWnQzWWNtNjFNRUh0?=
 =?utf-8?B?eXV3WDJVclVjMWlaTnJUTWlLZjJZb2dnRVJmLytRSzI3NlM5WFdLeXc5UVdr?=
 =?utf-8?B?bUdvN3IvK3liby9oZmpJend4UjNtNjQyYXlUdnA3U244a0J1QkhlM0l6YjJR?=
 =?utf-8?B?RnY2VTFIOXFGaDhmQXRlUGtPbDBtMnFLT3ovSld1QmlwczczQmd1WTI1T2FY?=
 =?utf-8?B?ZjlmeGhNZWJPdmtkOFl4Z3VVRmxKQStobUxmeVliQWp5ZlM0WVFkZFVUZGNz?=
 =?utf-8?B?UkVoa3RuM0ZuQzN0ZjJuNkY3T0hwc2d4SVhaNUFrdnJyQ0VSNXZkNVQ1ZHZo?=
 =?utf-8?B?NERsbjdqMnYyd1FoRHVsdmVaRXdJZzZNSWMwbjYwYUNwUy9kRXJLMjJQQTlx?=
 =?utf-8?B?OE82LzlaQXRtdDI1dEdnUFBvVXpkOGdYcndxdWRJU3FmazhJd0l0b2h0RWd3?=
 =?utf-8?B?YlE2N1lwUkJscy9oekZqWktSZFRZLzB0Q2h0VTd1bEwwbjlWazJkdVRaelVG?=
 =?utf-8?B?MFNDdFdCLy9BWTNyRDc2MUJRb0xaeXBVcTRJeStpckRXeGM1QlNmZEFLV1N2?=
 =?utf-8?B?bGp0M2E3RGlkYzFuMTFwdC94SU5kbkdXdnkzcVdUbTEyVjNERFg2NVgydE9o?=
 =?utf-8?B?VWttbnM5YmdxRGF1YW51V2tnVnJjZzZCT2owR2xPSkttNkE0L2I0MWphSGU4?=
 =?utf-8?B?Z0dWSURTNFZSeTdqZy9sdW5EY3l6b2hjSWROZW5uWGYxSFRKcUM5Uld1YTZl?=
 =?utf-8?B?VDVLUUxrK09NdW5KWGlQQ1VtN25XM3Q1eSs0RFdyb2k4WHF6R1BrR05EWWE0?=
 =?utf-8?B?ZG9iMUliR0xoL243TEthNDNSY3cySitGS1dxbWwrSjRseGdsKzlGMXVNM1hO?=
 =?utf-8?B?Y0twenMzUFhWZDBQSzdTRnErN3JkaEYvV1ZueE9IRFUxRUpia2h6eHhXRFI4?=
 =?utf-8?B?MGhBamNMcEI5K3EwcHpDK3h5Ky8vVHljbUU5TXN3ZmY4S2dBMTlCa0hncFFF?=
 =?utf-8?B?bVRWTDNZZUZvZkg4VjZRYk1jaXAyYmZkVDFIMUwwYkFHZVhyRFYvazkxMDRY?=
 =?utf-8?B?VmN2T0hBMTU1ZXRHV09FdFROTnBqQUF1TTFlbmdObkpKVHJ6UEYrYko5NDVz?=
 =?utf-8?B?NGh2dXU2NlJLRGZZbjloVm5lcGVvakJMTXNXdldiSDI2enJyenpGeFBEYXZB?=
 =?utf-8?B?b2FabnFOdEVFS1RoNGR3aUVQL2g1ektsSXVJcjY4aVpVVDFoamtScDdWRHhL?=
 =?utf-8?B?TUo0UXJRUk9hSmtFN1Z0bjNISWc5NHFtU1pyZDV4UFNGZlRDSlVuenB2TFN0?=
 =?utf-8?B?M051Rzc1UUZjaWlkdFlheDhMQWZBZklBRVVvOEFrdkdiYzY5a1VMa2tlUjYv?=
 =?utf-8?B?elFnZWJiWXhCT0lMR2lqOGZVQm1QWjNIZ1BGcVk2eTVHZnIyU3Mza3dQNGYx?=
 =?utf-8?B?ZCtxZUdkdFBlaUZWKzg2My9uQVlSZFJwbzlBODVnUnVxQVRyNWZFaUQzbnJ5?=
 =?utf-8?B?eHl5MTJiVHVaR21ZWWV4SUdaTGJGMnBINmRSeGZVSWpaTmo0ZXB6REpKbk4w?=
 =?utf-8?B?R292VGVmSGJhZURoaUhFTXpiSTQ0YXIvYW9TcTRKUloxWlpPWldNcGFhMEFI?=
 =?utf-8?B?bS9SUW1TOXdKbFAzMEk5VkhXNC9HQUFmdFREREExWm1DQlhNKy8vcE1RMjEr?=
 =?utf-8?Q?w+LtIsWfTEEFgrcbFzHM9f1vL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2941bcdd-8f78-4c7e-f0e3-08ddeb8e4c5f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:37:35.7216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3yVF4cG5dke7/vcXXZI00WwVxns0E7XpolB8tebfQvNSJ6rkp6+vOMCTKdkmy7//zEkvGkhiOhIDkzpxbysOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6876

gpiod_set_value_cansleep might return failure, propagate the return value
of gpiod_set_value_cansleep to parent.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index b7d75a78d9242e2003660a87d2d4c9f784aea523..ccb29e1dfe0d07005b4bcd8fefa2787292d921a0 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -46,23 +46,32 @@ static int can_transceiver_phy_power_on(struct phy *phy)
 			return ret;
 		}
 	}
-	gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
-	gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 1);
 
-	return 0;
+	ret = gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
+	if (ret)
+		return ret;
+
+	return gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 1);
 }
 
 /* Power off function */
 static int can_transceiver_phy_power_off(struct phy *phy)
 {
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
+	int ret;
+
+	ret = gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
+	if (ret)
+		return ret;
+
+	ret = gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
+	if (ret)
+		return ret;
 
-	gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
-	gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
 	if (can_transceiver_phy->priv->mux_state)
-		mux_state_deselect(can_transceiver_phy->priv->mux_state);
+		ret = mux_state_deselect(can_transceiver_phy->priv->mux_state);
 
-	return 0;
+	return ret;
 }
 
 static const struct phy_ops can_transceiver_phy_ops = {

-- 
2.37.1


