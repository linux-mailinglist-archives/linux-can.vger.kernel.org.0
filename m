Return-Path: <linux-can+bounces-880-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C977E91C6F6
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB751C222C5
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 19:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDFC74BF8;
	Fri, 28 Jun 2024 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="UT4tSp2G"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2107.outbound.protection.outlook.com [40.107.104.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7A78C8B
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604564; cv=fail; b=jrr/MqJ9dgkm2HJZr0sX8PL2ZbtbNYIx/uO5a/cSaLEB6l81tTMTc4emVxkapVtwhiky6h/4ZVM2XfqQ2fn0+r7yevAeDmKsekvupnHoh6mYUy2bp9dnFp48h4JmoKT3iy1UXGPqWcuoIYVeTb0j1OCjICAn+rKtj70a2VTrVOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604564; c=relaxed/simple;
	bh=5EWfGOeMelo3buvYVCPDCTFyry1SJM75d3MboexiBrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O7pim94hjzcC9tN7SDqtxGR7KwRuUPVtfTM/EACgHpCCha5o3BvJn7Ha9w914TrMr3wx3nTkRkdt7r9h4x8BUmzvu91UZMJDWukV7y1v/y5jlYFpCKM3ygJ8sNw3rC+BjNHNCa5vX2Gkl9PGfkFBrIAvPVIlS+gGUHc1nHIJWBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=UT4tSp2G; arc=fail smtp.client-ip=40.107.104.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyEJAfvqeGezNI8J71jn1X7JuiytbLQSw6iX/bmKbosEK84kWJTzrqcxeIpH3xkUVLmZBI//NuKR78wflHgduMkHqE0aeLqG/CX+FTVZktEfV/XjC/NUbVLDodfscf/dZECDQIY3FWwlHd6v/UMf3Pyyq+7WEJ8c34DUR4h0b8vEB96Epw+rRc5YN2mVBFF+/BXruiNW4ySS9SgwcFmsdEVVH0EWBRsw1mGs7OKtYWTMr10TdMFSlHmm6+CjmWQkTtr6taj/OTlY1UNuXJFn2DYgc/Pwe8arIxuHN8nEQBP97cUk4EzqGG7R2CEpMCurAVG5oqaGfUCCwltQb+tR9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osm9ozUpC4euEZNJ6JBIu5z9fe9rzC89Enci7/QEjXE=;
 b=HVqxjRA2tCsLQYYMl2B21XFAOcp3JWDJnrBNpDq77CqUbfkwAPia6m75Whygy5HW4nAQDT7AO9J6dO75Nlq/MXcaTalRGNeb0tV1o/M6bwxmUVOjz9M0A6tFUFClKzZJwtfpDIkbBVxCYQ3S3yxM4d+HYos/WwhBSjk6tGpKhq7Z3A6obpVF7iGTytQTZqfz1Wl3XvCj5RgNfVoW+sDb8CR/ZFKQVqkZ0xe2BzDhdmOK9ypX+0u7opShhSzhEjlK77YmS4lHmtcwaw6Qmo5Xp5vOD/hsdPXWl6xkglkn/cwKGdl2brBvq98lsuw+gdX4pOVEectGPmyYciRf1EO/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osm9ozUpC4euEZNJ6JBIu5z9fe9rzC89Enci7/QEjXE=;
 b=UT4tSp2G61Nw8S/0MafrueMP3mgjHjEOhApCoWWtWRAdu6gMyXYTNMqHHCppUdZi46uJNk9il86K7f9vGebndjKta9s471daSvRnuUhIayuBusADCNfiSIMcsAC4K8lfm9nYEWCmglSfMLbYQ4mSMGPDy3TakYLMlxGm89MigOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM9P193MB1142.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.38; Fri, 28 Jun
 2024 19:55:50 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 19:55:50 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next 14/15] can: kvaser_usb: Remove struct variables kvaser_usb_{ethtool,netdev}_ops
Date: Fri, 28 Jun 2024 21:55:13 +0200
Message-ID: <20240628195514.316895-15-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628195514.316895-1-extja@kvaser.com>
References: <20240628195514.316895-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::29) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM9P193MB1142:EE_
X-MS-Office365-Filtering-Correlation-Id: 460ffd26-d554-4ea2-1510-08dc97ac4e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y4uEGadkGGADAGrVA8zbSNjMWzrm16+M4VOFkjKs1hD0IWcPKTUm8HhmUPEc?=
 =?us-ascii?Q?YqQXVMT0tT4qs8fzqOBiqzBA95kJWwi8UL5ixS5lMMq+D7xomvYZD5NLL4SW?=
 =?us-ascii?Q?UAN+VXWWqGnitBXCPXZI4ZsO4uo3bNKlxUnvxVdJ/XMReG7+gDR4zVBimtio?=
 =?us-ascii?Q?4BOCfBys7NQYanfFyKmKHK0fQCqWTSwGeFBJuy/Ddqjy43Q5MknOOGEjeq0b?=
 =?us-ascii?Q?Ty3xnajl3xWOiIjo0Ct8L6fHsechvS4T1ilss87VdwGV3/kU7n7XfXxLDdLK?=
 =?us-ascii?Q?yZ41ujsjz7VOi81IKYwOXmf2c1etR7ziNNA0Yzdits7LefLEB6+5T0i876bZ?=
 =?us-ascii?Q?Nvvfj9CdUGlofUT33D+IwoAG/N56alL27JMi8IJMp5qJuQSbX4ykwoNO6zch?=
 =?us-ascii?Q?T1eZNJP1/LoBgXBK9thFj1whwB8tK+Lh+k5W3afOc7/UtxoI4Bb0NNKkYYSm?=
 =?us-ascii?Q?lIZ2yAgzSDHLAfL8BdPvTl/Y5tArnNDduG/PRWUn+Ub/X8AwCx8EPDTMhwvk?=
 =?us-ascii?Q?r91oedj/FC0ZylvCeaC1KCFs+heBu5n4SJMdtRlRQ8wHUHaCtJ2jVB385trR?=
 =?us-ascii?Q?EYJNrxvbfZMo27ibyRBld6uUpABVmvqiyHkFacHWCh7AqiBXHlk8RddHCll+?=
 =?us-ascii?Q?dKbGDsiKhQXQd1+XOBbqfCEZ0tF5s4mB41AE3aqgcLwnK/XzkatAtToRt5Tw?=
 =?us-ascii?Q?SFP1g3bx0e8HpjssVUAOqZaos7Clvs6+1ljFqOgXm+zJgfDtUUwodTxzNICe?=
 =?us-ascii?Q?s5fppmUA4oAuMjzpSCr5P/gX4g3Vr8zVFApZlqyGYQMsMbpOP8V5pLyk5l/A?=
 =?us-ascii?Q?sQvPyqiDdsKDEPzy/abZrGArg2Gdu0vLXFAb+06lbwBVAlr03H/rJ+ZeHqmD?=
 =?us-ascii?Q?7GKgx3BbcnO5HuwMFPswXKrf83ylqTghCyiDYe3w9qG+1iAZjGP4Mwwg06tR?=
 =?us-ascii?Q?Vy9PuZXHkd0IuHv3IKva+GH7hjuDIopmZJFE96L7FSWzXxj9FiSD2z7eWXKS?=
 =?us-ascii?Q?Cq5ArFh+A5NBHY+1lomzjPf4NV1FfcWvX0tBLpge/B3nz3SOtB/rgZr0XWEv?=
 =?us-ascii?Q?7leiZbl/l1SjrTUuZU2+75Rw3u6C3ji5qrEnhuGiik1YpfCIAutji4hzMFNv?=
 =?us-ascii?Q?sSFiJzugqJBocjv/ADHTZJ5xnNEmPWwO/TK0ckkJXJyAp7UFJMVfNMO0RVAY?=
 =?us-ascii?Q?YkE04VnhbMibzxKz2D5U/0cFEdrDVeHAhH2DB0HGwOb0EnR4YA7zWWACg9TY?=
 =?us-ascii?Q?sf8Crv/76KhGI6Yy8ZVUwRh8nMwIF5wWZQyiEWXSYobiTxgLUT4NRX4vuvkR?=
 =?us-ascii?Q?bsodS9IAKufai1XCJqPcEgdxX1fNQa6ARAgPXvQRTUoPyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DlG5VBzU6xx/NduyFSQ6Ho7QKK/riFZnF3Zgty2y1LywdaZVxJsa6FjHMZNp?=
 =?us-ascii?Q?iPckcjw/Bk0f086T1C/U6WtDH4hzXYDQBVzFcbK1X0n+421Sh3whArp6nBcD?=
 =?us-ascii?Q?wfbj/IzW+wsAKQcG8V7o2YxZ+8c4eo02T9jxnBgGCBzG0649ea55NnsZs6Kg?=
 =?us-ascii?Q?ib11salpZULg4mqIvG5OZKdH9YkFkaMp9nfRzh1N5XoywPePVkJSlMSJ8yiO?=
 =?us-ascii?Q?ZwRAnUcBmoXoKvjXyfiHjB5Rzi3u8GjIO7Nu2Ccsj9EpOpyVIBsT3807TIlf?=
 =?us-ascii?Q?5fbw6naClqP8OEBzflnsB4iw+4uBloZJYwbcUH55AqGMyOjixluwhb286lgO?=
 =?us-ascii?Q?ZflP9KrE0xVase3DBf+r2V/2bvv7GiHiPi0a+8g75elL1vgXLPDWwf3jJ1Wa?=
 =?us-ascii?Q?7Rs2k+sYhvVGabm8OmbjyOQpSEHa4dYJgHq9kvB9tTkpHIaoxgmQ4fO/Jqgz?=
 =?us-ascii?Q?7AEak94xiWN47e8Ek1+U82afi9R/jvZGEeB17da+ZgAUTCjDchhthRMwH6m/?=
 =?us-ascii?Q?58DR+KWDSVP5sTPrS0NmB+5D+C6obE7kHG8yyqfFB6ifIPTpEzIfU23LGdNb?=
 =?us-ascii?Q?tj0vawi7n5qA1UWrnWUxdYiYxZ7cmez3LVMNH65SMCXIScC+Ak5y2HnF+tl/?=
 =?us-ascii?Q?GIjP93FzjrQQzfZX2+QYMwy159PQdeUeTiMGwy5KzRZRmCVR7SPtqB7395gO?=
 =?us-ascii?Q?2E4P4Fu8T/4pYYtn1cliA//lypz0fVsNPjLSePuBu3kSDp4lUPOsQwUurQrA?=
 =?us-ascii?Q?1mMiI4q0dpdc3ztz+WIyYCvXAh9lOjpVa+AAPGF+Qe16ZMrzCNwgpjEl8J78?=
 =?us-ascii?Q?y2Sg47G/rDCEjP56c/UvZ3MtQfyiYecuIxP73zPZZrSR+rxjNlnJ9Bcs0BrZ?=
 =?us-ascii?Q?xe7butZVnWbsgnnggDiscq/4KXwDGVcsqCP7XB69bMClXPf/u9ppmS0+mLCe?=
 =?us-ascii?Q?K1w9GDXoktptsndOh/C4W+GWMyixh0ZxTgZECvZKu82p347R2KAqJKuaQT+M?=
 =?us-ascii?Q?cTCrxPvX7XykewYGUeSbCCB7Hpk3g98HxKKaZhAmCZX1bW2XytzLjZLYJYcK?=
 =?us-ascii?Q?wTEk8+tU+CEg6VCtDDUPd2Sgtx03+Kbh/Vq65fzesBjDVxayyS1B1bqoIlvG?=
 =?us-ascii?Q?JDFq310weF43kQThKNO+CRBymJL3xcpIo5X3fwtg7YAmwjFN48Wfy7AvT2zW?=
 =?us-ascii?Q?nRkkeBrtiXIW8FBB6zqTZaAEDOIBCMKxEYYvORo7KR4mwboF+CzA3C9sTwhq?=
 =?us-ascii?Q?PtNo+Yvdv8hL46xgSaL5o50YAt9q5H/xWVjm6PJx/b8i/SEzb2duoCfMhToD?=
 =?us-ascii?Q?e1yWAyYl4dDkZ06D8lE3MeVGmNuw7OChpEjPuLQtJDU/T3LxxtmKZZfUgvim?=
 =?us-ascii?Q?LCEb0P9xjdvYEIGQ4axgUuZIVsJgHs4k/k/lUkM2xnBJ844I/dghn1/e582U?=
 =?us-ascii?Q?QsWRIs75jLQNNTchgCPr40H5HMlTv/8SJb31Dg0naEvW3GDebaf3Doew3reG?=
 =?us-ascii?Q?DnfjB8N2yw6UhuXV3Q0qVlmZVGOJOSdRLTSBjvrYtnAvzu2y/jU4PIwXYdpg?=
 =?us-ascii?Q?tFiRhBkDj33GKM8zw+M02mr853FO2rHNlX1PctwE?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460ffd26-d554-4ea2-1510-08dc97ac4e27
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:55:48.2589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dB2QOiA/+hngl7oa1my5n+vpisUYsiYXfApzpmNQ4rwbgEiOB7ony4bBnb5itsYjtmBFtJlpO9+EGHHdVsWkIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1142

Remove no longer used struct variables, kvaser_usb_ethtool_ops and
kvaser_usb_netdev_ops.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index a4f32d57173a..4b6c23121b5d 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -753,13 +753,6 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 	return ret;
 }
 
-static const struct net_device_ops kvaser_usb_netdev_ops = {
-	.ndo_open = kvaser_usb_open,
-	.ndo_stop = kvaser_usb_close,
-	.ndo_start_xmit = kvaser_usb_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
-};
-
 static const struct net_device_ops kvaser_usb_netdev_ops_hwts = {
 	.ndo_open = kvaser_usb_open,
 	.ndo_stop = kvaser_usb_close,
@@ -768,10 +761,6 @@ static const struct net_device_ops kvaser_usb_netdev_ops_hwts = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
-static const struct ethtool_ops kvaser_usb_ethtool_ops = {
-	.get_ts_info = ethtool_op_get_ts_info,
-};
-
 static const struct ethtool_ops kvaser_usb_ethtool_ops_hwts = {
 	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
-- 
2.45.2


