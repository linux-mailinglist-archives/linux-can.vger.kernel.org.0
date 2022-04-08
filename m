Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D884F95F6
	for <lists+linux-can@lfdr.de>; Fri,  8 Apr 2022 14:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiDHMo0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Apr 2022 08:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiDHMoX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Apr 2022 08:44:23 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Apr 2022 05:42:13 PDT
Received: from mail.prodrive-technologies.com (mail.prodrive-technologies.com [212.61.153.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868FB1C16FC
        for <linux-can@vger.kernel.org>; Fri,  8 Apr 2022 05:42:10 -0700 (PDT)
Received: from EXC03.bk.prodrive.nl (10.1.1.212) by EXC03.bk.prodrive.nl
 (10.1.1.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2242.12; Fri, 8
 Apr 2022 14:27:06 +0200
Received: from lnxdevrm02.prodrive.nl (10.1.1.121) by EXC03.bk.prodrive.nl
 (10.1.1.212) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 8 Apr 2022 14:27:06 +0200
From:   Wouter van Herpen <wouter.van.herpen@prodrive-technologies.com>
To:     <mkl@blackshift.org>
CC:     <linux-can@vger.kernel.org>,
        Wouter van Herpen <wouter.van.herpen@prodrive-technologies.com>
Subject: [PATCH] can: m_can: m_can_isr(): disable mcan interrupts during tefn handling
Date:   Fri, 8 Apr 2022 13:26:50 +0100
Message-ID: <fe3c7a7ae0f16db0bac87c72faa4e91d0041fda3.1649414934.git.wouter.van.herpen@prodrive-technologies.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Under high mixed RX/TX interrupt load, the tcan4x5x's nINT signal
sometimes stays asserted, blocking any further interrupts.
Register M_CAN_IR is then set to 0x580d and never recovers.
This is caused by interrupts occurring during interrupt handling.
Disable MCAN interrupts during TX irq flag processing (from interrupt
context), as is the case for the RX irq flag processing.

Link: https://lore.kernel.org/linux-can/20220403105730.fnurim5vnnuxb7s5@pengutronix.de
Signed-off-by: Wouter van Herpen <wouter.van.herpen@prodrive-technologies.com>
---
Please note this patch was generated and tested with kernel base v5.4.
In the most recent kernel version, this patch is still required to fix
the issue described.

 drivers/net/can/m_can/m_can.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 562c8317e3aa..8cea1b946b71 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -949,11 +949,13 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	} else  {
 		if (ir & IR_TEFN) {
 			/* New TX FIFO Element arrived */
+			m_can_disable_all_interrupts(cdev);
 			m_can_echo_tx_event(dev);
 			can_led_event(dev, CAN_LED_EVENT_TX);
 			if (netif_queue_stopped(dev) &&
 			    !m_can_tx_fifo_full(cdev))
 				netif_wake_queue(dev);
+			m_can_enable_all_interrupts(cdev);
 		}
 	}
 

base-commit: 219d54332a09e8d8741c1e1982f5eae56099de85
-- 
2.30.2

