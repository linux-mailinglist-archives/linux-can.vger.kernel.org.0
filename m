Return-Path: <linux-can+bounces-4106-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7384CB1062F
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 11:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181755A288E
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B653286D7C;
	Thu, 24 Jul 2025 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="UhK9kEbi"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2104.outbound.protection.outlook.com [40.107.105.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E942BEFE4;
	Thu, 24 Jul 2025 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349141; cv=fail; b=KbnWA/JLoACta2EeziB3tFFL9Ixdvy6s5mnq3bTCM4Dr7AiGnJsXbNDTBF4lZ3ObWd8AheYVVtGbOYt0n8mERIx3rg5pIhY8JyAZSzamDilBNeKXMQyMW6rNa8W2wFk741UAnndxyl1Gq34Kx8t3fwHGU9UYUVdAehAJMlj4bdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349141; c=relaxed/simple;
	bh=aFBFRVHbX3BT7sK4wh+m4NoEUwVoJkp+UE4PEC0Lxwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VSg+FsFk8tNs3X5Zu77BNi852gPg1pQXusfHnubCi9tGJgD8LoypwH0JVU/epagYfA9e/FyHl5W+Cv7gNLeI6iaj6YlVLlth3nFTw63lPlvDMRjC0cpyvBBXcR44QxRnh/IIobDdyS/nXAdpAY/SeJza4UhSjkvfq+YarEAGMBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=UhK9kEbi; arc=fail smtp.client-ip=40.107.105.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBg4eeCGcIcWvhW0PVxzACAo3S9oEjOaZP5ZOks5tHbGYZcSJan/OGjXyhtyWhfZww/0ZWeaD4jTOqROnaHEZs4qKmxiSJwGSDO21pfJ/EDIKII7Cl71w96Ti9vufs+pDOCipTo4nLIBRlyKiI2YHQXK4BgoMC3v5C23RwkuyUNu/4gkrIbAidgrB8K1OWYvHnDw0ZeOyGTk+cFwtNPlKscnfwBtgAXhwbhUIkYz0+uHSARqW4EdBLiss+dn+E14dAWI6H/u1jra1xU0kGM0njJMujwltdtzSfGGv3Dv55a2h4d4HyNzOFIL3u+t35Vr62iS7GqgcFWZMY7C/Qgg9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsuRxBnFTqOAPBD00PBe03KETj54yk4X6GjberfeS8Y=;
 b=smGp7NzHD2Xy8JmpU6vGmecgdKlxEEIZbyfNURwSGAxLk2ANQ+nv/4AJWyghm7rF1AexQZJw++oMkTYAPpVZgxf9x/36ETQKJjxbYyVg+8r0ygVprxZJgKjQkkFkWnbAJwRUvfTj48bu2fJi9U1nOnh7zlIwv53gMh4wfNBPfPfhfS8smzyZ37wKBRl/RhtVV7SqLVFwEdDP8vzv7elSHMdObEe+1o8e6QzY9UqqVglxR7O7Nw1BNyAgwgDj7gL/bqD5qDOSHen+/YNnnDQ3POcYUgAVstP12OqUHYN7u94A5C6mfn1zGqWwSCMRH7v2YS2qcaBPB9qRkaPdVi0+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsuRxBnFTqOAPBD00PBe03KETj54yk4X6GjberfeS8Y=;
 b=UhK9kEbixhHpXZbL83rABMpr7tsZ9dUMTqShNHENZyYLnpxj37BrExJuXU28UE3TEUU3mYisICu3rTp+OL5DrPJu5bvP4o3lBr6khcBOC2JuZXG7dCmCApay8aZilr+bNSvHiL0adN+Z+OyVvb+jxfTNVqzzeRfsql2wm+DwMTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB9P193MB1433.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 09:25:27 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 09:25:27 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 07/11] can: kvaser_usb: Store additional device information
Date: Thu, 24 Jul 2025 11:25:01 +0200
Message-ID: <20250724092505.8-8-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724092505.8-1-extja@kvaser.com>
References: <20250724092505.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0060.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::21) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB9P193MB1433:EE_
X-MS-Office365-Filtering-Correlation-Id: 44183e7b-3ab7-450c-91b5-08ddca940663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pXBrbYC6ASghR1wVI0pQmL4zlM1WxNVgcW2EgDZNxoc/hqm7UG7a1RXitV/4?=
 =?us-ascii?Q?Y7H12l7gIbmXxf+CUFP2K01yqTzxom/shvZ4p2nyCPNOV+Qi8ih9hXDvsn5Z?=
 =?us-ascii?Q?bH1Oa0JAsZNm9b4eYwWHRcw/TC8SA4wAZg1506pu1V8dHjcWgidDU552iCv0?=
 =?us-ascii?Q?JYmNkSo06wJ7TeaFyHOxpe2lAVXijCeJm9R4ohGX6MQSoXfXAWGM1gwj+b6V?=
 =?us-ascii?Q?o5wpiEQoxnRivPpUMhXbIV71U2IJQy7CGhU1OL5tFiDHoTgg2eEI79XIWHVH?=
 =?us-ascii?Q?SOi+iB5sL+i7Kmu4ikzPP8e2VatQ07cBQXzr8jzsRSS/i0Kuwo8vDqxmex06?=
 =?us-ascii?Q?gAGxMAPtFUFGOhiw9Zjwaff7tH0dkk7/u+gj1gdyaurKiP6hl4f2gdbB7JJX?=
 =?us-ascii?Q?PxL1oZMrFE8m9FLANpboZHVml9MsrXKqrLMOaSWlDPXXlZy4a21N2byqp5L9?=
 =?us-ascii?Q?Sal5gq2X//tEumlPpFk6pc2EuCXDrXzj5/e9sjN33T7FtFSTdUbhF/ZkA+CH?=
 =?us-ascii?Q?XyrjPZY7Dftp4Q2sCM3BkrJLXIpT85/2q2rVKsl0Y0o0hPfuvT1isoKOXgSA?=
 =?us-ascii?Q?ovrJWZ3as6StfyLdDcr07bxJrWDOhUKPANNbse+pVTVClfyDycdw1niPMBRo?=
 =?us-ascii?Q?99U2QFo07n2KJgg7HHpcQ3rm8LJ5XRM9JfNh8wilDecWdIpvIVwUN6IEv6fV?=
 =?us-ascii?Q?PRaGDhmMZYmxXeh2gFVeOz8Se2z2QwAlQ2drZMSe6g5/QfCLwLQjRcxQDIPq?=
 =?us-ascii?Q?nRSu4yggo5zWmaI7M0VZ9FMZdrlNDIuLR6aB4FmszeRrmZyK9pcjmPShMDF+?=
 =?us-ascii?Q?Og+Gg4Guu3o2o7m8MHoG+MrpW8bZR1JVFlvLq0kwvkmzz+Aukx8S9zX+XZEC?=
 =?us-ascii?Q?rRQGiOADYSfgRiIfTA+If9hC3N5eaQBiGm6YFp/LGDeAnbq3E7BOEPC11F9a?=
 =?us-ascii?Q?0VOGyAsTH9fCprkQQXUevLa1KOoHBPG8P3X5F+on8S3yzmPic5J1It4IO9R4?=
 =?us-ascii?Q?eSrNzKSOrV9NkX6JgJGU6R4jwRxS3afjw0z8Pobq9EEippD4LyzkVqjp8udT?=
 =?us-ascii?Q?1+kwycF9Ae6QSTwrVK/oBvg8Qr3ao+d9c6IV8rZrHLw3rq3F7lt/Uj2+NDHE?=
 =?us-ascii?Q?zK+TX60/IUQHMc7tPvjJDSrhu7ESH/1HPfO+MjxU7F3EiMcIxGRrx3DHVFBG?=
 =?us-ascii?Q?UkX0kCCnNtXmM8qX4oGlzxfy73YHNyPyVSelwYA81yd1cX26M2KZknvbvzff?=
 =?us-ascii?Q?ZQjegsU90ofrhYVaknR/0MCXgJtelzKSJa28X6NUSX/Oj52Wq3z9poMXE8tF?=
 =?us-ascii?Q?mAnSH4vjQicoDbeew/EbRxdAaF3zYoIBZqQlCJ/aYCETBj2v5jrqBPHm/9/t?=
 =?us-ascii?Q?Y13Wxcwx8NESWyp4IINhhNTXSmqlp/hd52ouOMZB+QoDbw9HKLPyWV8Im358?=
 =?us-ascii?Q?uq/cCU3u7ho=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0HElkCXbSlx5WYTHEZa24+STMq1YDn3NEsuiXxwoOzHL75srm1vg0txfaxGj?=
 =?us-ascii?Q?0CqPU746NfBZsVvVQ22RGF9vo2EHr+GsA7g0HWWd1yVZLfAo2qgIDUrTjN/B?=
 =?us-ascii?Q?Hn1rAzTg0zlLl6IlnKJfcGi0t6WU2geA45pll0NIXFmXETcY1452uVPJrDBq?=
 =?us-ascii?Q?jTFg9uNAXN4pOW53g9TmLHevcJ31nCLr4n+E7DmX1+X/7J26UHEVsfh7Hxb/?=
 =?us-ascii?Q?JAVhVLQWQ/u+cniRrFC1M/i/uithXf3quetVRATJ2e7uBigDOzWkP8YsTF9M?=
 =?us-ascii?Q?ZUb2jWgUX6uJrS3dUHasRQ/FO9C9CgyV3LJU0c517nX6G/myOHALLrJ6AhTq?=
 =?us-ascii?Q?9OUldAEFq432gtcoqjaAjjj4Pgot1jt0rs63fc6qPHnaVjaB4e5hwHYMUvwV?=
 =?us-ascii?Q?ko+SpiZsmaArSWChp8qZvN9ewydduvhuU1R4lt9jJWQSxg3T8Gx8Mt6fOzL7?=
 =?us-ascii?Q?RI3TDttpQ07BSScZtU1OR8juXpjWtWsABm67Hb/m8NxE8hGF+FM6Wxt7Xc+7?=
 =?us-ascii?Q?l1iYsRDGKGUPJkQxjJStCPQHbi1aU4ZObJeYjvDXa3kl3s6YXhq8UDaz+QtD?=
 =?us-ascii?Q?VvKYdD4JIW1AMRIZBf+3nSLr9a1KXigTiF/nioGV98ZafR2OvjynbtTGHRRI?=
 =?us-ascii?Q?lD/cw3frBxBSa1BOdWXkO+TygzopyfeRL+7rmUG2KdzSPhI/lanbtEb5cui8?=
 =?us-ascii?Q?vGH1XJnCDhw3+cysNrWReMmr4MSip0zfD8x3AnNsPNcMO8u0uQjN5uHeUpC9?=
 =?us-ascii?Q?p8z/xh3pI8Nv4uqt2FEwcserfbL1tsLcYAqdvV6f1yh8b72ucgRlzp22mO9i?=
 =?us-ascii?Q?iRJHyzWpmDaYVlAcRHX6n2TTb9oqv60Cp5PzkBPY80Oj7NmQt24xxz9eQxSr?=
 =?us-ascii?Q?SwchHaxTxU5jNrOQ0NMbfRUEVYY+0EDtxp+cA4LLyuH45DOTvdvVU4nQws0t?=
 =?us-ascii?Q?J1t75Qsg3qBQ8qj+kQr0xl2nQ/Ivb/XXWiD0A3GDD6lFQC8mTpWNCcOeBZwC?=
 =?us-ascii?Q?7dpvVAoKxSHTRmuwDPL6kVnr0sufBPakM0Y50QLq2ftCyJLstSqyUO5QrqWl?=
 =?us-ascii?Q?AZWGHFEkFsC5S15F/cVGOIX+xdw8Kpd7u/83nqKYLGObhbby/19rjE7kQdOo?=
 =?us-ascii?Q?0QTYLRZHMAmoBV49Gzr+WLwjYNWKtYlS06GoSwmZhYPIMKXPozfvtyeJJifb?=
 =?us-ascii?Q?HWaInvjp6bP67I3Bt60V32qSkXc2F/HRj0r59IyBhzfLHI48WN6QZV2l6UAZ?=
 =?us-ascii?Q?8Lz54boTM5JwyB6V3ASB5IeiIMXhIICmD/wWHa2XCUEJjlHTen2dlyb/io5r?=
 =?us-ascii?Q?wvlnHylTUGUz8dpax87ku5aoglBSuyFj5l/t5oFcmJFzBQRJcgWUFa1/bogy?=
 =?us-ascii?Q?/lVvRDDCXYWkgMypRXALN7JVPFQHWHtbyhOE9xXeuOWmj+PGr8XPS/OtHrDr?=
 =?us-ascii?Q?wc96BWleUa/ALeN8oRkmohdT4qs2YO+RNH0ZCb8BINKoO/hmXpUsHABBnnG8?=
 =?us-ascii?Q?cjFsGIsrV28ZOaKwv67+hpfiCZmDPMHVM3jax0nDvd2UZFtdePKk0AiyOyMJ?=
 =?us-ascii?Q?pzQConbOLYXj8d1QRYC0tUwUDrkIHjdLZupiD6OOSCD80OoE+Tnkk6d0s5GM?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44183e7b-3ab7-450c-91b5-08ddca940663
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:25:27.4218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkcGvM5fHXirw7p99V5LYv0yO60br3fXxIcbYYV5ZXhSpWwm6V6ud5Gbnl6MHcYqhjKqVIhn/dtCdznTEbrWlPecFSzhWFdrHikDgjGl9To=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1433

Store additional device information; EAN (product number), serial_number
and hardware revision.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h       | 3 +++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 6 +++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 6 +++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index a36d86494113..35c2cf3d4486 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -111,7 +111,10 @@ struct kvaser_usb {
 	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
 	struct usb_anchor rx_submitted;
 
+	u32 ean[2];
+	u32 serial_number;
 	struct kvaser_usb_fw_version fw_version;
+	u8 hw_revision;
 	unsigned int nchannels;
 	/* @max_tx_urbs: Firmware-reported maximum number of outstanding,
 	 * not yet ACKed, transmissions on this device. This value is
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 4107b39e396b..a8930bf933a7 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -114,7 +114,7 @@ struct kvaser_cmd_card_info {
 	__le32 clock_res;
 	__le32 mfg_date;
 	__le32 ean[2];
-	u8 hw_version;
+	u8 hw_revision;
 	u8 usb_mode;
 	u8 hw_type;
 	u8 reserved0;
@@ -1918,6 +1918,10 @@ static int kvaser_usb_hydra_get_card_info(struct kvaser_usb *dev)
 	err = kvaser_usb_hydra_wait_cmd(dev, CMD_GET_CARD_INFO_RESP, &cmd);
 	if (err)
 		return err;
+	dev->ean[1] = le32_to_cpu(cmd.card_info.ean[1]);
+	dev->ean[0] = le32_to_cpu(cmd.card_info.ean[0]);
+	dev->serial_number = le32_to_cpu(cmd.card_info.serial_number);
+	dev->hw_revision = cmd.card_info.hw_revision;
 
 	dev->nchannels = cmd.card_info.nchannels;
 	if (dev->nchannels > KVASER_USB_MAX_NET_DEVICES)
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index b4f5d4fba630..c29828a94ad0 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -138,7 +138,7 @@ struct kvaser_cmd_cardinfo {
 	__le32 padding0;
 	__le32 clock_resolution;
 	__le32 mfgdate;
-	u8 ean[8];
+	__le32 ean[2];
 	u8 hw_revision;
 	union {
 		struct {
@@ -854,6 +854,10 @@ static int kvaser_usb_leaf_get_card_info(struct kvaser_usb *dev)
 	    (dev->driver_info->family == KVASER_USBCAN &&
 	     dev->nchannels > MAX_USBCAN_NET_DEVICES))
 		return -EINVAL;
+	dev->ean[1] = le32_to_cpu(cmd.u.cardinfo.ean[1]);
+	dev->ean[0] = le32_to_cpu(cmd.u.cardinfo.ean[0]);
+	dev->serial_number = le32_to_cpu(cmd.u.cardinfo.serial_number);
+	dev->hw_revision = cmd.u.cardinfo.hw_revision;
 
 	return 0;
 }
-- 
2.49.0


