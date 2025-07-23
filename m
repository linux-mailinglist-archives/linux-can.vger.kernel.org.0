Return-Path: <linux-can+bounces-4045-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EE3B0ED57
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F60188B826
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6555B2192EE;
	Wed, 23 Jul 2025 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="BAV57sho"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2106.outbound.protection.outlook.com [40.107.103.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBDA2E3713
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259737; cv=fail; b=n86KIeK+uTepCXSnunxYVb4u4LQ0aUtyAZniehWmDy6WJnw9DeyqWHJgEWglB2v11F5bDZqFc8/vzwon2kXc1M3cHhf9Z72x5nms0BRcxqwTlQXYFsVewumuahgIuon83S15upRKf0GGszd3uCGSATrNW2wEjAtvVXDxusTuREw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259737; c=relaxed/simple;
	bh=VgKk04WnTM6JwMbpF5z3ttBTiQ7vTkPr8aR/3QZ2qA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BQlc8RFVOUaPKpK2LAnR9xqH2OywH47c4yx5/SDXcZUwT9GKRZwdWNGrZJtbGuypLxW+m62qxNUpKrqvc24Yk6KiWFgR/mKoQDaQ/DrR2SzCSI9QjOif9+e459vAJ9T3yY54+oygc4LLZb/aR5xyiUzmiI3tA1wg3/HW6r/Xtt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=BAV57sho; arc=fail smtp.client-ip=40.107.103.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFOHKLcAn0YA+MfVvVZSy7sbFrrToc0/8fDVWMrTb6Rkt7jsOKtNQSANd2QiUAnjgGQNis/2wDSIED2kWuPhibpNQnmtNgma9ZDUajhoCHFn5Ydowa/FIKpPZccypxM+9MrEyaM+fXm2mTG16ru2Mpgm3lirIas34MD0G3UJKLqhLrEOa3EZb/Jo7/Ik8CtKJi34t5i9Jg59KUmtFXEYfEHYtiaJnmsaoxQppKdsnECZf0uNH3BT0qnZ9r1LvX9//9hg77yNnWIEX2fI9wPfm1L29FXhq4Z3ZIWP+KA5W0wkIbtmRIVrbd15vVTy6wCKKI7wab7C72fDuJbOj6adHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFH4lAA0tG45yn9BLN8Ygxv0k173+5pVbcY/h+KoAcs=;
 b=mrt2N57M+RxwLE0NjbixpvvBNLqHMNm+v2QOOBYaMBpRm7FXLV6kkVgtBw4LZb+2wePEoxBSc9mgibugXb9iibDQimjdo/MVAPl62cXvT0/VMBEB8f2B7XCQrqv3cQGNb5UjOI/G6zHzwdlsm2GTL1Y45TnpxGMi7nMMnz4k7nDNqu4RnNpQ3clS5UhfOrZ6X/xkF01Y74VQfHwCcfb5ERZ8spJHnncxpgMqo0sWKn0tnCTwI4+WqMQlFB+Z8KHXNwPEDiOHyWKFubJEEpUYnbLkRCYMEn/d6SdtoSMlhgdbMuzEyW624Fl23qKiXWKmBkSIJy8C7v+v4s4wfGl4IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFH4lAA0tG45yn9BLN8Ygxv0k173+5pVbcY/h+KoAcs=;
 b=BAV57shoeP/9RoQvBXiEEZIhVNVBW9en8lTvtBd1D1SB5kJSDYN0mCm0NeOOYDBH4XkoXwKBLCUc70WWUfxiDW3PS3dw9J4ifYKScXqZrdxeWx3CL/GvN4/XTVoIU7YlG6rOXB61onZ2IH8/1ooXM21h1Fm3ZRRnke3j6OiIP2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DU2P193MB2018.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:35:30 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:35:30 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 1/9] can: kvaser_usb: Add support to control CAN LEDs on device
Date: Wed, 23 Jul 2025 10:35:00 +0200
Message-ID: <20250723083508.40-2-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723083508.40-1-extja@kvaser.com>
References: <20250723083508.40-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0064.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::26) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DU2P193MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: b9409f37-e334-4f16-abad-08ddc9c3e217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O/zm6lDeZBxpC9or4BuvpiRXWa8YawdGZMwlsiz5WZBTS6wUeZrBTZgWZHZb?=
 =?us-ascii?Q?k86iN8I7R8IjvqRZT5l5YgguxFUujmdG87zjFDvA6YqEH03oyYACpQKNtuyT?=
 =?us-ascii?Q?M/tAjzFrLyWktEKbTA3655mA7m+C6hSknzU6aFZ9adeoHdYCKADkotiJS2qZ?=
 =?us-ascii?Q?b+RRyvseF8f52qY4xsTfk/644Tx7RuX/nQrNCJkWa7VhUkvBuTop54z18vwm?=
 =?us-ascii?Q?ECmYAtTCx0dvRPpCcemTwRWeZAKxlfBo3/9rxVZmiNF/+mkY4tGbVjHnJXdk?=
 =?us-ascii?Q?Mm8CeDM1LuVMNYX4pSiYrCFZG8L77WiN087NPhZuw+nPFof7taitJGeFhgKo?=
 =?us-ascii?Q?l5sQW3qARN1KXyj+2mUpA0Rw2dTx0feVLtByw3Nmi0WDtw9RCZPwAfr8BXV9?=
 =?us-ascii?Q?Gg9Itg6NpGxkSOZTZ5qjHt4yh6jmNhh3/EAGkOXWDlnYdc4CbQ6GVuHs1AY2?=
 =?us-ascii?Q?ZGMs4qOi+96feKmuaxi49shoUnKenhEx2FRpAkdZV9+PEEzw45tiGmrGYY/i?=
 =?us-ascii?Q?RH9ZDNgwfG1Z3y4JuVddmpj6HPRvzX1HmKwNJlLevlkHNXLPct17Ik968dfM?=
 =?us-ascii?Q?WKW0BBiU04J0u9Ijz2gZpVjqRbfcNzSEL34rgYPaQ9sVmOo2GP997Hw15JEb?=
 =?us-ascii?Q?8Lx3DRMZR7FLn6sJFfpazElZBKwppYs5qqHVNfH4Xsjdg9OMdao2ATXmTuSL?=
 =?us-ascii?Q?zB8Ei8bTw0EP+htxdrb0mgiC9ZTbpbMnc56jrROxS36H6uwzxAfwDfd+3hJu?=
 =?us-ascii?Q?mBXzox4H4WV434EXyLtDt3YKsGGO796OOFh/TEmpmUMy5J+DL6zfu9BTZJD0?=
 =?us-ascii?Q?lMCIr4AFTOlBHt+8gOJ1lbaa4Mp+gGzYL/G12geO7Ybnzr4zTy4UqGkAYvBy?=
 =?us-ascii?Q?h1DCXgeW59YpS95DX53aZk4CuxD/Q47eJkxihQU5cWWhboCwTx2PBnzTRAqc?=
 =?us-ascii?Q?roOvHRv4pMBoMUTT8JB7afilgcagSJTW8FrLOwHxTIftqhDmcZq5NZbvGuOS?=
 =?us-ascii?Q?Ak+HbjOaglja52F/Z1LeARmsynrzd6ou1OiH8f6kmmJ7EyQ84FAO2RhERpec?=
 =?us-ascii?Q?AvCufNLBRNFTiZzXdrh7m1o7Ynn6CeYnnVIy/9PQPeDbAgcL52IUuUW99kgk?=
 =?us-ascii?Q?Vslj3sc1r9wB9Po1+fetYj1VUTZ0SzlvsnAAicmHc0l600rBJvfY0xfIaNgi?=
 =?us-ascii?Q?8+rnCN9EVwcA5yY0v/xgHfKrx7IoYPNqW5ij9QwvHiWr3JEOTnflvdb216l4?=
 =?us-ascii?Q?Rk+TLayfAFcv8e6MzMuzJgAYvqeZt2Eyz7V1u75iW2+P9QQq0pF4LqFdOx5w?=
 =?us-ascii?Q?enPHhNjLbaB5Rf8x1i829nAI4/GtXSzTyy2YBfZkKmghlQgNejevK9j2rhwE?=
 =?us-ascii?Q?86A5hvPUbZl5PqsPWp1GDcjqAF8cawsXVZmgb3pmLiWQDL7Tz5LR7I7Ns3+N?=
 =?us-ascii?Q?HOPcifrDfNc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UGpGP8Gt3Ot/fMFACk72rCcWPRjpgUGRbYi16OksMbHxwAAIt1+gIACLwCfg?=
 =?us-ascii?Q?5MwD8IhDJR//K65bDgLXgM0VsW+nSHx55o/ux8VSGotXHyRx2/IetwQmFkR5?=
 =?us-ascii?Q?XlloEv4Zj19V8OcYdBe+0myvmRAuvO4wYyxybVdw7CaAX1aRY8W3Zz4MUNr6?=
 =?us-ascii?Q?m/e+meG7EI7S6slPYgMZVI7w5psinj1HDQ3RNP2UooFDI6prw3pzqVVG4lmx?=
 =?us-ascii?Q?xljtnwr6ntVfTv5ZeYtEHjAO/PW0NK0wpd5585u6QZtn9JxcPCglZe759Ujj?=
 =?us-ascii?Q?r3nJ1FqmQo2pSxfFLAZOLK4y02J9WycaWFRIwR0YFzeO8bmqGbLcDa0N+Vwq?=
 =?us-ascii?Q?8Ishz0hOAEixuu6N+HUBoeLSRFomPbpuRoFIrSjLKlICnDNytSjZgb5T1uHo?=
 =?us-ascii?Q?Luy3djwwIhojkrfL5VHTglIl2bGuK+sjl4tRLH2XA87/fmGPNN7T0XgQkzrx?=
 =?us-ascii?Q?vUc8Vq0QgTu9l4bUdyKsrtgHZo5b0dMqU876WCyiFeHCSj1fkYOqMTvbwASF?=
 =?us-ascii?Q?QvdPuc99VQHtzJUUmDkGPVqWRI6i2J89EN2W3qgwlmOujm6go7p90Xk+CQrx?=
 =?us-ascii?Q?VCrevFS84Kp5Ztx7iBHMR8UVYAJjwyBrAiWzau7ogG/7gG/mHFiGX8Bt8VRv?=
 =?us-ascii?Q?CYgRSPczB+5TIhFCnvTHZU08YsGz1e1scqMjkSP0OHjY8pFu83FArN62GbkS?=
 =?us-ascii?Q?3pFobQ1a1MhB0GwvUXbozgah7UAbC3/wX9Kui6GgIokyeWDlti5PwDG5F7MN?=
 =?us-ascii?Q?2oBpOtKI7PCIPWK+Sfo8z9YnR8z74Jqcy66d4+qnJXZ9DvWDkpNqRPulqWLF?=
 =?us-ascii?Q?vmfBVbQqT2vATebsCEUEAXEsPvg/zyosxXGza04oVPNWQTrV5mKtS+ZHuxfU?=
 =?us-ascii?Q?0mDd2PeB412KFOE1hBPPdad/8UKfegna8Wo8FSK/TnjDsa1IUg08PHzdPEBN?=
 =?us-ascii?Q?O+gUsJVk3uJho1Ee0Pj6iPmzvK/lJH//raGaYdJiBzutwZZIUKJV1JuSD7qL?=
 =?us-ascii?Q?Guu6phmtfFfiUkZxAHK8yVCOHg9KaekQoOFjDfUE8rjUs0ED6KA110DRXDAh?=
 =?us-ascii?Q?QKzXPETNdJSl5E0liwO6CD6o2iLoG1hXfnleDKM7oVu8h8hjGOMDIhPCii3r?=
 =?us-ascii?Q?gcwAHknwhWz2bMkWbIGtoAE+FjtRB5U3OvMIybO2G/y8zR253DmBEOTZ0gPp?=
 =?us-ascii?Q?LMrTlJj0UESRqVeG7HeCC8O9C92uYf4LAtltd4+FC5/vdocDU0L9kDUlWjRt?=
 =?us-ascii?Q?nWko93Jk8xfrOmJzIBzIq2ZydqUs+l3uo7nAuitGHFpMTX9aYS28HGZF8Myh?=
 =?us-ascii?Q?4CWeKMpBNJJICb9hH7N0Bvdg4RpDBGYeHUy0UHB+S15SXbnr9xQkhS/4aOEx?=
 =?us-ascii?Q?fvIdSpWMaKwrEx9tT9KE6fxeVrGgKke9FDTWdaX5iWH/TniA8XbraoCdVj3l?=
 =?us-ascii?Q?SdptI86CD8JIjq06nKx5FlLzyhLOnpJPOgVT0B9u9kzVtzb8oS43bzkfIMYd?=
 =?us-ascii?Q?qbRcebFKfJTJXTy+dcjCgK5v3jWyrwaoqKpLMarKa3gS41Qg24houdi2zPWG?=
 =?us-ascii?Q?SRb09ruvb/M9YL9n9iDf8PwiR5wESHXN302uAQfrVrZsZb59/Ob3DBSKBWgx?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9409f37-e334-4f16-abad-08ddc9c3e217
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:35:30.7084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zig44dagRV2x4664s0lckGLbcpPpVVZZjZ4A/f4QLN4h0XHhqcl5HPo+QcgKYCeXdLWzi2RgRrqqsXjAJAuon3uVKHBk3p/kaTiYpbQrfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2018

Add support to turn on/off CAN LEDs on device.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  9 ++++
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 51 ++++++++++++++++++
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 54 +++++++++++++++++++
 3 files changed, 114 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index f6c77eca9f43..032dc1821f04 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -54,6 +54,11 @@ enum kvaser_usb_leaf_family {
 	KVASER_USBCAN,
 };
 
+enum kvaser_usb_led_state {
+	KVASER_USB_LED_ON = 0,
+	KVASER_USB_LED_OFF = 1,
+};
+
 #define KVASER_USB_HYDRA_MAX_CMD_LEN		128
 struct kvaser_usb_dev_card_data_hydra {
 	u8 channel_to_he[KVASER_USB_MAX_NET_DEVICES];
@@ -149,6 +154,7 @@ struct kvaser_usb_net_priv {
  * @dev_get_software_details:	get software details
  * @dev_get_card_info:		get card info
  * @dev_get_capabilities:	discover device capabilities
+ * @dev_set_led:		turn on/off device LED
  *
  * @dev_set_opt_mode:		set ctrlmod
  * @dev_start_chip:		start the CAN controller
@@ -176,6 +182,9 @@ struct kvaser_usb_dev_ops {
 	int (*dev_get_software_details)(struct kvaser_usb *dev);
 	int (*dev_get_card_info)(struct kvaser_usb *dev);
 	int (*dev_get_capabilities)(struct kvaser_usb *dev);
+	int (*dev_set_led)(struct kvaser_usb_net_priv *priv,
+			   enum kvaser_usb_led_state state,
+			   u16 duration_ms);
 	int (*dev_set_opt_mode)(const struct kvaser_usb_net_priv *priv);
 	int (*dev_start_chip)(struct kvaser_usb_net_priv *priv);
 	int (*dev_stop_chip)(struct kvaser_usb_net_priv *priv);
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 8e88b5917796..758fd13f1bf4 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -12,6 +12,7 @@
  *    distinguish between ERROR_WARNING and ERROR_ACTIVE.
  */
 
+#include <linux/bitfield.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/gfp.h>
@@ -67,6 +68,8 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_rt;
 #define CMD_SET_BUSPARAMS_RESP			85
 #define CMD_GET_CAPABILITIES_REQ		95
 #define CMD_GET_CAPABILITIES_RESP		96
+#define CMD_LED_ACTION_REQ			101
+#define CMD_LED_ACTION_RESP			102
 #define CMD_RX_MESSAGE				106
 #define CMD_MAP_CHANNEL_REQ			200
 #define CMD_MAP_CHANNEL_RESP			201
@@ -217,6 +220,22 @@ struct kvaser_cmd_get_busparams_res {
 	u8 reserved[20];
 } __packed;
 
+/* The device has two LEDs per CAN channel
+ * The LSB of action field controls the state:
+ *   0 = ON
+ *   1 = OFF
+ * The remaining bits of action field is the LED index
+ */
+#define KVASER_USB_HYDRA_LED_IDX_MASK GENMASK(31, 1)
+#define KVASER_USB_HYDRA_LED_YELLOW_CH0_IDX 3
+#define KVASER_USB_HYDRA_LEDS_PER_CHANNEL 2
+struct kvaser_cmd_led_action_req {
+	u8 action;
+	u8 padding;
+	__le16 duration_ms;
+	u8 reserved[24];
+} __packed;
+
 /* Ctrl modes */
 #define KVASER_USB_HYDRA_CTRLMODE_NORMAL	0x01
 #define KVASER_USB_HYDRA_CTRLMODE_LISTEN	0x02
@@ -299,6 +318,8 @@ struct kvaser_cmd {
 		struct kvaser_cmd_get_busparams_req get_busparams_req;
 		struct kvaser_cmd_get_busparams_res get_busparams_res;
 
+		struct kvaser_cmd_led_action_req led_action_req;
+
 		struct kvaser_cmd_chip_state_event chip_state_event;
 
 		struct kvaser_cmd_set_ctrlmode set_ctrlmode;
@@ -1390,6 +1411,7 @@ static void kvaser_usb_hydra_handle_cmd_std(const struct kvaser_usb *dev,
 	/* Ignored commands */
 	case CMD_SET_BUSPARAMS_RESP:
 	case CMD_SET_BUSPARAMS_FD_RESP:
+	case CMD_LED_ACTION_RESP:
 		break;
 
 	default:
@@ -1946,6 +1968,34 @@ static int kvaser_usb_hydra_get_capabilities(struct kvaser_usb *dev)
 	return 0;
 }
 
+static int kvaser_usb_hydra_set_led(struct kvaser_usb_net_priv *priv,
+				    enum kvaser_usb_led_state state,
+				    u16 duration_ms)
+{
+	struct kvaser_usb *dev = priv->dev;
+	struct kvaser_cmd *cmd;
+	int ret;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->header.cmd_no = CMD_LED_ACTION_REQ;
+	kvaser_usb_hydra_set_cmd_dest_he(cmd, dev->card_data.hydra.sysdbg_he);
+	kvaser_usb_hydra_set_cmd_transid(cmd, kvaser_usb_hydra_get_next_transid(dev));
+
+	cmd->led_action_req.duration_ms = cpu_to_le16(duration_ms);
+	cmd->led_action_req.action = state |
+				     FIELD_PREP(KVASER_USB_HYDRA_LED_IDX_MASK,
+						KVASER_USB_HYDRA_LED_YELLOW_CH0_IDX +
+						KVASER_USB_HYDRA_LEDS_PER_CHANNEL * priv->channel);
+
+	ret = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
+	kfree(cmd);
+
+	return ret;
+}
+
 static int kvaser_usb_hydra_set_opt_mode(const struct kvaser_usb_net_priv *priv)
 {
 	struct kvaser_usb *dev = priv->dev;
@@ -2149,6 +2199,7 @@ const struct kvaser_usb_dev_ops kvaser_usb_hydra_dev_ops = {
 	.dev_get_software_details = kvaser_usb_hydra_get_software_details,
 	.dev_get_card_info = kvaser_usb_hydra_get_card_info,
 	.dev_get_capabilities = kvaser_usb_hydra_get_capabilities,
+	.dev_set_led = kvaser_usb_hydra_set_led,
 	.dev_set_opt_mode = kvaser_usb_hydra_set_opt_mode,
 	.dev_start_chip = kvaser_usb_hydra_start_chip,
 	.dev_stop_chip = kvaser_usb_hydra_stop_chip,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 6a45adcc45bd..a67855521ccc 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -10,6 +10,7 @@
  * Copyright (C) 2015 Valeo S.A.
  */
 
+#include <linux/bitfield.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/gfp.h>
@@ -81,6 +82,8 @@
 #define CMD_FLUSH_QUEUE_REPLY		68
 #define CMD_GET_CAPABILITIES_REQ	95
 #define CMD_GET_CAPABILITIES_RESP	96
+#define CMD_LED_ACTION_REQ		101
+#define CMD_LED_ACTION_RESP		102
 
 #define CMD_LEAF_LOG_MESSAGE		106
 
@@ -173,6 +176,21 @@ struct kvaser_cmd_busparams {
 	struct kvaser_usb_busparams busparams;
 } __packed;
 
+/* The device has one LED per CAN channel
+ * The LSB of action field controls the state:
+ *   0 = ON
+ *   1 = OFF
+ * The remaining bits of action field is the LED index
+ */
+#define KVASER_USB_LEAF_LED_IDX_MASK GENMASK(31, 1)
+#define KVASER_USB_LEAF_LED_YELLOW_CH0_IDX 2
+struct kvaser_cmd_led_action_req {
+	u8 tid;
+	u8 action;
+	__le16 duration_ms;
+	u8 padding[24];
+} __packed;
+
 struct kvaser_cmd_tx_can {
 	u8 channel;
 	u8 tid;
@@ -359,6 +377,8 @@ struct kvaser_cmd {
 		struct kvaser_cmd_cardinfo cardinfo;
 		struct kvaser_cmd_busparams busparams;
 
+		struct kvaser_cmd_led_action_req led_action_req;
+
 		struct kvaser_cmd_rx_can_header rx_can_header;
 		struct kvaser_cmd_tx_acknowledge_header tx_acknowledge_header;
 
@@ -409,6 +429,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_leaf[] = {
 	[CMD_ERROR_EVENT]		= kvaser_fsize(u.leaf.error_event),
 	/* ignored events: */
 	[CMD_FLUSH_QUEUE_REPLY]		= CMD_SIZE_ANY,
+	[CMD_LED_ACTION_RESP]		= CMD_SIZE_ANY,
 };
 
 static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
@@ -423,6 +444,8 @@ static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
 	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.usbcan.can_error_event),
 	[CMD_ERROR_EVENT]		= kvaser_fsize(u.usbcan.error_event),
 	[CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = kvaser_fsize(u.usbcan.clk_overflow_event),
+	/* ignored events: */
+	[CMD_LED_ACTION_RESP]		= CMD_SIZE_ANY,
 };
 
 /* Summary of a kvaser error event, for a unified Leaf/Usbcan error
@@ -924,6 +947,34 @@ static int kvaser_usb_leaf_get_capabilities_leaf(struct kvaser_usb *dev)
 	return 0;
 }
 
+static int kvaser_usb_leaf_set_led(struct kvaser_usb_net_priv *priv,
+				   enum kvaser_usb_led_state state,
+				   u16 duration_ms)
+{
+	struct kvaser_usb *dev = priv->dev;
+	struct kvaser_cmd *cmd;
+	int ret;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->id = CMD_LED_ACTION_REQ;
+	cmd->len = CMD_HEADER_LEN + sizeof(struct kvaser_cmd_led_action_req);
+	cmd->u.led_action_req.tid = 0xff;
+
+	cmd->u.led_action_req.duration_ms = cpu_to_le16(duration_ms);
+	cmd->u.led_action_req.action = state |
+				       FIELD_PREP(KVASER_USB_LEAF_LED_IDX_MASK,
+						  KVASER_USB_LEAF_LED_YELLOW_CH0_IDX +
+						  priv->channel);
+
+	ret = kvaser_usb_send_cmd(dev, cmd, cmd->len);
+	kfree(cmd);
+
+	return ret;
+}
+
 static int kvaser_usb_leaf_get_capabilities(struct kvaser_usb *dev)
 {
 	int err = 0;
@@ -1638,6 +1689,8 @@ static void kvaser_usb_leaf_handle_command(struct kvaser_usb *dev,
 		if (dev->driver_info->family != KVASER_LEAF)
 			goto warn;
 		break;
+	case CMD_LED_ACTION_RESP:
+		break;
 
 	default:
 warn:		dev_warn(&dev->intf->dev, "Unhandled command (%d)\n", cmd->id);
@@ -1927,6 +1980,7 @@ const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops = {
 	.dev_get_software_details = NULL,
 	.dev_get_card_info = kvaser_usb_leaf_get_card_info,
 	.dev_get_capabilities = kvaser_usb_leaf_get_capabilities,
+	.dev_set_led = kvaser_usb_leaf_set_led,
 	.dev_set_opt_mode = kvaser_usb_leaf_set_opt_mode,
 	.dev_start_chip = kvaser_usb_leaf_start_chip,
 	.dev_stop_chip = kvaser_usb_leaf_stop_chip,
-- 
2.49.0


