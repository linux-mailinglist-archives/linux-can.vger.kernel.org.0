Return-Path: <linux-can+bounces-869-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 339AA91C6EA
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EA81F25540
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 19:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E584770E9;
	Fri, 28 Jun 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="Lfw9Zc4k"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2111.outbound.protection.outlook.com [40.107.104.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4011770FA
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604553; cv=fail; b=XgjPM29Q38e2Vwid1W3yeDWK44oedSBdM6ki4/1lzLNYLdfh/AswEEbFCzaiEuErZ5Qt+zaEXERGomxgCtiP6Lh0/OAIpNnVZ6UyfhVhQ2+9tUrECP5SpwK1wnVEAyDnaw0j3DL76jzNWgVyrVEFxmflhqEl1LON7mLWNRBjaYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604553; c=relaxed/simple;
	bh=k0EI/naW0nJ71JEb8IB9iXoxtnuUt6IVDZUnXdmp6FE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AswGcSQTTXsHPgCPnFpBnSlf4XzscPLawfm3Sz8c5StDJgIYDs8VRTetbdwI/8N916/hhgZLQco8jZWe16rMiuTdNJbwWG7jdQzH3sw1IIeOoM3LRpByFz5sb4vIuUyu/EqnmSFRQKXV6UJ3dmTbnWxLQoBkniNGJdCX2yBhKck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=Lfw9Zc4k; arc=fail smtp.client-ip=40.107.104.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZG+bHwcUI5jDk84zmiIicWZjgQKPx4KX0yL44mkdE+74qPTqIy/P/f6QeorAzTBIyvJ9yClrboqnC7embdbv1OwGKCFNrZyWbUAG5TNRkJUopfls49GyiwEufEyAthPUQ7YTouBGg+NwzJuV1EDTzjS8Z3pG7Eitx+0JgR6YoE3dmCCA3cmta6TAgu7PJChUwjJu4tDIEiEY20wiQR5BAa4OoEoKHc3+wMagkzHZqqU9sLIiok5Bk2caJHXpKbzUWEwydhBt4TnzJcFU1Xe6RAOIMf+ZlB7/pAB5HXU+XK+KhsjaD1tDWO8MhhfhytqkmLXlde/Rz4ms0jIlhAfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNqyrrNq9otJWY+Aj1J2/99kZ/hqJYf8ZOrVvd9iCf4=;
 b=GRpYo6viC2vdbe0inIdljYFnmhoR8tYhfR8H2iIQ0Z6SJWvJNersPto7D9H0wiwL/hPszqmp0Z+EuwmbanfAKWuXvzV7lmMWEYKpA+Tk8N/A9DqtUVHYIxf0l/H2sDMLYz6ux550Uqlx2x3NY4R3fesg+kpAbva1EQTvTqJMfPrYePkbRQGhSQgHr+EoEJY+niDDhBg0NuNUigyxXamEE8EOXtH6HeZOJqq5u/QX3DtIJ3ckaHk/rGp9h+vQk7/Bs7f3HNxLmouudv3d57P0WQ7KECdckDYjax2Lex3FlgiyCK6wD/xY5MPckJFS+a89KYQPsV/49DLHaTUS2WmR+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNqyrrNq9otJWY+Aj1J2/99kZ/hqJYf8ZOrVvd9iCf4=;
 b=Lfw9Zc4kJZyyKsCz91klh4qiD4gFmgZ9eOBgTrUyhuAR5S/eZDPYKgRj8ZTp2WdxgBWuUx6t25HvCsAkhbgYKJYFKLRUHIX0u/79RW0TPO1LfyTvwymllaJ6Lm43WkEGn4zItViqGZqejPH1vtdiwYNe67zqW2j96Q29R4ePGQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM9P193MB1142.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.38; Fri, 28 Jun
 2024 19:55:43 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 19:55:43 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next 03/15] can: kvaser_usb: hydra: Set hardware timestamp on transmitted packets
Date: Fri, 28 Jun 2024 21:55:02 +0200
Message-ID: <20240628195514.316895-4-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: cff211b3-1ffc-409f-dbd3-08dc97ac4b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aZpeQGkCjJDaC+xoiWtnYd2CxhOqW45VIpoNOw0KncOfTxzW0ERH8Y2oljBw?=
 =?us-ascii?Q?ly7Y2utYBT8vJ3OlYVvZhiwg7pRI97K7oD7bCmBuMw73J5bs4WF7Zl+xPngK?=
 =?us-ascii?Q?m+o65+tZV6Fa3OhkCqRQJemQFYDbts3xH1KEFN+9uL0+txanmyWTPM5NGnCh?=
 =?us-ascii?Q?L4FQ3MIaFmbGjF9OAXgosjm6NuW3gCNVtNY9h7Lc+xIDUhlCnYhKzSC2cm9z?=
 =?us-ascii?Q?m+mikW9C7bmEJOWQQdUiwVbB25se05CftQDx7+7PCqsT3DQ5wBFk6nzQoJk1?=
 =?us-ascii?Q?mo8+f7NrpyIjX+rK3LpmuKwLxSwIP67Yd9tpOjJ2d2eFu8W7+OlnvSNiSKOf?=
 =?us-ascii?Q?6RTVG5Wuz5RDSoSSrDeOC3F6owb9D3BIi3xcBtKrDHSiAqaVCLHoINIBtFJw?=
 =?us-ascii?Q?D6vk7rfztBiuStGs/3CzA9btm9GzUA9hvM8zPNrhrTqz6pyyUhhOfKO0xedI?=
 =?us-ascii?Q?OfCokwi32myDGDkSALIZKPTXbsYjzHqERUv2B4sqkm7f+YJ9efCqhBQ1QACl?=
 =?us-ascii?Q?x76EWZeaXo24We+Ho8Y/9xr3QiBW00UJjZ3TeiWVWSKJoP/d2LxNsy5zjbHv?=
 =?us-ascii?Q?hFnhpU/nkK9o3toN8dcVhxPXD+xkAXHp0DMwCGtltcYZx/x6vNJ+oRyyAZdV?=
 =?us-ascii?Q?t4DyLwSSdzc6Z+LvpmOAcRHRG6iFw3XiuYfzfvMW42hxlqbrhCy5Vc+P71qa?=
 =?us-ascii?Q?ak0VpA4Q1L2F3ZvD3MKrmB4WnHqiWSZGO3k24nckA/56Y1k5t/Wh28trwToW?=
 =?us-ascii?Q?Xkv6uZ/nQrClLgOq346kXnphtpLAobeYoEy7Y5QMvfmWXXnw4+66/wZQoNsF?=
 =?us-ascii?Q?levJo+60sc5kgUuP0ZqEUlnqQR+bRmVmlKzhz3JqJrM2CyDT5vukxOcUl04K?=
 =?us-ascii?Q?8GStgXvP3jImgmPft/EOzx/jZcqXQxogMHK5RgMyYMx+Hf/X5wkSuQi0CV80?=
 =?us-ascii?Q?bFLrwI5GlDg13koFAmFOAKPSmlzMpn4R0yKEdcvKmemd5zDw0iHADGrtWhi0?=
 =?us-ascii?Q?urPe9trY2jiSDFua2NYuMm5I6f27L/v2X35X5mtSlfY5SfspL+SAD6mJHOCN?=
 =?us-ascii?Q?zmynwN+DF1gwn8QFGsMvDHK23/mb5FKmZlmUD3wtAUnyFT6CzcOtA07CV/kD?=
 =?us-ascii?Q?Mm3LtALRDG/jjDJO3FPnEGl5mpAzAiJg2MH9rekM1nSHk8Trhveotlx6PgjS?=
 =?us-ascii?Q?ljm73rHNZMOBJGmwgtf8HnOiw/pEFOOJPIxfPlygDVFZqZn8Dq101pksIW/m?=
 =?us-ascii?Q?MQu7TLyXnkxlBGdy3Gm6cY87AJQ7bGXra9s23J1lso1m5oaq1/T/3tvIrIMF?=
 =?us-ascii?Q?QFJ/jjSVA8JNROySTrYoHX1T2W//VIL3XgGUY7gih65ZKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1pUbnZ17K3kOXz4DNJ/yZVmPGdC9nYhyEQF1qA3XGW73t/RJpmfTPghdRdFt?=
 =?us-ascii?Q?NG/kH3dw3/Jz/AhDpCpNSMOXd3+v5tp21c3DNRyB7HhA9beaNEPR55Ni6Jqk?=
 =?us-ascii?Q?tLOcLk8xnZWm0NDb13KBqXW3UrpO0z0ZftjAXubCHliLL8o+Uxe7fBwOrez1?=
 =?us-ascii?Q?KkunVKoXs1nwyAzsuZ3WTzLJa8SSjZI3pdLEIWpCtUZ02RVvg3Bky1Rx4bn1?=
 =?us-ascii?Q?7bFH87m0j29LC6z4F0bGGzDgOAvtaMfAO49JyxWuHJ9fXQOk4mT/Om9i7k9P?=
 =?us-ascii?Q?EfAY6A0lSH2iqLx3q7giai3H5AiAjJHYWep7tUQSm/7bhIpSbhx0qrSO23m1?=
 =?us-ascii?Q?OxhNsRmbNGYqzJy87fOi4Ek4sForWG9gkxFVC0uRd54YlA9I/pjhCx7qTbWI?=
 =?us-ascii?Q?lgnvyikwGKZ14Oy4P9cpgjCkTKfMIvcRpHgm0JO5thvC4HcK+3PGyOCeWUSH?=
 =?us-ascii?Q?UNh+CXxyeait4XyXvTIaPF3sgmI7KC6f1ZMpYUHG6jU/qC42hRoWhFQG4x7f?=
 =?us-ascii?Q?AUe4q4u3ocuzesqHb6Vpg2rpEEV6VdQNzUq31dlx6z6h26/PSd21ONrN3FQa?=
 =?us-ascii?Q?gIShjiussm8uhsvz9kc95wIoVD5qd8XXDalREEueNhdnRqbjcXTFIPRfb4zC?=
 =?us-ascii?Q?U86OfsBr+M3UFTVU8jA6U+PBHRsw/bAwAm+J2gzg52lHU8lwGwvcYMntS1HR?=
 =?us-ascii?Q?rKrFomHRHFGNX6x4SxtiJnXbh14cqJ9hTO44Td0np+5XPVMNKxzhYh0VTqTl?=
 =?us-ascii?Q?teZU0KqCp1SvhTSuyJIny4sDf9l+NwbxJuApJGPTrE3JA82HK/QWA+4wIFht?=
 =?us-ascii?Q?U4fx89okCd2l77cgoxUqRl19d0d3TpHhS05HUtOi/kgXFPe2jesEPe4aJi5H?=
 =?us-ascii?Q?z+W7J1KVrqZr7jlX190O2fqIQMeTC8QzmmpNPP68TgZoRioGidM1lYJyHy8m?=
 =?us-ascii?Q?5ZxseJl2Lj8gUnSrS0aisEydYXYHmEI5UQTXyStmAS1X1TCl0ofLROJ5VDRz?=
 =?us-ascii?Q?yih0e0vs4nN6yDq76sBim3MO5pnB0bx+XlJqzGDR0LRqv0m1YMkQ4Po9G0nV?=
 =?us-ascii?Q?nNZDQuJitCNTeUBd0Xv+WMVAgt/YbDe9xt6FlmxqnXA1aFv5sRHPMFAiZ44J?=
 =?us-ascii?Q?U10ABRvL8XwTJwRjCisGZ2PGBH5bv6ywCKymmr8KDyoBVYlBYm/cO1NlOEal?=
 =?us-ascii?Q?4L6ZkpVLmdc0lrBpKRfi+ymhheK5I26fBcHRZ+ann5x5HbHJMVPjgXAWDXNz?=
 =?us-ascii?Q?eZu3Oy1fb/kVCKFWAeNNoVHRYD0oN8wla5Sedll2A9L/jjv5C1zCODRghQRs?=
 =?us-ascii?Q?EmBWq0rMU7ZCwj2SXzIhXp3FJFdYVPrqIt5qc0j8DbFZy0cuhtOFMjFd2Sbv?=
 =?us-ascii?Q?cl1GQ0DF9HjYZxLBdz5DoN3K+UURDjVUa9W8RvHRNzfFfaWNBe3dyYZkyffi?=
 =?us-ascii?Q?UYyjPplHNMn3YJQcwumpWymuiAx67C5XrMufFbTKQytcSqJJxLLZgfsSAC/8?=
 =?us-ascii?Q?DVRt7R6OhnXt0EkbFEXe+0/ARxnYuemo2Wp3zOPRl5M64yJB8z3CDk1y3seg?=
 =?us-ascii?Q?Nv30Wzqj5Bt4ciwGfsrcXjn+PJtNaFSWa4Gr6BWe?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff211b3-1ffc-409f-dbd3-08dc97ac4b09
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:55:42.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6cGex076itM6whleCvbF/8mzD9Vk4m3jisSkcNaz0tIb2KVP85gq+xKwvS9ztgdmQhQisQRIOKFj07MJzsziQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1142

Set hardware timestamp on transmitted packets.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 0be1cfe8d964..28a99d78ba8d 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -10,7 +10,6 @@
  *  - Transition from CAN_STATE_ERROR_WARNING to CAN_STATE_ERROR_ACTIVE is only
  *    reported after a call to do_get_berr_counter(), since firmware does not
  *    distinguish between ERROR_WARNING and ERROR_ACTIVE.
- *  - Hardware timestamps are not set for CAN Tx frames.
  */
 
 #include <linux/completion.h>
@@ -1191,6 +1190,7 @@ static void kvaser_usb_hydra_tx_acknowledge(const struct kvaser_usb *dev,
 	bool one_shot_fail = false;
 	bool is_err_frame = false;
 	u16 transid = kvaser_usb_hydra_get_cmd_transid(cmd);
+	struct sk_buff *skb;
 
 	priv = kvaser_usb_hydra_net_priv_from_cmd(dev, cmd);
 	if (!priv)
@@ -1217,6 +1217,9 @@ static void kvaser_usb_hydra_tx_acknowledge(const struct kvaser_usb *dev,
 
 	spin_lock_irqsave(&priv->tx_contexts_lock, irq_flags);
 
+	skb = priv->can.echo_skb[context->echo_index];
+	if (skb)
+		skb_hwtstamps(skb)->hwtstamp = kvaser_usb_hydra_ktime_from_cmd(dev->cfg, cmd);
 	len = can_get_echo_skb(priv->netdev, context->echo_index, NULL);
 	context->echo_index = dev->max_tx_urbs;
 	--priv->active_tx_contexts;
-- 
2.45.2


