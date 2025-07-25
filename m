Return-Path: <linux-can+bounces-4141-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65843B11EB9
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5723D1C26B79
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CA52ED852;
	Fri, 25 Jul 2025 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="I0HlOUd7"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2109.outbound.protection.outlook.com [40.107.20.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C972ECEB4;
	Fri, 25 Jul 2025 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446915; cv=fail; b=pLZF0HM3W3bG+5q9Tw1j3Kn7Kv2kbgLjGKU6rB4cq7DYfuu15zexLdeWB6Wm0TX2ZKX022gkImWdFqC8JK3VC0TP5utlBYa0NhtbR50rtbEu3HKYpk/YkTydC3GnnRLIommIqKJFvxIOYFPVWRIPdRTa7io2khoMQLe+GXGVvnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446915; c=relaxed/simple;
	bh=XF1cLdHm7KuFwtb5WSBiC4w7QlesXhaHyYB+//Z16do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XzOtyJMTH5iwYdiETjwR7vAJ3nhizfp6gJnEx2cHHw987ijgDLyjvnfwgROEOgPYTXeiBJsdjU5el0XOCY8ASv8Q6LyitL8vgx/uoVD7cyC7FGLjBldAgqMTooo2tRcC4YSL2eZjUCwDtxwsE2o22q29emNAI1ZES1Cpfgf8KBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=I0HlOUd7; arc=fail smtp.client-ip=40.107.20.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcfUSRG15CngOGn9D3NEOXV8ccaaXyY1ZnUgTr2kBvzn7Ogd/vjB5osC5KmQqbR6YeI0xXCGKJ2vFRvYoGWZTd0YNSpGSkqEQKS/jwa2xOJrukALefhE2XCPCGWzyHeW2CbL+bvVyqyhu1mX9Mmml/+t3kb2KRQ2E7IHf1pGgALmaHUDVCz4DUHqyN6UiONgAYEaigwa2pwSWIAPPnsk2o5x4BPZV8ZTEWgg4iy4zTyvsF2jXlaj+YaVs6JukwFtLmxsmifAlay3z4AqX1fG1ewXZJ6H1Z5Tyo1fRHeUkbHE87/lrNtPjJU/CX5xG1gd5blt/P/ETG6gDSL5RyI3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ae/ssj0Tv5hKgSoiBUedUS775XYl7zVRzv5QYDjQbTI=;
 b=Wgt3PpouY6pbqiTdOM1LPtct65hnDpi5RnxfOfD4dj4TU4AUeG2iJdXAEOcG71HaPG4g925N9I7cBY8Ej4gNslN9Jzjuhf1GxtTCxQYeY62NSMOCDLWUDUm4kiVpKZQUaJJnWJDnqTvs6U1dVN1ix/Zj3vXyHCm6SDCc8R1VnhEYr2SHNaxUDF/K3zrR5RiS3B9cpHsiI7k5p213i4vutJNR57dRDu8/k3zQxfrSIpxllNte+pbkWIFcI1Q4MRWrUJrFBlo0WTFEdj5breby2g/pB4pHz/nZGFyFXzLYbj0oZW+aPuoNR4LcG0pzwhr1Xl2Ppsukr9ll0TzglKgt1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae/ssj0Tv5hKgSoiBUedUS775XYl7zVRzv5QYDjQbTI=;
 b=I0HlOUd7vu3csV8gabA3E7LouRHrXS+r+W10x6wB7eEMXB0tazvXyTg6ZoEYXoErMbxMC8vX2ODqGQ5qhYx7zMsF7zThT8MsWIPJLH7vcNJnxDm+h6n89RmaM02Iq6T4Bk5yuxbtkjJIAX6TKC242FcqBvxtdfLLRfQWqWN2lrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB1219.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:36a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 12:35:05 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:35:04 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v3 07/11] can: kvaser_usb: Store additional device information
Date: Fri, 25 Jul 2025 14:34:48 +0200
Message-ID: <20250725123452.41-8-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725123452.41-1-extja@kvaser.com>
References: <20250725123452.41-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::33) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM8P193MB1219:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b55ea03-d796-476c-87ab-08ddcb77ae9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZmqZFPVuur33hwYX6EmUgdeyS5NZAAwtFIqPDlPrPByH1OtEEoiVIjVuk68o?=
 =?us-ascii?Q?av6HKCDlrwMkr2K8GNvgEMOKycBAzV5vLxKaTMxnH4IfsywEVSi46VZShFbi?=
 =?us-ascii?Q?J6frSKLPZ+ndnt4yL842gBcGhrFjui1Zhc83QCTpTGlZvQR0vNKxeETdKzue?=
 =?us-ascii?Q?lKKt1VrpYJ/mNpVGioCjtncgi+aJ5NTUP9txY8n81gtug8+XcXHC6RCloGZv?=
 =?us-ascii?Q?PQzZMbCesRRsA+nUvlrlH7YjB2OTRNdRnv74qBUrB2+ZCNBWK0gcUPFnwqfi?=
 =?us-ascii?Q?4gwJnrNNMIC1bEd+wOHQkZopDaxvA518aiQiFvz4dzJb87L6etyj+BvLyHho?=
 =?us-ascii?Q?BgSKjJF5j7jq76DD98hcTY5Ci8+oWeB8eZqN8lJbHgjFJrPgdoAO7dEg7wr1?=
 =?us-ascii?Q?529zrLOZzETcsN/6Ve3TBx9iR/6TMJKeKplM6akJO2iWYemhuqr1pv5+3SLB?=
 =?us-ascii?Q?2Nn2dIZTjUmn7LuHeezY5+14KZlhl8R7tftG09ONdKlz+ORPwqWrNyVgILNp?=
 =?us-ascii?Q?TJs23TrHNrR+KM4xwRaEBZb9u6mY6ezioWGb9zDCE+Fk+1e9KlL3ZNO9TELf?=
 =?us-ascii?Q?nK5VT6URATKWR2BXzP/8orNHqB0/cL4OnvYOTwtJvbabJ5Ctz2D3A/RJy4Gq?=
 =?us-ascii?Q?2X8+BfWGNQdUwRlH8A598xmivp7oNc4mIcJWQjkDn+svtr41BqCOZbfQ5VDT?=
 =?us-ascii?Q?r3ZyWbeO7H989EzgjJCCGTcYd4LhScOcBV7kpP8D5RuR5Ah5xPiq+7TvehLq?=
 =?us-ascii?Q?fzYQjSIUN5ifgERjsOAuZ0PsKpyW3PBOxLxF3t2Z5LtvJA6etGFJPb1bD+/B?=
 =?us-ascii?Q?mxWFyMZdthkkgVdDTi1Auwut248Pf94WKegpT/rjzxGGS8krHeveXhlIqoxL?=
 =?us-ascii?Q?AoCpXCcgYil7xI6bvQtJYYzEJMb4W9i5n2ptdyd00JR9WC+A0y3cmQ7uDgOu?=
 =?us-ascii?Q?VY2emiO11uPNli8jX3XMPB20Gz2E+2VVxug+yMQbQRsp8goXXFCmvstoMpjj?=
 =?us-ascii?Q?1I0Yux97sj+hHlEVNuefRFJVYqVJNV4KA5dpccwnneyPtOBq5+7pYk51drqL?=
 =?us-ascii?Q?2KT5iA1d8TUszHwkCTNJwD9Ji6GsENvfm5Y0WpwF1vzkihzgtsoK7hzajCFV?=
 =?us-ascii?Q?RzjaJ6rm2DO1pwW7xfRa44xMwN9tNCEie5lrebqQUoiaPhhpiMFhi30zNKyB?=
 =?us-ascii?Q?AwlnqtFQ/V9qM78KXbKOEaLLS1AAdxYKLEiHliW5lYruqgivhW05SYRLb4Iv?=
 =?us-ascii?Q?XvxL0P2Nsjboswewn08NEKzr4sqhcMhBvYku9ZwhzmT76xQ92bkEIT2oXIY+?=
 =?us-ascii?Q?UE9bq2GgvRWn4/SbN+1YUeLFY3YEAOzzxGND056rAG/Krlp6yf6SLLGL+KJT?=
 =?us-ascii?Q?+tctCRKF6UqGO2A2GzGUlUd500oOWtkFSWm9AYfpvSBR61DvU93zlOHvYJdI?=
 =?us-ascii?Q?8R828ArEcr4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hI4jW2qkqDtMAlodqcZfOkxICdohmsl0XriN5QBIVdYhw36SixQ0PQK60Ep0?=
 =?us-ascii?Q?hwGu2p3zNFRTeVZSgOQ3/w8bxkUyJCyl3C81wPTSQDV/RTyDppKOilXOmXt6?=
 =?us-ascii?Q?UUOrF7ya4GffQg0OfaBxQEzfSx7IhePGBI8jXmtZGQ/q61ltR//rhmBi8S92?=
 =?us-ascii?Q?2MPG4kETJ7mI57pHZ9s7cIAN+UDnoBCs6D/0GdY5mpXgJIPp0I+QI6JduygA?=
 =?us-ascii?Q?yG5IJDjy8lFehIMg335HiDi6LlYW3aC91Pd2ov4f0Wx1QmLoIbHr36snUprc?=
 =?us-ascii?Q?uVPPVbzP9xH50eze6qPZXHl2gvuuPcdCUa28JijDeOOj8BS9JyH/00QxW0VO?=
 =?us-ascii?Q?cEJpzuwYsBThXTPqxjc4OVnVIYwkF2lSYBmagjlz33Vp99PT9/v4o/GRNJ7w?=
 =?us-ascii?Q?iEcCOYhyZiHShqjf+CLJmK7rnepG6FeLLI4q829SVAazWGT6oL++cPPsyWl4?=
 =?us-ascii?Q?tt0t73QValCbkdpLDTVR09OsrbwMg/JhanvTcAH/EP8RvZwsgockS4L8omGj?=
 =?us-ascii?Q?ewu9xVV6PBGRWE6UBAFdVY/R+Px50i/2hml0eGcnnmPM1MKNNtlMjbUr9d/v?=
 =?us-ascii?Q?gGqBCxPAV8DdqdD9zgYgeWnxIehCiWKANXKNhTBLo2RBB/p65xg4z4Mkb6b+?=
 =?us-ascii?Q?KdjqSTh5iovlD4QrjomJETLwm49Y9rBWFWljebYMAnpQyb8U9SjLc3OgcUyi?=
 =?us-ascii?Q?Nj7KbhOJq1oY5ncez5DNPv+I0gieT+ZInQlg7f7oCpQ86tQJm4FzeOmjmxqg?=
 =?us-ascii?Q?EiJOdZaxhD1fECUgoz+7Zv45wZkj+nus0mWnCoI6L/G+P9m243lBytB0+vOC?=
 =?us-ascii?Q?N+tMPwr4KUBLSG8iCj8zxszKmGp2FqrgSzDzQSEH4pZl6z62+744Nf1N8FAQ?=
 =?us-ascii?Q?wuMjJy7zIuRDfse36Xde1F1zZ0TkXWcgL0ZJ6QMnhvOAzJ5yK47FIQLtYSLJ?=
 =?us-ascii?Q?K7Yg1aqc3RiTbkXrICPPtcV6VupEaEvSP2OHp6yQvYSlepu/JTEfBXBoAgoF?=
 =?us-ascii?Q?a0ENMlAuugVCrOHnLzTuLUagZqaPUJkNx+/bzEa02eG73Fg4GT98QrWM7Boe?=
 =?us-ascii?Q?gMPejBSfRjL4Rf10WX/foRz2UURgFrn2wgB22vTOWIb5Qpr1AysxWft85rWX?=
 =?us-ascii?Q?gnpIBU1vvUSAmFCkFx0eyNCH0/lix6aOlHAJ+t4L/A/6Y9yGZqDUOS8xLErQ?=
 =?us-ascii?Q?V5o4zvukL7kF3658NnkPjx9H+imVV3dfJyLWQqeBreum9iOU6TFJom3a4Gb8?=
 =?us-ascii?Q?06Eb1815VStDr0jtWIN7BjQbp2eya/CxvKN48bvTAi60gn+XfpEKw+agbEqJ?=
 =?us-ascii?Q?xWeqVxX6gZY3nYTzxvpOwyEbLsPvIirl/MjqxTd2uVLRo8PZkEHEsvCJsjip?=
 =?us-ascii?Q?PXnQLhvV39RM9tv7+5ziHZ7xA3mD5LrTQ8/lvxHvwUf9X7yFydp2JdRiSm6X?=
 =?us-ascii?Q?SCA/98jnYOHLdEV4awefKuQiiic/9LItgid39JlvLXDXSx+GLlscgm7/Viih?=
 =?us-ascii?Q?Z5OUO2HcE4Jx7/86ibPvESL/9NGKq5WEkHaREF5I4w8gIlAPm/ndUT+S2Pkz?=
 =?us-ascii?Q?/Pms0J2FB83buv4P1q3DJLo4DpEOddpMa+GDvmI/dai+CE3EDbps+UjaZNwo?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b55ea03-d796-476c-87ab-08ddcb77ae9c
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:35:04.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uz1VHnSSAU7PMhuED7byFVutWQ6HW8sIyAy78gO7wB3kUBjoL3Au66j6N56Z5yyFLLf5vMxQSFXcGJq/D7Be9FTt5RaOjZRlfNOlo4kr6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1219

Store additional device information; EAN (product number), serial_number
and hardware revision.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v3:
  - Add tag Reviewed-by Vincent Mailhol

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h       | 3 +++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 6 +++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 6 +++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index a36d86494113..35c2cf3d4486 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -111,7 +111,10 @@ struct kvaser_usb {
 	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
 	struct usb_anchor rx_submitted;
 
+	u32 ean[2];
+	u32 serial_number;
 	struct kvaser_usb_fw_version fw_version;
+	u8 hw_revision;
 	unsigned int nchannels;
 	/* @max_tx_urbs: Firmware-reported maximum number of outstanding,
 	 * not yet ACKed, transmissions on this device. This value is
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 388ebf2b1a5b..a59f20dad692 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -114,7 +114,7 @@ struct kvaser_cmd_card_info {
 	__le32 clock_res;
 	__le32 mfg_date;
 	__le32 ean[2];
-	u8 hw_version;
+	u8 hw_revision;
 	u8 usb_mode;
 	u8 hw_type;
 	u8 reserved0;
@@ -1918,6 +1918,10 @@ static int kvaser_usb_hydra_get_card_info(struct kvaser_usb *dev)
 	err = kvaser_usb_hydra_wait_cmd(dev, CMD_GET_CARD_INFO_RESP, &cmd);
 	if (err)
 		return err;
+	dev->ean[1] = le32_to_cpu(cmd.card_info.ean[1]);
+	dev->ean[0] = le32_to_cpu(cmd.card_info.ean[0]);
+	dev->serial_number = le32_to_cpu(cmd.card_info.serial_number);
+	dev->hw_revision = cmd.card_info.hw_revision;
 
 	dev->nchannels = cmd.card_info.nchannels;
 	if (dev->nchannels > KVASER_USB_MAX_NET_DEVICES)
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index b4f5d4fba630..c29828a94ad0 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -138,7 +138,7 @@ struct kvaser_cmd_cardinfo {
 	__le32 padding0;
 	__le32 clock_resolution;
 	__le32 mfgdate;
-	u8 ean[8];
+	__le32 ean[2];
 	u8 hw_revision;
 	union {
 		struct {
@@ -854,6 +854,10 @@ static int kvaser_usb_leaf_get_card_info(struct kvaser_usb *dev)
 	    (dev->driver_info->family == KVASER_USBCAN &&
 	     dev->nchannels > MAX_USBCAN_NET_DEVICES))
 		return -EINVAL;
+	dev->ean[1] = le32_to_cpu(cmd.u.cardinfo.ean[1]);
+	dev->ean[0] = le32_to_cpu(cmd.u.cardinfo.ean[0]);
+	dev->serial_number = le32_to_cpu(cmd.u.cardinfo.serial_number);
+	dev->hw_revision = cmd.u.cardinfo.hw_revision;
 
 	return 0;
 }
-- 
2.49.0


