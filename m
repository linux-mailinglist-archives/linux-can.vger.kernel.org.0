Return-Path: <linux-can+bounces-4405-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35826B3D728
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 05:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895411898955
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 03:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EAA224245;
	Mon,  1 Sep 2025 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kEpPAao0"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013021.outbound.protection.outlook.com [52.101.83.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E2821E0AD;
	Mon,  1 Sep 2025 03:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756696746; cv=fail; b=m5A8Wlzl7se39bHqqrR87dKPAWz/a8uM5UH85OtDSVbu0hc68jFLmvtusB6V2uL5KyXGHVufTqU088Wnyi1U81pEmUOd5Bl7m9T223z00vWZRFn8Pcb9r2PfwYu3S651rxmokJrTak+/6RxunK6wWubBxwLLSvMuLIguRpX7ORc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756696746; c=relaxed/simple;
	bh=/DEKToE9khI/IF64bz3dyJTnpv6u0rxFEBM5LAt0TbY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=n7HEQKRmh5d/9zKD5cMnfiuepD6wdH+TvWmbGdoQg+f4lfOq4AmjruL7bwV+CyCvAEwcsKxFU1/i5Cm+cLPaXze7lfnBvqHdEeO5tA7yuwnqe+iWgzX4hIdlHm51+X48+4ClCzTqaw1GtqkamDnC1PqamsOPj7/2YIzYhtF7haY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kEpPAao0; arc=fail smtp.client-ip=52.101.83.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyeMcxd3ZIIzRjavY1YER57TMKKcCseQFao16Nykv8u6pb/5ReOw6TR5gv7A2ZZsNKq+dRBltdzeOK1newfhEVnc0H7khbMl7rPM7YCtxQUPu97paO5jLHh78aroCAZ9tO8SbRxaOzH1bqbFiEdgmTVgt2pX77iuxbX4O//FtoI+cdfGUjcEiF5/TrFKBtbOYvLCU0ArdH74khkw3EoqwLzYgmZfIZj9BSXWKlV6A1vEbJHABIolPzXpHYWjpxjmOsWl9/F4sFf4/Ivq1Hez2Q0OrZ0JQYL4k4kUDXj+e/zuh6jBIUrTuKB3V+hSkTa/B0/WOGKg87RT17HRW60JSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHCj9HHteqFAp4t4kZFMVgMbZE3pIlCwTeH5w7sEo9o=;
 b=xVZwUs2pcLE9PIu9YZn6wb/u6FHir62O9wuVsrXZqu42fIbJNVU8MgzkhPIvTwtQD4xsnxd5OJxInOE+vyLtgAZDnlzWgVQEzwlHxA8uxmy5XnjMPMEPiy75s4COdqWF2ypznOlcePE6WmJcVfZLve+go07pD8IbNiE+sJDWfBgP/eohIBixEVHbR8/qG/IVd6XJN/0VppuB5viy8zf8X1yd8vb+vU3DFD93dD5xaAYtwrViosoTvauor1J/b/p+PGQYte3GLaxo2d7RZs865JifdtLga9vY7AFr7EA2J9Py4Q7bQPhGQvEkcafX0Uj3TDDGb1xDt6xTBnClyHbQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHCj9HHteqFAp4t4kZFMVgMbZE3pIlCwTeH5w7sEo9o=;
 b=kEpPAao0yqzlQnxwYDei0VQaPrGWSTnB5+ecm5HSIfpHqUdRM6bEcc9HoLjDdqYrnKAl7yvQxgnnvOPxfwvaT01c7wPQp9XZALsT3mhJyLoqEyNIJjG6x6khSXuk4oePhga6qzI/AjDDTA14wxpPYsgBIGny+UsKSEbWTgEW9ZNeNH/BHjeMtnv2wmSQJz2UhcwH6BruP7mE0ZeOOSRLBjCIX10tUvoX5HxNlVHXRPr2F322JJdrgfuqMItVZMUY58aKlPu81XXw6cqPV/l7MKzZN+kW1P+UfWm1NVnCc4e0lWjPKqUaSnNT1/qWYrNGepUeXdF3WEW+988VaLo6dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 03:19:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 03:19:02 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 01 Sep 2025 11:18:14 +0800
Subject: [PATCH v4 4/6] arm64: dts: imx95-15x15-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-can-v4-4-e42b5fe2cf9e@nxp.com>
References: <20250901-can-v4-0-e42b5fe2cf9e@nxp.com>
In-Reply-To: <20250901-can-v4-0-e42b5fe2cf9e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756696708; l=1482;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=/DEKToE9khI/IF64bz3dyJTnpv6u0rxFEBM5LAt0TbY=;
 b=1liP+r75O3Hv76g9YNIJZ4nQCxoUeWflBPqvCytid+fIwH8i6SPApXhWqc9LHzJhxyTFdXo3L
 FCtsNcCFmKpAzK3io3ZSpsuK1pkkdmqvdCE7kZQearTpuyPQQS8LV/2
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10321:EE_
X-MS-Office365-Filtering-Correlation-Id: 0135cd9b-404e-4956-c874-08dde9064c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUo3K09iamxSWGFUWlIyVkVKVkRCd0R1eTV0MHRsb1B2aWV4N3RPSDV6K2lt?=
 =?utf-8?B?TkxGSlRoWEdpVE45NTd2Q2RaNW5wWG1mODN6VVRkZGEzZGdYQ051QU1aNjU1?=
 =?utf-8?B?dk9INitCbTNhOWIyai9jVUhqZ1BGV2laeGVFNyt4Y3oycmwvc1pVL0VwUGts?=
 =?utf-8?B?SExXclg5N1YzbFEyd1JmdGhsV3p3cFhBRU5YMEdJWFFwWmlNbWk2NWZ4YWZv?=
 =?utf-8?B?Rm81a2NLY21Vc2JNWU1Ya0dpR1d3MGJ4WC94V0toTExDblBYUlQ3V29haGJJ?=
 =?utf-8?B?clhlQjNwYTdReXBLV0xtOUpaYUxGNTFoWktsTG1UY0ZvYjFndTlOb2FZeFRz?=
 =?utf-8?B?WVc1N0lCckdVV3F4OXQ1OTBmRW01aHoyMU1YK2ZPVDd2aEE0aTBlM3U4ZkVZ?=
 =?utf-8?B?TzJkdDc1K0taWWlESHlwMGtwVStpaFh6VTlwT1A5Q080UE9GQllHRk1KaXFj?=
 =?utf-8?B?dEx0NlprSFpHYnEreWVuK3lFZWVXNmUzK0RVRnpSR2JRUlZETHRLVjNTcCs0?=
 =?utf-8?B?MG9PRDUwSWVJd3FlOURILzRtZHN3bjR6TVlqVjhlaHpWcldKZlJlMXZIbEpF?=
 =?utf-8?B?NEthek05MjhZREFXZEJWYVJySDJhZWx0SkFmUjhUV2gvNW9hcnp3NUljS0Nw?=
 =?utf-8?B?d0ZnNUpWWVRvbUFTbFMrU1J2MXlTZkJKNHlGZ0VMZWJwa3BwcVQ2aGRhSG1n?=
 =?utf-8?B?cm1HTkdwTndTSmFQWWlVbUw3SGRVTmpvcXkyb2ZnQTBlTjAvbDNGQzJ4K1VV?=
 =?utf-8?B?eEdvQWVPeWY4L0t0SVl0d3RHN2hwMExLalUxdVg5Z2hDZjZsVFU5dnpvc05z?=
 =?utf-8?B?SGsrMGZRV0hSMlpBYVRpRVpiWEJybDVEWllDOHdOejNKeWM4eGR1TjZZNlll?=
 =?utf-8?B?MlJSK0dCNFdsVWw2VW9pcDlNYm1TS2pSemR2NklySklBTzc1dVBrdjF6Y1la?=
 =?utf-8?B?QjNwOStjamZxaGd0c25rbFhmd3Zkcjcrdzh3Tko5MGUrdElnRTY3b1BiV0Fx?=
 =?utf-8?B?ejdUT1pYUDNQWTZScVlHd0xmblVJMW5veDFFd1VXL2hVWktnNVkwSlpnYnAr?=
 =?utf-8?B?WEJDNlJ5VzJYbkF1UWlBWW01ZmNmQ0RCT1p2S1htOFJhRmxKL1FySHhjaXJE?=
 =?utf-8?B?dUtEQmVaQ01lOThIQkNXeHRvUXRsVVQ3T3ZFSkZyempqUFRxZk8zejF1eE5U?=
 =?utf-8?B?YytkdGpCQlhpZ0dyUThzSTBIeGRQa0xxVk80eVZuMFlaZGE3dFdCZDR0VllI?=
 =?utf-8?B?MFNabG5qRUd6QVFWc0crTUwrVWVqQzZVdjJDbmRjT1RXSW1LL0NRTjR6WDVX?=
 =?utf-8?B?ZFljc2E5T3lXYkkwcVdBL1JuY0pJemJnWUxjWTFqMEV0Y1FGR3BFK1JXUlo3?=
 =?utf-8?B?N0NaRmFXb3NUUzhwbzRoMHppT1plR2NWNi92bGdRL3JRV2d0L2FTNnVKcGJQ?=
 =?utf-8?B?Y2s0a1M2eURDQnprdENpMWJpaFphcDhES2NNRWJZK2FyL1Z0dmRwN2F5N01q?=
 =?utf-8?B?NjZkbzF6NEJEZVFnL1ArbjROdUJ2c0lSbVdHaEFVMFYvRklBNU1kaVNIdzBB?=
 =?utf-8?B?QVdPSjk3V3NvdS9tUzNYdUhZM2ZOSWVmdlpmQ2FGV3ZGbHlhbkxGOUlFL0tX?=
 =?utf-8?B?Vm9NcjlPTmROM2dCM2FKKzlnWWNuVGxNb0ZDaXYzR3o5ODNFRmg4RzJjQ3FI?=
 =?utf-8?B?cWNHdUd6Sy9tK2hRVGRaUzVjQ1BENXJ2MzI1Tm9oejJOTUxhcVhudUNpalMx?=
 =?utf-8?B?c25PNFIrcEN5Q0JnVU5MZ3lDYXpLZmxFNlorUVV0eGpRNjZWeUdrTzl1eHFX?=
 =?utf-8?B?RjBFMER2aVhSaGJIZFRpdlp4Z1pUQzl4MWNLWHloaTVWNmxvN0c1Z2k2ZHRp?=
 =?utf-8?B?NlV3bmoxZFMvc1hGQldIRG5CbVRpQW4rNHozcjkrZ3AzbXBDYUpXd3Zwc0RB?=
 =?utf-8?B?TU5iMkZzcFhGREVBZHVtbUc3dkI4TnN2c3pCQU4rRjNMUksxNlVCZnZiQWhY?=
 =?utf-8?Q?ghraz5nt5nLH3MgHnWjOy2KOwSXzwo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnpBSElxSjZyQ0w5Qk1IN0t1aGtIM1I1TTQrVzhNa01PeERkNTJJeFlrOG9K?=
 =?utf-8?B?Z0RxV1BadUpaMkNNbWxXbloyUStKZjl5ZWV4RjQ4Um1mOHd0dW50bm9zRGto?=
 =?utf-8?B?RDM0cU01aTlNRDREQysvSmdBdHRUNzNVUFNpU0F1NmlRSEoySGc5dnF1QmJ3?=
 =?utf-8?B?OWtiUnl0WkdoQnA4U3BXbmxxUkFLbitkRVRzaXpXY3N1Z0pIZE84NFdBclNF?=
 =?utf-8?B?byszemcvYnUwZUljY052V1o1YUVPajRUdDltOEdNZjFMeGo0OEVzZnZOT3lM?=
 =?utf-8?B?elV3QlhHNkplWFpKZDRFM0V0UWJ0NElQZS9NV0RQWW0vdEhvZnlYekpzNDJ1?=
 =?utf-8?B?aUtZTGVGWEZCZytZU2dsVFZnYkp0UDBPbGdpTExrbkFLOUppZDh1YXVEdVNZ?=
 =?utf-8?B?S0FDeWZpSFNOa0FBYXR3UUwzSWkvVHZUK2Y4TEIvYzRvVUVMU21oN2RLMXJU?=
 =?utf-8?B?SC80R1ZPQmhQa2Z6cUhrK0lBV1ZsM3JnSDBaMG4rbEdkZ0RFb1hCOWp4VEVJ?=
 =?utf-8?B?OHdRRkRKZDRXblpFN2s0VlJpYTNteXNaeERIejJIMzhmalRlK3EyTDdNc0NO?=
 =?utf-8?B?UG56QXU3WlpEMjNhQStvSWFXb3IxSTZlKzVLQTNsZ3dvRzBOVUJZQm5jY0Nm?=
 =?utf-8?B?NUpBKzFuZHc2dDRQdDhKS09DVHk4STFiRG5FN29YVDBhYlloSzRGcS90cUNK?=
 =?utf-8?B?aysydmdveHNQLyt5N2xscGhLeUpjL1VDdkVYOXNyZ2xNeWJRWDhTUFhSdzB1?=
 =?utf-8?B?U0hzcWVtRTVUMEdqeThFeWZLRDIyQlZ4LzlFajBhWnkrR1RNamVTMGF0bTZC?=
 =?utf-8?B?NWIxSmNJVENaWHhOMDRsdnVJZVJGaG5JQlN4VWxkWnNFbEpndTRhZDRLU0Vo?=
 =?utf-8?B?MHVISUx1ZEpLZmE0K0paN2UwUDQrUW82Y0hZdG0rN1dZYmt6Mm4xcEswVFdO?=
 =?utf-8?B?K0lOd1Rsc1dlT1NrMHp1bGtoQ1lZMnJJSDBwNitFOFdWU1VzMUhUL3IzRXYx?=
 =?utf-8?B?KzlpMFE0V0tuT05uWnRYMHN6cWdDQ2pzVmFXalJtNTRlbzVmRDdCNlFsNzJl?=
 =?utf-8?B?eHh3Tm1TTmpDSkNMdFd4RytzRnZuWi9ma1pSNXZyWVZlQWNWVk8vRE9CWS9s?=
 =?utf-8?B?SDJmdkE0YWRET1lLMzkxK2R2c2ZpMERVWnZJUnRyMk9taGpuRG9ITGYrY1Rt?=
 =?utf-8?B?aVlOMGxJc3Q4SEFJamMwRXR5RHBhdGZCSGdsay9aTjVzRjNab1dmL0plTnk2?=
 =?utf-8?B?VktwaWZpdG8yYWhaQkRhSWVZMFo5bEFjc3BDQVlQanRvWHh2NHdJajEycXF1?=
 =?utf-8?B?VHg2Q1pkWXFLV0hJbWY0bG5XMEpXOHYxSEhaVUh3VzZFR1VLZEw4T1lHY0dH?=
 =?utf-8?B?aWlpdEUrbEZFNlFrWDBBVXphUmQ5NG1KMnppcXBqVUdBKytHdFY0aytlY21J?=
 =?utf-8?B?VnRWbGsxWjVMalBnQTkwMHVFWDBFSUdHeG1mTGNmb0RNelFtcUYyaEt0SXpl?=
 =?utf-8?B?TFdHWmNDUGhhUEMrRnFzbWExMC9IQnFZRHZyR3F2ZkozZ1FuQ2VBUGxhdGFI?=
 =?utf-8?B?L1g4YTJ1NGhGS3VNWTF3VUcyYzRnSHRmelJxK3NCNU9OVllWNVN5R1ZaR1Bt?=
 =?utf-8?B?a1FHOWp1VzhFSnE0bjM5TkFmSnlvRGh6d09GWXFYQk1tYk9VQVhzMnFmSnF2?=
 =?utf-8?B?ek0zNUVlOXhuYW85d0xQUmhzNnBoK2s3QkxqVXhnMlByVmtLbTlucDI3T3Fz?=
 =?utf-8?B?QkZMOFpqdlVHNytXVkZIZkV2QmV3UWFpZkJUSjlHaHRFTEpGdFB1c25iWHlB?=
 =?utf-8?B?QVlqMTJ0VVdKOWpqOWhBd2JoVWFTeW1meUs4L0JUZmEwcDJRWVFkOW9TR1JT?=
 =?utf-8?B?UjdyaVgvc1hFZzcvTTFXaStGWGFUUkExTkN4T2lsUWNnelFLOS9FRklmT01w?=
 =?utf-8?B?ckMwd2tkUXdIY09xdjdLRUJ4MlhOMHZsZHRPa3ZDZWV3eGxRdThHekt6ZEFX?=
 =?utf-8?B?L2hhdlUzbXFDdUlGKzAxbGY5RWpycWRhTjVjQmdja09KZU9UcEh2QTdpbldr?=
 =?utf-8?B?MHE1dUZwb0VuR0NzS3htMzBvOERvYlBkOFViVGtkUmJOM1hHdVNmQ0NBR0dv?=
 =?utf-8?Q?Wd3e4pGVYqgwQUgGwEmFFt3/V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0135cd9b-404e-4956-c874-08dde9064c1d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:19:02.0504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBlNv/ztOf7S2j4PoChIg4VQ0uff2d4ojved4hoY0lgJJoM8uiF7atDX4plpyXMrq1ulM5rk8m9Nd42o4P0nlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

The TJA1051T/3 used on i.MX95-15x15-EVK is actually high-speed CAN
transceiver, not a regulator supply. So use phys to reflect the truth.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index 148243470dd4ab03afdae949c8316f31467d1377..c229b748ca7aba2dc8cabe14d66e3d1dcd704c9a 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -106,12 +106,11 @@ reg_audio_switch1: regulator-audio-switch1 {
 		gpio = <&pcal6524 0 GPIO_ACTIVE_LOW>;
 	};
 
-	reg_can2_stby: regulator-can2-stby {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "can2-stby";
-		gpio = <&pcal6524 14 GPIO_ACTIVE_LOW>;
+	flexcan2_phy: can-phy {
+		compatible = "nxp,tja1051", "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		standby-gpios = <&pcal6524 14 GPIO_ACTIVE_HIGH>;
 	};
 
 	reg_m2_pwr: regulator-m2-pwr {
@@ -317,7 +316,7 @@ &enetc_port1 {
 &flexcan2 {
 	pinctrl-0 = <&pinctrl_flexcan2>;
 	pinctrl-names = "default";
-	xceiver-supply = <&reg_can2_stby>;
+	phys = <&flexcan2_phy>;
 	status = "okay";
 };
 

-- 
2.37.1


