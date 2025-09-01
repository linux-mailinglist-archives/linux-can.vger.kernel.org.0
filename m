Return-Path: <linux-can+bounces-4406-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E69B3D72C
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 05:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221B53BBB83
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 03:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6466E226863;
	Mon,  1 Sep 2025 03:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="khT/57fl"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011001.outbound.protection.outlook.com [40.107.130.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A921C9E3;
	Mon,  1 Sep 2025 03:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756696754; cv=fail; b=iJ2C97+TWtQwLuu0jBh58WrsaqoFJdXVFDGqJnZwzJM1Sz9cW5bh/24YTJ5bXmPqv4J8Lhozb2vka51pFZvClHBUwM/rsAeBJ5KjnfpcpCR+8VfZRx0QpEi1h+kKq9XvNZPhDX/BVEUa3ZU73l7SvyCazFD1dOyJqqU4qcEUTl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756696754; c=relaxed/simple;
	bh=gwYAoI63G4t5m4cNemzDZqyMtsvawPjOsIwclvW3JyI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kFrmysCMiZNpuXtkxcsqEuw5JQGF30lVjM+Z8kFEkZjpBOqiyY/1bJgD85LnH1DVJO+18kYVXKq6zWjPaGC8YidQrTWzmTIClqzSK28wL57XgFlaEoxUcjLZd0Hl19v1edjMwlZm5AyUm7bF8Sl660+Cs/7nNeytzD3r6YU2ues=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=khT/57fl; arc=fail smtp.client-ip=40.107.130.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4Y2jhgwzSdoHOiTJN7ob2+dleOq0wifLl/LV/qqT/KFRlJbnHfLjuGAnHfmbjfgFzbxR2mP0JO8ZVhzPHbmu415yCoObPoRRdfjuSF/TqNMqkG+1rvZp1gcDPAXcrwGhct/BPKR+In8X9dZ25tfZnWucnD35MSmxluUE13Mne+OFFGihYvGFcQKlw+qeyCxrsmPon0H3g1c3H6rCNvGZGOVi5peDGzRuBIYeVCBQJNeM89DSMPq9EGCtO06QBuYebVk4KrjsLGcTcsvoxhhKOLYg3sx5avweJcEsFLcml4oJEGctbeZnCJzgYhkczQnW+FrYoV+Xpf7fqaVONcL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJGsqDseOtrXvlkPOas7D4KpqFI0ZXkMojqpv4q8twU=;
 b=JWMxKXOIh3QrBN3R9WDq7p5A9LpsGl6m1kBvYKvYsXiuSiut6H20hKY92hOfAPKS5Q9gzuKbD9xZoVMJHgoZ9/Vb7Y8c8zRz4ZLFgMmYZgD+pUHT6u950ckCDBzqeN4mrzJcgWOr9gSQc8+x5pnTA8o5ui8Z5zUVNrSnVTdIz4p4fd3uf6H9xvkjUP4Vw/XMqqIFtgV+Dmq6oq/qmlaTff1iJL4ZJeXw2nV9Ik5hlCQaV+xRwl6ifztg+cxFjt0xqlGEG7vwxZeb7gXo0g0Ta22g/7l3WofguWLfAFOiQdkEs2Ktvnbx08ujiFchWICcNHIKvDgppwkVx+/DsVr/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJGsqDseOtrXvlkPOas7D4KpqFI0ZXkMojqpv4q8twU=;
 b=khT/57flLjKTki0QW60fGt/Fz42KnN1j1g52S1wCrzZtQuRrFagXoqiy1uIVeD57ORo0f8KHMe4ahhq9UDErK6MiAL7dd1MMlnIufR7kbpIj/jQg5qHAncie7ImdkNHsOiU3oU1FtpC/nvwx037/NJJoDPwuShsy0rgAZoDxIGPukYAeDPXn9/pHbJqg5Gc58mP8TdF5g5Yw53vAefvlFk7lu26YijrdDiFUU5PYTBmZxT4E67C57N4oFKLPfPoYmnVHbs9VmDz3Udzno4p1G9fzSVVB9ZTraAA1YWAqcJnwnGHgqR+cLqR/7SkmrilI3Y3sdZ1jYzPMQvPWAXhE6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 03:19:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 03:19:08 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 01 Sep 2025 11:18:15 +0800
Subject: [PATCH v4 5/6] arm64: dts: imx8mp-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-can-v4-5-e42b5fe2cf9e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756696709; l=2835;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=gwYAoI63G4t5m4cNemzDZqyMtsvawPjOsIwclvW3JyI=;
 b=2/bX1NpCmFf6rzdH6JxzKcYAI8p46mUsIy6AG0r4U+zMRf3mBjfkq1tUBTpURR7yoJHImBs7l
 LtlsYv4oNCgCOajnVqr6aH6mFa6onrS0mjp6OAS+inVP42BLiy+c3w7
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
X-MS-Office365-Filtering-Correlation-Id: 7cbdbba6-8c61-4459-57a6-08dde9065012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d05PdDNPakV0VEJnTHJBTW9BSmFBT0gvK1dYTmV0dnpZUHppcnJDcm53L1Jv?=
 =?utf-8?B?OWJFWnFGQzQ5QStJYW5nNHVMbUlyR2RYVmVBTHVyaU8xVXR6aDNlVmNSWTU4?=
 =?utf-8?B?TnpaL1dNRjlUa3g4OVYzK1V3WjNmTGpQajVoYk9NRWVIcmREeXpmQmRRR1da?=
 =?utf-8?B?WWhUcGFMcmRJbm53NXpBUlRWV3lKSVk4RXIrS1YwODA0ZTdBVkVnOHdXeWt5?=
 =?utf-8?B?VjEzNmJIcHAxR1lCNUgwZktzTHozWVBqeVZQQlhjTk5QMXhPV2VkVEsrN2V6?=
 =?utf-8?B?YloybmZLK09lNTF2WEM3dWRwK2gzSzlDOEViU3VRdnUxSnQ4cmRUR1BNc3dL?=
 =?utf-8?B?Si9zVGo1eWJMeFhLREtkOFBUQkZ4RnFsWmxXZjZPcXNXclJYQ1VzWkVscW9a?=
 =?utf-8?B?bjVHL09qUVVsSHExdjU0dmhmNXBwRkZOTEdmekt6d21ZSEFCYTM4ZklxdUx3?=
 =?utf-8?B?clV3M1J2QjVYMWtVZFo1L1g4VnBmTk15U1NkeUhjUm1RK2lnZTVFS2ZjQTZK?=
 =?utf-8?B?cGFOOUphcnFISFQ3SXJ5OURONjZTelpqQTdlRHdTaVAxQjM2ZGsxNnZuakYv?=
 =?utf-8?B?QjdwVjZ6elRaNzdPbmxNTVg0Y0JHMEJqMndwWEQ1WGNpRmFEZloyTE80eDdY?=
 =?utf-8?B?VWVSNGpYUkZhQzlnOWVjaUJ2SExEakJEOThwbVlRbTNBWVZrUkNpWWJYM3R6?=
 =?utf-8?B?L1BFZXBJZGJyYkJWeTJndXc5ZU9xandDSXRoeWdJdk5vdllFV1FMdTJTWEha?=
 =?utf-8?B?eml2ZjErTmErZExSNHlBeENadEhLWkJXeE1TVVdhbDR1OWRTMnd0QjlyUmdY?=
 =?utf-8?B?RWRLQm9GNGViZnN3a2pMdmpaUjVUL0JVOGNMQjN1WE4rSHpqaEN6eVFSZHRI?=
 =?utf-8?B?bmxHbHVkZksxWUd6K2REQnpTN1Rhc2xncERsalNTY0lmWUYvZGx5a1dJSDdF?=
 =?utf-8?B?OGlXRFNYZ2dFZ2FQamMvV2Z3VlhxcmtvQnkza1JWUzRQMk9yamRCMlJJNU82?=
 =?utf-8?B?S1BCQlQ5S25tcWkyeGI0dXZCOFY3N0hwV2RTVkFwQlFEUXNQelNjaEcxRndD?=
 =?utf-8?B?OHJ4QWEyZE9ic1ZvV3V6VXBzVXB5dDNWYVU4Rzk0UEh1KzVTemlYYWNLT2JH?=
 =?utf-8?B?NG9LNEZrWjNDUTE2aTJTN3FGS1dNTldaK2xGblRGWDZCNHJuSEF3WmZsaXpB?=
 =?utf-8?B?U29IR1RmazZhSzVqTTZpTUhlYzRSUTJVQWNaS1hsdnJpSHRvaHhDOHZmM1da?=
 =?utf-8?B?Q083M1ZSUmNOaVl4RWJxNzhyQ3lkUDdqdEwzdnVOc3hHYTBCRTlYYnFUY2x2?=
 =?utf-8?B?WDZadDA2angyRUNJWHAwRVQxT0RyaGk4Sk1jY01KL20wV3k2L0UxRDQ4S0lU?=
 =?utf-8?B?QnZ1U2FYeEJ0eG1NdjBmTERVOFdVTmp5TVhHWXQvMXFpdFRucXFZdENKR0Ro?=
 =?utf-8?B?SVJYOWxRZzQ0dFF0TVNoZVE1TmZYSDVkZXFmVzNyUmI2dk5ZbUljQVdIa1RY?=
 =?utf-8?B?TVN4YU5WRzBaNWZhT2FkSEc3Y2FDZk1zaTRXUXU3Rk96dlcxT0V5TGpiUmVi?=
 =?utf-8?B?Q0VHb1BpMmRrT1A3OE1UM0EyUDAyUk03ekhzV2R1RzdQZGhQTXlhYkpSZnVN?=
 =?utf-8?B?V1F6d09VR0JwUWNocjdZQTk0STR6d0ppblRwMkk2TzRPZ2lGOTlIY3FicitP?=
 =?utf-8?B?Y0hSVUMzSUVyRmhwdWxleUNaaU1ZYTR2ZVpqdDhibGFFZ2dXaTFud2QvTmkr?=
 =?utf-8?B?am5WdFJnOWhjZU5rTjIvRWIrQkl4TG1Ld0QzT284ZVVFTnQxNUEzMElUdi9W?=
 =?utf-8?B?K1dCazdkcWJ5QXNMZE5lSDhOOHdpeGg1dFp3bnF6dU12aHJrbmRNSVFhQmFo?=
 =?utf-8?B?bFlRVnRkdnJmNCtnMTF5Z3prYWZESVdHaS9tTW9CWGpPSkVqbGI0Ni9rZVdY?=
 =?utf-8?B?alpIMnNLb04zM2ZuaSt0OUNuYitqTzl6U1g5RnZjU1ZyS2k2aW0xeU5VR08v?=
 =?utf-8?Q?IwhK4EQYkBakyZi28jDY5IplHa9+SY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjdXVndhdzJmNWxYeXJYN0NOZmFMUTZxZXFtUmR6bGd0ZGJrL2JKRXlXVTZJ?=
 =?utf-8?B?L1pmSisyQ3hoT3RlOVJTMTR6T0gvZS93TjV1aldKZzRCZDBKcnR6aGQzclpR?=
 =?utf-8?B?a1dYKzF3SERCSlZSbm1oR0NOVXdKWmpiM1J3cXMvdDhKdHV4MWV1enFIYk12?=
 =?utf-8?B?R1R4dXd4MlFrVWQwQXUxNkRoY3ZHdDNVYk1ZQzB2WlJiVi90bzRCWSt1UkI2?=
 =?utf-8?B?NkZuKzNkZ1JxSEo1Zkw5WEdmTmpUNFVPeTBwSW44K2pmNlNLNFJ2Q2NMdkJF?=
 =?utf-8?B?WEFvN0VhL2JMZDEzRkNxL1VDd093QXFOTmRFNzNrYUMwOFMwWUxSdzRmc2hP?=
 =?utf-8?B?Vkp0U3lXN0gzWks0ZkZmeEMxQm1jV3VQNFlxQlZBbzVvYXl1azkvazAzdXZw?=
 =?utf-8?B?YUpPQnR3dkxJemx3ckRVcmFLZ3pFS0RMRE0veXhFYkgyYkZMdzR4R1pyeGJo?=
 =?utf-8?B?dWo4WUJ5VHVGdGVFRkpZL2JBRDlzalYza0RoOGMzK21wa3JTb3JVSVc2SXln?=
 =?utf-8?B?MnF4Z0ZiVWoyVmwvQkR1L3NkZFluaTBwTnpvWktDc1N2VzE2cjlpV1kwc2hV?=
 =?utf-8?B?anROMWxndkc0S2Qxc3ltRmYxN0pUK1Y3eXg3bDNKNS9sanNHZk5TOWZzeGtU?=
 =?utf-8?B?djE1U0UrRFRpR1NMaUcycXZXTll2QjQ4NUZ0L2FNeWc0UUE2TkxFajN3eVNp?=
 =?utf-8?B?SldUek4rMHAybk1MUDZBdk1XNndENEI5QTQwZG1aWXgrZHB1QlVHNEdPRGJi?=
 =?utf-8?B?OHhsUzFKWUZkOHByeDMxVVVsb1hOcjhqYllqOC9XODltY1dlZmQydUg3YU5o?=
 =?utf-8?B?R1dXem1lK0tWaWh3VGJBN0c1M29uUEExbXVWMnlxZ09TTW1wWk1lMFVuTmJL?=
 =?utf-8?B?Ny9ZbXhFMW5nUzFRTDhWQUl1Z3JuN0FmZldnRW5qb1BMRmR4VnRYV2dZN3Fy?=
 =?utf-8?B?VktEaFFXU3ZRcVhMZ3pzeTJlaU9wamxGSkNjcWtrbXZ3YmRPYWs0eXowQkZM?=
 =?utf-8?B?QXlTUXVBbFNRc1cvQWVRRTlmZkdONlBQOUpVVGtKZVgzWVBveDBxNHhqOE5C?=
 =?utf-8?B?TXZSSGNVOHM1U0F5V3VMNVYzQm5UcnRkVnhCbko2UllwSGs3U3oxalFuRjRC?=
 =?utf-8?B?TVZSbFQ2RitqWk9FK05pMThiUFliVzZEckVvNzNvNFZydXJQQ3RhV3daRjJJ?=
 =?utf-8?B?aDY3MUxmQ09vYWxkUllBQ1lnZGlpTXhRU1luZzNJZkc4eUQ4NUppNmcvM2Y0?=
 =?utf-8?B?djVaZUpiK0M3aTQzZlQ1NGhUQWVzN2t0Yzg3cWFZdEdJZTJJNFY1SitKNEcv?=
 =?utf-8?B?YTFEYUhUMkxiMkxkWjgrNnhrdHlCNUR4RU94UWpKaC93SXJ4TWFOV09oaTRs?=
 =?utf-8?B?MnI1eTBaN1VCMXFhRFBQc0NaREJLZUpFMU9DZC9MeU1VU2lpdUJpN01PYmVj?=
 =?utf-8?B?bldOandib0xIS01jSHNaY2hHNGtWTFZQcVg2WXpWVUx1d1JKUVJpMWQzNFZr?=
 =?utf-8?B?bVBvN2VqS0JBTVZXZ1RpZFZnVzlaaFJEWmJHZ2pDdU5LMC9YQ3U2WEZCaSsx?=
 =?utf-8?B?b2ZPaHA2RnlTWk81T1NWcXVzVGtLd1VkVE52QUxOcDdlSlVvU0l1dWM0aTk3?=
 =?utf-8?B?RU9PaU5mbmhQd2VuR3RQNDYxUmpDMFIvNGRycDVHWmIxTUxFSnkrT1M5emJw?=
 =?utf-8?B?bjZqeENNdVhjclM1bVFya1RCaHg2L1p0SFNQWjNUUks0c0dYclhtUks5NHYr?=
 =?utf-8?B?dWxkVkJsUGtTSGlrZFgzRnBjb01BdmRPNytQejQ5MWYyYkEzc3k0V0NaZ0VQ?=
 =?utf-8?B?bkthVGluWi95eW0vdlpGOTVIalF5N2g4Ry85ZE9DaGJ0OE5YRjh6MjlvNmFY?=
 =?utf-8?B?SXRLZFcwRENvRWswZ0RnUytFMEYyQUNFaEZwVUlKM2w1dEFCMWtqT3VSa0hv?=
 =?utf-8?B?dWlyQmh6QlJuMEx0bVlMTUsxc2pWYSthQk9sbW1BV3QxQUcvdEdML3Rab3lE?=
 =?utf-8?B?UXJyVCtudUU0QXhyd0VxajlTWWxpZTJ3K0ltYllwZEFpSlI2Zmw4ZEJBb1gx?=
 =?utf-8?B?Y2taeU94SUI4QXpVejN6YzBBL0Uyeko0NDltamozUUJldWRXdDAwcUZOWGl5?=
 =?utf-8?Q?LjjwT6Ken8w3f3OwtNOC03h4Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbdbba6-8c61-4459-57a6-08dde9065012
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:19:07.9843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UJLy+4AcT6fWKybA4bs6HPgGUbpsMVj2yjWknOYmDxXkn1wI8ihLKvNMT+eFMYcoRuRsyTy8yn6MihN1Izxqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

The TJA1048 used on i.MX8MP-EVK is actually high-speed CAN transceiver,
not a regulator supply. So use phys to reflect the truth.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 43 +++++++++-------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 3730792daf5010213cbb9f6869a8110ea28eb48a..59891627dc462d37dfd620eb68b893546cc20d6a 100644
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


