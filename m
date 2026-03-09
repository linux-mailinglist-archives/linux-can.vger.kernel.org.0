Return-Path: <linux-can+bounces-7049-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN8JAJ4fr2neOAIAu9opvQ
	(envelope-from <linux-can+bounces-7049-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:29:34 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D57623FF6F
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07916322D731
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E83B42E01E;
	Mon,  9 Mar 2026 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GsVp8+av"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2243942E002;
	Mon,  9 Mar 2026 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083418; cv=fail; b=KVYrZ7n48l6BOUtvS4OGmyhEaan6/iZ0qWdL39t2oj313T2VZO1SRQ0ykMBPKuanCm8Y3r7YJPx+PHP3cklkKqqg5Gb367V7tdLCZxwe/lYub4poW60Vx7taSXNwxz7C2qTnj1GLNvmuQdC6egE/++vEH17qgt52BHq4iwalsYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083418; c=relaxed/simple;
	bh=shVGgS+ge2BWvvsuacisXxWoR0FmoWgD+o+7yYDaYdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=igHHEO1yJu2VgVRLd8+sWMvvODJiWRXIMYiEuwElOEg+ZO/Fq4B9EIaJOk2EGRjXkJbaddB6FI513Q53Zv5Tr/G2e07etFGHzI1fSlen3jzxeEJl52GWq0gwI9fh8JNLb+0Dae2IjGyATAyReMtISGUX6J2gTaL2jLqC7/kFyJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GsVp8+av; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYEAQ0G65xTrKHHURrhJB+PPZ30wz7GCZgClRQvxWfPupH8+QCEWLjI8CdHs1xbaYKk7wTahCeoHMiAF4ohjTy68nE9GnBgonuL11B/MXBYvN/h+V0X/GULszWww8axoywY9HMrmAAt5IH81EcnpDH38RNqWgVmpVetJPp6JHhQc3AXlh9lfeTd1ndCz6NgLlsYmrhhwp1ToaYjVZt8PzXgkHXi+d9vv5SQiCK3ertgRimCyXnhw4unulANt7gKwofOkoNHIPa2eIz5rKgZmksQaeHMahupje+CTIAkhBb+w9oCXwRZzHJ929JjBhZib38tSgKJAPFBHd2Jxw1hgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8F4UwhmG5nMd5uWeVVTdEe2DUNhsIXNUFtoDOFAwBc=;
 b=ibFW7KO/vFYWa5sy9ARirS8LBvHecMLnQmaVxAqr1pV9g3l1J1h9KTzf09LGa9tdtfElxRiHfu8WCta0bqEJhVKaJ3BEkw+6/C62BHA8lR2KtWQYSPIxtN5HokLAkt6YcB7H48ZSoQlpx9+adImJbfKx0oNQotDQ3B07r+iMTFMTpqMvpl/EVSU303vXzLRr30f3oKkbsPZp+f8FnztM9vWMZHU+2fFtWBOLClGLJW91b7Fp1U7EG4Iu29SLKnTjtPGeUPgMHZk51Q+QKl5CGeDeX6An8ciGfSLT5tzu+72pz3jW3wY/CpUC78w4VpARpEwI7p8xnQiX2X/Q103WGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8F4UwhmG5nMd5uWeVVTdEe2DUNhsIXNUFtoDOFAwBc=;
 b=GsVp8+avXEPzL/aFBtWFFErRG/BwkWNKLZepZ3HSk/N2SHZKwENCvk1q3iqQURHNyg+bmLYhypvVJJ6N73bntmlNN4a7DJQ7vC8aJhrsnYVhMvnTL4HNVxDFsdCz8seullpLphXYw0lelf4yfXCIycSCoY5yCUNLOSYYtA7XnjNa7IrSwwcYWukEIYq1+2HXpR6OvLiKA6qN3DuDF4/pStPyuHOhOAhtULYuumSW6i9WXH/SFr+KlEvrL85KLC2+kM4PfaI2QRvCXiUIr++A/iBxnuBsXAUKaHbyQ8aJy13lU6/UoRCkUj47DEvibLIoZZDHHnbqtkpGoleTse4wXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB9841.eurprd04.prod.outlook.com (2603:10a6:10:4ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:10:12 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:10:12 +0000
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
Subject: [PATCH v3 phy-next 20/24] power: supply: cpcap-charger: include missing <linux/property.h>
Date: Mon,  9 Mar 2026 21:08:38 +0200
Message-ID: <20260309190842.927634-21-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0043.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::28) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB9841:EE_
X-MS-Office365-Filtering-Correlation-Id: ea141462-e48f-421a-08a2-08de7e0f7d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	bUDln58pB2iW2wpUJwpE48ibXyuq5DBfxrVoU5VBliJt68VJQvYMsQ8zXobuonU8G1ho+msyrRlHGPvS/lmAu06NClgs2IMZtMWaWXnsLXa2SPqhPMRbJd+4kdf0DYuWHRjvFimCEfS8EYxk+5/eaXbnJU+D5xQa29hdFuSN2oL3v/t0xMwbXmtdvgTagyJXp6+yML5q1I5wTEMa4/VLg1AQ4jw7aJyPftSbCa2SgvstRb3sJsEidfP83Qf2B4UF8/RNIaj6OCp8Svq7JCkHftiBUgJ55NoV6hEjhMOb/schiaCNYZ8oBhHgpYS3CiisZhiQZFrk7HG9ZbDDRi1tkmRTPLzUgHJoPEOd3mhWL5u+V8+u3cQLI769zgCSAgYIRwhLaRBxXpfcJuFJ76F/MvUvuuze11qdDx+viWWQilRQ7w2b+TgNAE+23N3IEPK1e/1LmXIhNS+nQ4pUhj2SeJv8STwRntYtBdFfrM7Qhe9zuAXh53808rLX4o5PwlEtt7jrmbJctZ2uedvUr/owtE+4sPnP9M7Mw/ITSvmzQYaLpXFiHPd8rEBc8oRLq3KlRRmlMC2fcbrcheDcaIZ0Kncp6rjeOiV+qkyp7mZ8CRpAvx4sQe86/F/MqcqB50Tc96rH2XgUhG7tGY8k/1oa0ldOGKZbB8UZ8I1V2sOS/p697Pmg81MTiUTa9zpxC6KGA22DiryNnAxDxD2GOlox9iNeJzwObYtI3tiysE7Kl50=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZFg8Q+GkrNvWZQQEiOgX30jR7D12d+cTgPGelxm3hThlvboOzRt/aBZR/SKg?=
 =?us-ascii?Q?+CHtR2ziwNdH3KXUXU/C13PzD5NbvoNmk3rmnJukGUOu4EBtLGFX6r52wE0k?=
 =?us-ascii?Q?c/moKGVhLHD1H7mGA9zVf66woitPSZ02FE4QqCKM4IewBoY2b/8kR6sglCQy?=
 =?us-ascii?Q?X4r8RdwSoxRNM1oporxJpQpupFtDQTljX/plbNOvTJ92d4chDeGRUaD7bU90?=
 =?us-ascii?Q?HwJEqT+V2MLZKharIgh7JvvpiLNEpxmWH/eL/0sNaS8/X944SjenmD3YZ1Rp?=
 =?us-ascii?Q?qbEEcBz3kZp/7rycUoW/tduBJt14UCLcc/Q/RyqGEXRrT6hhUxawf1lQyZph?=
 =?us-ascii?Q?TuQqT3ERqon5HO0Z6+N1G1OosJOUy+TcAlVTFPevqF8wiaZ7tGhy2+K/7dlD?=
 =?us-ascii?Q?1dCrq9yQkTIAtnyZfbdflDXrGowhcCpu/dFxLaRL4vN1vhXr4oeahYaef0Pi?=
 =?us-ascii?Q?lEFiG4oRNqcP4Wf+vza0DqdqmJw8B+MWY2SPWcLqKN3oAgJN3uOCgGryVRx+?=
 =?us-ascii?Q?jp6TKJ2skqeRALC9zqtmMK21oBjCbW3ybL1NaCAMUQQ/51sDd4X76Mcoy60b?=
 =?us-ascii?Q?xhqsHFqXcgMnY02gh8UsOGtDFkugGY9JprpKSRJJLQahePCjfufYVHGDGkL1?=
 =?us-ascii?Q?tVyJ5XptXvE0Urh5a7hNkKs0RggMpcjFFiMv7jkxiVh/FBAjk1ykVMTPFU7y?=
 =?us-ascii?Q?OWZJXGLccIlzlB2SswtQMNzadkF3JcWlHWIVVjCpI8Dd60YcGMR3qMzjM/7t?=
 =?us-ascii?Q?6lVQ+L13Jv+oDStRvi2sLeagG4sgqKIMJD4v/ORsf0v0vbbgZSO1PyCsBtmP?=
 =?us-ascii?Q?SQQLhjP1c1gsl690ez9wjVr/K3s9OtO2/nnbHGVUB46nF/ZunSGS8nTqvGmA?=
 =?us-ascii?Q?Ywqx2vnkUU3MEBOxIJUa3qpnSxZYiIHoti7M02vkQcMGbsJzCBY7BBYqz3SU?=
 =?us-ascii?Q?kGMg8S73AygxnQe0Xxh17fR/Zlat087tvL59Jz1wJehuwA2YVGT7wF2V/nlH?=
 =?us-ascii?Q?tv470Ge54mBErqzac/7jyTdVTXCsciCx5j0gYbI5MO64R5ePA9OfTgxI0m/U?=
 =?us-ascii?Q?PDmEhVd8HauE1EsKd+MxXbhVOfM2rzwkJGEpyn2NTuMLT7w/A0ImPLc24vIR?=
 =?us-ascii?Q?wyUzNzpkMpjnhjg42dn0Vq5vXZDS0rQUEpldN3F/ZBNCUK3tGELVIwLahRdc?=
 =?us-ascii?Q?JZtnFfOBTMFDhIYH2nNDd7DutzxyTwCwem2ex/PXtS0vvaKtvB4VSlkfbQTQ?=
 =?us-ascii?Q?vijZK3SWbk5+zj8rVT9xzt2HSyP1jhr8iCHKxDJyR+vAXD2qWWLsIXd+mkrn?=
 =?us-ascii?Q?/qnToLh/Y8C0iukAngXqlgpM1WFcvTxgcJ688QRRAk+95TC/pnedo6CC/iES?=
 =?us-ascii?Q?kXBOqc45czJlwgBFgv4hRwJ5RdhzL3RQIaRjraKV8P7JfZNZMNhLiE90HhAF?=
 =?us-ascii?Q?3EEH+Yfe/OBzK7Q2TRVrMCx1R8Mp7pG+GYwa/1o0UPPY/YeuulsvfPjZclej?=
 =?us-ascii?Q?PgcwepgzRw3V+SYDtMOZKUpitOENlqKijNP+7z8TimQhL0D+y/kl4j9fao62?=
 =?us-ascii?Q?aMoNAAjYmFF63y25Kv+vc22NNJOrFVjAYISDnAeGPyfONJ5zt45fFGSDpphN?=
 =?us-ascii?Q?zaAcHtt2HIx6lidCbQI4pzobHXJWa5agOcUultCWqdZod2itQKntggPWQ6Ye?=
 =?us-ascii?Q?UigIfsGlX4dYKfisbZ4eQ1kiqCcxzKCFpopSYUV78McFla683w2MF3pjA/Nd?=
 =?us-ascii?Q?FTmhsCkRET8mXt3jRaTFz9CZkpkCX96pKwVhRRRCEMiptnEuDywyG3X1uRun?=
X-MS-Exchange-AntiSpam-MessageData-1: Gur00g143RFtBN4SutG2DEm3TV9Zrb1H3YU=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea141462-e48f-421a-08a2-08de7e0f7d59
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:10:12.6802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWoiQhOhy2vy2Dwcio3f1Egm0f6ms7HwVTbWYCbju7zfYCzMimbBCRXJKbosphn144e2MYjDnzaJbWn5RpjQig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9841
X-Rspamd-Queue-Id: 5D57623FF6F
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
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7049-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid,collabora.com:email]
X-Rspamd-Action: no action

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

v2->v3: none
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


