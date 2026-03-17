Return-Path: <linux-can+bounces-7109-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ/CNK7fuWk7PAIAu9opvQ
	(envelope-from <linux-can+bounces-7109-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:11:42 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FAC2B3D8A
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DD1D31590AE
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0CB1C8634;
	Tue, 17 Mar 2026 23:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="erQk5dBs"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93AE3F87E2;
	Tue, 17 Mar 2026 23:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788750; cv=fail; b=mk0V+D687P4R3nZYGbv4h70g0o017z71esFDW+pRJGOrkjKhKXDgSP4lgx3UaC8N2w4Ktd6Mn7Wwi9+IKtYsJvvyBgh8olyAMuleUO06wAP1rtTIBBrkzFYMzibVoHK3ABebwYgdLTI23RvMNsYZ5Wbb8wN9qtvizCubVoGz2Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788750; c=relaxed/simple;
	bh=6Vo+MAl2cqw6Uv+EPZT/VypSQs/IUe0eGBkN/tojc0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sdmRa6Yfee9xBBZ1NkuNXOCA9yQvqYgMunydFEYE+uhsLM2zwbCV4Bp3rbfgsWU2jLV0NpoIVfvYvxM/V5LQHcgiitrB43IF4Hjk3QLhXbbFhhAmyyU6Q5jC8QXM/86tpvJAn42lx0Ym8eG0phpRxLfh0zpHCSqHeY/1/Xh3PFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=erQk5dBs; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPp4Oue2aZREFIN8T9B+XsSFJzH/PULZO1XO+kYA3fg1ws0nSrtpkS0kZVGfdC0nScNlmXWyhWepoaroOG01IjdS70Nqd/Mt1ADi7eQhYY+tm0wp/dj1C2Gt0TbsrvI8uFVHJOeNTUMSNK+SwD5yvBGiwptATJ4FlmOnl4V8fTHwYKIFJtv2SDNqEFiB1w5mgJDn7+wNvLs9kr3DuHn8MoHFT4zhYBOCL9yo9gi0CwlyeQhCe5YFUiFl6zTxi4jabKbYXMokiW3vhZHKyLRn8bEY2050zNwAoV0TTRmorXpsA2ONJ+5fTc8LlwJ94vH3+i4XFWrkw/h1z6PNlsDamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVCZxFMmrHcxPEw199KrXpsyKqfxBTx39LMKrT8fVBA=;
 b=wlSzfCfvvOZanoCxuxLKubb1f+cYWLNFZq6gPmUfunZHvhMtmUXVZtoi9LH9hx1jSVAE7ZzE3tNH8s/XZmUgaMsdOboqc1/CA899Yf3bV/qNdS2iyH4FDrslwx6oc4kN8F7xESbEh4APJ2bI6/HjUf/QD8RD5ORTKkgt3xuyPvKCONY+yEiWGIwsTe5dOL8uLn6MEfnU/MDuNi3Y66wMQj3+5O1/9k8fGYPuFynVuikWI3NRvdHJLDqBwFOfZvaxY9aaPqeHNT1Kc0dSMUxZxDnjaJpc2rqfFj/ZWzgKQCoXo3jhitI2fOS5kfwK2ffsrs6f/+vqFeHhyPOjNTUmlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVCZxFMmrHcxPEw199KrXpsyKqfxBTx39LMKrT8fVBA=;
 b=erQk5dBsuR3bQHzKWnDCyZD1sR8hvNTeqoyjeRbZ+LXSt0PyAdTEDd2Gs/DPkI9Z/l74tGgUjeCZlR4t5daBaXFJ8Y3M3piiQwqn55inIcjXzpiNBqQPjkr5xf3/yQ03QMx9qTPeG91oPMpICtgSN1bCZ5LaoHcVz+/ofhTWNI5PVaku2kY6LVH421O0j7h8JqWCfPTns34AeVXNbXy781Ll2/5yrHyTp+Qh5BihU41JXJAiOte9E8bXhqViLzL2EhoFsxE1DEoFPPIFI+HQ3L/d5rfX+JvTZiHWkWY8oD9EqvohvEprMFX0YQ2QWe1lLBZEx/6bLrHNayxaANz+Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB12032.eurprd04.prod.outlook.com (2603:10a6:800:311::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:05:25 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:22 +0000
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
	Yixun Lan <dlan@kernel.org>
Subject: [PATCH v4 phy-next 06/24] phy: spacemit: include missing <linux/phy/phy.h>
Date: Wed, 18 Mar 2026 01:04:42 +0200
Message-ID: <20260317230500.2056077-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0047.eurprd03.prod.outlook.com
 (2603:10a6:803:118::36) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB12032:EE_
X-MS-Office365-Filtering-Correlation-Id: 9477f939-8a49-4bc3-640e-08de8479ab03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|19092799006|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ks+owPAXPwIGJ8mbE12BLS3BQtURRjqLLF0ErzoO/+5E7wH+Nhx+NTJrUwddr29zTIsZFnwVQFBj2xTw00D5COy2p9PxGqiaaTBntEtwJ4X2i9ObB1TkfZIJrTDzH0VqMCfjTPKp2V4fP0h5uFwbRKGn6xELotPzTymnsBcuShtfQGJLhx7T9FebpbIBgxXXvNQCn8aruEHjU42rI9FgcnQ5OURuboMGT6pwEx82VsDsTGsjjUxOZ3ErlAyW1Yh04F47G37WWYkMrrpAcJYfiynkW5lexXuyyG4Jo8WvRXftXxDac0BmXbgCL+E3weh2ZEQoN0vl336zhrgedJPoavf9UJ2l1TQCKaISL0FvyGi+nXZuOvDOyZZGR9loql1X9gnYw7SVTu+e4h8drDQTbvlu5csRWwdYVQWjeiOed9KCmtnjORuBZ+jl6jpGSV2pUbvpLtDq+P60iJYHfZsYhrAajNBC37QRD2SpIxD80bo6t7KUOhK80bXcKneKLnHxwteu3eAgjag06/KBbVqGjHw2aFnFwg0v9s+p5VPC+GG4A789UpBpUF6Hi6nIuBTGrsTk20HbJLJe1QoiGbDJxcZrt73weZu5yuMUPnrckpnNJ7Zvhevpzz/khT6D8qpB9kBNAUrJnSfro6Umxe47JqUTjuqAk6yk5yRPgsXaqIwwq3Wb2/wHZ2NtEMJ0iK8VUhG97J+mJRb99xBRy/pe8ROsNoyzzUXtJKAEiWvbqRA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(19092799006)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jpgY6y3zQdKy/hS6jVYYBWXz7YLZzfbQYhQeEOsxsx2jiBXdLnYoeuc0rfB5?=
 =?us-ascii?Q?hFU2PIkOMS1Uy2hiolw0Sn6F7MUZ7wlJsc1lFzgR1CaVzhLv+NJDm329gMnZ?=
 =?us-ascii?Q?/vmOwaq7oPhs/syPZlO3Mzx+HrVHV0qZt1TNc2vNHocJr5Z3JCXVpHivrmlc?=
 =?us-ascii?Q?+f4YPM0dn5MY67L7SgmJyQldTYkJMPItOSPXECFDHqAzPoPdXZdjpzXNRxUj?=
 =?us-ascii?Q?1KzvKn9JEf3JKn5Bt/IIObyV88ms2o9cNW0Z6Ds5sYJVOWa9HkyyhDIc3BXI?=
 =?us-ascii?Q?TjyanaVMDFM8pzLZrrAkPRDACoX3aK801x0pPtUzIGWm1RRPeMCx/y+0PPSa?=
 =?us-ascii?Q?xTY8gN+9QzcfmMMj5ADBibkNrwvywc/RfhSGhPnH+RXWqZ+NSlFXMCrt9e5y?=
 =?us-ascii?Q?PkcFRq5+ikbNfLQBsm47Dcknwf/2lEm6Mk/xzHEMRv+dI6ymCUKRujtvzgFB?=
 =?us-ascii?Q?3mwMzPND0/LpmpdpyrXNojRHoYpdOF/GemR36gIoPe4PDbQEEaOAGZ3N/Fhx?=
 =?us-ascii?Q?yW7LWnhGBMT0iCY19mNAGa7GVG0zaNEdWOqv1TiWWE991vwf+zDoc29Cv8S5?=
 =?us-ascii?Q?ySAJY0i+3tByeAvuyT4nL3VP4/4c2IFxx5FWASBeV4UD5qMPWLzOh1Q9K5+s?=
 =?us-ascii?Q?2yXRLNXX2Rn2Z5Oc2XVBGIrJFC/NMw8xENPe2tU9WH74fHBuQIfV/UbMU8AS?=
 =?us-ascii?Q?jIMmAaQ1iULcuQW7LTTlevJvZEV+ZC/ro6RGY8d8rbcXiZ4xMKfhk/VN0Fkr?=
 =?us-ascii?Q?o4rqfMQNCRueyBfuAr613WLnB1F8h3EHJxcluvhv11EWcagw92mPBTK3a2/f?=
 =?us-ascii?Q?HChCZ282qQlv95WyZQqzDglknMNYjYwBmdb3S4oGZfkZbya4cxdIR6UXheZ3?=
 =?us-ascii?Q?a3Lw7AgYbAgkz6ZBYEwLQtbJfMxPs7iZ2QLt1CZo+pOtk84o4UPTtiMqzAYN?=
 =?us-ascii?Q?NuZ+32DKbFs5NGlMCM1fCLcRA0aAceohQDY0gfgKaL/uRE/iBb2lCk9zj73D?=
 =?us-ascii?Q?dJeMUmyXV1M6R9muqQVFCuLHnkL+yJ/BHRGgxKyUcLQNdjPkVzbRPG1RoPB1?=
 =?us-ascii?Q?B+r2HOiA/pZhe1GC5lOQdECY0kWqaPbsjJXC2MdtTlfMnANdlbShZcsKX1xp?=
 =?us-ascii?Q?koYYZJGpFGZFHID/RWpXm07LLR2F30zWeCnpGkxbrzEu7KykwKAzgn8kl5t2?=
 =?us-ascii?Q?bRYsj6Wf86F4SDlZFdQgHDP0C4mthC+p9zt+6HQjmn2HV87rnpEoCgbLx+qb?=
 =?us-ascii?Q?s0c55YqSZzt2G0VELI348v8yB1PUa4WXRJvpfNd5V3GuBMk77zrdfJaxoVge?=
 =?us-ascii?Q?V+wBZAu65nHRSv+alg3nwj2gbXngKWk5MFxwKRqEktv93LuesQklfcMFlqF1?=
 =?us-ascii?Q?vvS1uCV2E2Pg9ml4m+zgcsG1b011H1ZI+C9WI2RqPJymRYr3cr4/B0MDotP7?=
 =?us-ascii?Q?5jfXMpQaWD7GWDxWYBc0OKNWtB509f5fQi1FxK+Gsch7tP8vf1hZiHZzS7rg?=
 =?us-ascii?Q?WB4bhNGvqhjzMMN9L0W73EDUj1/swdegxAi5f0vzqJ0+9bIk79NJ5QyoDMC1?=
 =?us-ascii?Q?iPJtF5M7xD4BAACZYimZZi0ZW7iR2saJKXc4CFvbtGFjPiCnB5vIk2WcP9Mj?=
 =?us-ascii?Q?UeaMcnkhF7sq1KEFtyPvpUSr6jxWOZV4WCxc61adIdhNKURIvQYOkgncE/vX?=
 =?us-ascii?Q?Yl0eXbETs0IhdwKTL+S9na6uqcagZVwdQOv1eC1kqF0WQ/aDnjQCbwtX0RV6?=
 =?us-ascii?Q?sjFbJCU1olGUGYcou9/HDFJAKlRx0y3paBsvJGDNuifTxtH+6K/wBoAoPylY?=
X-MS-Exchange-AntiSpam-MessageData-1: 7/FSgdA3FRkB5XZuZIzne4yCiOJUM5WmGWo=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9477f939-8a49-4bc3-640e-08de8479ab03
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:22.9345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZYQPdGWyz8C5yOxAkaRFoDySsAnnLgZayIPLpkdEtembsKMI/iwhoTv3/4rgQ+8Fft2vvkqE7Mf0k3sNGjWKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12032
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
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7109-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 76FAC2B3D8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This driver relies on a transitive inclusion of the PHY API header
through the USB headers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Yixun Lan <dlan@kernel.org>

v1->v4: none
---
 drivers/phy/spacemit/phy-k1-usb2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/spacemit/phy-k1-usb2.c b/drivers/phy/spacemit/phy-k1-usb2.c
index 342061380012..14a02f554810 100644
--- a/drivers/phy/spacemit/phy-k1-usb2.c
+++ b/drivers/phy/spacemit/phy-k1-usb2.c
@@ -9,6 +9,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/iopoll.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/usb/of.h>
-- 
2.43.0


