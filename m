Return-Path: <linux-can+bounces-7191-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MzvNYd8vGmOzQIAu9opvQ
	(envelope-from <linux-can+bounces-7191-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:45:27 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C72F02D39DB
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0380305CF17
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3ED42EEB5;
	Thu, 19 Mar 2026 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C5HF8mTo"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FC742982F;
	Thu, 19 Mar 2026 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959623; cv=fail; b=Ux0jIMiqqJJWwT/MlbZYZhzgffRxnh+VC2h/wor1qBT5BrJNpvFFfja/AGm/ZJXDBVu+t1xuKxObBNwhaTmsd5L7pOmO21AFWJM1jnz19ZzDFETjKrbDqMOl2MMZs/FyB7H1Qb6EbwI3ZmBT7mCYt7NKEnWxdtUIiF2ifAOvfeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959623; c=relaxed/simple;
	bh=Iuo2cEHzOrlqxX/b2rkhlMgpcsyTUUR++OCequ6EuU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jw3yijYNMjaMNIIozMU2HHHfWksmGpPd6CvLEYKPzBIZHO4x+rOH6cGBDo7Nh5HfcMqz4lmIDdelDO0izBQU1SquHXsduoT8P8A6erQCMq5E4m4U3c7xnhaiCSeK1pNepVS//FvmqnxbJY88zpEN7Yke1ChLDneH/S2EhDT8H2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C5HF8mTo; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYBMg5rdH1ECroImWyGUfymCcMTTGbCnMqD3gYFYmn5BUF7QGPrJtipdKs2BgK5mp59wQLCNRBKLsRIhQho5UneOmntR8jVTV4/2UUUdDcbCDKnjKtSjynPPfSBH1I7vhSdXT1AiWuxv5/fKM7cv5l3SJ7DKLHtiWaKl4ADZKuCH8uqZkKN8CbyjXlclZta2eFpVSTRUafp7114IachSueCORqp5m+J4Uff4mZ3LmGemviQR41l19UvVFe1E97Y1D0t9sg9fty4/W+HpppgmrRrcZijjV6FgUJoQh5mKNVgc/AdEeRJxgmrfv36BiQYYhOMlwntHWCojGD9FdAweEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6g9V2YvINEggIL2ucbZBwOE/kWImafgZZFWWR9n5tM=;
 b=UZJy71GgNe0yXve8O9bWkcL/6+tz3tzmTJyf5oL+xLFClB+2nsgnlnfZOqZ/uRWZPCs425OwUv3MAkN/YNpee+JSxHmbiDs4qOi0ETU0zOCOvkjQE3VgQCxWt3Td6cyBHTjjK51X5pDfk8L2Qb92BHemqxkVlvnIntPkux/aBXduqZwjr2bpV3Y7Oey1QNp+98aJFHIKLI9t4VQ3D5A4h+mDRlS+e0pV2XqswFUhUsI4Q2SjQ1yUb8km97eHj/3Z2ZhjeYS/ne5ejoUAdovE7GYi4ndfgMtNEov78bPyOCqDtVYLQy89NYZNBYkaYuzSHdkcDkgL3FPnqssGSAy1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6g9V2YvINEggIL2ucbZBwOE/kWImafgZZFWWR9n5tM=;
 b=C5HF8mToTJCkCCBluTPj0hFXLU512QD1Tx5TH9L60SDADcfPHfZvJ436ZrOJtu+gqmeQTMh30yuT7q8jm2j5SF0wegL0cOHjPS4rajEjTohAG+LiPIgEYTwdtiv3PXaZgCDCsQNbZXxjmzYox78EYca7UE7Iw6Hpx0RxNtSSqPy+15nV+GyUgRDHUpmPI3j03ATj2AFN0kqxLZYi7B9BszMXXlHQkM4gjTG03/rngnrqURD6HFlLyh9779CL7wMOw1fNmPdrsMECT/Vj509lIPLK8p3DafH5HOCghsq0l1oo4qkwOQxvyEapLydI635c47Eq1iJBL72jQSGoaDccow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8079.eurprd04.prod.outlook.com (2603:10a6:102:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:33:31 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:33:26 +0000
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
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v5 phy-next 23/27] power: supply: cpcap-charger: include missing <linux/property.h>
Date: Fri, 20 Mar 2026 00:32:37 +0200
Message-ID: <20260319223241.1351137-24-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P194CA0054.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::43) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 34533891-2bce-45f1-bac0-08de860789ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|19092799006|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ige3DgLHys2FLdoTsej6PijuTBjJ+MjxXwpUVElPrNVvHrdsrekMyfIZ1czpHn7jxeI484Fk+k80X+Djon4AFsOiD70HSn8uKhrCjDGMf/dnQTpazliZ+b0d8YHvrU1Tc+oHIYvYRlZvP8S2dPdQIBGtVSb1sEQFJbMx944CvwNgw0yD8Tkf2mfzz5mOGrktrGl1y//N0yRbzQ63YOATyXFBPVVd0x3mqudTfyBaAbRmed5IuPPluWhhZUTz5GA9iYMh+Hh+6yDP4a1dvVzpg0zDdsnU/hHfOEa9IC/FMxQHkVtHNETU6QuNpsL+rHa24m+Cuggb+SSutY3QHWwdzrML0UjLF/u+Jj6S7wQmyv+k4BYNqTGvBCFYfSeBzcDORoADhXO/aD3LJOwZXVr0xYtwR3+gYY3xP7PREAAipiNojB0nZPN6xLAsVpADJyOblyoBKmg+GE6yUcTy4uNJ+smIQfxY5x+xAuYICCkgvWb7qCwEQuKRPTJ4bumdR3i8mvO6jx/KgEBcberWgZEUZ9eGaCji6pV6xFpYvborCL791Q4VuYhRCC9Ockrx+DFWDlaxQWS7lCbuixwjQFvG/YUCmDyj4i6TIDpyZG6x2Z6qGQspzWKJBt9OaRzGjH9jFwLifgt9enYOSFCY/6qB1C54DazDg4tYw7wccUtZRzpPrXy3Bykwbc77ggOSbxyrYGagJZO9BQGvQ715spjfOv+MYKXTjQkeqNAvX35QVJM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2L/zVD+XoFbMJ/BsdkSMR0VM4FbRze5lL9gdqyeFKL9BwRrr4tpODm6siuVE?=
 =?us-ascii?Q?J8bQ8oeAg7sQcFE17GUBZcj1QDoDgLgnRDGs0PewRCB11RUC0MHaNGa7wZtl?=
 =?us-ascii?Q?bMBqNhT+3kyA39VXzu1nQ9lstaoYRVwNY1lOa4KngEbsBxlXxHYvK9tJ6w5n?=
 =?us-ascii?Q?qsJXBIfXmIX13fE2kbBRHdLw7INIkN82WnVTQCV+e/OpmqSQPpcoQMwXB8PO?=
 =?us-ascii?Q?VutzsAfwxQ9lsTYOPbmLeGiVt1hmutXgxvwKNjgtcGIrQwGKdU/xOV2/Kdnv?=
 =?us-ascii?Q?WhbWgEnegX0yuZNaQp57BW+iXF7ZHU/EDQKOG++RkLs0amTrnCNkpA2d656K?=
 =?us-ascii?Q?E6koHGAu1BELDEPe6vk6GZACKyKNzWeD/nCgv7qlSP2W11tyd9UIUrXW2K47?=
 =?us-ascii?Q?anDrS+fzkvvOh6qjfA47mpb9N6OHxgkxJ0kAAP4aB+LONXAYVO1v6plQNMp1?=
 =?us-ascii?Q?xsjxOvIxX0ueNnsipPfRg6q+qh2HBRWxjFipBLwfMj7WMEQZKzyrLqTXofUN?=
 =?us-ascii?Q?zom62P9kFhr2TylQ0OZ3XxVBAi+8FOMk3MzkEot+C/j/r2pK0hRQIHF4GLcn?=
 =?us-ascii?Q?FZg7C8Gl5RgsAZi5ckK6YlUEwopz2OlAlhtFjJQRdfKgJSu6557j41opZlvC?=
 =?us-ascii?Q?9YENcv9UBHJ5Slqo/L1jGx0sp8uNJx8G4dME89mv1tuJfFk24NFdFWE73Yab?=
 =?us-ascii?Q?2LSfwLAKRAkgqSG3fC5Tm65tTXxAf7ws4Gd58O80Fyrok5VOua0CVAfdk55Z?=
 =?us-ascii?Q?idtfeoCyuyTYSoosdy4SEin3Gm0/SSByaPDXAXUBjcYJ2aKuwp6ANpooPQqb?=
 =?us-ascii?Q?5ty3whAMKGL8hPk4YCgJe4ylNyMkZEROokruDRJfLTYs1Fep9uG1PHT8LzfD?=
 =?us-ascii?Q?/fZDmk+mjCmCGUuHMhrNRW/QdsYoqDBiqT787WKj3P73HrpEf6DAmRbzJoWV?=
 =?us-ascii?Q?HIa/LsQAfZj+xT9qqV54ZH6Ntic49/9pX9OMwhpyTXKoLmkk5MrneJly3VFo?=
 =?us-ascii?Q?i7wkNTu8fFZGC472Lxy9wwnSQtj/dHuxOk7YAKEXFHUQjyKMjcdUZyjbReLV?=
 =?us-ascii?Q?yLW3FEx84TH5HBIn6C+iMXtJ1+hl/mfSXWwp29FuxV5tNld/uWQys/0iQRnH?=
 =?us-ascii?Q?98A0HKSWC9tqix+w7h01T3MUI0kXdQQ57/Lz1ODKjqfKhMUH2akibuo6Ehpv?=
 =?us-ascii?Q?G9TS8FJjMnlw3D6rUM9VfBy/gpSGk09cwKEaHTlo2IQR3Sm16Md1t5PMRAud?=
 =?us-ascii?Q?gLb9KNYHTQiGQEOFdepLeh1T13ScOD+hfTgtXMH+3P3GZFTOOJYB+zKQ/ag6?=
 =?us-ascii?Q?ZnVeD5sM9OuwzHrtF16xsM0ccOcjaCjcjgp925dHaoSdfOqBkdv88ufd+1YN?=
 =?us-ascii?Q?tA2KEH/iesvPZqEpXQPZuV9i4J5IqrbhQjX10Vf1SiltL4SLKgB9H/QBmWwl?=
 =?us-ascii?Q?WEbsHzFm5w1K2Elupu2aQrMiIE3sYnniW2wEOKOdaSzQIsPbjrEDczPK0r3k?=
 =?us-ascii?Q?y20pLuasPO38XWGH8UBkP/ydqDQrDwAgHzRZZv3gjfoXkndtx/4WGspDbk8C?=
 =?us-ascii?Q?hKdEj4//qOp4ODw8W5MCrSxaBSpTf+rksaU2B8tbfY6+1b6uSD3ixqfYDTtc?=
 =?us-ascii?Q?lL7PYf5pqovjbl7GzK7FZZuXQ+xqYCGrau+gXKeuoWCMWRS4J5UflhCHwQBW?=
 =?us-ascii?Q?uz/Cdl3CM4rYvh+qcMKp52XvbcLSX5aimbE53nth/AloW8dirsW6lhYyuyln?=
 =?us-ascii?Q?s2lpBz7W07693GpfZ77sEXyFBjjBaG0AY385UjbelcQacyeI9EaeEpz1Lf4q?=
X-MS-Exchange-AntiSpam-MessageData-1: /oueoSq3ylVwhzkgqF5bsbmvP/9WBe/L45U=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34533891-2bce-45f1-bac0-08de860789ad
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:33:26.6908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOEEApkBvPEZTesnCnj681GH1y6uIn4K8TEf2FJVv8ColR6QMEwEpumDS4E8WZG+bm4x/vrxqBJxi5ckHkhNBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8079
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7191-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: C72F02D39DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This file uses dev_fwnode() without including the proper header for it,
relying on transitive header inclusion from:

drivers/power/supply/cpcap-charger.c
- include/linux/phy/omap_usb.h
  - include/linux/usb/phy_companion.h
    - include/linux/usb/otg.h
      - include/linux/phy/phy.h
        - drivers/phy/phy-provider.h
          - include/linux/of.h
            - include/linux/property.h

With the future removal of drivers/phy/phy-provider.h from
include/linux/phy/phy.h, this transitive inclusion would break.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Cc: Sebastian Reichel <sre@kernel.org>

v2->v5: none
v1->v2: collect tag
---
 drivers/power/supply/cpcap-charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index d0c3008db534..24221244b45b 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -21,6 +21,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include <linux/gpio/consumer.h>
-- 
2.43.0


