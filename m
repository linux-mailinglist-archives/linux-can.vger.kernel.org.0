Return-Path: <linux-can+bounces-866-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF46A91C6E8
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1CB91C23CC6
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 19:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B023C770EF;
	Fri, 28 Jun 2024 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="NmxySj06"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2111.outbound.protection.outlook.com [40.107.104.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA5D770F0
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604547; cv=fail; b=MFv6LySHgCKzj/pBxacRXWe5cUc8n/mDlQhNkg3q/FfarvTPDythZ0+QjXeaYOThE2uL0u96T5oNGG+oP4+pIRkho+8qaFRO3z8KmsKgUgeoIlPkc50EOSD+lY8fXRJyPBPejz3+XmTmFWFJtUvcKeMMlL4moVEr4TRrh3Rjc5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604547; c=relaxed/simple;
	bh=LwuEGfAwoVpwVZu7jkAn4p7twoGGBtqgFmb0H+aEWFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dDVn3dlA9wzPp51u4auJ63P5mGq1UTrAIgbXgl781O4yJk5ldRgdiQWfMo28VPeLSYESk8sX56lNOU3fukhwrXEbi37qe00mWi8afsyywM/bNA/z0s0L+dGB9hkwh43qYCCy5UA4Z9jzfTwY4jkPK6AmIOWzD7B9YeIVxJJ+bRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=NmxySj06; arc=fail smtp.client-ip=40.107.104.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+DVmcHyOY3lczO7lALeaZNZigxSaBsxDELUW8RAdYy1Kq8sJkmU9/ZGSJKDgTRdsMG5qWi3U9ByO/CpmIzQkXX9XtaX6cTzlRautbElLdmHnjWvA9Mznoww9kXSDCV82RF7AIwn+WDTHRBos2b6er3VP1rkpSci0T7Hk2yNkdeI9SGcTqBv0/z+/eXvcxpFnAJwh5B/7OtI6q+l7pcsWyqaN5q0OTMbB8O+cu43IVpdivK/QPaRFU9CcG4oAT4hdfj/HaSI7W042qXQrSgg2hRnyZJSub3WvQuhgZcKLqujKFNqgnUwPTfLRAoeLN4yiTg53+cxZzS0zAw0krGcKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEa1LtJ6TLLw9/VJnGk+U86qnx+0klpZfzdU5aBAQcA=;
 b=LuFDuMHHxG84W6wz6Rv/MgUPWnxwZPHvJz9Y3Sxmr8r9U3ict2cEiheaf/qApbEpUTC2QTRdqEym2fGXuZx7mgwI3/7P81a7tyWTzXWN8j4H8ow+TMRVpUMI8wkkh3R0CIcs1w204YLsEbhnZHk4nUaFeFaotU62B0JsJKPzEUrMjPUGROBbObHtZmFsXd6KOQ7TKjgGB/vYpw2EC5PobGqWXLAA8k3Mh1vAdlNbXxcyHTxzFi5OpsaBcD8TVGMKL3iBZgiSiEqwOQiES790W5kZ8V+N40wEDtXZjMWipNyGIIhdjPNStiimiJYku1AYc9IhqTF9j0k19LLcLwqg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEa1LtJ6TLLw9/VJnGk+U86qnx+0klpZfzdU5aBAQcA=;
 b=NmxySj060e0KM8cKq59/x1j3jErFMHzLI35B7h6NZod5LzPjf/YFxhkKtJr98oJJ+YEjZFaKQ48sFeHrgHOjfFsjz0r61l5NSxyKlEU2JoKuej3mbhQXSOXPpO/5YvFHT41FywNa4b+uhRL8knVOmv3Qz8jbOSDxKz5TCVahugQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM9P193MB1142.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.38; Fri, 28 Jun
 2024 19:55:42 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 19:55:42 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next 01/15] can: kvaser_usb: hydra: kvaser_usb_hydra_ktime_from_rx_cmd: Drop {rx_} in function name
Date: Fri, 28 Jun 2024 21:55:00 +0200
Message-ID: <20240628195514.316895-2-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 231d8db2-ebce-4abc-c72b-08dc97ac4a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RcHi1NLSuUmSawzQULZDYv8C6RWpqFUH1jY1+j/3aHXJcDTkyfMPJcnWcVpl?=
 =?us-ascii?Q?CdH7O537maGUZAGULlK7zRztp1zUJqny0B3xM7k54EoNIKjtXCkC5cCBPX+L?=
 =?us-ascii?Q?AyId3SZ3DLdrqTVq+CgpZB+9LlQ2X/fQeKXHaedGwL/YGM0PnB7glplp0h3G?=
 =?us-ascii?Q?60pZio/wLIWwbHcnHXnKuRG0dpolc8RP9Anhzs+hXPQCKW3xzFsFJheF5zJz?=
 =?us-ascii?Q?ammOZp6Lkquwi1xcrn+siTvqfAK3DImOzykSFo9qloOFYbotU3QTQrE0yP8W?=
 =?us-ascii?Q?rvbtnUoOxPPcNXIRn4iGL+nU4gbR+VSEEmOEv+Z/idULt4xnarhyugGwyHSF?=
 =?us-ascii?Q?wfR+J4cbh+8NgQyHukENrNcMXFuByDRmCvg5ED6t4HoN9Kb5cpnWyDK21bvf?=
 =?us-ascii?Q?Wo2eatBcZxjrxgOyt+h5A35QFliKNrM210JetiXQnmI12kq5x4bSHNmvaIbT?=
 =?us-ascii?Q?FU7Tl7P4SdsDnc/qDIRZ/pyvqbg9+BqCTkSXgUGLZBUygw4DE81Ha9FiY7OD?=
 =?us-ascii?Q?9yE9ys9HafGLheamcCAz4mA473E5LpmRcxsAZsAq5zq+Lpio0ZAB6+kQfU2K?=
 =?us-ascii?Q?06SWBpzqSWktWoP6MYYH4zWzLipbszDbr6tzoXn+uWIkxQdcZseaQdbsLMsg?=
 =?us-ascii?Q?uFE9O4eA7BZ7q7IJGKCpsXWdSXVT8NkdGUlfGPHy6v08PG2JihOwwzC1dGjk?=
 =?us-ascii?Q?2MGL/h4AQ/fMMnZrQ0Bmhmk7kVWfsb4clB30ZDS45QIbijtmrbuHynGMpvCe?=
 =?us-ascii?Q?173M/VQ9YnE79LkOROQlKc6jS3oeW9ZGFq1pqtifqNG6VModPieLGxSbKypY?=
 =?us-ascii?Q?l6rTqc+kBZjvsSEDtXW8tfweKzO7ahG0MdUPO0rgjOxIgqIORW8t5ZstAeCp?=
 =?us-ascii?Q?nFWTdMVxOxwUnjyerj455oueZ4UfyLXpyatI/PiyEVbNkSqUtLwqc9+mbpnc?=
 =?us-ascii?Q?wdEYrRSxUSsjAtaTNXrySvhPEJbqk2wUi/oLWuhObQH4jgUXG40fx8jSu7Pu?=
 =?us-ascii?Q?X6qs8lzVqvqgF8qATUuJMKCJDTYrLT41E0sIr0VTbzKhWHK3uc/964KfXyya?=
 =?us-ascii?Q?ajFW7Y6FzNLvZDZtX4fuMejYzr85O7/JPkPZabXsU88/Ir01VYD8vnEb7uhN?=
 =?us-ascii?Q?fgHSMDTbIBwz6AqF/kcK8Llskm7/5YnLbLeinz7CL7usbHaX2CK8Vsnt4wXf?=
 =?us-ascii?Q?iiaxQ1yWiR0qIuPZjbwvaRq6p3unC3WRfq+zaX2hyxPjAO1oOXlpQTcCfTpe?=
 =?us-ascii?Q?ZYUjD1CgM3YZVTsK4IY4p9sMVmXVxs0iRC+7yFsbDddGCK8mbIT0YksdNTMf?=
 =?us-ascii?Q?QR4hBh4CabdRLU6fdFiZC/dZa0XNoA1ZuGQlgOQ7mZN+nA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j8VXpZxQNAWIu8vkwE3dTm8Wt71bkAIiNfriGVI5iYyPFFPfQdrNd9mXzU3q?=
 =?us-ascii?Q?JxZ1J9SNiQiF8w4VKrqueXbXT3L+BXS8Kvmk3dEFP5zaUyQCYhFZkNWvDE/s?=
 =?us-ascii?Q?vcVYAIjyEIMfywu0OpWLohIA/ckxkuJOAMoh/TIU3CT2rmaCBROXLCRns7Qa?=
 =?us-ascii?Q?tgQg8l1BUMKkYPmYbYgVf7fKBBNc1/qJS2otx6H/Sl74/DFvBirnum+pHkgN?=
 =?us-ascii?Q?tGZ3piM2cM1Q4Qaga9KRX+ylYKG1TEDARyrr64nohsUZ/6O06/BiALLCMjZG?=
 =?us-ascii?Q?gXaqew3S5RmY+gacrP7x2fanoVkN+gV99Li91iq4IaiDGQub56/nrO/qDXdd?=
 =?us-ascii?Q?5+tUudz5fIb8oF0yfupmXPqhWGjHknnIwiEChODznsl/uQUmDtt6z07uSh3k?=
 =?us-ascii?Q?nSxZ+9HwCKEbTZwuTCEGYYyJtUOpjKlaESVw0z4vCj3qc+o0gcaq/Hgj7/pb?=
 =?us-ascii?Q?I5yR2NiWysTLiNVODVlmimwluesr88qN37v/Tf337dBiVw8fVI+rfUGmh3so?=
 =?us-ascii?Q?8naKOAvz+Ls6pRo0ACGamZoG1PZyKU2gnDlxyqnZ0KBYnKXfyxqGFohi0BN9?=
 =?us-ascii?Q?/K/DJEgovBW/fISXh1irQLHGZD4lFnBUHBV3r/URManOB9D2WbHRN23x7sDu?=
 =?us-ascii?Q?m5MdTf/wqLEZl4ehh9TFiAJVin8xemvmio6Q03NjYikTma73L2MChUPLQ4wO?=
 =?us-ascii?Q?DN1yyy+H51dlnwxmmitBaYE4HJ3Rwg6QhhUjEGuUjc9yA1WpJ91F9hA5Ryj+?=
 =?us-ascii?Q?EzSKJDsRU06LBOhqDiCwrImL+wJoeklyWTkw7q/oe/4uHqhAMLBdr44a3QSu?=
 =?us-ascii?Q?ShjCTzQmOqzhNCToWDbttMJ+QifvrapkzWIy6Ba6kXq/L7DOsmKmsNH6UhO/?=
 =?us-ascii?Q?MQkHMeWrFzLCNS8V4RzTC2gV4JBOc67lCOVlYQSEUav8wE9CrwSkgVOTtE/C?=
 =?us-ascii?Q?hJWVoaxS8MMQY/oSF7YcRYYgQ5NrHM8lCTQvd/LnryyWY7Ndt232y+EA8GWO?=
 =?us-ascii?Q?cwOZsux0ufl2elVwg5WBorcriOjWg2VbfAloVNHhoHYwzoYb0r9IdeOyD9+G?=
 =?us-ascii?Q?DSUoZ26gfponP95d/597aX3M+g2PuM73LgJef+eT17ClhilVu1ev41k2ZXEP?=
 =?us-ascii?Q?cicVztwQOaQBNFtfjbb/WWdG1tnWpae4qKXyEYoYpJIMKWexcWBXYRAeGb10?=
 =?us-ascii?Q?fiiOPx1e0sStMc18l6Xw5/vMTaicCEBfa3FUpxgKYy1uo/1QMonbAWRcDl0a?=
 =?us-ascii?Q?a3SxJawXsax+GuqFPi3EX/S52a/xB8sGlGuJJqGkR/2P6dwKVzD9r2KBMokf?=
 =?us-ascii?Q?/XxF4u+/dXa7nJ0FvEWF9Pht7ntXGv5e5Ez04MpGSG6QGhfE1Awnn6K2ewJB?=
 =?us-ascii?Q?xgdryUChBreS28Smz4W2/2Z49XhyqWVbiTkeIdh47eNyZVK/H+9iQqlCgmbx?=
 =?us-ascii?Q?wPTFj7W92q4TMoTAVjcHZT05cCXMUyn6QBSuOJHu1iYXpFrbeOtrVQUxI2ab?=
 =?us-ascii?Q?meJYsJtP/wZju+8AUA+CoCnQ/IdwFW/Bv1mWJwJCL4une+at/2Ea1HlWEehl?=
 =?us-ascii?Q?HDVBATtkWwpJ6wlNrH8vO5OZTmZnLioXWwzgQvvz?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231d8db2-ebce-4abc-c72b-08dc97ac4a87
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:55:42.1443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3wuUOuUHp5eLLPLRxWza0O1TIhzkIql8iOOdil5sW9dHjLSY97ZUSU2qRsYOuy1sIX9gqmBsARyCkkWezjY2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1142

Rename function, since this function will be used for more than just the
rx commands.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index c7ba768dfe17..a971fcb6158a 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -522,9 +522,8 @@ kvaser_usb_hydra_net_priv_from_cmd(const struct kvaser_usb *dev,
 	return priv;
 }
 
-static ktime_t
-kvaser_usb_hydra_ktime_from_rx_cmd(const struct kvaser_usb_dev_cfg *cfg,
-				   const struct kvaser_cmd *cmd)
+static ktime_t kvaser_usb_hydra_ktime_from_cmd(const struct kvaser_usb_dev_cfg *cfg,
+					       const struct kvaser_cmd *cmd)
 {
 	u64 ticks;
 
@@ -1234,7 +1233,7 @@ static void kvaser_usb_hydra_rx_msg_std(const struct kvaser_usb *dev,
 	stats = &priv->netdev->stats;
 
 	flags = cmd->rx_can.flags;
-	hwtstamp = kvaser_usb_hydra_ktime_from_rx_cmd(dev->cfg, cmd);
+	hwtstamp = kvaser_usb_hydra_ktime_from_cmd(dev->cfg, cmd);
 
 	if (flags & KVASER_USB_HYDRA_CF_FLAG_ERROR_FRAME) {
 		kvaser_usb_hydra_error_frame(priv, &cmd->rx_can.err_frame_data,
@@ -1302,7 +1301,7 @@ static void kvaser_usb_hydra_rx_msg_ext(const struct kvaser_usb *dev,
 		KVASER_USB_KCAN_DATA_DLC_SHIFT;
 
 	flags = le32_to_cpu(cmd->rx_can.flags);
-	hwtstamp = kvaser_usb_hydra_ktime_from_rx_cmd(dev->cfg, std_cmd);
+	hwtstamp = kvaser_usb_hydra_ktime_from_cmd(dev->cfg, std_cmd);
 
 	if (flags & KVASER_USB_HYDRA_CF_FLAG_ERROR_FRAME) {
 		kvaser_usb_hydra_error_frame(priv, &cmd->rx_can.err_frame_data,
-- 
2.45.2


