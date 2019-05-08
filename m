Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0567E17AF2
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2019 15:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfEHNoZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 May 2019 09:44:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46525 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfEHNoY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2019 09:44:24 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <mkl@pengutronix.de>)
        id 1hOMru-0007vK-B3; Wed, 08 May 2019 15:44:22 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@martin.sperl.org, linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/6] can: mcp25xxfd_can: make module parameters static
Date:   Wed,  8 May 2019 15:44:16 +0200
Message-Id: <20190508134420.29982-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508134420.29982-1-mkl@pengutronix.de>
References: <20190508134420.29982-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c      | 10 +++++-----
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c |  4 ++--
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c  |  2 +-
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_rx.c   |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c
index e28aad2b6ac8..8b81811abd9a 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c
@@ -63,23 +63,23 @@
 #include <uapi/linux/can/netlink.h>
 
 /* module parameters */
-unsigned int bw_sharing_log2bits;
+static unsigned int bw_sharing_log2bits;
 module_param(bw_sharing_log2bits, uint, 0664);
 MODULE_PARM_DESC(bw_sharing_log2bits,
 		 "Delay between 2 transmissions in number of arbitration bit times\n");
-bool enable_edge_filter;
+static bool enable_edge_filter;
 module_param(enable_edge_filter, bool, 0664);
 MODULE_PARM_DESC(enable_edge_filter,
 		 "Enable ISO11898-1:2015 edge_filtering");
-unsigned int tdc_mode = 2;
+static unsigned int tdc_mode = 2;
 module_param(tdc_mode, uint, 0664);
 MODULE_PARM_DESC(tdc_mode,
 		 "Transmitter Delay Mode - 0 = disabled, 1 = fixed, 2 = auto\n");
-unsigned int tdc_value;
+static unsigned int tdc_value;
 module_param(tdc_value, uint, 0664);
 MODULE_PARM_DESC(tdc_value,
 		 "Transmission Delay Value - range: [0:63] SCLK");
-int tdc_offset = 64; /* outside of range to use computed values */
+static int tdc_offset = 64; /* outside of range to use computed values */
 module_param(tdc_offset, int, 0664);
 MODULE_PARM_DESC(tdc_offset,
 		 "Transmission Delay offset - range: [-64:63] SCLK");
diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c
index bf94120f2609..7204864ee07e 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c
@@ -20,11 +20,11 @@
  * so we allow to control them via module parameters (that can changed
  * in /sys if needed) - theses are only needed during setup if the can_device
  */
-unsigned int tx_fifos;
+static unsigned int tx_fifos;
 module_param(tx_fifos, uint, 0664);
 MODULE_PARM_DESC(tx_fifos, "Number of tx-fifos to configure\n");
 
-bool three_shot;
+static bool three_shot;
 module_param(three_shot, bool, 0664);
 MODULE_PARM_DESC(three_shot, "Use 3 shots when one-shot is requested");
 
diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c
index 5a97c69fb37e..f159267e7f6c 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c
@@ -27,7 +27,7 @@
 #include "mcp25xxfd_cmd.h"
 #include "mcp25xxfd_ecc.h"
 
-unsigned int reschedule_int_thread_after = 4;
+static unsigned int reschedule_int_thread_after = 4;
 module_param(reschedule_int_thread_after, uint, 0664);
 MODULE_PARM_DESC(reschedule_int_thread_after,
 		 "Reschedule the interrupt thread after this many loops\n");
diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_rx.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_rx.c
index 11bf12461e58..5d3141d6b2ce 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_rx.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_rx.c
@@ -26,7 +26,7 @@
 #include "mcp25xxfd_can_rx.h"
 
 /* module parameters */
-unsigned int rx_prefetch_bytes = -1;
+static unsigned int rx_prefetch_bytes = -1;
 module_param(rx_prefetch_bytes, uint, 0664);
 MODULE_PARM_DESC(rx_prefetch_bytes,
 		 "number of bytes to blindly prefetch when reading a rx-fifo");
-- 
2.20.1

