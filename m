Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAFC52BF8A
	for <lists+linux-can@lfdr.de>; Wed, 18 May 2022 18:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239540AbiERPpo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 18 May 2022 11:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbiERPpn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 May 2022 11:45:43 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1675119900
        for <linux-can@vger.kernel.org>; Wed, 18 May 2022 08:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1652888734;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=aoZq+jKZAc+L3hFqZqFFvhMX4XUY32dV5D1GGFVwdBs=;
    b=bA9s7tU8ndiB6LLZ+MI9xxN+KR0DrcQjd2hbYd6Wr6LYL/MZcsecEISjEcWslpTbjo
    5avheJCZ1zMp9F6NljeC+slhycdxVTzNi/pIrPSgVOUhVDRzpDZfHzAG3jSXJDkf3fqx
    /AzAWQdxFTDKBlSLpZOu/GVzzCzieG/bbx/HEfeW7yMIL9lrUk4LPMuyK01A/N4PX/a0
    SuiS7S0lrrx5NHOHWsIqX8u2DY5supyYjIDJkdo+2koi84nSfD9B25JXlWqMvNM+4xjD
    ygNi4lvC5R5iARKw/7zAW8y9YHC/iQaTTqrY2p9VVy4nJLnMIoK8gA5Z+/7brQW8EHj2
    QH/A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JCKNKiWJaRDy1ex1"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id R0691fy4IFjYI0F
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 18 May 2022 17:45:34 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-next] can: can-dev: remove obsolete CAN LED support
Date:   Wed, 18 May 2022 17:45:27 +0200
Message-Id: <20220518154527.29046-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since commit 30f3b42147ba6f ("can: mark led trigger as broken") the
CAN specific LED support was disabled and marked as BROKEN. As the common
LED support with CONFIG_LEDS_TRIGGER_NETDEV should to this work now the
code can be removed as preparation for a CAN netdevice Kconfig rework.

Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/Kconfig                  |  17 ---
 drivers/net/can/at91_can.c               |  10 --
 drivers/net/can/c_can/c_can_main.c       |  12 +-
 drivers/net/can/ctucanfd/ctucanfd_base.c |  10 --
 drivers/net/can/dev/Makefile             |   2 -
 drivers/net/can/dev/dev.c                |   5 -
 drivers/net/can/dev/rx-offload.c         |   2 -
 drivers/net/can/flexcan/flexcan-core.c   |   7 --
 drivers/net/can/ifi_canfd/ifi_canfd.c    |   9 --
 drivers/net/can/led.c                    | 140 -----------------------
 drivers/net/can/m_can/m_can.c            |  11 --
 drivers/net/can/m_can/m_can.h            |   1 -
 drivers/net/can/rcar/rcar_can.c          |   8 --
 drivers/net/can/rcar/rcar_canfd.c        |   7 --
 drivers/net/can/sja1000/sja1000.c        |  11 --
 drivers/net/can/spi/hi311x.c             |   8 --
 drivers/net/can/spi/mcp251x.c            |  10 --
 drivers/net/can/sun4i_can.c              |   7 --
 drivers/net/can/ti_hecc.c                |   8 --
 drivers/net/can/usb/mcba_usb.c           |   8 --
 drivers/net/can/usb/usb_8dev.c           |  11 --
 drivers/net/can/xilinx_can.c             |  10 +-
 include/linux/can/dev.h                  |  10 --
 include/linux/can/led.h                  |  51 ---------
 24 files changed, 2 insertions(+), 373 deletions(-)
 delete mode 100644 drivers/net/can/led.c
 delete mode 100644 include/linux/can/led.h

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index ac760fd39282..b2dcc1e5a388 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -69,27 +69,10 @@ config CAN_CALC_BITTIMING
 	  source clock frequencies. Disabling saves some space, but then the
 	  bit-timing parameters must be specified directly using the Netlink
 	  arguments "tq", "prop_seg", "phase_seg1", "phase_seg2" and "sjw".
 	  If unsure, say Y.
 
-config CAN_LEDS
-	bool "Enable LED triggers for Netlink based drivers"
-	depends on LEDS_CLASS
-	# The netdev trigger (LEDS_TRIGGER_NETDEV) should be able to do
-	# everything that this driver is doing. This is marked as broken
-	# because it uses stuff that is intended to be changed or removed.
-	# Please consider switching to the netdev trigger and confirm it
-	# fulfills your needs instead of fixing this driver.
-	depends on BROKEN
-	select LEDS_TRIGGERS
-	help
-	  This option adds two LED triggers for packet receive and transmit
-	  events on each supported CAN device.
-
-	  Say Y here if you are working on a system with led-class supported
-	  LEDs and you want to use them as canbus activity indicators.
-
 config CAN_AT91
 	tristate "Atmel AT91 onchip CAN controller"
 	depends on (ARCH_AT91 || COMPILE_TEST) && HAS_IOMEM
 	help
 	  This is a driver for the SoC CAN controller in Atmel's AT91SAM9263
diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index a00655ccda02..7b7f103d88d5 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -21,11 +21,10 @@
 #include <linux/string.h>
 #include <linux/types.h>
 
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
-#include <linux/can/led.h>
 
 #define AT91_MB_MASK(i)		((1 << (i)) - 1)
 
 /* Common registers */
 enum at91_reg {
@@ -616,12 +615,10 @@ static void at91_read_msg(struct net_device *dev, unsigned int mb)
 	stats->rx_packets++;
 	if (!(cf->can_id & CAN_RTR_FLAG))
 		stats->rx_bytes += cf->len;
 
 	netif_receive_skb(skb);
-
-	can_led_event(dev, CAN_LED_EVENT_RX);
 }
 
 /**
  * at91_poll_rx - read multiple CAN messages from mailboxes
  * @dev: net device
@@ -852,11 +849,10 @@ static void at91_irq_tx(struct net_device *dev, u32 reg_sr)
 			dev->stats.tx_bytes +=
 				can_get_echo_skb(dev,
 						 mb - get_mb_tx_first(priv),
 						 NULL);
 			dev->stats.tx_packets++;
-			can_led_event(dev, CAN_LED_EVENT_TX);
 		}
 	}
 
 	/* restart queue if we don't have a wrap around but restart if
 	 * we get a TX int for the last can frame directly before a
@@ -1099,12 +1095,10 @@ static int at91_open(struct net_device *dev)
 			dev->name, dev)) {
 		err = -EAGAIN;
 		goto out_close;
 	}
 
-	can_led_event(dev, CAN_LED_EVENT_OPEN);
-
 	/* start chip and queuing */
 	at91_chip_start(dev);
 	napi_enable(&priv->napi);
 	netif_start_queue(dev);
 
@@ -1131,12 +1125,10 @@ static int at91_close(struct net_device *dev)
 	free_irq(dev->irq, dev);
 	clk_disable_unprepare(priv->clk);
 
 	close_candev(dev);
 
-	can_led_event(dev, CAN_LED_EVENT_STOP);
-
 	return 0;
 }
 
 static int at91_set_mode(struct net_device *dev, enum can_mode mode)
 {
@@ -1329,12 +1321,10 @@ static int at91_can_probe(struct platform_device *pdev)
 	if (err) {
 		dev_err(&pdev->dev, "registering netdev failed\n");
 		goto exit_free;
 	}
 
-	devm_can_led_init(dev);
-
 	dev_info(&pdev->dev, "device registered (reg_base=%p, irq=%d)\n",
 		 priv->reg_base, dev->irq);
 
 	return 0;
 
diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index faa217f26771..5501c4ed745a 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -38,11 +38,10 @@
 #include <linux/pinctrl/consumer.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
-#include <linux/can/led.h>
 
 #include "c_can.h"
 
 /* Number of interface registers */
 #define IF_ENUM_REG_LEN		11
@@ -757,11 +756,10 @@ static void c_can_do_tx(struct net_device *dev)
 		netif_wake_queue(priv->dev);
 	}
 
 	stats->tx_bytes += bytes;
 	stats->tx_packets += pkts;
-	can_led_event(dev, CAN_LED_EVENT_TX);
 
 	tail = c_can_get_tx_tail(tx_ring);
 
 	if (tail == 0) {
 		u8 head = c_can_get_tx_head(tx_ring);
@@ -904,13 +902,10 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 		n = c_can_read_objects(dev, priv, toread, quota);
 		pkts += n;
 		quota -= n;
 	}
 
-	if (pkts)
-		can_led_event(dev, CAN_LED_EVENT_RX);
-
 	return pkts;
 }
 
 static int c_can_handle_state_change(struct net_device *dev,
 				     enum c_can_bus_error_types error_type)
@@ -1180,12 +1175,10 @@ static int c_can_open(struct net_device *dev)
 	/* start the c_can controller */
 	err = c_can_start(dev);
 	if (err)
 		goto exit_start_fail;
 
-	can_led_event(dev, CAN_LED_EVENT_OPEN);
-
 	napi_enable(&priv->napi);
 	/* enable status change, error and module interrupts */
 	c_can_irq_control(priv, true);
 	netif_start_queue(dev);
 
@@ -1212,12 +1205,10 @@ static int c_can_close(struct net_device *dev)
 	close_candev(dev);
 
 	c_can_reset_ram(priv, false);
 	c_can_pm_runtime_put_sync(priv);
 
-	can_led_event(dev, CAN_LED_EVENT_STOP);
-
 	return 0;
 }
 
 struct net_device *alloc_c_can_dev(int msg_obj_num)
 {
@@ -1376,12 +1367,11 @@ int register_c_can_dev(struct net_device *dev)
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &c_can_netdev_ops;
 	c_can_set_ethtool_ops(dev);
 
 	err = register_candev(dev);
-	if (!err)
-		devm_can_led_init(dev);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(register_c_can_dev);
 
 void unregister_c_can_dev(struct net_device *dev)
diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 2ada097d1ede..64990bf20fdc 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -27,11 +27,10 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/can/error.h>
-#include <linux/can/led.h>
 #include <linux/pm_runtime.h>
 
 #include "ctucanfd.h"
 #include "ctucanfd_kregs.h"
 #include "ctucanfd_kframe.h"
@@ -955,13 +954,10 @@ static int ctucan_rx_poll(struct napi_struct *napi, int quota)
 
 		/* Clear Data Overrun */
 		ctucan_write32(priv, CTUCANFD_COMMAND, REG_COMMAND_CDO);
 	}
 
-	if (work_done)
-		can_led_event(ndev, CAN_LED_EVENT_RX);
-
 	if (!framecnt && res != 0) {
 		if (napi_complete_done(napi, work_done)) {
 			/* Clear and enable RBNEI. It is level-triggered, so
 			 * there is no race condition.
 			 */
@@ -1077,12 +1073,10 @@ static void ctucan_tx_interrupt(struct net_device *ndev)
 			 */
 			ctucan_write32(priv, CTUCANFD_INT_STAT, REG_INT_STAT_TXBHCI);
 		}
 	} while (some_buffers_processed);
 
-	can_led_event(ndev, CAN_LED_EVENT_TX);
-
 	spin_lock_irqsave(&priv->tx_lock, flags);
 
 	/* Check if at least one TX buffer is free */
 	if (CTU_CAN_FD_TXTNF(priv))
 		netif_wake_queue(ndev);
@@ -1234,11 +1228,10 @@ static int ctucan_open(struct net_device *ndev)
 		netdev_err(ndev, "ctucan_chip_start failed!\n");
 		goto err_chip_start;
 	}
 
 	netdev_info(ndev, "ctu_can_fd device registered\n");
-	can_led_event(ndev, CAN_LED_EVENT_OPEN);
 	napi_enable(&priv->napi);
 	netif_start_queue(ndev);
 
 	return 0;
 
@@ -1267,11 +1260,10 @@ static int ctucan_close(struct net_device *ndev)
 	napi_disable(&priv->napi);
 	ctucan_chip_stop(ndev);
 	free_irq(ndev->irq, ndev);
 	close_candev(ndev);
 
-	can_led_event(ndev, CAN_LED_EVENT_STOP);
 	pm_runtime_put(priv->dev);
 
 	return 0;
 }
 
@@ -1432,12 +1424,10 @@ int ctucan_probe_common(struct device *dev, void __iomem *addr, int irq, unsigne
 	if (ret) {
 		dev_err(dev, "fail to register failed (err=%d)\n", ret);
 		goto err_deviceoff;
 	}
 
-	devm_can_led_init(ndev);
-
 	pm_runtime_put(dev);
 
 	netdev_dbg(ndev, "mem_base=0x%p irq=%d clock=%d, no. of txt buffers:%d\n",
 		   priv->mem_base, ndev->irq, priv->can.clock.freq, priv->ntxbufs);
 
diff --git a/drivers/net/can/dev/Makefile b/drivers/net/can/dev/Makefile
index 3e2e207861fc..af2901db473c 100644
--- a/drivers/net/can/dev/Makefile
+++ b/drivers/net/can/dev/Makefile
@@ -5,7 +5,5 @@ can-dev-y			+= bittiming.o
 can-dev-y			+= dev.o
 can-dev-y			+= length.o
 can-dev-y			+= netlink.o
 can-dev-y			+= rx-offload.o
 can-dev-y                       += skb.o
-
-can-dev-$(CONFIG_CAN_LEDS)	+= led.o
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index e7ab45f1c43b..96c9d9db00cf 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -12,11 +12,10 @@
 #include <linux/workqueue.h>
 #include <linux/can.h>
 #include <linux/can/can-ml.h>
 #include <linux/can/dev.h>
 #include <linux/can/skb.h>
-#include <linux/can/led.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
 
 #define MOD_DESC "CAN device driver interface"
 
@@ -510,12 +509,10 @@ EXPORT_SYMBOL_GPL(safe_candev_priv);
 
 static __init int can_dev_init(void)
 {
 	int err;
 
-	can_led_notifier_init();
-
 	err = can_netlink_register();
 	if (!err)
 		pr_info(MOD_DESC "\n");
 
 	return err;
@@ -523,11 +520,9 @@ static __init int can_dev_init(void)
 module_init(can_dev_init);
 
 static __exit void can_dev_exit(void)
 {
 	can_netlink_unregister();
-
-	can_led_notifier_exit();
 }
 module_exit(can_dev_exit);
 
 MODULE_ALIAS_RTNL_LINK("can");
diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
index 6d0dc18c03e7..89933e65eae6 100644
--- a/drivers/net/can/dev/rx-offload.c
+++ b/drivers/net/can/dev/rx-offload.c
@@ -68,12 +68,10 @@ static int can_rx_offload_napi_poll(struct napi_struct *napi, int quota)
 		/* Check if there was another interrupt */
 		if (!skb_queue_empty(&offload->skb_queue))
 			napi_reschedule(&offload->napi);
 	}
 
-	can_led_event(offload->dev, CAN_LED_EVENT_RX);
-
 	return work_done;
 }
 
 static inline void
 __skb_queue_add_sort(struct sk_buff_head *head, struct sk_buff *new,
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index fe9bda0f5ec4..d060088047f1 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -12,11 +12,10 @@
 #include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/bitfield.h>
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
-#include <linux/can/led.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -1079,11 +1078,10 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		handled = IRQ_HANDLED;
 		stats->tx_bytes +=
 			can_rx_offload_get_echo_skb(&priv->offload, 0,
 						    reg_ctrl << 16, NULL);
 		stats->tx_packets++;
-		can_led_event(dev, CAN_LED_EVENT_TX);
 
 		/* after sending a RTR frame MB is in RX mode */
 		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
 			    &priv->tx_mb->can_ctrl);
 		flexcan_write64(priv, priv->tx_mask, &regs->iflag1);
@@ -1736,12 +1734,10 @@ static int flexcan_open(struct net_device *dev)
 			goto out_free_irq_boff;
 	}
 
 	flexcan_chip_interrupts_enable(dev);
 
-	can_led_event(dev, CAN_LED_EVENT_OPEN);
-
 	netif_start_queue(dev);
 
 	return 0;
 
  out_free_irq_boff:
@@ -1783,12 +1779,10 @@ static int flexcan_close(struct net_device *dev)
 	flexcan_transceiver_disable(priv);
 	close_candev(dev);
 
 	pm_runtime_put(priv->dev);
 
-	can_led_event(dev, CAN_LED_EVENT_STOP);
-
 	return 0;
 }
 
 static int flexcan_set_mode(struct net_device *dev, enum can_mode mode)
 {
@@ -2187,11 +2181,10 @@ static int flexcan_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "setup stop mode failed\n");
 		goto failed_setup_stop_mode;
 	}
 
 	of_can_transceiver(dev);
-	devm_can_led_init(dev);
 
 	return 0;
 
  failed_setup_stop_mode:
 	unregister_flexcandev(dev);
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index b0a3473f211d..968ed6d7316b 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -343,13 +343,10 @@ static int ifi_canfd_do_rx_poll(struct net_device *ndev, int quota)
 		quota--;
 		pkts++;
 		rxst = readl(priv->base + IFI_CANFD_RXSTCMD);
 	}
 
-	if (pkts)
-		can_led_event(ndev, CAN_LED_EVENT_RX);
-
 	return pkts;
 }
 
 static int ifi_canfd_handle_lost_msg(struct net_device *ndev)
 {
@@ -624,11 +621,10 @@ static irqreturn_t ifi_canfd_isr(int irq, void *dev_id)
 
 	/* TX IRQ */
 	if (isr & IFI_CANFD_INTERRUPT_TXFIFO_REMOVE) {
 		stats->tx_bytes += can_get_echo_skb(ndev, 0, NULL);
 		stats->tx_packets++;
-		can_led_event(ndev, CAN_LED_EVENT_TX);
 	}
 
 	if (isr & tx_irq_mask)
 		netif_wake_queue(ndev);
 
@@ -828,11 +824,10 @@ static int ifi_canfd_open(struct net_device *ndev)
 		goto err_irq;
 	}
 
 	ifi_canfd_start(ndev);
 
-	can_led_event(ndev, CAN_LED_EVENT_OPEN);
 	napi_enable(&priv->napi);
 	netif_start_queue(ndev);
 
 	return 0;
 err_irq:
@@ -851,12 +846,10 @@ static int ifi_canfd_close(struct net_device *ndev)
 
 	free_irq(ndev->irq, ndev);
 
 	close_candev(ndev);
 
-	can_led_event(ndev, CAN_LED_EVENT_STOP);
-
 	return 0;
 }
 
 static netdev_tx_t ifi_canfd_start_xmit(struct sk_buff *skb,
 					struct net_device *ndev)
@@ -1002,12 +995,10 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dev, "Failed to register (ret=%d)\n", ret);
 		goto err_reg;
 	}
 
-	devm_can_led_init(ndev);
-
 	dev_info(dev, "Driver registered: regs=%p, irq=%d, clock=%d\n",
 		 priv->base, ndev->irq, priv->can.clock.freq);
 
 	return 0;
 
diff --git a/drivers/net/can/led.c b/drivers/net/can/led.c
deleted file mode 100644
index db14897f8e16..000000000000
--- a/drivers/net/can/led.c
+++ /dev/null
@@ -1,140 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2012, Fabio Baltieri <fabio.baltieri@gmail.com>
- * Copyright 2012, Kurt Van Dijck <kurt.van.dijck@eia.be>
- */
-
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/netdevice.h>
-#include <linux/can/dev.h>
-
-#include <linux/can/led.h>
-
-static unsigned long led_delay = 50;
-module_param(led_delay, ulong, 0644);
-MODULE_PARM_DESC(led_delay,
-		"blink delay time for activity leds (msecs, default: 50).");
-
-/* Trigger a LED event in response to a CAN device event */
-void can_led_event(struct net_device *netdev, enum can_led_event event)
-{
-	struct can_priv *priv = netdev_priv(netdev);
-
-	switch (event) {
-	case CAN_LED_EVENT_OPEN:
-		led_trigger_event(priv->tx_led_trig, LED_FULL);
-		led_trigger_event(priv->rx_led_trig, LED_FULL);
-		led_trigger_event(priv->rxtx_led_trig, LED_FULL);
-		break;
-	case CAN_LED_EVENT_STOP:
-		led_trigger_event(priv->tx_led_trig, LED_OFF);
-		led_trigger_event(priv->rx_led_trig, LED_OFF);
-		led_trigger_event(priv->rxtx_led_trig, LED_OFF);
-		break;
-	case CAN_LED_EVENT_TX:
-		if (led_delay) {
-			led_trigger_blink_oneshot(priv->tx_led_trig,
-						  &led_delay, &led_delay, 1);
-			led_trigger_blink_oneshot(priv->rxtx_led_trig,
-						  &led_delay, &led_delay, 1);
-		}
-		break;
-	case CAN_LED_EVENT_RX:
-		if (led_delay) {
-			led_trigger_blink_oneshot(priv->rx_led_trig,
-						  &led_delay, &led_delay, 1);
-			led_trigger_blink_oneshot(priv->rxtx_led_trig,
-						  &led_delay, &led_delay, 1);
-		}
-		break;
-	}
-}
-EXPORT_SYMBOL_GPL(can_led_event);
-
-static void can_led_release(struct device *gendev, void *res)
-{
-	struct can_priv *priv = netdev_priv(to_net_dev(gendev));
-
-	led_trigger_unregister_simple(priv->tx_led_trig);
-	led_trigger_unregister_simple(priv->rx_led_trig);
-	led_trigger_unregister_simple(priv->rxtx_led_trig);
-}
-
-/* Register CAN LED triggers for a CAN device
- *
- * This is normally called from a driver's probe function
- */
-void devm_can_led_init(struct net_device *netdev)
-{
-	struct can_priv *priv = netdev_priv(netdev);
-	void *res;
-
-	res = devres_alloc(can_led_release, 0, GFP_KERNEL);
-	if (!res) {
-		netdev_err(netdev, "cannot register LED triggers\n");
-		return;
-	}
-
-	snprintf(priv->tx_led_trig_name, sizeof(priv->tx_led_trig_name),
-		 "%s-tx", netdev->name);
-	snprintf(priv->rx_led_trig_name, sizeof(priv->rx_led_trig_name),
-		 "%s-rx", netdev->name);
-	snprintf(priv->rxtx_led_trig_name, sizeof(priv->rxtx_led_trig_name),
-		 "%s-rxtx", netdev->name);
-
-	led_trigger_register_simple(priv->tx_led_trig_name,
-				    &priv->tx_led_trig);
-	led_trigger_register_simple(priv->rx_led_trig_name,
-				    &priv->rx_led_trig);
-	led_trigger_register_simple(priv->rxtx_led_trig_name,
-				    &priv->rxtx_led_trig);
-
-	devres_add(&netdev->dev, res);
-}
-EXPORT_SYMBOL_GPL(devm_can_led_init);
-
-/* NETDEV rename notifier to rename the associated led triggers too */
-static int can_led_notifier(struct notifier_block *nb, unsigned long msg,
-			    void *ptr)
-{
-	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
-	struct can_priv *priv = safe_candev_priv(netdev);
-	char name[CAN_LED_NAME_SZ];
-
-	if (!priv)
-		return NOTIFY_DONE;
-
-	if (!priv->tx_led_trig || !priv->rx_led_trig || !priv->rxtx_led_trig)
-		return NOTIFY_DONE;
-
-	if (msg == NETDEV_CHANGENAME) {
-		snprintf(name, sizeof(name), "%s-tx", netdev->name);
-		led_trigger_rename_static(name, priv->tx_led_trig);
-
-		snprintf(name, sizeof(name), "%s-rx", netdev->name);
-		led_trigger_rename_static(name, priv->rx_led_trig);
-
-		snprintf(name, sizeof(name), "%s-rxtx", netdev->name);
-		led_trigger_rename_static(name, priv->rxtx_led_trig);
-	}
-
-	return NOTIFY_DONE;
-}
-
-/* notifier block for netdevice event */
-static struct notifier_block can_netdev_notifier __read_mostly = {
-	.notifier_call = can_led_notifier,
-};
-
-int __init can_led_notifier_init(void)
-{
-	return register_netdevice_notifier(&can_netdev_notifier);
-}
-
-void __exit can_led_notifier_exit(void)
-{
-	unregister_netdevice_notifier(&can_netdev_notifier);
-}
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e6d2da4a9f41..bebf44a5e431 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -563,13 +563,10 @@ static int m_can_do_rx_poll(struct net_device *dev, int quota)
 		quota--;
 		pkts++;
 		rxfs = m_can_read(cdev, M_CAN_RXF0S);
 	}
 
-	if (pkts)
-		can_led_event(dev, CAN_LED_EVENT_RX);
-
 	return pkts;
 }
 
 static int m_can_handle_lost_msg(struct net_device *dev)
 {
@@ -1085,21 +1082,18 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 			u32 timestamp = 0;
 
 			if (cdev->is_peripheral)
 				timestamp = m_can_get_timestamp(cdev);
 			m_can_tx_update_stats(cdev, 0, timestamp);
-
-			can_led_event(dev, CAN_LED_EVENT_TX);
 			netif_wake_queue(dev);
 		}
 	} else  {
 		if (ir & IR_TEFN) {
 			/* New TX FIFO Element arrived */
 			if (m_can_echo_tx_event(dev) != 0)
 				goto out_fail;
 
-			can_led_event(dev, CAN_LED_EVENT_TX);
 			if (netif_queue_stopped(dev) &&
 			    !m_can_tx_fifo_full(cdev))
 				netif_wake_queue(dev);
 		}
 	}
@@ -1572,11 +1566,10 @@ static int m_can_close(struct net_device *dev)
 
 	if (cdev->is_peripheral)
 		can_rx_offload_disable(&cdev->offload);
 
 	close_candev(dev);
-	can_led_event(dev, CAN_LED_EVENT_STOP);
 
 	phy_power_off(cdev->transceiver);
 
 	return 0;
 }
@@ -1816,12 +1809,10 @@ static int m_can_open(struct net_device *dev)
 	}
 
 	/* start the m_can controller */
 	m_can_start(dev);
 
-	can_led_event(dev, CAN_LED_EVENT_OPEN);
-
 	if (!cdev->is_peripheral)
 		napi_enable(&cdev->napi);
 
 	netif_start_queue(dev);
 
@@ -2005,12 +1996,10 @@ int m_can_class_register(struct m_can_classdev *cdev)
 		dev_err(cdev->dev, "registering %s failed (err=%d)\n",
 			cdev->net->name, ret);
 		goto rx_offload_del;
 	}
 
-	devm_can_led_init(cdev->net);
-
 	of_can_transceiver(cdev->net);
 
 	dev_info(cdev->dev, "%s device registered (irq=%d, version=%d)\n",
 		 KBUILD_MODNAME, cdev->net->irq, cdev->version);
 
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 2c5d40997168..dd08c59aec62 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -5,11 +5,10 @@
 
 #ifndef _CAN_M_CAN_H_
 #define _CAN_M_CAN_H_
 
 #include <linux/can/core.h>
-#include <linux/can/led.h>
 #include <linux/can/rx-offload.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/freezer.h>
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 33e37395379d..c3e3c07f8804 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -10,11 +10,10 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/errno.h>
 #include <linux/netdevice.h>
 #include <linux/platform_device.h>
-#include <linux/can/led.h>
 #include <linux/can/dev.h>
 #include <linux/clk.h>
 #include <linux/of.h>
 
 #define RCAR_CAN_DRV_NAME	"rcar_can"
@@ -387,11 +386,10 @@ static void rcar_can_tx_done(struct net_device *ndev)
 		netif_wake_queue(ndev);
 	}
 	/* Clear interrupt */
 	isr = readb(&priv->regs->isr);
 	writeb(isr & ~RCAR_CAN_ISR_TXFF, &priv->regs->isr);
-	can_led_event(ndev, CAN_LED_EVENT_TX);
 }
 
 static irqreturn_t rcar_can_interrupt(int irq, void *dev_id)
 {
 	struct net_device *ndev = dev_id;
@@ -529,11 +527,10 @@ static int rcar_can_open(struct net_device *ndev)
 	if (err) {
 		netdev_err(ndev, "request_irq(%d) failed, error %d\n",
 			   ndev->irq, err);
 		goto out_close;
 	}
-	can_led_event(ndev, CAN_LED_EVENT_OPEN);
 	rcar_can_start(ndev);
 	netif_start_queue(ndev);
 	return 0;
 out_close:
 	napi_disable(&priv->napi);
@@ -579,11 +576,10 @@ static int rcar_can_close(struct net_device *ndev)
 	free_irq(ndev->irq, ndev);
 	napi_disable(&priv->napi);
 	clk_disable_unprepare(priv->can_clk);
 	clk_disable_unprepare(priv->clk);
 	close_candev(ndev);
-	can_led_event(ndev, CAN_LED_EVENT_STOP);
 	return 0;
 }
 
 static netdev_tx_t rcar_can_start_xmit(struct sk_buff *skb,
 				       struct net_device *ndev)
@@ -664,12 +660,10 @@ static void rcar_can_rx_pkt(struct rcar_can_priv *priv)
 
 		stats->rx_bytes += cf->len;
 	}
 	stats->rx_packets++;
 
-	can_led_event(priv->ndev, CAN_LED_EVENT_RX);
-
 	netif_receive_skb(skb);
 }
 
 static int rcar_can_rx_poll(struct napi_struct *napi, int quota)
 {
@@ -810,12 +804,10 @@ static int rcar_can_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "register_candev() failed, error %d\n",
 			err);
 		goto fail_candev;
 	}
 
-	devm_can_led_init(ndev);
-
 	dev_info(&pdev->dev, "device registered (IRQ%d)\n", ndev->irq);
 
 	return 0;
 fail_candev:
 	netif_napi_del(&priv->napi);
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 1e121e04208c..d97fc2a08d63 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -27,11 +27,10 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/errno.h>
 #include <linux/netdevice.h>
 #include <linux/platform_device.h>
-#include <linux/can/led.h>
 #include <linux/can/dev.h>
 #include <linux/clk.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/bitmap.h>
@@ -1126,11 +1125,10 @@ static void rcar_canfd_tx_done(struct net_device *ndev)
 	} while (1);
 
 	/* Clear interrupt */
 	rcar_canfd_write(priv->base, RCANFD_CFSTS(gpriv, ch, RCANFD_CFFIFO_IDX),
 			 sts & ~RCANFD_CFSTS_CFTXIF);
-	can_led_event(ndev, CAN_LED_EVENT_TX);
 }
 
 static void rcar_canfd_handle_global_err(struct rcar_canfd_global *gpriv, u32 ch)
 {
 	struct rcar_canfd_channel *priv = gpriv->ch[ch];
@@ -1417,11 +1415,10 @@ static int rcar_canfd_open(struct net_device *ndev)
 	napi_enable(&priv->napi);
 	err = rcar_canfd_start(ndev);
 	if (err)
 		goto out_close;
 	netif_start_queue(ndev);
-	can_led_event(ndev, CAN_LED_EVENT_OPEN);
 	return 0;
 out_close:
 	napi_disable(&priv->napi);
 	close_candev(ndev);
 out_can_clock:
@@ -1467,11 +1464,10 @@ static int rcar_canfd_close(struct net_device *ndev)
 	netif_stop_queue(ndev);
 	rcar_canfd_stop(ndev);
 	napi_disable(&priv->napi);
 	clk_disable_unprepare(gpriv->can_clk);
 	close_candev(ndev);
-	can_led_event(ndev, CAN_LED_EVENT_STOP);
 	return 0;
 }
 
 static netdev_tx_t rcar_canfd_start_xmit(struct sk_buff *skb,
 					 struct net_device *ndev)
@@ -1617,12 +1613,10 @@ static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 	/* Write 0xff to RFPC to increment the CPU-side
 	 * pointer of the Rx FIFO
 	 */
 	rcar_canfd_write(priv->base, RCANFD_RFPCTR(gpriv, ridx), 0xff);
 
-	can_led_event(priv->ndev, CAN_LED_EVENT_RX);
-
 	if (!(cf->can_id & CAN_RTR_FLAG))
 		stats->rx_bytes += cf->len;
 	stats->rx_packets++;
 	netif_receive_skb(skb);
 }
@@ -1790,11 +1784,10 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 
 	netif_napi_add(ndev, &priv->napi, rcar_canfd_rx_poll,
 		       RCANFD_NAPI_WEIGHT);
 	spin_lock_init(&priv->tx_lock);
-	devm_can_led_init(ndev);
 	gpriv->ch[priv->channel] = priv;
 	err = register_candev(ndev);
 	if (err) {
 		dev_err(&pdev->dev,
 			"register_candev() failed, error %d\n", err);
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 966316479485..2e7638f98cf1 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -58,11 +58,10 @@
 #include <linux/skbuff.h>
 #include <linux/delay.h>
 
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
-#include <linux/can/led.h>
 
 #include "sja1000.h"
 
 #define DRV_NAME "sja1000"
 
@@ -381,12 +380,10 @@ static void sja1000_rx(struct net_device *dev)
 
 	/* release receive buffer */
 	sja1000_write_cmdreg(priv, CMD_RRB);
 
 	netif_rx(skb);
-
-	can_led_event(dev, CAN_LED_EVENT_RX);
 }
 
 static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
@@ -529,11 +526,10 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 				/* transmission complete */
 				stats->tx_bytes += can_get_echo_skb(dev, 0, NULL);
 				stats->tx_packets++;
 			}
 			netif_wake_queue(dev);
-			can_led_event(dev, CAN_LED_EVENT_TX);
 		}
 		if (isrc & IRQ_RI) {
 			/* receive interrupt */
 			while (status & SR_RBS) {
 				sja1000_rx(dev);
@@ -585,12 +581,10 @@ static int sja1000_open(struct net_device *dev)
 	}
 
 	/* init and start chi */
 	sja1000_start(dev);
 
-	can_led_event(dev, CAN_LED_EVENT_OPEN);
-
 	netif_start_queue(dev);
 
 	return 0;
 }
 
@@ -604,12 +598,10 @@ static int sja1000_close(struct net_device *dev)
 	if (!(priv->flags & SJA1000_CUSTOM_IRQ_HANDLER))
 		free_irq(dev->irq, (void *)dev);
 
 	close_candev(dev);
 
-	can_led_event(dev, CAN_LED_EVENT_STOP);
-
 	return 0;
 }
 
 struct net_device *alloc_sja1000dev(int sizeof_priv)
 {
@@ -671,13 +663,10 @@ int register_sja1000dev(struct net_device *dev)
 	set_reset_mode(dev);
 	chipset_init(dev);
 
 	ret =  register_candev(dev);
 
-	if (!ret)
-		devm_can_led_init(dev);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(register_sja1000dev);
 
 void unregister_sja1000dev(struct net_device *dev)
diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index a5b2952b8d0f..ebc4ebb44c98 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -14,11 +14,10 @@
  * Copyright 2007
  */
 
 #include <linux/can/core.h>
 #include <linux/can/dev.h>
-#include <linux/can/led.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/freezer.h>
@@ -352,12 +351,10 @@ static void hi3110_hw_rx(struct spi_device *spi)
 
 		priv->net->stats.rx_bytes += frame->len;
 	}
 	priv->net->stats.rx_packets++;
 
-	can_led_event(priv->net, CAN_LED_EVENT_RX);
-
 	netif_rx(skb);
 }
 
 static void hi3110_hw_sleep(struct spi_device *spi)
 {
@@ -565,12 +562,10 @@ static int hi3110_stop(struct net_device *net)
 
 	priv->can.state = CAN_STATE_STOPPED;
 
 	mutex_unlock(&priv->hi3110_lock);
 
-	can_led_event(net, CAN_LED_EVENT_STOP);
-
 	return 0;
 }
 
 static void hi3110_tx_work_handler(struct work_struct *ws)
 {
@@ -723,11 +718,10 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 		}
 
 		if (priv->tx_busy && statf & HI3110_STAT_TXMTY) {
 			net->stats.tx_packets++;
 			net->stats.tx_bytes += can_get_echo_skb(net, 0, NULL);
-			can_led_event(net, CAN_LED_EVENT_TX);
 			priv->tx_busy = false;
 			netif_wake_queue(net);
 		}
 
 		if (intf == 0)
@@ -781,11 +775,10 @@ static int hi3110_open(struct net_device *net)
 
 	ret = hi3110_set_normal_mode(spi);
 	if (ret)
 		goto out_free_wq;
 
-	can_led_event(net, CAN_LED_EVENT_OPEN);
 	netif_wake_queue(net);
 	mutex_unlock(&priv->hi3110_lock);
 
 	return 0;
 
@@ -929,11 +922,10 @@ static int hi3110_can_probe(struct spi_device *spi)
 
 	ret = register_candev(net);
 	if (ret)
 		goto error_probe;
 
-	devm_can_led_init(net);
 	netdev_info(net, "%x successfully initialized.\n", priv->model);
 
 	return 0;
 
  error_probe:
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index fc747bff5eeb..666a4505a55a 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -20,11 +20,10 @@
  */
 
 #include <linux/bitfield.h>
 #include <linux/can/core.h>
 #include <linux/can/dev.h>
-#include <linux/can/led.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/freezer.h>
@@ -736,12 +735,10 @@ static void mcp251x_hw_rx(struct spi_device *spi, int buf_idx)
 
 		priv->net->stats.rx_bytes += frame->len;
 	}
 	priv->net->stats.rx_packets++;
 
-	can_led_event(priv->net, CAN_LED_EVENT_RX);
-
 	netif_rx(skb);
 }
 
 static void mcp251x_hw_sleep(struct spi_device *spi)
 {
@@ -971,12 +968,10 @@ static int mcp251x_stop(struct net_device *net)
 
 	priv->can.state = CAN_STATE_STOPPED;
 
 	mutex_unlock(&priv->mcp_lock);
 
-	can_led_event(net, CAN_LED_EVENT_STOP);
-
 	return 0;
 }
 
 static void mcp251x_error_skb(struct net_device *net, int can_id, int data1)
 {
@@ -1175,11 +1170,10 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 
 		if (intf == 0)
 			break;
 
 		if (intf & CANINTF_TX) {
-			can_led_event(net, CAN_LED_EVENT_TX);
 			if (priv->tx_busy) {
 				net->stats.tx_packets++;
 				net->stats.tx_bytes += can_get_echo_skb(net, 0,
 									NULL);
 				priv->tx_busy = false;
@@ -1230,12 +1224,10 @@ static int mcp251x_open(struct net_device *net)
 		goto out_free_irq;
 	ret = mcp251x_set_normal_mode(spi);
 	if (ret)
 		goto out_free_irq;
 
-	can_led_event(net, CAN_LED_EVENT_OPEN);
-
 	netif_wake_queue(net);
 	mutex_unlock(&priv->mcp_lock);
 
 	return 0;
 
@@ -1401,12 +1393,10 @@ static int mcp251x_can_probe(struct spi_device *spi)
 
 	ret = register_candev(net);
 	if (ret)
 		goto error_probe;
 
-	devm_can_led_init(net);
-
 	ret = mcp251x_gpio_setup(priv);
 	if (ret)
 		goto error_probe;
 
 	netdev_info(net, "MCP%x successfully initialized.\n", priv->model);
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 25d6d81ab4f4..155b90f6c767 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -49,11 +49,10 @@
 
 #include <linux/netdevice.h>
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
-#include <linux/can/led.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -514,12 +513,10 @@ static void sun4i_can_rx(struct net_device *dev)
 	cf->can_id = id;
 
 	sun4i_can_write_cmdreg(priv, SUN4I_CMD_RELEASE_RBUF);
 
 	netif_rx(skb);
-
-	can_led_event(dev, CAN_LED_EVENT_RX);
 }
 
 static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 {
 	struct sun4ican_priv *priv = netdev_priv(dev);
@@ -662,11 +659,10 @@ static irqreturn_t sun4i_can_interrupt(int irq, void *dev_id)
 		if (isrc & SUN4I_INT_TBUF_VLD) {
 			/* transmission complete interrupt */
 			stats->tx_bytes += can_get_echo_skb(dev, 0, NULL);
 			stats->tx_packets++;
 			netif_wake_queue(dev);
-			can_led_event(dev, CAN_LED_EVENT_TX);
 		}
 		if ((isrc & SUN4I_INT_RBUF_VLD) &&
 		    !(isrc & SUN4I_INT_DATA_OR)) {
 			/* receive interrupt - don't read if overrun occurred */
 			while (status & SUN4I_STA_RBUF_RDY) {
@@ -727,11 +723,10 @@ static int sun4ican_open(struct net_device *dev)
 	if (err) {
 		netdev_err(dev, "could not start CAN peripheral\n");
 		goto exit_can_start;
 	}
 
-	can_led_event(dev, CAN_LED_EVENT_OPEN);
 	netif_start_queue(dev);
 
 	return 0;
 
 exit_can_start:
@@ -754,11 +749,10 @@ static int sun4ican_close(struct net_device *dev)
 	clk_disable_unprepare(priv->clk);
 	reset_control_assert(priv->reset);
 
 	free_irq(dev->irq, dev);
 	close_candev(dev);
-	can_led_event(dev, CAN_LED_EVENT_STOP);
 
 	return 0;
 }
 
 static const struct net_device_ops sun4ican_netdev_ops = {
@@ -881,11 +875,10 @@ static int sun4ican_probe(struct platform_device *pdev)
 	if (err) {
 		dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
 			DRV_NAME, err);
 		goto exit_free;
 	}
-	devm_can_led_init(dev);
 
 	dev_info(&pdev->dev, "device registered (base=%p, irq=%d)\n",
 		 priv->base, dev->irq);
 
 	return 0;
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index bb3f2e3b004c..debe17bfd0f0 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -32,11 +32,10 @@
 #include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
 
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
-#include <linux/can/led.h>
 #include <linux/can/rx-offload.h>
 
 #define DRV_NAME "ti_hecc"
 #define HECC_MODULE_VERSION     "0.7"
 MODULE_VERSION(HECC_MODULE_VERSION);
@@ -757,11 +756,10 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
 			stamp = hecc_read_stamp(priv, mbxno);
 			stats->tx_bytes +=
 				can_rx_offload_get_echo_skb(&priv->offload,
 							    mbxno, stamp, NULL);
 			stats->tx_packets++;
-			can_led_event(ndev, CAN_LED_EVENT_TX);
 			--priv->tx_tail;
 		}
 
 		/* restart queue if wrap-up or if queue stalled on last pkt */
 		if ((priv->tx_head == priv->tx_tail &&
@@ -812,12 +810,10 @@ static int ti_hecc_open(struct net_device *ndev)
 		ti_hecc_transceiver_switch(priv, 0);
 		free_irq(ndev->irq, ndev);
 		return err;
 	}
 
-	can_led_event(ndev, CAN_LED_EVENT_OPEN);
-
 	ti_hecc_start(ndev);
 	can_rx_offload_enable(&priv->offload);
 	netif_start_queue(ndev);
 
 	return 0;
@@ -832,12 +828,10 @@ static int ti_hecc_close(struct net_device *ndev)
 	ti_hecc_stop(ndev);
 	free_irq(ndev->irq, ndev);
 	close_candev(ndev);
 	ti_hecc_transceiver_switch(priv, 0);
 
-	can_led_event(ndev, CAN_LED_EVENT_STOP);
-
 	return 0;
 }
 
 static const struct net_device_ops ti_hecc_netdev_ops = {
 	.ndo_open		= ti_hecc_open,
@@ -952,12 +946,10 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	if (err) {
 		dev_err(&pdev->dev, "register_candev() failed\n");
 		goto probe_exit_offload;
 	}
 
-	devm_can_led_init(ndev);
-
 	dev_info(&pdev->dev, "device registered (reg_base=%p, irq=%u)\n",
 		 priv->base, (u32)ndev->irq);
 
 	return 0;
 
diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index c45a814e1de2..792ab9da317d 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -8,11 +8,10 @@
 
 #include <asm/unaligned.h>
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
-#include <linux/can/led.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
@@ -230,12 +229,10 @@ static void mcba_usb_write_bulk_callback(struct urb *urb)
 			return;
 
 		netdev->stats.tx_packets++;
 		netdev->stats.tx_bytes += can_get_echo_skb(netdev, ctx->ndx,
 							   NULL);
-
-		can_led_event(netdev, CAN_LED_EVENT_TX);
 	}
 
 	if (urb->status)
 		netdev_info(netdev, "Tx URB aborted (%d)\n", urb->status);
 
@@ -450,11 +447,10 @@ static void mcba_usb_process_can(struct mcba_priv *priv,
 
 		stats->rx_bytes += cf->len;
 	}
 	stats->rx_packets++;
 
-	can_led_event(priv->netdev, CAN_LED_EVENT_RX);
 	netif_rx(skb);
 }
 
 static void mcba_usb_process_ka_usb(struct mcba_priv *priv,
 				    struct mcba_usb_msg_ka_usb *msg)
@@ -698,11 +694,10 @@ static int mcba_usb_open(struct net_device *netdev)
 		return err;
 
 	priv->can_speed_check = true;
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
-	can_led_event(netdev, CAN_LED_EVENT_OPEN);
 	netif_start_queue(netdev);
 
 	return 0;
 }
 
@@ -730,11 +725,10 @@ static int mcba_usb_close(struct net_device *netdev)
 
 	/* Stop polling */
 	mcba_urb_unlink(priv);
 
 	close_candev(netdev);
-	can_led_event(netdev, CAN_LED_EVENT_STOP);
 
 	return 0;
 }
 
 /* Set network device mode
@@ -855,12 +849,10 @@ static int mcba_usb_probe(struct usb_interface *intf,
 	}
 
 	priv->rx_pipe = usb_rcvbulkpipe(priv->udev, in->bEndpointAddress);
 	priv->tx_pipe = usb_sndbulkpipe(priv->udev, out->bEndpointAddress);
 
-	devm_can_led_init(netdev);
-
 	/* Start USB dev only if we have successfully registered CAN device */
 	err = mcba_usb_start(priv);
 	if (err) {
 		if (err == -ENODEV)
 			netif_device_detach(priv->netdev);
diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index b638604bf1ee..f3363575bf32 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -19,11 +19,10 @@
 #include <linux/usb.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
-#include <linux/can/led.h>
 
 /* driver constants */
 #define MAX_RX_URBS			20
 #define MAX_TX_URBS			20
 #define RX_BUFFER_SIZE			64
@@ -478,12 +477,10 @@ static void usb_8dev_rx_can_msg(struct usb_8dev_priv *priv,
 			stats->rx_bytes += cf->len;
 		}
 		stats->rx_packets++;
 
 		netif_rx(skb);
-
-		can_led_event(priv->netdev, CAN_LED_EVENT_RX);
 	} else {
 		netdev_warn(priv->netdev, "frame type %d unknown",
 			 msg->type);
 	}
 
@@ -580,12 +577,10 @@ static void usb_8dev_write_bulk_callback(struct urb *urb)
 			 urb->status);
 
 	netdev->stats.tx_packets++;
 	netdev->stats.tx_bytes += can_get_echo_skb(netdev, context->echo_index, NULL);
 
-	can_led_event(netdev, CAN_LED_EVENT_TX);
-
 	/* Release context */
 	context->echo_index = MAX_TX_URBS;
 
 	netif_wake_queue(netdev);
 }
@@ -805,12 +800,10 @@ static int usb_8dev_open(struct net_device *netdev)
 	/* common open */
 	err = open_candev(netdev);
 	if (err)
 		return err;
 
-	can_led_event(netdev, CAN_LED_EVENT_OPEN);
-
 	/* finally start device */
 	err = usb_8dev_start(priv);
 	if (err) {
 		if (err == -ENODEV)
 			netif_device_detach(priv->netdev);
@@ -863,12 +856,10 @@ static int usb_8dev_close(struct net_device *netdev)
 	/* Stop polling */
 	unlink_all_urbs(priv);
 
 	close_candev(netdev);
 
-	can_led_event(netdev, CAN_LED_EVENT_STOP);
-
 	return err;
 }
 
 static const struct net_device_ops usb_8dev_netdev_ops = {
 	.ndo_open = usb_8dev_open,
@@ -972,12 +963,10 @@ static int usb_8dev_probe(struct usb_interface *intf,
 			 "firmware: %d.%d, hardware: %d.%d\n",
 			 (version>>24) & 0xff, (version>>16) & 0xff,
 			 (version>>8) & 0xff, version & 0xff);
 	}
 
-	devm_can_led_init(netdev);
-
 	return 0;
 
 cleanup_unregister_candev:
 	unregister_netdev(priv->netdev);
 
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 43f0c6a064ba..7ed6c7606702 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -24,11 +24,10 @@
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
-#include <linux/can/led.h>
 #include <linux/pm_runtime.h>
 
 #define DRIVER_NAME	"xilinx_can"
 
 /* CAN registers set */
@@ -1207,14 +1206,12 @@ static int xcan_rx_poll(struct napi_struct *napi, int quota)
 			 */
 			priv->write_reg(priv, XCAN_ICR_OFFSET,
 					XCAN_IXR_RXNEMP_MASK);
 	}
 
-	if (work_done) {
-		can_led_event(ndev, CAN_LED_EVENT_RX);
+	if (work_done)
 		xcan_update_error_state_after_rxtx(ndev);
-	}
 
 	if (work_done < quota) {
 		if (napi_complete_done(napi, work_done)) {
 			ier = priv->read_reg(priv, XCAN_IER_OFFSET);
 			ier |= xcan_rx_int_mask(priv);
@@ -1296,11 +1293,10 @@ static void xcan_tx_interrupt(struct net_device *ndev, u32 isr)
 
 	netif_wake_queue(ndev);
 
 	spin_unlock_irqrestore(&priv->tx_lock, flags);
 
-	can_led_event(ndev, CAN_LED_EVENT_TX);
 	xcan_update_error_state_after_rxtx(ndev);
 }
 
 /**
  * xcan_interrupt - CAN Isr
@@ -1418,11 +1414,10 @@ static int xcan_open(struct net_device *ndev)
 	if (ret < 0) {
 		netdev_err(ndev, "xcan_chip_start failed!\n");
 		goto err_candev;
 	}
 
-	can_led_event(ndev, CAN_LED_EVENT_OPEN);
 	napi_enable(&priv->napi);
 	netif_start_queue(ndev);
 
 	return 0;
 
@@ -1450,11 +1445,10 @@ static int xcan_close(struct net_device *ndev)
 	napi_disable(&priv->napi);
 	xcan_chip_stop(ndev);
 	free_irq(ndev->irq, ndev);
 	close_candev(ndev);
 
-	can_led_event(ndev, CAN_LED_EVENT_STOP);
 	pm_runtime_put(priv->dev);
 
 	return 0;
 }
 
@@ -1810,12 +1804,10 @@ static int xcan_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "fail to register failed (err=%d)\n", ret);
 		goto err_disableclks;
 	}
 
-	devm_can_led_init(ndev);
-
 	pm_runtime_put(&pdev->dev);
 
 	if (priv->devtype.flags & XCAN_FLAG_CANFD_2) {
 		priv->write_reg(priv, XCAN_AFR_2_ID_OFFSET, 0x00000000);
 		priv->write_reg(priv, XCAN_AFR_2_MASK_OFFSET, 0x00000000);
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index c2ea47f30046..e22dc03c850e 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -15,11 +15,10 @@
 #define _CAN_DEV_H
 
 #include <linux/can.h>
 #include <linux/can/bittiming.h>
 #include <linux/can/error.h>
-#include <linux/can/led.h>
 #include <linux/can/length.h>
 #include <linux/can/netlink.h>
 #include <linux/can/skb.h>
 #include <linux/netdevice.h>
 
@@ -83,19 +82,10 @@ struct can_priv {
 	int (*do_get_state)(const struct net_device *dev,
 			    enum can_state *state);
 	int (*do_get_berr_counter)(const struct net_device *dev,
 				   struct can_berr_counter *bec);
 	int (*do_get_auto_tdcv)(const struct net_device *dev, u32 *tdcv);
-
-#ifdef CONFIG_CAN_LEDS
-	struct led_trigger *tx_led_trig;
-	char tx_led_trig_name[CAN_LED_NAME_SZ];
-	struct led_trigger *rx_led_trig;
-	char rx_led_trig_name[CAN_LED_NAME_SZ];
-	struct led_trigger *rxtx_led_trig;
-	char rxtx_led_trig_name[CAN_LED_NAME_SZ];
-#endif
 };
 
 static inline bool can_tdc_is_enabled(const struct can_priv *priv)
 {
 	return !!(priv->ctrlmode & CAN_CTRLMODE_TDC_MASK);
diff --git a/include/linux/can/led.h b/include/linux/can/led.h
deleted file mode 100644
index 7c3cfd798c56..000000000000
--- a/include/linux/can/led.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2012, Fabio Baltieri <fabio.baltieri@gmail.com>
- */
-
-#ifndef _CAN_LED_H
-#define _CAN_LED_H
-
-#include <linux/if.h>
-#include <linux/leds.h>
-#include <linux/netdevice.h>
-
-enum can_led_event {
-	CAN_LED_EVENT_OPEN,
-	CAN_LED_EVENT_STOP,
-	CAN_LED_EVENT_TX,
-	CAN_LED_EVENT_RX,
-};
-
-#ifdef CONFIG_CAN_LEDS
-
-/* keep space for interface name + "-tx"/"-rx"/"-rxtx"
- * suffix and null terminator
- */
-#define CAN_LED_NAME_SZ (IFNAMSIZ + 6)
-
-void can_led_event(struct net_device *netdev, enum can_led_event event);
-void devm_can_led_init(struct net_device *netdev);
-int __init can_led_notifier_init(void);
-void __exit can_led_notifier_exit(void);
-
-#else
-
-static inline void can_led_event(struct net_device *netdev,
-				 enum can_led_event event)
-{
-}
-static inline void devm_can_led_init(struct net_device *netdev)
-{
-}
-static inline int can_led_notifier_init(void)
-{
-	return 0;
-}
-static inline void can_led_notifier_exit(void)
-{
-}
-
-#endif
-
-#endif /* !_CAN_LED_H */
-- 
2.30.2

