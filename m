Return-Path: <linux-can+bounces-7281-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G0jOF/TxmlzPAUAu9opvQ
	(envelope-from <linux-can+bounces-7281-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:58:39 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC38B349865
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4DFFB30CD9CF
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5903A5E99;
	Fri, 27 Mar 2026 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QITSdrgD"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02F33A453B;
	Fri, 27 Mar 2026 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637354; cv=fail; b=ZFDlyRum/G98JQg82UPKQpXciimlBpjBuuyROJ7PXQrz9LR9gc7Bk4hLSj//amQctLM87NZbe63pyxhdVC3HDlPrQLDfYGinAJBBNgl2QUl7rN8Alzg2Lh5wCzfzIJ8SmPZjiQb/ifQRHLAAkMUFRR1qgfvYDzs4ThQmskAFMaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637354; c=relaxed/simple;
	bh=hwdk2X+fLwDefqj2dXOG3POtb2i/eSFdqt4Z4v1f6dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MItH044F9hRO4/jbnTkRAKglTH04sQzuAwekVnzUJD56RF4LYs6KX7R75KBZ5tg/8AVsiRxL3fbGD+pm1PPBlpss6Adnx/acGnwj0Q5IuhgHSpIec6nCcCDgwFiNACNYI0o074zNv7NtFOpfPoI6oDZ5PmQguBswP/kQ1baPm0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QITSdrgD; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXfsWy1sjveBCDK58A8gZ3JvPnsjvWCN0We20sur+g6wqls6nFi9gSowvId/iXk4B1VnTearW62bSw05SxVwn1ZXEP/baEzVj0ooP1+Nep6d4tRd0JcKE28WNqaYEVle6RZpGZ29q484MvOrG2E43lKl/R25A+YCZIGPtlMSAzF7I3LYU7du8ekunArKb3zGtJ3QbIXQKSaWH9B9nktCDUaQbaKr0hOucEXkYL8+pAFoT2GbJDIh8c9hh/IJkYT+7i7iR6lieBUc+ITufV3o0OXIDmjRcb+65HfwnQ+XSZqCZzm/TAnqpVDaObDyT4xyqtkM2MfsZ7ZY+JJDmNhMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03jrpw5db6+trMjkB/a/fGIVq/X55iHRxrnyQ5DlJh8=;
 b=W2QS2Rr1tcH1h9r5MVbgnxy50PCphIqsluxbeHWkAK72geM+JY4pBNLhyERZBGc94T+R1x1k3w5bNgEO8uvhcCS+hp/ml3BevZYIrTlnEf6PMuCm8trR2ad2isDvRjiQpLEOFno6rIMAAMpFSQ2Cglswc0ZM0D5LZukEjxYui461Vzh04DMBU9wQ+aPIXoJ1V8VfMxsz81I5l0lvOtuGt378EPRBPUTTzODyps90sOWjY0IX40jdmHp1Z4HQtm3/OBZ5vb2VSz6uixHiv9sB0mmXFa2L1eaCNS0vG4Mmz2SqeA2htM1DNBGd8RumrJwNo43hmOMzrFLu8zbFT/lZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03jrpw5db6+trMjkB/a/fGIVq/X55iHRxrnyQ5DlJh8=;
 b=QITSdrgDKcsOb8FiVhVxQ9Lr+aj1oADHIxcbOi9SO482PDr9T02ZVHYV6qeExgidUqo2y9yTAL02H0Aiv1eH2To+C3fkr8141BakVf4Nhov83AWVjCQntzWNQ12OvbYi6tv+zZp8PCsYOCjNJVBzKLPOht1+APW4fXwJt3GZAZ2tkT3OHEY9udyRaHGz5L6tB+ngBf+d498sFu+tfklYG6Oiz6WRNHXHMEFd0GIezh5s1quHXiU4mR0/n9I/jSv8Y2kTeserd5RSUvoaPmf79Qv1o9gnGFHFpvvSNFO6Psi1AwivfA8l6tb7RcwF5hRLH5Y/9uzvRLcMXqmavr550g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by GV1PR04MB9515.eurprd04.prod.outlook.com (2603:10a6:150:24::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 18:49:10 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:49:09 +0000
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
Subject: [PATCH v6 phy-next 17/28] phy: make phy_get_mode(), phy_(get|set)_bus_width() NULL tolerant
Date: Fri, 27 Mar 2026 20:46:55 +0200
Message-ID: <20260327184706.1600329-18-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0287.eurprd07.prod.outlook.com
 (2603:10a6:800:130::15) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|GV1PR04MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a9bff1-576a-4c99-247f-08de8c31880e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7qz2bg0Q4u6sJVpuVBYZrxk6nhPtumAhELnepMF1Y9veGfeXXXWB2cgRgThWGBWL9tbRAP2gqvhsZqdzuUC9AauyyHVemvp4kRJdEt1NHSIzvWQkYbJ6UHV0N0DtdxkeiZZvit8jR45AHFwVrLC37HZHYAZJPafizRPxkXwnw6lDC8rmaJS0SzsQ8aY8pUfJNsRjJW0X+LL5m3SSTlFrd1Iq+1nFs1iLSw7Nse880iblwiV02b13Rvzdsvga27aQR9XIHaVSXqSGCF6FN7N3MvQCYRS5dWUTd8pk+zZ7aBS7m6Lw62dFY3/tFh3Omdg5U1ymajR0K11UIoecYMLlW8bwJothTODCn/3SQbs2oEeR6m2ZH25g+TMnK8zgBu1TRuY8QDC14MqBxBTanWdf5aCsZfq5OhkJs+uRzU2fjx8o2K+L6vHQ9dL7Q0LcGqu5WNl6WMlB7N0pbBy2hFNT+5D1lm43e49gp3lc71qMqjdvkKxsWy5v/eDIbBiBQqsmQVNh9TpAE9iwV6Vn6biAlcvU6hE5ggszA06Lb0Ew/+X0NR5Mz4nmn8AP55I+QevvxhbS8MK6NdB4W08JPbOIMTpALwuehE5usOcODU7BpnXMwwzlnF8z22Sb8CuGEOvsQC+kbh72Qa5+DKDxRDlBN5/LkimV+1tLC/WC+Kz1Jht2wVAEr9ULGAg5YnJDvnHyV0cc3reMX11ls82d3KnN1XjmMtrj3mN8gv456NhWrdU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RfNtoL7hgG8bNyA4hE73yhlFrShrG0GNRfbEbo+oVuoaWaBB2sYojYV5OC7Y?=
 =?us-ascii?Q?7WW70zb3iXLuvSgJiyujfNKf7lBZP32E/kZH+sjHtcqjQyoDfThJMDtuQ0+7?=
 =?us-ascii?Q?MQmipxcor75aN7EwMm9E0ctm5Be2j9Zn2we3NOpGoF8UIvqNWVjsArfx91hP?=
 =?us-ascii?Q?G6zWQwWwCkF8ElnZHtt55FvlgNIOsvi+jh5qoaEpzkZrGVRYBVFOQDVGRt9d?=
 =?us-ascii?Q?r4hKsNlDuyeXKyNdC1vZ6aPlGqrZmzMRMMP0ydG66NfEt2yf/QjgDYN0UsvJ?=
 =?us-ascii?Q?xKIX/dROf5Z7MWBdB0/Du9MTScHoeyiIOSSXCHovFjfYIVXlSoFczOAILExS?=
 =?us-ascii?Q?Yesjyd8cDcGBbxm2GFvXhKnlPEC4lZK6flw2u0iuZST3XpN1hmxR6omCLNii?=
 =?us-ascii?Q?aJvAne18BtXiqgpXqErqmaH3ld3oiEx5ve+7Xq2GiLxjCGXB1SmM/P0Qspfb?=
 =?us-ascii?Q?1u9C2m+cFZuCKVX4NUr75QxwMruw93C5tz2b6wAMnT0AGJrKtdEqywh+YJjJ?=
 =?us-ascii?Q?Of3EMpWF3jq3/ucZg3FtWkvOsNKca1x3bv+5+IRhDnxqnuq/8izML/mOkgGQ?=
 =?us-ascii?Q?ya2TLlP08LmRKJmhDU/dkb4XnJbpresQ1MFiyi1VxXvqwgeGLgtqU99gAMAi?=
 =?us-ascii?Q?4wgZoKGIu2NtOO8d2kSKAp3o68Dz4eRyXohHQQp8JjKrLw11PpfCBM6b042G?=
 =?us-ascii?Q?7QrPzqJGyjqvKP1WbaBmcamHLA7qU1nGA5t3rR5MnlBPhxeoWVIHOyR9IJpg?=
 =?us-ascii?Q?aQMpfkePj90qh6S/OPqFo8j5vDhUfpwPkH/LYm+s+k8ZxQ8szzing9PRuY/v?=
 =?us-ascii?Q?s5gISXSuvzDFblZV+azUZuuNXX3jU4EIYIWRs7LddDZwj240n0TrSKnQ4jNK?=
 =?us-ascii?Q?kbmnLyfyhcKivjzwImzQ3R7d+8c3hI8aKQPO9SH484E8hpl7biRFzkgdqgik?=
 =?us-ascii?Q?qwJT2pZNU53IFmyn1SOG0twKKIehwd/vVMHqpmhSMMyScXctmffMSxOi4JCK?=
 =?us-ascii?Q?fNux+ucjpesAXhTQ7U/nejDGN+fkPPcAdMrUTvHFRkUKsaetYdrkjZp6qV+J?=
 =?us-ascii?Q?MphLxdDzNNhESWPoNSv3o/iPu+DxlRJCtQzyPM7HJkzLaKR8gDH++jMAQcwW?=
 =?us-ascii?Q?e8SwTh1Gg+vmiW9amtprJj6lH7tFZn2VasC9pMB3VqFm+UyZV64AaOv0VplT?=
 =?us-ascii?Q?FVHzSXaK4lQ9/WehPwfwFIvuGsQdANAdKxX9hDXY0mgSJbbsAecq8LTMM+Z4?=
 =?us-ascii?Q?uoYr0bimycoYEWNIZrdI+4RWGQtdaH7TveXx5fioSToCuB/7WODssMhv+RSF?=
 =?us-ascii?Q?p3CTO6x36JZ6pnyZ7k3Qv8EZQ1L3OeNBIAWRda8hC6d/5Nq4PlxVRZ5CMA00?=
 =?us-ascii?Q?TRbeOQWOzIYM2N9QVcwyXuiGkyDsTp5/unAy8RatkLdpMAMwWrv6UIks2qmf?=
 =?us-ascii?Q?3vKGz1oRNUtAKc0Uz9dokOFHDXXeBfgtiyfT+2NAdoooBs45T15IqXMJU3T0?=
 =?us-ascii?Q?QT7PzrL+oBHuxb4xN/FBsO7luFwH6eDUlF475iabrY7mDU4wUjSXTkPE9GvL?=
 =?us-ascii?Q?DX09Ws/UoHkQs0isvI/ZRpKJdPgS6oO/HRBV0gG4wODMTUnYYcZAkZ7f/v0d?=
 =?us-ascii?Q?4RmugCXs8BJOuQzQG7nx8tjKXawZ3kYW25HlsE/DGdS0V6W+UWRfX14RugtX?=
 =?us-ascii?Q?whL6ah0xZ9aPzR5xFNDwNp0FGIjvAk8fglhaBnd8+DyZN3TemrsrH3IDslpI?=
 =?us-ascii?Q?KZI7CT1KkgyFvKiyx1Lk3u9punw7m1TmOAB2H9xR6osb2WHbT+tQehJuXKMZ?=
X-MS-Exchange-AntiSpam-MessageData-1: pAYviJnQ3Ebc09tk4WgGqkzvLccppg88FiE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a9bff1-576a-4c99-247f-08de8c31880e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:49:09.8194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxCNqrF+jy6AuKS2AzC0KWTm5aSAu5Mrjgky6sM03kwt+qCkaNC2hYP+0Trtp2EYas4mzx5fAr5PbbPIPmCxOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9515
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
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7281-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC38B349865
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PHY API has an optional "get" which returns NULL, so it needs to
accept that NULL coming back in.

Most PHY functions do this, only the formerly static inline attribute
dereferences did not.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v6: none
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


