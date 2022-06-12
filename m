Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2FE547C71
	for <lists+linux-can@lfdr.de>; Sun, 12 Jun 2022 23:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbiFLV1Q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 12 Jun 2022 17:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiFLV1P (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 12 Jun 2022 17:27:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3825123BD6
        for <linux-can@vger.kernel.org>; Sun, 12 Jun 2022 14:27:15 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o0V73-0006rm-OF
        for linux-can@vger.kernel.org; Sun, 12 Jun 2022 23:27:13 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 2772693506
        for <linux-can@vger.kernel.org>; Sun, 12 Jun 2022 21:27:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D616D93501;
        Sun, 12 Jun 2022 21:27:12 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id aa280717;
        Sun, 12 Jun 2022 21:27:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>
Subject: [PATCH] can: m_can: m_can_chip_config(): actually enable internal timestamping
Date:   Sun, 12 Jun 2022 23:27:08 +0200
Message-Id: <20220612212708.4081756-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In commit df06fd678260 ("can: m_can: m_can_chip_config(): enable and
configure internal timestamps") the timestamping in the m_can core
should be enabled. In peripheral mode, the RX'ed CAN frames, TX
compete frames and error events are sorted by the timestamp.

The above mentioned commit however forgot to enable the timestamping.
This patch adds the missing bits to the write of the Timestamp Counter
Configuration register.

Fixes: df06fd678260 ("can: m_can: m_can_chip_config(): enable and configure internal timestamps")
Cc: Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 5d0c82d8b9a9..03a22d493cf6 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1351,7 +1351,9 @@ static void m_can_chip_config(struct net_device *dev)
 	/* enable internal timestamp generation, with a prescalar of 16. The
 	 * prescalar is applied to the nominal bit timing
 	 */
-	m_can_write(cdev, M_CAN_TSCC, FIELD_PREP(TSCC_TCP_MASK, 0xf));
+	m_can_write(cdev, M_CAN_TSCC,
+		    FIELD_PREP(TSCC_TCP_MASK, 0xf) |
+		    FIELD_PREP(TSCC_TSS_MASK, TSCC_TSS_INTERNAL));
 
 	m_can_config_endisable(cdev, false);
 
-- 
2.35.1


