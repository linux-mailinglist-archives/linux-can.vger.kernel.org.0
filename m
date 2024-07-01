Return-Path: <linux-can+bounces-925-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 828AF91E499
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 17:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F071F221B8
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 15:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A740716D327;
	Mon,  1 Jul 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="BfQlj4GA"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2125.outbound.protection.outlook.com [40.107.20.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5A516D32E
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849012; cv=fail; b=E9A2hyzyi7uMbM8AzB2ehiKIy3PQS+/TporgPwimVGD5yezQ5IgnlUzfSrxMXmVHd9vR79C7DWvrJ6iTxhXrzi6PbgiWmW8ZfR/VbKn2rg8ypoKa65hlqjVNoMfFswiG+qp8C/VwLfLr4tUrA2h8yo5a1/c4UfWahv6Dp4eCVo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849012; c=relaxed/simple;
	bh=6uND18XSwBL8IyMzc+OjpnR/Kfg/S1cU+N7H0Mjg6x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T4i8XUdUxn3RFUmYG1lxJozL86XqjpWDtAu5cSzGV5Cgi9fnzeI7EknHj/RdW/zQQV7dYPX2my8czyvT9iAxgBDCEx87mMKqvVLWMMWVUKxx8E0p5x4pt11wBaz8jaXum3K6/gn+aR2OJvAipH5/wIOwzU+nYzjn0kH/SIkkEZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=BfQlj4GA; arc=fail smtp.client-ip=40.107.20.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXgcj1jHH6/Mk3ZrzHGFAgnCLEw4vhJGHMMYiTDoi59fRltXIGHRJOLMS4THiuWLy20WxqtVu8FUU8UtJSoalPADxPGWPQB22qSOs0R2i2z7Yx6jml3S6zj2GBJcBqFcTqppoaMB9FHGcqF5Gs2ijHJs07XKMmWlq2P32TTWRDOBO9gH5sVQkPmtxblUny1DhP7jcZ4K2EgDkNlHr3qSBN+3K0Bqao88QYG5j/FLi23iQlqzJaZ1dWYF1/iW2V0B76r3KGDTz3eZoFdOd4kQgyPbLYxcvVlOrM5MZ+YepqrWmt+non7Abt2G1ZnlQ/aVpaTCuiuG1Y4XlwA6jkXkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpquKG2jKAOq9aHn/sOv39xfVoJUli/R/OFFV+WnKd4=;
 b=E6VLxqUq0rqRQ54Qd0+H5o3Lwdad8sjRfC0apf8QbaSD2ABllW2CUyhHLCPknx12r6IUIvhQm6kG+WPVN2t19IYOm8HU2kHpdcTd/qVd78U3jq9UWm276PF5V0HRfuO0ngHAYtR3Yl5EFSvuw7gaP1NOZozqCK3Q6vMnJYRBVuX02lK9xMqeQP4LwNCc5rC8vLdvyfKZzGbZ4YHEKDLlzNUqSnCURBcee2VUAdWV3noUM5lvxmXwZkDOdl0dWDXnZTjK3b1K5DJ5xkQ5axD6lIquoteQZu0latZGGGolcNGrTpS73JTusFdnaAS7PFU3LNjNzzti70vtJ6wO/St+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpquKG2jKAOq9aHn/sOv39xfVoJUli/R/OFFV+WnKd4=;
 b=BfQlj4GAvePYg0d2nsRW1TlOLdh9JKTCyPi/z04qLY2iD4g4K2ZqWfd+mwomosUGLjm3nt3UKzNy4ebO2Y8hf1QNbN/w6pxk5gwSW2Aebsn5Wyydb5yvIxTHKfMSBBj+O3nw0rIoOiHE2VpXNXuox2IC/PFLiL9Lu0OFPfkB+lI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0519.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:50:01 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 15:50:01 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v2 06/15] can: kvaser_usb: leaf: Assign correct timestamp_freq for kvaser_usb_leaf_imx_dev_cfg_{16,24,32}mhz
Date: Mon,  1 Jul 2024 17:49:27 +0200
Message-ID: <20240701154936.92633-7-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 30a03499-fea2-4062-5518-08dc99e577bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DXXRZv+m4o+TUSkDGeHBRg7Zipf3nt6jX8RECioJqHYABkGBmPCRlynUxJ+l?=
 =?us-ascii?Q?ho831e+WPSnnDx6UQLtODCmI+6oM6LxKGQQSYoBql/bysHmAA4hbQXV2N09j?=
 =?us-ascii?Q?1DSVSM+TLdQ9LRE5FHl6FkY3v0KQGN/jrFhBcghMvcHwSmxppNxaH5RqtxIf?=
 =?us-ascii?Q?4xDJ0Jyhd1uvyzJnnH0lnUbj9hp+aEC6j4wxgeN+3/LwzJE292LoukF5annj?=
 =?us-ascii?Q?QYd0wnq+i6RT7++6HZ2nSzxgPoHULbj2sYrti5wQzEdNn0i51QqRJ/GOm19j?=
 =?us-ascii?Q?20OBMrp2uyQsblLBv+j/zFUIiXc6P916A7wYNM1crJD4oWZasWzEArq2y0jV?=
 =?us-ascii?Q?PaIEF/bXKHcBHtbU16ilPuDkIpPQh4vdcMzkgOjQuX6BdYT9Unc5cdGH2BBU?=
 =?us-ascii?Q?qPfeBRF0hs47y259WJVgIe8Kkj+BcMHouCo0Io65P5zJNsMEit0HisCtf35H?=
 =?us-ascii?Q?rCe6kUO3XjHoYIakr7KgOALkOIx7mNlJ8AiIR74xnbfeS9u27YtZOHY4gL+V?=
 =?us-ascii?Q?rghE9IgSJLkqKGO3gy/aLGL77Kyx1NyQSk7exlY0+qDeFVRdZbh6/gaOG293?=
 =?us-ascii?Q?xL4LtyZ39pUKDL9a4OFz5CKrwLV9gw4oekKJ0yKyACQC5jHi6r/40LnBvswg?=
 =?us-ascii?Q?bw/2MZ/Xyy6wAa/LKeBkfCA9UPE0++09FtFIXVybPuevhrpRNsnmRMz81pym?=
 =?us-ascii?Q?vwg/8FmUgI9ZXtwNWv/5ZR/BcmijXXsfpj6DYLNFaSwxDVJ75HyoQtEp0SH/?=
 =?us-ascii?Q?2HN+c6V2oi08RhTkTaXsnraZ3Mf41Wbeik8fPJfqJ7hdN0ARiYwgqK/bqq53?=
 =?us-ascii?Q?HdqSCh6MPm1/ktj2GqEPGiEAMwWdH6TK3wu+6UE4v+2bE8h9JYqU7xXuUbe5?=
 =?us-ascii?Q?Lwqw5AZj0kTWjkgkJ2TXLPbPjlGAhRE4fwnIGjNGp+6p9HnoUiXyo+zzSXIP?=
 =?us-ascii?Q?98HSTv3/HOCwmUfLtQ1c9hW37dTL4Lq9EBhFSXXaKk7PgHEN3sCIzzwBfc2Y?=
 =?us-ascii?Q?PQRcePwKJj2W2txAjnYwIq1s7IZhrTxFjUXlAPwr2M8k9fBUMuIsZdyqsYLZ?=
 =?us-ascii?Q?CBfAznHMfaKnSUe5R0a8qvreGvfo0r5c51B6g4FmiAwne0O8r7hyBw5Qcco9?=
 =?us-ascii?Q?xDOevcEt2WDg25X3gydJw+PJ6tLiWf9x+YdnmKHWBVWZH7hBabJ/dzeUVLES?=
 =?us-ascii?Q?ptXX9Htez57neWsBltQ+p5rHkU1D+3MMCkS9NfIclAMSrkHNVq1/JMA/yIgb?=
 =?us-ascii?Q?GZ1wbmvxWC4G7KQRGizZwYvpuaGyCM3bKS7CAvCLzalbHKnNLR6lArIJBG4f?=
 =?us-ascii?Q?7MyBr2L51xXYIj8b0o13KkWj0p3lkUDgsuyzs3nsOeeRjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7pY0KgzJTUhNwuIPwWvDth9xpvvvZhq6YsuD/Goi8lsYRBNBk1I57IoFeRgH?=
 =?us-ascii?Q?ofEfJlhhFH9Tob8lqfJ1d5qk4Aa0C+e86F4YYE2G0sSzynVxbdAhVtbM8dqe?=
 =?us-ascii?Q?V+3hcQYr0crFzpM5Edj08xi12kzLNoftlXTXTjXnjlUAjm/mQJq123wzP3TN?=
 =?us-ascii?Q?s08nt2CJbQFTv0pAtOAZwR2TwTZ4YUWfj1SCnLpdzMXYv3i7o42NSqlKbMQO?=
 =?us-ascii?Q?EabR3il9kxZSQyxow4B0TMWTQPDCmpCQ4dY/HErRrarwiJfTr4GhgSuOh7ZY?=
 =?us-ascii?Q?rISDNVmrcHOttcnjIpyEBDJbpPDT6D99VMjcPw/julTXAp0Bt/dHroIvEw32?=
 =?us-ascii?Q?6Vb2mup3pBcLGPEZBsoDbOwlmb9tiZ62btx2FIkH1aDJFmVVuBbPwUXntske?=
 =?us-ascii?Q?CdYgLZTYYvGVepMnusZXbUu32Eb9IjWestjc3f9fHhQkhEKgAGvO/juBJJW2?=
 =?us-ascii?Q?m8OXtyMAPnMwiYy5cqVuvYoINbidZvPia5S90Zv/wzL/xSoXN8LboyIyy6d8?=
 =?us-ascii?Q?PH2lZwyULiJ5XWP+IrRcnhpscbaxqwoHu2yEDsYE3Kf2ZGP1Vhdq75tO7M0R?=
 =?us-ascii?Q?qDbtJzK1QsvRAH212k4TY0+5eLAzQi5W7hE72Rrby94MGrQc5gXnujO8O4Bs?=
 =?us-ascii?Q?WeTAT9HDs22HND6V1MND+g8NDifCtye/ANaOEFcsDPi00Ja7OOp9oahxn0Jd?=
 =?us-ascii?Q?yNRYk2WT4GRtXm8WG5ECr8jAb2t+vibmoLKySGkBIFmwOA6Tv9+cHz14NtG7?=
 =?us-ascii?Q?lWppYftY8OZE2Eydn65scgqSYWuSnJFF0fWaRJC1CCGLxI+HJquGiCtYLnVP?=
 =?us-ascii?Q?dIBKDD/xYl2hxE+tNNfzlAqWzJAg3MUSQviw6PzffGi1K4O7il18gWA+aPnZ?=
 =?us-ascii?Q?JUQSVQAkwUOxcFvarDOh1czUqrlc7pZx3rMVh2XSwhZQ6HRkz24f4lGo9ZpH?=
 =?us-ascii?Q?8SXPf5Tnn+cniWSsxfouts5xJPNDakeB5dmt90tx68JKIbqb3EtJv50WAjtJ?=
 =?us-ascii?Q?L+qP5V8B6SULsvxz7OAeIMzPHCkElP71J0km6g5LZrGymYOkRlRW5PICLiT8?=
 =?us-ascii?Q?5gVSz2mmV6r1hCHZCTwRUcYcCgye2X3cnUEXZNm4C40o7zHZJ4Z/qwoR/Doh?=
 =?us-ascii?Q?Bx5qdxw5wPQWjqHiCyamsNfhYCKhBR+SDUe2QHnLwPB6s8+qDjcqP3vMnKvX?=
 =?us-ascii?Q?lyVF+BjL0XrGouYmMr8H9t5UkkTquKRFlg98dwKm2VlHamcKt+HoAJeBg+6W?=
 =?us-ascii?Q?CwCOhzySnKXtLV713fvTz0RRgpNPlVX5mybqWTwQfa8ZOyIc6cOn2nFosBq4?=
 =?us-ascii?Q?5/yAAnzry3ieYvZz0v+dZOuVNiwoiatr7w+wT0Slx4UpFcQQU4rqdyTVp/RI?=
 =?us-ascii?Q?3VH6J0eZU9Dl/SCIKr5qK3SUNETTgyZsbomtd2hpdFNp9zC/cAobMwMSwlmA?=
 =?us-ascii?Q?h7QSj5Cax+ioUuiL/hwO1y3ZspraYUYonfVLNREXSQhCijFsMdUb1BQJ5tPb?=
 =?us-ascii?Q?PfwHwKexw9RksrQq1j4YeEbqrz72ReNvKs7tXxZwL3OyxTBrece8xI9DgRIP?=
 =?us-ascii?Q?ovUED0CFkV3ag0k3IOkwFHhoHVIL5iP+AUDuZfhW?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a03499-fea2-4062-5518-08dc99e577bf
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:50:01.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UguCVIirlhMFqEkM104oBVieWtBGhL3qh36lH7EXee4hE01KEHZU/NbgCNQZ/aac92bAs5umOGuMvgI+cIbW7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0519

Assign correct timestamp_freq to kvaser_usb_leaf_imx_dev_cfg_{16,24,32}mhz.
Since the driver didn't utilize the value, this didn't cause any problems.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - No changes

 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 70511e151a3b..00fe7410e36d 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -483,7 +483,7 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_imx_dev_cfg_16mhz = {
 	.clock = {
 		.freq = 16 * MEGA /* Hz */,
 	},
-	.timestamp_freq = 1,
+	.timestamp_freq = 16,
 	.bittiming_const = &kvaser_usb_flexc_bittiming_const,
 };
 
@@ -491,7 +491,7 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_imx_dev_cfg_24mhz = {
 	.clock = {
 		.freq = 24 * MEGA /* Hz */,
 	},
-	.timestamp_freq = 1,
+	.timestamp_freq = 24,
 	.bittiming_const = &kvaser_usb_flexc_bittiming_const,
 };
 
@@ -499,7 +499,7 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_imx_dev_cfg_32mhz = {
 	.clock = {
 		.freq = 32 * MEGA /* Hz */,
 	},
-	.timestamp_freq = 1,
+	.timestamp_freq = 32,
 	.bittiming_const = &kvaser_usb_flexc_bittiming_const,
 };
 
-- 
2.45.2


