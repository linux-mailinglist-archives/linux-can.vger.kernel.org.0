Return-Path: <linux-can+bounces-7030-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC/fDw8br2lIOAIAu9opvQ
	(envelope-from <linux-can+bounces-7030-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:10:07 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D453B23F3B4
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F144C306B2C5
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2B2361DD2;
	Mon,  9 Mar 2026 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bXlUbYBx"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A73603D8;
	Mon,  9 Mar 2026 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083354; cv=fail; b=JvmmCfwIYdxDpx3LkNEOYN90E6U1czLRF2iRQMva2WKWvEocuvePciwDoaTNiDa3dcYSAioneH5SESoWZ1oKoNfJfNVs8uibRUQ37K+6i8xL8B4cbL6+CxVkSxhr7rEumi4/H9cxvfX6DCHhMnqzhZsXUrjkwXqyXM2DsKjmSgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083354; c=relaxed/simple;
	bh=9f4t/udBZC95eW3i1KBD2fUZKVLlC8hiP5QZnes8z7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ar73nZoN/+7fHZkHA38jnaqorZJX7DaG7zR3S/IMDVT0BhxwhLhJjVcEy3HckkCRjY7X865auBuuUyC2O7ZVoV4RYl+6ufoAiyhvsf8ivHF53ycjB1v2MRpPZSrFjKCIroE84nbLTMkJGC3Xlc6sv2D5vB9Yw0mVhl1HH5MuPrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bXlUbYBx; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJXk+VF/deM0vHBzU49AzIimgyQJOhLHPWzNU3UOFryU5IOSbQ4gcmXd0UQW05H+iDSpWrnQD7XNsqo3tOBpXOToNeRL39Dm7FA1YxBRA/yR/VNokQ5zPoA/Sit18mxtwP9YBkOXvnTj4LGlYpfYClbkk6qk2iJ+GFsxVgoVhBYfd6n/M6FaTUEum5sZJuRryZxG9h+X0bwYJtOOZjojSbCmA7SN0XltHU0HRfAHETAIzrjsiIgBHEqFPbGWcqFAolhzhRzpJF9FFA0ENbjnsdNFFz4LLo+glh6BCt2xBeCjaXQUDwIXpYrmVXg0KoK++Gxy9YXfRGvKombZVdWS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvaC+XnCNYSrwp1+4GR8LG6J+QqxiDVV5InTerYdxuo=;
 b=Lp+dsZmGxyGsFpmCVUk1wwleA/A7epSvFUMXFwC810MWNazsbDocTu+AJHOtwCJEo4vVDa06xixxbv71A9ZlBEp0bLWRRKV3K1LJ4l94mzRE+RiEs678s2yNvuqIjjR4hfeqRQnvW1bHnm1kFsCzUjXFNxGE1e8LYB63xFKIhjWqzQ6SI058+TG0tOT0V+iwjBJIKwJNh82yoISorJrw7IETNCyq7NNZnStfZ5ObCHA3bF38wQIx6zcVOIw4fMzmRvMzLIDtND+z+K8En+/gJ07q9/SDen+5YGhxJwldgtrzibhsOQ18OehmFwhjFK0TDr40z+Fup3ClMgp3OufLqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvaC+XnCNYSrwp1+4GR8LG6J+QqxiDVV5InTerYdxuo=;
 b=bXlUbYBx+LMhS8/uqGLLwRtgR9KBNkAhB4JMQEMrR6EuH7+XY963TMwwid7Qr+zvOIq07Yt/aUMC/EtdjsK1hG1LrTcfqYC23fSSYwrbMRi5osFKDu6TeoWetRnmdfDEfp6kW4tDwCw1vWvG5nEUOP/bLzab7Xv0MN0Tn3f09hug9NNFVZjeUS8aEfau+YZjPG9edxTOiCTcORoAUhfb9pEKg8DAtHhIYdN4wp89BPI9qj8AX1UQhAs4LDASWZFjv6n2oD4Y4YpQgY1P1J/XkAFHUJ29rcYo1p0iBQgescwa+D/VL0QyW64tgyeEjCY4yErUH+OTOBB2mXxbppG3Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:09:09 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:09:09 +0000
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
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 phy-next 01/24] ata: add <linux/pm_runtime.h> where missing
Date: Mon,  9 Mar 2026 21:08:19 +0200
Message-ID: <20260309190842.927634-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0179.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::36) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: f65ad207-7521-4d67-a98b-08de7e0f575a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	Hvff6ccmFuAeFSu2lo7tngdk2OAxQLUg+IgGEiduWfdNN4ohy4352Is4avnXIPgfzbue2sEuVAWEqayWQbkTYJyWctjOHQFaQPV0aQ2OxTwEhUqFKIqVynMNZcKXjDhHbsxEqv0aHcVfTTawtqUVYEJY1o7rxi7XmWPsPWRgpYQttkY5Owq2lWPmSbbmzdwcCtYFgBa1cwRkmT2+0K9+xGaAXlWL0xqd3aLAMUivcSAZMfHWjWWg+tsi5x1NZwhl0lJXNH4dQkj91G47lSgB+BjIaOvA6ZsRNyDwZcWWWBMvGEq2WQPyaDAXXkhuRC3U42U8PoxWA35SrZ1PszfWbfZNejyAEiQq+BWLuPajqwHJ13KSpX+l5bSpXMSUsfqqINMv3QjCN7ACkt5HRs6+BvtcXD46AppbvStmaaDYmFf/YIQQeOxuSo1Atv1i/RtMMWaOvaFIEYhG0RowUoQsxMo7pwVHmH1dQa9PQnWevVGQ9m+b90vugzYVb9aFUysnFm1f1NzIboSsy6LxT5TO6a4gqk9cVQiABfkHNeH+uuvd4gL/iuHMRuMulbKIeBiTH5S8xiOAE4PPbglIWE0YPw2fJU3KEoUG4lHl5ne2QdxReE71KvGXk1kl3gutvz0zjklnCgz719X5nngYKPrT5grXQcIzOKva3Lyhtk3z6qt6vjnpereSSBkmI/tGZHo7T0jbdhcMIWYaBQy6x1zGxIol1CMF+RbdwDz43zQcZLI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jw23+WojDlWVnrFsz1lysBQgrsARozEX9bKp//sxWoBgG33+nEQN7zcHcDa/?=
 =?us-ascii?Q?BL9RWldR8GEyVPG/HlIbZ+G9j4XM+D//4qJb3EkULKAC/oSjfTtDq5jC4Uhi?=
 =?us-ascii?Q?Hm/90YspGi3yuSrEl6riOlSPYZSwxA2dS6DSQcXOfBaXLyt1MiuzkfVAMGdE?=
 =?us-ascii?Q?oanfWzt4CzG9x1WiSsA2LrZW76y6IVQoojEKaz/cVfJmW56uK+2AV6TuBpkn?=
 =?us-ascii?Q?7jucg8oY94OiArUMfo+HRTjKPuoauYRYJiIR7iMBDiPh9l/4KLnucU89ieFP?=
 =?us-ascii?Q?AlxT47imE2HDnT8ZDMbk6eQgfMnLeThKvFGfR0yCxPsNZWz+mpawcH+Wjvg4?=
 =?us-ascii?Q?jlSO2o+eB78dR+r2yb7onCBRjrqkGY3UmUDLS9UIlyKkFWNMGV0pUnF4z66p?=
 =?us-ascii?Q?DOCscLNjyQ0EH6G8rpq6LY0d9Kl2V//a88t1xY/GvkMWMH+a+6JiNOT1h/wa?=
 =?us-ascii?Q?W3qUYoX4QrwfHVKKcxMvT4KMj8moUCuXAZZQVdYiJk4N7tV8Hc1WRKKQLqje?=
 =?us-ascii?Q?N2JXWeV5xjZhqW2hzVrTIKh/IsQDHDvl3IuiGUyTOkrfVm6ktedLtOuBWFRX?=
 =?us-ascii?Q?8JmHmYkqgrNqgPqxyZo9th7seBENQOIlXMwwNjbXL0IaNpbFMxhF8KAZ3QcQ?=
 =?us-ascii?Q?aXStNN2wtpu/q6xTW28qbwWyDXJ59Yk2Y58txZ4zKHjZLnbGGkYRFEMcpj6A?=
 =?us-ascii?Q?wkk/VapM3AZOhEsOm9JlE8ok24+5jXTndd/AZA8nGKAOJBbjlXursurgNuXs?=
 =?us-ascii?Q?Qb7b7e7NrFOnz0aD1cPPn+Ozp1yyuKCWtDWvqoVj8gU/ilSKJQjflyN2g8no?=
 =?us-ascii?Q?Bu9jdurNTLJUPwaBHPD8lWQiLDiFbW+5JqV04iOY4+r9uM4ueCd/K42SC7NV?=
 =?us-ascii?Q?BlHdiQCQV1h0XU5hlcEyO+wJ+GfzQj7oAsig/Erfg0uK2ov6BLhL8d9hiGbX?=
 =?us-ascii?Q?6YdgGngz23GMqSCWQhZwezsNZoxfhFSwQspJF9qdkAmGv+NQlu+I5fX+uagY?=
 =?us-ascii?Q?V9pGahsBab3WnKxtMrH5K4b2t3CDf8qb/WWsQ16WsXH8gSBcXJWiiNBPO5o3?=
 =?us-ascii?Q?H48z90rVY5/PAMSsPWCWoin6MPuGNDSfCs7es97VOtcupff/i8DGrBGB9wTH?=
 =?us-ascii?Q?OPfLB63DOcBgTxDnO7EuV6bXwKojrOp5nDEI5MOgFgsS4EaSQh3bU8GDizaa?=
 =?us-ascii?Q?BmCrIp115KKz8wqUJaIiz4+JpvdlDX+zXARcFCgHdoXz5/r/d1mzHsUVPpsx?=
 =?us-ascii?Q?wZnyzJAX1qFPXQAKde5fT1IeBtX8lYCb+zehgQCbltp86dY5MpewZABNmZWu?=
 =?us-ascii?Q?Nxd2ZdJppCOSfT0ghjUT0fIgUTRKC+Xn+WNc6PFSgu7L0yNUO/sHbuhPxJzY?=
 =?us-ascii?Q?m//IzT+uZ+k1aUWBYiVjrWQjGXluEIJy5esGY36CgJZgdkBQCYAJSQacm2ZS?=
 =?us-ascii?Q?Bv8kSo5GBF1q8TrUtt5TCufAZLeNBvwGDn/g2v7/k0FOWCTgR6UO536mEWb8?=
 =?us-ascii?Q?36grsqyVIyIcCuzIjK9bpw69sa4XGpwTYJj5s0/FiFlfHRfag8SyxbCscC74?=
 =?us-ascii?Q?t7L00kZKrB18ooLp1BG2PDui5jDOv1TFxkvD+uaTNVidAsFlNwbIOEhPSMKw?=
 =?us-ascii?Q?oRvO6xV7vb/1ChT+4yhRsxNNGWm9GpCneB6yXS93fUh11r8bcYv/aIPyny9a?=
 =?us-ascii?Q?gCY7LoIY1H4XX/TApfh8fL0WT5G+YZ5ZjPcpQpYsWW7/07Q7000B34JgbClw?=
 =?us-ascii?Q?QlbnDyprAlQOgH3bJgBrbJXXRpnXqqWsLjwGI4w4b4RqMJbKrfjlKoeQY/5y?=
X-MS-Exchange-AntiSpam-MessageData-1: qvqvhjLZNtLTrQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65ad207-7521-4d67-a98b-08de7e0f575a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:09:09.0057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDVA6FlFuWGxDJ9yPuE5MdFEVvBxDnYX1f5EYEeG9j5K6D1IArZlPlrCLNZ0mJup2b6JRDIpcb24thsiQ8NCPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540
X-Rspamd-Queue-Id: D453B23F3B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7030-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

It appears that libahci.c, ahci.c as well as the ahci_brcm, ahci_ceva
and ahci_qoriq drivers are using runtime PM operations without including
<linux/pm_runtime.h>. This header is somehow being indirectly provided
by <linux/phy/phy.h>, which would like to drop it (none of the functions
it exports need it).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Damien Le Moal <dlemoal@kernel.org>
---
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>

v2->v3: none
v1->v2: collect tag
---
 drivers/ata/ahci.c       | 1 +
 drivers/ata/ahci_brcm.c  | 1 +
 drivers/ata/ahci_ceva.c  | 1 +
 drivers/ata/ahci_qoriq.c | 1 +
 drivers/ata/libahci.c    | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 931d0081169b..aa3c4949c4ab 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -26,6 +26,7 @@
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/gfp.h>
+#include <linux/pm_runtime.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 29be74fedcf0..48460e515722 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/string.h>
 
diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index 2d6a08c23d6a..3938bf378341 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include "ahci.h"
 
diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 0dec1a17e5b1..409152bfefb6 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/libata.h>
 #include "ahci.h"
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index c79abdfcd7a9..e0de4703a4f2 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -30,6 +30,7 @@
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include "ahci.h"
 #include "libata.h"
 
-- 
2.43.0


