Return-Path: <linux-can+bounces-4103-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A90DBB10635
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 11:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B283A8E95
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30C2BE7CB;
	Thu, 24 Jul 2025 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="Myp+mApy"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2132.outbound.protection.outlook.com [40.107.103.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C522BE655;
	Thu, 24 Jul 2025 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349136; cv=fail; b=U5JZrESZeur6S8Jf5ZnA4N93xTEUheLTFfhwflEyLf27dwFo0tbaiQOXuxCBXgAZV1aUGAYLMO2waVaWD6JK2WX+5dCv3mkYH/8j+M+EpcFpaBaBQoPgsFxPizSJdFPewuLQbSsUlZE8X4e+0SBnb+b0QCv8VDsTg9v/BXL9Bs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349136; c=relaxed/simple;
	bh=QrX8oUVcDnioq9cl7AxVWGp90wTRtjq7idQ9AXKvl5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y1GYluaCTvgC5bI92K6E8reKUj+IIW32KP3ugyHO4loONKekWLMfAH1wunDm72S5GLQP0ORGHl1vvWVXGWFNHFgy+QV2Suq5QHJ0jRFtNFlmUhXeEMqN7YxuJY2OFHAQoEN/9768RIfcZzDMpvF+Vr+9+cnw+LnvzpVd1M/VLzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=Myp+mApy; arc=fail smtp.client-ip=40.107.103.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qD2YRwEmhJwtK9320ICGBkFUbo7xXNrBsENnNTel9kZtAcPZpUggsjkNsUPTDY1o96u/qcXw6qak8SzfsUztYZVp+VPv98ijfvbdLiGxd0txzKbqoDbwmNgONzU0230RoW2iEki/05sVck7xE3UzyBTVQ5f6wle9eDlzS+BC4yrFTGCJUYCRweZOLfZyJ3a1gfK5ikiafubtIz+TILHeuXT/bcyCkTwP2AICLSpaviU3BT7PFfQP5zH01v4VBnSyCr8ZCfsomJHLeBFulKKueiM0pm4iCtjmKHn+zp1EHSd6dknrlbw9EDocuZWex/VHEVbWbaAGAmuvTSe1eJHWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBrnOBAjeIsSQ/epACZhjkh+9cQwHvBNvxG+xuMPoqo=;
 b=tiZJ2rVGl5mH8SsAyVVZiZ+N0ZYc9YMjZbtcLH5ou46R8nsnEGg/kOmAeKID6KvGLk1DFLWGqYYx920toksNaXRtkQ1G03jjxFTz/IbwDYotqqg2VZPQ6RsbFO+mwaMNlkDZ5UXMywmK/F6rpu2itLDTJRBzpXv3PJbId+APRdJWgrPImBvEEbVtLQIpR8JK/RHlln8wyOBDGm7RChoT1QPUZmRIyXv60SfzP8TOT5dNASkNQTMLRotEtBE77QxxRmGQO2CSKyxzwP78Z5zcSxQhvXf0mxzHjZQUmT+82Bt2ewKHpUg7qf9xGkrc/KVb7zKvM1nmPi3NQ+I51thc1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBrnOBAjeIsSQ/epACZhjkh+9cQwHvBNvxG+xuMPoqo=;
 b=Myp+mApygJpbmHuRWz/ooPri79X6slYfJCU5ptk0Q2rqLZ1GT0S6R0k8k4RsKyMrW9EoU0WmztXa8tqMDD7h10Z6OcdWtngvJjqNcWO9aWaHhhQUy+TFicN/q3WFMnWs8HQGla/2kKTGlB/p4zUAr8IzvqM4jvnmEmpyW/j+vxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB9P193MB1433.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 09:25:25 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 09:25:25 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 04/11] can: kvaser_usb: Add intermediate variables
Date: Thu, 24 Jul 2025 11:24:58 +0200
Message-ID: <20250724092505.8-5-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 195c985b-9c08-4d2e-01a2-08ddca940532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2jFfMPEX4j5T5zC5mha28oOcwfNj6JEUPCx2rqTMjXScFEDVP452/gwwKoAX?=
 =?us-ascii?Q?JBuoEkfpy4dvSerO2oegAIcZ/w88O6omBxbOFsPfPoDcMI0F5xlCXb+9l2hm?=
 =?us-ascii?Q?qLUzQYCcfivFXeLiX+tOumVPD5++1s3+Ga8Pl54vD+QcDBOqV1PqA72H3fYr?=
 =?us-ascii?Q?G0Edl78EJhw3RPhErU9FvatL48xfjzgsd1i301sudi1Tntsky+KbY5pkv85a?=
 =?us-ascii?Q?ik+iUWW7T4ndscJfGWA7B7ox8WVP72P8ARD+fsMAJPpSEuX3fL0mQLDQGlfl?=
 =?us-ascii?Q?dkUbUn7oOImJWdA/fXzdvMNOH8lZm5TUhaj+VVUY16kf5Z0OOuLTvHtBtdjT?=
 =?us-ascii?Q?o8QVOmpsSVAHwpJpT8qk7WNSc+Ikv6rjCfPGB0s7tEZnHaLvBx351IXQ/jWT?=
 =?us-ascii?Q?tM110Yr6tvnPhAHuspHS1r3aygqQ+Y1eTuwFtemM5F8FSGHkaGyD+bSdtZan?=
 =?us-ascii?Q?KdaAWHPv/KvaWiUd1LgTVFJIp7om9jYUUHk1X3rTrf/QgB0b4mxrawDcGdzv?=
 =?us-ascii?Q?eWGVzIfHPKh7TYiR99DPMGO+bzbQ/cBkAzj9L7tsTVMQh4tL8YirrWIToe9w?=
 =?us-ascii?Q?n/uaw3xfIt82g9trFvYoMlsobX7jY3NW4HUEXFEmrWZ8Pv6BWT/O7R2xy0b4?=
 =?us-ascii?Q?bbKvclKACv9ypY3DBqsZCX0TimJlFII558a9M1BDRd8gZh+cJ3qNclbOPe5K?=
 =?us-ascii?Q?aBWieDjbMpIDaGTaelbdru40umy6OasuOxa7+vo0gFeMXVuxzmEd/4etyxdc?=
 =?us-ascii?Q?Y2XZtL6BDuz9ZBilg3t30rC+1JT73GRq/f7EIRP1P34qk5dZj6vtpHf8c/+2?=
 =?us-ascii?Q?duHVwaMJx7Yv2CysvG1IO9u8WsG6sYg/iLBNDIaZGR2EAD1OTUD9eOqmIhbB?=
 =?us-ascii?Q?El7/aMwvP8fGnw0QY74NpCxCECuzP6iN38ACt0BaM+5eUUOpiSHqZ1LYO/XX?=
 =?us-ascii?Q?xF4r/IKwdRiz8LCEfGBI00hwv0MzpM2HQIktl4DZbyf+l6ZLvVhXnjn9+hNa?=
 =?us-ascii?Q?DKxHxlBr99R5LODnWIJtn18IGiqrZgUdrr+B35psYpyZQXh6ejS/lcGrFbDM?=
 =?us-ascii?Q?b7UfHF2jU1cpADjoT1s9VM/LXjof2ifu1bnBWmfgh1GGQrUNPE4sbY/PcoVZ?=
 =?us-ascii?Q?tAn1JDqLTkXB0WBwFM7i+yRfpTKZG9bZYXVQ1xSIgdMCBK7wwTrHEmTCTNSf?=
 =?us-ascii?Q?Pswex3B3jl3hgmbLsjiDhFAITBzGqDKxXLTcj6RUhV+kyhI/DqTuSnon6mUl?=
 =?us-ascii?Q?5hLv0TiOwQGv1SgL5/W6i1+WHaTv2kBQ06YGB3pOLnm1UBs145Gm1vEn2nXi?=
 =?us-ascii?Q?DUiGdc7oj6WKvlF6LLThmNlKUkCY4S2TCFxRc5+D+Nksp7mndWgM0ddzsDWS?=
 =?us-ascii?Q?R34AT2F7AizKvCJd10ty2YPAikurQLvq4vlYZPYEqCOkdUyQ44EKwXt5crEL?=
 =?us-ascii?Q?DqioK3uHoVM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MxpsdXnTYccV7OsCqsePG72IIx9A5nWNGJPaG7Z8CSyn+vGtvmaz2gp6KzKG?=
 =?us-ascii?Q?soBgzPQw/ss2Uvun4AM71BzB1R0a4Q85EIuGO8LnQKBzJmew+W2GFNbYCqlq?=
 =?us-ascii?Q?IBYnf9DZPDqaz37n/HYgRt42IWWffoUTPftIZ1SxV4WTScmS32hbNP8+ZGYZ?=
 =?us-ascii?Q?FMSDqWKFAVvhtlebTTcj0UTf63Q+Z9vp2Kywy6gk0wTPXC8Bf63Yond+8x8I?=
 =?us-ascii?Q?S3IESQeMOEkqGDAzqMtFgaZ8k/4g8BnEefvUdVAKQpXIaBhQ3zWXsuG7REso?=
 =?us-ascii?Q?VhsLV2Z9OxXKi5KxsHF+43j+GmUi67Y/A5S8iAKDXzWauMhAKNZ7eXV4khb5?=
 =?us-ascii?Q?HELxVnwTdLAdeIl/PbE8XEcy5EvsqlXm2an14Bel+qwdRv28iJA3y1/QlZBI?=
 =?us-ascii?Q?XuDGZqliNX5oMNqiXS6icCxjqG7582wpSpZShxBDuzVg1CnME2i5zwvmou3g?=
 =?us-ascii?Q?hV5+u8fxO8cc0y39VLs59vv4BNXlCfiVrf4tMIRGkIJv+1Hsqhwh39WVqvOp?=
 =?us-ascii?Q?OAk/EH6oDyAD6yJLfJb3s9EULCxUGdrpWDDGJr8Cp9IJSn9KV+u3CyoBgvJP?=
 =?us-ascii?Q?xJHyrde2439KVkfH5oZlEvJmfmft2S4ncLPZOx/y3okQqGqt7POFM7wqpwzs?=
 =?us-ascii?Q?Ts217m6NtqkdnkFRRWlNLRbdPNfZtqSX7EBgwk182ypn69hbDFSu/uRpmqJb?=
 =?us-ascii?Q?WJdzuIVuEYhFzrtCTxKcR35xHPvm07LTsdgyEBP+WEunWzX2noZosop73OGo?=
 =?us-ascii?Q?dmoxRr5A5XIa0jQ86jlU7gy6YVCpSy8hG1tF8+cujvCLxksD0pcdDBsgAQ7R?=
 =?us-ascii?Q?kk1YXVSwzTO3X6O59EzhPFjxzhFloNRns48sFJOM1ElX89dGMBLrLeRY1a5D?=
 =?us-ascii?Q?z4ytMauB8jxczTP3WHqWwsxQdhG7cqAXcEDyibvMBWEG1znfy96IvIwXtgMp?=
 =?us-ascii?Q?RbxSD92Ofsu8QZAtjEkEVCNNnFEr8haU/Wm1bxYKm/7bjfbIs322bvRKLEyO?=
 =?us-ascii?Q?cL3wfDVmSKamdeY7ecxf9yAA3ogQhMoHsQBwbfMUF8uZS61uwxCMa9R/gV1O?=
 =?us-ascii?Q?nDhqiBHkvGaCXHj0S7bs7KcI8ivQSXAQvmPc1kVWLZnInt3s7H/TqWTVVPSR?=
 =?us-ascii?Q?Bbw934NIoCNzCv5tKsIO1NVSbKfAyPNTXQVEOLVXqZxQ3K7vVUTJ9feHtcfq?=
 =?us-ascii?Q?IBijuNttxVzrCU7m7Dds/BKUf533c8dGXYtD/wbfej5h1mB5ZEzx+5vntOfR?=
 =?us-ascii?Q?nSqqdinoRDiuQpHoskxlXbr5LpcNOpp8+MDfQKGiU6DWUIW/yB3e566GwT+G?=
 =?us-ascii?Q?WN+rVAMv1qubNFpaFGEMacsbztb0HN2UkIYagCtmS5QcoOhpt+pJ17WEyE0Z?=
 =?us-ascii?Q?gY4qVEhlk2j7ObRjatyqhbbUHJBIoKVleS3Sb7/1ei+oVY9UXZmHpq2v9qnn?=
 =?us-ascii?Q?QFf8CJ8LP7k3fL4v7TbxxjBqOcDZ8egGTfppWiRtSDgm+qDmkInops0Y5HSi?=
 =?us-ascii?Q?gUvsfsPt/gPzNf3FAdO2cCutJYxjJpUoZaeQvvHWwVHp50Ot8g0FrwvzsxEX?=
 =?us-ascii?Q?kGQRux7sbTWD5R66OO8SBZm1YujcpaEyCmeppO9rIHfQVzcos7UvY44yi1uv?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195c985b-9c08-4d2e-01a2-08ddca940532
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:25:25.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Vbt4Kg6VGvnXXIEoD3qG0/SAtSl4uDtp/ZlmLC9e7gRFmFku52CnLxiU4hGAGKYnZlR/yOIisEmou2w6UYF6OePOVSytyueNQtjp8DK80w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1433

Add intermediate variables, for readability and to simplify future patches.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 7be8604bf760..46e6cda0bf8d 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -364,10 +364,13 @@ static void kvaser_usb_read_bulk_callback(struct urb *urb)
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err == -ENODEV) {
 		for (i = 0; i < dev->nchannels; i++) {
-			if (!dev->nets[i])
+			struct kvaser_usb_net_priv *priv;
+
+			priv = dev->nets[i];
+			if (!priv)
 				continue;
 
-			netif_device_detach(dev->nets[i]->netdev);
+			netif_device_detach(priv->netdev);
 		}
 	} else if (err) {
 		dev_err(&dev->intf->dev,
@@ -795,24 +798,27 @@ static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
 {
 	const struct kvaser_usb_dev_ops *ops = dev->driver_info->ops;
 	int i;
+	struct kvaser_usb_net_priv *priv;
 
 	for (i = 0; i < dev->nchannels; i++) {
-		if (!dev->nets[i])
+		priv = dev->nets[i];
+		if (!priv)
 			continue;
 
-		unregister_candev(dev->nets[i]->netdev);
+		unregister_candev(priv->netdev);
 	}
 
 	kvaser_usb_unlink_all_urbs(dev);
 
 	for (i = 0; i < dev->nchannels; i++) {
-		if (!dev->nets[i])
+		priv = dev->nets[i];
+		if (!priv)
 			continue;
 
 		if (ops->dev_remove_channel)
-			ops->dev_remove_channel(dev->nets[i]);
+			ops->dev_remove_channel(priv);
 
-		free_candev(dev->nets[i]->netdev);
+		free_candev(priv->netdev);
 	}
 }
 
-- 
2.49.0


