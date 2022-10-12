Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA865FC15F
	for <lists+linux-can@lfdr.de>; Wed, 12 Oct 2022 09:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJLHpn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 12 Oct 2022 03:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJLHp2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 12 Oct 2022 03:45:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2CE27FEC
        for <linux-can@vger.kernel.org>; Wed, 12 Oct 2022 00:45:26 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oiWQe-00060m-TA
        for linux-can@vger.kernel.org; Wed, 12 Oct 2022 09:45:24 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 45647FB359
        for <linux-can@vger.kernel.org>; Wed, 12 Oct 2022 07:42:09 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 2A562FB352;
        Wed, 12 Oct 2022 07:42:08 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9d159858;
        Wed, 12 Oct 2022 07:42:07 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Vivek Yadav <vivek.2311@samsung.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [RFC] can: m_can: clean up LEC error handling
Date:   Wed, 12 Oct 2022 09:42:05 +0200
Message-Id: <20221012074205.691384-1-mkl@pengutronix.de>
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

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 15 ++++++++-------
 drivers/net/can/m_can/m_can.h |  2 +-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index dcb582563d5e..ebdd3c164d7b 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -816,11 +816,9 @@ static void m_can_handle_other_err(struct net_device *dev, u32 irqstatus)
 		netdev_err(dev, "Message RAM access failure occurred\n");
 }
 
-static inline bool is_lec_err(u32 psr)
+static inline bool is_lec_err(u8 lec)
 {
-	psr &= LEC_UNUSED;
-
-	return psr && (psr != LEC_UNUSED);
+	return lec != LEC_NO_ERROR && lec != LEC_NO_CHANGE;
 }
 
 static inline bool m_can_is_protocol_err(u32 irqstatus)
@@ -875,9 +873,12 @@ static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus,
 		work_done += m_can_handle_lost_msg(dev);
 
 	/* handle lec errors on the bus */
-	if ((cdev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) &&
-	    is_lec_err(psr))
-		work_done += m_can_handle_lec_err(dev, psr & LEC_UNUSED);
+	if (cdev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
+		u8 lec = FIELD_GET(PSR_LEC_MASK, psr);
+
+		if (is_lec_err(lec))
+			work_done += m_can_handle_lec_err(dev, lec);
+	}
 
 	/* handle protocol errors in arbitration phase */
 	if ((cdev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) &&
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 4c0267f9f297..52563c048732 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -38,7 +38,7 @@ enum m_can_lec_type {
 	LEC_BIT1_ERROR,
 	LEC_BIT0_ERROR,
 	LEC_CRC_ERROR,
-	LEC_UNUSED,
+	LEC_NO_CHANGE,
 };
 
 enum m_can_mram_cfg {
-- 
2.35.1


