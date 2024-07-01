Return-Path: <linux-can+bounces-931-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6AC91E49F
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 17:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984A41F222E2
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D008116D327;
	Mon,  1 Jul 2024 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="c6g0hwwA"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2125.outbound.protection.outlook.com [40.107.20.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA22716D4CD
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849016; cv=fail; b=ODtALjycQcTfL0QKA0/2AQJh3+5Smg7MCarrA3gIvHhFfCtqzU7K05SX8U8jPsI29pnQgiHVRaVoaJu+oe8BhM58oGrWIpM4r/0105Usp1XdzRQBThT8iUib0y7ZHytIfl7kyf773/sIiyXfQ83DYEt6Swi8UKEKJprzJv46QVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849016; c=relaxed/simple;
	bh=wJ3in0u4TvR1eOySTvPsTp0TTBciLEAGL9kp7MoIYRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AOKmUO4yFN6qA4UQFCJzFJis6MZpAlq98QKdvxGNeTMjF8hOXGuTr7DZZQIMMFIYL7+IPgjqt8OMZCl+AaZwlIlaXBZdydHVRoOLyJsyceZ3QNiydGLmmEPivybI60HaS0hMrVWVTQFaaBMOXxVqQH2Ipd3XnTljRWn3SJbYQco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=c6g0hwwA; arc=fail smtp.client-ip=40.107.20.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBUFZhrXH9hw+FWSB3KimWfeY+n2xaVSbPiQfbhIhgZOzuQvTPOQi31qE4RmS5XYEK5vrUrrXsHapH9vh4oi24OWgoGfL5LJssGwQcAOh7IRgdBZ5daG4x0CniK2U35CmOIFTJoHR+Fi2f2lRSpK61TK3Vsh1HwLc7sGOkjV8omnmgfgLvnZmEWecCz7cw3m8GN/R4VonFfRYG1Yemd16fbitl7VDOgBI3FBXlJcAvmumYcHmxpvFx5xiVgYSP37x2o2hV3FEneuR7OUbxCCeI7ykuImrCTp/BfTL7P1iKKA3ORNvej90QAg4uxX/CY832wyB1FMeoYtXr/cpYaJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bmU7suraRi1jkdpSm3V5HGJBeSWLUKdiI2+J3+Qjsw=;
 b=j56zLGTZiE2RSCZEHUO0KBlzrchl528u4Ra7ifP+fjwLjO9vn3m5hyIbyr2fYpI3wBn0XN1gZ9DyWLozKRx7wpmKPMG9vgzQlbtwPlGWLdf3DdbmTxq9DHdWzOPQCdn58lq4YvRhq/5wRiBkjmrmM8ndB2hUWRLemdlAtuqObHXuHlD6cQ0KKVPo5CGEadyEDcRZ4dWXyDWMYtOezUkHh45nmtBbY8PRtxyNNCUklqH8BmflPB9y4KHZ2obcvF5um0VqTXzAIQLHKHGrhhtLF4Oi/aWbll9TGGRGA7HC7loqgicv89Zi54EbriIXKcl9Qd02BmQwtytDjXmLtXAC0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bmU7suraRi1jkdpSm3V5HGJBeSWLUKdiI2+J3+Qjsw=;
 b=c6g0hwwAFqjPJtMJC5WODewvPq0KGwRMBxUrB/8mZlvMnz5TikaYzU0amfzpj8a2wavNM0XBCU/JR2lPFH9vrZXrijiFOOlsPiFaPafh5YYx+32q9JbGqcZzXPQhi2JGtScT84z+edofF8E+YN3bU7Zu1z2rVzA6h98q/JjbZA4=
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
Subject: [PATCH can-next v2 11/15] can: kvaser_usb: leaf: Store MSB of timestamp
Date: Mon,  1 Jul 2024 17:49:32 +0200
Message-ID: <20240701154936.92633-12-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: fc5e0122-270c-4509-ef86-08dc99e57976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kf814k0Mm+wLp1aVC063h9wMKTRK6Qku83ENr+eSCs4XKvR2sk5zVeJk0wdT?=
 =?us-ascii?Q?AbTZYVqjoMwqZd23t8T4fLAcEtlxVAHthv4FdhrnkQu0nPqtiexG87BbVH4E?=
 =?us-ascii?Q?1TGP5KzAJ+ewkvQ04t2GAHjJqmieZTkJYSbtqUNOkUOO/sduROkyguL0CmkQ?=
 =?us-ascii?Q?Ee+LTv0GqiMkMgt+0QWh8uj7JChgl94+9eznNAPXlPDeaTXltKCbwAsTKmDR?=
 =?us-ascii?Q?xnEYyqC4Wf+cwnAYZfLdQQ8krwy4yE+sHW96fwD4gsFjlCK/yBbXmxGVjEH7?=
 =?us-ascii?Q?oD7lc/LHf0ULZJNqzQpJuRNhmvEbrpcCWdsPc7lv8Q7JChgavtut98rY8miv?=
 =?us-ascii?Q?7T+HZm/O0SN0DQmPD9pkCzUe491nkTD/QiDmzjjlpBnmsX8DA2czPbI3JUbd?=
 =?us-ascii?Q?dinbLL+8XVJgXnE/hShZidl+tZg9WqonAI9xMZL5ibEiot0aTc/42JQeL/Ti?=
 =?us-ascii?Q?BUvwSwA/GdHw6Ai9bRY5yifrTkBXZxw6pyf+7N4+X5DAY0nHmcQzGpz6nXZw?=
 =?us-ascii?Q?wY+W3yV3ptkTyrlOSGu61166qdTnicoaeWRG/6j1hcL5ZStb5yYV22qfKS+P?=
 =?us-ascii?Q?bJVzEcvNLgYqa45p0EenQY6inpwJ5kT3zQl3vbyBYSNy9Zlo0wUqZ7ZKG9co?=
 =?us-ascii?Q?PKjONtRDVS01Gds5LCrss1eGiKeYaYc98fUf3xQ5FVeLMcwMFyraXnfQOcEv?=
 =?us-ascii?Q?CJH76ayM+sYEBqYFNnZii8dRojusuUon1d9A5bG3gch99RTi70bTE3//dcRe?=
 =?us-ascii?Q?QN6ifckJ8YS2JX2STkQ7AYjs5EPRibQg5eI9hyhefogyuEg/bVcnrpnRUwCQ?=
 =?us-ascii?Q?+OtCqOnavWCjsY6HksBFMmVdD4x4ERdvhZE0GyjUfDVVF2NdlDlq9FwhuAri?=
 =?us-ascii?Q?/PlPPnmctc8htARfVAE/KkIPN+cX9kXrSEgrA1yfMX4TRejHMPFwpZLlDkl5?=
 =?us-ascii?Q?LYz/NRzOeA+V9RpRQ3yvP82OipfZlo7nb/yoJGkbE1BLhnNcn/4aBpUliUBO?=
 =?us-ascii?Q?0ThaqnbLhT1rmTQ/CIVpJfEhEPQP+bzdUao30qCUhgBfCgsgOhBmrMksMuiY?=
 =?us-ascii?Q?10xXHYTCwxodQkXqepnTxikCPOHvIcbEvhs56/sjEdIYmRCOuXLmbWtlAPsj?=
 =?us-ascii?Q?M7GjifrqaCIQ+/s4NQiQWBeaSGf/Eigjiqafr7msfhdc+C5BIpH/haXpr80f?=
 =?us-ascii?Q?kjWaWQ/fjiARmhV+YG+RLuVpA9Yx55sVHiwPryVX13GutcDYl498fBY4kySX?=
 =?us-ascii?Q?L/JHQ9evQGfznk6ksAMEm6ELedb0eLNzRVPsPA+RqnNP8MtfMx+j4gJy5mdq?=
 =?us-ascii?Q?GSuuYEU8fYGIZj9rw0LJaPQkog3VGtJtg6GTDrhTxOTLBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ranOylERFpwThu/UcYDV6xt0HxXzro/whUdXnFfi6opurhrTZh41L2D0tG8Z?=
 =?us-ascii?Q?Z8ZOJmji7eP75vNDVcnbt5Swl5a4SQsYctFMuP9WKalUxEtN1sRNhXhgO7CF?=
 =?us-ascii?Q?YsG7TD/IgrOLrR6XsFTf/8SaIkG1aUSKYN05i6tYhr4mwu4g2s906fUbKfxt?=
 =?us-ascii?Q?wj6bIXuVwg1iqowrpqE6LK2HqWp1GlX8Gq/Gjps2WaPni8D5JCc5kJET4elS?=
 =?us-ascii?Q?RdtBv4rctmrXNV6fljaR+LE9keF7WuKlpFjkVlrulTWRl+svvTahOgxrTR03?=
 =?us-ascii?Q?C94O7fbh3HN/QSj4paF5bC0HvX5jFCX9Mi+SPaeOmWFjyMnxMOl/0JdI4QH1?=
 =?us-ascii?Q?ZzrcnST5mIvDEILajQQztpAWiCp8CGijcMZ0aqUJb7fFtI/0Shl0+eyJwrIH?=
 =?us-ascii?Q?fbXNjJ80V7shYbWNQTc1ctrjTej4vCP75Y79tA/nysq6dntDW4oaeMRLXcPe?=
 =?us-ascii?Q?9zV9NVBZ05L+G2yl/iXjRw4hq3ig75Bpomz0CZsDdh7hXQF2EzoB+24Wejw4?=
 =?us-ascii?Q?bZlYKvegjFHYq4yGLcjutlAhVNPQ/jST8mKb6kbUHoSHGaWFxFdHj6VHsR/9?=
 =?us-ascii?Q?L28JEq/zNjQ/KVY666ec/B4fjgH6DCqIhFK1/8ydmVJ6As2lqZuNtdIneVhI?=
 =?us-ascii?Q?lO3CzXbsNUpIdM4zFYQscfkkIuxGX2dAe6+v5U5xUmilpVogwKEUCL+XsS1d?=
 =?us-ascii?Q?s385nq0TJCKqX5EL4Fy25duISI7ab1l9WPReCeYbIr4+CktkUwpQskz+ljMa?=
 =?us-ascii?Q?WvdEbDriPNgXtTAj99rCZfJhgOKLTwwyUQ/YKCYrRsw/xTiXZhlX2BX6eu8h?=
 =?us-ascii?Q?HrWQ8QPptdBWmdaeHlxJCgxL8Yu7mZF24gG8V6LCxaUtoKjXVjRZJ6z2UBkt?=
 =?us-ascii?Q?C5lh0On/LItMn5Bm2mKecUK54rslxnkDt0lTBpNftwFbPlsvrLOjI5AdfMEf?=
 =?us-ascii?Q?TThDs5cNdTrMxSv6Lk11McxLS9sp0mUYrR3Qj5J1lYlgaT6Kx4j8nqHWvDKM?=
 =?us-ascii?Q?qoGTFwRBTfXSNeADZmLe3OLe+3jUPeeEDHsxWuGJ+eNd59oC1YQa2z/Ky+vy?=
 =?us-ascii?Q?CAluz+m7RbciDSINkq0docQI6j5Ih7DPuxTaYQPcv2BkpGTjZnuYJP2GJc1m?=
 =?us-ascii?Q?RJhz4gAPSv4+932cb+nAam9mREG4Kh/SUf56pWlc4XIDwsQHMk0BKtjVuE5k?=
 =?us-ascii?Q?wpucqIGLk1qXPCb4AEgnIluJZH4QinZpBTXTj/Cw8U3dY+z6R4TeGpGTBjYr?=
 =?us-ascii?Q?YP2j6Ozre5CWm0GU7o0hU7D3mq/Bacu6KMa6vOBzKGBD7M0s+foNVQadWL4q?=
 =?us-ascii?Q?Wi3cxHcRzVy7CaJ/3sy0GUbIy+MkkZr7V5bKdoblAgCPBVETn1HLd+tbOghm?=
 =?us-ascii?Q?+bBtdDvSqPgn6pf0wJWBK+WDXqLjAkUMPAIQYV0CI8X3Yg64dsZOMmR9rRZM?=
 =?us-ascii?Q?z0U462Fe62cNgJwGEZrR8Lwuz2Pd2e8tS/MAmIISZdYXA2hzQcsMv2mCbOpm?=
 =?us-ascii?Q?kl6Ye7r9w7bdMiOIZUVmUzkyAcNIaXZpLOS21BUrnFPnzVegBPLB1CJlwAkI?=
 =?us-ascii?Q?rnIcdyVRRNBavnXgnTVe5XTrf1YTHegkoW49pCFF?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5e0122-270c-4509-ef86-08dc99e57976
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:50:04.5620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ofkzS5zUTKfxdyC8QdgsjXNrqC3YkR5evw2Sr07KNvaY1BLGxcP/iIxVNpxPCWYzmoWm4qm2vyaoFdzUaJTOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0519

Store MSB of timestamp, provided from the device via the clock overflow
event, for usbcan devices (M16C).

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - Remove the "ignored events/commands" comments, since here we
    handle the clock overflow command

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h      |  1 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 4256a0caae20..591f707d2895 100644
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
index 2c0313c8f63e..465707174f2e 100644
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
@@ -418,7 +421,6 @@ static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
 	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.usbcan.chip_state_event),
 	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.usbcan.can_error_event),
 	[CMD_ERROR_EVENT]		= kvaser_fsize(u.usbcan.error_event),
-	/* ignored events: */
 	[CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = kvaser_fsize(u.usbcan.clk_overflow_event),
 };
 
@@ -1573,7 +1575,7 @@ static void kvaser_usb_leaf_get_busparams_reply(const struct kvaser_usb *dev,
 	complete(&priv->get_busparams_comp);
 }
 
-static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
+static void kvaser_usb_leaf_handle_command(struct kvaser_usb *dev,
 					   const struct kvaser_cmd *cmd)
 {
 	if (kvaser_usb_leaf_verify_size(dev, cmd) < 0)
@@ -1619,12 +1621,15 @@ static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
 		kvaser_usb_leaf_get_busparams_reply(dev, cmd);
 		break;
 
-	/* Ignored commands */
 	case CMD_USBCAN_CLOCK_OVERFLOW_EVENT:
 		if (dev->driver_info->family != KVASER_USBCAN)
 			goto warn;
+		dev->card_data.usbcan_timestamp_msb =
+					le32_to_cpu(cmd->u.usbcan.clk_overflow_event.time) &
+					KVASER_USB_USBCAN_CLK_OVERFLOW_MASK;
 		break;
 
+	/* Ignored commands */
 	case CMD_FLUSH_QUEUE_REPLY:
 		if (dev->driver_info->family != KVASER_LEAF)
 			goto warn;
-- 
2.45.2


