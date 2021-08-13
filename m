Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3173EB330
	for <lists+linux-can@lfdr.de>; Fri, 13 Aug 2021 11:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbhHMJLD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 13 Aug 2021 05:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhHMJLD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Aug 2021 05:11:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B465C061756
        for <linux-can@vger.kernel.org>; Fri, 13 Aug 2021 02:10:37 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mETD1-0005bw-HP
        for linux-can@vger.kernel.org; Fri, 13 Aug 2021 11:10:35 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 903DA6668DC
        for <linux-can@vger.kernel.org>; Fri, 13 Aug 2021 09:10:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E8E636668D8;
        Fri, 13 Aug 2021 09:10:33 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3fd3d6fd;
        Fri, 13 Aug 2021 09:10:32 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>
Subject: [PATCH] can: mcp251xfd: mark some instances of struct mcp251xfd_priv as const
Date:   Fri, 13 Aug 2021 11:10:27 +0200
Message-Id: <20210813091027.159379-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

With the patch 07ff4aed015c ("time/timecounter: Mark 1st argument of
timecounter_cyc2time() as const") some instances of the struct
mcp251xfd_priv can be marked as const. This patch marks these as
const.

Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c      | 2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c | 4 ++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h           | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 6c369a399c45..673861ab665a 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1456,7 +1456,7 @@ mcp251xfd_rx_ring_update(const struct mcp251xfd_priv *priv,
 }
 
 static void
-mcp251xfd_hw_rx_obj_to_skb(struct mcp251xfd_priv *priv,
+mcp251xfd_hw_rx_obj_to_skb(const struct mcp251xfd_priv *priv,
 			   const struct mcp251xfd_hw_rx_obj_canfd *hw_rx_obj,
 			   struct sk_buff *skb)
 {
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
index ed3169274d24..712e09186987 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
@@ -13,7 +13,7 @@
 
 static u64 mcp251xfd_timestamp_read(const struct cyclecounter *cc)
 {
-	struct mcp251xfd_priv *priv;
+	const struct mcp251xfd_priv *priv;
 	u32 timestamp = 0;
 	int err;
 
@@ -39,7 +39,7 @@ static void mcp251xfd_timestamp_work(struct work_struct *work)
 			      MCP251XFD_TIMESTAMP_WORK_DELAY_SEC * HZ);
 }
 
-void mcp251xfd_skb_set_timestamp(struct mcp251xfd_priv *priv,
+void mcp251xfd_skb_set_timestamp(const struct mcp251xfd_priv *priv,
 				 struct sk_buff *skb, u32 timestamp)
 {
 	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 1002f3902ad2..0f322dabaf65 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -853,7 +853,7 @@ int mcp251xfd_regmap_init(struct mcp251xfd_priv *priv);
 u16 mcp251xfd_crc16_compute2(const void *cmd, size_t cmd_size,
 			     const void *data, size_t data_size);
 u16 mcp251xfd_crc16_compute(const void *data, size_t data_size);
-void mcp251xfd_skb_set_timestamp(struct mcp251xfd_priv *priv,
+void mcp251xfd_skb_set_timestamp(const struct mcp251xfd_priv *priv,
 				 struct sk_buff *skb, u32 timestamp);
 void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv);
 void mcp251xfd_timestamp_stop(struct mcp251xfd_priv *priv);
-- 
2.30.2


