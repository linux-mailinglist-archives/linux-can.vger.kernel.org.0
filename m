Return-Path: <linux-can+bounces-7042-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K9oJrAcr2lIOAIAu9opvQ
	(envelope-from <linux-can+bounces-7042-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:17:04 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B9A23F8C9
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C178308CD7F
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FDE4218B3;
	Mon,  9 Mar 2026 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ahEsvcC6"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E6641B340;
	Mon,  9 Mar 2026 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083395; cv=fail; b=oG8O2T30X5A92ytnLfqaXk8K0DgNmZsBFQQ5mRZPowRXNSMXo/qIrG/NSBKNlmIUbwZI+dlTO19cK7dHJAyuA5x3kP8uiPYQaYA0BhyZLLksczczrBHvOwUbcuwoBAgqbvgjjG+dxqEVmwLDQ0nY6UQwZzX82PEbtSK80zKmooI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083395; c=relaxed/simple;
	bh=mOlVzT+adHCMo9tBt0lOwvbnLjjJAHJZsauOLcbSIxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M3cY96r1T4DCzSSXXI+BAyedyeIW/6XAIi/Io8pAIW7t4vVw7XP+Rh26vVKQrMFWaB3H9fmAc8k0CmkHEqWRm5Pb0M4a3ZP0RGNa9kx9UfJiQU6J/mRi1NkD8SIy23T+eyoqVk6E1SxCWLxe1gXnmU4rKb0uLPpRMRao3Gqxndk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ahEsvcC6; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tscDPmsdipa4v45vNTs08FzGdoFd91xYYe/afrcDrTqbFfYcOov6RBLZHbZ5ggI0wRbMRfy5U3aQuatl6vaLFO4yh5NYsiOm/oM2JsOEAaZmU9mKxtMUQve//ECVh5tgsxFqFuXhOGl5wLiCpm2DD4BcV1mL8RE7cw5HIYO7Rbmf2nshEg8jHmeGRaHcS5IIQ9aIuu5VB0rE1H3cFHwPSJgrc1RXcAADTIwDyk72QMilKUbPIPnilfZ+ie9zpQSqbewbrF5AWApKxvpJZgkoPTHmsc7HcHFwkVavDLMZSTsa0H3FrPzGDLgKbxgnvDumA3Hl/xaaYwecu0zl8dB1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9V0MCvzcQ2BfV/KCNBsGJdi1muxhN8NO1E8PJumV5qM=;
 b=p3n+WWiZWeAbtSJrNaGHhIJQkZBBsAQwH5eFimAbG29idzF7Q1ekD3qp1303/LH9t+TuPmf/wzGC5NhThM40HmBHFkHzje9OT/Vv0DOYI3g+mQG4x0sIriXlYAFkS3IdAJIJF1Xf9jXjTIJwO6linuJ02DqIYXk1NF7yxNYoGekTVXilJTbbQKDqCT9GpssNBW5ZWaCp+LSUZkVeaSwJVWp5WoOBmAU9LNXisL0UUtexcgr/5hGXUSCTtw8qIfZa45wvKwrgfvVEYC8caoYEWjlsNMMfCyEtF3WM4dO7Wmr9kc5GkvymS4ZfI2PGTMXN1sphBG0LmOGigrbkH/g78Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9V0MCvzcQ2BfV/KCNBsGJdi1muxhN8NO1E8PJumV5qM=;
 b=ahEsvcC6qSwdKZbARyFsw3bht8dI/JV9A/m63AcaLdu9+Ci1Hhbuwcqazn2REyPfP3sTItC5asYUrSuc7DDER0X5BhixxhceLE8TYbX5lnbgRRXPdmaafA1XFa9LJmjbHtyxtp4mVlaA8nR6sPW3PEjgwDTV3UNOrGisxbzV7rRymxBCl02FVh6TP6leLCrlsK5uXwqu6l0CzyGNuOOlDA4pvJj8nmUBRdcjkR8d0SC4GM5+ivKjG3iZEpNyPGrUS1bZTtF47P0Z5s2o2jcdBFfRez/rh1aXkRvhPG2+KcPe6R6cvBxukA5Q/IACKdRpWlzucj1GrJjbjXio4VlodA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:09:35 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:09:35 +0000
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
Subject: [PATCH v3 phy-next 13/24] phy: make phy_get_mode(), phy_(get|set)_bus_width() NULL tolerant
Date: Mon,  9 Mar 2026 21:08:31 +0200
Message-ID: <20260309190842.927634-14-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0108.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::37) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: aad15bf8-72f1-4c7f-42f7-08de7e0f6700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	CZf6jqXo9sUlPRmgR5UnqeSdrWBX6KYrNfXRcl2qF3/+DHjhQWRuI/eFjei/v4djp7qZSE09wgbpwNshnWskJ85p8bPhVrIGUvHETyUm2XFZQLCXbgb4z8u/1vVb8UX6QXB8VVJZv/xusecxEH1uoZO+o3eiBDk+PUNby5AIE4/jos5RsrPPkk7wb+EOJIAlYouSbUg0z1DfqHBvbAOnl8wl7uVddc+6CE09duNKOzZzkM+Dfp0onoxYhxhXSrOCt3zj5I3PFcrLk+2TFEJgPukrLcb3JIqwsDNmZi9zMWLLUrtWZVAkWKWNKGNCfx5qrFQ9I9zeE3BjhxtwogCuDvVmKVhwKyb2oWx0yYPUat/jLtQ/QREPI07GnDnqiOI/EHhyYs5BsP3wzn0bo5kZmd3p1zj893ORqd7Zlin1FGbO1KRUz3lri9xZUW0bBibbhgeZ78SBylacAvMBA4REHKPsdiVFg8LxsM21W9wj8F+2t3YekcDowJVkZGw6jI6U/1ahAGG4j6HNAO21FGToOFdEWsNJFTRuM58xFojpegrapBWJlZGtdp7CYzs12vcXzgxFcom0em3hHqx2ExlOWTYLJZ7vb3XlvcbluVKgIvLBvhKiCIL9cm6CL6fXs6jNyKXBxrZVUqxdI7tFXSGADJEzxVLfqKXIN6sq4FqWZzIk8ZKs7dA7v+WROeihfU7bTvFM1i77yDvCtvq453g2tY7cNhVuLg9PBUjZHeV7xj0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G85LY4wQNFCm91SG83QHUJw3EbQvQi+K2yfXO6L9coYk4s6Hx71nxKOkRJWD?=
 =?us-ascii?Q?AneZ3gtc811crgFkM4J/Lsurv3doDJVhyRXhpSmlR6AW+6hLMTOvlzBohjCs?=
 =?us-ascii?Q?JgMvCysXuGmq54IvpPXkQRyysSRHKXYo/0t00AIlmY5/+hd/4+39lsF17fKn?=
 =?us-ascii?Q?3ckATmNdfV1dYGDzAxafZY8OqG24+Jtdkk+P6M1At95apGvpvVD6CwjDnstx?=
 =?us-ascii?Q?/FW0kPDGlQNkwsGLCqelLh7VvfkA8+LIvjLW1bwRHzLrvRBCQm0DZCq960Uv?=
 =?us-ascii?Q?pJiWganI5D+w2ktyeUvO8xgVHGQBFhtKqVM9zjoMvTFpUPpDU2M72k89l+6b?=
 =?us-ascii?Q?sRw6HBdlyit6S/DY0yj+AEEH6ILuv/1hn6TBICGINGl4xU5/LyIez2VJb+kK?=
 =?us-ascii?Q?VZg47vu3BJ/VNWwlUruqnwMFSc06DsSIjeMV6M4EkNWGHKneZI7fkne3z8g8?=
 =?us-ascii?Q?t6oJD3AtpPja9ZHgxoRYuDf5fmL6V/cR9RbJEpCCBv1jwC+CZ7iv9j4NfwoL?=
 =?us-ascii?Q?9DhLungWDVcR0nB3Kr2z3yDD2RY9pYx31RxjORSfltbYo8sf/me8Js0LYTro?=
 =?us-ascii?Q?3z5JkDM3uzM8d6OFPUS5WWrop3CxupmBVROdMgQGQxayL93nOZmDcmQNqvPO?=
 =?us-ascii?Q?hUa8xqjxylOafvOGPxnpCVNVgTQTBlj0s6oacBXEFsNBMZ0zoPq1Fa0QndTV?=
 =?us-ascii?Q?rxXmQWevt1uluTYe8UdkfBKKxMxAECue5pfM9e9fElE7Z5+eZlDMptrOD4cL?=
 =?us-ascii?Q?zuEwA6LBfFsKQD3HIJHsr38V1ph/hp7jZiw31yxrJI6ONd9qSB9b65lMt8V0?=
 =?us-ascii?Q?xl5YZCo5zg+BOeAOuwmfViuP7LYjzC2LYM4eyB9wcjJ9BjoISc3cWJmHPqgF?=
 =?us-ascii?Q?7QobSfK3f4Wc1+GbsEprziBITLs0F+a4CJH3pvTxTs/XRKyIwKdqJixl2Xk8?=
 =?us-ascii?Q?YJFuBQcTuuHH2TTHKxSzg16jZX51/VKJ5GBIvK1KFsuoZ15zwRKBOzjbQRcl?=
 =?us-ascii?Q?fKvtr4hXKBBRXL97vYtrGrvaM8I/awvo608WNV7G1wsSqkn/zx+sNDPFv29c?=
 =?us-ascii?Q?XHtZv+UZe1sigxqGsAbtnzqwGxeQTr/3w/MNyuYTjZVqJ6Xl2ukQ44A+1FkJ?=
 =?us-ascii?Q?X8xflUvTpAvK0qO3zo8zDSTmoJqT371x8XjhZThsZRzYim+/Xzo6GxDKo7w8?=
 =?us-ascii?Q?lcH9VWgZ9vqFJpZPmvo0uQI2dwxNhKa8K24JxpBIo7eVKfG/QQxelZhWrGQH?=
 =?us-ascii?Q?lqcnY7uhbnuEw0fA+5Jp3j7MPsM4TzFdYt5YZoE3sr+86CRu0s+tqg1H6eA1?=
 =?us-ascii?Q?IQQkBnlK36sVaQF+Nu0NhCjrsmDPOOvsC1s5p2qh1So1v5egZiWKsqmnG7Cn?=
 =?us-ascii?Q?8+AGxgSOOuN+pNsjXrF4fXRG/eRe0X75DtuBI2U9vawqIHgozWry6RUrIpCh?=
 =?us-ascii?Q?7oA6brUHvt4avWfz26uPQfF4pNNOLMkKaln6i8nYKo04JJVlEVPMReYQvG3N?=
 =?us-ascii?Q?SwCIQYFYo5sqH/hVdVOKG1cH5KeNB/9BaJqHSSCmQaMVchWf2TVbhaBW2ukq?=
 =?us-ascii?Q?LA9d/sB5Gas5l6FlOeqqMbUW+VEFc8LxssDMMcOPcqIx6a6AaAxC9adEGRgy?=
 =?us-ascii?Q?+iBtFLoRN9LvwReT+nSvPqJu5yK3gfFgmpLoBqcHxICOW39gtOJLv1xE7fhG?=
 =?us-ascii?Q?pYCUZTpixEbaPTlMOntws/VrmqNq5WdQkzSZUI3TagGf1TdoJzPJ2VYjdbI3?=
 =?us-ascii?Q?LAdo3n7QBwQ4bMEVcUvYqsxw6yx326ZdNLs/BIUVwnx2O6jgeerZQenq+Uds?=
X-MS-Exchange-AntiSpam-MessageData-1: pHsNidLOp3sPVvpFe8V8jRDVRvboUBhGXO4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad15bf8-72f1-4c7f-42f7-08de7e0f6700
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:09:35.2882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOkJDDcmtWXsfUGARkL+R9ReND+EGRMMuW3vdKTjTLl9UGbOpErjgUB/XHp1TS6buY1hLJzJYiWgf/zxIPXkyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540
X-Rspamd-Queue-Id: 16B9A23F8C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7042-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Action: no action

The PHY API has an optional "get" which returns NULL, so it needs to
accept that NULL coming back in.

Most PHY functions do this, only the formerly static inline attribute
dereferences did not.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: none
v1->v2: patch is new
---
 drivers/phy/phy-core.c  | 9 ++++++++-
 include/linux/phy/phy.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index a1aff00fba7c..0d0be494cfd7 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -624,19 +624,26 @@ EXPORT_SYMBOL_GPL(phy_validate);
 
 enum phy_mode phy_get_mode(struct phy *phy)
 {
+	if (!phy)
+		return PHY_MODE_INVALID;
+
 	return phy->attrs.mode;
 }
 EXPORT_SYMBOL_GPL(phy_get_mode);
 
 int phy_get_bus_width(struct phy *phy)
 {
+	if (!phy)
+		return 0;
+
 	return phy->attrs.bus_width;
 }
 EXPORT_SYMBOL_GPL(phy_get_bus_width);
 
 void phy_set_bus_width(struct phy *phy, int bus_width)
 {
-	phy->attrs.bus_width = bus_width;
+	if (phy)
+		phy->attrs.bus_width = bus_width;
 }
 EXPORT_SYMBOL_GPL(phy_set_bus_width);
 
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index f208edd25afe..a7e2432ca1ae 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -248,6 +248,8 @@ static inline int phy_notify_state(struct phy *phy, union phy_notify state)
 
 static inline int phy_get_bus_width(struct phy *phy)
 {
+	if (!phy)
+		return 0;
 	return -ENOSYS;
 }
 
-- 
2.43.0


