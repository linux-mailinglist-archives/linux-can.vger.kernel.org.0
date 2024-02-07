Return-Path: <linux-can+bounces-216-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8295B84C797
	for <lists+linux-can@lfdr.de>; Wed,  7 Feb 2024 10:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70D31C249EF
	for <lists+linux-can@lfdr.de>; Wed,  7 Feb 2024 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7863F9C4;
	Wed,  7 Feb 2024 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P+wfLnhe"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC043F9D4
	for <linux-can@vger.kernel.org>; Wed,  7 Feb 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298375; cv=none; b=l3GoP1n+I/BMztlaVSyHdQAus/c6S0prmh70jjXY9smUlDk6zC7ZuhXvVcP7o91hotigCWKMvH6nzq6/5nBdnE2BWz3I9BhyAbvkwiHyCW5jg7tLH0EF+FnrkperMWnb4qDxAzJe9DQpfDfTG++18zCffGkIrwizRjGYh7kZfQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298375; c=relaxed/simple;
	bh=IrjB9D7I+eQ6XxmJDoPLbOhDTNkYMgIUTaS/CiFBq2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eb+kL0kjL50t2XiAzcWOAiSSQumajAUvcWPkLSF/hhAOlZvVbYRIdxibDJmQE1+4pC+3rWOxtzSQG7q6WeGyuvEPc67CT/2M60gj2MTLd8aaYHsB1ILgnKOUA3BxTjV6JFoeY0kZTU9Du0lUFO1EyX+1KYj5cKRwsp15ztzkZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P+wfLnhe; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51147d0abd1so474047e87.1
        for <linux-can@vger.kernel.org>; Wed, 07 Feb 2024 01:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298371; x=1707903171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyrMc5jTp9SVMayJr+6E15Cmf/hoA9mjpzLhtoAYUfo=;
        b=P+wfLnhebTEVJE9V4wRL4x856FoM9eLNlJ/mTzOyJbRZuzDBqiQIcYQtOmv5wERqeU
         bzAWc2t0E+AHpW+7fl6CyGIOg+WdA6QfmdIAUw9iR3nFvOrzdRwZByMOKzt18YlWCEiD
         XejWl5EhssTxklQsAS1TQuGGANBMgeswg+vcea7KSvOVPXXOxz6J9rWKyOKbaNMXbIfX
         PqdcpcE4fJoNLV5bgLE7WqFSnT5UBlu/Dq+b6ZNAJIk8rRZ3StwBHAoO/rUER9vquylQ
         uj2KEyIFp87Xq3xf8twaZlYnPP0ud1YVJRAcZ9cA9rVBIpJSlPv/8KMLMgw1CNLTmXzJ
         U4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298371; x=1707903171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyrMc5jTp9SVMayJr+6E15Cmf/hoA9mjpzLhtoAYUfo=;
        b=kGZ0K1sM7NXhLoeAqJmNPkuFXNCHManz23Gem8/kb92drB1fnxUII0O1bP7AgXAJWX
         jX2KbfD5x4mSUSI4fmoK771mzEpB6AnUxM/ViL2K3PSWPjL1KRUfbPIvxREiI7BPygWD
         nLxwkjpsiBfXnQ3dvzh2XdYR5ntvpnfbwxBymaVXQ776RUBydu7nhE7KTnFe9Pt8OS9y
         8ZSbvx7BZRiXlwwyknXbyVpUdAbM5i5q620MOqP9RKaL13g47PerPKVxwxII2cyc3TeU
         sdWokAGKk9qxswn8WOI0TyXuTo0X7E804CLKDdG0Dna0gCsPCPdyVN5MSOPrwlTXIlPO
         dYog==
X-Forwarded-Encrypted: i=1; AJvYcCVwZtwg0Fs5SM1iDAhhFBvX77b5WEj/6+oPy85fqGYBXO6WE7RparCjBFYn/0PO11wM0vK8i2vcBb3FS2qkUMNiiorkAljhMgdl
X-Gm-Message-State: AOJu0Yx4lyBT2nyd9aG6HO3Imi4jZMFeSkVeibbSP/Te/whm/euc/x6L
	fC6soQr+sWw+gYHUsqOskpC/2CNnjBzJbjp3bRNty7htb2StrYZCoIBdFxiCb9M=
X-Google-Smtp-Source: AGHT+IGlyySrxZb2xCUU3NVUNF0iGN9y5kNPNUw/zgDn+20t3kXSbkZ4pfjUGMlLN2CsKy2qSf3Pgw==
X-Received: by 2002:a05:6512:370f:b0:511:6263:408d with SMTP id z15-20020a056512370f00b005116263408dmr1649723lfr.8.1707298371575;
        Wed, 07 Feb 2024 01:32:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOWcLOLQ9J24dPnoaG8IbJC8shp1vr4lGFMt2PWDagdz+m4NS4yWhB8snlw+CumAifFUDVrlUoZQ0Q4+v/UP8wiJ6vbRLHuHPZvpoKBiPo7MLcZwoYW/a8xXdRQPbBICXOLhHiDhjAKDcNhAYomPtmipfq0dp0x9lQsHUhw03WjeaN+twKE65+wW/cfKwFDEcvgkv7x+5NmYuerBB8W/4TQxB4mvQOjIbNqje/tX5CwShlEm60Trmie5idaae4N0K9/ORgEmZNgkWFPmOPiZVpQuulZXxE9HFO8P/xxfpt+03JWR/b4wsqM6PttqvDeLX/c1+CQ+3yuMESoZ6sxSdQGO11NTGeRppTUUFU5/+UYIjVL3SMg/hWxm8nZstXMw78Y11jXsQRmFQiwEPP8pwZdCLvXjCbBXMYvEFxCq47A4Bq6jvPqjBzBUvw
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id qo9-20020a170907874900b00a388e24f533sm122336ejc.148.2024.02.07.01.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:32:51 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Lindgren <tony@atomide.com>,
	Judith Mendez <jm@ti.com>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julien Panis <jpanis@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 14/14] can: m_can: Implement transmit submission coalescing
Date: Wed,  7 Feb 2024 10:32:20 +0100
Message-ID: <20240207093220.2681425-15-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207093220.2681425-1-msp@baylibre.com>
References: <20240207093220.2681425-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

m_can supports submitting multiple transmits with one register write.
This is an interesting option to reduce the number of SPI transfers for
peripheral chips.

The m_can_tx_op is extended with a bool that signals if it is the last
transmission and the submit should be executed immediately.

The worker then writes the skb to the FIFO and submits it only if the
submit bool is set. If it isn't set, the worker will write the next skb
which is waiting in the workqueue to the FIFO, etc.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 56 ++++++++++++++++++++++++++++++++---
 drivers/net/can/m_can/m_can.h |  6 ++++
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 48968da69ae9..b7dbce4c342a 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1539,6 +1539,9 @@ static int m_can_start(struct net_device *dev)
 	if (ret)
 		return ret;
 
+	netdev_queue_set_dql_min_limit(netdev_get_tx_queue(cdev->net, 0),
+				       cdev->tx_max_coalesced_frames);
+
 	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	m_can_enable_all_interrupts(cdev);
@@ -1835,8 +1838,13 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 		 */
 		can_put_echo_skb(skb, dev, putidx, frame_len);
 
-		/* Enable TX FIFO element to start transfer  */
-		m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));
+		if (cdev->is_peripheral) {
+			/* Delay enabling TX FIFO element */
+			cdev->tx_peripheral_submit |= BIT(putidx);
+		} else {
+			/* Enable TX FIFO element to start transfer  */
+			m_can_write(cdev, M_CAN_TXBAR, BIT(putidx));
+		}
 		cdev->tx_fifo_putidx = (++cdev->tx_fifo_putidx >= cdev->can.echo_skb_max ?
 					0 : cdev->tx_fifo_putidx);
 	}
@@ -1849,6 +1857,17 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 	return NETDEV_TX_BUSY;
 }
 
+static void m_can_tx_submit(struct m_can_classdev *cdev)
+{
+	if (cdev->version == 30)
+		return;
+	if (!cdev->is_peripheral)
+		return;
+
+	m_can_write(cdev, M_CAN_TXBAR, cdev->tx_peripheral_submit);
+	cdev->tx_peripheral_submit = 0;
+}
+
 static void m_can_tx_work_queue(struct work_struct *ws)
 {
 	struct m_can_tx_op *op = container_of(ws, struct m_can_tx_op, work);
@@ -1857,11 +1876,15 @@ static void m_can_tx_work_queue(struct work_struct *ws)
 
 	op->skb = NULL;
 	m_can_tx_handler(cdev, skb);
+	if (op->submit)
+		m_can_tx_submit(cdev);
 }
 
-static void m_can_tx_queue_skb(struct m_can_classdev *cdev, struct sk_buff *skb)
+static void m_can_tx_queue_skb(struct m_can_classdev *cdev, struct sk_buff *skb,
+			       bool submit)
 {
 	cdev->tx_ops[cdev->next_tx_op].skb = skb;
+	cdev->tx_ops[cdev->next_tx_op].submit = submit;
 	queue_work(cdev->tx_wq, &cdev->tx_ops[cdev->next_tx_op].work);
 
 	++cdev->next_tx_op;
@@ -1872,7 +1895,17 @@ static void m_can_tx_queue_skb(struct m_can_classdev *cdev, struct sk_buff *skb)
 static netdev_tx_t m_can_start_peripheral_xmit(struct m_can_classdev *cdev,
 					       struct sk_buff *skb)
 {
-	m_can_tx_queue_skb(cdev, skb);
+	bool submit;
+
+	++cdev->nr_txs_without_submit;
+	if (cdev->nr_txs_without_submit >= cdev->tx_max_coalesced_frames ||
+	    !netdev_xmit_more()) {
+		cdev->nr_txs_without_submit = 0;
+		submit = true;
+	} else {
+		submit = false;
+	}
+	m_can_tx_queue_skb(cdev, skb, submit);
 
 	return NETDEV_TX_OK;
 }
@@ -2015,6 +2048,7 @@ static int m_can_get_coalesce(struct net_device *dev,
 
 	ec->rx_max_coalesced_frames_irq = cdev->rx_max_coalesced_frames_irq;
 	ec->rx_coalesce_usecs_irq = cdev->rx_coalesce_usecs_irq;
+	ec->tx_max_coalesced_frames = cdev->tx_max_coalesced_frames;
 	ec->tx_max_coalesced_frames_irq = cdev->tx_max_coalesced_frames_irq;
 	ec->tx_coalesce_usecs_irq = cdev->tx_coalesce_usecs_irq;
 
@@ -2059,6 +2093,18 @@ static int m_can_set_coalesce(struct net_device *dev,
 		netdev_err(dev, "tx-frames-irq and tx-usecs-irq can only be set together\n");
 		return -EINVAL;
 	}
+	if (ec->tx_max_coalesced_frames > cdev->mcfg[MRAM_TXE].num) {
+		netdev_err(dev, "tx-frames %u greater than the TX event FIFO %u\n",
+			   ec->tx_max_coalesced_frames,
+			   cdev->mcfg[MRAM_TXE].num);
+		return -EINVAL;
+	}
+	if (ec->tx_max_coalesced_frames > cdev->mcfg[MRAM_TXB].num) {
+		netdev_err(dev, "tx-frames %u greater than the TX FIFO %u\n",
+			   ec->tx_max_coalesced_frames,
+			   cdev->mcfg[MRAM_TXB].num);
+		return -EINVAL;
+	}
 	if (ec->rx_coalesce_usecs_irq != 0 && ec->tx_coalesce_usecs_irq != 0 &&
 	    ec->rx_coalesce_usecs_irq != ec->tx_coalesce_usecs_irq) {
 		netdev_err(dev, "rx-usecs-irq %u needs to be equal to tx-usecs-irq %u if both are enabled\n",
@@ -2069,6 +2115,7 @@ static int m_can_set_coalesce(struct net_device *dev,
 
 	cdev->rx_max_coalesced_frames_irq = ec->rx_max_coalesced_frames_irq;
 	cdev->rx_coalesce_usecs_irq = ec->rx_coalesce_usecs_irq;
+	cdev->tx_max_coalesced_frames = ec->tx_max_coalesced_frames;
 	cdev->tx_max_coalesced_frames_irq = ec->tx_max_coalesced_frames_irq;
 	cdev->tx_coalesce_usecs_irq = ec->tx_coalesce_usecs_irq;
 
@@ -2086,6 +2133,7 @@ static const struct ethtool_ops m_can_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
 		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
 		ETHTOOL_COALESCE_TX_USECS_IRQ |
+		ETHTOOL_COALESCE_TX_MAX_FRAMES |
 		ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
 	.get_ts_info = ethtool_op_get_ts_info,
 	.get_coalesce = m_can_get_coalesce,
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 76b1ce1b7c1b..2986c4ce0b2f 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -74,6 +74,7 @@ struct m_can_tx_op {
 	struct m_can_classdev *cdev;
 	struct work_struct work;
 	struct sk_buff *skb;
+	bool submit;
 };
 
 struct m_can_classdev {
@@ -102,6 +103,7 @@ struct m_can_classdev {
 	u32 active_interrupts;
 	u32 rx_max_coalesced_frames_irq;
 	u32 rx_coalesce_usecs_irq;
+	u32 tx_max_coalesced_frames;
 	u32 tx_max_coalesced_frames_irq;
 	u32 tx_coalesce_usecs_irq;
 
@@ -116,6 +118,10 @@ struct m_can_classdev {
 	int tx_fifo_size;
 	int next_tx_op;
 
+	int nr_txs_without_submit;
+	/* bitfield of fifo elements that will be submitted together */
+	u32 tx_peripheral_submit;
+
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 
 	struct hrtimer hrtimer;
-- 
2.43.0


