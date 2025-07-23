Return-Path: <linux-can+bounces-4048-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41654B0ED5A
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34493BBFB8
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0E22E3713;
	Wed, 23 Jul 2025 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="Jsrfdjb1"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2106.outbound.protection.outlook.com [40.107.103.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C67127CCE0
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259741; cv=fail; b=fslsDSys1QxOQqrRJw/pML+iftcQQLLoMtSMj4fqJc94f3yCjuGG9NGxzJ1dND7rAvemAweGHRvusXyX4IxVBjbOhybPE08fr7vyaPG8TJzByhqCrGpGS2kkyjaFBpl55Bg/Ot982DGehXO1znDrjNAj4AO3kNkP4qNiUI07v0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259741; c=relaxed/simple;
	bh=+aMHaiE1Qvm/Guptc1l7LePV5NYeuIrCzYj46mjQ4h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gH1vOY2+B8rDa4zgmbzNUOLBn6cAQX6vJiPjYoFwi8ujrgPF79+C8kBe4FbzUk/qAeHfZUqm+7Lq2+OhCiMvEbVupiMdpsbZ3PnosK48hgHYsQI90Nupi3dv/pjLH5nQIJUTBMtdpoZ5HcSCe0AeNeRpyFCmgdtKtS5K3U66NIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=Jsrfdjb1; arc=fail smtp.client-ip=40.107.103.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaDDd72T3LAgFitY7nQ2S5O+dpwJovMv6ULWybRjmnqUxDm6DyaZRD62WrpQw3rmT1FK5Vj27k7PH09ZQe2V/DW8dk5t+NMTTeBzTahSc3q4vzXapjIGiphtCcmQa8MOUs+/VBGIPR978tcodrRH4oeBYKuEoJBWOY1nFmcSOdmbrsxi0yw7jDPBSvOy3aBqJGyJ+LeGK9XK1OdS5wcJveEU8XFRLeDNS03nuagQfVFNyTtfD65SlD6sh/y1cTaYxl4482jQsPU/0kADnwxXtkwfuZCfIUloY639HvZtVYGGWTvzDpsqqnM2CHAJJWA5/wZDe0UaDAr8QQvzqiKE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKqc+yPQiCebBuQDwNOu01Baw42McyUSluHwTEhQJFY=;
 b=STGjMVF7BHVzvuBKMLRTfjqyKP5eAeUIcpuc4gQuopskPpcx/3p5QNNrIkXR53jtH8UvFdBn5l1fEM5sAIe00xhMxOpFw/EIZwP/vXWjj8ALHQdz4LJdM2fSgnTx2IEeoKPeNxRdF8n2Z/lJe2Yo1meOZeae7wCDGx8h5y023sqbLFkAJmFEpJhPPDDvr5d2s2ZpvogMPudrQDpE7G79umlkP2zzxwIOMnpbbYHkVlR+wRgk9f7arbSb38MzbzMUVVqpNxTxNpTrP41GVuFJ4NhqReclYwoi8i06UhC+bwSPOuUn58RrJpBT+1oL9o+ZhiGPkkK/HEeRUbB0RR3HIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKqc+yPQiCebBuQDwNOu01Baw42McyUSluHwTEhQJFY=;
 b=Jsrfdjb1X8m8v7fiPqBxUFYfnBGw5LxNKWcvarSBL1m9CVG6THGMZJP6XVEMmP8vz8ghBMJ4olqdAzSVnYMbknglYmb029lQAspFvYWWLsOQWLb+aqpGbdprC05P0qIUt1/97UncIz7akFbHUa91Arni4/1PYzSl4GmCLk8+S48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DU2P193MB2018.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:35:32 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:35:32 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 3/9] can: kvaser_usb: Add intermediate variables
Date: Wed, 23 Jul 2025 10:35:02 +0200
Message-ID: <20250723083508.40-4-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 28e226a4-289e-4a9f-c3e1-08ddc9c3e2b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f38iqtzOIglkzaT6vjKHXMx2NVV9dvaRM1CjrTbIoih3txw4+C56hBU250T4?=
 =?us-ascii?Q?JoC9Mnw/BP6mQ4OXqN/5gEji83V85KDN+bVnDF0m1gL+C5/Vu3iXrinGx55s?=
 =?us-ascii?Q?VLQGyqXH+5bALKxCzn+nrs7fGBY2ERKfWpwOq7y46FP4XNXlUyIDc0WJgV85?=
 =?us-ascii?Q?tZsdVJzJuWr9rxAynBU+vGmJD6Vr1ZjNQBU0o4NZtlNtFJN0H02pfFIlw7q6?=
 =?us-ascii?Q?pETJfREEH/5Y/XD2Jn3BRu2y1cB4sfFeF5PwdMaTnZvpI+EdyjcLgclrKWHK?=
 =?us-ascii?Q?21+lLxFi7mTmQ8h+IB8KxCfJocYDRPzMbikzFHuC6E9XoU2BZUO+AwMVxEj+?=
 =?us-ascii?Q?ZRmcbbu8y77YYQs2rGnycvKQX0aTjVie2DYEobUzLujtZXYzRriQWkUGhx0S?=
 =?us-ascii?Q?+xx9NllBYhUNFnAaibCj7Fd+6H8KtZ9Nm94+D/kOFCqf93/586C6K4PdCyrw?=
 =?us-ascii?Q?Gp5PW/qAj5Q85GkcAp8PeAnk8wNZK8m9xBG3jKfwzynnSS/vSjXH9M4zlabq?=
 =?us-ascii?Q?i9TsmNyWHgCAxpICoAGAGWRXQY16rXiuKjGmkHmHWo0yridYQpJDN887eE0C?=
 =?us-ascii?Q?ZVUKWW68kdhQDqg9byC+EuzGVlM0I5gW03YmAYI11jQDxBpCgEn4ZYxOy7LK?=
 =?us-ascii?Q?s8wEBaxKbMaq7cVt+3MhjuNP8DDT0bLmMPMb1J0r3eXRKNEsUpfuQGCcLGg5?=
 =?us-ascii?Q?ZUO4qBW9s/Zgmw+by3pimYhBr4ak8Xlq52Q9Ojst/G9zP9e9WyY45CIXRFPG?=
 =?us-ascii?Q?LG6Uq4tBaBrpbNxCLdT6qwqIhWXPBonloiJ5k/Se6W2nytq7fZRoxmUD+mf9?=
 =?us-ascii?Q?OQN68ydO/2INzYaQZxYy7LvMte1HlVNhyOwpiucz+GG6YdXiqa4h0/rl6W9x?=
 =?us-ascii?Q?uztaH0J+OkD9weybC8qnA7gTzbh0JoIG1pWK5BSzC5Rj6JCg9eX5L0OCSuV1?=
 =?us-ascii?Q?dOYXTDCdu7THjtjI1WXddR9iX4j27sPMhxWZaXQIOLpsx/39VwXyai0lybqE?=
 =?us-ascii?Q?ksSYiexTbVPFKmtoz1UPyc05TEjk0rl/SKubJ0PWdgvRdFIQht3E1YhbNea7?=
 =?us-ascii?Q?TDcL8IIHQ/F0H5WeQcNGLhENau+i+ezyv+BsUaBrm1xGFBKATKegJiPd9k7Z?=
 =?us-ascii?Q?5/RiMWTxdR42S9/969ah2Vu4JZdVcL/u4fmCYHxtHHiRUgo0j8gK/rL2cheN?=
 =?us-ascii?Q?pZtSd8UENv8Ua7j+OhZVPd4EgDskKSxcALXqC6nQcphIkDJ3APapwFIjAbXi?=
 =?us-ascii?Q?tFv8C5aLkejFYM0+ocb6I95ZOSp1Q/mwNpcSGVm4cfvirrUHbjawNEsvDSfu?=
 =?us-ascii?Q?QPLdQhO2I7Rj7rnU2nzV4x8k1LLIrB7EsuE74SOmwIv3HBQ03jPxXmuDJuZ3?=
 =?us-ascii?Q?/jJkLhZ8vXLqUEQks+U5LrC+5UBiG6BfGXhszANDhXvYm8z/88AcXuIv+4fJ?=
 =?us-ascii?Q?BOl9lM4rFCk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m9rNgs4KP3AyYWO51Xi1SInwFf8AzONJxZqW9ha6nttCdhEe9xw/tF7IkZGd?=
 =?us-ascii?Q?ykeQdvseIDWsQze0tMkJr4R+j6BjT/Y2wHh2JtWYOSb3kRTFy2zpIrNLMqmf?=
 =?us-ascii?Q?jy3Cz9F6b8aj/Shv34X2D8JldX8bTU+2nMWgD/eX74gdqm3Mt8ULI07Zj7/n?=
 =?us-ascii?Q?13fJOtoYJ11q+fRlTITY2MiEycU+pV9mAxYDCOZyEzqMZl3Kb51IXr2QwPkS?=
 =?us-ascii?Q?o33yGnkTen6R09rksnNgs23NlgEGPhiVUmGUW8KdG8QkrRVzYiBERykGjuUm?=
 =?us-ascii?Q?k26F6fDKVOEof8vZ1D+9lZcwS7C9YKYqZQbT2MbOFAJxrvVBSPcMsw/57ceP?=
 =?us-ascii?Q?IK/2DvXAp13Olyci//poamBfJ393tkJ43K2cLPD4jB8CN6cXhndrngumsSpp?=
 =?us-ascii?Q?q7VCs5YPcIMPDKsSWysTb2qEXpGrjOt/xzy3JoAqlUdnJKd3JhIRsIKRGEwg?=
 =?us-ascii?Q?y7W8hYf/KGFXkvAI0hfPx9ies1GQ0E69FWif6aeTumdZlU/IKNw1Sf8GM2zE?=
 =?us-ascii?Q?U2Nnwr7iPYmqxh9hMUQCGJG3yPHjf664siI942ttHBGt4LkPg0rM3K7fROUq?=
 =?us-ascii?Q?mEz74Rp6vQRTFe1/m8ZafsK5CLSug4te2HNDbEtIQPNQY4514A8tGKRBssh3?=
 =?us-ascii?Q?92JCWSx5eO7r1w6rpV4RVMq4xGPtor1nM3p1gbMY3MVsacmfHkOw53mSMEWa?=
 =?us-ascii?Q?nwCY80dKUMA0dliuXfeW1vdikuCS46gAFg6IhmzPxPQg/GxC2PLCMLscwr4H?=
 =?us-ascii?Q?lgWb0nVk9Tn0waHMKyTTyhCPpyIFvAXF/NYQG7OR6JafYJjfgb2gE+6gw1A+?=
 =?us-ascii?Q?gOXbtWbiN5oTZAyrHKX8OC+SxKXvaBFX8C5Cr0EWzuMM1IYFGKfjuTUHo420?=
 =?us-ascii?Q?96zhvSaq9P97r68kxJeCoZqqPrHc7lQxJEejMtm7gfOYaT5/bZtt4CmhYLMe?=
 =?us-ascii?Q?T5EGDn9yRzzwsGGBbNqASDXdvbXli+xdudQ1IEA+s4m+FOarmaubzdPCvPix?=
 =?us-ascii?Q?E4FXVlBBWQjbbXeR/sm3ecODRZdiZBIJEwdkWwTs8I7Zdbg63RCNkaYKdHGn?=
 =?us-ascii?Q?P1684ZwGjnLEt6dUKMREle+i6DVUYlv6PLC9ZynrE9HD3TiEDBUrpGLw+n+5?=
 =?us-ascii?Q?9YonCSoisH3RROzqV+vPyX4A+SuFFu3rG/AtXe279D8yl14PRnIrKgvPYCRN?=
 =?us-ascii?Q?wZp+Evgg2mexubUkREsn97243H7wyb13RgVQJfniIYTcOKb0zHIhGifd6eR7?=
 =?us-ascii?Q?G7IX674cAWCFFedTdjeqRUkD2tajIuZcDfp8eZqpD5eHE9y9MKVE77nErnBA?=
 =?us-ascii?Q?3OC2GVmFyPeMCb6V/bETjMauV8BX6C1jT3iJTfelphR4BNAttoQlVjmfQyc3?=
 =?us-ascii?Q?YgbpbUPWQWZmnEtubXsS0t2mo5SmQMSuzBZAs8a1iCfR2zXOXbusa4769UBg?=
 =?us-ascii?Q?6cazzvK93x0Mx4D67LmbRh84IRFqdywR/SI6JjUX0+/cjdyY3B4O1nNm3YLS?=
 =?us-ascii?Q?cfdshfJEnKiYH1RGXQmjVlpxXL1sHgykeGlaBaYDhcXZgN5+Bw6qaqJwuomI?=
 =?us-ascii?Q?KHwkGAkqJMxCsS0LIDbUasNoR7MoO8XdJXdFfsSi8qgfrLCqYh0tkMIsb/Gh?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e226a4-289e-4a9f-c3e1-08ddc9c3e2b7
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:35:31.8671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyLeznh6RsQMPbU+vqoNOIa8WKqQDbz3uvsDmwg+fQac01BGCZ4zbASaNgpoxyvWrsO46MY8qvLwsPp/OM4vvqGrfQ4F7fLZxNS5LsszLlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2018

Add intermediate variables, for readability and to simplify future patches.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 8003c3662247..264840d84987 100644
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
@@ -798,24 +801,27 @@ static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
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


