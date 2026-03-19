Return-Path: <linux-can+bounces-7187-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMIZBJR9vGk1zQIAu9opvQ
	(envelope-from <linux-can+bounces-7187-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:49:56 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8896B2D3C75
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0704432B9600
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C684279E4;
	Thu, 19 Mar 2026 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mc83rNQ+"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48364421F07;
	Thu, 19 Mar 2026 22:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959618; cv=fail; b=YZ0WJIa62axhvRVu0Ml0EoorbDKC4uGEUIyLzSNNjqh4rDMoJtPADGIU6YThr7+Dwb9FSf2zydfVfenJ64tuZ+v5epY4qeQ6egzqtAoKWJn0GHG/SgTRhJKDUFXxRL7irUvOPcSKc61PsO1aapaxp1p/FDrx3T4q2RP7Lbr//Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959618; c=relaxed/simple;
	bh=jsNsXabiluOF4NFzuFnPi6YlDqwfSL2lVV/s73vyEw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o+rXHTIPAK66pV90TAxCKDH4OzoDifd76iy5ZhuDZwPxlzfejWYkhsYH+BrCsbOAotqspsj68DAGIYYzKXaoFRlCxnA5cVr7y9fVuYq617IGoWaJolMy7GyadPqKif3EYtZwYtokJXWFiBq4+WcmITKF8ivZEwPLtnZRqoONyt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mc83rNQ+; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSaCS5CYbN6Uh1L0PgEEV6iEUmh/zLEV9eI2VAT+6Jm+4SDujBTeQhf48pILTL7aD4ZlAmVMRxlONm5ScFupVef48ARTiuZsSreOROiKO6wQ/efSeP1BIVQdt9tpaXF6nZBYfd/svpGXCyi65YyWsgnPJL3KRjLGJF9bwG3ni37Dt36bDVfvigtN+4W6/nJcIqiIvF58DlOeX6cBUdfJtikJOIOArnetrN7rY23/BoLZXMy6J/+u4zjItA5vSPoQ4T9uIIZ4STJzS2LUVEFnRgqZi1n+k4XWprK566QTNr2RxSl1q5RSSq4aieBVPDBgse69TmjxqqS1mfr/GYiUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmByo8vP5R5ywxu3EV0K1L0EUI2yeBwe+fqBWhuBtkg=;
 b=fcaKuBAX6qsGulvN/+5wY0aQPdP0l8oK0ur6vta1SHSXcknrVz00Gg4VZGy9bCjHE+MlERMzt6dw0GgVW0CxpQpaMEHQJTb3Gxjf5/RKIXiNWBtHIRy/hsEur+Lp/5/kC5Y80d1CgEi6M2A2hcNLSMHY6/pXLoIgEi9dTlzv6RCgSYDx3s0qs3mPUj4LC/F56X+06BYXnUVTgWb9/uguW9gn+1APTbRQqiAahL08FEwy4PuukFLmMO11LoDW+h3GjJbY2bQf4OOi+3AGDrMonG2E8YnPtEMawxNFkEpSQCt0HjYGyaWlicgv6ugXLZIJZhn79/HoCX9+H5Bd4BS5Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmByo8vP5R5ywxu3EV0K1L0EUI2yeBwe+fqBWhuBtkg=;
 b=mc83rNQ+vfpf+p7KAyRBKN/VPL5j0A4A0cSupZKLiC/q2tbuiCi8FjOplI45Qc7/UyboH0XcjtihxNkVC20yJT/1/OzhC860xANTPeoBAo05Anh3jQ+kuE4jKFyCWhmW1BVWM0okinsrTo4Kp2EOs51lDGkpbhHD2ogcBAHkgE2jl4J9knAawsgTeSntrxuXRoF/Z5wGIWrOItleGU8qIHLFhv0LOiRKO630TJ+93UM9JQ7N/tVKOPPf/mLTj/G6UPxzgQN7m6X8CeJm7UdrYiah/0MvfCXE4uAsmrq7Qo1wQGDPb54KRdBfTjQlV+WQPCRwoHMbn4+LsHbT6+h5ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8079.eurprd04.prod.outlook.com (2603:10a6:102:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:33:21 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:33:16 +0000
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
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v5 phy-next 18/27] drm/rockchip: dsi: include PHY provider header
Date: Fri, 20 Mar 2026 00:32:32 +0200
Message-ID: <20260319223241.1351137-19-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0229.eurprd08.prod.outlook.com
 (2603:10a6:802:15::38) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f71c39c-aa80-4ee2-4847-08de86078368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|19092799006|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	q7wpKQvc05TUxqvezrHRwYf35/uJfSfHGllc9KA2FB7Bluel9frQYnQuu0x12cPP8FPypdDzElAyUjQzjaf7gEFsR1hZiTMM02kFBUBNm0oboTFPxFhLvsdRPOIJcMTJ1zammmvbvXK0YMl4zG1nR90zghYcVKAUkobIIy19NOPR4ZdTCBff6rNR8N6Ot4pjmAdTrUNvsX7GzPPAPAMEYu/IHlu8ZjsVNA/L7CFqLp06tFmwWuKZiB5juRwRpIpR8BwwEblFtI8pg7Tm0a8aI9oj78KUslc6zGz+Ch/5hUX3yL5WM0pvn34dW+s9eDVBn4XBbv7Q0BcuP5kLqC9qqiKUzCWId5cRkUQyo/ommIPRus3bb0huajDOb2qoMd3eynh0kCmIWF8h0nwiDAIykNxV/IoHWIJZBHLXykvOV+zbX0kfTfvDESqgWO8vWXrHWkKE5yEfhBBAcV/NYlPETLGkXzsT8NJvupOUFOl6JJkAe3Ct3gZ9H3ykoqI0NRvaKtqHAQvJQoG977bpMvZpQkbLsXWrKeeZgCUj89bh8gRRByCtv5VfwpWAY8cP7jYmBbyXGH6Dk77lOr7DsRCINDIKQK7CZ68R+g9Kv/WzP6lj/bW4W5jygVn85Wb4gzz9sA4WUlcOoAeOTw3vXBYXzWkKp7ibvkXnCSidOEpYlNeJ73pBkDCDo8xPYsRhWfV8Gy9RPGGB6X7mJphOxca3i486iytjoHKaPhoUDuDGWZo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVNMRmdHNHIxak9iTFIvSUJ6aEV4MlEvbjhFc25qWFZmM3lLZ0lhUFJtbS9X?=
 =?utf-8?B?OFBQcEVJTlFVcGQ2OGdkWnY0ZlJUNXBoL1RHLzFpZ0dhTUlWUDgzYTdoNXNS?=
 =?utf-8?B?dXcwSEF3Qk4rR1huZjNJQ25oV3AzRFh3dzg2WXhvQi9oWHdNcUVEbWlRc3hX?=
 =?utf-8?B?MWlGeE5CQmNydXI5MVMyUk4weFNsZnBRRGJvQldVU2FENjFJSThYUlNONmZy?=
 =?utf-8?B?VWtvTlFGWmh6KzNXdGhwYURDdXRnWHhZblhvc1ROTVRwek1BNk9DRmZFVFV0?=
 =?utf-8?B?eEUrcnhZVVJpeUtBTmtNbHgzM2U5STdmSzRSYzR1QmNNczk5YXN1d2dkU042?=
 =?utf-8?B?V1lrY1lTdCt5QjVKRUpjMWFBeHJGNHdjMlJYVlQzRjN5aFRVV1k2MzFiUHha?=
 =?utf-8?B?bXJCMGNmdzgxR0VWVlIvZTBkYWdoSXY3VlplNkpka2VNc3p5dXNrTnAwWEgv?=
 =?utf-8?B?S2k2YmlMTjZqWE9vczRkR0hXVzlUd2JiOGRNeXpnSVVWRzd6WUNMN09kUStk?=
 =?utf-8?B?cDNzd05CMWZmTVFjUEpzak9tYTNJR0d5VU5DT2Q3ci9CRFdEQnE3aXEvQXN0?=
 =?utf-8?B?QjFBTXluWlF3RUFJeUlmdG1TT3I5SjM4MjArbVhPSHhmdDU4NFZZcnNkOXYv?=
 =?utf-8?B?MVVZRkRxYjl0bURwdFkydEZuWGswNWhUd2VPRSt0MERuNzI5cDNMRUc4YTRi?=
 =?utf-8?B?NjQxeE0wU0hHYU0wVjhGcGlvckovaGRnT1FZSEJUUnAvVWhRaFJlZGpHSXFx?=
 =?utf-8?B?TUpJZ2hRSWp6V0p6cUlJdjBLeTl1YlFRMStlb1hBTTJnaDNaOE9nb1dSd2dL?=
 =?utf-8?B?ZDFFZnplYnI3NW1jSkxzMVBzME5YL25ZNzgramE3QUtnd25pK0pySzVCOVNn?=
 =?utf-8?B?dHJnd2M5Z0FoTzlPUUw4TnNmSSt1N1hrNWJLNXc2M2k5OXQwMEdYWG5MMTRK?=
 =?utf-8?B?V0g1eTNWQ0lLZmV3ampXc2hIcUM1WDQrY29NUlhIRG5EbnpyUFdQN2ZpLzND?=
 =?utf-8?B?bTZsZFE0N1dnaHpyTlhmRG9nb0pHc2t4REp2U044dnNYVEd3cXNSVXYvT0VX?=
 =?utf-8?B?V2V1LytPOEh1cy9BcTMwMmpGa2poU1MxaDl6TlFETGJwUTk4S1ViaTZ6QkpJ?=
 =?utf-8?B?Wm95cEpsYjlEMFpaV2ZsOGpmRlFybjViUGIrRVkzQ3ZXUWtqUTkwa2tYWlYz?=
 =?utf-8?B?bHFLeUpoYkE3eDNvSGdqL0o1U1N1eGlmTW83L0tzcHJFV3ZNNXBrVWNOOW95?=
 =?utf-8?B?M2V6YmNBWlQzZS9NTHpFTmNvcWE1Q01GNm9ZRmR3bjlCSkxHWEwwSTJKZnNB?=
 =?utf-8?B?MjlEak5lRVNPV3hCNnFtTlBnejgzS2o2eGI5ZzdIR1FydjBCb0xJYUl0TXV2?=
 =?utf-8?B?b0RCdWFYaHBucVNCdTJXOXdVTXhQcy84NnJQZTR3dDNLalBPWGRjYnh0UkNJ?=
 =?utf-8?B?WldMNTE3YnE4TGpHelJ5TUtIQlVBa2VRUFltaXV5WWd6bEg2ZUh6bTZpdFZC?=
 =?utf-8?B?RUNYRXZ0Yyt0QklHcDdBQkd0c1pTMjZiN2hSMWZxZXFoMThVL2czS2tNSWNa?=
 =?utf-8?B?UVlFMXROaGkxZjdWQyt4bHlocVArUHdrc2hXZU05ZmhaZGNSeVphdDFxeldM?=
 =?utf-8?B?cStRYkNrWkgwUmpaaURnWjBaUklOT0JEazNuMUtnejJselZmZ1l3OU5hWFNZ?=
 =?utf-8?B?dTNtK3ZJSTRsMExaYVZxbXNPUHNNcWNMbGJ5Qllha25ublV4MEluN0xLS1NR?=
 =?utf-8?B?N28zdUJabUFNeGJQSDU5bC9FN3hJcUczWTVXV2NDTHdNaHM4YXY4YUZJUVNs?=
 =?utf-8?B?c0ovWlBrenVsRk1CNE03MWx6VWovMER2RHFwN3Z0SnpVREZXQzY4RlNBRFVH?=
 =?utf-8?B?cUphb2hDWFhzME8yOUozUkZHcWJJNTgrTkIwR0NmU291bzJPbkpCTVBhSTRu?=
 =?utf-8?B?eTlDNHlFZzBudFpOMFpDQ2xZZEltUWtPYlkySDk3Ui9mYXI0dU9LdTFpU1ZE?=
 =?utf-8?B?REgrWUovM2tFaEZFREkzMUIyTTF1OW5BOExrRjZ1U1A1ZWpNSkY5NFY0UEhI?=
 =?utf-8?B?YVUyZjd2Yk4wWjVKTHR3cnAzOUJDMzVzeVIxbC9HVVJBb1EySXk1Sjhvbk9v?=
 =?utf-8?B?bXltWjMrTE5oWjJKZ3RJd1Mzd0tkaHhLZm5ybWxydUEyQXJEWmRVMTAvdDRz?=
 =?utf-8?B?cG54NjRsbkVkcXJWZ2xLVHFQWmZYZFRidkpqYktzV3YwNlpxdWpLWmxVczZv?=
 =?utf-8?B?aDBERVRtaENkR1BJZUQzMGRnZFRqbFpwSXVRZ0lVUm92dUFST01VSk1Fa01i?=
 =?utf-8?B?Y3NrdDh1MjhaeWFRUlQ3ekRWdXZEMmZLUC9EY2ZBNXFiVjFVZXFRWTdvZVVv?=
 =?utf-8?Q?JS70Ite8uCNSktj3S0XT/IZee8VkETaM5OrLjSyENACin?=
X-MS-Exchange-AntiSpam-MessageData-1: p6wXQDXZlAvo4FfFE8C/sRlQofMNSrKktag=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f71c39c-aa80-4ee2-4847-08de86078368
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:33:16.2198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0KtJVLgUck3Im38belRBgGQN3fi9Er6gHxSpiPnAptixiYhfzl/WgizfZx99nBKoXIWSNers2tc0jp4gs6xyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8079
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,rock-chips.com,sntech.de,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-7187-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,rock-chips.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,suse.de:email,ffwll.ch:email]
X-Rspamd-Queue-Id: 8896B2D3C75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Rockchip DSI controller is a PHY consumer driver, which is also a
PHY provider (calls devm_phy_create()) that lives out of drivers/phy/.

According to Vinod, this is discouraged, although it would be difficult
for me to address a proper movement here.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>

v3->v5: none
v2->v3: fix cc list
v1->v2: none
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 3547d91b25d3..c0aaa51e0237 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -27,6 +27,7 @@
 #include <drm/drm_print.h>
 #include <drm/drm_simple_kms_helper.h>
 
+#include "../../../phy/phy-provider.h" /* FIXME */
 #include "rockchip_drm_drv.h"
 
 #define DSI_PHY_RSTZ			0xa0
-- 
2.43.0


