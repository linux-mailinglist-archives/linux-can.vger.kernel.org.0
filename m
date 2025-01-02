Return-Path: <linux-can+bounces-2521-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9E39FFEF3
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2025 19:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F1E3A332F
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2025 18:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E1A1922D3;
	Thu,  2 Jan 2025 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="VlIyn8sq"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2136.outbound.protection.outlook.com [40.107.247.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7C3185B48
	for <linux-can@vger.kernel.org>; Thu,  2 Jan 2025 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844312; cv=fail; b=PRWp+3In1mCnV9FKM4shDco7I34QC4504yX6E8kPA+jF71KXc6oo7ZzzPzrjXGStwCzfphIV5miw1GanHzfvgx60sQbDsVhfTGwd29mcWeabjJtxJcgCBYkcm13vN3GXGV3H2/Nlz7H7GcukVNIdLkx7KqxRNF4umLpXg4ZrnVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844312; c=relaxed/simple;
	bh=pzzQq93v1D0T2bz7bT6F6xJdzhkZj7OJT99uw345p9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wfc97VKPr+C8sTnmBeZBnVnCcFxRVVlNcCP+dJ0TWkzhVb1EI890f/qUbC5Ul4RpE1HU5DhBb7vQg+LzT2owGmaYp4gUCoWT5dOiZ3ezEKFyvuV7ut4DZ5V4pi8Z3hsLG1U+SirjJYZn/Q9JioNgLNZTHjyaqLfNpSPmDbbjgXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=VlIyn8sq; arc=fail smtp.client-ip=40.107.247.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ho2AR036SAt1OXJUYLwHQHDyYDYyxwRy4PR1w0MJ7idPqNX1lrwpcdVXysweRedvi46cLxpUNms4MGjr+36UgpWxmAgr5/CU3RJrFVngS31hliaEz++qZm+iv4NThKUR5zLspLsJ15puRy3x3vfh9BIeaZrITlh1PlBVL0n3/f4Q12VH/B+7NedAHZV1BAIlWFPgeSWRVZjBWdswFenBAuecp35V6KiI7GkRwR221VwzlgtPshkS9mb9f4qgCu+2Aa0Vbj4EfC9c7b2UySlurBuyaDMAt0pQPqRSIz4Ho3k7uNuiKeInJyQ4CYdhL0dN/Pc6JGZt4kwaehjVlHhzUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EowfG2XAI9p6sY1IDiMRK3B2ohpMYjSO48n/+AV7ck=;
 b=o6noS1KvLV8Lae1phvXFTfRq0MpWwKFvEqYaVDCX8rcYo8KNsVQoUfr0hqqdCB9djkFs1x/L5c3K3pEmJw/+WZYxLCdUXGHYQQo2hsloZaeb2huO0sGQ46BgDO9wJXTX7QAM5sJJzpy1bHGZEjlAZknpPTFVav/8Rt3zFVHPr/JamDk71LZJ3Y07iuzqKw4e6YjM3gft3HbwkmP0+bCQlIqL91Z3q0oyE+an3dH6p8VOtk38JTfIp3h4GrKatO3gSXtN/vo89dyPYu8Mib7nl5mmCCwfVLWWwfmANDGJBdl/8G8mFuKNsb+ThBiMw4d+TfBZ72SQizgD8FK7k3AyeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=gmail.com smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EowfG2XAI9p6sY1IDiMRK3B2ohpMYjSO48n/+AV7ck=;
 b=VlIyn8sq5DhGQA/6/z4IkY44XnOEu7YDVCf8QaTe04G/q+J9wg0UaDI+8cUk1mccIxJqoa9yD51RxcD7B6i/H9wFoJfQehKkWYisXiTRXpxFFxnOHamCg6kEp/tAYCaNOwThiUHCRlBHt0REJ85qy1fj5RLcNH8VxZuQba8FwFc=
Received: from PAZP264CA0150.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f9::11)
 by AS2PR03MB9670.eurprd03.prod.outlook.com (2603:10a6:20b:5e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Thu, 2 Jan
 2025 18:58:22 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:102:1f9:cafe::67) by PAZP264CA0150.outlook.office365.com
 (2603:10a6:102:1f9::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Thu,
 2 Jan 2025 18:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server id 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:58:22
 +0000
Received: from debby.esd.local (jenkins.esd [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 765E37C16CF;
	Thu,  2 Jan 2025 19:58:21 +0100 (CET)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 71EED2E803F; Thu,  2 Jan 2025 19:58:21 +0100 (CET)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Robert Nawrath <mbro1689@gmail.com>
Subject: [RFC PATCH 6/6] !!! DO NOT MERGE !!! can: netlink: Reject bitrate if CAN_CTRLMODE_FD_COMMON_BRP is not obeyed
Date: Thu,  2 Jan 2025 19:58:21 +0100
Message-Id: <20250102185821.670839-7-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C714:EE_|AS2PR03MB9670:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ad8223-9bba-4c76-8701-08dd2b5f6df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VC8xVFk4ZXFrbHQ0VndxRUJXVFNTS3J5dTVEWmpTQ2ZSenhEUmc3QnQweTNk?=
 =?utf-8?B?eisrRWtxRi9ZbnlNTmc0RlpGcm5iUkZ5cDduK0tPZVhrUVgycmVNSkd1SFNI?=
 =?utf-8?B?RCtrTnZvTzA5VmQzVGl1SXNFdC96QSttNnV6a2JoWlRZT0RPSXBsV2R5N2RN?=
 =?utf-8?B?dVpyYXpuYlJ4ckkvdEJIMnJ5bHovclRycDhYUzVTbC8zTGtZUFdNcW1KYmQ1?=
 =?utf-8?B?TXlVYjYvYlRkbUJVUWFkRnFTeGFlVFZUaUVEK0RYWWJIUHdOMlJIT2VyOFZl?=
 =?utf-8?B?R2pCMFVhRG85OVdzNUl0YVl0TE9IYkwrbUVqeDJtNGl1cU5mVVBwWUQrUUQx?=
 =?utf-8?B?MlFFUjg5ajFiTWVhZmJTejV4bzR1bzIxVU5rUDlmaHYwdXlPK1ZRUU80MXhQ?=
 =?utf-8?B?bzZwS1JLdXVjRmtyR3JId0NZalJGRnVMVHprR0VSUnFBc3R6R3RzSDNPYkgv?=
 =?utf-8?B?VFJDcjZEVEpwbFkxN1NXbjAvRTBjbmtyczRENGVLMU9CZVl2UUdvYnZnS3hi?=
 =?utf-8?B?S2xMMld3dk9DUVVrbVB2eXZYcExHQVdkNm9uV2hNRDJ5ZFJtcDlXd3BqbHQy?=
 =?utf-8?B?Qm1yUW9wNk1UVjU1VDJZLzhabVloMnNDSWM4Qlp5RHNIUTZYKytHZEpleS9V?=
 =?utf-8?B?SE5aVzZSZHpHalk0azBNLzV2Qlp3REFMV2lCRzVuaHBCRTMrcWFKM0hTV3hB?=
 =?utf-8?B?WkVWY0RYcmhMOEZIM0tmU1kvM3ZsTnUxckkxUHJpVE1DRlU1T1M5bi9QTWRW?=
 =?utf-8?B?eXhVY2hLTmVxckNHNldJcmVEQk1YNzlLNDA2UnN6YW9aMnl5b0RTQ0QvN3Bi?=
 =?utf-8?B?ZzNrd1hialo5Vm84WmlocXJWNHVmQjVIOS8zQjRBMTh6enVpRnEvSHhaVGJI?=
 =?utf-8?B?Y25LV3lSUHZVbmdtZC9SOXpaTS9zelQ3b2UwWVVXOGVnRkQ0eFBXYWVWLzBG?=
 =?utf-8?B?eTE3a0J4SHhJRHRuMjd3WHQ2Smdjc3kvd0o2b1JDYWs5Q25XWE4ybUhMZHRX?=
 =?utf-8?B?bWFEZGxlZnZmYmVuYXlMZ0tpRVZsYWdLazRid2dpNHREem83dWJqdnBOdzFG?=
 =?utf-8?B?RE1LUEhjYWFQWHZKb1d0MHV3dWpWVEZVY0ZXTWFJZy9qK041M3RuemRWeXBZ?=
 =?utf-8?B?ZHBheWRQaFg3SzYvNVhMd0UvVjhENGFpMElpVDU0Nm93YXh4aWJpTDI4THB6?=
 =?utf-8?B?T2svKzZKd1hlTnY0QWt2U2FlSWhoQUhGTDF0eVdoSHA1RXp1eEM0TVI1d3kz?=
 =?utf-8?B?QzlyVitidTRlS3V2QysxbTdjTzdOK0JnaTN1RENxTFRKQW11NThyNk1aWW16?=
 =?utf-8?B?SDN2clpVOVFvVHQ0Z2ordU9qMmdFR05iWjB3YTltRFcvQ3VvNmNhREZMQVhk?=
 =?utf-8?B?MkdjdUFHT3dwM2d4eHQxcGxKRFloVXJ5TWc2VWI1R05zR3VjT1dYd2NaLzVQ?=
 =?utf-8?B?NUdKOS8wYVRJUzVCZnZvTEovQWl2MGZuVDV6N2xSQjN3Z1hLejFmYnBnMjRT?=
 =?utf-8?B?YWxldGhSaXZlSG5NWFZiSktsdDd4UE5LK0U0TWdKQlZxMzJzVXVSU1R6T3Mw?=
 =?utf-8?B?R0hKUksvdlB1a1BiUU1xUG1STlVIWmg4VzdyZDVka2RySWN1NS9mbmUzU2Yr?=
 =?utf-8?B?L1lFeU0wZTRNd2NsajYrZmYxWVg4cGthYmlwZXArcDVYRkRtRVZRNzVzYUpw?=
 =?utf-8?B?SW1wVGd4TXY5MkJIOTJEUC9vQjd6TjZSRXZLcDh2NVluc2JUT0Iva1V3VW5n?=
 =?utf-8?B?T2NncU1veHA3bzc3eVY0cmNHem9uWUZodFljYW9xbXFZYXhoRS9KdytjMnJN?=
 =?utf-8?B?aUdHbEwrc25hK1VkU3cxcmY0cnM2djhYSFN6cERhUGwyakpMQkpVNm9ldTd4?=
 =?utf-8?B?S1lWZk9pNHlwVWlXd2VCYUhna0dOVG9MV3FnckRTTThHZFZUZmovZWQ4TWxI?=
 =?utf-8?B?eUdEZG5oYS8xVTUzTnlyVi9KNkZkMmk5UG9uVGJyeGhQdHBxRFBiSnNRNktk?=
 =?utf-8?Q?Ix+0KvPIRxP0yE+HWEsxciS7q7OJG8=3D?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:58:22.2457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ad8223-9bba-4c76-8701-08dd2b5f6df6
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9670

This patch adds a check if CAN_CTRLMODE_FD_COMMON_BRP is obeyed and
rejects the CAN-FD bitrate settings if the selected bitrate prescalers
for the nominal and data bitrate don't match.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/dev/netlink.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 79328d70759a..9a043c2b8bba 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -360,6 +360,13 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			if (err)
 				return err;
 		}
+		if ((priv->ctrlmode & CAN_CTRLMODE_FD_COMMON_BRP) &&
+		    (priv->bittiming.brp != priv->data_bittiming.brp)) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "CTRLMODE_FD_COMMON_BRP not fulfilled (NBRP: %u, DBRP: %u)",
+					   priv->bittiming.brp, priv->data_bittiming.brp);
+			return -EINVAL;
+		}
 	}
 
 	if (data[IFLA_CAN_TERMINATION]) {
-- 
2.34.1


