Return-Path: <linux-can+bounces-4102-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3990B10628
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 11:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B84D37B0D64
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27674285CAA;
	Thu, 24 Jul 2025 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="FrmAAB9x"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2104.outbound.protection.outlook.com [40.107.105.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6006D285C86;
	Thu, 24 Jul 2025 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349136; cv=fail; b=QJiJ9CvpPRSMhavb2SqBB67XXYSv4B3Oq1xaWt2Y5fTVOF3ZE8wuRSDJp+W0FyhRuEpqYSiVlUaYEVD8qbIXUek7BWyREybXcuLeBQa1T+gE1LbUqRf2iVffUu/nCSrNehR6ZnZdGyNhbKh4diEf1Utd55RBI0sXqBKgmZkOzMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349136; c=relaxed/simple;
	bh=d0hscrnmNg5HJCMDGpF50aQewLGoip+U64GMDLEa3Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e+RnJVmUDIjDFw3UW4mUUSRwNeLkzxrvJTebAVRL0WiRbSGMIKBBNKXb5/k8xmV+fskMDtccNcLinbsj/aDVYpeyqox/UFPWcmxXWqY45uKFjIkTGd0RRFTwKn7zrGAgcuUVakxUz72kQMTfd+QHLBSqeV6e3l19OpFTaB0S6qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=FrmAAB9x; arc=fail smtp.client-ip=40.107.105.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDrtP+QypqhfANRPzU5bt+y6s9uqjL764lhfbfkvkGm+BHrlJJ6DPf6CLYBF3j+yoDCLb+CUQsk/Wo2vNQ9Qh2K5oRAb4syZItMbz0Pq/I2nqKb3aj7kYvHqiYiQFqCNTgeSTBNs8Fcy6NKb9hgBYlIXRSbqImj8ip4J25qO9u/Xsmz2HUFtfXpLyJIhhO4pqF9DNbwvwiA6D+e4ptUt3AjnQbBf6+JNDB1R5rxhGGFiRSEEUpARllu7AbsDEqInIHAMMRyMZkNimwunjfHAuvDzS2U5nOGEBVsphhCA27Z43+jhD5edBwrgwQnXM8S2QSKKeUAmhyuWpYvoYEeFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5lpTmzZpMnvXz5jf071H+izkfvT8s48pocdIFkO00o=;
 b=hAvQj+HNijeMuzH6ZXIBDjngj8j5eucCpBSYbhC1bIOunwNQPuwZ9YtPAcUnnxQM/Vw+M7tJ/OztREt6nwDeoNbT6WnyaZ/+JwlLxFtUSjmouww2uQLQzaKG7XWyRIm/pkf2F19HdGGMNXKH5bW4BW6x8EYn4exe+85oF0u3rz/ZpKNM4hZhj8D3/UnOKb8M4g4N3puityIQi+97BIDQ7St4SL+6ukXyqqW/e7h9AEmuCT8wTzViiQG/UcoQ7T4gqtFD9+iC6iG+0wxg4AtuVC6gL3Ddbiwgj3Qnc+aofbN+B8zeUQ0Jdun90ngZBCYtNZHIYGXyxMvNYl+xqJ/HOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5lpTmzZpMnvXz5jf071H+izkfvT8s48pocdIFkO00o=;
 b=FrmAAB9xQuPo7o345F0HQHf996bxKDonHltTcxdaITW/oq+lvh9sTfu1rBY6D/q4YvLL7ckToFgqZr0KH0phbIICS7RbBWnXyTE/6a1f2rmg4kitEpGVdg7VzekudZgLxNcvWXCV3ozB6LOXAYyCCPxoLL3haJSroA8TtFpJ7zA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB9P193MB1433.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 09:25:24 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 09:25:24 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 03/11] can: kvaser_usb: Assign netdev.dev_port based on device channel index
Date: Thu, 24 Jul 2025 11:24:57 +0200
Message-ID: <20250724092505.8-4-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0cb720d2-5144-4e8b-5e7b-08ddca9404dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8n/UeMLQpdI/+ZPWGSYyheTXApt3FikHkODaGhldGH6zXAq2l4rMQ02C3zgI?=
 =?us-ascii?Q?dux4dlYWpqJlt03qiUQ0kXfUDvFfA8SkbsPaoPPoyj8riSqivdmaC1e1IkuY?=
 =?us-ascii?Q?OAgDIODGCjYCyryNciPWtnCbGeQ7Xn8qiKloV48rMixGeWJQHrTEga3+ytTR?=
 =?us-ascii?Q?GeZxUvFEgUhwe5Lr0UQuZkycGZzPzl5p+tPagITwgxaskfVkGgdzhkFCudi/?=
 =?us-ascii?Q?scuZCb/NIELVXQnwyLdfHr+BfyVyxBJPRkNLFWsOOFVckDwFZXYyrqADn2Wm?=
 =?us-ascii?Q?Oa4/lO14QVcidqmDtO9hoUJsroflZ9e0f/vHgPmDhwZJATWZkpcGPpBYp4Bq?=
 =?us-ascii?Q?+AVRXiwc2+OX1zjV3LziP1LBFH5o7drPe5t4JHT2LP1i7DLTOfKZx1MYv9Ks?=
 =?us-ascii?Q?X/yhx2RGoIydLTEiMg9AdjA05278DxavMRCuUpKJlkoqQxA5QylOCAQv8VNU?=
 =?us-ascii?Q?kx748XkXcDB9fjHjtu0cY7PXxbCgq2vSYT3nPID1+ZlZyqwr8DtrL9gkCiC2?=
 =?us-ascii?Q?sYex9UN93/NLoLoGCL8XqM/VKhsQXcJ9vfxrWIZLIBFLmXIaWQXaPhJcSA+P?=
 =?us-ascii?Q?jmMz+PKDXlvkKQvGoykDp/WtGdXoefOHS7n0JrI00hF+HuCFVNf4aezUX2a3?=
 =?us-ascii?Q?X04SljjLEsHipJu6u+cmaDtsknMQEQljHOLpo512neJ5r0VWF7SRsdJFDiRH?=
 =?us-ascii?Q?9YQH4j/OGcJaPjfakvgrEnUFXhYsnixOKk75Zp67OO58yPIgDksohdz4+CQS?=
 =?us-ascii?Q?0P+PqWs4/SXFiqB0FU257xLCn0i5RtWBe21voLgwAFaUQG3lwZEZ7aDo7pWF?=
 =?us-ascii?Q?zpZlkjWOhlunkXU9KAVMiFP2soNqKzcYlIVQR6Y/pnv2aSwRqQhzDSVyT5DQ?=
 =?us-ascii?Q?ae4YqS7yOE9btXWzLkY+xJqyDPcDYxo01wKLL57frn4ZhEZYHetAd8FEpONh?=
 =?us-ascii?Q?xnL6oGd0OzJ6I1XhRhiR1AnVNQ30lDojbqK27CBswsVUbhu0pswiZ3Ya5/dQ?=
 =?us-ascii?Q?Nf0nhMLKM8em2VXaCbB7f5TjbxXHA9UgNB3MfCm7Zzkl3vZJgCUgMX/kannf?=
 =?us-ascii?Q?bcy388fU1Z77DLCbiOVOVhk/qoAL/A2hbL805W8nMJ7WOiBWIQ7WhHjUllxb?=
 =?us-ascii?Q?RAlOmtCGmxbDws9pA4s4HrsI687u3/ALx6l7SWYlGzxd4F7K+Ufup0/s2t78?=
 =?us-ascii?Q?VH6HoGxoNeS4Q2k2PxqS86VVIc2nRdb0Ljdq2+yEn8IDLY80nOGIr4vhIVNI?=
 =?us-ascii?Q?Z+HsqRjckCa66Rgb9Y/YS3nJhRtGU1+b00NNH+m0rDUOCWzTAHAlwamLkN7E?=
 =?us-ascii?Q?+v2p1L2RRk1zDW80hO31hyo6OGJKTtX9LDXV8HlLgKhXSydHV0CIP5os1hgH?=
 =?us-ascii?Q?tfYDIUIoSs9mzZ/ckeqDZ72+ahM403OxICINTezHLdFTf8uV/lulth27+f0Y?=
 =?us-ascii?Q?ybHlfvuJ8G0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?16xOs8ahAeBdWrNOEvpHgLQZXBXX6JYIQ1uyh0bsGuEV+8cHBF9YpbJQM5At?=
 =?us-ascii?Q?tE2OZp5syvHuMt0428HCWoCIE5wU/JyLRyMpwuwBWNEpDoNB6/Wp7f8M92fJ?=
 =?us-ascii?Q?JeEDUBX3sFHVIA512gquP3MLk3B3tNEpz6JqDfFL0XYe/CAf14VblU2uM7Wp?=
 =?us-ascii?Q?voehzhh/7nsoSfoX5WMx1NA2CxOQajs7GGzLYloQzsXRI1iVDq6tYRuq3Nj0?=
 =?us-ascii?Q?m7tx+A04LGCikVNB69FvukC3YAfctJ8OrVRwsQ8JQ+Piidyt7GhTSoB8umVc?=
 =?us-ascii?Q?L5CNz6+ww8j+jH6M/ucDcMJfkffyptO7y85G9H3YOWoM8GVPvSH9sU4h1Br0?=
 =?us-ascii?Q?v06fD/5wuaDJrgmaupfxa97/qZXKJpClcBE0BWpCzCEhfZGfq+vXQ4Xw3AIq?=
 =?us-ascii?Q?aVRVcS+1TcXhLz/dF0/8k2W7S6rUzpqrMQVZxeo+4o2A5gk24qP84k8Fqzu4?=
 =?us-ascii?Q?e9Ld+dlARIWig3iGMgPVK0o0evngqbciLK1o/zZGGcSMV4QoodV190TnoIs8?=
 =?us-ascii?Q?lxJ8tQq3Xy/HFYBLyFV83nJfAdscAHzBLFiV+ggYtyL6xHHVLnqbhrhTVCCm?=
 =?us-ascii?Q?mLvqsCdAhIriAyG6ypARrtNeXXnG74c1BXugjBpMl5x3w2qsf2U0XW74F/nq?=
 =?us-ascii?Q?0z/kyi50fvtAw6JPodjnDNJ/FXn27Uz9u9/cdO/ZO7tAzPveyl4x4545Qyvj?=
 =?us-ascii?Q?VMzGxMvPRln9jPABmIjFhD5PsuJ0grCI8zYBhyIdeVW8T737xDdXl83WIjJd?=
 =?us-ascii?Q?M+NBvMkq7eqv4aBDmgLQ8lpRQ5bE82+UbeeI7jhjZpQBtwQM2fZydKRikWCG?=
 =?us-ascii?Q?N7OOE2t1rg7wBa2FhneEYz1n1AM5r/N4efqWetAJKqkyWNXdbNJ6y6+HKnUl?=
 =?us-ascii?Q?Oiig/rkGaNxkyKVP4qQjt/b86xucv1UrNJxOv62CATx2uy3Ev93AkZKLR9x3?=
 =?us-ascii?Q?8hg+jKQqHjzISUq7WxE4zWi3ekcXOrM4YCasMDh/rW3XIJ3W4jEFpicJqwSa?=
 =?us-ascii?Q?mbb3eNliIAtlqJi3Rfq88YVgz72hbzjtHi0zLiMPiJWiJ2J9Qo4x2wzvFGQ1?=
 =?us-ascii?Q?3Ot77DiO/By17s2V9xhipWVfAZ7kkBtJDtKfEIyGkI6AdvelDHEOdgNpacbx?=
 =?us-ascii?Q?t78LdqIo/oBLL0bh9Xyosh+K4uODFcqJIuZzLcQ8a0zeJiYScJLcibQV7exT?=
 =?us-ascii?Q?ERhKOE4+pRrisj76Q+/jHuaKbz2uwQ0rEOOg//+YNvmI7J/p5U/8vVdOFBDl?=
 =?us-ascii?Q?nEZgWlzARtP9NIW5gBxam/BKNE2pYfXTkHHEbRlkvcDgiOnTihzqKCxm84CK?=
 =?us-ascii?Q?jPd8Z2qgLNJOB/6yf6vt2o5mvx41TLv7oeCwGv9gbjZfE0Oic3UDEdsM47Ke?=
 =?us-ascii?Q?RLFbjBVn3bSjOqOfS+esCubFi1avpqks3nUBhxoRRzJvk7YmbSjhZr7YRIoY?=
 =?us-ascii?Q?RId5vQKk6i0zDUOi0dxhNsQ+xNvqC7SrNeigHONTgYGnvzkuSsj821irLXJN?=
 =?us-ascii?Q?E6bkiphy9DmLjpA3IycUNSWNpBNoFl8tkhSN1g1bS3EGvcPml5D6U3hM5IyD?=
 =?us-ascii?Q?wqMoNNtYy1p9+pDH3I8cmTveZtr0xKYKffDqAr9Y7vSXUjKNOYiB5roOlJCJ?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb720d2-5144-4e8b-5e7b-08ddca9404dc
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:25:24.4277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIZ+jtb0l3JZl3ew0lFsvBgGIuHBuGFuT3g2IJlwDVOaXhOQXUo+3RtX2VBZrpXD5LdKflo5A/gV4f7bvYfo1VVrw4bubP28+JZIoOoHIbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1433

Assign netdev.dev_port based on the device channel index, to indicate the
port number of the network device.
While this driver already uses netdev.dev_id for that purpose, dev_port is
more appropriate. However, retain dev_id to avoid potential regressions.

Fixes: 3e66d0138c05 ("can: populate netdev::dev_id for udev discrimination")
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index c74875f978c4..7be8604bf760 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -878,6 +878,7 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	netdev->ethtool_ops = &kvaser_usb_ethtool_ops;
 	SET_NETDEV_DEV(netdev, &dev->intf->dev);
 	netdev->dev_id = channel;
+	netdev->dev_port = channel;
 
 	dev->nets[channel] = priv;
 
-- 
2.49.0


