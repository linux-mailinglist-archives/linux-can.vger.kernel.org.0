Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A855337399D
	for <lists+linux-can@lfdr.de>; Wed,  5 May 2021 13:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhEELoE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 May 2021 07:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhEELoE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 May 2021 07:44:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1E4C061574
        for <linux-can@vger.kernel.org>; Wed,  5 May 2021 04:43:08 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1leFvm-0000WZ-SS
        for linux-can@vger.kernel.org; Wed, 05 May 2021 13:43:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 355E861D1E6
        for <linux-can@vger.kernel.org>; Wed,  5 May 2021 11:43:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D5AD361D1E4;
        Wed,  5 May 2021 11:43:05 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 94195df5;
        Wed, 5 May 2021 11:43:05 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH RFC] can: m_can: m_can_tx_work_queue(): fix tx_skb race condition
Date:   Wed,  5 May 2021 13:43:02 +0200
Message-Id: <20210505114302.1241971-1-mkl@pengutronix.de>
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

The m_can_start_xmit() function checks if the cdev->tx_skb is NULL and
returns with NETDEV_TX_BUSY in case tx_sbk is not NULL.

There is a race condition in the m_can_tx_work_queue(), where first
the skb is send to the driver and then the case tx_sbk is set to NULL.
A TX complete IRQ might come in between and wake the queue, which
results in tx_skb not being cleared yet.

Fixes: f524f829b75a ("can: m_can: Create a m_can platform framework")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

compile time tested only.

Marc

 drivers/net/can/m_can/m_can.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2fa10bc0befe..bba2a449ac70 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1544,6 +1544,8 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 	int i;
 	int putidx;
 
+	cdev->tx_skb = NULL;
+
 	/* Generate ID field for TX buffer Element */
 	/* Common to all supported M_CAN versions */
 	if (cf->can_id & CAN_EFF_FLAG) {
@@ -1660,7 +1662,6 @@ static void m_can_tx_work_queue(struct work_struct *ws)
 						   tx_work);
 
 	m_can_tx_handler(cdev);
-	cdev->tx_skb = NULL;
 }
 
 static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
-- 
2.30.2


