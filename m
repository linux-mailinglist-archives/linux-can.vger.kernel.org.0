Return-Path: <linux-can+bounces-7516-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGRcJYPG+WmmDwMAu9opvQ
	(envelope-from <linux-can+bounces-7516-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:29:23 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 052A64CB490
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F19430A9BD7
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DA447D933;
	Tue,  5 May 2026 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lHWZQn93"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9D0478E59;
	Tue,  5 May 2026 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975612; cv=fail; b=RPjDm9ISoMH9F9FtJYOPXQgsq/lhejQojmwzHfk1TfLxR/DdEaPnXy3dXzfD6jHTT5EXAPtzUiNRdLsOU5yhOzcTMwvfdAstZCz8Nac7QbL+rI7zw2cE0Y+kY5FjfjMxwrmtgrhuh+RKX6Z63PkpX8BZY1x2LFWvFEW0OlPL/ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975612; c=relaxed/simple;
	bh=la2ob9RYYtRx/9zCE5qTBR4fXIFytHVQZKzE0IvctIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AlU586XIJK2Z9nChmmzYQF03O9HYsrWgQO7EXU6wyk1h/aV7QzcRm79zwz2rMShus7z2x08Xqtp82ZTTw0aaDN/WwH29Jxj127nhdC1pupXUrl1Fenyj5+bRwh9nROBch4Fn8UwD2Pw7HFF1fH1krkqXT+FsFQ+h6c2rPO76f5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lHWZQn93; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRdX0QOo+u7t08JvcT7alFdxomJ7fM1DdY6BGc3Pn6Gc2Ir/jJWMwJA3AJo3cU9MuKTkxwMG6FOPIEowyqIA3gbA64tbKxMpRoaZJbM18DrwNnP+ZgbB0BvwvA2sTRrF6szAtbavaGCG8lWi3vs6ALVPCKrpeqDfGiKDEFjTlWeKy390dtBVJpKJDzgaWnVp0Zqh7iUk8bMcZOTSS4tJDX89iECJZRWdVAMvWa5jEcZfIBgO5SafzKCK2h3HZ9wYsLE4v0WWNZmY2gQ9KafTarFZRa546UUzkZJnH0G8zHIu9dLL5AVraxh6MmAX4RE4IXlnTEA9asBz8oaoIwqmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmM8kB+LU+AQC9HhS+yXW1WEeDKKNcy+UBlvQl+8c7Y=;
 b=wLaj/jMTC6udHOVP3OIGnpjQWP07zVeUAfDlByAT5qDstP/nmQfq1Flf4rsEzP7p215UDTM3gBdQnF7Tscw37sPSPtFTWyJ+TN2m8+6ndo0oBIFyys7++0v3tTFqb+3NSQALko0mVAAdgMdQcntLFvYgPBoqewFOR0rCHveE9TIPqNnjyHanbvzl1bMaIixau9Kh8F6MZVwe5FaIbU71ne8T+yEVxppksM3o0CfN046beQiGJ7oP1vrjkDC+xsaGkwR4tT/hhG6OHtXZszy5Jv1K6lmolZdqOqh+SWsIyDoWGIHI+HoOSbOsP3uK7cVI5OJLrNdd0rmCwLCBbkeX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmM8kB+LU+AQC9HhS+yXW1WEeDKKNcy+UBlvQl+8c7Y=;
 b=lHWZQn93f3K6j2JJboEv1k4CSpwOIYMsYQ3uHiYI98ceQT7XYIh17QY2wQ17VaSSQhh3yB7JtK478GzCsbV00h/5bRhZjkFv63c3P/cfEerb44vEhVCjy8rLe56PdWJ4m8iQSS2hxXtnLX6qDMU02B1gBXKjSovHtvPlXNlTRpn9VQL/OlwQiKiyDT+qD8HsQakv5ZT3cPZDOCPTEDhpquufoHE2XtmBdr1XYSXoJxzuxITpa3Xgm3aADhslXfs0zoYd5VV/GOVXuYcoojE7wM/cPBbXcWTC49iKLzGVEfR4IELeRVJ55Dy4BttRN9RAMWF2nuUO06O7HAEQoJ6NKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB8308.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 10:06:38 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:06:38 +0000
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
	UNGLinuxDriver@microchip.com
Subject: [PATCH v8 phy-next 27/31] phy: move ulpi_phy.h from include/linux/phy/ to drivers/phy/
Date: Tue,  5 May 2026 13:05:19 +0300
Message-Id: <20260505100523.1922388-28-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0011.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::16) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df60d77-98a0-43b9-ac00-08deaa8dff6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	abbdwysatzNpPceiUxh0/c1hbJ+3LtbTxBU6gL3I7ab/rSTD5VRemnJkyk5ZOs/TtfOpN/Tm02zlrpkDZnUjGg4Gy6K7ZydCID4BYdb5KglYbZHWIfaBHvLx+4EjvUmxUKc+Jdwms6yXwPHJxszHPNfyR9X/x1/nbftpCsa1gFJiDeKvPFZBC93lZIce6k6dzBHkajiXX9uz1isQK/54dbIo1PYZEx+Qxw5wC5RftylZBWzGAYFM1wBKL07OQ1R9l+s+aTW1uufVLbsuLtZ87p/4FXg/GQkKOPniz9Ovh3Fx3m5pKnjTrlm0j1fncnATSWPzBVLhLGQPxadKmruiCZFDWkwIpQNP34Zl7J0OipMCBUadft4YDItjGuskFEz2asIyXm9RRGrQAQcKbVCUZXqr/gu+tgwxXVC1ayHk8+kLWODP/7Q9B2ztIOZb7ioBJfoPAFZw24F9NmdSx4pLEARk0/n+SGFwUmEA0UVZ28iiRzS6XhUGojrrPeLX4X+ljHCgkq/cONCMDaGej8GMmudkionsBhXfCOXuD9B06mCn5K/x6GsD8RL5YYhd/T8CHP2W25tanE5Ke+8OeIcdPUpR0ndUmnP3Tpo5Pp4IqbonMHbi4j+nt255iXAvj1tlWUbwoMbYJG4BfAQkdsvhEvDFIlfIYsfF/iJmuUtMGH7gl4bnAxFeY79zmedLdtA9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5aW7TmN8CCGRa+/5BjOtgMDP2bxcStHsNBef4oO+ynUl8x7pP6VVAh07TjnG?=
 =?us-ascii?Q?l59cUsjtvG+dcaqbhEWZyvNACPdflGXGNJfiX2ACEcjouGybMJj7HRrIKBtD?=
 =?us-ascii?Q?lcjA46cWyzgtVZlr2f+KquG3T0ETO7wCZqrhhSeJkIuKN5ow6JmgRZfPfZ84?=
 =?us-ascii?Q?AT1Kpj/mvQnTh5lFm3Gf6LwG8vJbROYUu8uAANFuVmxMyMVQOfvEU5Cw80D0?=
 =?us-ascii?Q?AZOklo91lFoUVsGKWLtB2RpEQ0OMHLc4OH5MsOnTTPTSbFyLMgnkq2wDlUr+?=
 =?us-ascii?Q?OxzxWFaICffXHdxinH4Rk9CIbxmmvzaoxbcBDr6vJ93QcYn83Qnc7bzLvL8t?=
 =?us-ascii?Q?gvA0wgQWrWxOgKS/cElA0yjhH12jTRMSO5xrhWWB4QFwdsPHSVebkKLkGC0d?=
 =?us-ascii?Q?yrjLQbXzj5oVv4pf7FizAc9uCm91JHievkuWcZZYkyNCJ8s27cJIby+PyV6B?=
 =?us-ascii?Q?TeipZaLoVGViuXs7rU2b39cx5VmY6ufYFmyjvjWM00Ir5M+D/vPRxSo6yvbo?=
 =?us-ascii?Q?WEXc7C8GG3fgpRWsVnBy6UVMegtJPTcANetjR4HSuNkFhqeoFDXozAa0cab1?=
 =?us-ascii?Q?zTDL7qMWlU4UDUmQpXs5/Z5igZ+FVpNh2JJvIOA72EX3ViO8TR/WFSXJnjP7?=
 =?us-ascii?Q?ALKSHsKFizytkvP84Dr7jVe72u7f7Hc7VA2CfytwUlnHL0NFiT7Co0uu/rmi?=
 =?us-ascii?Q?1tzX3sx/Lo/4v+MebFqxbPgVfoTlakfanNpN8cn2KkHCgrKXf1y5Q4ZA0NT9?=
 =?us-ascii?Q?LlGt3r4WnDE5uUWsKbK7tC3RgIs/8iID6kKli3/5VmhCKfJz/ojRbyTg1iuS?=
 =?us-ascii?Q?4whfhsopYIetQi4BOH8+dLBP/wUlN+Uw9zmjK+wK0AOizL+vAzYDc+xx4jlL?=
 =?us-ascii?Q?2XFfyb0D7K+lvUg9ktZVm4xblsW8X6uZYWknQQpzRtWaMtMVyO6S26Ix/Tpp?=
 =?us-ascii?Q?9CqxqhMUWu/8PmFn4qGAOSX4+tna9VjtKl2XW98xf3FFZKrO4Gtf5lVPaQ4e?=
 =?us-ascii?Q?4RotQIaFm20+OGyHy+P2C9zjy3XWnu8YzUPf0wtkydXretlACRG+FzQhNQUH?=
 =?us-ascii?Q?6dDrhfB0FsylM4CsEL4NdDYI0M/aY369UtvL94B+oNTtfUnmtqrtf+v+Ebll?=
 =?us-ascii?Q?pfTOWPa3Ks4E8mc07rHxnFR+sBK1m+f2JoKTnuiDY15qV35A8+DE4fqNzH3M?=
 =?us-ascii?Q?fPloLI8sW5SN9lYkMGzeZWAMtiyVuE8ND2i+k9gmL3ptAc0vZkI7Tsy00gDR?=
 =?us-ascii?Q?NlWOYttKMpstk2kNnrC+80jgogPiVtkiNvO4x7By30jlAv2FDmfZbR8gkooW?=
 =?us-ascii?Q?Jj/gtxRqPsthnQBwvqpt2k5PSiSO1jZzyH/BSvpZW7o4BuK8bcxdr7ykjHOY?=
 =?us-ascii?Q?JqRMD7o6lZ2c9l1v7HI0dPwA153xhMWfQIyuSkw7FjXOmooZI4Niz1PIpQvd?=
 =?us-ascii?Q?qg8maImzr0rBx0JokdbgKO3+zQ3BLWvHDP6K8XZL4K97FnF33skTa+C3PBUQ?=
 =?us-ascii?Q?8Ejnu9dnhMvmjUo31vd9yKjBuNYyxHs//BpQ4aeqzY19Zn4xRI53hYKIVeUm?=
 =?us-ascii?Q?g7+kXPxZ5ohVWuGf89JjyUxJvC9rnfK1+cFBg8AkIA6etNLMoDPxUOu4MmYl?=
 =?us-ascii?Q?g3oQ5H/YJwYkVjxlVAowa9uKQF//p28sGNULN5eile1LTUjlJF3IjlD9pzFK?=
 =?us-ascii?Q?pF8VN2GnKjvzbhOTC4NnnVEb5KYrKnuYIqxz9ZvMd5M+n0kqnZLzk/L/E17w?=
 =?us-ascii?Q?5M1KeUp3jA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df60d77-98a0-43b9-ac00-08deaa8dff6e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:06:38.8530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c83JXpEer8Zb26Uw+fI+Yk8qfB5+yN1OhjkjYjubGwhIEmbvANRIiUYSET7FpwZGylz2g/24M57G0fNCaTg9vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8308
X-Rspamd-Queue-Id: 052A64CB490
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7516-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Since the PHY provider API has moved to drivers/phy/phy-provider.h and
include/linux/phy/ulpi_phy.h needs it (phy_create(),
phy_create_lookup(), etc), naturally it means ulpi_phy.h is also a PHY
provider header and should be moved to the same location.

The header is included only from drivers/phy/ti/phy-tusb1210.c, which
confirms that PHY consumers do not need it.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v7->v8: patch is new
---
 drivers/phy/ti/phy-tusb1210.c             | 3 ++-
 {include/linux => drivers}/phy/ulpi_phy.h | 0
 2 files changed, 2 insertions(+), 1 deletion(-)
 rename {include/linux => drivers}/phy/ulpi_phy.h (100%)

diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
index b7080403e649..5af809231c92 100644
--- a/drivers/phy/ti/phy-tusb1210.c
+++ b/drivers/phy/ti/phy-tusb1210.c
@@ -12,12 +12,13 @@
 #include <linux/ulpi/driver.h>
 #include <linux/ulpi/regs.h>
 #include <linux/gpio/consumer.h>
-#include <linux/phy/ulpi_phy.h>
 #include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
 #include <linux/property.h>
 #include <linux/workqueue.h>
 
+#include "../ulpi_phy.h"
+
 #define TI_VENDOR_ID		0x0451
 #define TI_DEVICE_TUSB1210	0x1507
 #define TI_DEVICE_TUSB1211	0x1508
diff --git a/include/linux/phy/ulpi_phy.h b/drivers/phy/ulpi_phy.h
similarity index 100%
rename from include/linux/phy/ulpi_phy.h
rename to drivers/phy/ulpi_phy.h
-- 
2.34.1


