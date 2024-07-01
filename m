Return-Path: <linux-can+bounces-919-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BED191E493
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 17:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FFE1F21E4B
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C5316D4C0;
	Mon,  1 Jul 2024 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="iyJ3WPI6"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2128.outbound.protection.outlook.com [40.107.105.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2D816D334
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849005; cv=fail; b=obcrzxtKo9jbvr9DAZBGJC4hc1ObnCuozyMgXMUxRRUUZWbdsaGuvxTrnV+aazi87p/EZeGe+B1fPGP1qtBjb/byiG/XNIaphqT9KnACuj2g1sWI5Nb2Wzi7tJKTtTcYtVADW/euG40MY1rRIIpBPK2Rw6i0T1SQ8iS3g+/P4Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849005; c=relaxed/simple;
	bh=0eAGNCg0ah4VqGqqBtKi1Agv260rMRsXo4qb2mdukFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kB6fd33YsBVHpbKziLZnxoXvSmY89SvIzNQqdd0XM4H+9toJKJiH0h+tKtNG5oRCTrIa1lW3+unPlAHR6wXQrASFl44oxbG0AgzfpjbBSfrrTRrF4oz8iInTV9AbCyHnPqcqeBUxv5NXYfUZwrzNcshfk4kEosTQ0MdMeC87zIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=iyJ3WPI6; arc=fail smtp.client-ip=40.107.105.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9E28rs1s3Gyw750akPlmayC4X35OjzQFUcOBjTPESix1fVK+ZUqfLGUunrFyHeLysCruFxGWAGBRzu2PtIlXe8XbT0I9sKsoiu2Zy/a4xK1cHL7d1vNuDrBSedHQQao/5hDl5uOXNOlV2WiWYVM9aH9icSi0mkWG29/4AFrDMwIb4iU3HLwfUcuW1ajkUPxkub2tcpFcNqNs+wl+l2BnVXR+JOR6DlyOQmg4ele9AY3RpudyOsVk7lgENfvy3PWmZXJw7P5V4Gw1LVlLcWwhJenI9z9OegsAigixCXnTaHDEPYX8zZgGBrgLEQQBJJe7G/GXYZDTu19w6LK/IDPLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlbazvBQS7EnAHWuLFl589lKffy2UZPLPKeQc3KbUXU=;
 b=fDbeNvP+IdKmCAJR3kBNH+Edk1ViBkKxABEOkGnuHk3v7DZPhhIjxbonuAXQol9lABKKcc5hSOV1u049Bxyo4L7J5AjD7CWQMLOc/VhiWpGSg/Qsypk+Nnl2LuvI6SAiKKkgLognsqAxhFNpXuMI/p7MhU29zuXCz7L7Zhw5K+nNjnYiPqS38XMmGATsRTIQEPRHtSMFiMpNZ6831zDqkyNKhVt04Pz15fnBiEhA/2ItmQt7cADihsXKxoLsDnMjvhsHYVEn5fYxQtewUJWznsvGmG3QuU8x9GYterZK/dctRR95Lqxuqua7j0F4Adb/VKmDS+ezsmQvKhA/v/b+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlbazvBQS7EnAHWuLFl589lKffy2UZPLPKeQc3KbUXU=;
 b=iyJ3WPI6gtAkIzZQpR73P+8loolO2KPzXgHgLdfgyfXbBciV20nQ4mvixv9f9V9SGC1P0i3Yy0FQUm+Ap7wOv0hNbHhCBKhLHZWldg1a9LEP/B4liwisqI/Kp/xznS4aohn6g7o83PcrdUHrbH8Rv9XCOE1lLRlNWFNJg+EGEk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0519.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:49:59 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 15:49:59 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v2 02/15] can: kvaser_usb: hydra: kvaser_usb_hydra_ktime_from_rx_cmd: Drop {rx_} in function name
Date: Mon,  1 Jul 2024 17:49:23 +0200
Message-ID: <20240701154936.92633-3-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: ccb7c863-b898-4a13-6c90-08dc99e57658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?77C2ySoY9O5am9nCZY8FU34LzIFM6WtMlEW+kZvYbiFumG01+kVf8DmgZYkF?=
 =?us-ascii?Q?eyGHOzDHnW58lSSSsAN5uH+NpTaE5UdeFSvxADW8vIP081IdIS6vlC1yIuFs?=
 =?us-ascii?Q?ECZ/kLfOA83JVTDeYle09Ygd2kH+3telJ/HE0Ynl3MOz6WjINI8ygAVPq7Mr?=
 =?us-ascii?Q?Xb7vZDEaAT8Z1zsmSYRN++v5wyFZ6k5zvAMuhvU3TONUjniHaGyDrb1LO++y?=
 =?us-ascii?Q?yPnImeMpHmWqUH40yK70ZuuBQmZ5Fe+MIdxfFW4tnWzpeKJs9RTot0y7DWJN?=
 =?us-ascii?Q?Io1UlblUYTUF0v2gLYbnVWjA/jOymmlhvtZweL9UdIMir5DoPT8xD3irCei4?=
 =?us-ascii?Q?3k56IS9WqYY++0C1OkFhfRZqpUPpdTIDuImO9MEd3+CHbpdDFfLGAu3hhShA?=
 =?us-ascii?Q?K2Q5ipgoWYA3yGAPIj09DKIze3qlVUgZDWDnuZvsDhpT3ZcBgAGylrCwDH5t?=
 =?us-ascii?Q?YbSJuyhsF2v3XRyFPTueKj7BXTLr1SAtM2p07h+Crm5v9F2Oo1+QO9h0JURi?=
 =?us-ascii?Q?vERQYWW4E+3X9aqwSUJa9zLLLsFZmR+kz0FHqXR63ZQUIxoME6PP4PYAlP41?=
 =?us-ascii?Q?poIrl9NtkVHbTVzOffapzaVJChkhdBGKS/bH7Ksj5umFuNEAuHZfds7tcX7q?=
 =?us-ascii?Q?Ff4vE9LRd/pcnBfJJP2AdcNrN0paXqKngqDYfRC9QmFPfW0tJ18KJZu7ANt8?=
 =?us-ascii?Q?+QLdNplL6NoBFLdzhW0b0J1Kx8Dg8NmoP2LRIGI7wSU7nK/21AxLIWYEqdJB?=
 =?us-ascii?Q?zeDVjQvaKVMcaQQQDFHkSyr4Psb3bDpxv8CO7f7L5TKAGcJigV66DtkPG38l?=
 =?us-ascii?Q?z8kPUo+ScnvhPKVLCdmOK/NpQdE1AnCSdECbMgIPXAFTry9CfButzE4sJ0Al?=
 =?us-ascii?Q?IzS1LoXUKfhczu6vVxTDXlrYf940zu9lGIFBn0UiqK3+5ebW+xXosRPJT1WJ?=
 =?us-ascii?Q?Y4hVbPh02X37vhdSZpKEmpEuiG/uRCSTljB5r33mPiBgrrVOoMtnp0wRxbgs?=
 =?us-ascii?Q?b5xUw8pZcW2lZcKpGcmztaMpFXiGm3AbZc7WmtXXQ7DQVP3x58/ADMS6upbh?=
 =?us-ascii?Q?qSEgEJrBoWqd8nVnclh9trqHW+fllWYcizauRVjR/syiaxbXR1mSuV6dqxdC?=
 =?us-ascii?Q?zHnOSt3ezDD2heiLBB3Cnux7dF7mjeMcuye7/+7+NDLRRuYyGu4sjIQgGVSs?=
 =?us-ascii?Q?DCdmgRxmFbTsdZodksrlYNtmG5Y1cCCR+ub6dS0S9vyay9r7n2iAnhVZcN6V?=
 =?us-ascii?Q?E3zXC4jULsL5T+cFKdpKHwKEsU84FrVY8ftjdCW48876xmfH75xeedK9BK7K?=
 =?us-ascii?Q?a+Xhm8jv/X9IKYf1u5sY5gYO/VGjQ/pmKZNBO+SUL2A94w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6xRXsucZ3HV9oYF8RWJ6G5KQVkPNN9j0wnq2501kNR0YzIRRSsMbZH//ASVf?=
 =?us-ascii?Q?Gktvepvtw7tJ3my1hBGO2NmoyBkyEeP/pZKNeRXOLDgI+BNw5qka5UVwchSE?=
 =?us-ascii?Q?bAm+p+im+ENR+hjh2+aKyjnR3Ar/B1EBFU+V2juMlcJAdKuh3ExnBrsmqlO3?=
 =?us-ascii?Q?iPW/i3eT7a87yoqII3dm70ahWfOK7QQidVzQOlj4fio0wtYLJEBfvSZaJ7ht?=
 =?us-ascii?Q?D8koY2OZG30J9S9xNoTxsZlS/J3XmxCKGk2N59W4sENl9VO/49K6k+bi4vd4?=
 =?us-ascii?Q?Ybh1QODIf/U2LDSf9M5oVPvmGwFK1lIz4fjwyyGVenome6lvm2Q6+c+Ad/V4?=
 =?us-ascii?Q?FLa6XJnYvqv4SBpmg74kIBzC/7Km7M6M0+PEYMJAUkwF8IfNfOlsZtrk0K6D?=
 =?us-ascii?Q?Hat9nak7xTTKU5HxhaqoR17EoxTY4TNvIKI6neUfz1vVGGur5INOs9xDcTsq?=
 =?us-ascii?Q?y2CwlqarOzoAAbBLHD9PVEZw71BSrpzsisPqKL2T7EBUJdZGryYBsRYMkIa/?=
 =?us-ascii?Q?GU4kAAK+WnmgFC8Zcablgc7zxyUUUz/xjkG92FT6IocYMuuOhpfw4TGpfVy2?=
 =?us-ascii?Q?plhJeI+FdV+PdMyKvko/StJg7+ZNS52/KOoXXAV+TkWzJcbr0/xjHPOofgIo?=
 =?us-ascii?Q?7LjiIKd9Omp9th2d77O4q7jaf4+r6xgkE3hyTLGDM3Dht1pV+T1p33SA0/Tn?=
 =?us-ascii?Q?9+iXBr74RBvNLtlLY0gm97hfWY4sGrzxQ8rF1ar1Ytaihm588/5uTzgfqmyc?=
 =?us-ascii?Q?JzE7cJfwNox4iBKazFmlI0oiGN8csS1LbdZ81Ojjak9rra4Dut36svsKmem8?=
 =?us-ascii?Q?OCBYQuQmEZCKhf6fk2KX8kIu86FjI+8tOpANTh9aOk3EFfpFf7WVn+0ocwa8?=
 =?us-ascii?Q?RcO3B30B8eYxqEAer9AMQuPoma99Lqt1WKi9RLWyvxpBeuOREFeP+TMmZ09r?=
 =?us-ascii?Q?tpGdeHWIDzU6X9vw8/ROIc7jnqoI97QoJTNd+MO2vge4laQhkjSkFH0fp0J/?=
 =?us-ascii?Q?wEh1zNZAlc5ACCb4y4+5pZ7QXWdjiLyvN6PCz/jC5EeNeKcStPs96HlGY02+?=
 =?us-ascii?Q?wjPbc9cMa6YnDN6t9VGwt1bYeJp6GENCiPuLaG3H96kL3RcD6dNGieQjtA8P?=
 =?us-ascii?Q?ZM06xc3PZ9bDBUlNDJBVkXB7SXijs/vwXfqOVqxlOTML6D5Wr+CRfLD5pbUv?=
 =?us-ascii?Q?lT0uWuwzzMl8GJ0DLKl6+iKHR57tyVBZoD4Bn/FDZwc+Q+3jyYqH5URYFgCk?=
 =?us-ascii?Q?nWMtX230mUqd8KSZDmo6alO6DihBSvYmo7s7OlzZTvO4JrkiHvecN3gnbXGF?=
 =?us-ascii?Q?Gzw524WPddpaOsz775MmT6fwgZnNsPMQS90jtnGWm5BGIoT4/U1wdYZ7/VVO?=
 =?us-ascii?Q?FtXNjoWTdVJ0pjXXH2pZGRPRlkaq74XVnoOgvWW5iPuSzf4c3erbrZm1MtTP?=
 =?us-ascii?Q?dMmLj94nKEetx4Ni4wxVi7nRQkr76TKWHl1k/vnCNt0PnJWLbnJvtwDQPVTx?=
 =?us-ascii?Q?Byyn0BLy78m+iPmL2NKYKbtqMoK/CLElpDfVoHa5pzMJOq0CUJL3q7ygKSyg?=
 =?us-ascii?Q?xJGgyFdJ88g93y56LcSZXDyCRdDv5Hq64uSagq5G?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb7c863-b898-4a13-6c90-08dc99e57658
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:49:59.3534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LF/ryCAptbzRqUhG7p9s0MScjkgDHaSlShJeG9wPqiP8vinmDFZ58eo4mnWVDETs18kNfzL7L0TnRb19hs8+mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0519

Rename function, since this function will be used for more than just the
rx commands.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - No changes

 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index ad1c6101a0cd..84f1f1f9c107 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -522,9 +522,8 @@ kvaser_usb_hydra_net_priv_from_cmd(const struct kvaser_usb *dev,
 	return priv;
 }
 
-static ktime_t
-kvaser_usb_hydra_ktime_from_rx_cmd(const struct kvaser_usb_dev_cfg *cfg,
-				   const struct kvaser_cmd *cmd)
+static ktime_t kvaser_usb_hydra_ktime_from_cmd(const struct kvaser_usb_dev_cfg *cfg,
+					       const struct kvaser_cmd *cmd)
 {
 	ktime_t hwtstamp = 0;
 
@@ -1232,7 +1231,7 @@ static void kvaser_usb_hydra_rx_msg_std(const struct kvaser_usb *dev,
 	stats = &priv->netdev->stats;
 
 	flags = cmd->rx_can.flags;
-	hwtstamp = kvaser_usb_hydra_ktime_from_rx_cmd(dev->cfg, cmd);
+	hwtstamp = kvaser_usb_hydra_ktime_from_cmd(dev->cfg, cmd);
 
 	if (flags & KVASER_USB_HYDRA_CF_FLAG_ERROR_FRAME) {
 		kvaser_usb_hydra_error_frame(priv, &cmd->rx_can.err_frame_data,
@@ -1300,7 +1299,7 @@ static void kvaser_usb_hydra_rx_msg_ext(const struct kvaser_usb *dev,
 		KVASER_USB_KCAN_DATA_DLC_SHIFT;
 
 	flags = le32_to_cpu(cmd->rx_can.flags);
-	hwtstamp = kvaser_usb_hydra_ktime_from_rx_cmd(dev->cfg, std_cmd);
+	hwtstamp = kvaser_usb_hydra_ktime_from_cmd(dev->cfg, std_cmd);
 
 	if (flags & KVASER_USB_HYDRA_CF_FLAG_ERROR_FRAME) {
 		kvaser_usb_hydra_error_frame(priv, &cmd->rx_can.err_frame_data,
-- 
2.45.2


