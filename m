Return-Path: <linux-can+bounces-4295-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CF7B30D4F
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 06:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D7B1C27F20
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 04:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6AA296BC3;
	Fri, 22 Aug 2025 04:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R3rj/TGZ"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B87B27F736;
	Fri, 22 Aug 2025 04:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835583; cv=fail; b=Vun0B1k+TWI+ZaGVKi6U77+kAvXffPRSx+/CQXbZJhp4M+rNjY4vxAZ9kaotSDcSSHQfvaFKUl/4adNIJOV0gJyb09lQxwAmC/2nuq1QZw9LbMvxJyF3cSdtNrAf07/lxSZxJu5nuF54SBMpO9rzdgD4UWH9jp3466uU4Ovn6s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835583; c=relaxed/simple;
	bh=k5Hs+Amecj6+QGD6PsQ/3cP5ltSqAIzRxVwJy7xq3no=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=M+GC3yZbe7U+Y9qCDsVFZSXP9YVCLGlQXpfrdLNFtK8rHududVVfgpu24t/FeeRaBdg6S3PdPjFlFb1zhdGfrvPhkHJVGmR35db/VV3e6QlcbCdpxNm/fBjQuPXPm1MpNoCbAgbZO+M+p1AFVs7FDmlPOM2d0cV7rBa/SBjBYs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R3rj/TGZ; arc=fail smtp.client-ip=40.107.162.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGkql8NW6/blIP+Gwi5gBJ2M2B0CpneG4M/uz9H01W9wWER3jidnFcrzB0pcMRn/5qGV6YE4nVw3wpEtsGMtmUVDHEaQ2zElLbDS2hhJjz3A1Qqi3MEC+NeqpYsIxRYh+g7R/SQu5h3w1Af+KI44ORUjAHAfZwMEuOzcvxlHZwhF801CYPenBAen2wIdXZMS3fd+56ZXGxxFD6BPYHXw2UZFyNAn4N8OZ7VYnrcC4cwvzmbg5VlvnLqFP6o9gUbbeENIpGh6SWVkHZvzvihGnc0HIzO4vNe3ZBl89Wygbg3YAmbeJGdf6eiAow+XngLUTukaOB8QTKa3dY0Ni+KawQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5cN7gkvweniinjHN5anjHUpjznyl5Q+q3xrkvpQDW8=;
 b=sCHGTc0ExnxDwMjcKrQNswWSY7pNBE7C+lxWfm7VIZLlGVI0U7KIln4XG9lnyIQt+b8IvnCkwpddtE+MyvBCeDdklIs8Pheg7j+peFFHRr/Ov0AhMhmG0ILB0zEdu/Lpd2DJq4lW2YQWzPsgtikBTggzUcxGlZD9f6s/ZLLhG5f220SIKbHD+SV25MQYBipugefzAksXAlP0M6iLJjNroJ04kfGrgXd+4L0w+xyvH41PeHqd2z/cfZ140yt4NOzYuHPJDj1pGrLHw87U8w08gMi8tnwHQBX9KL4QljocoZ3s0Mkr3IygFXq0gXvazh07jG+QE8kz7op4nsRvt6EwQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5cN7gkvweniinjHN5anjHUpjznyl5Q+q3xrkvpQDW8=;
 b=R3rj/TGZjri+/Muq8sm78YskeaDTpoX0G0NevxaA9uf3qLNiQIGZlXvidpzokaHa/11lZemF7ltbreve8E+mxVcxzrQK9SGFq5dCLeFBVqegz2XFoobLbNlXlAQRnZvDvt7dcx5Q8Y3xxGKHG9yzym9Scpk0myr6MI697AIUu5wB7IMRgABA5aLAosCEvgGWeC+RKGtu8MVvabFh9h0WF69x9O74eSfehzClS0kxkHivzECJpj+oYRKbjiKc/97hrh8M6h4rI+H6lQM54oG7GPB586Bq44odhCjJDFEdcsMywulb8aApVBK/PAfjM4NQSXI1w6fyWI1dWmhrWGwCkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10569.eurprd04.prod.outlook.com (2603:10a6:800:273::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Fri, 22 Aug
 2025 04:06:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 04:06:19 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 22 Aug 2025 12:05:32 +0800
Subject: [PATCH 5/6] arm64: dts: imx8mp-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-can-v1-5-c075f702adea@nxp.com>
References: <20250822-can-v1-0-c075f702adea@nxp.com>
In-Reply-To: <20250822-can-v1-0-c075f702adea@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755835544; l=2793;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=k5Hs+Amecj6+QGD6PsQ/3cP5ltSqAIzRxVwJy7xq3no=;
 b=tZ7lKHedYS82kuCay2iY2lZFpZ5njIKTFgVLrbPGhvf8qzwV2w3AjMubiIDawcgoiDSHJSSWc
 FLPLthFdcIlAPbpiPyeGJbz0zpedzBFIHGlQrVEheAbAYgZoCc+Upuo
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10569:EE_
X-MS-Office365-Filtering-Correlation-Id: d9074674-026a-46e7-0c68-08dde1313f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|19092799006|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEc2aTA2Mm5QMHdYWCtUdlNGZXlmMEJDV2J0SmtuLytVanM1WFlETFRPT2g3?=
 =?utf-8?B?eG1DbEMybFZmQXBRM3JxMFIxSWhzb25uYUN1c01ITW8yR1AxeWRzZ0JyK2F3?=
 =?utf-8?B?ME9rcmZvWU11cnY1Szc0NmdZNzVSc2xkd0ZmdmhzMWxjSjlnV2gwbWFKNFR4?=
 =?utf-8?B?dW1UQW1XN3VnY3RnV2lQbCtxOXZuNTJ2TXBwbTlHdzdNOXVxQnpEbWlIZXdR?=
 =?utf-8?B?L1phT2pudzBkeStZblp1bGxNSlZod3FBZXV0a0RKTWFlbDNHbERQcmllbHEy?=
 =?utf-8?B?ZlhNVlpwUUp0b1cvamZQeEh2cEZOY2JjYVhjVnBYVXZXR210alBabVV4Z2hj?=
 =?utf-8?B?ZWJwWVNjdWxIakhrenVGdTMyVHpEZG9Gbm4zcml3SmRabFNEZ0hENVoyOEtP?=
 =?utf-8?B?bDlnc05iQzNUdndVem1wQjlWSFJwK0RLcDdzOWFONUNiWWVzbVRnVVM2dFd6?=
 =?utf-8?B?ZXhWNDBMVGx5YzJTMDVoZjFXYzFpSFB6QlFDZkE0dGc3M2xBT1ZoWmE3TW8x?=
 =?utf-8?B?MVlpUUp4V2djUG4wdGozM1VoL0hEOW82Vm12MmhNZmVJU3A1NElpM3NSdVg3?=
 =?utf-8?B?eFY2eTBCVER4OGtabTkvN1NjcmlPazZmY3VBN2ZzdlFNWlJsdUhMdjhNeFlB?=
 =?utf-8?B?TWVTQlRkM0dYT2c2blY5Z2JFUFJ4bUhmNmt2Rmg5ZEFtK3FiK2dFdk5FNVor?=
 =?utf-8?B?VUZKS1ptMVl6Sk9kQnpPNFdLWmwxZHBobytPakVOOFhFbDBnT2xQblMwT2FX?=
 =?utf-8?B?cm5DdWFxckZPUklhZzZKT2RzNnpyZ1Q3WHNjSE5wOHZCdTA0ZTJIQytzMDBn?=
 =?utf-8?B?NGVROUVHeWJxS2NldTdramVnY1lleStHdWVRU0hJNHFpRGhhc2N5SG9zQm9Y?=
 =?utf-8?B?RzR3UnAxbW1pa3JiUVdOd1N3Y1lXMDd4dTFSYWNoQmJRTTV2RDg4TGJYOGQr?=
 =?utf-8?B?bzhqWTc2TFlQL2ZJT2JSd21GYzdFNkdGNWtmRmVhU0JhNXBoQitPVkwweTlh?=
 =?utf-8?B?N3VtSHgxeE5yUVhva2dxSmtkYkZKYW53U2oxalVmVGpVSm5uMG4vMWNIQjNB?=
 =?utf-8?B?dU5SeHVwc3lrazdzejBadThmSm9aZ25IcHZ3Wmh6SVJpalBzNVphSzFCTzNa?=
 =?utf-8?B?eUxka3RhK09rSVF3ZTAvKy8veXNYMDlzYlNVZnhDSWUxdkxaRTFwMFZDRTlx?=
 =?utf-8?B?MTA3bUlZUUtQVG1CRDROOVlPSVkrR0pyZHR1T1oxb1NXYXJydWdXdkF4MVdy?=
 =?utf-8?B?SXRlWjZiUEtnVVJQTm1ZSThNa1BrSDBLL3R4S3lqV0NKTHlsYUVjcDVZQXpI?=
 =?utf-8?B?c2ZHNlNUSmkvRzV1cFNXTnl4bzEwWnVhVmR1TDE1QU53NTlEVGUyZVFwLy9j?=
 =?utf-8?B?UnJzd1JQWnhkNGhXWmQxNWlPaWNnY3J2eCtPUC9TUFJTSWJPSVRVVExRTEM4?=
 =?utf-8?B?MGJWQTlIQWd4dFozdUVON3lZcEhLbmdXYWdndFIzN0FVeUJPSWl3M1JlR05F?=
 =?utf-8?B?cmVuVjRXRjV4YVVibStqR3paeno5NS9vYzZKaHdOdVZWclhxd29TRTk4YlU1?=
 =?utf-8?B?akp3KzVqV3RUTzlzNVdHRlBSOWZqODNrV3I0Nm9lUkVPWEU4emliaTZqZEtO?=
 =?utf-8?B?ZEVzRDhCL2daMGpWSFJrbjNhbExpT0U4YXB0TGdnS1J0MzBrU09vc2lWdG94?=
 =?utf-8?B?bWVaRmowNTF1TFBsWXYxZVZ3RkExd0licThJc0wrb2Q4OUI1RWVqWXRvQWRH?=
 =?utf-8?B?dU1idEViTGdGbVU2MXNzeEN2Qk4xRGF2SldJS3ZKcUtoSU14Z0wxM2VCN2s2?=
 =?utf-8?B?ajRNT1ZXbVdJd0FCbEIxbTliaG9JeDlpMnRaaWhsM3AzVWcvNG1mVjZRWkV2?=
 =?utf-8?B?c05UL2kzeGZRNlVGYW4zUjZxSkMzaXUrSmpMQzZ4cjF2bm1WdXo1am9FWWcw?=
 =?utf-8?B?ckp5ajZwOCs1WnAyNHRUTnlLbXZrMXdVeVpnT2tIRzQ0dVZVVmY3ZDNTWGVL?=
 =?utf-8?Q?DepRnlDyEZzGihukRFZi6rrOCCbo74=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(19092799006)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?em91ckxXSzIzcWZpbXE1dExqVWlLTU0rYXIxWU5ibWw1SjR5VUhmTDM5ZThT?=
 =?utf-8?B?S0JEejRreWpVcHpVdXc2RXlJYmhnWWJkbDREY1NVL0ZGMGd3cVdtTFdHbWR3?=
 =?utf-8?B?dmI3aTFVTmNNOGYwb0IwMFdnSElNWWZsTXpTVm9wZitoWGljYllGVWlaV3pu?=
 =?utf-8?B?eEFsMTJ0Sytvd003aU5TWThGT291eU1IbEpzNUtMcVVyQkV4YkdCdkpnb280?=
 =?utf-8?B?eUdvK1Z2Q2VqVVI0UktBc25Sa3p3S2x3b3lMbm55d3R1dm02SlJEUzFPRHB1?=
 =?utf-8?B?RjY4bXoxdVJtY1AvSEZyQjhRWEFzRUF6NG1tRWZFVks0UElHQ2FtNWN1My9K?=
 =?utf-8?B?Rk9BVHBoUnZIYTBYai9IdHIvTGdNbi9yMjdMZTFxcVkrdHd2cFlnczBUemVu?=
 =?utf-8?B?Z2JzTXdoWWNBUWY5Q282a2p6eEJTQUROb2QweXhJS1hwQkVGR1M0R3JyclUv?=
 =?utf-8?B?T0pKdEdpc0JOWGlJQUltMXJMcUl4NEZjNmpBTVp3VnZ6MEJ0bGxFSDVkT3ZS?=
 =?utf-8?B?RmhIa1JtanpIQkwrQjQyREdLOHVJb2pNd1NFRksvYUdkZFVyUVJPbU5iOW04?=
 =?utf-8?B?V09UR0hsUlZseUFUQTNxdTRETGVEQ05ydi9nakZRZmxFY2JZTzBNQVRqaU43?=
 =?utf-8?B?REFXa1NCRjgxVmlISkVZUlYrV0lDQm5hRWhvYVFoSmVvcG1CR3BqU042WGF5?=
 =?utf-8?B?T0VGQi9LZm1sYkRjNDJFMkx2NGRYLzRPZWpERkVaQmx0aXdKTVlaU3N4azdZ?=
 =?utf-8?B?dkV5ZWk0dnRWazBteVZRWmJWaGRleEw2Sk1GWjZMMDJRTzVYUmtmQnlTZ3Iy?=
 =?utf-8?B?WkpCZHIzd2ppOCtJZGdWRWIzQjFweE5YeTJNWm9ESjhNMDNOT0NuWit0YWNz?=
 =?utf-8?B?d1FQb2t2OExQN3RDaFc3c0lObkVXZExmMHlzd2k3bEN0d3N1UFY1eWYzTU9o?=
 =?utf-8?B?V2JHQ20vUXJ2RFdKV3Y0eHppRWtZSE9zczNObE1JTTBDVjZydVVMZy9URW4v?=
 =?utf-8?B?SUEya3dkbHNjdmNhckxoNThTaWQ0cGx3ZzlJS2tUSVlFNnVqS1dpaU43ekMz?=
 =?utf-8?B?R2pYSSsxcGJaME1xRkNZUklrTnAwOWRKVmZTOHRvbzZ4cW03UnJFWWVqSzY1?=
 =?utf-8?B?YlFlMVI0MkpPM3BaRllOTkFwVFN6VHQxK2FGVE92SGJsTlRpbTA2Zm1VTkNJ?=
 =?utf-8?B?S0d5ajZXNXdOYVdpWDhnelNUQ1ppcTUzMHdhdUNlWDdMR2d3Q2dnczZCTXhP?=
 =?utf-8?B?RlI4dlhtVGZFQmkvT3hYNnJOVHAwV0RHR3lJc0dPUnhiYkNsWDdHdUhVNW8w?=
 =?utf-8?B?ZmoreEkraG9uSG9CaFVOaklQRHdUaVlXM2JUTE51dUUxbnFlR3hCdlJ0MlBR?=
 =?utf-8?B?YUR4L0s1QWxNRjBPWisyRkVjRVZ6R05zMmhjV2ZFejc4NW43UzRRUzE0RXRD?=
 =?utf-8?B?enVlSWJZaDRvTXpOalVPcWhRaEhiOGhHT1JDRFNmL1FjSmNZR2lVdzZXQUs3?=
 =?utf-8?B?Z2pCcmRhMFpTdG9VdExWcGdkRnhldkw2eDBHeXpKa0kwTWhXdVpncnpwRStM?=
 =?utf-8?B?OTRPd0ZUZUVTbVFwNHk2RnF1MkpnWWNBNGlhRW11ekg4cTFsZi80cWI1bTl6?=
 =?utf-8?B?YXlnSUZEaWVNMXZqazl2djFxRFhqLzdHaVNQNmhxWnlaMHc5K1VMTXBOL3VO?=
 =?utf-8?B?dmNnams3cHRxWXNudFBGWFc5Nit3dmdvelFXSWRyZWw2b2Fvb0t0bUl2TVZm?=
 =?utf-8?B?TE1jV250bUduNkVsOWh2R0JGdHBvZFZmY2VMTm5IWmQ1NHh5bTFpZStUelRy?=
 =?utf-8?B?NDl2anVrT2dBQnZzM0g1VTYzQy8wV0VsbzZnUU4xeXNpY241blVrbnc1NkVR?=
 =?utf-8?B?S250dHd2K0RINUE1aGxjMW55RDBIcWswZ2R1ZWNNZWdiRGtWTVpaY0thaGpj?=
 =?utf-8?B?SWhNZWkxYndXQTI5WXdYWEtCemFnRG9JZjQ1THEyRkhoVkR6VVhxL2RMVzgw?=
 =?utf-8?B?MU9IZ0hqNUl6Zys2UFh5Q0VPa3NlQzc1YVhVcWpGcXdCcmRqc0k4SFpXdVpl?=
 =?utf-8?B?b2JBeUNTMkROeFFGeVdHQS9oQXpBVG0xMG5YR0M3U0RuMmhvZHpLVFJXVDVk?=
 =?utf-8?Q?vTzX0Z3ISAdTNtC/wL2nwUzvG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9074674-026a-46e7-0c68-08dde1313f83
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 04:06:19.2722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDArSWfK+01OtgLKE4apenehhST0I2g/+K+laUEEXxSoP5MUBtvoks5eifYpCZlJHwWbjecG+rw1Wno5PQ8whw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10569

The TJA1048 used on i.MX8MP-EVK is actually high-speed CAN
transceiver, not a regulator supply. So use phys to reflect the truth.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 43 +++++++++-------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index c0cc5611048e6a739f13c14bbd2e7b26f2715696..d238d419d87cc7c99d472720c96aade90275cb0f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -56,6 +56,16 @@ memory@40000000 {
 		      <0x1 0x00000000 0 0xc0000000>;
 	};
 
+	flexcan_phy: can-phy {
+		compatible = "nxp,tja1048";
+		#phy-cells = <1>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan_phy>;
+		standby-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>,
+				<&gpio4 27 GPIO_ACTIVE_LOW>;
+	};
+
 	native-hdmi-connector {
 		compatible = "hdmi-connector";
 		label = "HDMI OUT";
@@ -103,28 +113,6 @@ reg_audio_pwr: regulator-audio-pwr {
 		enable-active-high;
 	};
 
-	reg_can1_stby: regulator-can1-stby {
-		compatible = "regulator-fixed";
-		regulator-name = "can1-stby";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_flexcan1_reg>;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio5 5 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_can2_stby: regulator-can2-stby {
-		compatible = "regulator-fixed";
-		regulator-name = "can2-stby";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_flexcan2_reg>;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	reg_pcie0: regulator-pcie {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -431,14 +419,14 @@ ethphy1: ethernet-phy@1 {
 &flexcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan1>;
-	xceiver-supply = <&reg_can1_stby>;
+	phys = <&flexcan_phy 0>;
 	status = "okay";
 };
 
 &flexcan2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan2>;
-	xceiver-supply = <&reg_can2_stby>;
+	phys = <&flexcan_phy 1>;
 	status = "disabled";/* can2 pin conflict with pdm */
 };
 
@@ -903,14 +891,9 @@ MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX         0x154
 		>;
 	};
 
-	pinctrl_flexcan1_reg: flexcan1reggrp {
+	pinctrl_flexcan_phy: flexcanphygrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05  0x154   /* CAN1_STBY */
-		>;
-	};
-
-	pinctrl_flexcan2_reg: flexcan2reggrp {
-		fsl,pins = <
 			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
 		>;
 	};

-- 
2.37.1


