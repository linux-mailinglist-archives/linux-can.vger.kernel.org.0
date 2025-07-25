Return-Path: <linux-can+bounces-4139-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4CEB11EBA
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB78A7BBC0D
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002A62ECEA4;
	Fri, 25 Jul 2025 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="TjaznJxr"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2109.outbound.protection.outlook.com [40.107.20.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1452ECD1C;
	Fri, 25 Jul 2025 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446912; cv=fail; b=cA91yCYXTCcbwTXMkFL5y57ueJH3CIxTjJK5H9IbHa5HJGV24nlLM3wEIZGG0hM4QaYuYDEKkewg16mlRAftUxNjSmmbJu+Q//lCOXt71xFHnSEiwy+8mWQ2zEljybHENawGdNyVjH173UzkPrWRZPzdKeUMjrKEG3iqurz9tLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446912; c=relaxed/simple;
	bh=x/dgKxPWRwiaOHs17MWy4Y5WLLEdd5aj3Q2GIP03u5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mcvp3FlsQEY7fJ5qnE7FZswjbFvpUKx5jDcp//25sjsArwOhhqAJCQjXdoHBgNml+Nn73MdunnpdP31c3HYN9v1mZRD4beijUJZkwxaCJeeTYrViY4UxZJ3O51/p95/40HfRkcpslH2ia3j1M1xOmeH8L4mk+hxPzPdWJ1vr4yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=TjaznJxr; arc=fail smtp.client-ip=40.107.20.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKKXI+yVzeWihekgaV7pxAoXyZf54J1fa5tC3aFRTiHqT6l+SQGauqbyQZZjL9s1h14dzN3UG3iwhHnOWS2ZuylqbaLLPjHrFEBTpE5jwWmAs2OboVcLip+cUs+iWQvt75ewZJQqwXP6y25mcVSVmqQ907iVu3xeMQHnvB0hx7rRjJaSXYmbwgMZST1nizJeTk7MkAvdFWuYJd8zyWJTZITEBYowMPXIU7pe6d35zS5+wRUwt7PsJDdEm06VO+FjH/y3umImtGFrNMbgSqLVM+3H35rtGIsPIo6geC3B7Z4F7tBKHAUq8Zh0sWgH2RhZtk2ZOmnpZZ8oToQ7527/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kPVtpTlxUjeVByXzGyvQCVFT/ksUlIyGjRk64eNJGk=;
 b=d/5vR2DQW948inKI8U+rUo6DYoZ843pRna9hyEbJI15kkrFJGFSH5RQjbSvOC+IrwnDAB5eN2bY/cTTKa2LfWCGdtdxSs/XuXWoWQuemKaqYcEPm06UGf01umPYwqXQ2vMpl7o6BLVN2lJzGAkE7/4FZCcOCUYEymrryis0Mw9O8QeQSvKG3ZnM+iBqxWduW2ARzH4Bzb94sW/WJ4JJryLVaO7wQ/BskfEZt2WV3d5G0zFU8lN//ZRjEdi2ZtThFLvEqRyIGqJZxm2zmEZmZdPTi52bO8YA4lBq31URGFAiGwLijEhfvdP6US18h8Gb2Ql8jES9RGjjfHpN0murGvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kPVtpTlxUjeVByXzGyvQCVFT/ksUlIyGjRk64eNJGk=;
 b=TjaznJxroTDfT4wvWwH5hh9RJsQmpmahyPOax71GsesLiEonUSpnjfvnj/SytpNTA14vq4q7h083LBoKp8jCag0XQJ3q9l1SWGNeLbv8kyHPMSRimaddILsTWTHCKdRHnEFDbn4AauDn6FaYLMUjX3rVDb7YSd8lpzZRHUuFkrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB1219.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:36a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 12:35:04 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:35:03 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v3 05/11] can: kvaser_usb: Move comment regarding max_tx_urbs
Date: Fri, 25 Jul 2025 14:34:46 +0200
Message-ID: <20250725123452.41-6-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725123452.41-1-extja@kvaser.com>
References: <20250725123452.41-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::33) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM8P193MB1219:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a461db1-be67-4212-e65c-08ddcb77adfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dse24Nx1XL5DkzriVWcOECjtZpdt70wfnck+9AqjsGD6GkPtS3CkjH9OyR0t?=
 =?us-ascii?Q?C7VHdJh8mVhGbBCbi7ig7ntCmeGCnkijDjMhFygTAPvBgawiO2gehB/hsjQp?=
 =?us-ascii?Q?gkf/6+YYOOmHEEcRart1MqNxJpAXqyTQisV7O0LRL7z5B9bXWQyU8wOCz4w1?=
 =?us-ascii?Q?U4Q2QYoAAfq/C8F+7qx/Gq8VuLfhoXK/Wg7OXx1OIMWdk2PBWAA4xmp3M4VY?=
 =?us-ascii?Q?igVe2wXj4F4vRZtv0ppcqDCUOZsSor510AC6jxioLoH2hwu12GQfflGk2Fec?=
 =?us-ascii?Q?IQmXFOrnQoRzVstwN13+YNsuGk6T1HmhsLttJNRY85iTjzBKEzHSscas5SUv?=
 =?us-ascii?Q?q1Asw2njRdtR4jiEOLcJDrn1MEaeQ22pdGBCndm63cnhvgPLAEeJBOJiOV9W?=
 =?us-ascii?Q?waFrfQYXAjPNx6g6ZOXLuVB1SFnC0AgDibu0rtmjimizePQgWGaAAPFmprzV?=
 =?us-ascii?Q?zEkDtGrCBJLCYswL0tJFoTsBIUotrdN7RyYY2Y9mZPvTbWNW4ErlEJDHDtmz?=
 =?us-ascii?Q?CkHwqRKv6tm5og952PPwR3PUNvyc1M/4tRzCYU3dTsjidPetFakbWqGfJxA2?=
 =?us-ascii?Q?bga52hwR8umRb//3xUNoTPssGPJHpS54aMzOJ9s8W+HTAq+4tiqLs3uQkllG?=
 =?us-ascii?Q?8EW/fbcEPM8yeyu7BCYRikmQJmilZFKmPzOetzhV6tcHQkPT7rLvBhg9yqRM?=
 =?us-ascii?Q?Ph1hNiyb+pw8KShQ84TWZ5LMxRtX2RQmr4YPTrcNgw3dBd9hFoo66Wcmu18e?=
 =?us-ascii?Q?jSKRkJqcgawJvMM15burkQly5NcHZ4YXzzzNnsiRHqgUfSYa9n7mPivJFmWo?=
 =?us-ascii?Q?TmBlMP6NrpJZ52Hu1bTd8k4JcL4mT27ulhY+C6t7CcvdAi8vePpEmXAVLB5P?=
 =?us-ascii?Q?qvb/xqc7/veiF5NshwXY66oLTop9FjTaqF8YWqKt+j/oyjYQF9srDJ6Vl3J8?=
 =?us-ascii?Q?vww2bbj9ePOCqfjDiKdxvtzPgCOqc1mgboBFvSGKZdKr/YrqO2ckt9ExUx6P?=
 =?us-ascii?Q?GkQMxbptXT/XOWa2X1DMTm1FshkA6IX/lUpIn9sltC2obR0h9u+lrAe7T4qA?=
 =?us-ascii?Q?6D3C7oeImaGSIFoXQXqGR8qEZbMKWL2anaXS2jjtgK8/FncbvTAgfftEivG3?=
 =?us-ascii?Q?hr0sHettjGjML26LZZLydqifavrtrMrJrayNpXGpr56OIiR12kqFXjLLHQm6?=
 =?us-ascii?Q?A3QSZwVTyjR0JbC3joTte7/4fl5uPQOxN/4SQM1VUwi2pv097Pcn/qVWZSBI?=
 =?us-ascii?Q?Cehdo8Q1DQWfD3RF6cNbDDbGksJQdKbOfqB/HVgAP4PGmYrE+A10sKibCzoR?=
 =?us-ascii?Q?b7ph5PUR7H7Aeffc2OnMqU2hhaJq8G283ODKFx0QbkNOkJDz9BdGlHqU8IRN?=
 =?us-ascii?Q?iUGz1e944oG9TRSXYsYNIM+e0AwM7UjzsWuRUGKuDNVP+kB+UJYmoFg3NNHv?=
 =?us-ascii?Q?90FERGZYxxo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?owgMIYxi4VXBlArJCeL+EXYZd7x08sCvXftZfGlCDEWVUgOzjXi7l4+kBkCx?=
 =?us-ascii?Q?1CJ3H1KDmDAPE9YEJK7TJIfDC3BUZsRtJztUkfRmOIt9NnL50akCw4z0fT0z?=
 =?us-ascii?Q?AuNxYynJ+Asfs2ALQWKqWSl7I3v4E9K5LDPv82Jl9qFXuL85ZianIOYHHmqU?=
 =?us-ascii?Q?MRvCGYJUb0GzN++6GrykE2Kij/l0UQx8JbRtZ9FPz7w4/adIErHuQhfef6Th?=
 =?us-ascii?Q?B+69DZz3T5RYvrxv/8rqSi5BA/Bq+W17nAxRxy4m4IiUF7rSsXOHEljL6MDz?=
 =?us-ascii?Q?S3AP1XSfrLG4ruONIm+GPgBpE5O0f3GtHG3iCKgXapsU4JBFmr/V9QJEiCS7?=
 =?us-ascii?Q?YGZwds/pZq7lR6A9jnoyQWNmyStf4LgtE7rlZM847OQiHzbL+BcSnN8o/Pvl?=
 =?us-ascii?Q?/ko5jouA3I+3vzSMXNs+b1NMvIz0eV8ofjPesRLCcIaHP3ni0Os2nonW5bf7?=
 =?us-ascii?Q?WB06NPIXn2w1vO3hpMAvuDjLg01gnhH870WU3/dVYXE07xgkf/YIjKRFCzeM?=
 =?us-ascii?Q?u7b1rl+zH4Len/EpkkmmMvaqAj1InpGXpziJQYTfRiaWlKvyUoSQ//5u6foN?=
 =?us-ascii?Q?4jpwc6kFPhgEgJoq7+c4kXYJiAv8Jch/MYgmofClImJgMEScgC68RIasKBur?=
 =?us-ascii?Q?fKODwfIZhHgYxRuEdQhBfDiWaPPPVdxlfD7zT18lE2dC3Y8kEdl9hW6uK3Lq?=
 =?us-ascii?Q?g9dXsWKOesOLHZBVFkLO7fk0BNTtRjVe+mJxzE79127ZHB3Wt+qesN+gVQIu?=
 =?us-ascii?Q?EZUUcpJ590IXBXabmGPhccmfRPEdZspmvk3FyL4nmG0KQoxmWh5+pNdnynsx?=
 =?us-ascii?Q?YqW3GVT53rmtXEJlyqw+f7h0HLxyuRp9OFtbJj2YuTrzZzr7YiPX7keZkMDF?=
 =?us-ascii?Q?JeFqJe7nRIBOGfvNgw9wocHmzJj8or91VM1CMiIHn0EIKrqTX4oZ5OdGhc2Z?=
 =?us-ascii?Q?4WjENMmednswYDd7WpswwsJNjauVkR548ffFkakWNmUHcBCe724HoF/3+4/O?=
 =?us-ascii?Q?dPG+V0Joly8+cq5elch0eN6ee7aw8j+PZdQOrEbRaScEw0SLkG4m5vhE0tx1?=
 =?us-ascii?Q?SNKxP7wwFe50snSj3f79vSy0iuJgc0oCsSjZKq3hm60Zp1zVzrA4spE4LkpH?=
 =?us-ascii?Q?irtw/hsh9h5AdgHqpel1ngY2iQXv493pYjMAjhD/jRPluhiDRHRExTuICysV?=
 =?us-ascii?Q?pYDbesgjprNO4kTjY/EHan6GUS5j471XrpwqA4nifBWPbWzeL879kfc8njjr?=
 =?us-ascii?Q?2Nz5Iw2kLBlHfVdfvameFYK2nTwh+hNYtc4FvgSEfizdBRA1mnUwX5hli4ks?=
 =?us-ascii?Q?JLfu4yjFO4v8UtNX1uQzZ0wp6Kwp+62l3jNsOUQ/mRsyfx6MoQ4ayvxT5Cm6?=
 =?us-ascii?Q?rLfLAsR+mIGVUDDV1ocdCVBwQAom5PXQn95Zu9nAd16s68/dtU5kCbJS4adg?=
 =?us-ascii?Q?/7l2qJ7zM4jPcI2w8e/R9H1Q6YdkDvjRNQZoNlFusyGWXW8/BPM0F2ciPNZz?=
 =?us-ascii?Q?zU8t4VIdpYf7gvIotmbnYPvVCO67IsNbvnYN1+OWpie7w68oTmlSHshqKnM+?=
 =?us-ascii?Q?JGYVmK4QDZ1/d1ub2Fr/EawvuVLhN/44NuQdwfanZrCuqg2ZgHZ+rH6arOmH?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a461db1-be67-4212-e65c-08ddcb77adfd
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:35:03.8911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSADfB9KliD/VY15RQC32SRO1c/rp1xBqcCSGfHAqlECoNJuKs/cJR0tdKmCCT7UQ0jkVF99NuisBEvdkKZMntNwCqtrVsb854hYIwYtWtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1219

Move comment regarding max_tx_urbs, to where the struct member is declared.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v3:
  - Add tag Reviewed-by Vincent Mailhol

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 032dc1821f04..fba972e7220d 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -101,12 +101,12 @@ struct kvaser_usb {
 	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
 	struct usb_anchor rx_submitted;
 
+	u32 fw_version;
+	unsigned int nchannels;
 	/* @max_tx_urbs: Firmware-reported maximum number of outstanding,
 	 * not yet ACKed, transmissions on this device. This value is
 	 * also used as a sentinel for marking free tx contexts.
 	 */
-	u32 fw_version;
-	unsigned int nchannels;
 	unsigned int max_tx_urbs;
 	struct kvaser_usb_dev_card_data card_data;
 
-- 
2.49.0


