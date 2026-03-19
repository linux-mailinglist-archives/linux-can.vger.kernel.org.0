Return-Path: <linux-can+bounces-7182-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJlzDgl7vGnOzAIAu9opvQ
	(envelope-from <linux-can+bounces-7182-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:39:05 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3832D35CE
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A74A303460B
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6E4421F04;
	Thu, 19 Mar 2026 22:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bWDOQeGi"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E226A41C2F7;
	Thu, 19 Mar 2026 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959613; cv=fail; b=oQU5hdQq4Kd4OQwo81Xv4kbKC0JYSh9oMSEk+DMC+BlqFxl/MDc1ygqSl9eimAyN0Wzb90vPFYV+J+HSzGmXfy5eMgSSTCqpzOIi1tbQihkOX3y5E19lWuWzJ54ucT16o1LuBcLUtT4v+OZ7Y/pQbyFvNbOxIttLYzJsWDUY7E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959613; c=relaxed/simple;
	bh=R/nAlDWxKizrjCTStzkGK+B9zoLJLyh1q+2r6AqGenY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AaG04lB1bWgf6UUX1Mhmm4ojDuUB2LOLdA1iEQg0ezaprwo9LEiRJaVfbW0QUOcapPfB8+tDSKQn87DLwP1kUpwWupEI3TywLmqHvJVFjN1idf5Iurv2UQvotFCRAkfQxwMVHZSUR1uiJyhko0Rk3KqBfLkhucG4pY1XlEV/4HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bWDOQeGi; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=infSQsCRQFpXR9jDmsioBkmYgOSwFP+AKeSwIhmW/xdyfDhOICz2TZtVZyG/jfq0iv909A4OKLtNiBHwotvxYgWuVN6zfQN+R9qHoJJWC/PhJBGWKz9aYVPFBxYVj7e+Wwl6Ibesfk1dxt2qjMzAZewcSYR7NOACDrxDxgNGBvyVh4MoTSCtjtZetDAXZ1163k8591FOeRWOxaLLVF2L3Yn1T/lOPY9uZl7O4MINPyCXfL/2wIzG7Y0twZm6dvgc1+auUWsgXwXy5xCvdahHIuGlou1FeU4yhsFgpi1BOAkS4hUJlLFugPT4vAAqXnbWzAqCWHcRp1pPAf7QFfXSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGfs25zQMT7xq3S2oiFCa3pDSy81prQGGDglvk1LHuA=;
 b=pfAIxqfhtvCz+NvK2klptGRLYe95vciFM1wmTEdExlne8uO0md3MBkdXbk7p5ITYt3JvMYoWDNr0vb4JjEEcFSiAJhXWGLYcslD14HZlZCACZ0QrRoESRyVLuFndQ3SPqLS7jlHRmqRlItdz1CFTTIBH7bkIAlx6RMrdqLLAXIrjJqVbyQP/H13AAZoFpolQx87+oOxDViYIBj3w6L3oPDohGrMzcWew0BtqGGDeL/Y+MEtKjEFFP3NhJksxZMh5/w8ZSklyMYFIbMswD6PwDyqOgY3B1qC5rMS5HTzGvcAOgt8tjanhc5MgtFi0yFJomtO97YSA9WmfpOTiPJQf0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGfs25zQMT7xq3S2oiFCa3pDSy81prQGGDglvk1LHuA=;
 b=bWDOQeGi2SZbhEeoNo12uuzY1qp4pwuegkOYdqvdGqyii9Bq7N+QjoarNhP+SfrSiikRSKoRdw/z2EYw1LK9cNG/LCFfnkcPnX4igM/SFIzHBF/XV0eUcVMcCQuPARc3z4tGHmGL0T6WhPZrbjLHy5/O97z4AGh4SroALrQ9JpdsEB4HoRgNORBqo69K76A/xxiaqsR9tSPMBs2qYMawGN77GAiIQB+mmXpMvEw42qFQRLOPXFL08rPioZEp8RUc2IiNb+8ohQ2YWorFEpCrJHAXvpMVGlJDrlID5E2iod83Zgx/ZNPN5RKWFpI8juvkSIxPBaoBsxP/X/nC+kDVDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8079.eurprd04.prod.outlook.com (2603:10a6:102:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:33:17 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:33:12 +0000
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
Subject: [PATCH v5 phy-next 16/27] phy: make phy_get_mode(), phy_(get|set)_bus_width() NULL tolerant
Date: Fri, 20 Mar 2026 00:32:30 +0200
Message-ID: <20260319223241.1351137-17-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0166.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::23) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: d914bf74-1464-4e58-b6cb-08de86078108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|19092799006|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kclDBbtlCNmXV6T7wbGhh8ozTjlKpnuS+Dr5kLn8E8SlEQ5t3/exIk+4cZ70l+zgjNWvmUkVBu1tzGx2Yu7k8WR4T6p036q3zqEGn0bR1Ypkj4G0miZJATlYeQLPmlKfDps62DWtRNEER6cnY39OMOCZKTZEJFU/qSPdZFmPPgeINxI8VDOdElhxSDfJDPafazRBwWdiE2UGB/1vh0tSoF2TpLEFhbAXpFDM0++RJrbjqOSJq/cvfIcVOj1d9LVE90JRAr4bIxHOCCRtABsbbGHh+WYrd9BPoBBWQRo4k/BSPiPnBvnDzUnNfMxpO+7c6foVFy4eXgmaNYSFeBUsgRcVCLy7H5nnxrdXqvHC3zzEYTnDSOFVRAGhxsOQYeLSh2UmJrZfsNTdJeyYHTbfjZz/EuGJakSZkNRcSBuxeCd/2I1yKmmoi243TbmCQsIJbHeLjLfMLGDkWx2WDBcMqt6tJMfVOcNrDlKWyAqS6eXMjZn8MFxag3KTv2Qnpfh+setHGmfW3/5l3yzlMqGembo0+kIL3LSf11Tm2JOChWv4PIuaefdCOiBr6m+GUsNKFLtZCteodNS0p5oREzbbBLJhKJ94Lf4MvJjpLRMfGCpUlCVpHvnN5VYEHXwkACNOLnNyObLIv4SBhPH/9zL3WpFHMUp/Iioj2uFyCfEUXhdGlHSbnIPuGIhlxlQHXp88A577oDMBIWLMTFgjxsKPRivPbfFyyC8u8+zaMtRpnE4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MT0Nzo+D6yBBhY3Zo9+MPkKNN9mxcEvaoFx1FWlX6/lLC5JJV9+OlOAwxAXc?=
 =?us-ascii?Q?r3F+vvdUvNgt9M5Sr4/5EUUrHpmUEbb25J/hd8ho0dC3oI7NP1x5/FhVoUi2?=
 =?us-ascii?Q?oBUssX1fvigPaKtY6Z5EaMTIem3+y58UPBodQHPslA38Tadjj+CUvMcpSdlo?=
 =?us-ascii?Q?YjbqdGwhY20BREFP8YzE0Xf8PUwXDMyfPN0s+7umn8SU6WhIG1nZVOeMPGOs?=
 =?us-ascii?Q?qDhOgo4tc56J2jSFT5wBvH59SrPnenOYXsYeA+0uk89Ef3YnffT5f0dB8ZvU?=
 =?us-ascii?Q?rBJsa8DHL+K5Fslr9P3FK+0ZNewM0YNL/qZxRf9o3ha/GsbMtBcOKTRcohAH?=
 =?us-ascii?Q?U3FqFjo7Doa7+SrfIW0A9hX907pQqEsq+C5xgvU+FkW+7gQHQL1JbB+Sk3u0?=
 =?us-ascii?Q?Xn5WMDArLhPH1NlZL5LpgcDOw51xT9R4GIyISiS1YpsUueQgwkHpiFI0dp28?=
 =?us-ascii?Q?hZUvWyIttfbQTJqejF6Gbl0mw0+6ApiqrcDs/qZ1M1+HbfFcreGCmcssUs5k?=
 =?us-ascii?Q?eimRzrUwG1pwbIIGKJ6Kw+2RdKX8RhIRIMDZ6QuSGSU5wt43TOw7M3MN5oCE?=
 =?us-ascii?Q?MXZ3wZ65Drc0hTPCcGbH9AKuT1uWVgEsB+AWQ8fSZCz5LzDtbYPf/kIMDLTD?=
 =?us-ascii?Q?De7Bjda4+HlQnsioQXDRUZx9Gyf+Wmc3nX3+fof33nEIfU2vW/pFeOX2GJ6q?=
 =?us-ascii?Q?8G51+sIMcRiPIlbSwPd39FSIA5YgruXHUdXunP/Tx6RZOLw8oA/cSL4Q54cF?=
 =?us-ascii?Q?y3KoTllowykiNg3nN9owgwEU0eL0pGBh/MJgY3MjUHXzcFhwxUEiAUCHlI/x?=
 =?us-ascii?Q?JZsWI9lGhIvIr1x3WhqIazQTVDpn7k7YnRg4B1X5LfKn328J+u25Zp8ldJrG?=
 =?us-ascii?Q?uvzYRRlexL8gvl5DydJAszMhp4Ga9vESFUFqjaoK9jm9KQO7M9vi0kOkfGDy?=
 =?us-ascii?Q?hgEed9ONuUBIIyoqFuhsLADmrNxcGBpGAGihK5JXccQPtWPNdszwwDMjUNny?=
 =?us-ascii?Q?jmg0hWNnxwQkV9vnXJJ4zspgpJnQ2tH7GXGHK8pzeoXLGkjLACTP2TcZn0X4?=
 =?us-ascii?Q?bz8X8XNtH6SWqTrTBkvxro1YqEPNebH+alB7p1S8WPfKfLj93+uMqROYbEH/?=
 =?us-ascii?Q?JE2shUfA6YM44Xm8P7CJaI+/AyLqaFM5/3Qc/OENeo/OjZf4zp5+Nazj4V1K?=
 =?us-ascii?Q?gj4Zb8pZKpi/ezvWpaGq6P34SL94F4r6gvxLsOiyk/s4P4JLwLCS29n+p6mK?=
 =?us-ascii?Q?ioiq4DMU2yhj6jjJLxuo+X/TQDp/2n801t8RRRxAqMFxyNVO7Ncq1+Ey5ztF?=
 =?us-ascii?Q?6oxSd5r0bJZYDIdN2nFqrbzVakP3HHGL3hgPcuA9WhcjRVnYm1u5yHF6XtaY?=
 =?us-ascii?Q?G70Py0p1+ThReWAcpBMQhXnFp7h6JzGdP89eN1JqwnIwVwB/09Sfpt19j6Qx?=
 =?us-ascii?Q?+0No4SfbbPt7erxs3xeyXNzfYJN04vR44zIPrjDjFsyV13v1KFIvCcUaORUp?=
 =?us-ascii?Q?6gDhgnaV/l2JqyLB1IcPrz3cumTuLD4gzgQZyGHeH7C6F0Umrv95rC8XvGny?=
 =?us-ascii?Q?OEO9KJsiQJbelyCbHXrKb32vqSSz0vxKQmef8DuchsYvB3vGez5iza+bTjXh?=
 =?us-ascii?Q?lfGOjkrw1Oj5z8MPZmFe1r4BLSABU2+9kU1C9/slQxBI6LFtKluk85CsQpBT?=
 =?us-ascii?Q?+keN6ClQ1Ox0r1jjsV6bMpqU05Mw2N3tCaCeedw26i/px1JR3IavAaAnPlW0?=
 =?us-ascii?Q?6KDtqEV8yTElDsNgh0Y2ZoHdbs5TBNrPAykr5ARV+3SS9s//qa+zTkNCPZG0?=
X-MS-Exchange-AntiSpam-MessageData-1: ycAuGos8lvYCvSV6T72MR5RDvRL4UACclJg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d914bf74-1464-4e58-b6cb-08de86078108
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:33:12.1967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXtxQvJP01na0fPxqFc90Rs7vgCKYdzuQ0ADTBWs8bMCrLnphLdeOCWaVDfLLvONNw5oJn/Fg6osqvDXcIsF6w==
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
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7182-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 0B3832D35CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PHY API has an optional "get" which returns NULL, so it needs to
accept that NULL coming back in.

Most PHY functions do this, only the formerly static inline attribute
dereferences did not.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v5: none
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


