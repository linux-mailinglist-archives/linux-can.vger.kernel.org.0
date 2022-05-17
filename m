Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDFC5295FA
	for <lists+linux-can@lfdr.de>; Tue, 17 May 2022 02:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiEQAYD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 May 2022 20:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiEQAYA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 May 2022 20:24:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84259AE76
        for <linux-can@vger.kernel.org>; Mon, 16 May 2022 17:23:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CE9F6116F
        for <linux-can@vger.kernel.org>; Tue, 17 May 2022 00:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A12C385B8;
        Tue, 17 May 2022 00:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652747037;
        bh=ucqKTB6272MbcwoPGgh074uJNxAEwdxPE8qS7hqV5EU=;
        h=From:To:Cc:Subject:Date:From;
        b=oWK9oWa3F/AC/WP/SpebDGJWT57bhSRCD46BVDlYV8vKAABJDgqTcvseQaRnrkur0
         Kp/b8rEhLCjzJuOl3keqN0/X5RbeTcrya1I04XGLVV2nbKTNu94n20CcBJygCU0nZg
         HZasD0Pw2oZ95IydbqRb2NKyR6huJbskLC0eQaRQ0oXv5O5fI1JQMeqmRgabWgggq1
         DU5O8k6s6SF8VwSX+2Os9fDvO1UUQuP+FwP4L1kuWv22gIf+RZ/eZypmndAGAiVdiE
         yO347VfEsRhwgvpyVbNoDE475MR10jfqjI5hk91EekTW/I2IopyezvZ6UReAyBP0l+
         9rW2YHDj4f5ag==
From:   Jakub Kicinski <kuba@kernel.org>
To:     mkl@pengutronix.de
Cc:     Jakub Kicinski <kuba@kernel.org>, wg@grandegger.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, appana.durga.rao@xilinx.com,
        naga.sureshkumar.relli@xilinx.com, michal.simek@xilinx.com,
        dariobin@libero.it, stefan.maetje@esd.eu,
        mailhol.vincent@wanadoo.fr, yoshihiro.shimoda.uh@renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com, uli+renesas@fpond.eu,
        linux-can@vger.kernel.org
Subject: [PATCH can-next] can: move to netif_napi_add_weight()
Date:   Mon, 16 May 2022 17:23:45 -0700
Message-Id: <20220517002345.1812104-1-kuba@kernel.org>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

We want to remove the weight argument from the basic version of
the netif_napi_add() call. Move all the callers in drivers/net/can
that pass a custom weight (i.e. not NAPI_POLL_WEIGHT or 64) to
the netif_napi_add_weight() API.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: wg@grandegger.com
CC: mkl@pengutronix.de
CC: nicolas.ferre@microchip.com
CC: alexandre.belloni@bootlin.com
CC: claudiu.beznea@microchip.com
CC: appana.durga.rao@xilinx.com
CC: naga.sureshkumar.relli@xilinx.com
CC: michal.simek@xilinx.com
CC: dariobin@libero.it
CC: stefan.maetje@esd.eu
CC: mailhol.vincent@wanadoo.fr
CC: yoshihiro.shimoda.uh@renesas.com
CC: prabhakar.mahadev-lad.rj@bp.renesas.com
CC: uli+renesas@fpond.eu
CC: linux-can@vger.kernel.org
---
 drivers/net/can/at91_can.c         | 2 +-
 drivers/net/can/c_can/c_can_main.c | 3 ++-
 drivers/net/can/dev/rx-offload.c   | 3 ++-
 drivers/net/can/grcan.c            | 2 +-
 drivers/net/can/janz-ican3.c       | 2 +-
 drivers/net/can/mscan/mscan.c      | 2 +-
 drivers/net/can/pch_can.c          | 2 +-
 drivers/net/can/rcar/rcar_can.c    | 4 ++--
 drivers/net/can/rcar/rcar_canfd.c  | 4 ++--
 drivers/net/can/xilinx_can.c       | 2 +-
 10 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index a00655ccda02..953aef8d3978 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1317,7 +1317,7 @@ static int at91_can_probe(struct platform_device *pdev)
 	priv->pdata = dev_get_platdata(&pdev->dev);
 	priv->mb0_id = 0x7ff;
 
-	netif_napi_add(dev, &priv->napi, at91_poll, get_mb_rx_num(priv));
+	netif_napi_add_weight(dev, &priv->napi, at91_poll, get_mb_rx_num(priv));
 
 	if (at91_is_sam9263(priv))
 		dev->sysfs_groups[0] = &at91_sysfs_attr_group;
diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index faa217f26771..2034dbe30958 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -1246,7 +1246,8 @@ struct net_device *alloc_c_can_dev(int msg_obj_num)
 	priv->tx.tail = 0;
 	priv->tx.obj_num = msg_obj_tx_num;
 
-	netif_napi_add(dev, &priv->napi, c_can_poll, priv->msg_obj_rx_num);
+	netif_napi_add_weight(dev, &priv->napi, c_can_poll,
+			      priv->msg_obj_rx_num);
 
 	priv->dev = dev;
 	priv->can.bittiming_const = &c_can_bittiming_const;
diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
index 6d0dc18c03e7..509d21170c8c 100644
--- a/drivers/net/can/dev/rx-offload.c
+++ b/drivers/net/can/dev/rx-offload.c
@@ -337,7 +337,8 @@ static int can_rx_offload_init_queue(struct net_device *dev,
 	skb_queue_head_init(&offload->skb_queue);
 	__skb_queue_head_init(&offload->skb_irq_queue);
 
-	netif_napi_add(dev, &offload->napi, can_rx_offload_napi_poll, weight);
+	netif_napi_add_weight(dev, &offload->napi, can_rx_offload_napi_poll,
+			      weight);
 
 	dev_dbg(dev->dev.parent, "%s: skb_queue_len_max=%d\n",
 		__func__, offload->skb_queue_len_max);
diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 5215bd9b2c80..76df4807d366 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1609,7 +1609,7 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
 		timer_setup(&priv->hang_timer, grcan_initiate_running_reset, 0);
 	}
 
-	netif_napi_add(dev, &priv->napi, grcan_poll, GRCAN_NAPI_WEIGHT);
+	netif_napi_add_weight(dev, &priv->napi, grcan_poll, GRCAN_NAPI_WEIGHT);
 
 	SET_NETDEV_DEV(dev, &ofdev->dev);
 	dev_info(&ofdev->dev, "regs=0x%p, irq=%d, clock=%d\n",
diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 808c105cf8f7..35bfb82d6929 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1910,7 +1910,7 @@ static int ican3_probe(struct platform_device *pdev)
 	mod = netdev_priv(ndev);
 	mod->ndev = ndev;
 	mod->num = pdata->modno;
-	netif_napi_add(ndev, &mod->napi, ican3_napi, ICAN3_RX_BUFFERS);
+	netif_napi_add_weight(ndev, &mod->napi, ican3_napi, ICAN3_RX_BUFFERS);
 	skb_queue_head_init(&mod->echoq);
 	spin_lock_init(&mod->lock);
 	init_completion(&mod->termination_comp);
diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 5b5802fac772..78a21ab63601 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -679,7 +679,7 @@ struct net_device *alloc_mscandev(void)
 
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 
-	netif_napi_add(dev, &priv->napi, mscan_rx_poll, 8);
+	netif_napi_add_weight(dev, &priv->napi, mscan_rx_poll, 8);
 
 	priv->can.bittiming_const = &mscan_bittiming_const;
 	priv->can.do_set_bittiming = mscan_do_set_bittiming;
diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index 888bef03de09..fde3ac516d26 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -1189,7 +1189,7 @@ static int pch_can_probe(struct pci_dev *pdev,
 	ndev->netdev_ops = &pch_can_netdev_ops;
 	priv->can.clock.freq = PCH_CAN_CLK; /* Hz */
 
-	netif_napi_add(ndev, &priv->napi, pch_can_poll, PCH_RX_OBJ_END);
+	netif_napi_add_weight(ndev, &priv->napi, pch_can_poll, PCH_RX_OBJ_END);
 
 	rc = pci_enable_msi(priv->dev);
 	if (rc) {
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 33e37395379d..103f1a92eee2 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -803,8 +803,8 @@ static int rcar_can_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ndev);
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 
-	netif_napi_add(ndev, &priv->napi, rcar_can_rx_poll,
-		       RCAR_CAN_NAPI_WEIGHT);
+	netif_napi_add_weight(ndev, &priv->napi, rcar_can_rx_poll,
+			      RCAR_CAN_NAPI_WEIGHT);
 	err = register_candev(ndev);
 	if (err) {
 		dev_err(&pdev->dev, "register_candev() failed, error %d\n",
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 1e121e04208c..f75ebaa35519 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1789,8 +1789,8 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	priv->gpriv = gpriv;
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 
-	netif_napi_add(ndev, &priv->napi, rcar_canfd_rx_poll,
-		       RCANFD_NAPI_WEIGHT);
+	netif_napi_add_weight(ndev, &priv->napi, rcar_canfd_rx_poll,
+			      RCANFD_NAPI_WEIGHT);
 	spin_lock_init(&priv->tx_lock);
 	devm_can_led_init(ndev);
 	gpriv->ch[priv->channel] = priv;
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 43f0c6a064ba..7f730b471e9f 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1804,7 +1804,7 @@ static int xcan_probe(struct platform_device *pdev)
 
 	priv->can.clock.freq = clk_get_rate(priv->can_clk);
 
-	netif_napi_add(ndev, &priv->napi, xcan_rx_poll, rx_max);
+	netif_napi_add_weight(ndev, &priv->napi, xcan_rx_poll, rx_max);
 
 	ret = register_candev(ndev);
 	if (ret) {
-- 
2.34.3

