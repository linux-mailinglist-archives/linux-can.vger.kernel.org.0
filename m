Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4A3577F20
	for <lists+linux-can@lfdr.de>; Mon, 18 Jul 2022 11:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiGRJ4q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 18 Jul 2022 05:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiGRJ4g (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 18 Jul 2022 05:56:36 -0400
Received: from mailgw.felk.cvut.cz (mailgw.felk.cvut.cz [147.32.82.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD9F1B7B7
        for <linux-can@vger.kernel.org>; Mon, 18 Jul 2022 02:56:34 -0700 (PDT)
Received: from mailgw.felk.cvut.cz (localhost.localdomain [127.0.0.1])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTP id 19D5A30B294D;
        Mon, 18 Jul 2022 11:56:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        cmp.felk.cvut.cz; h=cc:cc:content-transfer-encoding:date:from
        :from:in-reply-to:message-id:mime-version:references:reply-to
        :subject:subject:to:to; s=felkmail; bh=8vjYRfVGtmwZixXiCchfsak42
        XCad/gECa5eOr67CK0=; b=McmcuLYjY3Rd2FSxnzBab4mKHR5dVETMwAh4UL8r2
        60vYtqbgJ+8sIZ8x2sxp5zU2M3Y/x32OD818YL6uvglN11gA9TjW35POHc7Fb/Ej
        P6QlhWNRyRsyCKJod1logokSLi2j5cvaF0hTUm7RiIneaDFl8UflMfG6LzEPl5ys
        PdXFbHMa88pTqpLwotDv/MEolLCaR7NOkYoZ6sO3n3OWdfP5bLBrgsCf+tuyTbVs
        vbqyLqvUkrsdysKDFs2ZdP9oLXXtaiOFtLapwkG7YHpdrMi9jGWvFL+y/oSWFpy6
        T+Py5bi6NCymx8Cf/vD4l1e+rLGfA2lLgypxa9d2vKKWg==
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTPS id 0306430ADE4F;
        Mon, 18 Jul 2022 11:56:02 +0200 (CEST)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 26I9u1Iq027951;
        Mon, 18 Jul 2022 11:56:01 +0200
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 26I9u1Cs027950;
        Mon, 18 Jul 2022 11:56:01 +0200
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     linux-can@vger.kernel.org,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        Matej Vasilevski <matej.vasilevski@seznam.cz>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        David Miller <davem@davemloft.net>,
        Carsten Emde <c.emde@osadl.org>,
        Marin Jerabek <martin.jerabek01@gmail.com>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Jiri Novak <jnovak@fel.cvut.cz>,
        Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: [PATCH v1 1/1] can: ctucanfd: Update CTU CAN FD IP core registers to match version 3.x.
Date:   Mon, 18 Jul 2022 11:55:18 +0200
Message-Id: <b426389bd3c6c4032b4bb6c234ccfe981e6d3860.1658136506.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1658136506.git.pisa@cmp.felk.cvut.cz>
References: <cover.1658136506.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The update is compatible/pure extension of 2.x IP core version

 - new option for 2, 4, or 8 Tx buffers option during synthesis.
   The 2.x version has fixed 4 Tx buffers. 3.x version default
   is 4 as well
 - new REG_TX_COMMAND_TXT_BUFFER_COUNT provides synthesis
   choice. When read as 0 assume 2.x core with fixed 4 Tx buffers.
 - new REG_ERR_CAPT_TS_BITS field to provide most significant
   active/implemented timestamp bit. For 2.x read as zero,
   assume value 63 is such case for 64 bit counter.
 - new REG_MODE_RXBAM bit which controls automatic advance
   to next word after Rx FIFO register read. Bit is set
   to 1 by default after the core reset (REG_MODE_RST)
   and value 1 has to be preserver for the normal ctucanfd
   Linux driver operation. Even preceding driver version
   resets core and then modifies only known/required MODE
   register bits so backward and forward compatibility is
   ensured.

See complete datasheet for time-triggered and other
updated capabilities

  http://canbus.pages.fel.cvut.cz/ctucanfd_ip_core/doc/Datasheet.pdf

The fields related to ongoing Ondrej Ille's work
on fault tolerant version with parity protected buffers
and FIFOs are not included for now. Their inclusion will
be considered when design is settled and tested.

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
---
 drivers/net/can/ctucanfd/ctucanfd_kregs.h | 32 ++++++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_kregs.h b/drivers/net/can/ctucanfd/ctucanfd_kregs.h
index edc1c1a24348..0c181ab51bf8 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_kregs.h
+++ b/drivers/net/can/ctucanfd/ctucanfd_kregs.h
@@ -4,9 +4,9 @@
  * CTU CAN FD IP Core
  *
  * Copyright (C) 2015-2018 Ondrej Ille <ondrej.ille@gmail.com> FEE CTU
- * Copyright (C) 2018-2021 Ondrej Ille <ondrej.ille@gmail.com> self-funded
+ * Copyright (C) 2018-2022 Ondrej Ille <ondrej.ille@gmail.com> self-funded
  * Copyright (C) 2018-2019 Martin Jerabek <martin.jerabek01@gmail.com> FEE CTU
- * Copyright (C) 2018-2021 Pavel Pisa <pisa@cmp.felk.cvut.cz> FEE CTU/self-funded
+ * Copyright (C) 2018-2022 Pavel Pisa <pisa@cmp.felk.cvut.cz> FEE CTU/self-funded
  *
  * Project advisors:
  *     Jiri Novak <jnovak@fel.cvut.cz>
@@ -64,9 +64,12 @@ enum ctu_can_fd_can_registers {
 	CTUCANFD_RX_DATA              = 0x6c,
 	CTUCANFD_TX_STATUS            = 0x70,
 	CTUCANFD_TX_COMMAND           = 0x74,
+	CTUCANFD_TXTB_INFO            = 0x76,
 	CTUCANFD_TX_PRIORITY          = 0x78,
 	CTUCANFD_ERR_CAPT             = 0x7c,
+	CTUCANFD_RETR_CTR             = 0x7d,
 	CTUCANFD_ALC                  = 0x7e,
+	CTUCANFD_TS_INFO              = 0x7f,
 	CTUCANFD_TRV_DELAY            = 0x80,
 	CTUCANFD_SSP_CFG              = 0x82,
 	CTUCANFD_RX_FR_CTR            = 0x84,
@@ -102,8 +105,12 @@ enum ctu_can_fd_can_registers {
 #define REG_MODE_STM BIT(2)
 #define REG_MODE_AFM BIT(3)
 #define REG_MODE_FDE BIT(4)
+#define REG_MODE_TTTM BIT(5)
+#define REG_MODE_ROM BIT(6)
 #define REG_MODE_ACF BIT(7)
 #define REG_MODE_TSTM BIT(8)
+#define REG_MODE_RXBAM BIT(9)
+#define REG_MODE_SAM BIT(11)
 #define REG_MODE_RTRLE BIT(16)
 #define REG_MODE_RTRTH GENMASK(20, 17)
 #define REG_MODE_ILBP BIT(21)
@@ -123,8 +130,10 @@ enum ctu_can_fd_can_registers {
 #define REG_STATUS_EWL BIT(6)
 #define REG_STATUS_IDLE BIT(7)
 #define REG_STATUS_PEXS BIT(8)
+#define REG_STATUS_STCNT BIT(16)
 
 /*  COMMAND registers */
+#define REG_COMMAND_RXRPMV BIT(1)
 #define REG_COMMAND_RRB BIT(2)
 #define REG_COMMAND_CDO BIT(3)
 #define REG_COMMAND_ERCRST BIT(4)
@@ -263,8 +272,12 @@ enum ctu_can_fd_can_registers {
 #define REG_TX_STATUS_TX2S GENMASK(7, 4)
 #define REG_TX_STATUS_TX3S GENMASK(11, 8)
 #define REG_TX_STATUS_TX4S GENMASK(15, 12)
+#define REG_TX_STATUS_TX5S GENMASK(19, 16)
+#define REG_TX_STATUS_TX6S GENMASK(23, 20)
+#define REG_TX_STATUS_TX7S GENMASK(27, 24)
+#define REG_TX_STATUS_TX8S GENMASK(31, 28)
 
-/*  TX_COMMAND registers */
+/*  TX_COMMAND TXTB_INFO registers */
 #define REG_TX_COMMAND_TXCE BIT(0)
 #define REG_TX_COMMAND_TXCR BIT(1)
 #define REG_TX_COMMAND_TXCA BIT(2)
@@ -272,18 +285,29 @@ enum ctu_can_fd_can_registers {
 #define REG_TX_COMMAND_TXB2 BIT(9)
 #define REG_TX_COMMAND_TXB3 BIT(10)
 #define REG_TX_COMMAND_TXB4 BIT(11)
+#define REG_TX_COMMAND_TXB5 BIT(12)
+#define REG_TX_COMMAND_TXB6 BIT(13)
+#define REG_TX_COMMAND_TXB7 BIT(14)
+#define REG_TX_COMMAND_TXB8 BIT(15)
+#define REG_TX_COMMAND_TXT_BUFFER_COUNT GENMASK(19, 16)
 
 /*  TX_PRIORITY registers */
 #define REG_TX_PRIORITY_TXT1P GENMASK(2, 0)
 #define REG_TX_PRIORITY_TXT2P GENMASK(6, 4)
 #define REG_TX_PRIORITY_TXT3P GENMASK(10, 8)
 #define REG_TX_PRIORITY_TXT4P GENMASK(14, 12)
+#define REG_TX_PRIORITY_TXT5P GENMASK(18, 16)
+#define REG_TX_PRIORITY_TXT6P GENMASK(22, 20)
+#define REG_TX_PRIORITY_TXT7P GENMASK(26, 24)
+#define REG_TX_PRIORITY_TXT8P GENMASK(30, 28)
 
-/*  ERR_CAPT ALC registers */
+/*  ERR_CAPT RETR_CTR ALC TS_INFO registers */
 #define REG_ERR_CAPT_ERR_POS GENMASK(4, 0)
 #define REG_ERR_CAPT_ERR_TYPE GENMASK(7, 5)
+#define REG_ERR_CAPT_RETR_CTR_VAL GENMASK(11, 8)
 #define REG_ERR_CAPT_ALC_BIT GENMASK(20, 16)
 #define REG_ERR_CAPT_ALC_ID_FIELD GENMASK(23, 21)
+#define REG_ERR_CAPT_TS_BITS GENMASK(29, 24)
 
 /*  TRV_DELAY SSP_CFG registers */
 #define REG_TRV_DELAY_TRV_DELAY_VALUE GENMASK(6, 0)
-- 
2.20.1


