Return-Path: <linux-can+bounces-927-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0F191E49B
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 17:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1541C21A2F
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 15:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE6F2C6A3;
	Mon,  1 Jul 2024 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="dnXvcHnn"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2128.outbound.protection.outlook.com [40.107.105.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBFF16D4C6
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849013; cv=fail; b=Uj8TNnlihk3DvPy9UbXn7/QvCfMtrB55MsX62xuLSSLLM5sFXIovyStwYssTDLaVvZebPnvSxs1UPva2A6FqaeqXzjfBznJebMZlarCjCZH4UBiAlomYw8QIXBtnQt8RfZiWFhP20+iPQNqa0zFJPuTRuMBzJpMw9JDv9gqkHxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849013; c=relaxed/simple;
	bh=1BC3+UJnG+Ps5Hldoki1Pv8vA+IId35prrEMScv1N/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hJzog/mDWFYS+iMnqF28Ss1lka1yZ+hENW1+S4y/AcYl++sopgeXf/zRYX8GA8RyQmeAyhbg4Kza2FkTby6oQAtBbHLTbve6UmZ8ZlO9TgX6/hnsOgVMbq6nmVv5WMd/bjME++TxTZM0HFk6oL+Uc1Qr/1QzlZS57+uvWbveNTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=dnXvcHnn; arc=fail smtp.client-ip=40.107.105.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdSmacMOXH+cRMIMe61OKvIPWqaLo599j4W60g+VPl5HfOFxrQx2pXJPaKSUbIxyITXokqZyqMeREAp5FwOIHdsydJ0JIHKrfeJEizYeKWs4Dn/Cnm0wUWixZ2Nx3q4XDAgxJXDeWLJye1vtAdXZqqEGa+hl5x+mRYY58IZtnNZVrQzjIH773HbpQ/Tnw49Uh3shU/lP2uGXEZSMTCpqHNUBjkTXDZColXsDREdaY1WLOgpRzqJb4Gc3sxfODeTrffC9dviW8qEnQcoquazzsVDkYJ/CeXhLxh5xQhlv60Q0LzgkXX1QoXlDEch8H5fnX5RhCJy7LGngE7aIm05AVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSFryqUwhYyxcp3F5khDdkSd8tWtM38UsxsnHQ9Q+oE=;
 b=fZ0F9gemXo5NOCgGcFgfUEZlqOYtQu/vfpwWTShZhCOhFYcdrlCEFv6fgjOnFwPz9NzXu04AKhtp8TmFTe9x7UUHUMmrS6oYpEsFrOVq8LYUTrDuIsAGj+IKWGL5eElUjvnL6Q/LpMm/+l0T+vvITJTq18VBAcaVQTL4G/i7msy1tW28/L0cTqyj3uM0eRo0LUftqL3j84hD/adWV3WowPVNAPgcP6vXvvfLlvCaQwjvR1ACdU8IhcML/HM6e/A/xja7UrZIXMAG9ViMqymlQi/edRVlXEshBRWeZDGOKdW5GEAMFlvVBVqTcmQqqcvCuw3s7CxZy37SmkR/iFTC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSFryqUwhYyxcp3F5khDdkSd8tWtM38UsxsnHQ9Q+oE=;
 b=dnXvcHnnTm/Bms66HIqSeBEALb5rEMG1o9CIfBRxcQ7AGDZZdIyRhj6bpHstxyTwNl1zGcOxtWn/GsQ2AQ3xUQNRyFyyLhsrudHxCr81A8MJvsroGSqC5X0MMiBRBIIPh6XOi8EXC6Eqg5SGWlQ9ZZmp/dgtVwTGG+6srAB2qIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0519.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:50:02 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 15:50:02 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v2 07/15] can: kvaser_usb: leaf: Replace kvaser_usb_leaf_m32c_dev_cfg with kvaser_usb_leaf_m32c_dev_cfg_{16,24,32}mhz
Date: Mon,  1 Jul 2024 17:49:28 +0200
Message-ID: <20240701154936.92633-8-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: c1979796-2d9c-4578-afcd-08dc99e5781d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k4d3QkHeTgwVqplCcp1454Xq7fg687xXVcq/OpR/Wn0mktW7W39dWXNSLj1f?=
 =?us-ascii?Q?w44vZ3I3UintlNDzp/evAb9OP1zOdjfvrLFuhDhKQNtoMtbhMbiwFglzH9DC?=
 =?us-ascii?Q?9R/w5C9DZLQvVhvs1V9H8AdK7cgRfNwXWeN2Xgr7T+jNPt0FNLRmY25OWnv4?=
 =?us-ascii?Q?ypsrsK2HUZoD80RErnpQFrxJ5b7+XcFNhx3JJznFDYpeHcdx/XjnToQ9sx77?=
 =?us-ascii?Q?tQusMnUhkFSiMbJAHJx1JXhpaXm9jVFNR3/XfUh89GAruInyeNXK/2d7XIha?=
 =?us-ascii?Q?w7zRk4gHfDjUDsxNuBSjWwon21/H3AXNwew0M6Hls4rMrLHhxl6MCQnRnE28?=
 =?us-ascii?Q?Ve3u3G7gem5dAO8U/cE2l51vyIKm0ckm5Jl7x9Tk8h1XSGrrPfPo0eDRhBN+?=
 =?us-ascii?Q?BYx09bLfdOxwQPMKUvMVXxwan1eSnql3SiOjna1E97bVaLvR+S5d4NcjE908?=
 =?us-ascii?Q?wUCHh7mYycNiaaKzCFFptSGomQAfTzeTmB4s0PF+Rq1H5NfMRb3zJ3NuGoq8?=
 =?us-ascii?Q?F+C7fwTxnqvD4eGwh+CVXKHMCsybsVEgKC2nowS933F7oF4IgmxtFbSbeqX6?=
 =?us-ascii?Q?/jQ5aoiAUdM4UWsrtEmOzQ9AF9R36XDFF9buITXvUWLzBqvnYGhZshqIif5a?=
 =?us-ascii?Q?v94N5uBitwnPOEOa7Zj02cuNHehixSwDy0JCmvNRxTc8qewlKatP3mnf/Oj9?=
 =?us-ascii?Q?nKbj2a5+XCCYqdKnqK775pviFzKpQu6TvjXY32KTSI03KA2DQrRjKjp5ZhhQ?=
 =?us-ascii?Q?U1oFi1Pe3dzlB6Pa/VDfIxDaGellG4koMmtEWK4io4mFXrxtCxxGsrTdzdt/?=
 =?us-ascii?Q?/9wU8fuX1uCTp7GKqML7wsk6ayff4zQ+eS+VtiRkoym3OHYK3XZbaaawDgmp?=
 =?us-ascii?Q?+QrFYa8KbbXcnZ3DQQnZMaVz1BRmGnTvhDVd27lMjoSuSoMYEgiRwNuZqgzi?=
 =?us-ascii?Q?BV8WrduQifeVoQEf5jODKr31wM67/UCYNqefB/1l0Ul0sFSJWMuZYL7C1mrx?=
 =?us-ascii?Q?WPI6YAEyJ1/bEfJXpXBoeUd8GhdrdrhsyueVlPDTHBr18QQ1ROTaX+Xy8kqU?=
 =?us-ascii?Q?sV0Jj/S0o5vXPvJqFJlDDmTKy//R7u/WDS5jzkwQ800FNb3XgAAWN4gLMGMN?=
 =?us-ascii?Q?TrlFDOsgXdZBX+m1LexczevMVo8mHFYkTQgGKZ+c4VuXjpZBProNfKPvLexw?=
 =?us-ascii?Q?c+aTGBsSmy+LHgWqtYqEX6PWf22OBCDBgB35J4RgTcdcrYeU3RxSBgIdm5QB?=
 =?us-ascii?Q?HpYkPgivNU75ozwR785S2iTzb9RCGA2A0jM3jscv17T22UjUJFILMaQnnW+O?=
 =?us-ascii?Q?MpathVt7B90l0x+nipjDOLZutI+QdjFqTQXXreFi7xIeyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8/BwzsDxaZjkJqhu7L21p62cd+Q6EZ61bmyKumMYweypan5vKL6r52gb/4PL?=
 =?us-ascii?Q?sZPxbeJRSi/gbiMbJNBQ/w9vnPLS+q8yZC0+W705tibkIa/U/S52ddMIPHyV?=
 =?us-ascii?Q?lHgRbkgGCxdG3MhZdr2ir/AjmUS6BCRUu3kL5hgS9WJfF6h9Sm1L2d7p5UEk?=
 =?us-ascii?Q?cyOBNsNwempBZ9ptyLPsTJQk3YM0f05qx210pQ8ekLzIlaB3iPjkno6kHyQI?=
 =?us-ascii?Q?lqisj0mbMfiEmYaXF1ZLsUiUl4T3TmSrXD86qH3QuondxCNqeLFayIQqJa2r?=
 =?us-ascii?Q?5nKGTYytvW65FMvsuMdc04tgY+tdZ9TGxgfqrxz5sv0910D/HWatIjzQ+SVd?=
 =?us-ascii?Q?O2yuJqVHEuIjRTGkKfJ5K44FYcPLaBvRILwqbwtVxYKpYJHZjHfDokS6SNA3?=
 =?us-ascii?Q?JrX0KIzhDie9Ja3PqB5MZDOWvTXYEH+7PxAVRxwbgczmkjlYspPzaDGJ1Fvy?=
 =?us-ascii?Q?YCNt4dJeWtmzuM4FKXWWaRUKyJ6dpl7rLorjZwAE3wkotrpczIrciaCFFU/I?=
 =?us-ascii?Q?YrUWqgLp3eAOdzl9ubWuw0CkMAjRKvU67JzngwFq+zQVbc7gN4BUG0OHvBPN?=
 =?us-ascii?Q?yPQ58wddUO+vWfiBX9y6uQ2a0pLBtB+bNNDEqAjYoF70hDK/YilfPuVbKTlz?=
 =?us-ascii?Q?E1EKNbr7L4wTODqBCL+qMXW3GBVL9mm3rhhvl+eVafofzXtq44mxWa8uTHqR?=
 =?us-ascii?Q?OO8C/+eJNSA/VJVQH3GR2IZAz7tgu/iXaBlEwad3e8swRNeI6+TcvZ9VjzMB?=
 =?us-ascii?Q?a5UTZDHfsHiI89bbwcFzRThdrDmUFOY4zMvlvd5pd8qpRRGtQ1iDXUmeKZoo?=
 =?us-ascii?Q?6Jhe6dh7JQ320TjgnIIXfxVIEENUAqEeTz8dfZVNKrfWjS0rlr8NDjL3c//j?=
 =?us-ascii?Q?ITUOoGCAyPNoUPc/8RCojKn72lVc/FEekGQ5SKqPEX9k4e6fGQ9OoRjSVR8j?=
 =?us-ascii?Q?DwItxcCZYIEzAyxgQ2TJq99AjEFeX5/7aT7VUfidt7CoRReWe+xPYSWVTFaF?=
 =?us-ascii?Q?KLoXIiPYhfKolt+QKe/glWawZrq9k9NkwQ7WCiJVMB69PA5Se7h0SE3PHY/Q?=
 =?us-ascii?Q?ooe697UlCzE4gEmDu0c/oSoXBrGD0aEtR8UZX4OibaH6XslX2UXL8+AfRPZm?=
 =?us-ascii?Q?Px08xyi7SdZa/OEU7251zFvC0WWxpxffSI4FVMcJNFrYUeHUMs7Z5Fz65H/O?=
 =?us-ascii?Q?k6O0D2MBRiUZfj46CJaTe9x5AcVj2BpQxadhBxqjh1AEUVV0Roox04wV11wC?=
 =?us-ascii?Q?b1SmLiL+dGGrncjTkvRIAwx+Zr8qmUka13R/xV3ddQ+lNeaKcPBQ4E4h28mP?=
 =?us-ascii?Q?ZfqqJxkCubLQcCLrjuKqOpHvn4Y5x4r/6L5POmJ76T6yLn6dhA6ky49mMEV0?=
 =?us-ascii?Q?6fQair3psyqN6R5/Xhd9aFD7QZdUfntQ8UkEHH8fDzrvjFNjGEkx0x5FVQcP?=
 =?us-ascii?Q?HU0d37RpuZFa22LpQvn0bRxUixzi5ZGMj8/OJpTGPHgazQq8OITsbywTfNG1?=
 =?us-ascii?Q?o3PznP80n05LM7UKHRaI6KLU44X19RofoaxsRP7gPZon27VLkDeN/BXtcFu8?=
 =?us-ascii?Q?kmrlyfc19+fh7nEzeR0JarULviFJ1CRuF0GiUeZZ?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1979796-2d9c-4578-afcd-08dc99e5781d
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:50:02.2424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XAShN/X4FyoYzfHrUt89h3b9zMk+fMmUt5dOHdZAgx02gujZXrxd25kiNYCnxEQqf64baJvgQRqYfsh2HzOJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0519

Add new struct kvaser_usb_dev_cfg constants,
kvaser_usb_leaf_m32c_dev_cfg_{16,24,32}mhz,
for M32C based leaf devices.

Note that the bittiming parameters are always calculated for 16MHz clock,
while the timestamps are in the actual clock frequency of the device.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - No changes

 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 00fe7410e36d..3245471e906b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -471,11 +471,27 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_usbcan_dev_cfg = {
 	.bittiming_const = &kvaser_usb_leaf_m16c_bittiming_const,
 };
 
-static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_m32c_dev_cfg = {
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_m32c_dev_cfg_16mhz = {
 	.clock = {
 		.freq = 16 * MEGA /* Hz */,
 	},
-	.timestamp_freq = 1,
+	.timestamp_freq = 16,
+	.bittiming_const = &kvaser_usb_leaf_m32c_bittiming_const,
+};
+
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_m32c_dev_cfg_24mhz = {
+	.clock = {
+		.freq = 16 * MEGA /* Hz */,
+	},
+	.timestamp_freq = 24,
+	.bittiming_const = &kvaser_usb_leaf_m32c_bittiming_const,
+};
+
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_m32c_dev_cfg_32mhz = {
+	.clock = {
+		.freq = 16 * MEGA /* Hz */,
+	},
+	.timestamp_freq = 32,
 	.bittiming_const = &kvaser_usb_leaf_m32c_bittiming_const,
 };
 
@@ -686,8 +702,19 @@ static void kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *dev,
 	if (dev->driver_info->quirks & KVASER_USB_QUIRK_IGNORE_CLK_FREQ) {
 		/* Firmware expects bittiming parameters calculated for 16MHz
 		 * clock, regardless of the actual clock
+		 * Though, the reported freq is used for timestamps
 		 */
-		dev->cfg = &kvaser_usb_leaf_m32c_dev_cfg;
+		switch (sw_options & KVASER_USB_LEAF_SWOPTION_FREQ_MASK) {
+		case KVASER_USB_LEAF_SWOPTION_FREQ_16_MHZ_CLK:
+			dev->cfg = &kvaser_usb_leaf_m32c_dev_cfg_16mhz;
+			break;
+		case KVASER_USB_LEAF_SWOPTION_FREQ_24_MHZ_CLK:
+			dev->cfg = &kvaser_usb_leaf_m32c_dev_cfg_24mhz;
+			break;
+		case KVASER_USB_LEAF_SWOPTION_FREQ_32_MHZ_CLK:
+			dev->cfg = &kvaser_usb_leaf_m32c_dev_cfg_32mhz;
+			break;
+		}
 	} else {
 		switch (sw_options & KVASER_USB_LEAF_SWOPTION_FREQ_MASK) {
 		case KVASER_USB_LEAF_SWOPTION_FREQ_16_MHZ_CLK:
-- 
2.45.2


