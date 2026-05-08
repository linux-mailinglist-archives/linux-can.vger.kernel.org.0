Return-Path: <linux-can+bounces-7578-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPAEC7eL/WnWfgAAu9opvQ
	(envelope-from <linux-can+bounces-7578-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:07:35 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0C34F2D40
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C584930953DE
	for <lists+linux-can@lfdr.de>; Fri,  8 May 2026 07:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A656537A4BE;
	Fri,  8 May 2026 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="dxH4i5AO"
X-Original-To: linux-can@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021132.outbound.protection.outlook.com [52.101.76.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBBA37F01E;
	Fri,  8 May 2026 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223728; cv=fail; b=eItsY1vYjW0uueAHAHN81TTbDrXrW0pspJ5+7x3zw4Lt5ffUVg9IxTkDoJPKBZxtJm9sklJyEkqDRUtibUBeTlrXpTIlLh7LWWQGdkOW1W2d1DIkWPxJ1yYcbdGb61r/I/YbjKaAPGV+HodxDPStewXXeQ1kU0Hos6vJWWGAQAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223728; c=relaxed/simple;
	bh=hNwBCdTFnz+MLuoh7eP1sWn4BlM1TJaKoAAQHhMUUQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gt+tKnMo29scXGWSCGEdFaaebIVH3VoOYYWyXPnzVvHy6008eSFRq2H/3qZbq1iG5zRo9YDrnC2MaxT8Q0IkiDGbT64Tj2RlNnvZt1XSh3LgDTeJJW50jRd8VHgFp5/kwv7nyvbxe+KmcodPXBhRTKWxNRQGYKExrzgOODUvJfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=dxH4i5AO; arc=fail smtp.client-ip=52.101.76.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBYNdlstgIv4+Pv9TogMfEvqixCpbKsoLaujbLD1jwOJTdiJXFaRz5V1VqEH0OBY3HWsHOE0tWaMHnoK5IyZiL4P7IMNxEwhDBByBZI4jlI7b82qPEbM2XW9qxBkOhtPADIpd8zkKVZ600WuLCzu7v9hw96bm9C/qltT0PiMoeJaz02BxIv0iUqh9Lvne3q8gwzDDBuhEu/LCLM9NZWOTsIVkuQLrOlwHfiZialnmMo2GlyxlGu66VymUM+SgIbFNe/KuKwGVwvcrJ94NLrfSS4H8PKoDcpTjCPd5ouHpjY3QfF7YNUYBOUucnBeT0P2ycE4R1rYYOIB44T+juKR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6IL80wCwzNe6o5x0Z/HfLS3KMekXH8R3lcu9EH9kiI=;
 b=xcNLtFEkXSlePU1LLEmJToTOudGDKINGrsBuKMXKY/03yYrTWRbxBg+wqHDgvMTzO8vPBLwfNMRCpI+mvsFNthmgC1Lh3ffDJGs7eviz+iXNcpBL9QmGpMy9LpRaCgY1G94ggExgQLrBGQ388pVlXgs8pKjfmZF+UUaEWRzq6Rqh3GDysw7XUySdL2XQstHE33jdhGRRFwKmAnitJnPa5/AjNlzXH2beD0GhC1AbMV5QkUaFq1KO1m++bKG3LRfZeNj4QpeSBP1vQstByIjXiGCm14KGHCEoFyYVEN56jvmElK7L5fAEYRp/6uGppig6vYW5nZ4wq+KOCyu9kdxEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6IL80wCwzNe6o5x0Z/HfLS3KMekXH8R3lcu9EH9kiI=;
 b=dxH4i5AOv4omZsAkmSxkb5o3EpAyzKjfGmpghE3o6GkUbPU/QYp3ViD9O3/JsQzeW0SCFxx7V4kQIfnro4bMuyWlMRIJ2sXZdHm91Tgrcnh1n+eF0vpT/FSKTNxlIPGmYOWav69ffU1CmSY6x+D0aMTvLfMTJ/r5n9LdFZd+1tyC6TOXlKIIEmBWEysZp25s8Tr7t1+HfKX5GdGstdOwAwg0V6XLt1m80YXGiQNYXUAmTOsoGN6PVkXN3vKVAbHXIOt/CO0PLoEJcmJet2BQeumivOhgCcxNXPx3MOw+eEQfyAy9ubPOOKDIZM1Q9HtOt+GYxKP21QxGWyA1vhZ5mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:188::6)
 by GVYP280MB0889.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:01:39 +0000
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e]) by GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e%6]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 07:01:39 +0000
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
Subject: [PATCH v7 15/15] can: grcan: Advertise CANFD capability
Date: Fri,  8 May 2026 09:01:21 +0200
Message-ID: <20260508070121.6918-16-arun.muthusamy@gaisler.com>
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
X-MS-Office365-Filtering-Correlation-Id: c61ecd6a-e858-4bc9-81f2-08deaccfa67f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	azRAA4BeDr+tzRmyRwVMNzRU4SYcLghnO6aO+XhlykpvNHS7uW0qebnFnB/Ny2pariocyvCC3uVPT1+HgCwfLXpvvOJMCBo+MHt4wKHf6nyFf3DHphRzqytjRFvyxXMPvkqHKsecNQhxJA9rOnvH8iU+MApPl6DRAs7q0PxSKoNqNg5yIn2POxeYEpi6/7U5DqkCN6IMrApPjNxenKMC+kHsd6bz4DZOVEeuSdwF/NsXbf6uHkzXBut0gKvMIFcTAUD3RXQo7xYKDP1ytjvG9LU0kyh/opQ3YUeQDePwwK/Bcc2vFPKvr+n69xazTOZ5MEBN5dbj2hfkBtgpT3Gm5CtDvFTFZ2W1FuYztvCCCbd7UPfvuwdUHYcC3X4vn5CinZxeTpRsBpLUeW6Oaqt5OwT6uY3JhRAEN7B0S9ODlELB/7Qw6sMWofjmA45uAPlK3z2A0Pt2ywWem77f+4wz0d2QTdHWtZ5+mlKHxaT5IG/us1rfQ8HXEHoxzCYbXBSGgi+WQGmUMa15u66U1os9LhCMsUzrl/z6pn4i7lwxag8134anijhh6S8wXIVIUv9Lj+lNGORNplrOFG161EDFUuflcCtNG4oWpMvoR9bQx4Vu8kmS1ezeqL0zytKwjs8v6sOcU8Ixm6jtpoVdBxDzQFkC8CONI9jcepzzxgKrvLwhuoujCTlVgOQUyonO/LGq47Ts/Nj1IP875S186aoZ8SLmIZttZc9kpbQuw+csIq8QHFLpcyGzXMr0gZNtlGKE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5NQo7dOg9aPr7B8iEWp/Mzp2yvtUnUeR19zXcWhgD4jOjEX5MPfLrDzGEoT2?=
 =?us-ascii?Q?CCysIZG3muWMbxsK4xAiOMngGIFODqjZLEFaTLwL+XdF1dsXf5YSxKGVffQt?=
 =?us-ascii?Q?kCtgvuRV+DzQ8xK/w8RU3XsEseizYnRTiuiWjSYGcWdzdm0LTi09MvQnagVj?=
 =?us-ascii?Q?7Oq1yaro1HwR2wIheWNea1UyiWQo4P1NI8cNoLA0VFxIWAMoZ5DgnYyKiMM2?=
 =?us-ascii?Q?42s7J0mQVWO4ueg1G62RIY9Xps0SPJgnOOcaP53IMUnvoTBtP6Gd3u08Vv++?=
 =?us-ascii?Q?nSwWh5E6kr2/vkKhcgZbEsAHQ2fEDP5cXMqdpO3xSgeSKxeo67kqC0kMsk+r?=
 =?us-ascii?Q?tHIm3NVW/xopLfS52+dwF/wtXomWGbpZWxJ/CoIojVurtUb7bV0Z0gFyAb1Y?=
 =?us-ascii?Q?w/afDr9d8fpLBvFTIZc9VnvienEAuTY4vX0RPz8oGwmDf3fInmOvcGHcBaKA?=
 =?us-ascii?Q?dRe2L8UUGmWI8533XGsuFuXYF9elAdLkDfGRfvqYAuXHHhViswObCaxZh8M4?=
 =?us-ascii?Q?1RVC3Db1RLVpNvHLKb4zNnuY7jQDnC2+538ZUEqNynq+ISQTLH2w/uuggo2l?=
 =?us-ascii?Q?++A9LYJnHBQUBhRGQy9ODu/nluSIPBpcftRZiRDpRQxY2Mc57E2damohBlVi?=
 =?us-ascii?Q?gLQAlxbOPa8SVuce+HM8xOIlaxUyx7BqzumI9zTj0Q1MwD0o8Rfx6rdBoEZO?=
 =?us-ascii?Q?h/m/WzGr10M4u2J1qwr0CvhApXmNJq/3R/fstQJbsWkWBjvFmubvsfD7cD1a?=
 =?us-ascii?Q?A3CBjge2wY/E5hEtdespQI9YTHn3ZgcvlpeC0y+3964CpbNLjsQj5+44CpjO?=
 =?us-ascii?Q?/o5qyIpexjM+7J3miV/oFXqS4Xwv6JNAZoiwLUpP+wN8akSuLghSrY1rBWYK?=
 =?us-ascii?Q?8C2KwpUtHWFVhGdnY+bodayY0CRKPiQLHyRXeH9l9GmduIYZ0ajeRa44zzf/?=
 =?us-ascii?Q?CauP7E2AGgMnyxVTidOuVe8GnIlXhXJixcIjdxFOLTHRMLt8qtz8Cs4/Hruh?=
 =?us-ascii?Q?CQxW5AYXm56+qiIxFz5KDGx2LflNjCe4hTaaMa4aWIdmMDQkAJXjfssQIerg?=
 =?us-ascii?Q?tbx796PCo0UsM6NYg65TC4vYIDWKjjud6SU746u+prSJMWiGqofpCY3xEsmb?=
 =?us-ascii?Q?t/nqZCKVXCIsPP0irl/ZkHwAV2jjpIqmcw4h/KL3rQnKFOa+7NiRDqDy9hSX?=
 =?us-ascii?Q?mFYyaZIDpgA8AkQRsH/mGb9byKJkCQEHX6IGHqpjzsXZgvnTopsUTYUHzsCC?=
 =?us-ascii?Q?FWNsKLhj8ncbTNfRq753VE51ILgXl673LDxuzo06QZjQ5IUNC/KkgWKstjgZ?=
 =?us-ascii?Q?h2QSMnFAQL5XefoTs6BAqAzhTFhpoEUK4Z6fysqr1AlaJapMlpsZWPaZa9uz?=
 =?us-ascii?Q?Qbh7zv2drzk541+9wAA48NSHETPmv4NenzdPjb1CbKFBS4Z21JklDbyOCi5S?=
 =?us-ascii?Q?WV1vw3B8PKCNpgmskr/HAltTD9KgRX7lADujjAqneNJy7eEeLgxlwYjs1mL6?=
 =?us-ascii?Q?cwvULwJfaIz/KGLbQZyu9JaNXZ2RsJfo4xFjzC846sVsDniR1PZmD/IyGGQq?=
 =?us-ascii?Q?WoBHRi4L9DulRj4Fmv4+ky/nGCf4VW8kSf0MVMA5po4lLBRlegelMURetmHS?=
 =?us-ascii?Q?RxpXJjKl2q/TMwYRTroF7Kp1y3UJFREzcp1PmyvuhYlQVJgvs+9ICLnc+M8m?=
 =?us-ascii?Q?Cq8Xm++gmG7sqUVxzODV0k80LFDzXh2seO4xy6PiAy1AR1XIve1x7+T6M/SL?=
 =?us-ascii?Q?JUeaIIJcyOH3T66lWWDwajvLFTnQPL0=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61ecd6a-e858-4bc9-81f2-08deaccfa67f
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:01:38.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Su4wUuw+nG0zQvXB1PT5W1pHSJzaqLCRM2VEnzgkjOR95da13KF/3MlErhiiAV1TDtllgOmGM3jlU/BvaAvjZwvkxAd11Rub4BLM7JFAbHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0889
X-Rspamd-Queue-Id: BB0C34F2D40
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
	TAGGED_FROM(0.00)[bounces-7578-lists,linux-can=lfdr.de];
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

Advertise CANFD capability for GRCANFD hardware by enabling
CAN_CTRLMODE_FD flag and providing CANFD timing operations.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 06ef081970a2..060031df8192 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1766,11 +1766,14 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
 	priv->ofdev_dev = &ofdev->dev;
 	priv->regs = base;
 	priv->can.bittiming_const = hwcap->bt_const;
+	priv->can.fd.data_bittiming_const = hwcap->bt_const;
 	priv->can.do_set_mode = grcan_set_mode;
 	priv->can.do_get_berr_counter = grcan_get_berr_counter;
 	priv->can.clock.freq = ambafreq;
 	priv->can.ctrlmode_supported =
 		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT;
+	if (hwcap->fd)
+		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 	priv->need_txbug_workaround = txbug;
 	priv->hwcap = hwcap;
 
-- 
2.51.0


