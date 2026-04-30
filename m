Return-Path: <linux-can+bounces-7429-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKHcKd4382lgygEAu9opvQ
	(envelope-from <linux-can+bounces-7429-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:07:10 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A75244A13F4
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFBA63006086
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20273BFE3A;
	Thu, 30 Apr 2026 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nxJqJXEF"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F54E19E839;
	Thu, 30 Apr 2026 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547223; cv=fail; b=q/seDnvYZdhN/9kZlfRRoT47rxh7LrNJ0Q8M8QdhSSDaVi9sT58gZIzbIxMTiOtpMTkyyidIR0i86tSKIr8fg1G+IOGifdIsvUOUy/RvXtMZdl9LIuIfLGRTqYjZipYsXZqZeDV/VTzgRU1Zl6yUK8+Kx3WsEWZsGcVsaTlF3bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547223; c=relaxed/simple;
	bh=54G7TRODDIJN8SbJYv5ZtcElhkwDxxe+Ks+m6aVW0pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lRPdBQYMW/NWoFByx2qpAoQwNrz/85BXjS7eT1ERjO5MQZrzSKbLdIifla4JRbXUNITiZTYc6Ttn2KRXjyMWsZFDAdyqdGCCnFQI/KqWWGEYXZlS6yG/fAK3HqILt2wePCZE3jeeFjUZ3k+0/d+sSPh819x4wmvcAp5chECUK2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nxJqJXEF; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdQIfyoWPcYB6jtqZvwZPYRnIPS/BlBittLu8Im2OOYOwP/0Eh5P9Y/r1tmVIIubdOw+5e1nyI/8TTJPjPHkT19/qTRxHQnwj8060vAad4U6qqcuMvQ4PUyTaLp6fx3toAt6L7PdAcycTShDCSUErFteKM0XsLfIDV3dSMJxGX+TEhy4JGMf0e8/FODSzXnAhro6c+N7G4Wg7xVyHwR7hlewGZgh+Y0W7KR+GafUo4t0F1Ya93JiFrwAmI2jT4XCQVPc4mxqnBRy356OIho46oQNYRiUXHlDgx7jftQDMk4eGRRuwAAFL9uBdcLY14FNJum6zd2HAGlWx9v1UBCHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKwE4FvD116+ghF8di6dMrH+jwBPGos7uX0Kschl048=;
 b=hxXJYTl5wmCfv1EIsYQ2S0KHgt7taYs3PoRhEiXSHhUwpZwKSLFO56l52hbhBBsuRGlaPNT68lpWd1p92zBciiUFeUQkXdNoxhxRjOACgfN+Xzg8na4tQ55RKtZVILndHBuQmrc4BFXQaQBAdjpVqJp61+UqMl6y5Lo3gosAuN2aR+BgxWEgyjUX8PpvTtGye9jBXA2Ooaka6whUnFeAw0/oV2C0VMGmh6HGB/pkVHYWjq0HTZWEvQGHyljqe1rTYaZCs9aLKKzWrh2VMD2hB22/SV0+2B5i0fFLCT27ZXQfZUt2x6kLYVRdBZQ0u7KYVvJ0tSo5GOco9iwYLOzy3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKwE4FvD116+ghF8di6dMrH+jwBPGos7uX0Kschl048=;
 b=nxJqJXEFNKOsHI2AvIlYgLKLU9Wd+6X2TUFgVhcDo0T/DOgmXRkXa8RtBcTnnZjf9hnyDEF5XlmEdTDR+fv9PlToC8XKOWDAfnifCMM8k2SRJRgOJJFe/meWxDer2yCvgsoPxIJqblVFNm09KlwnIWbv7jwleCq71gE5zby8nRJ7oBTtfzhTsF3PYlFQN8ZCtnMPIu76FiF0+xZAIBwwiE3tw7QNr7E5nkTYnySpb8J5DCPKE6rXylqReVJc77CGVhywCOemltbxmdpVDGbYvo+IiXJkkO25gJViX1zZ756ILEzmGO9eM79I+2df/3FZmRFKIBr+KljabefSp64bdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB10609.eurprd04.prod.outlook.com (2603:10a6:150:219::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:06:57 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:06:57 +0000
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
Subject: [PATCH v7 phy-next 01/27] ata: add <linux/pm_runtime.h> where missing
Date: Thu, 30 Apr 2026 14:06:26 +0300
Message-Id: <20260430110652.558622-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0123.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB10609:EE_
X-MS-Office365-Filtering-Correlation-Id: de4ddc80-8124-438c-4287-08dea6a8983a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|10070799003|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sEcQvROVo7d0fMsWAsl3bByT62/dYS+K10I+wm51Jxe5dnTidsjxb61xbvxvPgqH268OA70rnfRaFWZqJZzM2aqqbI8ZWhADosUo7zqo8JLbmMyOJiNrE0gNJHrfdarxOvItNyt5MTBohUZ5f9/K2RnYO1LWjRYlVxogj6SNeqqfVVjkxfSIUuIbEJsOP4qCRHnhO60OU6ZaB1H0fW6YNn5xQgSOEZavPYHGyVFS9eoqWoO5j3wzEUN72kef9OHOnFf+D/XE1+8mOsZfmIA44uvAkh+lT7YJXtvri9PnOHUk0nj8GUvIvMeiDUxb8oC+Z3eZTYhDq1+Wm0277cbwPccA141s6w10HViOLKJJhelE5K2Ube6Ko4Pvt/ZeQl7Sz9OFWN0UuwSYhW2//qBQP/AgQOGdB44GQLQ9tDo05m3TK+cnuM1UQokyJaGGXYI2vehqUnJ1PuNNrl6ARUeBWP+jOJDikRMavKBEz+5vWmlFWzNyLUK7K7GLRz2ZF0YRTRoh7bP6Uz7Kx+qI85HDwVN2MUw/25eZWFQjl7zRSLQZ7yx9FWVD/2XwM/r7EfRP/nD170mGkBAyQejUSyGkJA5N4LYOtvw0YIE8sogJaf8E6wQX/dFkq4/WKzzjiRXB5AitlIox4NjeI40wd4gbAcXB2R6HO41Rabw48QOnZUxRdaNtAJgvMBTtvMcz/jVkKiibOExrsvCw9a2upV7yM1SGkBdUjHiuZ5kqNVzpuyc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(10070799003)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P0SOLbTZoYyfdxaZE3qsZ0rI5R5eJBqx4h/ZD7CH+kposvovyzvCCuMmoP4p?=
 =?us-ascii?Q?+QTaUJuM2rfpUhFeB5lsLQUGl849G9lwKI4xz+4hk8o8bxagK56vGB/zyPLZ?=
 =?us-ascii?Q?QNCgB8ycTUz3Ff/s9ipqGne11I7vohpFdXt5IoXb1f1S8YrTrZfoG5eKJzu6?=
 =?us-ascii?Q?8cS4EhrGOQ9O2ItYkaEUP+59OKVcdbUK3dHMbw85Hj+TMi3yRAaL1rlTCOiz?=
 =?us-ascii?Q?Aelcta1VwuPyeJSBkdE9xMcRl7urYSJhTKtAMRftCIb2rRVhljVBiDgSwuvX?=
 =?us-ascii?Q?ykTrfY4CWwdmHjmxxxREeDFBpfdkoST8nzw9vFoZdBVcyTEhXdd1IL7K+QX+?=
 =?us-ascii?Q?fPWxvKIyM06NE7zqD9btG6OaeuDmbbsbb2I3/uA18n0QinicLwoo1PKKg0LZ?=
 =?us-ascii?Q?IxQKKWQni2k3Or5flIuhLjb+SH59IYVmmByOYCY/x/yPESf5AT/OHUMGhUZp?=
 =?us-ascii?Q?UAkHrXp93k6oTECFbfk2/dcoY1FbWke8TMeS8LHBVSYFtGMKAAcuKq07r5ur?=
 =?us-ascii?Q?zkYRU40C+EmYIXK5n54ueYTzCpIIjDSkPU+/cAa+23jnH/kAsPPpZILx4xSf?=
 =?us-ascii?Q?ymjJOJCFazkfKtho6+bYzgitnYG3lPytG4YFlgjVuuzQlO75ujh9gNHsLp9v?=
 =?us-ascii?Q?F1Va8qMCcTehVaWI0omUNwHPVeTlWYbLBt/HfGXkuJf+C++xKyKxQ8+ZGyfe?=
 =?us-ascii?Q?S199DL/cmad2XX9USasaOx7Oa4mGwf0osnR7ukmUxbYVPGYKKJDsYGiGTodO?=
 =?us-ascii?Q?9UMmfyimjLtRtEEhYBqJkNAvC8xTX+mmVKMk/xGMMe43yOuY2t2Z9ciB9eoh?=
 =?us-ascii?Q?IAaJ9ABM2fWqCN1UghJYPReJIwC2VtJq7cbKBXBSCwsvwPeKqFfarymNrf+n?=
 =?us-ascii?Q?xrhDOi6dcuE8TtK9XRcDcZw2WCD0MTIBZelccwHnRt6gCC95qedVMp0y1MBC?=
 =?us-ascii?Q?RlMIALJ/RL2RYCDtJxim/hJoVsKrNvvNh2uyHCblyxEBe4N8QCfWrlTLflew?=
 =?us-ascii?Q?SEy+9Aw/L93ZKuOQQInI5UhafHjWfCulFAGiUCv22I4ghi0VXcR49myS+Q04?=
 =?us-ascii?Q?5xZCxXIf7lI0FTkh+rtlMhMr3Wkb0sGfWz7bALuvSzIc/V5m0B93GUh9bGsw?=
 =?us-ascii?Q?uX3TeO5V+fvIvjVtKCDdlJNnLHMOvk/fG6Z8R0+sk5oJBFD+AE3Yza3NbRnW?=
 =?us-ascii?Q?XK81MKVKY2DXr+4nWecn92146H3PDZf39Wb9yeSnbzDjp3iXylHi/9Mt5P5F?=
 =?us-ascii?Q?BUrxe6BZn+0vDn7zO2R4A5kRQphje7KPEGnixKfByPtaZD6oJ6GCKzUkDINU?=
 =?us-ascii?Q?LtHXE8MZCnj8dATLanOwm5zIMxPj0F4QD4tvffJW2B/tPJgM966sL9Y6gtpS?=
 =?us-ascii?Q?6V0ui3NFVkEW5+SpCyhCaRPp9oEPpHOCVjQ6dgg5MsItE8TugQgrFuRmzyqx?=
 =?us-ascii?Q?x9jM8XIWbR9dYDnw2IED3gmewhjzxDdX/+0E6bXbDTdh4+rgB6abvemWC75G?=
 =?us-ascii?Q?SPeWvMXCrCcu3gPpwqJlAzZBxLEArZJoxkG0isC/OWiqxw63lAYMnEYz01Oa?=
 =?us-ascii?Q?MHBNAOswQ06f+31IIA7Qleoea3Dk5DegteQkZQ1KZrzy4D58WEX8+Ioqw2w9?=
 =?us-ascii?Q?ZfOtj8YJ2rkeDEL1i4o9jXY4bvmmboOKMe9Ou56QtWqsk2rk6Yan1tT7QZTa?=
 =?us-ascii?Q?xg/L5qU/e2MFDEUml2auCpuRNo6NomCgjtjJ5THcsigb1bzlrsEOKiU/zftP?=
 =?us-ascii?Q?spAhUgMoSqi55zKl2CSuxU/8BmOoPqrWTkjS7CgeAaiPXqWEBbWi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4ddc80-8124-438c-4287-08dea6a8983a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:06:57.3816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NEkdICbkplZeCoO/Rvm+/OYm5Zkf7K+qSqYyoTVhpt7htG3YtPI8OFuZIiAxw169ax55rc20WBHorqr/rF+kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10609
X-Rspamd-Queue-Id: A75244A13F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7429-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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

v2->v7: none
v1->v2: collect tag
---
 drivers/ata/ahci.c       | 1 +
 drivers/ata/ahci_brcm.c  | 1 +
 drivers/ata/ahci_ceva.c  | 1 +
 drivers/ata/ahci_qoriq.c | 1 +
 drivers/ata/libahci.c    | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1d73a53370cf..1396a53bd6df 100644
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
2.34.1


