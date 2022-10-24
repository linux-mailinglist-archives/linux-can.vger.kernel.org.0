Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42ADD60BB2E
	for <lists+linux-can@lfdr.de>; Mon, 24 Oct 2022 22:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJXUts (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 24 Oct 2022 16:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiJXUt2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 24 Oct 2022 16:49:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4872E7F13E
        for <linux-can@vger.kernel.org>; Mon, 24 Oct 2022 11:56:49 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1on2c3-0001xq-He
        for linux-can@vger.kernel.org; Mon, 24 Oct 2022 20:55:51 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id EC69D108C70
        for <linux-can@vger.kernel.org>; Mon, 24 Oct 2022 18:55:50 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D558D108C6D;
        Mon, 24 Oct 2022 18:55:49 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c540e585;
        Mon, 24 Oct 2022 18:55:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: m_can: use consistent indention
Date:   Mon, 24 Oct 2022 20:55:44 +0200
Message-Id: <20221024185544.68240-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The driver uses indent-with-tab for defines. Replace spaces after
IR_ERR_BUS_31X with tab for consistent indention.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 34c76ee87c6e..59deb185fd6b 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -210,7 +210,7 @@ enum m_can_reg {
 
 /* Interrupts for version >= 3.1.x */
 #define IR_ERR_LEC_31X	(IR_PED | IR_PEA)
-#define IR_ERR_BUS_31X      (IR_ERR_LEC_31X | IR_WDI | IR_BEU | IR_BEC | \
+#define IR_ERR_BUS_31X	(IR_ERR_LEC_31X | IR_WDI | IR_BEU | IR_BEC | \
 			 IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | IR_RF1L | \
 			 IR_RF0L)
 #define IR_ERR_ALL_31X	(IR_ERR_STATE | IR_ERR_BUS_31X)
-- 
2.35.1


