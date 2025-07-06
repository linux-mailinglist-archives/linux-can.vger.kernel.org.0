Return-Path: <linux-can+bounces-3951-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5B9AFA58E
	for <lists+linux-can@lfdr.de>; Sun,  6 Jul 2025 15:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E21189C811
	for <lists+linux-can@lfdr.de>; Sun,  6 Jul 2025 13:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C815F194A65;
	Sun,  6 Jul 2025 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZaBqU2L7";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="CkDvqvFG"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A7854652
	for <linux-can@vger.kernel.org>; Sun,  6 Jul 2025 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751809182; cv=pass; b=t4J3olQ/4tVmKg1rtfeFNODi8EdDdmrbfjoLULCMoaI9A9Y0HupTM6sVt2m3EJJ0wjTBfvWJB1h/4sbVUBX4V3JaoMlI05COBqcG1GQa3B58zfKNSsGY07Ru8OBHAgbXrvwbv+m/ernP6n0Wt8Gmo3Z261JP4n2D18afvRxkDZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751809182; c=relaxed/simple;
	bh=uhPR0+SLY2106a9a7c2SUOmQSVDdcnIHtNw9UoELi/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G+3fOXy7lT7EcLWGk2FzgdQs8cy1FTC0LbHNZQBN8lcrGamF9kJJUZulj7gdHAGPTDG8/geYzl3GQ/owSxjasCvUH/qPyJm9afijpcnu1Vg5oZLdVUrCym8kDAyZt46ajp13RtqPiRcTR1xdjX7O1YKvgZZrnfoKrS7gHViJBn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZaBqU2L7; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=CkDvqvFG; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1751808984; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jyUDSWyOBNAtBrGkctQNWWH3v3wDVylz3H28cFY69UFqfSMaaJtf5JgS7NFrq6PPGN
    CTWIAnw4kSAaxZYOxtp2RNdcrgnSX3xDFhOW0sfEJJQK/6bbN4Mq+QrPkT5gzM4KGvei
    6A5C3tsRQiPve7fjKlSfauqVzDDQl0gMik0JlPl3RA5vyrFA//scu0iXI9FrYacQXKzp
    88jSCSQhuAWMyCZK7W5GF/T5TUf7A7nl6/IxxMW1st7zhHq7ehGtvHs1kIZy6SJPvJC2
    RgVFZSwNyXMWI2UjpR2/N70Z1B6T/maC4Wz2pPEhMt1HLJZHowFjG2c6lwVu61u8DEP3
    2hKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1751808984;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=PH0ZeGwWqfJvWDK5Wv96r8lWcFZS56tcclr7HLBvf50=;
    b=XO9jZHw2Da4SPMit0HbULAJXp5z0NJXOdSN/AebBJE/EMLNGuJClIpQLQ+unFLlni7
    T3RDrX5/64iWijmQABRtlAsnbSMrnO29yrOeYwCi0aWMVop/oTNJbzAUnzTNkEn5eppJ
    iGqcKV94ktDCepPwrMZY+1GPUBpfQ0IVFak60jsExf1pI69VlpZgZzLxyvKp5mbAWKXr
    rwjaEpMMXZscZpX6uoqBX3Li9LO/YX3Bn1NhTv5i+mN4f86b2Pgz+kdfe/NN0tyEKPM9
    mDdOQbITugjsFxChC2n5H7dZzqI0C8Y9myA0QyWW88SSidxjUlTktP7VJn9HZRN/A058
    8gdg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1751808984;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=PH0ZeGwWqfJvWDK5Wv96r8lWcFZS56tcclr7HLBvf50=;
    b=ZaBqU2L7BxLOs1qSzDhjlcc/XlicYeWP049qZx9MY2Jr/xDwB2AknkBu7u7fxdRsH/
    JGuJ+luWfA1mTC77wrQc5f5je5Bc61rtHAX63CkoOuEDNm4vtgtPkt3c/6BizSi/JS1p
    8hDWb/nT7pEo183tbL6pqgrq02tpDKV0xFLh9q9iToqZTcLTh+1LHRNyjUMHEz4oPyjH
    aDWepHs3W077Fv/hNjfj0SDtoroz/yqBtOU11D4NFnJf1kGWKNFNj0GfL/VHkaLGuIx9
    okX5w8kaIrm8u0XxwzLyugrDByT7vCyYcVd/d9ETsp/WmiBlW769wpOTO49DOt7v+k44
    d+IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1751808984;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=PH0ZeGwWqfJvWDK5Wv96r8lWcFZS56tcclr7HLBvf50=;
    b=CkDvqvFGKUM2NTPH2pRwI0kwSspAL4ebaZKzh45b/521DrITZSe9apI/0VbQDjiFmq
    QNaqfoSidxiF6czvO5Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+4xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K55aa3166DaOK1x
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 6 Jul 2025 15:36:24 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next/b4 1/2] dummyxl: update config possibilities and rename dummyxl_priv
Date: Sun,  6 Jul 2025 15:35:49 +0200
Message-ID: <20250706133550.47369-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dummyxl.c | 55 +++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/dummyxl.c b/drivers/net/can/dummyxl.c
index ac1b579b4c1f..c61f27b93e9f 100644
--- a/drivers/net/can/dummyxl.c
+++ b/drivers/net/can/dummyxl.c
@@ -10,16 +10,17 @@
 #include <linux/units.h>
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/skb.h>
 
-struct dummyxl {
+struct dummyxl_priv {
 	struct can_priv can;
 	struct net_device *dev;
 };
 
-static struct dummyxl *dummyxl;
+/* pointer to our single dummy device (for removal) */
+static struct net_device *dummyxl_dev = NULL;
 
 static const struct can_bittiming_const dummyxl_bittiming_const = {
 	.name = "dummyxl nominal",
 	.tseg1_min = 2,
 	.tseg1_max = 256,
@@ -71,11 +72,12 @@ static const struct can_tdc_const dummyxl_xl_tdc_const = {
 	.tdco_max = 127,
 	.tdcf_min = 0,
 	.tdcf_max = 127
 };
 
-static void dummyxl_print_bittiming(struct net_device *dev, struct can_bittiming *bt)
+static void dummyxl_print_bittiming(struct net_device *dev,
+				    struct can_bittiming *bt)
 {
 	netdev_info(dev, "\tbitrate: %u\n", bt->bitrate);
 	netdev_info(dev, "\tsample_point: %u\n", bt->sample_point);
 	netdev_info(dev, "\ttq: %u\n", bt->tq);
 	netdev_info(dev, "\tprop_seg: %u\n", bt->prop_seg);
@@ -90,15 +92,14 @@ static void dummyxl_print_tdc(struct net_device *dev, struct can_tdc *tdc)
 	netdev_info(dev, "\t\ttdcv: %u\n", tdc->tdcv);
 	netdev_info(dev, "\t\ttdco: %u\n", tdc->tdco);
 	netdev_info(dev, "\t\ttdcf: %u\n", tdc->tdcf);
 }
 
-static int dummyxl_netdev_open(struct net_device *dev)
+static void dummyxl_print_config(struct net_device *dev)
 {
-	struct dummyxl *priv = netdev_priv(dev);
+	struct dummyxl_priv *priv = netdev_priv(dev);
 	struct can_priv *can_priv = &priv->can;
-	int ret;
 
 	netdev_info(dev, "CAN control mode/supported : %08X/%08X\n",
 		    can_priv->ctrlmode, can_priv->ctrlmode_supported);
 	netdev_info(dev, "CAN CC nominal bittiming:\n");
 	dummyxl_print_bittiming(dev, &can_priv->bittiming);
@@ -129,10 +130,17 @@ static int dummyxl_netdev_open(struct net_device *dev)
 		}
 	} else {
 		netdev_info(dev, "CAN XL is off\n");
 	}
 	netdev_info(dev, "\n");
+}
+
+static int dummyxl_netdev_open(struct net_device *dev)
+{
+	int ret;
+
+	dummyxl_print_config(dev);
 
 	ret = open_candev(dev);
 	if (ret)
 		return ret;
 	netif_start_queue(dev);
@@ -174,50 +182,57 @@ static const struct net_device_ops dummyxl_netdev_ops = {
 };
 
 static int __init dummyxl_init(void)
 {
 	struct net_device *dev;
-	struct dummyxl *priv;
+	struct dummyxl_priv *priv;
 	int ret;
 
-	dev = alloc_candev(sizeof(struct dummyxl), 0);
+	dev = alloc_candev(sizeof(struct dummyxl_priv), 0);
 	if (!dev)
 		return -ENOMEM;
 
 	dev->netdev_ops = &dummyxl_netdev_ops;
 	priv = netdev_priv(dev);
 	priv->can.bittiming_const = &dummyxl_bittiming_const;
-	priv->can.bitrate_max = 8 * MEGA /* BPS */;
-	priv->can.clock.freq = 80 * MEGA /* Hz */;
+	priv->can.bitrate_max = 20 * MEGA /* BPS */;
+	priv->can.clock.freq = 160 * MEGA /* Hz */;
 	priv->can.fd.data_bittiming_const = &dummyxl_fd_databittiming_const;
 	priv->can.fd.tdc_const = &dummyxl_fd_tdc_const;
 	priv->can.xl.data_bittiming_const = &dummyxl_xl_databittiming_const;
 	priv->can.xl.tdc_const = &dummyxl_xl_tdc_const;
-	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
-		CAN_CTRLMODE_FD | CAN_CTRLMODE_TDC_AUTO |
-		CAN_CTRLMODE_XL | CAN_CTRLMODE_XL_TDC_AUTO;
+	priv->can.ctrlmode_supported =
+		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_CC_LEN8_DLC |
+		CAN_CTRLMODE_FD |
+		CAN_CTRLMODE_TDC_AUTO | CAN_CTRLMODE_TDC_MANUAL |
+		CAN_CTRLMODE_XL |
+		CAN_CTRLMODE_XL_TDC_AUTO | CAN_CTRLMODE_XL_TDC_MANUAL |
+		CAN_CTRLMODE_XL_RRS | CAN_CTRLMODE_XL_TRX |
+		CAN_CTRLMODE_XL_ERR_SIGNAL;
 	priv->dev = dev;
 
-	ret = register_candev(priv->dev);
+	ret = register_candev(dev);
 	if (ret) {
-		free_candev(priv->dev);
+		free_candev(dev);
 		return ret;
 	}
 
-	dummyxl = priv;
+	dummyxl_dev = dev;
 	netdev_info(dev, "dummyxl OK\n");
 
 	return 0;
 }
 
 static void __exit dummyxl_exit(void)
 {
-	struct net_device *dev = dummyxl->dev;
+	struct net_device *dev = dummyxl_dev;
 
-	netdev_info(dev, "dummyxl bye bye\n");
-	unregister_candev(dev);
-	free_candev(dev);
+	if (dev) {
+		netdev_info(dev, "dummyxl bye bye\n");
+		unregister_candev(dev);
+		free_candev(dev);
+	}
 }
 
 module_init(dummyxl_init);
 module_exit(dummyxl_exit);
 
-- 
2.47.2


