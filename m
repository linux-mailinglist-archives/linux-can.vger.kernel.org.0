Return-Path: <linux-can+bounces-7184-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OITO0h7vGk1zQIAu9opvQ
	(envelope-from <linux-can+bounces-7184-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:40:08 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D59762D36A4
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5AD1305AA33
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC7B423A95;
	Thu, 19 Mar 2026 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i7xw77CS"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52141C2F4;
	Thu, 19 Mar 2026 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959615; cv=fail; b=k4fwO7l9+zTsPcY8Pu9ilspfNVTOLZEAwl07Nb7toegzQ2PoRtd8aJqtS3mtAUWN6JOHMJLzYPLeYG2wuUpuYzp+CncmJt4QF80N0ESAm/jOOHvTkIDz+laA0pUQPVLDVfpvmCk8DVNAKoCIbNzJXJQzsari7le5mUwyRD+dK8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959615; c=relaxed/simple;
	bh=kFrshqgznTak5+rdix93JO1Br/OkFg867ksQEGXtRjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nKZxi61B+Zl/StjCrb7GupLG4Hci7Wyp827SUeQip8CZ/qhZyo5e/LfuS+dBL9vSbVdLGklwqImoMGozVPNl3y1NwKZjyEQ51TSqu/TtVZDWaqY54U1PXO/L1u0a1LIepvBspOi1QzheCRFsBobtPdMIygfNP0tHeEQ1qtTCNes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i7xw77CS; arc=fail smtp.client-ip=52.101.72.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YK0vJ5uUvUf+sirLzvjQyMGrznvUc3uFWKSaCE7CzRvOhuXWxhCx96hb5dXw9hxZrQoiwg6BFFmx7XyAssqu9LgILYWD43XQyJsAfUL3IxbRn5yBarVvwrsXKjXJUEKIA1JHlJLagj/Qad+OyFiYz8CQGihM4Wcx21qRphy8F/um+Rv5V4AnqnZ2JYolVbrp56DTxJZF4qyLWxoO3l+upAsTPg0vEf27Cgnt9ZiKGAZmmcLFU5A1IakFakWuulnOLF7ayjy+DVNUnDIdGmlIM96A1+PfLvFEmkFSrQ7JDub+cYrJR5LzUiDv4yS6UG5NxzYG01tQaTPurwG6tjiS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ok5zSouSkEHcGyZensumTc4hI8GTEsik+92hEvSEm54=;
 b=ww15EPgurUesb9zz7glF+MqCcHe2A3qKjtFgsKPVpgO8I1vvS0f4SYZ3ucvj/4R5N1QP5vScrzUNxg50QT+IN7ufs6gd5Bo9LJqJavTGUb3w9skuF5b53LQyjFJpBsYXalvdBuLw/bRI9HeQF1Lj7/QOscWeV9wDLotrXQLFOnpdqxLk7z32tFgRK45pracI3x28eQ6b4W76L7pBrXl3Z5zdC4ofeDJBdIWWEqMTrUgjOAlnHap7GTpQPk+j3m3XXwngm5gHTDKAQmDHgC/+foGthIKy7rtN9cOHnX1A3y/37j/F57ZCaRxIDbzAX/aISyVkBm+7kumeaLjpzUexWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok5zSouSkEHcGyZensumTc4hI8GTEsik+92hEvSEm54=;
 b=i7xw77CSdCwWucvyd26cYRtQhJUSAH9pbrIJWQ5PLQCpQVQkaBFa2gdf8jRZ6/iQrLcQAidqIh405BA6X37PFAbbdyIqKU9jXspA6dwsy3Qyqz2GbgHHQPpB6X6xzc1Vro29RMj9KS2DcURV8IjgmXG/lpVaS7Lfa5wpUt3ISulw/Uczszd+wJ4HlIqrYuL7JLhRzThp101mJrWUQbTA/Zhr5w4297WyjcNjIYU7/68XI5gPbJMN7TQgpGk1J/68V0iCOkWcaug/s6gOVbmZa9nQjBy485iBmkSWZMnccrOwfAutKsrRhYOF90CylgL6wZzTAsKlX7FDFoorPDVdHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV4PR04MB11355.eurprd04.prod.outlook.com (2603:10a6:150:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:33:04 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:33:02 +0000
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
	Heiko Stueber <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v5 phy-next 11/27] drm/rockchip: dw_hdmi: avoid direct dereference of phy->dev.of_node
Date: Fri, 20 Mar 2026 00:32:25 +0200
Message-ID: <20260319223241.1351137-12-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0264.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::37) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV4PR04MB11355:EE_
X-MS-Office365-Filtering-Correlation-Id: 5227d12a-d127-46df-0a1f-08de86077b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|10070799003|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oRjDG5SlZ8jOadbBlEqAhxJOCD+FWGBQC1o4IXGD2beo7dKB89gexnQtsmibKY0OWaNrsVrOPn6JhVV8L+Q3/gO8PoPKJQqjo0Pnw4WhfeAfyUZWGxsHchIRg3ksfZbuMi12VvqthNtV8Se2K11qH1N4u0Ai/8uk0kcgUrza7N18ptfiqxqMh3lIfmWug3dWAJX2YVjlx0K07chfsV9O8HCVAxtdFEs9ws1LKYhk9THkSaHnfQrj1sIXKgJPrwl8JOMdUrOFXkyk6mP52LE7xACVnaLKdwdXqRhlBtULrp4sqAtkUPG5rAA/+iYUBcFx+eusuvJpGYNQqcvaWWu1o0/xXYOlohAJ0g11hDGHTeLhCyfIff+fB9Ufan5wuH/qlVAuGwnIK9M10+P0nxTp6YHf1bODT6Wm/aiFEz+o8V4vMZ+WvQKGwcUf/oPXnjpqvCjopEstL80N9q3kacqqqF0U6LL8IngeeXJn/Hz2XJAq2VO+Zs7v4OkA1nBZaOCEmGTe1R0M2A1e8fhAog235be0iu3TrC+vtAZ7yQPrU8sAGc8LmfGlgdG8ON1e2yR+ravM5EaQamOHKMJ2v9YojYu6W86GB3j4ma56lSla7hzACHXtLBkh0znW1ms3J+7Q4Awksjh2G22OEJdgV5MeZEKRlc/SdQWLKUiM66r6K/ayRP06MzPYy7v8gIMd/jiQMDLeR72XMSRklCRz2JRBxVylZbJeKibgqe/O9pRjs5A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(10070799003)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXJyT3hEVlk1L1BiTEpza1MzbUVBZDZDK3B6bzd0YmxhendQUi9VWmExSXpr?=
 =?utf-8?B?OVcwM1djQUVjKzdDZldKZzJ4bXlndjU4MVRwSm5MRlRwRWhKbTF6MWlwakxJ?=
 =?utf-8?B?SFpKeU9yTTVKS1c3Tm5HVDJHNXpNeUFia3Y2aW9uYS96cHR2anRyTnZCc2Nn?=
 =?utf-8?B?SktBbTRobCtZaFMvVlpuSVltVEVZZnhjTS9LKyt4bDR0dzJ6UGRYeC81ZFZi?=
 =?utf-8?B?YVVuaEt5Zm51MWdjYTRwQURLUGE1ZnVudlVOYnBxb2ZFSUhmVG5mbnh6Snda?=
 =?utf-8?B?STRINnBVVVh0d25LRU9NWjlFbWJVQTBpRnpvTXRscVBlK0tzSzU2L1puQ3cr?=
 =?utf-8?B?emF3Uzl0aEo5SE8zMmU1dGRKRmFrMk5BM3BtQWRvbUVMb3pydTNybkJ5cC9X?=
 =?utf-8?B?Vzl2VnNSZzhYUFhOUy9oc1llNGd3bmI3dGg5azJqd0ZsR3Z5a3QwcnhYYzl3?=
 =?utf-8?B?eFJMYUdzeE5pSkZBSFVISHBRaHVtZEVUek14UU9zRm9qMWxrdzZibTRIQVdT?=
 =?utf-8?B?c3Z2NVVJTUtGRGc5WVpjak15ZW04SjZWZENicVlsVTgzSmdLSW5BWGt0bUJU?=
 =?utf-8?B?TEE3VlVYUEVrM29PL0NyUFFvdWh6S3ExK3h6TzFnc2krQzdoTEhIY0J6REdU?=
 =?utf-8?B?SDFuUUJOQmpLU3JBYXcwajEvNCtOT0ZlZnFDWlpDQ3N2bDBPVS9pNGxRVE1Q?=
 =?utf-8?B?V1hoV2l1S285eVBxU1JIbUppYzdIdEh4YzhqWm56Smo2bTlOTlovRkhkazVG?=
 =?utf-8?B?amszUittdDRzUExWdUd0WDZRN0dvdWdvTkR6bDJnMExEQ1kvbFVxcmt4ZjMv?=
 =?utf-8?B?VXMzQjdHOEUyK1VoV1RKUFk0cXB0dnRnSHhzMTYwYU5TY05kWnZLcjNSOW5n?=
 =?utf-8?B?eHZnN0Qrb3hyNXNkWVc4cXpCaFpFK25xNUlXWDRDRjQ2MjY2ZEFraFkvUncw?=
 =?utf-8?B?M2p6NmV2NkpQeElIaTQwNjlVb01OTWxYMFhEM1o0NVhyWERMYzJyTGZZdE5v?=
 =?utf-8?B?NnhIa3ZJd0pablZYK2hMQ2ZDcDhLQTUxYkVUT2JRN0FaQTIvNHNMRzhZQk1n?=
 =?utf-8?B?WXNhOFZjamVqdHR0Ui81S2tNVWYzU2xnTC9IYW1KUm1KMTJBRnpGeG9rbDYv?=
 =?utf-8?B?WnMvNnRsMGJaeGd5RmFMVStjcGt0WFJWcnNRaTBtclZub0s2dkkxZUppdmYx?=
 =?utf-8?B?TUh2NVYwVnZwMjRyTUNqOTUwcVl5aXRONTRDLzR5cU53azdnaFRRVG9RUVlj?=
 =?utf-8?B?SHhTYWNJMlE1U1ZMazYyVVN6dUZZYnpjV2RuU0Jydi9aL3ozbWRlQWJPckls?=
 =?utf-8?B?RDlEMEJSbkczclM4UURvamIvajZkYThTazFOT0lBRlRmSW03UjNyRkh4MEZo?=
 =?utf-8?B?VWhxS3piNjBkaWJZS1VaNmw3ZlFkb1pOMm0xdEVVVE1FaDRtVCtSdWU3S2po?=
 =?utf-8?B?eGxTZjZPeHVZK3BBVGFSbHBMV1lPYk5ULzNySkVnWXpWQUg4VURkK2Y3dkRD?=
 =?utf-8?B?eHdiRVZIK1YzZGt5MmJzWmJXSzdSbERwY1hkaVhQaVRkdWdSNXFyVXM5V1lx?=
 =?utf-8?B?bWV1c0prR2FUcEJKcW1NU2Znb0wzRVZYWTZsQmtOMHlCTC9acEptQldPTXVu?=
 =?utf-8?B?a0UrVDRlWW90cXQ1YWM2d3g4eWJNM3FHbXNWVCs5M2lCSmlib21jbmVCeUlm?=
 =?utf-8?B?UVRzMzYxWWU3NmxSZzVnZW1abU5wb2xDaTVQK2g5bE0reXhkU0FvS3pMdnlD?=
 =?utf-8?B?RG0vcGFnaWFwZjRkR1dPdEYwbWZ3SjBXQ1pmUDlLRnhUdE8vTm1IV0hzaGZG?=
 =?utf-8?B?alN3WEN2Zy80VmdhZVFyc1Yxb1psYm9pVzVpeVFUWXpqVkg5S1BhMzlCaG1p?=
 =?utf-8?B?TEVsOUZQdW9EK2ROdDZua0lLOXZGMGUyRzR1NEIvZk1IeGlaK3BoUzJOd1Yy?=
 =?utf-8?B?SUx3akQvMlY4WVR4SS9lZjdQL0lRYnQxWXhTRHV4clVWUmFtdytmUVc0YVRp?=
 =?utf-8?B?QUUxMWtTZU5zUUtCbzl0NjZ4RjBUUlZxVDZCdmFNM3U5RGhoME9Jd09iRW9B?=
 =?utf-8?B?ems2K2lYdTNHcUh3WlhCWDB4QkNyTG1FTDd2ZkEyaGkzcDFSSktjYm1zV09N?=
 =?utf-8?B?Zmc2bzZKUTljZnVMWkR5bGZnM3R6WWtwVmhsazdndStOZ3VpSmlmSUVYWGtx?=
 =?utf-8?B?UEVkUUZnczB3NDJRa0ZKa0w2Z00wdmlpcllSTktzSUkxQUFUMzZKZ3RCN0pi?=
 =?utf-8?B?YWtWa3krTStpWkVZcXpMK1MvVU9HUDI1YUQvYklBdWNTYStGYnhYY1RhemNu?=
 =?utf-8?B?OFpwdy9DUXl2eWQxaUZKTFJrKzFsOVF0Z3ZyYXdlNCs2RFdxRFVrVWwyZllq?=
 =?utf-8?Q?ohLTNed/xd8gCn5EpPI91/ElaH8xL8LF5N6iWHt6USXPK?=
X-MS-Exchange-AntiSpam-MessageData-1: g37xMMjSoA52o6HfOJz0kY3JwG2gAoSnr74=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5227d12a-d127-46df-0a1f-08de86077b11
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:33:02.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35/y7fNq6QJriYP3deS9YV1d+9Zp+xOzRvzbVCnqZKBb/ug3DwRGiPtWqI8Jek76oOxbDmQ6c7q+gtkYd0/Hyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11355
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,sntech.de,rock-chips.com,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-7184-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rock-chips.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email,ffwll.ch:email,intel.com:email,sntech.de:email,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: D59762D36A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The dw_hdmi-rockchip driver validates pixel clock rates against the
HDMI PHY's internal clock provider on certain SoCs like RK3328.
This is currently achieved by dereferencing hdmi->phy->dev.of_node
to obtain the provider node, which violates the Generic PHY API's
encapsulation (the goal is for struct phy to be an opaque pointer
with a hidden definition, to be interacted with only using API
functions or NULL pointer checks, for the case where optional variants
of phy_get() did not find a PHY).

Refactor dw_hdmi_rockchip_bind() to perform a manual phandle lookup
on the "hdmi" PHY index within the controller's DT node. This provides
a parallel path to the clock provider's OF node without relying on the
internal structure of the struct phy handle.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Heiko Stueber <heiko@sntech.de>
---
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>

v4->v5: none
v3->v4: add commit message clarification of what is understood by
        "opaque pointer"
v1->v3: none
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 25 ++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 0dc1eb5d2ae3..7abb42e486c0 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -537,21 +537,22 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 				 void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	struct device_node *np = dev_of_node(dev);
 	struct dw_hdmi_plat_data *plat_data;
 	const struct of_device_id *match;
 	struct drm_device *drm = data;
 	struct drm_encoder *encoder;
 	struct rockchip_hdmi *hdmi;
-	int ret;
+	int ret, index;
 
-	if (!pdev->dev.of_node)
+	if (!np)
 		return -ENODEV;
 
 	hdmi = devm_kzalloc(&pdev->dev, sizeof(*hdmi), GFP_KERNEL);
 	if (!hdmi)
 		return -ENOMEM;
 
-	match = of_match_node(dw_hdmi_rockchip_dt_ids, pdev->dev.of_node);
+	match = of_match_node(dw_hdmi_rockchip_dt_ids, np);
 	plat_data = devm_kmemdup(&pdev->dev, match->data,
 					     sizeof(*plat_data), GFP_KERNEL);
 	if (!plat_data)
@@ -564,9 +565,9 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	plat_data->priv_data = hdmi;
 	encoder = &hdmi->encoder.encoder;
 
-	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
+	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, np);
 	rockchip_drm_encoder_set_crtc_endpoint_id(&hdmi->encoder,
-						  dev->of_node, 0, 0);
+						  np, 0, 0);
 
 	/*
 	 * If we failed to find the CRTC(s) which this encoder is
@@ -588,13 +589,17 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 		return dev_err_probe(hdmi->dev, ret, "failed to get phy\n");
 	}
 
-	if (hdmi->phy) {
+	index = of_property_match_string(np, "phy-names", "hdmi");
+	if (index >= 0) {
 		struct of_phandle_args clkspec;
 
-		clkspec.np = hdmi->phy->dev.of_node;
-		hdmi->hdmiphy_clk = of_clk_get_from_provider(&clkspec);
-		if (IS_ERR(hdmi->hdmiphy_clk))
-			hdmi->hdmiphy_clk = NULL;
+		if (!of_parse_phandle_with_args(np, "phys", "#phy-cells", index,
+						&clkspec)) {
+			hdmi->hdmiphy_clk = of_clk_get_from_provider(&clkspec);
+			of_node_put(clkspec.np);
+			if (IS_ERR(hdmi->hdmiphy_clk))
+				hdmi->hdmiphy_clk = NULL;
+		}
 	}
 
 	if (hdmi->chip_data == &rk3568_chip_data) {
-- 
2.43.0


