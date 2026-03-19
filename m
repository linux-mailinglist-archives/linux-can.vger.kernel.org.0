Return-Path: <linux-can+bounces-7194-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIm/EOJ8vGk1zQIAu9opvQ
	(envelope-from <linux-can+bounces-7194-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:46:58 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC81D2D3B02
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CC813067CA4
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D0B43CEC1;
	Thu, 19 Mar 2026 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WzmDkWSI"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6EA405AAC;
	Thu, 19 Mar 2026 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959628; cv=fail; b=ZZcyvPBdQ1PsrwB+jFqeVmvljRLGiIDnhc+kB1mdP17K6IuEm84LX2FfA0C9gnNfe78UZuLUybTaZ5Syxha9g2/ZL4QJV5+zCeaeckB6ifEsSxrj60E6d+fxha90dqAQQ8dwd39zAYMlmkWe3JZTPm+X9UhOOqE4DSIGBDZ67Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959628; c=relaxed/simple;
	bh=iTxpMaNcklI/KDbTMNPtJn1cZPeIQ8DH2MK8WajaezU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X/9AVI6ZSCSlYuHjFAiXGVaHwdd4+o7XF5C73s7SaXZuzSt1aUn3Oz0asSElN/HlbMxLahXw34+qGrbvZs84cp0dsXbrnG51cmMYrdjjxfGvdyqJVwF9NY/Y7HAhoufPA1xKPE1jaD/9G9H8N+XLIed6dIUIszaIK2jSre42X0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WzmDkWSI; arc=fail smtp.client-ip=52.101.84.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wU2u8MJssBBrcJWtbz3lq3R6YbDhcUYSVlJS/mlDEQmT6FLBg+JeRamYNRHu30aab2883UZXlRy5vWNNS2JxuX47TW4w0WZ5jencTvZiYNs61oVyNBbu26VwpXpH+aqhpnUAzVBn81DndiPsNz20waJ1lAj4v7t8DSRx0WHtLfQQ+Zh3bILfSgZzz16caYACOjplQ6uc7L2zu4i896ZU5zoZYpllENsH6J9mfiAe3fYpRVPxe4BfOcApO//DIiBCm8fHesbcPYZis0sYpvZmV5x1w0CJcaHDKT0tEMWoB7GseekxL93q9soqvyW8so1vnQZqYnuY+fKCr9vUbB0y2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VmtgYJYmkaxA6II3rhXAes4JMKXwWNRfkBD6NswxLw=;
 b=ZeL84dYywpiLpL1gPU0E/FbJC6FLJIQEMcpfe4B/3Mv6CVIsJRrSatlHcef7n3nmrQvSvxFL6N9zbJZXj0S+leMXIkmicmRvvZCXd6APY2JTM56hHOnqkthXXfJdwgyhxQbAt20bwIr2wI2TyHfvnC83JZdMcSfxb9pjswbRg6PezJIRsTbJuiX8zGtP5+MJsQ+PUVez3Qtmi73CZzRuDvqfX2JITZR7Uy24sMURGgCTGFSwQF3SpMsPIUd8m/w3AjPkPXjKmJqAGaa4FGGWAdF3xznOZ8z1aSvCYHwQD5W5y+nx+epb/rVBmE7Csuc9GO6zQNcGHD4xeOBxPROqIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VmtgYJYmkaxA6II3rhXAes4JMKXwWNRfkBD6NswxLw=;
 b=WzmDkWSIXKOK0PXIuKdnHvQFK3kqqmbTYCo+c15gupX0AqgGWLxLx0bFG+qWSfo5aJjaPiCxYOdFEloUBP/ryXIQH4pUM7u5102LYHfTW158lUnMPnWwwy/+58v1T2YMSx6WIZ0ZyaHZH6txeVkgAONFGM3C0AAO9kx14n+WtcS4QJNuGnVwibDAaw6QP0NThTlcKeHGKdibYEHgwt8G0UkIxzMhSfq9oIRiOOjrorJISRVPMFqfD6aTD5aVENiNy75h5V0BAeBUJ0Gs52wJubIy2rMFzbKSWwxnZjUy0XodJ8OEU2u8uI69vBtfJGdh6/0A2xx6CozxrwfGnFzORQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8079.eurprd04.prod.outlook.com (2603:10a6:102:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:33:37 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:33:32 +0000
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 phy-next 26/27] phy: remove temporary provider compatibility from consumer header
Date: Fri, 20 Mar 2026 00:32:40 +0200
Message-ID: <20260319223241.1351137-27-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P194CA0037.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::26) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: ba1b9f48-8b44-4245-90ac-08de86078d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|19092799006|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+1fIcCQQlk59Znjw3fylNUF3WDiraiBRbnO3AOUf8CDy0L7sIMTRNO12mKgldzgujCLWUfaPky0xLzy79CszgtKVnCAPaOovAes/98qwZiRGrBm7UqVYfZjT34MvwiS+jGfa1BBbYd4XaRCa3TPHpqRqjXfAjbdqDNJZcfNCXTepOvrGOsGbyUAc0lXxljJkbIqU8Qjd/xLf5jp3XbKWm9NzhxNE3PCB0O35QP8JETAARgKjBEwACOiEyYEKXtmyxFFSeYQ9/qhzCQywUqHcKIGbFPUierK267XDu1l/Eqky9o9Ami+uZakMrBFymbEGIKo9tra9Bo4y6WEND1ByWPVH94N4n2m8lAGkvjongQzb7y1ff5yxULzzdL9JoPFSvd6K04bjZgrMl7BnWSnMyXglWicCxkZ/vG6JjE/o55MFvV8RvsJCXhYn/VmIGn/ULZHLui7d3uKWyVDCdDVog69x3dtB6NVrihlzX379Lp2hhTKCV3tqlmWmgoLrx+j0qQhrqLCBYZ8DB24V6zVBN6w4AC4Ml0Xt6iuJBLW7D6FYM+NDkRPz+vTTY4+wRkdewjK8yZvGljriDrxqK4ooTAL5EFbUDb4i4+4O15r4p40hjl6Wo66SuCnmH9WZ9W7hAe0dYNVQGjJ6LeyTXAZnmqOdYKSILQU5dNwOcxBSqlkrP+onsYSH5KS33g3QJaqEYlMfLxFbI8rpaPhCwgRjyosSp8QjbcmxSUNQKWZ8bGI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VflRTa6aiQIAbEc+XOO24npsBdSP4nHVblBK7i1rAEGKeVpEwyQC1JOZ3jmj?=
 =?us-ascii?Q?eNeTw+AhkQrK2ASLcdh/P2zCLF6LnXQIH4vlC0EIsidcpabRiJo9FL2os3ND?=
 =?us-ascii?Q?qr0Lk4FzYQjebml6srYGKsPax1bh6NE/NrWMTqlhU/1RghL6nCmfThyHmPxl?=
 =?us-ascii?Q?hsCTq8nspbX6zynOHQeSqIDu+BKsyAAsQ7AktbESQIC9dIzZaOlaW/4UYQFy?=
 =?us-ascii?Q?fNJ8FtOuzDAKQV088kjD80tPZR//erXX40Bh8J2E17Y4N56jgvCpdR5QlA7m?=
 =?us-ascii?Q?abbGkl5le8Se0eO32S4st+Eb4PSUa/0tqDl/0SJGeDe3VwzeuKNSR4gy0gAh?=
 =?us-ascii?Q?yAcfhYiGC7siWq605E8McZ6ayaOOa3dN7TQaKOsK85ALwePajlz0P74LnzzE?=
 =?us-ascii?Q?Hudk0HJWUSjdkhKN6YyEtjjAS2Veo38ZquxSyvGCTlWy7Pny2mm97ysfG2HI?=
 =?us-ascii?Q?ZJrJRU2Ojs1sj7E8F3FS6fPMdZrf2Fi+SLTpaD4jdFiBFGZWU5Njddv0fcUa?=
 =?us-ascii?Q?YUk1MPy1M9Zxs53eZGbXiF34hSwl5SY29gHYU4Adetyuo3TyoikZ9YDkBrdQ?=
 =?us-ascii?Q?6nM0agQU9B5h0I+qDFI8DnxwFAEXoHHbBGaFwGbapyPOxUI2Q4i0ldHSoKEL?=
 =?us-ascii?Q?9G13EI/mlYmDmnikZzi8pGupz/LGy4qRohL3QLJCmeFfZf/uqRfBCPRKFMDJ?=
 =?us-ascii?Q?SkAKDIsliRvcvlwVr1t5RHONBG0w/gdAw+QR7RheNJtez8+g/N8b3alb8zSz?=
 =?us-ascii?Q?KCJpLv1bos6fK3uu1cCUaCebQZitVY2MO0lzxv9+aTfEIbZweeOyU5Bs7km4?=
 =?us-ascii?Q?6PLUP0fi/Mr0ata+017dguHBOsp8Iby588Z6SP8Ih6+wcN608Y2jLAmy7eoV?=
 =?us-ascii?Q?xdVgMIOOklE31QzbKhnfP+zw75TF7VyMeSk8b5E8B46jrX2krAU8aL9dLNpz?=
 =?us-ascii?Q?QEiDasW/TWfa9Ee94TijnKm7kLMvAetdZju0feyFHvWtnmF3tQom9LJprneH?=
 =?us-ascii?Q?K/Y7xxp1v/GSEAuQbnFotWeqmoIRw1cloJtFUzVW/Xo5pfiSa8h1EwhV8Jmr?=
 =?us-ascii?Q?ywE+wOSu/UBLUDEvK8AXPBU1iwztT8Y3akUu7sN0/bWZO0q6e5SLQkSQ29z+?=
 =?us-ascii?Q?m/35d2PpzuUMTZO0Hk0FxHijgUTVvq+HNJjaYLLmpBBf1RjR+EHspWzvX/pL?=
 =?us-ascii?Q?3KAScJUn5Hci9U2fgg939eXVoAIX93xjB3n3xtMPMHWtHD8ezV38kLpA0C11?=
 =?us-ascii?Q?i09hFpaQ/A66TM+0gV/mN/y03QORClFQmYbGhVC6kz3OhN8+7z8C28UEV9AS?=
 =?us-ascii?Q?2ap3auJpFC+oBye5uKYdAywG2mzuFU4NXjvjOK6E0F8K6MWOy7PNu6gUO8L7?=
 =?us-ascii?Q?3roLPEkF/zoYElQuHcDTnRtvDRuiBmz0VcM84Z37qBSQVa7y+JctNaOn2foo?=
 =?us-ascii?Q?sQmnAp4fHQiIkT80DPE36jUvb1LfwrXJhBv886CaLjkVnH7XZhiM+RiDTPmH?=
 =?us-ascii?Q?ttNKZmsgFOegAG1g0LL3JSInUK4VAkmbrXUIng3bjzy6baLxs31oDx9COhR2?=
 =?us-ascii?Q?3+XXZkIDoHIhagIWekA2mCZtmI2gndpF8dHw7kTPYxGw2pywlAY7QPuGUdRL?=
 =?us-ascii?Q?tr24ehijSwopM9wNBtbyHO7Pq7FHTVt4LV7CF2gzOkSSP82HuTfrmZPtO5wE?=
 =?us-ascii?Q?Gq6vZ1D/Crut74roqCOV3/LKVzE9KrF5zdX2Nrbd0uBrKcdCrA3pTUwTPYdj?=
 =?us-ascii?Q?qpr0oiwzIBkqwVEd2j6NP5ODfBS9K4LPSXGExb4W+V+aQlSU8W4Luv/kWApT?=
X-MS-Exchange-AntiSpam-MessageData-1: zb8LqTfKyMhFrDwkq5iaymYWXHxhgr/NbD8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1b9f48-8b44-4245-90ac-08de86078d3b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:33:32.6640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //DPs9B3CLm2eQG9fKaDO9352oOlcnLRYysj64nnCCjMDKYtw0soi2jycyAW6uFPDQt+7lr+Om3wnN0MdjBcmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8079
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7194-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: EC81D2D3B02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that all consumers have been updated to no longer dereference fields
inside struct phy, we can hide its definition altogether from public view.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
v2->v5: none
v1->v2: collect tag
---
 include/linux/phy/phy.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 34b656084caf..0fdcefaa3f55 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -12,8 +12,6 @@
 
 #include <linux/phy/phy-props.h>
 
-#include "../../../drivers/phy/phy-provider.h"
-
 struct device;
 struct device_node;
 struct phy;
-- 
2.43.0


