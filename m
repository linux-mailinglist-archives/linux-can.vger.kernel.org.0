Return-Path: <linux-can+bounces-2526-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D3E9FFEF7
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2025 19:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D2B162B79
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2025 18:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF8D18BBAE;
	Thu,  2 Jan 2025 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="ThK6N1nV"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2116.outbound.protection.outlook.com [40.107.249.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E4198A25
	for <linux-can@vger.kernel.org>; Thu,  2 Jan 2025 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844317; cv=fail; b=fTVc/D8ar8x8q3ReUKxBaJu5cAWH85JSD0ZYk6WCUGJIYTLLV7Ivsw2JvSe484LJfotZeaU8epDDw1lcF503h0aG8ikWONvHcsGTUBxw+nTCbcjHjcYR/tDLH2XHjXJXo3sHRtCwo6BCGUSlL/UTfZ3hBq5AHoPbc0aCnwd2Ueg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844317; c=relaxed/simple;
	bh=YuqYwYwW9LfLBMXvAgnQyGTNsdt6Cp9y6nPeVPOOY8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMvWQNOGlgJPJ2gANj9Bjx3St6h+r0hUrT0VI+E2BnzWkWjidR7sVEJvWsFBabkWno7xU1Qlkjlc4CNcI4cqIabgLiNdZNr6NiuMFfa1MNWTSpLwYcVpHrsffGMOq77KxF+YuU5qHKw+YZaYVdkn0NW4zd6Er/3e/q6Ta+fbfrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=ThK6N1nV; arc=fail smtp.client-ip=40.107.249.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNB6PpIiYKS1alvaj2jvuqvRiEv8Xxz8x528jWeAY0WbAtVIZzStHJM00qcxKJ2hPLpmZM/d28T3nGqvYznITn/uaryMaaJeDenXvEzyuxId7C976hMK0Pp1s8wvxBMn+KOZLVbzqAWQe7sgrpMGG/qFq6bYKcNnamiNbBJEHuk7UMbThmp1XTiK+TBxs+oOr10PTOdSVXZ3TUzzwdNtp0u5EZGfA/jev/bsY66IMWAKWUNNWehIECw5ttv8bOr2JO3mjHFMQEvrd0FHqodPd+aY4rfmLFhHjy1NpLeJibqY3gHZmCsEQtOIXKvpHfOAWlcTxoarFZgzS107MLL/cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBQG8eOEpmLWc06WTEqcVXhT4nYxB6YJmvlSpqcAjXM=;
 b=qa3/pSgI96NurITpicqR0MNmBFvsZKvdn98nJ+9UEkl+vfLjMK4wrKXCLbAUjrqJzaB0v//TDWmnbp65Br5ykbpNTG7kU5i8J1Y+xWinRnKChqDCcr+mY1IPzARSaO8LXLqCG6JGVtOm7aNogoV0PXMgxlGjOdblO20JCfDTyu9hwzPmcUFbxHH7R1YKqKVCQUDK8Db+ZilVQvsHprYtYmoUHJulSYx2tOZalI0VGKQ5A1+qvvxz7lLfTCqwQgeJVacdgiOwqdDLqyUjRkNOLTOugCuugZUeLkHmuheziApELNdl+xpII/WUhCAg4ULaN7fgr3IJ+VUQbCBVQw2xpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=gmail.com smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBQG8eOEpmLWc06WTEqcVXhT4nYxB6YJmvlSpqcAjXM=;
 b=ThK6N1nV+oRLOZkcavcyYaysSS6XQtMc2rWaILno09QNosNpiZkGFf3ohlpC7qHQdATjFZznl8z57KGEvmgHbf4MoPTR+wyqhxZY5kzW9JSCIqgmPb2/Bp9Peff4Jz3c8PbnFv/RFiFcANH4tcdt2h13HL/Ci82ERSmd5s4Y3/g=
Received: from AS4P189CA0045.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::17)
 by AS8PR03MB6949.eurprd03.prod.outlook.com (2603:10a6:20b:293::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 18:58:22 +0000
Received: from AM2PEPF0001C715.eurprd05.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::d6) by AS4P189CA0045.outlook.office365.com
 (2603:10a6:20b:5dd::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Thu,
 2 Jan 2025 18:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AM2PEPF0001C715.mail.protection.outlook.com (10.167.16.185) with Microsoft
 SMTP Server id 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:58:21
 +0000
Received: from debby.esd.local (jenkins.esd.local [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 6DDCD7C16CD;
	Thu,  2 Jan 2025 19:58:21 +0100 (CET)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 68C3B2E8048; Thu,  2 Jan 2025 19:58:21 +0100 (CET)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Robert Nawrath <mbro1689@gmail.com>
Subject: [RFC PATCH 4/6] !!! DO NOT MERGE !!! can: netlink: add CAN_CTRLMODE_FD_COMMON_BRP user api
Date: Thu,  2 Jan 2025 19:58:19 +0100
Message-Id: <20250102185821.670839-5-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250102185821.670839-1-stefan.maetje@esd.eu>
References: <20250102185821.670839-1-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C715:EE_|AS8PR03MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: e90809ea-a870-4f65-5c46-08dd2b5f6d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkRjSVg0T3Y2Q3ZvTHZ4Yk9yb0JCb1Z0Rmh0clRBNkpJaEpmNy9tVHZwQVBE?=
 =?utf-8?B?dzZlZnZXZ1EzZkNGakYwb3l5Z1hXazcvV1B5diszaWkyc0RtdmVOdHViZVZH?=
 =?utf-8?B?Q09MN1JlQUgvcFdaZEVjamJTWmJGV0Y3aHNiTVRQTTZ0dmdRc2QxT1ZhT3By?=
 =?utf-8?B?aXpoai92SkhpaDJOUzlRUVlkUXhaNkxaM0FsS3hNVkJHUnhBTXArYjRYellm?=
 =?utf-8?B?Q3B4M2JsejlLT0tUdTVudzRYOVBJTGtybE5BTksxTEttYlRqb0M4d1Jhc3BT?=
 =?utf-8?B?Z2RvTDIzOUZieXNzcCtuQVBNMWpFa0ZDdUpZOGMxbmMwNm43WlA2SzdYeDZa?=
 =?utf-8?B?dENLVDBlc0t0UVBwVE1KcE5ZREZ2RDI3T1RBTkFPeFZzaXdjdDJWOTBtRVVz?=
 =?utf-8?B?REdaRm12NXhkZGxkMDRJeTVUZmVPRXFTU2o0MEhIdWdXZW9kZWVuUC8vdlAr?=
 =?utf-8?B?V0dkM2o4UUdiNWVCYTY3TmJDdHlHYjNST2MxaDlyS3F1VGk4RUwrNVBER1Rp?=
 =?utf-8?B?STNNZWhuYkxlYkRqSUV3SkNERXNUY3lkZGN6ZHdrRnJvR01FbXc0M2R1RXY3?=
 =?utf-8?B?ZGhXR2ZCUWxUNnN2MXpSM3daZFRSSkMyTDNuYklIM0tFeXJvN0gzWGx2UmJE?=
 =?utf-8?B?eVBNVDhYRXd1QUc4bnoxSTMwWE1LNUhzUzd2b1N6U2xxSE9MZmRSUFN6RU5u?=
 =?utf-8?B?T1I2TW8zbm14Z1JWOXN2Mjk1WE8yS2tQNm9PcWc2N045RVVpV2dISEVSQVNy?=
 =?utf-8?B?dTh4WUFlY3VVL1hucXJWUDhTdnZyd0hJYWxiSHRKbnEwY045QnErc3VZcGFQ?=
 =?utf-8?B?WXorK3hoUTUwaGNoYXpQdzZHbkJqTllpaVZja2FRQXAxTGhLbDNMNkZEVUx4?=
 =?utf-8?B?S04wcTdYVWhPemlaa0lMSlhPOU0yVjFXYVZ0WGYrb0RNL1JPb0VHWm9Fa0Yw?=
 =?utf-8?B?OTdFV3BWM0RtMW5yaFVKZ2ZqWWZQMHZsaSt0eFJray9lN1ZRRXVCUFdsOXNs?=
 =?utf-8?B?ZHZveW9SVTU3aFZqcFVPbmxXcVBXbkxiUHduVTJOSnUzR2FxUG81U2tsUVky?=
 =?utf-8?B?NjBRK0t2bXpVSERFN21USlg0NnVjMnRTc2dTOFZ0WkNCbUxmUXUzU0VPYWZK?=
 =?utf-8?B?b1YxaFpOWGZqQms1R3ZEUDFnb0QySDkvZGhkQ21qZkh5SzlDKzBmQUo4ZGRZ?=
 =?utf-8?B?eUwxcUlMUTZKbmFxQmJMbnJuandGR011WFVIQUY0K1ZrR1RkN0dOczdUb3dW?=
 =?utf-8?B?dnVzSFNJMy9yLzVIM1ZlYjdmZmo5L0RKcmQ4TGhQaVVNU3JRb3g0MVBmaVh1?=
 =?utf-8?B?NFJxdnpLZDlQRUNvNzhwc05kRytnY1NVLzRaREgyQU1ZazRKWTRhV1o0ditP?=
 =?utf-8?B?bisrNHdBSitIVnRsdmRndy9tOXpBQU5vbkFrbDE3ZFlkaFNrQ2xpV2NxMFIz?=
 =?utf-8?B?WHRMRW9LQmwrOGNSZ1BmNDgreUk0Q04va2svalRKdi9WN3Vxb1lieERzeUk3?=
 =?utf-8?B?ekgwWTFUa2FGc3JTOVUwZE41MGhBYTUyYkdxOTRNdzJUYk5yWllrclE0cnFn?=
 =?utf-8?B?WDV2Q3oxZnlqMy83WTFqMXFGNEpINUp1TzVweWJGcm5Cc2tVZE5qZityVUlR?=
 =?utf-8?B?NmhSUjdSVE5SclYxbXNqM1pnUXQ3UWpDTk9td3NmUW15S1BCUXBHVmhDM0VU?=
 =?utf-8?B?eWRjempOT3JEQ3RBbFNaQ1RyMEJ3VnJyOHI4WitHamNrb1ZtTFkzdjMyN1p5?=
 =?utf-8?B?Znl1VUxQZXcxRWl3c1U1OEkxQjZhdDlLL3dRbFFGalRyQWlBRDcrdXNkWVg1?=
 =?utf-8?B?bGloRTE0eERkZldaSnpqbkM5UjNIVXFoaFd3alBxMkFlOUVYRzlITktTRmlH?=
 =?utf-8?B?KzRqeGlzQzlxeXBSK09CRi9GZ2l4eXdxMWFYb1N3UFlQL1VLRUZMZnNIcEJ0?=
 =?utf-8?B?Y0RheGtnZnVZSkFSMU9SWUgzaDFHTytzcmVIZXpQQnVjZXlPc0VIcXBRUHdF?=
 =?utf-8?Q?gsQ+D84qXH7HgrfPwiN0+oGFlHN4wc=3D?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:58:21.6482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e90809ea-a870-4f65-5c46-08dd2b5f6d9b
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6949

This is a minimal patch to introduce the new CAN_CTRLMODE_FD_COMMON_BRP
in the user API that requests or forces the use of a common BRP value
for both the nominal and data bit rate for CAN FD.

This patch should be integrated in the patch series to introduce the
changed bit rate calculation in the common CAN tree.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/dev/netlink.c    | 4 ++--
 include/uapi/linux/can/netlink.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 01aacdcda260..79328d70759a 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -211,9 +211,9 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		if (maskedflags & ~(priv->ctrlmode_supported | ctrlstatic))
 			return -EOPNOTSUPP;
 
-		/* do not check for static fd-non-iso if 'fd' is disabled */
+		/* do not check for static fd specialties if 'fd' is disabled */
 		if (!(maskedflags & CAN_CTRLMODE_FD))
-			ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
+			ctrlstatic &= ~(CAN_CTRLMODE_FD_NON_ISO | CAN_CTRLMODE_FD_COMMON_BRP);
 
 		/* make sure static options are provided by configuration */
 		if ((maskedflags & ctrlstatic) != ctrlstatic)
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 02ec32d69474..cfcb4205e7bf 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -101,8 +101,9 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_PRESUME_ACK	0x40	/* Ignore missing CAN ACKs */
 #define CAN_CTRLMODE_FD_NON_ISO		0x80	/* CAN FD in non-ISO mode */
 #define CAN_CTRLMODE_CC_LEN8_DLC	0x100	/* Classic CAN DLC option */
-#define CAN_CTRLMODE_TDC_AUTO		0x200	/* CAN transiver automatically calculates TDCV */
+#define CAN_CTRLMODE_TDC_AUTO		0x200	/* CAN controller automatically calculates TDCV */
 #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* TDCV is manually set up by user */
+#define CAN_CTRLMODE_FD_COMMON_BRP	0x800	/* CAN FD common BRP for nom and data bitrates */
 
 /*
  * CAN device statistics
-- 
2.34.1


