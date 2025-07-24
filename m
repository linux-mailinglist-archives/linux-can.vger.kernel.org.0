Return-Path: <linux-can+bounces-4087-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C52B101CE
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 950CD7AB381
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 07:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77AC26B769;
	Thu, 24 Jul 2025 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="R9ljpe0V"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2132.outbound.protection.outlook.com [40.107.20.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDC12652B4;
	Thu, 24 Jul 2025 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342245; cv=fail; b=d/RkH8PXd7I9asTcOx0GeVfuEsA+nX247R5BQ59j3X0dIwNVXvnRshQEuZKlLldL2NaEQUAer5xzrfV8npO8dJQ2DXNqbP6hiJks4eqE5q/wCP6UJaBam8n3qUiR7I3qwlOmbb17LwOY1afi/u1ugAWQZsE/gYW6moQqgI7JRHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342245; c=relaxed/simple;
	bh=T/gFUfs5FQZmyGzxf2eai1qV+g4bTlKwnWe/OKLS4Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JaTARKcOvSBi+aT3VDnjf1figkLd4hbGsnZ2dxkJ+vCPzOZUoeXt0ikkz+hKvEWsOCIYXziNjfKxIw5GtfCND+24E4sJi2b3ue1YRpsNi8OZ3+fpS02oD+vZOQF7boQqgwnWrDkLaNqfgGF6losVX5LRVsgg1bwL+aOe4161UfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=R9ljpe0V; arc=fail smtp.client-ip=40.107.20.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qvd7osTOhzoNKgJQ9wymbbCo2JXh9z2enIp3p74xAQrbpz3Nzh8/pXsi8+CPA7dlhqVm6crLU+fpOvO4bp+cUElDWLl207grB48AynH4Ki1mBXTpwA6ziQLAPT77uk7gx4VsT7MDvjqHhD24yLJ8VnYhdJCSmHcW1xpodbmV1u00A3bJbsCG0h4hj37u2idng1FvTyGNV4KcQdGF+eb9ZqKMFKuBFkmIWb7H+pypQlznHYl5VFPTf2k1kKBAnrKy99pocIcOQc7EC5k87LNVYUPtIJHyatPpKwe248afpZft+01VJJX6Fnn43i/KGglmH4n0M3tvopNGu3vL4F3hLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViaWm8i0Pgd7/dVORIv5bk1AtkxGclq60jw3d0FUomw=;
 b=aImR5H5OF00Gfsj+SHovJaZZpzP119oDbGyoElyB/Q2ENtqAiP307CRwUWxcTCwjcryo/R+vP/v/QYfo7tnhVngfuuoYFEKBLZvmNUxMZUNGowAgvOrt6m1U0xRtGWLhL7L639z4wOzsfuf1stoNc4rgYq45+xNXJTDfp7eNbCntzpOF3rP/QtekzdZR73VFZImQGFHQyk6yAObsRIy11sOsmv24b/R3TiqEsCbAsu6OyOUbCGKncUJzLl1gn8GiKMPOEVw4+aTr2/NQ4123juKQ3uZkP09Dw3/mv6ei1uBQ/rOVCouj1SnHJUm+i8kNunAW68brIk0Zu2Ez8DrlpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViaWm8i0Pgd7/dVORIv5bk1AtkxGclq60jw3d0FUomw=;
 b=R9ljpe0V4eKb9u5yBdlA/6x0tmkRVM1qz+gMMabbCDcWfgdpC6Qir07rVq3soe2jnBD/Bey4LsNAbTeCDFQnNkD6LukFTSo6pMftoSPGc+MPwPbEt+B4EdF9xsTtuEEcNJk0xPbioJr7HvNMKitpUpEh2YP5/tqvuUFN5TSvzQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB2657.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:32d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 07:30:34 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 07:30:34 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v3 01/10] can: kvaser_pciefd: Add support to control CAN LEDs on device
Date: Thu, 24 Jul 2025 09:30:12 +0200
Message-ID: <20250724073021.8-2-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724073021.8-1-extja@kvaser.com>
References: <20250724073021.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0090.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::8)
 To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM8P193MB2657:EE_
X-MS-Office365-Filtering-Correlation-Id: 85802ee8-7ead-46c9-2131-08ddca83fa11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B4LUBIuPzW8/MyOotmfQkornfdMd+kY8a9DH7Ga5FoiQt8uwFU4lgt47oL34?=
 =?us-ascii?Q?+2QvA4HaRhBWybtToQpfvkDS+FBlA8ABXhopPk2YtoS2hgGGF1yKRPlYO80J?=
 =?us-ascii?Q?9L+D7BIfwgqBza9ZreKH6IqcVS2yvGW12xJE7GODGkCXja2dkpwhYsTxYJcR?=
 =?us-ascii?Q?ryQ0NhpHCS8e8aE0mYN00W45vOvXe6ElX/RSBNkPl64tvdXs/hi+vXwxyVG9?=
 =?us-ascii?Q?To6cLP39Kw9Zg1pNZuSeU0Qj2Mj94d3V8DHfD9ZrS5Ek807cArjHv1DID0NE?=
 =?us-ascii?Q?3/z2t3k0cvQ5hAJKnGEXxwJtpGBx7aIOFf51dekYgB8ltlaemNlWNLQxfVgd?=
 =?us-ascii?Q?ZIU5tOTCl5wZqhBT9BLuIw7gwYJHEqrkhg9miedWhmeradzN5TNyrMh5aqBR?=
 =?us-ascii?Q?V+4pHkJrGhbs7V/3vbpecynERcy5/tCtk1tlXrjzjqx7Hkkx/hc26hFi4IKO?=
 =?us-ascii?Q?bJf0YRwSKejwk5SYwwiVjbv8ouoVPUh6cZLL5wOZyeGwtH3QRR4MGXz3aIwu?=
 =?us-ascii?Q?g/Z3K0Fy+AUZID8DiV0fFeSqRKwpZ9Lw2qHJP+yY2DARtAcnFce1gW+KqFOp?=
 =?us-ascii?Q?6+8WsikYqPTi/MYxF524W5YaVSAzH1QJcmqKqRvSZOPKccSCqKBeBolnVCg7?=
 =?us-ascii?Q?K5TR2XDfOW0dowf/IsHbHhKetfQp1e1vqlh6g25GOK/E0/XE9dfQYBUAlweH?=
 =?us-ascii?Q?WM0vHwt+Rhp1+72mSGffB4MOW8H+DnDo45GsQaaoBwjwENTDtCxjueuvrNYI?=
 =?us-ascii?Q?Pbes9WjWzqFiy5T9HPQa5ZCIuJHxVZsEmySZG22A/BCtAQpjZOWhMh1Sg9GP?=
 =?us-ascii?Q?kXxH0/0Uxm9blIu6Qxt8HhG98bx0OFVexGdCn/ZPVv1GZh1CBAfkxo68ki9Q?=
 =?us-ascii?Q?GzwsRUWzTgWv16v6Uz9P7Buy/dZNXwe1vYV8Ed/7YT0H4l5KC0Adf/QeHIBy?=
 =?us-ascii?Q?r0Wbdkt0KMKpJjS38CB51Xjrp0boXV9BRWlyDw4wJFb7BbNWSotEEV84Uabt?=
 =?us-ascii?Q?DBF3ejemMHD4dB8J6bPQDH5uG9VDGnuQ3aLBjz1sl4sL3HxBxRKHdbH1gheN?=
 =?us-ascii?Q?V9BItkSJdvNsulJh6WdZ9MkFf10p/4pQHpy2Jefr9J8cUzT6i1MbA1DjmfKr?=
 =?us-ascii?Q?dt3pNNCCrdqM8JRGJ8K9u24rhzR0xM/R4ERzoAgUWWNSExle+dXoiB5s2aCc?=
 =?us-ascii?Q?IOKFDYqN4zlqMKEWWscfXOTX0wApW0Ax52U5+VKY5FZBF+9i6iKjo1oNA+Er?=
 =?us-ascii?Q?06GSVts5m9dUM6t80LHk3h3h3hkaXVxCl2/FAfDQ5A4qrf0eMB/XFiI4PCHS?=
 =?us-ascii?Q?peo2SMRZWJyZbQRvnLGAfbxG6B4bQpYjlz8XlfQVlTa8XLWvuRxfOBrSoQBI?=
 =?us-ascii?Q?29V2j68KlUX6Wjdmi/ksnrbKmu+LKJKwtUVrz7BYB1bnYOFEn+tEHDcM7kvU?=
 =?us-ascii?Q?iZk7Z5Rests=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L5Jw2Po4d1ZH1gGChctooNBvkbGVgXj24FTpT51fAKDz1dcw7npeFuS28Llp?=
 =?us-ascii?Q?d3uiEXwaUvtLBLPnKVyck9/BuY3d3wOVEoDvIrQGZnzc5DmG6bIOLq/+KVky?=
 =?us-ascii?Q?6AnYyf41TS1nuJqALdVn/QOAHhg912KGiYtxMy9NEMvYLmSl4cSpCDvFavZ6?=
 =?us-ascii?Q?drBgekRDwwMyhfu+yoqEQPEpHd1zoVeq9GB08e+lRPHdf3lknn9MWgaX6QRb?=
 =?us-ascii?Q?SpRnIzrgmMgYiUv3BDuLjEYwYME8YuIMzpk/hPlBBB5gFr0s2LObPDwALalj?=
 =?us-ascii?Q?x890OeGsM1QblT9a25iWI6Z/LvgA/ZPBCdg+9GD5shqOC4SPJexeLsqzx8vK?=
 =?us-ascii?Q?CZ6NFPdwePQHEWRZ1gzMxX0NnEF3IrorGb9RCUnwLUwa49nzkS4Yd1zAiVBL?=
 =?us-ascii?Q?gzpaudQhhZjdqCSJwepc9Red2aT0yvNSQy4tzO49l9XqqCWIJAOL0fzFQuL6?=
 =?us-ascii?Q?O8COX8fiWUbZjy0lN4PeApYJX2LfbzFlYnu1iixQU1KStC8K5BC0sYKejjIS?=
 =?us-ascii?Q?z0tYBW0QLxgMTERQut36SFTwTKrTmTEGxmF01DsCazFq4NNQV/WjNbQBwbP8?=
 =?us-ascii?Q?5b1MgAto5j8cPO71IS/rB+HjUAvC95QYY+9tLwUj8FR4P+BFiQLyrhI+qgIE?=
 =?us-ascii?Q?oH59Pdd33K4A7GJrPNvfq6F8mWa8UDoLSYDnhqXoewNWbxTmdyWsGy7t/4Yg?=
 =?us-ascii?Q?jER0PMLrkhkkcFSGtLGZrXcxaU4ppZSKcmSunR/iSlGOBmSr34y5Q6W9egsr?=
 =?us-ascii?Q?JMHXCLj8IkblPMdCXAJ6b/6PlKOz9brVe8tUo5K75xfjgx6xOxOb9yv1AxtQ?=
 =?us-ascii?Q?7lja0NCe4S6B31a7tAZGKlzdrn06vAk5K1Odgghe5BvqMoujBi9a6hfFQBdI?=
 =?us-ascii?Q?+bIxzT3zQnt6iAn/sCHYMql8T01Gpba5EsN/aVKmnK/iQVRp136yFEtdRvmZ?=
 =?us-ascii?Q?DLAStQ9RdNelHWs4QqKlJOEFr5lWKlq2VhKNC2ex93qmdG/+GQjKtCbgD7Lm?=
 =?us-ascii?Q?FwWL1v+Zh9QsZ+yrLGmNFWh3qhgI+BbfzPQXDTjxvUkqmm5TKxS0CIx+t5x0?=
 =?us-ascii?Q?qOKXl9NsQHrKRWoWs/sL4iagYywwK4I7JrZpyqP5ii7u+cQaJMiFS1ZvhMje?=
 =?us-ascii?Q?qe4ukG/g0Yvh4r121ZXvsMFvN42HV8Ko34Kj4t3meeJnMFHaZot3lwhlaXvW?=
 =?us-ascii?Q?mHvB/3pSEgZA6n9zmTc+s/VNIt6MEKzPK2DULoNgoGFBOkeNvmoFw+nvIk8R?=
 =?us-ascii?Q?loA4qKBJYVFpJ8HxTcN9jom2aChbLWjb4zUq7ax80mnLeRWjdEVn2AUAYmAb?=
 =?us-ascii?Q?WT+jKZtUvwAxOwc6WJzXc0aVMEaDPUupfu2qYB45USGlrK+ih3RduJJ9C+U4?=
 =?us-ascii?Q?q1KSsWK7yJiscto6zkmZ13bV8FcrmqjsVwp9a2tHV0/FkJuYqsq7Qq6RteAh?=
 =?us-ascii?Q?P6bdjy04uKl8eKY02q32jHwpJAuRPFKzwIGEz0hmzBpW8SsMc8J2lJIXRoqV?=
 =?us-ascii?Q?4xvDvHG7aIQ6kZ+ipkaPQaz7cYfLGS6IUSLH34Y4pKS+JHECDA72WrXIEOoJ?=
 =?us-ascii?Q?rqcAyTnMxHiMRGmCa3upBvuk3MTX0XG34FLlCa3AHsdqiBen3eilKjLVzIY8?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85802ee8-7ead-46c9-2131-08ddca83fa11
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:30:34.5063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4qmqKa967dIdksIzOg9xAho912cp5y5qOTW5u33AedjfHFPDztvMSZlQl58CrWjlUXCdKmYmZ5ZCc4+YD3VXEngoxVr2ta6u3GFUH5opKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB2657

Add support to turn on/off CAN LEDs on device.
Turn off all CAN LEDs in probe, since they are default on after a reset or
power on.

Reviewed-by: Axel Forsman <axfo@kvaser.com>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 09510663988c..c8f530ef416e 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -66,6 +66,7 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_KCAN_FIFO_LAST_REG 0x180
 #define KVASER_PCIEFD_KCAN_CTRL_REG 0x2c0
 #define KVASER_PCIEFD_KCAN_CMD_REG 0x400
+#define KVASER_PCIEFD_KCAN_IOC_REG 0x404
 #define KVASER_PCIEFD_KCAN_IEN_REG 0x408
 #define KVASER_PCIEFD_KCAN_IRQ_REG 0x410
 #define KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG 0x414
@@ -136,6 +137,9 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 /* Request status packet */
 #define KVASER_PCIEFD_KCAN_CMD_SRQ BIT(0)
 
+/* Control CAN LED, active low */
+#define KVASER_PCIEFD_KCAN_IOC_LED BIT(0)
+
 /* Transmitter unaligned */
 #define KVASER_PCIEFD_KCAN_IRQ_TAL BIT(17)
 /* Tx FIFO empty */
@@ -410,6 +414,7 @@ struct kvaser_pciefd_can {
 	struct kvaser_pciefd *kv_pcie;
 	void __iomem *reg_base;
 	struct can_berr_counter bec;
+	u32 ioc;
 	u8 cmd_seq;
 	u8 tx_max_count;
 	u8 tx_idx;
@@ -528,6 +533,16 @@ static inline void kvaser_pciefd_abort_flush_reset(struct kvaser_pciefd_can *can
 	kvaser_pciefd_send_kcan_cmd(can, KVASER_PCIEFD_KCAN_CMD_AT);
 }
 
+static inline void kvaser_pciefd_set_led(struct kvaser_pciefd_can *can, bool on)
+{
+	if (on)
+		can->ioc &= ~KVASER_PCIEFD_KCAN_IOC_LED;
+	else
+		can->ioc |= KVASER_PCIEFD_KCAN_IOC_LED;
+
+	iowrite32(can->ioc, can->reg_base + KVASER_PCIEFD_KCAN_IOC_REG);
+}
+
 static void kvaser_pciefd_enable_err_gen(struct kvaser_pciefd_can *can)
 {
 	u32 mode;
@@ -990,6 +1005,9 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		/* Disable Bus load reporting */
 		iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_BUS_LOAD_REG);
 
+		can->ioc = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_IOC_REG);
+		kvaser_pciefd_set_led(can, false);
+
 		tx_nr_packets_max =
 			FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_MASK,
 				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
-- 
2.49.0


