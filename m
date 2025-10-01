Return-Path: <linux-can+bounces-5082-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46597BB07B3
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 15:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2455A4E1869
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 13:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A74C2F2914;
	Wed,  1 Oct 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GK7uStec"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9892F2611;
	Wed,  1 Oct 2025 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324991; cv=fail; b=qBD9GIyUhmDcb/Qa51kubyd63iBt533TBSmp2FPZcGh97RRzFAv5UUQn81Xyf9zWVcl2YtevHBO31UGeuaFn2qmzjrJW15YZeQERhmGfl+8Y4xoj65UcXNJRJSyL+QTUFOK90SBnz2Efnc/B6mpNthC05k39Th1IRDCits1lRYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324991; c=relaxed/simple;
	bh=4fDDBf9ZWdTE+TSeEkYBeUOVTNHO7HUE9EVWd93HAnk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XchaUSChjt14Ii25HX2Vy/CKV6uAu89TdkN0UlZ60cNqM+KyDbas7ddQxJY8dDR3dobJWVRqKpyvuPXMoQfuG/HWP9GCkYIsXxP+tu9fGGL4Sjw67g8oyrme8+plduIQG9H1rR238/ephJ22hRxnZMba1TPw1rGDr6UkG5TFekA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GK7uStec; arc=fail smtp.client-ip=52.101.72.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efmaqWW2+QPgCUy5Yiq7DeeTMym86/quXNVS8C1ys1mtBrgaEzzOn1oTJSimUi6hd3CFgvtdHtLV1Rd4WE/oGv6ZtVpnBz4Hlywo+O0oFx0LZL2NCB/Uu2mog169rmzTRjvpVUIvGFj4d/g+0b86yHwCByiBiDJ9kfR6263MYYFo3mWzrWYFHPyMS0WM+Yy98/udAes0U2MIzkCQ8+NL1idWvXi6NzVk/wfkh1m9A7kou1mrtBL4FPxWhd/TKIbk/MJxH0wJczDjeQI8PZshx6SIhiECDOZ7Hhe4VO4jD29sKrWc4helUJU5s9FrHvHGA23dg4gUTTAMlJ7E1GLt7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z55kA9f8QZA4zltFECyIygQ72CEIgPI8PxGBeNIPzU8=;
 b=VlYmbT+AkvD8icCgK4j4t40yqx48zRhpXOH/92nJWXb5+epcMYI5sRppYjLcL9JI6kyoLjrjhGJPRGXypgpm82V0tWgUUNPyTR27ECmRxgWhxkI7gsc5UfH2+jsFenR0/LZTiI3SB363wjF8fP5uc2YcBQQrEJFtHYH+lD3vzV569OOyg8Ep27tEzWNfd9Xt0sCBAfg4AH2itPsgfAZaKe+1TjttMymBup5Ic7kszbcnKcqM8Pm5sGASTihgkwJDBKoqzvsUy2rLX4bgqUHAfWnNQhUxtCwAOkTOmHj/A25XSGSuoUx3fgfX5dCyO8qlLAzb/2TWDZw6Kic5MshsyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z55kA9f8QZA4zltFECyIygQ72CEIgPI8PxGBeNIPzU8=;
 b=GK7uStecf5xMK9HDTrHkbDUAWnM9x76qFanITOT/Qp5y4ktrX7TvpOQrBrYk8XijVjMY3UTKPPYxllZYAh005UOodxA1G6/Z/+D3JXBhrJyEpuG7+fDQ5dTg/hpo2vikxxjvghADf4EsUBiE3Rb3cFkCE9wiCjH6BclqB0hsVvjbO/rcvD1Da579BfLGsNESsuzs7YJSNGX8cS3lzsIMYzdKgokbIWnlyVHE4OCd5T4Gs3Ok3VTp8aua7BKEdqP9zLc42+W9+DeQ8tkMY1+Se7wlkN0uEXTYg2ud61hYIoFrNTYLOIfMKVclso2cTNiMzVxQOSu0YsoD7sN4YlnNkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7227.eurprd04.prod.outlook.com (2603:10a6:102:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Wed, 1 Oct
 2025 13:23:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9182.013; Wed, 1 Oct 2025
 13:23:06 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 01 Oct 2025 21:22:33 +0800
Subject: [PATCH v7 2/8] phy: phy-can-transceiver: Introduce
 can_transceiver_priv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-can-v7-2-fad29efc3884@nxp.com>
References: <20251001-can-v7-0-fad29efc3884@nxp.com>
In-Reply-To: <20251001-can-v7-0-fad29efc3884@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759324965; l=3575;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=4fDDBf9ZWdTE+TSeEkYBeUOVTNHO7HUE9EVWd93HAnk=;
 b=vaD4Rwy+D2xZkIdplGcPiiBv1bBpm2a9sYFKp0cOZRikKhwCZ6POIVYgVQzKWjUq6kLSLI5sL
 qtbcuvDo2ySBYdYWGpg+PRi3hblCrEEwbIuJJZSS9EkiSso7pm+h1ZE
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b892071-76a6-412a-cafa-08de00eda811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmFDN2NqbFQ0WG13VG53UUIvMU1DdkpWQ2xnd1dzTXREdEJOK0NneTlmNTZj?=
 =?utf-8?B?UUQwdEtsNVpaSjgwQUxFWEl1SE16c3cvYWFEVUN1a3BGK01VREFJckZwWThH?=
 =?utf-8?B?cVFXNzRTY0VHd2pnUG1ET1dPWlY2TkhENjVSL2tGbHdhcnlmRllkbzd5ckF6?=
 =?utf-8?B?OHgxV0VwYkgyMFd5MWxHeXZoL0Q1L0hpRys1aDFHZ1ZKbmtBMWEvbmxZOGVu?=
 =?utf-8?B?Ull1cWkxeGdnaW1oUFl1U21zSEIzY296Vk5nT3ZoMEtmZWtHcHBQekxWNkFs?=
 =?utf-8?B?OWhucTk4Y3BqM1ZpMnRLMlZ0ek9VMjZFSkpFM2NKSGNwNTR0WDBSOEdPV0pP?=
 =?utf-8?B?SllUc09UU1NqK2JmUjhtSTd1R0FIOVViaDlrRExFcndMK0x3Wk1GbnFoRzUy?=
 =?utf-8?B?TlhKelh1Qzlva0k2V1F5b0JrVUpnTHRBRHloVmlXRkkva2oyck10eFM1eklZ?=
 =?utf-8?B?L25kbTBNVTV5K3kxcGJWbTFqUWUzWXI0Tnl0cGF2QUMxNlhhQ3hUa1JqN2Vm?=
 =?utf-8?B?UWFtQzdwblpjVFBYbWxxeGx6dmNlZzZFaVgvK0l1azdldjRHTHpQQkhIRktN?=
 =?utf-8?B?cGIydm5lMGVJbWFGV0xKWVFOVldDdWc0czRNdmljaXFzcE1uUCthbm1iemZQ?=
 =?utf-8?B?c2FiM1NpN1A5dENEQnB6eEl4ZktjR1I2RDJuUmNHczZzNGU4SW5vZ2FRNjdB?=
 =?utf-8?B?Y2U3WkJwTHZsN1ZVUkFaVDl0U09yNUdXcGlKc0dkM216S200U0kyMkRSdEVu?=
 =?utf-8?B?QWhYdVo4NGU5dGM0Skw1RHZVZ2dWZVQ3RURkTmVkTEpqekM5OEprV1NHaEkw?=
 =?utf-8?B?emtsUmVJT0pCZ20wZFVVaExHdWxhN0RURktTV0FZWDlqVXpBclFIZHZ2RmpK?=
 =?utf-8?B?RUlhVUJaWklSTTRXMzQzejJSUjZuempmbHhLR0xhV2t5Y2hEZnRROWhLbXFI?=
 =?utf-8?B?b3NKemh3Slh0UXJ3QzRPWnA5ZTRkdVM3M3Vrc1E4RjBNaHo5M3htbU0xSEhB?=
 =?utf-8?B?emEyZFVta25OUFR5Y1hsUlZ4NkNIcXlYTzFVZk1EUEp5bWlJdGxPcjEwUmlr?=
 =?utf-8?B?bFEyc0RSQmlqUnBkOU1BZlp3L0VVYWw1dUxGVVpiY045MzRqanY0TUdVbTYy?=
 =?utf-8?B?d1RHQ05OMWd4cEJtRDhRc1VyQU5CR2FEa3IvamNmR1JweS9nWmh1aTJvS1A5?=
 =?utf-8?B?TVFkc2Iwd1B0eU1oWTZ6eTVGbVVZUU56eEtMR2VPelU0S293UHJFeHZMaHhk?=
 =?utf-8?B?bE03NHJiRk5NS3g3a1N2eE9hVi94V1FQcVVvNjJVU0lHdFVjcUcyalRXY1E5?=
 =?utf-8?B?bitvemplT1RCcStXL1FLRFV5VjZ5d2VDWE1UZTNrWllWRDRmejQ3Q29MNEVQ?=
 =?utf-8?B?VXhxUVl6THF6NlYySzZlV011M0lzOFYwSW5JOE9DTFpOUlFyay9xd2ozazhu?=
 =?utf-8?B?dEJmN01EK2VxNjYyWW9Ib0dFWmk4ZThIR2hRRExxSDFkVGE4T01UUURRNmI3?=
 =?utf-8?B?VFZLUkZiam1qVS9JYjRDZHlLY0JONXVYc29tVDVYdWRia1d6Y21LL3R5bUxF?=
 =?utf-8?B?Q0swUnA2N1A3T2tmM3R4QW1jNzNqcHBQREZVWHpMSEtmZ0VPK0xzeEowUnBj?=
 =?utf-8?B?a1ZUR3dOc2VOQWZ6VFdveDR2MHZiQkJtcU5tN2NjYnlUeHdCc1NDS1pDdzho?=
 =?utf-8?B?bit4VTM4RUJURWp1L1R0cUQrbE9LNnhBbFVxSVN2QkdFOVJmZEFzMlJ6NS9s?=
 =?utf-8?B?bmVrYkZmdmlnWkJUWTVrSWRqZXV6RjA1U05RU3NEZEdPbDVhMENINjZXQ1Nm?=
 =?utf-8?B?RExtcDduMDdjeXFOOXFGVzdweTIrZFhrb0xqdk1zTzliOXBiYlBVaStJZm9H?=
 =?utf-8?B?OXBIanV6bDFtWUkwM0RtcDRxd3JwTU1pWEhiZDI3bnlXRGhCbHBZS2RiOS9R?=
 =?utf-8?B?dU90aXVXUllYUTlPVzMxOVBnYjVQMG1FTTZEdzdkVS9tZ1FFajVqSFZtRkYx?=
 =?utf-8?B?Q1IwMC8yMGhlZGtiKzJwN2gvbksrQnhuVEE2eGFaQ3RBNEI3ZGttQ1E2c1gy?=
 =?utf-8?B?SCtpVitKdkRxWkZmaVdZZTRHemRPeTgwWlVPZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEp3RVU5SGFKZjdYNEhJMnRXbDMxY0xaeTZkRFBxOHlsc2o5dGw2aVBqV2ZX?=
 =?utf-8?B?WHp2QmJEYnFxY1g4VGF6ZmlENkdvYnJZQUVhYXBYUHc4dk96UWR4a3RXSWZk?=
 =?utf-8?B?UExHY1FkdUxSZ1hLb0hwQUp6dzY3UEY2U29BYXptV3k5VnVnTGZGQm1jZU5u?=
 =?utf-8?B?ZDFCUUJyVEZnVjRHUk8wTzZoaE5xSGp5MExUYlNMZHVycDdUNXMrQldHWnNw?=
 =?utf-8?B?blBuODR6bWxUZ0c0bmRzNisrdC9MRjJnb1hzSHBiMzk5T0g5TThUa0Q0dU94?=
 =?utf-8?B?NlVaMjZnUUtreHU0VmM1dm9DaEFXUTZpN3JRRytJOTAycmg2RzU0WXVaVlJR?=
 =?utf-8?B?QllLSEwyenZJRy9LaE1Razd4NDFMUENoQjVVdnhuUW1tUm9LbEdlaG1qckc4?=
 =?utf-8?B?SDRIb1NkempwaC8wMDJqNGd1NVRqT0xidTVYT0JmVlB1NmNJa3EwNjdsVm5S?=
 =?utf-8?B?QTZIT0tsYk1zOEp3QmIycVBZU3hHK3JqbHZ4UjhFTkNnazY2MmpHV0JlYW54?=
 =?utf-8?B?cEFROXdCL3phbEgxNWVEN3JPdVFlcVNIMUgvK0Jtd05tdkF2M0hpejl4dVR2?=
 =?utf-8?B?cnFoWGZCMWVGUWtnbkVSdDN6MjI3cG1GUyswckpDSDNVT3NKRE9uOWtwR3I1?=
 =?utf-8?B?THkxNXc3N05UeFVEaXB3Y0FTdmlyZ1c0Z3c1TjE4cTlqN0ZHakViQlJDcS9X?=
 =?utf-8?B?Qk1BQ0lhaSsxRlNvUXgxRmppSmtpdGJmUEtDQmFCYzJkV2lHSnRiT1Fab0cy?=
 =?utf-8?B?WkMzaEM4NEo1UEZRUVFwcCtsWHR1MytxVVJoSHh6OUxyOFBBL1Q2WjVQSjBs?=
 =?utf-8?B?Y3hmL3VkMDFyMExRRklhMnNXaVhQTW9WR2xKdkVJQi91U0F3YnhXSVJ5WUlY?=
 =?utf-8?B?UmVmcit1Uk50MFlwbkVjTEFaQ1ZSZHAyUFBGUmducGJxbnE5Mk9xRGNYdi9S?=
 =?utf-8?B?WHlFdVBGSUhzMEFWK29YbHcrOHZ0WGZhNHlCRWkvU3RXSFFvU0NHYXRreFRn?=
 =?utf-8?B?U3REalZqUWdxK2JQd2xrYUZtNUNGN1dEQmlHMU9DamNlSEE3cXRuZFZTSGFt?=
 =?utf-8?B?c3hPUzNsMmJQbVFsMWRkZ25SOFB5WkhmWFFUNUVJbFp4M3lUVTl5UXBlelJQ?=
 =?utf-8?B?Mk5hczZJRVI3cUFTNTNvMzBDQ3NST2lqNXJ3eFlYVWlDeTRvZ0diNnpIU1Uv?=
 =?utf-8?B?V2pnR2hTcS9ZUHQ2Q21IWGxLMHZqa2ZoMUZxM2NuamhxNE5hSUxNR00zdXA1?=
 =?utf-8?B?VkYzTnErS3pIV2pXdkZwa1Jhd212YWVPZUlIcWN5VkY2WWtwS0EyT08zc1d2?=
 =?utf-8?B?Y2JrMnZkb2F6WVRtTjIzVGI4VlQxSWgvQmpUblMvejBFNkRNMXFBWFNKaG5j?=
 =?utf-8?B?bkxpQ3BJbkt6NnFqY0JRQlBtMHFRVU1VWXI1a0JudHdJa3luRlYwa0F4UlYz?=
 =?utf-8?B?bExwTk9sSGRiOVpjRHFQNVJBR0ljR3BCNloxbzNvSDlJbTlaaDlVVUFKVXFu?=
 =?utf-8?B?aGRrVmFIOVU1dFJBSkRCR29rR3oxd3hjWUEzUUlsc1R6a0szYTN5ZFFRb0Zu?=
 =?utf-8?B?b2ZuYmkwZ3ptRkE4VmFMMndmalRhTDF0MSs4SWNHOVpSWHBUL0E1MnVtYTNZ?=
 =?utf-8?B?alFMZnRMVFd0VDhSenBJM1FCWFNKMEUvK1NjL3FvbFY0N1htbGRNRWdBYUVi?=
 =?utf-8?B?WVBJS1NkanIvTnU0Zit0dlVpRWZGdEMvZzlmd3gvMmNBekU1NzcrUVpieHIx?=
 =?utf-8?B?Nno4eG5TR0o4RTZGT0FCQk9POHhaSUcrNTdUOFB3Sk1udyswcFJjN3F6TEd2?=
 =?utf-8?B?UUx6WmJnQmRGVUZjMUFkazgvdHhUVkNhQkJldG5kbkhRSm5kbkhXb2lWMCtr?=
 =?utf-8?B?dXp4QnljL3dXWldTZDdzOVFET254QWRXWW5tUERHUjErbXhpenFtVS9keFRD?=
 =?utf-8?B?UGNzKytZTWlvVkxZMlZRU1N5NDdaWlh2ZlA4b1Z5SGllanRrWFdMdVlreCtE?=
 =?utf-8?B?VTRIajBEaUhXZFFnVTN1WWtZQURKUFhEUU1tYXVxL3MxOXovaDFYTS9BWjNq?=
 =?utf-8?B?b001TDlteUFnZS9XdnlRRnRuaU84akF5QkpWSGJRM2dFUG1kTWsyYUhYRncy?=
 =?utf-8?Q?Gxy/pmdD5KoVar7oykeCjcZh+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b892071-76a6-412a-cafa-08de00eda811
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 13:23:06.2150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/Dr0NzUeM86cm7+cPjkSW0PBkeIDbNMtP4GgGp7U7yHQZycnw3mLqoFc4BDO9PRGV2W+l6eJK+Qnmb1UaSQZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7227

To prepare for dual-channel phy support, introduce can_transceiver_priv as
a higher level encapsulation for phy.

No functional changes.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index f59caff4b3d4c267feca4220bf1547b6fad08f95..b06ba42854c194b5aec1ca1a41db2c65862c4529 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -23,17 +23,24 @@ struct can_transceiver_phy {
 	struct phy *generic_phy;
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
+	struct can_transceiver_priv *priv;
+};
+
+struct can_transceiver_priv {
 	struct mux_state *mux_state;
+	int num_ch;
+	struct can_transceiver_phy can_transceiver_phy[] __counted_by(num_ch);
 };
 
 /* Power on function */
 static int can_transceiver_phy_power_on(struct phy *phy)
 {
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
+	struct can_transceiver_priv *priv = can_transceiver_phy->priv;
 	int ret;
 
-	if (can_transceiver_phy->mux_state) {
-		ret = mux_state_select(can_transceiver_phy->mux_state);
+	if (priv->mux_state) {
+		ret = mux_state_select(priv->mux_state);
 		if (ret) {
 			dev_err(&phy->dev, "Failed to select CAN mux: %d\n", ret);
 			return ret;
@@ -51,13 +58,14 @@ static int can_transceiver_phy_power_on(struct phy *phy)
 static int can_transceiver_phy_power_off(struct phy *phy)
 {
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
+	struct can_transceiver_priv *priv = can_transceiver_phy->priv;
 
 	if (can_transceiver_phy->standby_gpio)
 		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
 	if (can_transceiver_phy->enable_gpio)
 		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
-	if (can_transceiver_phy->mux_state)
-		mux_state_deselect(can_transceiver_phy->mux_state);
+	if (priv->mux_state)
+		mux_state_deselect(priv->mux_state);
 
 	return 0;
 }
@@ -108,6 +116,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
 	struct can_transceiver_phy *can_transceiver_phy;
+	struct can_transceiver_priv *priv;
 	const struct can_transceiver_data *drvdata;
 	const struct of_device_id *match;
 	struct phy *phy;
@@ -115,20 +124,25 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	struct gpio_desc *enable_gpio;
 	struct mux_state *mux_state;
 	u32 max_bitrate = 0;
-	int err;
-
-	can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy), GFP_KERNEL);
-	if (!can_transceiver_phy)
-		return -ENOMEM;
+	int err, num_ch = 1;
 
 	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
 	drvdata = match->data;
 
+	priv = devm_kzalloc(dev, struct_size(priv, can_transceiver_phy, num_ch), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->num_ch = num_ch;
+	platform_set_drvdata(pdev, priv);
+	can_transceiver_phy = &priv->can_transceiver_phy[0];
+	can_transceiver_phy->priv = priv;
+
 	mux_state = devm_mux_state_get_optional(dev, NULL);
 	if (IS_ERR(mux_state))
 		return PTR_ERR(mux_state);
 
-	can_transceiver_phy->mux_state = mux_state;
+	priv->mux_state = mux_state;
 
 	phy = devm_phy_create(dev, dev->of_node,
 			      &can_transceiver_phy_ops);

-- 
2.37.1


