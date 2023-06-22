Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F867399A9
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 10:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjFVI2C (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 04:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjFVI14 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 04:27:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E702E2680
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 01:27:33 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qCFf1-00036F-II
        for linux-can@vger.kernel.org; Thu, 22 Jun 2023 10:27:23 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 93DA71DF437
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:27:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 296AB1DF3D4;
        Thu, 22 Jun 2023 08:27:05 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id cfbec546;
        Thu, 22 Jun 2023 08:27:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Jimmy Assarsson <extja@kvaser.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 29/33] can: kvaser_pciefd: Sort register definitions
Date:   Thu, 22 Jun 2023 10:26:54 +0200
Message-Id: <20230622082658.571150-30-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622082658.571150-1-mkl@pengutronix.de>
References: <20230622082658.571150-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Sort the registers defines, in the same order as the register bits/fields
are defined.
Sort register bits/fields in MSB-to-LSB order.
Update and add comments.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20230529134248.752036-11-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 212 +++++++++++++++++---------------
 1 file changed, 111 insertions(+), 101 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index feef044c6b0a..d2e520f9eaa7 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -30,7 +30,6 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_DMA_COUNT 2U
 
 #define KVASER_PCIEFD_DMA_SIZE (4U * 1024U)
-#define KVASER_PCIEFD_64BIT_DMA_BIT BIT(0)
 
 #define KVASER_PCIEFD_VENDOR 0x1a07
 #define KVASER_PCIEFD_4HS_DEVICE_ID 0x000d
@@ -42,24 +41,8 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 /* PCIe IRQ registers */
 #define KVASER_PCIEFD_IRQ_REG 0x40
 #define KVASER_PCIEFD_IEN_REG 0x50
-/* DMA map */
+/* DMA address translation map register base */
 #define KVASER_PCIEFD_DMA_MAP_BASE 0x1000
-/* Kvaser KCAN CAN controller registers */
-#define KVASER_PCIEFD_KCAN0_BASE 0x10000
-#define KVASER_PCIEFD_KCAN_BASE_OFFSET 0x1000
-#define KVASER_PCIEFD_KCAN_FIFO_REG 0x100
-#define KVASER_PCIEFD_KCAN_FIFO_LAST_REG 0x180
-#define KVASER_PCIEFD_KCAN_CTRL_REG 0x2c0
-#define KVASER_PCIEFD_KCAN_CMD_REG 0x400
-#define KVASER_PCIEFD_KCAN_IEN_REG 0x408
-#define KVASER_PCIEFD_KCAN_IRQ_REG 0x410
-#define KVASER_PCIEFD_KCAN_TX_NPACKETS_REG 0x414
-#define KVASER_PCIEFD_KCAN_STAT_REG 0x418
-#define KVASER_PCIEFD_KCAN_MODE_REG 0x41c
-#define KVASER_PCIEFD_KCAN_BTRN_REG 0x420
-#define KVASER_PCIEFD_KCAN_BUS_LOAD_REG 0x424
-#define KVASER_PCIEFD_KCAN_BTRD_REG 0x428
-#define KVASER_PCIEFD_KCAN_PWM_REG 0x430
 /* Loopback control register */
 #define KVASER_PCIEFD_LOOP_REG 0x1f000
 /* System identification and information registers */
@@ -77,33 +60,54 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_SRB_STAT_REG (KVASER_PCIEFD_SRB_BASE + 0x210)
 #define KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG (KVASER_PCIEFD_SRB_BASE + 0x214)
 #define KVASER_PCIEFD_SRB_CTRL_REG (KVASER_PCIEFD_SRB_BASE + 0x218)
+/* Kvaser KCAN CAN controller registers */
+#define KVASER_PCIEFD_KCAN0_BASE 0x10000
+#define KVASER_PCIEFD_KCAN_BASE_OFFSET 0x1000
+#define KVASER_PCIEFD_KCAN_FIFO_REG 0x100
+#define KVASER_PCIEFD_KCAN_FIFO_LAST_REG 0x180
+#define KVASER_PCIEFD_KCAN_CTRL_REG 0x2c0
+#define KVASER_PCIEFD_KCAN_CMD_REG 0x400
+#define KVASER_PCIEFD_KCAN_IEN_REG 0x408
+#define KVASER_PCIEFD_KCAN_IRQ_REG 0x410
+#define KVASER_PCIEFD_KCAN_TX_NPACKETS_REG 0x414
+#define KVASER_PCIEFD_KCAN_STAT_REG 0x418
+#define KVASER_PCIEFD_KCAN_MODE_REG 0x41c
+#define KVASER_PCIEFD_KCAN_BTRN_REG 0x420
+#define KVASER_PCIEFD_KCAN_BUS_LOAD_REG 0x424
+#define KVASER_PCIEFD_KCAN_BTRD_REG 0x428
+#define KVASER_PCIEFD_KCAN_PWM_REG 0x430
 
-#define KVASER_PCIEFD_IRQ_ALL_MSK 0x1f
+/* PCI interrupt fields */
 #define KVASER_PCIEFD_IRQ_SRB BIT(4)
+#define KVASER_PCIEFD_IRQ_ALL_MSK 0x1f
 
+/* Enable 64-bit DMA address translation */
+#define KVASER_PCIEFD_64BIT_DMA_BIT BIT(0)
+
+/* System build information fields */
 #define KVASER_PCIEFD_SYSID_NRCHAN_SHIFT 24
 #define KVASER_PCIEFD_SYSID_MAJOR_VER_SHIFT 16
 #define KVASER_PCIEFD_SYSID_BUILD_VER_SHIFT 1
 
 /* Reset DMA buffer 0, 1 and FIFO offset */
-#define KVASER_PCIEFD_SRB_CMD_RDB0 BIT(4)
 #define KVASER_PCIEFD_SRB_CMD_RDB1 BIT(5)
+#define KVASER_PCIEFD_SRB_CMD_RDB0 BIT(4)
 #define KVASER_PCIEFD_SRB_CMD_FOR BIT(0)
 
-/* DMA packet done, buffer 0 and 1 */
-#define KVASER_PCIEFD_SRB_IRQ_DPD0 BIT(8)
-#define KVASER_PCIEFD_SRB_IRQ_DPD1 BIT(9)
-/* DMA overflow, buffer 0 and 1 */
-#define KVASER_PCIEFD_SRB_IRQ_DOF0 BIT(10)
-#define KVASER_PCIEFD_SRB_IRQ_DOF1 BIT(11)
 /* DMA underflow, buffer 0 and 1 */
-#define KVASER_PCIEFD_SRB_IRQ_DUF0 BIT(12)
 #define KVASER_PCIEFD_SRB_IRQ_DUF1 BIT(13)
+#define KVASER_PCIEFD_SRB_IRQ_DUF0 BIT(12)
+/* DMA overflow, buffer 0 and 1 */
+#define KVASER_PCIEFD_SRB_IRQ_DOF1 BIT(11)
+#define KVASER_PCIEFD_SRB_IRQ_DOF0 BIT(10)
+/* DMA packet done, buffer 0 and 1 */
+#define KVASER_PCIEFD_SRB_IRQ_DPD1 BIT(9)
+#define KVASER_PCIEFD_SRB_IRQ_DPD0 BIT(8)
 
+/* Got DMA support */
+#define KVASER_PCIEFD_SRB_STAT_DMA BIT(24)
 /* DMA idle */
 #define KVASER_PCIEFD_SRB_STAT_DI BIT(15)
-/* DMA support */
-#define KVASER_PCIEFD_SRB_STAT_DMA BIT(24)
 
 /* SRB current packet level */
 #define KVASER_PCIEFD_SRB_RX_NR_PACKETS_MASK 0xff
@@ -111,80 +115,86 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 /* DMA Enable */
 #define KVASER_PCIEFD_SRB_CTRL_DMA_ENABLE BIT(0)
 
-/* Kvaser KCAN definitions */
+/* KCAN CTRL packet types */
 #define KVASER_PCIEFD_KCAN_CTRL_EFLUSH (4 << 29)
 #define KVASER_PCIEFD_KCAN_CTRL_EFRAME (5 << 29)
 
+/* Command sequence number */
 #define KVASER_PCIEFD_KCAN_CMD_SEQ_SHIFT 16
-/* Request status packet */
-#define KVASER_PCIEFD_KCAN_CMD_SRQ BIT(0)
 /* Abort, flush and reset */
 #define KVASER_PCIEFD_KCAN_CMD_AT BIT(1)
+/* Request status packet */
+#define KVASER_PCIEFD_KCAN_CMD_SRQ BIT(0)
 
-/* Tx FIFO unaligned read */
-#define KVASER_PCIEFD_KCAN_IRQ_TAR BIT(0)
-/* Tx FIFO unaligned end */
-#define KVASER_PCIEFD_KCAN_IRQ_TAE BIT(1)
-/* Bus parameter protection error */
-#define KVASER_PCIEFD_KCAN_IRQ_BPP BIT(2)
-/* FDF bit when controller is in classic mode */
-#define KVASER_PCIEFD_KCAN_IRQ_FDIC BIT(3)
-/* Rx FIFO overflow */
-#define KVASER_PCIEFD_KCAN_IRQ_ROF BIT(5)
-/* Abort done */
-#define KVASER_PCIEFD_KCAN_IRQ_ABD BIT(13)
-/* Tx buffer flush done */
-#define KVASER_PCIEFD_KCAN_IRQ_TFD BIT(14)
-/* Tx FIFO overflow */
-#define KVASER_PCIEFD_KCAN_IRQ_TOF BIT(15)
-/* Tx FIFO empty */
-#define KVASER_PCIEFD_KCAN_IRQ_TE BIT(16)
 /* Transmitter unaligned */
 #define KVASER_PCIEFD_KCAN_IRQ_TAL BIT(17)
+/* Tx FIFO empty */
+#define KVASER_PCIEFD_KCAN_IRQ_TE BIT(16)
+/* Tx FIFO overflow */
+#define KVASER_PCIEFD_KCAN_IRQ_TOF BIT(15)
+/* Tx buffer flush done */
+#define KVASER_PCIEFD_KCAN_IRQ_TFD BIT(14)
+/* Abort done */
+#define KVASER_PCIEFD_KCAN_IRQ_ABD BIT(13)
+/* Rx FIFO overflow */
+#define KVASER_PCIEFD_KCAN_IRQ_ROF BIT(5)
+/* FDF bit when controller is in classic CAN mode */
+#define KVASER_PCIEFD_KCAN_IRQ_FDIC BIT(3)
+/* Bus parameter protection error */
+#define KVASER_PCIEFD_KCAN_IRQ_BPP BIT(2)
+/* Tx FIFO unaligned end */
+#define KVASER_PCIEFD_KCAN_IRQ_TAE BIT(1)
+/* Tx FIFO unaligned read */
+#define KVASER_PCIEFD_KCAN_IRQ_TAR BIT(0)
 
+/* Tx FIFO size */
 #define KVASER_PCIEFD_KCAN_TX_NPACKETS_MAX_SHIFT 16
 
+/* Current status packet sequence number */
 #define KVASER_PCIEFD_KCAN_STAT_SEQNO_SHIFT 24
-/* Abort request */
-#define KVASER_PCIEFD_KCAN_STAT_AR BIT(7)
-/* Idle state. Controller in reset mode and no abort or flush pending */
-#define KVASER_PCIEFD_KCAN_STAT_IDLE BIT(10)
-/* Bus off */
-#define KVASER_PCIEFD_KCAN_STAT_BOFF BIT(11)
-/* Reset mode request */
-#define KVASER_PCIEFD_KCAN_STAT_RMR BIT(14)
-/* Controller in reset mode */
-#define KVASER_PCIEFD_KCAN_STAT_IRM BIT(15)
-/* Controller got one-shot capability */
-#define KVASER_PCIEFD_KCAN_STAT_CAP BIT(16)
 /* Controller got CAN FD capability */
 #define KVASER_PCIEFD_KCAN_STAT_FD BIT(19)
+/* Controller got one-shot capability */
+#define KVASER_PCIEFD_KCAN_STAT_CAP BIT(16)
+/* Controller in reset mode */
+#define KVASER_PCIEFD_KCAN_STAT_IRM BIT(15)
+/* Reset mode request */
+#define KVASER_PCIEFD_KCAN_STAT_RMR BIT(14)
+/* Bus off */
+#define KVASER_PCIEFD_KCAN_STAT_BOFF BIT(11)
+/* Idle state. Controller in reset mode and no abort or flush pending */
+#define KVASER_PCIEFD_KCAN_STAT_IDLE BIT(10)
+/* Abort request */
+#define KVASER_PCIEFD_KCAN_STAT_AR BIT(7)
+/* Controller is bus off */
 #define KVASER_PCIEFD_KCAN_STAT_BUS_OFF_MSK (KVASER_PCIEFD_KCAN_STAT_AR | \
 	KVASER_PCIEFD_KCAN_STAT_BOFF | KVASER_PCIEFD_KCAN_STAT_RMR | \
 	KVASER_PCIEFD_KCAN_STAT_IRM)
 
-/* Reset mode */
-#define KVASER_PCIEFD_KCAN_MODE_RM BIT(8)
-/* Listen only mode */
-#define KVASER_PCIEFD_KCAN_MODE_LOM BIT(9)
-/* Error packet enable */
-#define KVASER_PCIEFD_KCAN_MODE_EPEN BIT(12)
-/* CAN FD non-ISO */
-#define KVASER_PCIEFD_KCAN_MODE_NIFDEN BIT(15)
-/* Acknowledgment packet type */
-#define KVASER_PCIEFD_KCAN_MODE_APT BIT(20)
-/* Active error flag enable. Clear to force error passive */
-#define KVASER_PCIEFD_KCAN_MODE_EEN BIT(23)
 /* Classic CAN mode */
 #define KVASER_PCIEFD_KCAN_MODE_CCM BIT(31)
+/* Active error flag enable. Clear to force error passive */
+#define KVASER_PCIEFD_KCAN_MODE_EEN BIT(23)
+/* Acknowledgment packet type */
+#define KVASER_PCIEFD_KCAN_MODE_APT BIT(20)
+/* CAN FD non-ISO */
+#define KVASER_PCIEFD_KCAN_MODE_NIFDEN BIT(15)
+/* Error packet enable */
+#define KVASER_PCIEFD_KCAN_MODE_EPEN BIT(12)
+/* Listen only mode */
+#define KVASER_PCIEFD_KCAN_MODE_LOM BIT(9)
+/* Reset mode */
+#define KVASER_PCIEFD_KCAN_MODE_RM BIT(8)
 
-#define KVASER_PCIEFD_KCAN_BTRN_SJW_SHIFT 13
-#define KVASER_PCIEFD_KCAN_BTRN_TSEG1_SHIFT 17
+/* BTRN and BTRD fields */
 #define KVASER_PCIEFD_KCAN_BTRN_TSEG2_SHIFT 26
+#define KVASER_PCIEFD_KCAN_BTRN_TSEG1_SHIFT 17
+#define KVASER_PCIEFD_KCAN_BTRN_SJW_SHIFT 13
 
+/* PWM Control fields */
 #define KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT 16
 
-/* Kvaser KCAN packet types */
+/* KCAN packet type IDs */
 #define KVASER_PCIEFD_PACK_TYPE_DATA 0
 #define KVASER_PCIEFD_PACK_TYPE_ACK 1
 #define KVASER_PCIEFD_PACK_TYPE_TXRQ 2
@@ -195,41 +205,41 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_PACK_TYPE_STATUS 8
 #define KVASER_PCIEFD_PACK_TYPE_BUS_LOAD 9
 
-/* Kvaser KCAN packet common definitions */
-#define KVASER_PCIEFD_PACKET_SEQ_MSK 0xff
-#define KVASER_PCIEFD_PACKET_CHID_SHIFT 25
+/* Common KCAN packet definitions, second word */
 #define KVASER_PCIEFD_PACKET_TYPE_SHIFT 28
+#define KVASER_PCIEFD_PACKET_CHID_SHIFT 25
+#define KVASER_PCIEFD_PACKET_SEQ_MSK 0xff
 
-/* Kvaser KCAN TDATA and RDATA first word */
+/* KCAN Transmit/Receive data packet, first word */
 #define KVASER_PCIEFD_RPACKET_IDE BIT(30)
 #define KVASER_PCIEFD_RPACKET_RTR BIT(29)
-/* Kvaser KCAN TDATA and RDATA second word */
-#define KVASER_PCIEFD_RPACKET_ESI BIT(13)
-#define KVASER_PCIEFD_RPACKET_BRS BIT(14)
-#define KVASER_PCIEFD_RPACKET_FDF BIT(15)
-#define KVASER_PCIEFD_RPACKET_DLC_SHIFT 8
-/* Kvaser KCAN TDATA second word */
-#define KVASER_PCIEFD_TPACKET_SMS BIT(16)
+/* KCAN Transmit data packet, second word */
 #define KVASER_PCIEFD_TPACKET_AREQ BIT(31)
+#define KVASER_PCIEFD_TPACKET_SMS BIT(16)
+/* KCAN Transmit/Receive data packet, second word */
+#define KVASER_PCIEFD_RPACKET_FDF BIT(15)
+#define KVASER_PCIEFD_RPACKET_BRS BIT(14)
+#define KVASER_PCIEFD_RPACKET_ESI BIT(13)
+#define KVASER_PCIEFD_RPACKET_DLC_SHIFT 8
 
-/* Kvaser KCAN APACKET */
-#define KVASER_PCIEFD_APACKET_FLU BIT(8)
-#define KVASER_PCIEFD_APACKET_CT BIT(9)
-#define KVASER_PCIEFD_APACKET_ABL BIT(10)
+/* KCAN Transmit acknowledge packet, first word */
 #define KVASER_PCIEFD_APACKET_NACK BIT(11)
+#define KVASER_PCIEFD_APACKET_ABL BIT(10)
+#define KVASER_PCIEFD_APACKET_CT BIT(9)
+#define KVASER_PCIEFD_APACKET_FLU BIT(8)
 
-/* Kvaser KCAN SPACK first word */
-#define KVASER_PCIEFD_SPACK_RXERR_SHIFT 8
-#define KVASER_PCIEFD_SPACK_BOFF BIT(16)
-#define KVASER_PCIEFD_SPACK_IDET BIT(20)
-#define KVASER_PCIEFD_SPACK_IRM BIT(21)
+/* KCAN Status packet, first word */
 #define KVASER_PCIEFD_SPACK_RMCD BIT(22)
-/* Kvaser KCAN SPACK second word */
-#define KVASER_PCIEFD_SPACK_AUTO BIT(21)
-#define KVASER_PCIEFD_SPACK_EWLR BIT(23)
+#define KVASER_PCIEFD_SPACK_IRM BIT(21)
+#define KVASER_PCIEFD_SPACK_IDET BIT(20)
+#define KVASER_PCIEFD_SPACK_BOFF BIT(16)
+#define KVASER_PCIEFD_SPACK_RXERR_SHIFT 8
+/* KCAN Status packet, second word */
 #define KVASER_PCIEFD_SPACK_EPLR BIT(24)
+#define KVASER_PCIEFD_SPACK_EWLR BIT(23)
+#define KVASER_PCIEFD_SPACK_AUTO BIT(21)
 
-/* Kvaser KCAN_EPACK second word */
+/* KCAN Error detected packet, second word */
 #define KVASER_PCIEFD_EPACK_DIR_TX BIT(0)
 
 struct kvaser_pciefd;
-- 
2.40.1


