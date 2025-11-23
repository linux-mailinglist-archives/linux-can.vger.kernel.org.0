Return-Path: <linux-can+bounces-5623-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47714C7E562
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 19:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 81769344EDC
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 18:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB3A2D2493;
	Sun, 23 Nov 2025 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="dlvKaSAY"
X-Original-To: linux-can@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C9523EA8E
	for <linux-can@vger.kernel.org>; Sun, 23 Nov 2025 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763921919; cv=none; b=akwlTKcHkZhaxdH1Jww4Rh9Yow2UrNMvS12lBYIcdmoLJX6Eqb6/NBeQhfra4w2QKQZO9MJYro2Zs6xabfb+kC+LnM9LTBuRonasbZy3BzMw2Jsa2onD3NM/ybtJmPNA7RCeI9hGT42EzCZ4+4qVbRb0gbHhl9CmVZX+Bfjk5AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763921919; c=relaxed/simple;
	bh=z0qloevcrntkpGwRXqLk7LXfnh3dxQj/AWRtob2cuQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TidUddyRzcB/kBVFW481J/PgHebiajQNGYlg20eMEn92Dq8/Z7Cs09aac/b5IrqkE43i3JAGuj86bXJJHMyOHKT6jwV7UyMN0MZWPTk7M5W6uNG6lv9kEqd9dRFu9WUXbDZWMIxEX76+0I/JXjj/HfN1pBiKzsFA5y0pDmstmmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=dlvKaSAY; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 2F7AD240104
	for <linux-can@vger.kernel.org>; Sun, 23 Nov 2025 19:18:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1763921914; bh=yDp042790YwvV+urLEfZ1H1JZATWRqyWJqVEo/iBqxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=dlvKaSAYr431fNm3KFLRfVq+ovy5aILI2UAwoszrJP6jzRtbQD2ya0FALi5YtrtIy
	 Coc6jgU2lRd/KkQVyNHNB9af0wG0GhqJ49QYMQzskbINrh0Q1f7Ox0M9gPt7TFih1r
	 1FrlZFV5UMPZSlKqPCDRyvFqWAIvUDjvRMxEIdjLS8m1yp1tdHsHkw9jX9E7LchmjW
	 pIqJNnf8tjcL2TFQ2jYH/ogvru3ITaKz18C9pSVTNsPbWn8WGRriT2mqXSOfdm+qKR
	 VAmXc1aEwSeXxAr7LMOo4/kuSpXwW4duQx5mBWBG5MdTD8wwMoxdq/OSBAnRWKAdFh
	 yyUYGwxfjH0/A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dDxzF2SKyz9rxF;
	Sun, 23 Nov 2025 19:18:33 +0100 (CET)
From: =?UTF-8?q?Thomas=20M=C3=BChlbacher?= <tmuehlbacher@posteo.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	=?UTF-8?q?Thomas=20M=C3=BChlbacher?= <tmuehlbacher@posteo.net>
Subject: [RFC PATCH 1/1] can: sja1000: implement NAPI for RX IRQ handling
Date: Sun, 23 Nov 2025 18:18:33 +0000
Message-ID: <20251123181820.19233-2-tmuehlbacher@posteo.net>
In-Reply-To: <20251123181820.19233-1-tmuehlbacher@posteo.net>
References: <20251123181820.19233-1-tmuehlbacher@posteo.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reduces the amount of time potentially spent inside of the ISR,
especially if `sja1000_rx()` takes a long time because of slow IO to the
controller.

Signed-off-by: Thomas Mühlbacher <tmuehlbacher@posteo.net>
---
 drivers/net/can/sja1000/sja1000.c | 42 ++++++++++++++++++++++++++++++-
 drivers/net/can/sja1000/sja1000.h |  1 +
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 4d245857ef1c..621e824afdfc 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -387,6 +387,30 @@ static void sja1000_rx(struct net_device *dev)
 	netif_rx(skb);
 }
 
+static int sja1000_napi_poll(struct napi_struct *napi, int budget)
+{
+	struct sja1000_priv *priv =
+		container_of(napi, struct sja1000_priv, napi);
+	int work_done;
+	u8 status;
+
+	/* only using NAPI for RX side here */
+	for (work_done = 0; work_done < budget; work_done++) {
+		status = priv->read_reg(priv, SJA1000_SR);
+		/* check for absent controller */
+		if (status == 0xFF && sja1000_is_absent(priv))
+			break;
+		if (!(status & SR_RBS))
+			break;
+		sja1000_rx(priv->dev);
+	}
+
+	if (work_done < budget)
+		napi_complete_done(napi, work_done);
+
+	return work_done;
+}
+
 static irqreturn_t sja1000_reset_interrupt(int irq, void *dev_id)
 {
 	struct net_device *dev = (struct net_device *)dev_id;
@@ -572,7 +596,7 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 			}
 			netif_wake_queue(dev);
 		}
-		if (isrc & IRQ_RI) {
+		if (isrc & IRQ_RI && priv->flags & SJA1000_CUSTOM_IRQ_HANDLER) {
 			/* receive interrupt */
 			while (status & SR_RBS) {
 				sja1000_rx(dev);
@@ -581,6 +605,13 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 				if (status == 0xFF && sja1000_is_absent(priv))
 					goto out;
 			}
+		} else if (isrc & IRQ_RI) {
+			napi_schedule(&priv->napi);
+			/* don't keep spinning unnecessarily */
+			if (isrc == IRQ_RI) {
+				n++;
+				break;
+			}
 		}
 		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {
 			/* error interrupt */
@@ -633,6 +664,8 @@ static int sja1000_open(struct net_device *dev)
 	/* init and start chi */
 	sja1000_start(dev);
 
+	if (!(priv->flags & SJA1000_CUSTOM_IRQ_HANDLER))
+		napi_enable(&priv->napi);
 	netif_start_queue(dev);
 
 	return 0;
@@ -643,6 +676,8 @@ static int sja1000_close(struct net_device *dev)
 	struct sja1000_priv *priv = netdev_priv(dev);
 
 	netif_stop_queue(dev);
+	if (!(priv->flags & SJA1000_CUSTOM_IRQ_HANDLER))
+		napi_disable(&priv->napi);
 	set_reset_mode(dev);
 
 	if (!(priv->flags & SJA1000_CUSTOM_IRQ_HANDLER))
@@ -680,6 +715,8 @@ struct net_device *alloc_sja1000dev(int sizeof_priv)
 
 	spin_lock_init(&priv->cmdreg_lock);
 
+	netif_napi_add(dev, &priv->napi, sja1000_napi_poll);
+
 	if (sizeof_priv)
 		priv->priv = (void *)priv + sizeof(struct sja1000_priv);
 
@@ -689,6 +726,9 @@ EXPORT_SYMBOL_GPL(alloc_sja1000dev);
 
 void free_sja1000dev(struct net_device *dev)
 {
+	struct sja1000_priv *priv = netdev_priv(dev);
+
+	netif_napi_del(&priv->napi);
 	free_candev(dev);
 }
 EXPORT_SYMBOL_GPL(free_sja1000dev);
diff --git a/drivers/net/can/sja1000/sja1000.h b/drivers/net/can/sja1000/sja1000.h
index f015e39e2224..2ba168f97452 100644
--- a/drivers/net/can/sja1000/sja1000.h
+++ b/drivers/net/can/sja1000/sja1000.h
@@ -164,6 +164,7 @@ struct sja1000_priv {
 
 	void *priv;		/* for board-specific data */
 	struct net_device *dev;
+	struct napi_struct napi;
 
 	void __iomem *reg_base;	 /* ioremap'ed address to registers */
 	unsigned long irq_flags; /* for request_irq() */
-- 
2.51.2


