Return-Path: <linux-can+bounces-930-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8452691E49D
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 17:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58C91C21D7A
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 15:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FE716D4CE;
	Mon,  1 Jul 2024 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="iXLBU6DF"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2128.outbound.protection.outlook.com [40.107.105.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E11C16D4DE
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849016; cv=fail; b=quhyEqFz8e/IZ/PV26CADEFO3UhQsqu5JwxvdI/lcit8vS5D6WvJO7fC71ceYw2X2dFq77QtDuGdGBHtOExPdBEMcZiUqvjvDQCRY8Ego6QK0Z0pN1/CrbD2aB56EeR9gFYnAyRA4duJu0MJGDr2HmWTmlW2XvUTFG4C36XU/pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849016; c=relaxed/simple;
	bh=2fYdVVF0t8mOTUnKAkVqOPliAlskMyzieHuT7mm8xwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KEf1JviuFjoRLlS5clYuqXyv4V4lfJjqhFfc+coU1QyGKiWfdQQ0wDert7oZ6s4JRwIgYGUmyVbKhMKCu04kEgmfZZwdoz6NtXY72ofr3NPbE9alWxRNXVi9B4kZ/8igtSxpsboWDKPK0p5s1b859GNUMmW8KPVgjb3c6dWOORk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=iXLBU6DF; arc=fail smtp.client-ip=40.107.105.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8y5xCSeK0L9flGt1r30GXzkc0EZyOVjUov1UNwDGBw6aXKQfE3Kx30BCb5El0JmJx3Z3g6Vvv8+xaJ5LG2/UVkT2K+l24ou9rb8rHq1MdOQvCxY+ZFi/0Kw8Bg8ixmFT5tSvI+2yFvW9oEdS9m6/4NX8CQEb2+x+en8c4G4er3BfEaQPYpztnqqq334sZff3Q1Sd10/SV3SifOXkzkdo9p2uznurm/JDsTwxWPeUW34G3kzucq1rPXUyS76sj0rBDkuwVou3nMMDgS46Gu07K9/ROThucj7IqITpqQR4ZIMjaNWYeN69BKBG+fX+elMrEimwBBpoYPZbhGcJuToxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzEOHXeEsy8uT/e3v+dJEKIZbGrFTzRHPFa3ySM/SXA=;
 b=IKfK8s02l4KvU/i4E0NWLr8iHTgijyhWFgZ+YgmBdHRkUQiLYw3boahQHhVUdM1ctKHMuQY+e0UZU18y/MX8yZCp4260xfSCoP9d6TyVdABdZCLK2lK9HskRt3d0Sk7KulKS3UOLbIu7DWzNJxo/O43je0NSNm0/1DWPwzkxUdhdouZznfCJ3WHatm6qOG6XAdcQY3XNfDQyygllAeeeMuehb07afuHTdNMuXGgrB87NGS7lxzi7fGhavD5eLGgupZlUDMFneLDdlfbVMGIJP2ACu9JOV93sXCjH1hTWWMhgtvjHZCp+wEoE82ZoVqxp4j1o7caWtBABilTgBwrGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzEOHXeEsy8uT/e3v+dJEKIZbGrFTzRHPFa3ySM/SXA=;
 b=iXLBU6DFMG+kp1L7cZkMmiiJrA8K+mNdfdyKUK2FnAiLK/zE7BNy05GT/rd9VhBY67CGG3UxY+aHey68KjZY2Xa+PeUjgwzGvWuMNVVM7FpiGDiCc3TKB2PwgbWGhIEskenee6DUgh9qM/ysugkU9kNkAmsGHhs85d9wx20zMTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0519.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:50:05 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 15:50:05 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v2 10/15] can: kvaser_usb: leaf: Add structs for Tx ACK and clock overflow commands
Date: Mon,  1 Jul 2024 17:49:31 +0200
Message-ID: <20240701154936.92633-11-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701154936.92633-1-extja@kvaser.com>
References: <20240701154936.92633-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::20) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB8P193MB0519:EE_
X-MS-Office365-Filtering-Correlation-Id: 778f9bde-2e22-487e-558e-08dc99e57928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xwFIm4KyCvzYV/OQhxc23TfTNO6gaBjSkCJx6okji4TZBCVk3vWBrkb9PpoP?=
 =?us-ascii?Q?M6dEfbUIACmol5ZZYvVMFZhq5w2mM0vPSf0kGHfrJV3xO+peU+86NzLsmKEU?=
 =?us-ascii?Q?NoE/Qv/H1oKV3EXm7ynFhFSRsaHBCTMOQ5KCKUW2p752mpDpHJMZ7Q99vIrZ?=
 =?us-ascii?Q?Zr9pxVwn4PRgWEdA6GCAWVhK6FjDrmi5szkqFvCwYlN6JACNuR/WGVhWBdpT?=
 =?us-ascii?Q?ygdAbSBS44K/KuBQMPYTHJIp57ko+OuNDJMcxlo7cH31yz9mQPrP1kJ6Rb3c?=
 =?us-ascii?Q?4npk/OThnf9ou0WDqiV3N+FHWGb+xxPvrNXnkAH6rQI3vMG5YIWCcLyDrP8R?=
 =?us-ascii?Q?UZif4fUqeW8xFEWSiUIRjgdT7WQIBM752Upy2hOx5yq3yzPXT1DYuPsg3wSx?=
 =?us-ascii?Q?6kg/dDviikrY1mc7iW7ym2eUAV8GlmySL1nDMm/5SXh8g3/U2dmbtUnpD3FW?=
 =?us-ascii?Q?LupagEz1/M90nMXKKtrY1n0GkRnq/w+bkaD0P8j7fL1uuz4EhKtOZXbRPbVu?=
 =?us-ascii?Q?OukCfbTwsv2NlvfTGEXD+2cIr4uKRJrQT9psabdhzA5ql9vWQYbUuFwUCnz8?=
 =?us-ascii?Q?GAwbbU4teswLrP6aR5sZpmlmtqJd7lclZgktGUohVQ6CoKvknb0c3XX68aHS?=
 =?us-ascii?Q?e04TZ/CLAlklOTweBFQD9koRIXu6N2eJHimNrDEmobI84cK1nm9fzPZgyxeT?=
 =?us-ascii?Q?yjYUFvM0k7Yg/d9cW93udm9kyLHMMZG+jcjxocqoHm6fSfhcGZ4tsDCZou/3?=
 =?us-ascii?Q?aen0zliE7/r0LxB+T52sUFE5dEzDuJrt0TJgKT5qGmlGxTYicE1LG0S3AW/4?=
 =?us-ascii?Q?8xuZlw24SyNhm2Ki07v9qFX/xgCAV0YGOlxTcpvVzzENHzgIbUuxPJztiUyF?=
 =?us-ascii?Q?OtPfCN2hZHUwmr29apSKLz2y1/LVp3gSfPu/7+cP94hvqP8itx036n5qDx26?=
 =?us-ascii?Q?YTVoRjHH57kV2SS5NYvW3HXU8AB555SZLzRgJsXdnCdqRJAuHcyUZPkMeaYX?=
 =?us-ascii?Q?EaTHk7QcdUjEusSPYEUGtFI4nSCLaRxWQUC4EoCN6gOlafN2E/mU8v081V2f?=
 =?us-ascii?Q?X8dBFk3karrwhCGq2hLi+2Pa09gzFQ5/TE+e892NJ8usPrNA9Hs0Oz4SlMSA?=
 =?us-ascii?Q?A72Fe3TJK5MDT8THqDW9UTncNKL2A+IlH6MPFzzu7qELxjtOAkGFw7QpKKcw?=
 =?us-ascii?Q?Fb6CiuYuXYveSI4sKhmUvrK2M4D+daDYiMEKBQhl9VXDs8JrUbfAUey0Oird?=
 =?us-ascii?Q?oFPwNqqXpuxC5d90Du8UaaTtMnEJ86T39az9wFZEphPBzlSdI+2bujkKGRsB?=
 =?us-ascii?Q?FL4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fnUOWEjMbC1MaRNsReOKMEgwK2wAncgiE4HkegIm8QVGl+LqPnb+6T0tRm5I?=
 =?us-ascii?Q?jDYvC+v5kO/AjsZbjcVyqCvLtGQwDg1FAPgBsUBh3+yJgHqeGT1h0u0euyS4?=
 =?us-ascii?Q?mmUKm/kD44CAGPz2whX4NOiEp9fxjQIi5gQTQNrhNOHnXvkCySG5UD5kLOvD?=
 =?us-ascii?Q?9gKO+0Xxg9NT/oer/kI1MmqmS4X5fQU2/rsVJdkxb/p6j5w/ipDLQcQeAf6Y?=
 =?us-ascii?Q?t4IVIcu+MVF4OadmC9tXGPr51UCyAVILiOCYvhSJZos7ZOWI0sKMuIstytcm?=
 =?us-ascii?Q?IYgdVBSXBCpF5kTuWbGXqvCCiR7qN3D42jcVXy0lBOyZ5a91RITqPP691Xi/?=
 =?us-ascii?Q?/DoGerEUti4zEJVuzA3k4nTVozFye9fglE3waz7aqGBFk5a5gtnK4JR5F52h?=
 =?us-ascii?Q?AqRdOEnslfKZ1zhUPe6any2Y8swalqcPJK8+ubG/RPG8vMYubCTCOsWl5Vko?=
 =?us-ascii?Q?jIgwz/OgJTQiKWBZHf3vusjZyeSzk1ygFqZKuOv+sA8A8AL7O3VhhrJq6nLn?=
 =?us-ascii?Q?Nd0FaA7OIGKjSSUwO2Mc8/hRiGGzec7x6dzQ/lJMY5GQJSY6q1sSXk5QbJbj?=
 =?us-ascii?Q?52blfT2I1DlFxQDtcj+Ub/cKDHL663F+HQJ4AX2okf1CjSx4kagdrzzVgdMO?=
 =?us-ascii?Q?sINiVDgT4HuXDee55unlXh7AnOlPwLVQqJac0z2tj9NzjYSPuCFO6yRnBeHY?=
 =?us-ascii?Q?rGgbpoui/HzPTy6iav2ATkUqoudyZ4mx+qbn6qg4rvqumBx746zsJY1XicJb?=
 =?us-ascii?Q?Tidb1+WUzWXFQ9i+gX4E86cpeeThvptFas7I6yhVRwkRhiXWwB/fP0Ke99LC?=
 =?us-ascii?Q?wGRSUhvpfDOxoQOPNsH3mRv6rq+SB7vxvtAxoqZMzo4XOUdDS7uY6XcUeoMw?=
 =?us-ascii?Q?rD8E35UjnROYTxnfwl5ldEgrOgUJnzIyGLnFZmNCtilRa4TG2u0JTbeQJln6?=
 =?us-ascii?Q?LiQW2buHozKE9sVimfg7OuPqqY7zmmq5nVCOq0wSQSWpC+b9hECxVYBfrmeS?=
 =?us-ascii?Q?XhdEzoJnqrUz8ieGa/jmJdfI12Y+5xih5U6bfZrdHjnr7Njue5e1tFuZSPfM?=
 =?us-ascii?Q?q7iFrcVALsE1CXP5HEEqDOtLcovkGUp769CmrCF3PCux9Bw3i2IszTfTHw2O?=
 =?us-ascii?Q?P8zcrI8VTBIqWiFII+FmlixUfSqO/injAodjr9dOrUn/dqEg767DDvmckWIk?=
 =?us-ascii?Q?dhdyR0nCK8bYMMqk5VRc2amILrRJTiYjyqghB4+Gj8uY04mzun+kMF8ffK73?=
 =?us-ascii?Q?hikS+EaMJ4SgRvh1q4g6pm0Hl2odRs+zVv57/F5XHTRtD6LY2qCtw42lRP3p?=
 =?us-ascii?Q?XZnw1n3PCZ2YdNhdW9R6KR9zzfzujGb3FabcPYgf9MfcW8GwAoW2YKHp0bmh?=
 =?us-ascii?Q?uK9MWnYrB5VPjIMc12QNGwkzLAfza/++gp5z6om+tRabBKtAsVWCOCyrUFaA?=
 =?us-ascii?Q?cTGQ13bwhMrQr2c35oNiIKmvtPHB5lQUcd50YWNbSxEjgrfVcisGjQNNXDV3?=
 =?us-ascii?Q?5rVRCXbwGLaIQwsVvoVQkv71RIPDVqLqD0Wr7mWXSdD+ChGROKVc+ZlDBVvQ?=
 =?us-ascii?Q?v+OTsHwduWBGsvOwW+upV4/yGMaxGq4kE8ojuK1h?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778f9bde-2e22-487e-558e-08dc99e57928
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:50:04.0236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGMSKfj1cXs7NeJ3VuofvinLU13CfW02ejhNoeNrfbKiOKcedrF2fXlltNpOdCVOLGPD92ul4+VUrxivYIxG1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0519

For usbcan devices (M16C), add struct usbcan_cmd_tx_acknowledge for Tx ACK
commands and struct usbcan_cmd_clk_overflow_event for clock overflow event
commands.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - Keep the "ignored events/commands" comments, since the patch that
    actually dispatches the command, is later in this series
    Pointed out by Vincent MAILHOL [1]
[1] https://lore.kernel.org/linux-can/CAMZ6RqKqJX6eqogS2598BFm-AN1uOBbBGL+MkoJtR=-z379Q=w@mail.gmail.com/

 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 5839333eb5ae..2c0313c8f63e 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -242,6 +242,13 @@ struct leaf_cmd_tx_acknowledge {
 	u8 padding[2];
 } __packed;
 
+struct usbcan_cmd_tx_acknowledge {
+	u8 channel;
+	u8 tid;
+	__le16 time;
+	u8 padding[2];
+} __packed;
+
 struct leaf_cmd_can_error_event {
 	u8 tid;
 	u8 flags;
@@ -288,6 +295,12 @@ struct usbcan_cmd_error_event {
 	__le16 padding;
 } __packed;
 
+struct usbcan_cmd_clk_overflow_event {
+	u8 tid;
+	u8 padding;
+	__le32 time;
+} __packed;
+
 struct kvaser_cmd_ctrl_mode {
 	u8 tid;
 	u8 channel;
@@ -363,6 +376,8 @@ struct kvaser_cmd {
 			struct usbcan_cmd_chip_state_event chip_state_event;
 			struct usbcan_cmd_can_error_event can_error_event;
 			struct usbcan_cmd_error_event error_event;
+			struct usbcan_cmd_tx_acknowledge tx_ack;
+			struct usbcan_cmd_clk_overflow_event clk_overflow_event;
 		} __packed usbcan;
 
 		struct kvaser_cmd_tx_can tx_can;
@@ -396,7 +411,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
 	[CMD_START_CHIP_REPLY]		= kvaser_fsize(u.simple),
 	[CMD_STOP_CHIP_REPLY]		= kvaser_fsize(u.simple),
 	[CMD_GET_CARD_INFO_REPLY]	= kvaser_fsize(u.cardinfo),
-	[CMD_TX_ACKNOWLEDGE]		= kvaser_fsize(u.tx_acknowledge_header),
+	[CMD_TX_ACKNOWLEDGE]		= kvaser_fsize(u.usbcan.tx_ack),
 	[CMD_GET_SOFTWARE_INFO_REPLY]	= kvaser_fsize(u.usbcan.softinfo),
 	[CMD_RX_STD_MESSAGE]		= kvaser_fsize(u.usbcan.rx_can),
 	[CMD_RX_EXT_MESSAGE]		= kvaser_fsize(u.usbcan.rx_can),
@@ -404,7 +419,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
 	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.usbcan.can_error_event),
 	[CMD_ERROR_EVENT]		= kvaser_fsize(u.usbcan.error_event),
 	/* ignored events: */
-	[CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = CMD_SIZE_ANY,
+	[CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = kvaser_fsize(u.usbcan.clk_overflow_event),
 };
 
 /* Summary of a kvaser error event, for a unified Leaf/Usbcan error
-- 
2.45.2


