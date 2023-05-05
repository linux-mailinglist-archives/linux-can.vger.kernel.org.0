Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA00A6F8C58
	for <lists+linux-can@lfdr.de>; Sat,  6 May 2023 00:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjEEW2y (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 May 2023 18:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjEEW2y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 May 2023 18:28:54 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417EF46A0
        for <linux-can@vger.kernel.org>; Fri,  5 May 2023 15:28:49 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 88FB985DB0;
        Sat,  6 May 2023 00:28:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683325727;
        bh=UUFokWi9zwGwCz0rBomyZ5pW6FQ0Bs2MTCMln6a3Xew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQT/vIEvhujNDgq8Rl7m6pbBncnV/p3HW5r7Qvhsc2xV4a9I2kd01ka/8VNNtAHtW
         IqCzNU9dqlCkosFaXQdjgRw5cYO1VDS6HXNlxf4wHw2YE8d71f68oh3SvinidVswjE
         65oCoRI2+tK5ofV1o8OU6lgmv95yC0NBAAxE8Wy4bBxW565CTOWrbhEZ2CnqaMIsRu
         ZD6Xe56pteh+E0vuGTxF+f5nByFHb9tNJSargQBDdtv/fMwOIv50RtS5+9j7hoPY+L
         2UQPyublykB46y4snxItwDh59kZoGxptN24sd/U7c/o0MoEEY6z5A9Q+Kd269dS9ZD
         gONZoKvVWIKaA==
From:   Marek Vasut <marex@denx.de>
To:     linux-can@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: [PATCH v2 2/2] can: mcp251xfd: Move generic macros into length.h
Date:   Sat,  6 May 2023 00:28:20 +0200
Message-Id: <20230505222820.126441-2-marex@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505222820.126441-1-marex@denx.de>
References: <20230505222820.126441-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Move CAN_BIT_STUFFING_OVERHEAD and CAN_IDLE_CONDITION_SAMPLES generic
CAN macros into linux/can/length.h . No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Kopp <thomas.kopp@microchip.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org
---
V2: - New separate patch, separate from the mcp251xfd addition to ease backporting
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h | 9 ---------
 include/linux/can/length.h                | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 412d58d84fb63..7024ff0cc2c0c 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -432,15 +432,6 @@ static_assert(MCP251XFD_FIFO_RX_NUM <= 4U);
 /* Use Half Duplex SPI transfers */
 #define MCP251XFD_QUIRK_HALF_DUPLEX BIT(5)
 
-/* CAN bit stuffing overhead multiplication factor */
-#define CAN_BIT_STUFFING_OVERHEAD	1.2
-
-/* Number of samples after which an idle condition is present on the bus
- * as specified in the ISO. This is 11 consecutive sampled recessive bits
- * after a full frame (if one is currently in transmission).
- */
-#define CAN_IDLE_CONDITION_SAMPLES	11
-
 struct mcp251xfd_hw_tef_obj {
 	u32 id;
 	u32 flags;
diff --git a/include/linux/can/length.h b/include/linux/can/length.h
index 6995092b774ec..0e20e153955d4 100644
--- a/include/linux/can/length.h
+++ b/include/linux/can/length.h
@@ -122,6 +122,15 @@
  */
 #define CANFD_FRAME_LEN_MAX (CANFD_FRAME_OVERHEAD_EFF + CANFD_MAX_DLEN)
 
+/* CAN bit stuffing overhead multiplication factor */
+#define CAN_BIT_STUFFING_OVERHEAD	1.2
+
+/* Number of samples after which an idle condition is present on the bus
+ * as specified in the ISO. This is 11 consecutive sampled recessive bits
+ * after a full frame (if one is currently in transmission).
+ */
+#define CAN_IDLE_CONDITION_SAMPLES	11
+
 /*
  * can_cc_dlc2len(value) - convert a given data length code (dlc) of a
  * Classical CAN frame into a valid data length of max. 8 bytes.
-- 
2.39.2

