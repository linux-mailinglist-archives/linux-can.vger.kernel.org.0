Return-Path: <linux-can+bounces-7031-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IX3FFAbr2lIOAIAu9opvQ
	(envelope-from <linux-can+bounces-7031-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:11:12 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C758123F496
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B95E830C097D
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DB83ED5AB;
	Mon,  9 Mar 2026 19:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EStCO+/Y"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5213603E0;
	Mon,  9 Mar 2026 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083356; cv=fail; b=XiAoXY8y3PCYQ+xitXYvVX6v7UDJ+QwSp65EH6AaMX1d3NGa28XUJc1wPYmk2iCngFN0ut6VwgaSm7r6vvYiwkF2r6U29t/sAScp2AfdGFbLn9u61ZnQJfE5QWS8+gzjyl7rHIWmQcHhGIrwTFV1sbIYWcacxYuVOyF2xnmqJEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083356; c=relaxed/simple;
	bh=A3jbPGwFbnsqoKU21te01mrqiTzWMWnS1zF0Cfhk4UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T0mmQ7WhvauoFhx2Qig0CO2btoxNjHPPjNC1PJcCAIVjzV3rrk3XSHNbG4Bz7CEvobhzwsOh6YQ+a8UBGHfgme1SHvOHa+LipQyp4FOplgVE+qgPbXuEoobnw43YwcHhysYgpnN0KkCN/obDVZ1mi2wvURga1pvwFXKajEpmQ54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EStCO+/Y; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKc4+QMwaXsPT/W10pi3KcHqAW4IDuNjWiu1eh7//bVjA0u2fc/sl7NTtB5uQYCwuw8y1KYB7yhizt48oIHMLXD8u9oEGhXwK7rcPLw9bYfsTmRvvVIGbI5Oy6OiSGic16OPZZGKoUF9Dpe03sGX0IJ9cqnu9/2Z0BODbplmxss7c6YfdED1XPTShTjXvB9UWGH9aIwOI6M5OZnQRzwos8DPdti0zz5/7i1Ao11zWdU4tupnCi3t194OGIjjxDNosSF/R0cWBb8oBA01Zx7PSJOqPHIHrSes+c4M7XUdFfRqiCJ5Ej08bB+p1fCiyd01q7+prg666IxmJxSXnHQAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8g1cryLcRhbUu+1Vft4PZlDqgDG4cnCWNfGGum/8Ec=;
 b=uBvqCwc5pCeEl9jt9mJUpRhWDT6myl6qo2e61uo4ZsMJU3fZMKs+QyW9Ge+dHdOEHD0DdcG2b115b5R7YnHnuU4xDtHLyflNqUqsz53w8rxHFZ1yPOMoY+IKvFnSY3VsYUf5CT2Mdsp2hsgM093zqjTvcSw736C1/zGX5RhZhd1SEsGbXZpQ0rIzvZl0vzSRvyhj3BruiUSgAuNkdVvzeLXHyJlau01944CSmhjQTmwa6f0oVVcT8zCaVnpmZow3pH5jnqVWG8iKdCBSb5LcnxuEBSy0y6o3vbfDNK0dozMZIba7yED5eQHXjLibogw/nDuAxHnzM9GNlwbAHZWDFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8g1cryLcRhbUu+1Vft4PZlDqgDG4cnCWNfGGum/8Ec=;
 b=EStCO+/Yem+mF2K87lHeSl127xytQFQbSWTC5cYRFSR2OF3z7vsDDZCfHfF8+9VayaYDyL/3ZOogs3ibRv31BhdBO4NdJd7z1xZBBAV6dcqvaCVL6T3oALR81FQHmddwToUMd27PZTCaYlbvpR7Q6XjF8f9IHvOS9JBGg4qQb5AKccg3qpXGEJ75CGwZzVFimrIkekf+00fnBmU3yT6nDF71eRMFR0dhwegqCkirPAsMtCEBqtMOxWe1NLkq/464N0QQ1GXdUtGG2YcTymLvC0/pyYBHg/FnnQdiQpq150LrMi6OQiQgO5t6i1Q5aXJMnTqopjeWa5Sg4tqAYh6y2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:09:10 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:09:10 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Yixun Lan <dlan@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: [PATCH v3 phy-next 02/24] PCI: Add missing headers transitively included by <linux/phy/phy.h>
Date: Mon,  9 Mar 2026 21:08:20 +0200
Message-ID: <20260309190842.927634-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0502CA0029.eurprd05.prod.outlook.com
 (2603:10a6:803:1::42) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f730e9c-69bf-4915-d125-08de7e0f587c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	xp+FOUhSln2uDcdtm/VbdNZKjE8eWPeKVVcFoiOEJ4hFTDi94uciU9On8nQKWt3JXJpC+C3f748eq6sRB9I3sca8/poPcNNpPn/DDM3gRDGBJJfuadTK88IuW4hB9WGcO29zNNwh4nax6RJ0c1505sFx/G6bOIAo4O3qEWibu+AluOcduD1NXcbMYtMQY5rCTnTAjN4vgL9rmrk20uSCxtGCCwAgVajPHHszMaSEkdHTCUqzu1bBYRLjS9XtwNtsZb8D1rygNLaCoTB1SqkJmdD4ATG2w9SzWr3QZcELac8QKTlXPkxgxBdv5Jd2eYT74NBQba9WygOet0SAK8xRozBb0f0jt1wSVy9X2JBIbJfD9AbJzxLyQ/6BI1WjK3YFL65s3hDXIuMESS6LMugW9Z038JSA5E+kKLhouLDa9kqleuAm2sO/rm83tr31N6YcR5l2Hvoz17bdlDUo1aU6qB2yOhm+jqx4agY97DvrpmzN/XWVPBLtdL58D9pL1lSUTdcchQqbCp6ZQxbOVjTYRsP5K6M7c+G/1qt2gqi2udqt3ZIdh7N7b3U/QONDSk9yky5noo0V0ynEgDcThK+T28myAtWhpO0sGxdxRVCepwnnZ02evRDABLS7U/mZ4Hzy4RbUvKJiYBKoDAhdYNFCKmjv12ZVnknfll6fHS6/01DRq4NicSvcc1aExnz4tSLDcw5sgSI26xHGLMqCqSjMEsyLzvEP8BemqFSs9IaDF8c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWlxNVlwZFNxUThZMDc4Z3FjbUxOZzRiM0p4aW02VXZNcTdPZHQzYzdOaEJO?=
 =?utf-8?B?SHRjeFpZUzVvN1dtVkRBclgvMlRCZ2FEVzkycmFWWnB3QXpoWHAwN3Y1OWJZ?=
 =?utf-8?B?SjdxVXJZcXlPS1A4OURkbzZRbGlEOW1HUUZTWGpCcDhwK3R6bUp4R0dXNnpj?=
 =?utf-8?B?SXRFM1Q1NDlHU2JvZ3Jtc2xscDFTbjBBbFBkYnhoUTNzSHhQdGgrWVErRW1i?=
 =?utf-8?B?bEJSNnd1a3BaOHhmcXFJSzlJLzQ1bDRqS05SSTdQVzFCakVVc1ExcUN0Nk5L?=
 =?utf-8?B?OFdQT01tTTR4eTM0dEk5NGRJUENuc3BIVlJ2ckwwUlVTRTkrMEQrYSs2NUw4?=
 =?utf-8?B?d1Q1QTJTVnZEVUpIR3BtRnRQVGhveTdlSG9jTUFpRDIrMEs5NmxxWXhua2s2?=
 =?utf-8?B?aWMxc3ZOWm90SUtlYXhWdDVkekk0Q2NEM3ZZd1pBNUJDTVhRSUh6QlppclZv?=
 =?utf-8?B?MWVzNmhEckdwUkRnSXJjRnE2OWlrblBpNSs0RDczVVZSSmRMQ1JWYWF2L3Za?=
 =?utf-8?B?MitKMDVyZS8rb3NHL0srTk9zdUhmeUF4bzVob2VmWTJqMVlJUURoMHE1a1gy?=
 =?utf-8?B?bUNpeiswRk04TERHcDZNRkd1QkMxZkNJZyszNWc0bS9Nc0lSd2RsM1ErQTZt?=
 =?utf-8?B?QzgzZTBWTnFiSitLaUllZGdWU3JLSzBCZ0Q3REJXcTlTMFdzcDcwU0hWZW54?=
 =?utf-8?B?bUhDZFpFd1ZKNzdadkZwOVBYejVIMlhiejNGY1Q4WXFmRXBpWXFBT0F3QkEx?=
 =?utf-8?B?a2M1WGUvQUk5UlY1UzhBb0pCcWNGWUFCaG1CL3kxVTJmL3NRZ2F0M0xLdjUz?=
 =?utf-8?B?QnhkeUJVZjgyRlRSTzZ0MVM0RDFMNmpPSGE3ZTlac3FIdkZjeTYvTE41WEpD?=
 =?utf-8?B?cTIvQS9QZEJUVFNiWGhuTEU5TDNWV1orVEZ2am9VSllUQ1VUSzRDbXBmcWwx?=
 =?utf-8?B?V1lsRHR4Qm1BdGRJWVNNMkRXeGlKOGRVdHk3WS9nL2l6dTlaYWN5NzlDSW9E?=
 =?utf-8?B?RVJBcFU3SFAySElOa0F4Q014N3dLWkFKSWZOMFJoTnpKTU9PZHZ4QWJLcUhO?=
 =?utf-8?B?Um5EeEgzYlNSTjVEamlqU0FjTS9oVHh0SVN3M0dFazRWVHp0TWJ4eGRzc3g3?=
 =?utf-8?B?UE8xVGtVQjhsZ3QxSjllM2ZPWUJUNU5pcjFjVGdHZ0FBUEo1QldJMGZFZytu?=
 =?utf-8?B?QmFEVDA5ait0djIxS3pvODlMS0dUTXpyTEJuenlWMDljZlZGMklvaGJuREl2?=
 =?utf-8?B?clZQMWR0MmE5TGlTU2xPMHFkZkY2Y2NBM01WZG1nZHdLZXRNVjFZRnlrd2hi?=
 =?utf-8?B?TnZaMGF1aXRFd3ZyWTExdkZzQUs4M3BFdVFsaVRJNUZGMitrOFhlQWNNQXoy?=
 =?utf-8?B?aWN2elVjTnBpZWlaMzVPWkNnVWZubzBvSUgwNFBBVE1CamhaemFSb3JkQ2tF?=
 =?utf-8?B?MUdralJ4YlVEQkVOaEUvU0NYZEJxZVlReGN5YlY3SzFlQWRQeG40NkZwMVdF?=
 =?utf-8?B?YllYZFNiekdTUnpiaXQ5NUpBa29KWlVaOG4yQjhYVFhvQ2p4TmI4NmFsUzJ2?=
 =?utf-8?B?Tk05UTNXY3RsdmVybm83L3NCeGJTNndFQW5YMk14ejJpREhIcEJrTXlrUjkz?=
 =?utf-8?B?ekdyZXR1b21jZXhXQWx3NGxEbWRjeXh0cEZGTjE2RWRGL2RUcUYrdWtaVkVt?=
 =?utf-8?B?THd0YWxYWm5pLzVpRDg1eXVaMUVnWEZMRTVtNTR1Rmc2QWU4L1VPUkU0N1Jn?=
 =?utf-8?B?NFB0N0NicmprUVlGeHZRcjAwNjgxeGhOTWQ0Z0pNQ1A2M2plb25EYlZFN1d3?=
 =?utf-8?B?dldYTnZXUWFQd01VREkwVmIvSDdGZUx4dFNZdllxbW01MzJDMmVhdm4xNnZF?=
 =?utf-8?B?aWpkUmZiMk9oek5obTIraStIUCsrb2JkRi8yblY4RC9hb3prUmpEMUlsY3JK?=
 =?utf-8?B?N0NhWEkxUEZqUmtRUDhtRnVWVUw5OWxjMFV5UlVyd01oN1o4bFg3MDZUdjls?=
 =?utf-8?B?WGxzRkc4MmFtMlI0VlVMZDU4eW5Ma3RRT1A0SzVmd3J3NXNtTkIrNnpEOEg5?=
 =?utf-8?B?VllSS0VLQnVaNFMxVVBadWN3M2VqTG51VjdJc29TaDVnZVFtYlVZRVpFZGlo?=
 =?utf-8?B?dDZISkJJWE9xQlVzSkJRMlFFYXNDR3lRS1lIK1Q1SkVoZnNybGJtS2d6VC9m?=
 =?utf-8?B?Qk90SDZodGpPdU5oRlRPOHpwK2p3RkNpbkhzVWpITDB4TjJkdnpYQ01IbW9n?=
 =?utf-8?B?YVpwWFBabHY1bzRoeVY0RDRtcGx3L0dsUUdGY0ZFN0RVOVRZdHk4MnJTdkla?=
 =?utf-8?B?ZXZldWVPdmVJK082aWoyQm5mQm1ENkwxVmx0Kys2Sk4vQlhwR2M0WDF3cVRP?=
 =?utf-8?Q?Ry/zbwotJjxqm9Lj15IdKgia1bzKNBc9L1hckbBEVcDAh?=
X-MS-Exchange-AntiSpam-MessageData-1: 2qvegL2lNJhmgw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f730e9c-69bf-4915-d125-08de7e0f587c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:09:10.8655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8U8yIL7UykR02lnWfaR22SFMOLwuWA0fMwT8vcPuKP1dvK9MbVA0YQMTUON7K4bDb/Wl75TFLF2n8swwJLUYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540
X-Rspamd-Queue-Id: C758123F496
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7031-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,google.com,sntech.de,gmail.com,nvidia.com,rock-chips.com,starfivetech.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,rock-chips.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,sntech.de:email]
X-Rspamd-Action: no action

The tegra as well as a few dwc PCI controller drivers uses PM runtime
operations without including the required <linux/pm_runtime.h> header.

Similarly, pcie-rockchip-host, pcie-starfive as well as a few dwc PCI
controllers use the regulator consumer API without including
<linux/regulator/consumer.h>.

It seems these function prototypes were indirectly provided by
<linux/phy/phy.h>, mostly by mistake (none of the functions it exports
need it).

Before the PHY header can drop the unnecessary includes, make sure the
PCI controller drivers include what they use.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Yixun Lan <dlan@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Kevin Xie <kevin.xie@starfivetech.com>

v2->v3: none
v1->v2: collect tag, adjust commit title
---
 drivers/pci/controller/dwc/pci-keystone.c     | 1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
 drivers/pci/controller/dwc/pcie-histb.c       | 1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 1 +
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 2 ++
 drivers/pci/controller/dwc/pcie-tegra194.c    | 1 +
 drivers/pci/controller/pci-tegra.c            | 1 +
 drivers/pci/controller/pcie-rockchip-host.c   | 1 +
 drivers/pci/controller/plda/pcie-starfive.c   | 1 +
 9 files changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 20fa4dadb82a..642e4c45eefc 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/resource.h>
 #include <linux/signal.h>
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 5b17da63151d..e0079ec108ab 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -21,6 +21,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
 #include "../../pci.h"
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index a52071589377..432a54c5bfce 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/resource.h>
 #include <linux/reset.h>
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 18460f01b2c6..e417122da51d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -19,6 +19,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/module.h>
diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index be20a520255b..dbec159fd458 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -15,7 +15,9 @@
 #include <linux/mod_devicetable.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/types.h>
 
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 06571d806ab3..3378a89580ab 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/resource.h>
 #include <linux/types.h>
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 512309763d1f..a2c1662b6e81 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -36,6 +36,7 @@
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ee1822ca01db..46adb4582fcc 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 
 #include "../pci.h"
 #include "pcie-rockchip.h"
diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 298036c3e7f9..22344cca167b 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include "../../pci.h"
 
-- 
2.43.0


