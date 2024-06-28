Return-Path: <linux-can+bounces-878-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BD691C6F7
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3DA8B23A81
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 19:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42797711F;
	Fri, 28 Jun 2024 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="Dj5XZTJA"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2107.outbound.protection.outlook.com [40.107.104.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD44E78C66
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604562; cv=fail; b=gZM4K/OpeaZ29qr1FMi1dGBzsG8Wj7zqIpDFYVA78gEBKJRdTCrw3BqoTdzjo+dAZMueBhwaa9XqOsjR7QwSvceaDMCrjCSxcBbnuPRO/4EHu5p+g+16SRYUTyK9vN3OEF1TF2cCZtLMXNMzfrnFPva/DhVR3961QK6qvH9xEiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604562; c=relaxed/simple;
	bh=jiVkgLKusIml4HkrmGS926xeFOuYa09c5YQ4gGhqKdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cv9cRpt87hS7PULkoVJjXArb280k+tWtMnHSfMNhietbE5DKBiCdvsVf6BnS8fec3xS0HWKa7ZHDc1wTxgUqjwMpxDvF1OW9tu6GKPqCjLLOjIG+BSuHT0O+L78jjDEn4l3gUrhyoVLqbjb/xIl0zF/Imn/K4M4Lop3pPUmJ3Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=Dj5XZTJA; arc=fail smtp.client-ip=40.107.104.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAz9OHh9RnwAVjBsVV8QODbjPC9gIoeYnCLmxkeldKDcLC/NhWhDwogwFSvZzWucqwRAmm9s1efGY7/vXAAp9ZzMtIuWUi7Lgvvsrb+gmKZyUJ3YoR9EIYJEOSl1zq+z95IwRPlmBOmY2DvHUJnFcLL+lj8mCCz8QFt2ZEy8iRGXdXErV1KlgLUnEiPmfq3Y8Np4K+qei84Qu+c7G0n/95mwReEpqsMWFD173avavms/IPjvD722+3lAt7A8CkMDRh7aB4cfMp6r/Z3vHx6zw0GWcM7Y409b/WaKO+wp3Y0QFZkQ/wuUZNXxb0cPIeKbx2LYZcUigFLjHhRKfS1DGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlqYukJWf/umegKI1IR7ZA3RST3KoMLBrzmDa8CwRdM=;
 b=aJHDxAW+XGd+VlW077WPf707f+FuXXDwjiRYxgALN/Nk8T7+g3yulevz5fys8KM28MezB8W91mWNYp+hvVCW/2UK3qTgFS2Wdi8ij7h0fdXJa0EwcvFHP4wu4yyZwgBPQGjfshMsY1WoN0+IRFmp4knZzscK86gNrhSw3P5PesXxXavJ7w3S50RsJ1ChzPXn4zhX8u3DIqjaEKEeaEQYUa087JOra31v+80nbe36H5W7Ki2QX+9Q4kGrA1EUe5EJDGxmnU6K7uM8jcFAseRo7z2NtzdQ8G1p9XIgIeRo6hdKd4IOod8sMfpbDD4kl1UEH3SMqHGluYN1pFsdPcPW+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlqYukJWf/umegKI1IR7ZA3RST3KoMLBrzmDa8CwRdM=;
 b=Dj5XZTJAJDewAGXrRu1/jGhgpV3I6AL3Bx2Ew7dIaR7kpGD/3ZfxLwsyypsKKmkVxxDkLO3Ssmles4FtTn0f93XfWNbummeHUL/CmpnGG7SfvhsoXhw9s9aG2hpuxGc+JGbmxv29Pz7ebr391BJIf8c2R6T9nuQRiK44wwnjiPo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM9P193MB1142.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.38; Fri, 28 Jun
 2024 19:55:47 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 19:55:46 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next 11/15] can: kvaser_usb: leaf: Store MSB of timestamp
Date: Fri, 28 Jun 2024 21:55:10 +0200
Message-ID: <20240628195514.316895-12-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: fffea4a4-f5dc-44dd-d36f-08dc97ac4d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IpcC/1AQXfD7v+2Q9wcuQn61Pg3dZUZtT1lNv82xsra4JBKUAk4Yyf0jUfC/?=
 =?us-ascii?Q?vUc4VMzqA1AsTPVps6/193HmLSyZPz5XvU7euJHEm89dMifb7gZ1OEvAxJ+B?=
 =?us-ascii?Q?T2vDmNyok2m308HlwBd7+c1QJKKRwkBKNaKQ8Uu6BNHDXutHXH+m0CdDfm9O?=
 =?us-ascii?Q?YDeIg7g0L1A2QVTfirTzjL6AHhyd59WZWHTecHZfYhLtziNeGLQ1fCvwhuP5?=
 =?us-ascii?Q?WKhK3F3gu8HP3WiE4/HPTkt6u2TaocOp/lEehrSZBTeSwKoFPrIj0HS9bW+h?=
 =?us-ascii?Q?ZxQVvnwPZt4O3Sb7PC2km2+/L2LGVomc5LpvbxPh1fIwvP18RiPFbo+mElAr?=
 =?us-ascii?Q?W4r15ce7HnOOYEh/CatFRaoiNuhPhlWm1mLWGYHdlCJcLU1ZHvvODwV0TCT8?=
 =?us-ascii?Q?979KPcIAnBWNoyOOK11dsW4p2oJo6bIzDDyhUOs74D1IqfAHD0WepJh8VneL?=
 =?us-ascii?Q?Moqo4gH2Q2TLZeXb4kxcMwJMoZKTpTgZQA/ec8PnTU7IRxrVKJQr5qIa0wJ7?=
 =?us-ascii?Q?WH/smNXCps4DguVNOUNKDqKuUEghkEimn0ZVKYY5MRnNG5tYIFwWbWkicYgj?=
 =?us-ascii?Q?i6fYqB+UCe2baayZuCRrtaQ1ov+ie/ZQ4okxDcnQxaCSqcrCL2JfZN2hsW0X?=
 =?us-ascii?Q?gkN/IAeOcULQX3NcaIVSygCI+JMzkCLBslVC0xT4oDisPlqEJ9BNBddkJcsy?=
 =?us-ascii?Q?U0dihXO08BfOj7iHDN26AG6s6lQL7QbDNnyhwdHQKP5OLHDI/nHE48HFYHSn?=
 =?us-ascii?Q?+b3NMSSsiL/srmDUNQxye3Y0erK3c5OjWN7eZQMxQcxIdz6ppYA1GYpAfaRo?=
 =?us-ascii?Q?PKW4fUJ/+R2voAr/19PET+nqMPIgtYxXJuvwilUJv2kJwleMAlPmqhcCQVc4?=
 =?us-ascii?Q?d4ufsBVlZaJEOs6bcROlvhAxZj4be4W493T87wfSW7cLqnZgQJdUEe48Arsx?=
 =?us-ascii?Q?HpTF8qML6gbEyxQj1AVlIbwqiHyl6iKiG923PgCG5i0KBP8TAzrmVyAk4RUx?=
 =?us-ascii?Q?IbMZDLGHJZlbEnN266V+o2QQeJveji6vW3D+B3riR+3dNndCXJv2HasKH6NR?=
 =?us-ascii?Q?Qoitzj9fbBTTZ2swBNngbO3cFlZoiD6MxJ5GCiv9Vzzqqe8X5UhKuBNWz/3s?=
 =?us-ascii?Q?qEg9kSSzk0AEnc3SDk34lSu026kISQAnSwR0oM64ax8qYBsx2DUvxZa1WZr5?=
 =?us-ascii?Q?6424VksUNwOpPtHOlY9EnPNLVm4L8s7fcg7oN6pdgiU5kB1RJYFIjL6QQKgK?=
 =?us-ascii?Q?rWBohslA2y7+2TT1PkwONX7J2LurCHgwce0K05vdXl3dS7Uz9E5CN6DGCiw5?=
 =?us-ascii?Q?acHf3ovOmUKGMcKL0c5RH01RJ/Itg+Cy/TjkttnOJi5l7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UpOXMuhnt3E/szrV2w/ct33TBF+5BvrmoeXBm/JtAIB23nMIWVhrD5+qiNlI?=
 =?us-ascii?Q?ZyF6lq5SAcD0IOCrgneHTmGJPgY6Fx0CVZIGFVkt2blTJNF30UvtBKbXxzVO?=
 =?us-ascii?Q?va3+f1rs/tTKE5f/lIMbW3NtACc1MtFsMRi3bm8mPw7hXQ9NLpsv9igxHMr8?=
 =?us-ascii?Q?Ue7VOcUwJgCgn53seTBY9dXKHraEj5p+yuC8yt6IShJ6TkmvZFnqNfskY5xJ?=
 =?us-ascii?Q?v6HO9854RPVAGIJV90fozRi2qJMPUZ4k7tXWViM6rcH+cdGMV504TTExurJM?=
 =?us-ascii?Q?5m7SJOGjSLcGkhfBu7EAtzAbpXwJvp7iV6R/Tdu/mY77GW87uyntAxTEvddv?=
 =?us-ascii?Q?JQO0TtBacp5xShiiO+CzIuvVvHFx2Fll8Xj+/EJOxAEJIJHPNiCaI+CrlroV?=
 =?us-ascii?Q?7XI/2INNB5F8zFMaWxyTxo4isLnixEthgcWSmh0UU2xcaHZNnaOEAsnrO10F?=
 =?us-ascii?Q?WdYz6FEo9N2joVJyT4y3Q/5QIKF7GxErP5B9Pp1cMX2RYdAgU3aMOosNj1FL?=
 =?us-ascii?Q?hkxDeTecsIVOLPaoMcOEGMTSFu+WTrJXN0p5X5nuCUYc7j1aCl6dwbPGFsgy?=
 =?us-ascii?Q?0UUBVwukeeYtd8M5YsyAc8faaPBMZ/MpYy1jhr0cAM8FSUd++vb32TaNvu/t?=
 =?us-ascii?Q?wBDobkgcdkKs+/4Jz9VTCHT2dNNEOgMtU1U4U+jqcoEgC48RVsE+Qzlr6b/6?=
 =?us-ascii?Q?RQfgyFzYQmRR6+AJAWAqLIDx4cWLU6cRwgXgJCfOQIDTBuJYOO5FUp22AZQA?=
 =?us-ascii?Q?UWkZj8yspS5Y9J2ArvXugqm53nE6fBVrUw8PfmGiGy4hs9kzZd0/4uvbN0bb?=
 =?us-ascii?Q?1PdTQHvmekM7LJc6nEywl1iZ1cxZg4n+5V+oOkBC2CnJY+FTE9FaZA68cLUE?=
 =?us-ascii?Q?DiUFKZW7TMPBiPoE39xzanF5Wf6/yCnEkTqgNl/MMa0uOnRwQl3veFTRTw/w?=
 =?us-ascii?Q?Y6kzs2EvGQU4GbTT7V5iYbRutiC7dADGM46/8WXtmdz88cduV0lkLDerAiMD?=
 =?us-ascii?Q?NlP8ZASdhYh4Fsu7qyGV//Ub3mrXObiGbhMg7GqIQyG7EYw73vjA0rumnlTh?=
 =?us-ascii?Q?PeiMtR49bTPnsruMr1MWk08ugnwR0mneCDQ/23hK/zXoP1Du/GPIlM0ynCR4?=
 =?us-ascii?Q?LnwFTTlYv766cDLnyepuNh7+C44jjwqIk6/Isc/+ZYNZs50Jy7Hfu29yt6kQ?=
 =?us-ascii?Q?YbKZ8xo0Wg31Ry0twbK/hZvKVOcWm49Y/vFSZe6MXDUWjJMsLDWN0vXHp1FB?=
 =?us-ascii?Q?egra/UL3HEf3k9Cstzvl+L4PxPTuaQlPQxEsLOyufIqw9YBlj4SM4NCu9vZS?=
 =?us-ascii?Q?/uGLb8TMTwHUdW7IcMPMoWSuJmZwmQzOiOfkLeIeh1HDdbImhs8Qj9/S9x3W?=
 =?us-ascii?Q?SIwi6bKfnxlhuCq98FBHFE7Mte7cjxqsmngP2YCHcTVDwkwvZrkvNsU5SgiD?=
 =?us-ascii?Q?FiaMJmAFjZ3JRKJy4okT86yWpXZlT8VXBWhFlsI+VO3c0b3E5pxZw38Qu4I2?=
 =?us-ascii?Q?0/2Ci1LjOAozJuSDiiC5KaGEjT4AONFYccX4bMircT897jQXBCXw2hJdItrm?=
 =?us-ascii?Q?GnOvddJGw5Vnz1NcxR1uoYgKFrZ/+6Mvv/0jx2Ie?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffea4a4-f5dc-44dd-d36f-08dc97ac4d65
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:55:46.9221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOz907C6gxhdo2/BcK7IrMuWjuMcb/VNIcYrDVRpzNPnr/e2S2h+2YVtKSjjx0MEd9nP5BF0sXwbCvs43idHOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1142

Store MSB of timestamp, provided from the device via the clock overflow
event, for usbcan devices (M16C).

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h      | 1 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index f5868e0b3b23..5552140c0869 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -70,6 +70,7 @@ struct kvaser_usb_dev_card_data {
 	u32 ctrlmode_supported;
 	u32 capabilities;
 	struct kvaser_usb_dev_card_data_hydra hydra;
+	u32 usbcan_timestamp_msb;
 };
 
 /* Context for an outstanding, not yet ACKed, transmission */
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 98bd6cfca2ca..9b75f240485d 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -119,6 +119,9 @@
 /* Extended CAN identifier flag */
 #define KVASER_EXTENDED_FRAME		BIT(31)
 
+/* USBCanII timestamp */
+#define KVASER_USB_USBCAN_CLK_OVERFLOW_MASK GENMASK(31, 16)
+
 struct kvaser_cmd_simple {
 	u8 tid;
 	u8 channel;
@@ -1576,7 +1579,7 @@ static void kvaser_usb_leaf_get_busparams_reply(const struct kvaser_usb *dev,
 	complete(&priv->get_busparams_comp);
 }
 
-static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
+static void kvaser_usb_leaf_handle_command(struct kvaser_usb *dev,
 					   const struct kvaser_cmd *cmd)
 {
 	if (kvaser_usb_leaf_verify_size(dev, cmd) < 0)
@@ -1625,6 +1628,9 @@ static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
 	case CMD_USBCAN_CLOCK_OVERFLOW_EVENT:
 		if (dev->driver_info->family != KVASER_USBCAN)
 			goto warn;
+		dev->card_data.usbcan_timestamp_msb =
+					le32_to_cpu(cmd->u.usbcan.clk_overflow_event.time) &
+					KVASER_USB_USBCAN_CLK_OVERFLOW_MASK;
 		break;
 
 	/* Ignored commands */
-- 
2.45.2


