Return-Path: <linux-can+bounces-7571-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPNnIw+L/WnWfgAAu9opvQ
	(envelope-from <linux-can+bounces-7571-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:04:47 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 153444F2C6B
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BD7C307375A
	for <lists+linux-can@lfdr.de>; Fri,  8 May 2026 07:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D4D37DE8D;
	Fri,  8 May 2026 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="tal1fOLv"
X-Original-To: linux-can@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021132.outbound.protection.outlook.com [52.101.76.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1350737A4BA;
	Fri,  8 May 2026 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223716; cv=fail; b=cSfrMGfczZHrGb7ivF8dDrVvorfhUlEMzRpsxX3eyhZVhkkYb1XcaA8BQjrMq2RKKGc3L/JTdr2/8lZ9fyECaSJ4LrvmoIGWK7HssDU0mg9EpS6ioK6DW3UWD65Lzc5gHEnOWYeQdSJeSfNe3TLKXl16Jz/df+eOZOkHVlJMbaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223716; c=relaxed/simple;
	bh=4qOCsCEzaGJZotvHiVjnVObw33R0hRNl2MgU1DvYQXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BHWHqTQ++ohkhWAjAOn7huhG0C8a5J7VjNYZAORKkORuT9imggMalrk5gBRekpxCQX4gcviYSwA4doLuEvwjxx/N4zKtqhcILf4LtZJ95BWY+d6Crhm0r/nzreEgAg3SBUrF5ukaCwm5qv4i7PdTEOgCOxigjLGfcwAS7hZPh00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=tal1fOLv; arc=fail smtp.client-ip=52.101.76.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgXDbiAGGULBFypYWLWVBuzB0ejVlsI/n/e4YdhBa09H0iHq9Plqzk7DcYchbxAZq024iEF/m3b05G6ktu7RMCFDDJ4jIOb8um/C0FSgLbEA2535hOJP/ROrHYFLnvNWuiVU039uTGp6IvjjMfYZfYIovF6w+uSuwzyVxtkh27vT0CEzmAQWzKXcz7d7tG9PdYBhPsPH6II0iVeLR9j75mhg7TAniKHfzReWkroV9spqg464OUJyKNohmeT7mPxRLEvc9IuMLv8QxZgUCFSEo6VvB9DDTj3bclW3ubEmJ4SiKABJbvE8LjPlXMTpyjiso9pJpmiBwyCvvkFLBRYosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1VBFildY8PzzWUDOCE3NZmRyuoQ9/bfo+ai+BqYlC8=;
 b=lTLhnOXxjnXvr86aZsHs1nQWf/bflJPdRIXcmYtHR3dda9TcKHrRJTUtBDdLKBgCTRyy4kxNe+8uHqtzfSOSTU6+cQGOD/Nc5TXygLcxBoQO6vhTbKxvyzUWCRV69pvF8qffWFG9nDmhoCW3sRDEogCAz0n9FWyZtqk8fx+slFjuW2Swqehp4aTaFXV1c8Q0dfzLPXS8Tarp+Hic2FHrGvD43ELHMZ+zDgef2EGEIleewEgxClYv292KoXCxGRWW/EbkoKNlvwIc/b2UANHgdD/new03i37q57tzr0gVczI5b3S6t9lpgVW1PfuQUdxWtUrtMVuXahYHi/9462IXTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1VBFildY8PzzWUDOCE3NZmRyuoQ9/bfo+ai+BqYlC8=;
 b=tal1fOLvbK+X9x3giFtW9Es6UxlVdaTRDLzya7rogX6wQEZkCPVwRNmSp0F4WigsPfxIn3bxmYk0r3QXtEtThhMjqauRul0aGnMkowE2KiEwfS14TOZ0m4+bclwTa0aPctTs7srS/d7FFFwiordbv2YFhxwEvwf0R5Hw2Utauv7oc/0taouEc8VaT4ICk7Hns39R5Mdq8sxIYUpo5UQPvNCC+X6JSggFVqJ5ZP8V9VGeQ0XJUUeBB/ZMk8neuaHE8eRuHzk3esO0DM34XxjetC2k47UfHuZ6DH9A+jlK1TQqTH/BBLFKivKFGCTFwTrdH5VI0a85F2WjSVCAHD39Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:188::6)
 by GVYP280MB0889.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:01:36 +0000
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e]) by GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e%6]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 07:01:36 +0000
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Daniel Hellstrom <daniel@gaisler.com>,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v7 10/15] can: grcan: Reserve space between cap and next register to align with address layout
Date: Fri,  8 May 2026 09:01:16 +0200
Message-ID: <20260508070121.6918-11-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260508070121.6918-1-arun.muthusamy@gaisler.com>
References: <20260508070121.6918-1-arun.muthusamy@gaisler.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00023A0B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::212) To GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:188::6)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV3P280MB1530:EE_|GVYP280MB0889:EE_
X-MS-Office365-Filtering-Correlation-Id: 61275157-ba96-4097-9f02-08deaccfa547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NR1ILxF1Ur1BrzN337N2knIxa8G5Gcg/37HUfNSEqxUHUdsJ+Rwr47rhqmv4/sch+4MrDn1PBsILJLC6Hv09rANCGYnds1eQSecOr+XzK0gwFTf0EfUTc51keEU2A4A+IO5EAA1NrBEtP9OJRlGnTSuM44H5oaDuVCKlJiyS3tdidpDAfRj2o9B7Wfudt00eay2PoS3S4uXEgiVPxkJbSrFIYCgJ3aDbEGqkEj79XnzV5Z4HjzeXx9ALkcSajB5rwZcrOAktlgcTTC0d6+cfbvYgOGL0/CXXNFHHnCme7IstWAJuCbfKv1zrpNycs9XDbL/3AmYTP6FNRjfVle22+7TVMzq8cjt6tss9Y72BEbJAfsp8ID+GW6PaOl6YZYXB3m11jV4TTqCoyAXCWRnnG7pbr/B8+duJcSPZYYY8Q8K07y6NRhANk4iPG9GYZNxZIfwCADd3BhFJw93r/dDpkR5eQY4ufuLUXAWpU/ciI0wLIIZCPOrY8Nh43x/aaVQbHcjyVtOFEC9cpjCZ817p8CHg786b5gXWueXqOCtfwGutpocGmeeFtS6bUvk1LeTDJT2Acmfnm+NJl4E7TBsbpQLXDG6DYX5juK+0KWpS6NnXOi/DsuszhYUs55kJtZjjLGq+SDAGBU1RV/YDL8Dg+N+hfWF1ruOZ+RB6I2tBztyJz6rqaRKoMbWlfo/eyF9BdRuO8OInkBuFPEtgLTybgZHuKXjrheE2eRNl23MQkNPetrGjCCJ1VcdbG9K87Rfp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iuuiT6GUGTL58zLbjeW6dpQBT/Eig5QQ6x77yEbRDfXu2GlyrZmvdlXfX1AE?=
 =?us-ascii?Q?qmF4Xa7f5i68iBp7vNMphM7+B7RBdBz7gxqUX8SYezqgVfvt/BwlKX3VbVXG?=
 =?us-ascii?Q?MaLDcxyCNS+sS8DtaPlx3/R+8pg1Nt/Gmkn/k6mqmIZM/+rqHRlyPJk+qenk?=
 =?us-ascii?Q?aegbobpbk9zrBQKHrbAWF1jC2S5PnJJSKUbAjbBU8vDp55eP1K4W+01DOlLU?=
 =?us-ascii?Q?LcGY5cAVgjkJM947WOEhwWUKq6osdJZwwsMPqXELAjf9w3n3jIf+xKbP7eVv?=
 =?us-ascii?Q?G2zF2YwHhXL8yMWMen1eeDPFywj5WubzU1PAxSzpma33OxYOWS4vFspP5Nwt?=
 =?us-ascii?Q?e4C+ziBDo/zxKZlvqbl9+jQjH7umg0uTofR3B9o7dDGYzwRlMb4riPtPAWYq?=
 =?us-ascii?Q?3uCbPufc3nfrRgU+slP5RR0XW6AlySwdDwtaP3MTxXwmn+iwBbCMvNMsbJ3w?=
 =?us-ascii?Q?5ajErM9loB+nqTV6LyHeIlsWGzPVXatzuXHX0uoiED/aSYEYo2m5LJEd1U3h?=
 =?us-ascii?Q?nUIBtBvFyIMUQ3iyRGOzKMpUhe85vuV6nnva9g5ZhfNs7AreqPNJIs2nbnfu?=
 =?us-ascii?Q?Yd7W3KDr0+1lK8lnb2rA5iKHRmHuzwrJXikpLEQbjr7MG0zqD8l4Floeq+vG?=
 =?us-ascii?Q?cd91AAJ9P2kUqrsT7KZGUZqhhmmUNsI0pcdzrq3LJoNs92ZJq6jwpInI/gy5?=
 =?us-ascii?Q?xxhWdrFei1fTByq1/aet5oY3h/PXpCm0aCVJykB5w8aE3DgilP3RTQjcUAKK?=
 =?us-ascii?Q?MzLG5I7jQ7b60vVPNB6qsD5aSbeQD1DPrgaqPogp6YGbswkp3iy/nlobelD8?=
 =?us-ascii?Q?3TDHNmd3nBYdx8fO1HeqSBasIhPWziI2fEGE+hbp21GNg32Ciy4Lpa8hHTv8?=
 =?us-ascii?Q?uqLDUMv3uiorESuY/a2+HYLRFjZEzULzverHMTA5jOGBRrI18Fjer4I9WzbH?=
 =?us-ascii?Q?JBP+fvNiITvIExQotSNLSTJR2oPDVL/n0Uvz6xXecr63Vg6LGdgS24MCsAqm?=
 =?us-ascii?Q?8iPOCqOKoa6TCBUN33ZU7qcrXui9RqduaVtoKdt2e7lSl/cKtZcJih8mEZdt?=
 =?us-ascii?Q?aAXXtiTgNJwrwnpCLaAoQ2ooA+bsbMyXz86zHIJyJ9jtNK+UO06pYb2GQSx+?=
 =?us-ascii?Q?vY+Jx0IU0AulJjykV8+ET+yd0jlhAVIbZ2LCgZ+iHdyX16zg1iOEJIjyZIDj?=
 =?us-ascii?Q?wLSNGBX09hKPZttRjeq2O4/odu5UvU7IOOD4pHnzA+AEEgrrX+Hm4qYiV3zf?=
 =?us-ascii?Q?BLNKhPFGp60tZ+mpyY0dwh3xCDbTrw8EhVuI/oknx5sAYRV4mFwyVXklO0bm?=
 =?us-ascii?Q?jhZAQ2CKrVHt+oY+gLypSQGGPgMWFy25UQ2PYSOxGuVEc4iGu3fytJU1GDBR?=
 =?us-ascii?Q?uMbDIRyjgk7J4Hy6TI70NbU8Jes2fwvQY5jBJJoG2p16wFRsAchn0Z1x1x3z?=
 =?us-ascii?Q?CeQ5kriGBptM7WPVZyjveoYQyju5UHFe6HUJVdo6dTDk8GG/w57XNYkLBj4d?=
 =?us-ascii?Q?Rv4MVq8yXMjZ+K+7KvGppiiLOOhgvFDeSy2EXDmM3b1q0IL/QpWl6fLRJKQF?=
 =?us-ascii?Q?pS8ExEgKtENfmOxLUDENRo1Jhoyrn75T9rd/Jy9aC6d2NlKNYt8e7P1c+Vgm?=
 =?us-ascii?Q?hkV/y/B4vRMUnLfnZrReiqLoo0lrD4x7YSY+N7RwbfetkCCN+epGthJkqW9z?=
 =?us-ascii?Q?7NHDb8zqhBMRALT2XaZ2X2Nkh5xdJwQYMQ1ccdIrUsUMz+u8l2fXKcKXI9A7?=
 =?us-ascii?Q?TzxTN3UwHDDt5MSdsFTxg+ecs7E0iBc=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61275157-ba96-4097-9f02-08deaccfa547
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:01:36.5539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFYXpuwTRvz/q6KgKaXgi2QapPHqtH/mbtP5nghul/7ib4pP882yp/H34GaKyvlc9qaR+VhfQfU9a1RwW1wMPatjATPIIsdqcvhEMvFrTPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0889
X-Rspamd-Queue-Id: 153444F2C6B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gaisler.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gaisler.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7571-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gaisler.com:email,gaisler.com:mid,gaisler.com:dkim]
X-Rspamd-Action: no action

From: Daniel Hellstrom <daniel@gaisler.com>

Reserves space between the capability register and the next register
within the GRCAN driver to align with the hardware address layout.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index ccf4032ed642..b5527fd9e02e 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -49,7 +49,8 @@ struct grcan_registers {
 	u32 conf;	/* 0x00 */
 	u32 stat;	/* 0x04 */
 	u32 ctrl;	/* 0x08 */
-	u32 __reserved1[GRCAN_RESERVE_SIZE(0x08, 0x18)];
+	u32 cap;	/* 0x0c */
+	u32 __reserved1[GRCAN_RESERVE_SIZE(0x0c, 0x18)];
 	u32 smask;	/* 0x18 - CanMASK */
 	u32 scode;	/* 0x1c - CanCODE */
 	u32 __reserved2[GRCAN_RESERVE_SIZE(0x1c, 0x40)];
-- 
2.51.0


