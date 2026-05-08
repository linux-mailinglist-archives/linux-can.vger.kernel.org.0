Return-Path: <linux-can+bounces-7577-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJhjIHKL/WnWfgAAu9opvQ
	(envelope-from <linux-can+bounces-7577-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:06:26 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D41C4F2D12
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C8FA3061AD2
	for <lists+linux-can@lfdr.de>; Fri,  8 May 2026 07:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CE036EAA6;
	Fri,  8 May 2026 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="pUnKyLbA"
X-Original-To: linux-can@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021092.outbound.protection.outlook.com [52.101.76.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555B437EFE3;
	Fri,  8 May 2026 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223724; cv=fail; b=Mn6zlg34Lvmzmd+GDf2GWhO3O3So+cj0UI+GLc4wGbpLhKvbt2XBszg4BGE0euiI5weM4l5ZxKfCIY5oYlTRIOP9YjQC4o6QIVr7ZUcejo/lZoiUEjKkCr0pazs0amIn2EOdtlC0Q8txTrUvexxRp5lc33VyPbD/xKxvWplAm6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223724; c=relaxed/simple;
	bh=k946LPdMfpqMjGLegc3iG+aOJEmuf1sJkRExwhsvixw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LCmEZL6wU4Gqu9lJ9ZEjAlHJq/jx2FjocfuF236bPDL7PgkmAwrtIPuUltSKZHee5Y9eTZRjhOvyMt3LyepOBJqLdkPr650z7hxxbrPpIolcSOkVEI9Mzti9yOWVF6e8j6JKm47gWrCk3++d384UZkfnEgrEWKHTzrntPUcVN3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=pUnKyLbA; arc=fail smtp.client-ip=52.101.76.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMZJHSGgQq2MEc5eqfqP3s7I2fTKGV9iKS95CtS9hI1KdraTrvGv1OB/MzA+2xAJ5qv18UblcUInCHJ86gAXnE0Qz+7t7I8jp7k4cNAtPAljdcazxu8DsXvhDgVxdNSdhrSS+YyKW8+PMMqju0d7Iv8qTs86e/BV7+B9uNvxPdtDlBsU9FZjlukPYvXeg7MpBK61BBYkqqzdBK7tBbrqsnUQp8ugL6jxcsaSRzJ8g81ZottA5Zp0AjdX8qobHIGLPxkNPAIGZD5vmecIjPhPLKCOeZdAyUwFHW19SiEEK/iETblS96NHdQsIombpGewNiQEax4tXQIhXYvLOFW2HVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASEJxSN5QGmQNYSe49lw9LkHrlcBRAxe4kSPic8VNGc=;
 b=GYVkv2Dt+lm6cyWeg+AYB6Gh7+E6yf1pHFl2BIi+OZ4Zr010cYGaOaxSAuwtbiPfeVh8UsSvsDh6CpnwFu9N3B8kopJlq/izGEMWhx+w0eA9Evo0/gYcn/tTElqR7lovd8dwa/IqEcHlx4aOIWd62v1DLDg7ZpyPLeC8nnbzmaxzb0uNFnJkVmsOsekmSBE5ZghRx798VUpybbEMKIzUAWUUFu+igiC8OBIPmGxasJLPASmaleOjX25AFWKAWs1uyCZNix2inBypu18BiiPw9pE+gvAN90OTg4Sj/MJNuBQJ/wxS5TUpygZ/4huirrc5b1e2YnBjDBfAnUfv3Zm1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASEJxSN5QGmQNYSe49lw9LkHrlcBRAxe4kSPic8VNGc=;
 b=pUnKyLbANfITiG6IButzYXmsaaN9Tw2HzAbPkxbDlb4wtEdKUKgQmqNCblnY+ivKyEWqaynVvj2NIvY4zF1JQnKIZTO0Kof8IBsacsQvkJ/SQgqYEuTIz6V9Sa3OD9zE9GIakdrE0z/saf5ezZA0XT7//Qq9s3VO5JgYnA39yD9qxBp54bc8l2H6ta2NcLukKp85A4AoUX1QxBuqVAZLkR+KFCiPZ0il7ldv7T+U8QrLNKss/aqvRYuGaB9x86ddOIO5sa+jk/SBfV/S+QFmdVIMg2dYAYesIBlKdmPn3SeBPRGgx+ee1etPgC4+7CvwSagB4yBiHvQt5O5rckoUug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:188::6)
 by GVYP280MB0889.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:01:37 +0000
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e]) by GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e%6]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 07:01:37 +0000
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v7 13/15] can: grcan: Add CANFD RX support alongside legacy CAN
Date: Fri,  8 May 2026 09:01:19 +0200
Message-ID: <20260508070121.6918-14-arun.muthusamy@gaisler.com>
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
X-MS-Office365-Filtering-Correlation-Id: 39bdc81e-883f-4a8e-7de0-08deaccfa5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YiVFye3HP3kCK72hTsSrOpM8+v69ortvH1cPsd3MoW3r1FmW8xzf12VAC/xjjuInyyJPZ/QTuKIlwrpIOCMp17oigJw0ASprmVFCbnySkFp7CYxtae920dBb+LwXJ1NeaAENmQ8ClDV/KP8H6yYn3pKsBxNVapSw4qCHvXtyK5JF4mKYf6OwN38I5p4I4zPKTHHupjo+s3o4k3uLpN3VVr2YYFDTE+f0c8LXn0wlzWGcwPt72ecj9fxeeuWE1fiHCmWebsH7Wxzh+Nm4V8V9iQ3jBl0X2VuSU48WQzZRedx+AuE4AX7iupMcqcwWfiy3Z3lIGbwzHzW7c4NLaALMLd3fVDW7krJtIOuOfW7FaSK5NQy2zSbSAlaQKFerlYE8e/h7WE0Ul7GqNB8gkssHRUIzGpQLqf6tU/VtgWGdOOiFXHcdDIKBSAUCx/cCTwZogpuJeF0+BRk1hAwn6EED5sNkAUKiPli98sc89Z3d8fFTaAp4ObEwxFZLiP/96qwapdOxmFpPNf7VSLSZ48nEklSreMtd7D/AVZfVXWuRnwfC0IIpU5uTH1s9TIsln2Yrs/+DxBWAS2gwIw3Lp4BSXO5EsDscLFfK0LpK+nY1/D1XRPUMxQdvZjsrs8GYvfjk/3C/g+say8QRO6nAbb8ax21iqMy2KNRyLyUvIE04gMY7aupTMvpwnqq1wG0hXAD4dkBbNlcDarcEh4iOSRsTodjIjCCBfFLWkCyy9/yUxLBvT8t6OV5cVkSy0H2vFU7M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wu2vSIkdzoVrcmEA8nej8LGiJ1SQEFsOSR1cdhWCwoO65ILLiLeU5FXH/Orc?=
 =?us-ascii?Q?ym3SZ6AwWK8KU4KEOQZehew+PvXykaMBHIdiikOD1FYuxA3zHPsAv7Q0K5ql?=
 =?us-ascii?Q?vbpH/e93IrPPhD2QhD4sRRAUxY9FZZennDlnnt5eZvyGHldasC3i4qbZ34u/?=
 =?us-ascii?Q?DQ9LAg6GM0AEdqoOBNC7pIY0kYVwrRE9IkrbAhKj20W6Wi4dPkEh01adjQhk?=
 =?us-ascii?Q?BBUDUzlAnwfAKmtnPkLTKdM9sLkOzsDbwcvm86EAAOr+p30BrxMa0o49BlLm?=
 =?us-ascii?Q?7C0Raxr8ZFwEBUg/Icm1Uop3tJ1/derPb4E/1Li7BI3u8pZdi+QlUeSj2CwG?=
 =?us-ascii?Q?W44nHd+UydopjY87P7dYmrkque1J0jF3k41ZPLPUsPel4a3cYKMMh155lfhr?=
 =?us-ascii?Q?PSRBdHqAQAi7oedhyswYYKLum/vHgB/3X3kQmwizxbZPfQvFnKr/+kDUDM/w?=
 =?us-ascii?Q?L3Y+SnQFTvv6OANuHZoeUhotLg37PMFek/C0KfnAnVt71dBQyVO5HqZ/MpSP?=
 =?us-ascii?Q?5C2f75cJmaDd1jtWZmfGjjdS7HnpftOdI+FUZ4ZA7VVAnKDCHcZCG1ycd8BJ?=
 =?us-ascii?Q?eVp5Nzrs/ZqjjH+3Bc81BT8dSXu94MVMWGe9xRgdiSJGSmFwzRym73YoSFEL?=
 =?us-ascii?Q?gn+3/OkJv3u6NPWlkZff1xrlv98IfNhVsWzY9Pc4ZoXZX0UFkopyue3XX2xQ?=
 =?us-ascii?Q?7sIBC1bk0mYMTydIXENIaGgNLCMYFvBUHGgz7QHNEW+YsKT+MmiQu5nwGbZ0?=
 =?us-ascii?Q?FKgFbz2B2/GAK8GD6jGQYuZy+u7jCMdt+01mmTnzvkuUs4YPurP+5rsiJUsn?=
 =?us-ascii?Q?sAJKxEBdotGUbgGw1g6k92y+lmgWenYZC+BeEVZduLRfKjxZJ96Yt7qfvlci?=
 =?us-ascii?Q?J9rbCCO6ybZ/oOg+08bwDom0dCsk9GcJfWkb++SGBDk2BFQAnTTwyd1RnIXc?=
 =?us-ascii?Q?iHcV/2LHgj8ZEV1dpd+3zkaIbx8Bxv3555vF+9D5LbR9XNPTUbCP+/dfzE1o?=
 =?us-ascii?Q?J5pu+5r89RWeJHR82Ox43fPXW+bde16pl6j91hyv7BsfRZ4ZkV/OAbksVjJn?=
 =?us-ascii?Q?D0CsyawFwIxMwCBhUDgpTsxMZ+RkoI5RXL4ndylja/7pHNfukha5MWdsNhK1?=
 =?us-ascii?Q?O4BZDpRFxTODBs8uklQibC+COusircsSKrlbPdhZRFWrjR6H+gxdXOcefx6I?=
 =?us-ascii?Q?PSO/GKq46OqMOSVKaCmKeO2Ha2qOKUcG8HJ3ux9lmQmhNNp+i2HyeTHd69ce?=
 =?us-ascii?Q?e67WCgLzUpWAmDRvqjTmPGGaVIEdRv1plJ5bhr/lMfzX8DQbvxG8KXOt0MF+?=
 =?us-ascii?Q?PtT8TlHiT15DVDSqcHqFqeMzUVWi4/n0wVy/DBAm8+kxMxZTxl/1lrNdaD7g?=
 =?us-ascii?Q?HeTB4RDpyd2aOY2fioZ8yv+gD3Z8tYTICC1suUQ+SA/CMZfarN26p3eLyT1o?=
 =?us-ascii?Q?gNcdn5J+BLFylU9f7QATUt2VVjHVhtn6mLYDRAuV4pMD+82jNB3mkT/PIUJ8?=
 =?us-ascii?Q?j3ywUrWMhZzTDuXiyr4CLV0cxXBn99IHLKT1EC7kDtzPzyFP8kk7vU+LT1U2?=
 =?us-ascii?Q?tMX0d1zPQcuxbGkOIICc9olhxFviVXLGQG5KGHCbud2u01aCCDi0DHsoNCIV?=
 =?us-ascii?Q?YVin2bpF0qaF8ZBRarIPCPh9ddosXvKjCstlycRmsfWCkv/zwFtPjbf1ts+Q?=
 =?us-ascii?Q?A6+H9/n2FuQq2b4vuSpErJVMSeTGIq7XUHuGd2+X6NasxoK3zHMqV7al9ce4?=
 =?us-ascii?Q?zZTAp4GrUlmApFglJJ+CuDJELwmZC3Y=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bdc81e-883f-4a8e-7de0-08deaccfa5f1
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:01:37.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgRubtAvV0jkKjHUu/RO+CkWJspKe58W+74xd1NuDFYhGLzpqCdzZjaOp2BDBy2tMx6qvsBOGcqdgUJBo6vava9XGeGSZSDttVijMq7OL6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0889
X-Rspamd-Queue-Id: 1D41C4F2D12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gaisler.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gaisler.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7577-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:email,gaisler.com:mid,gaisler.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Include CANFD RX support with the legacy CAN support, enabling
support for extended data payloads to provide higher bit rates.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 72 +++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 25 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 690e07c7b1ef..eba52701c882 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -235,6 +235,9 @@ struct grcan_registers {
 #define GRCAN_TX_BRS  BIT(25)
 #define GRCAN_TX_FDF  BIT(26)
 
+#define GRCAN_RX_BRS  BIT(25)
+#define GRCAN_RX_FDF  BIT(26)
+
 /* Hardware capabilities */
 struct grcan_hwcap {
 	/* CAN-FD capable, indicates GRCANFD IP.
@@ -1250,17 +1253,21 @@ static int grcan_numbds(int len)
 
 static int grcan_receive(struct net_device *dev, int budget)
 {
+	struct net_device_stats *stats = &dev->stats;
 	struct grcan_priv *priv = netdev_priv(dev);
-	struct grcan_registers __iomem *regs = priv->regs;
+	struct grcan_registers __iomem *regs;
 	struct grcan_dma *dma = &priv->dma;
-	struct net_device_stats *stats = &dev->stats;
+	u32 bds, copy_len, payload_offset;
+	struct grcan_msg_fragment *frag;
 	struct grcan_msg_header *hdr;
-	struct can_frame *cf;
+	u32 wr, rd, dlc, startrd;
+	struct canfd_frame *cf;
+	int i, work_done = 0;
 	struct sk_buff *skb;
-	u32 wr, rd, startrd;
 	u32 rtr, eff;
-	int work_done = 0;
+	u8 *data;
 
+	regs = priv->regs;
 	rd = grcan_read_reg(&regs->rxrd);
 	startrd = rd;
 	for (work_done = 0; work_done < budget; work_done++) {
@@ -1269,47 +1276,62 @@ static int grcan_receive(struct net_device *dev, int budget)
 		if (rd == wr)
 			break;
 
-		/* Take care of packet */
-		skb = alloc_can_skb(dev, &cf);
-		if (skb == NULL) {
-			netdev_err(dev,
-				   "dropping frame: skb allocation failed\n");
+		hdr = grcan_msg_header_at(&dma->rx, rd);
+		if (hdr->ctrl & GRCAN_RX_FDF)
+			skb = alloc_canfd_skb(dev, &cf);
+		else
+			skb = alloc_can_skb(dev, (struct can_frame **)&cf);
+
+		if (unlikely(!skb)) {
+			netdev_err(dev, "dropping frame: skb allocation failed\n");
 			stats->rx_dropped++;
 			continue;
 		}
 
-		hdr = grcan_msg_header_at(&dma->rx, rd);
+		dlc = FIELD_GET(GRCAN_MSG_DLC_MASK, hdr->ctrl);
+		if (hdr->ctrl & GRCAN_RX_FDF)
+			cf->len = can_fd_dlc2len(dlc);
+		else
+			cf->len = can_cc_dlc2len(dlc);
+
+		bds = grcan_numbds(cf->len);
+		payload_offset = 0;
+		data = cf->data;
 
 		eff = hdr->id & GRCAN_MSG_IDE;
 		rtr = hdr->id & GRCAN_MSG_RTR;
 
 		if (eff) {
-			cf->can_id = ((hdr->id & GRCAN_MSG_EID)
-				      >> GRCAN_MSG_EID_BIT);
+			cf->can_id = FIELD_GET(GRCAN_MSG_EID_MASK, hdr->id);
 			cf->can_id |= CAN_EFF_FLAG;
 		} else {
-			cf->can_id = ((hdr->id & GRCAN_MSG_BID)
-				      >> GRCAN_MSG_BID_BIT);
+			cf->can_id = FIELD_GET(GRCAN_MSG_BID_MASK, hdr->id);
 		}
-
-		cf->len = can_cc_dlc2len((hdr->ctrl & GRCAN_MSG_DLC)
-					 >> GRCAN_MSG_DLC_BIT);
-
 		if (rtr) {
 			cf->can_id |= CAN_RTR_FLAG;
+			rd = grcan_ring_add(rd, GRCAN_MSG_SIZE, dma->rx.size);
 		} else {
-			if (cf->len > 0)
-				memcpy(cf->data, hdr->data,
-				       min_t(u32, cf->len, CAN_MAX_DLEN));
+			copy_len = min_t(u32, cf->len, CAN_MAX_DLEN);
+			memcpy(data, hdr->data, copy_len);
+			payload_offset += copy_len;
+
+			rd = grcan_ring_add(rd, GRCAN_MSG_SIZE, dma->rx.size);
 
+			for (i = 1; i < bds; i++) {
+				frag = grcan_msg_frag_at(&dma->rx, rd);
+
+				copy_len = min_t(u32, (u32)cf->len - payload_offset,
+						 (u32)GRCAN_MSG_SIZE);
+				memcpy(data + payload_offset, frag->data, copy_len);
+				payload_offset += copy_len;
+
+				rd = grcan_ring_add(rd, GRCAN_MSG_SIZE, dma->rx.size);
+			}
 			stats->rx_bytes += cf->len;
 		}
 
 		stats->rx_packets++;
-
 		netif_receive_skb(skb);
-
-		rd = grcan_ring_add(rd, GRCAN_MSG_SIZE, dma->rx.size);
 	}
 
 	/* Make sure everything is read before allowing hardware to
-- 
2.51.0


