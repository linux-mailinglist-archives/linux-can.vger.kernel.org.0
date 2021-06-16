Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A3D3A9740
	for <lists+linux-can@lfdr.de>; Wed, 16 Jun 2021 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhFPKa2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Jun 2021 06:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbhFPKa1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Jun 2021 06:30:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B1BC061574
        for <linux-can@vger.kernel.org>; Wed, 16 Jun 2021 03:28:21 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ltSmS-0005Ae-45
        for linux-can@vger.kernel.org; Wed, 16 Jun 2021 12:28:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B8F2263D186
        for <linux-can@vger.kernel.org>; Wed, 16 Jun 2021 10:28:16 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 9440963D168;
        Wed, 16 Jun 2021 10:28:13 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id dc9a77c7;
        Wed, 16 Jun 2021 10:28:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>
Subject: [can-next-rfc 6/9] can: m_can: remove support for custom bit timing
Date:   Wed, 16 Jun 2021 12:28:08 +0200
Message-Id: <20210616102811.2449426-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616102811.2449426-1-mkl@pengutronix.de>
References: <20210616102811.2449426-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since commit aee2b3ccc8a6 ("can: tcan4x5x: fix bittiming const, use
common bittiming from m_can driver") there is no use of the device
specific bit timing parameters (m_can_classdev::bit_timing and struct
m_can_classdev::data_timing).

This patch removes the support for custom bit timing from the driver,
as the common bit timing works for all known IP core implementations.

Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 24 ++++++------------------
 drivers/net/can/m_can/m_can.h |  3 ---
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index bba2a449ac70..3a2afa54aca2 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1436,32 +1436,20 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 	case 30:
 		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.x */
 		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
-		cdev->can.bittiming_const = cdev->bit_timing ?
-			cdev->bit_timing : &m_can_bittiming_const_30X;
-
-		cdev->can.data_bittiming_const = cdev->data_timing ?
-			cdev->data_timing :
-			&m_can_data_bittiming_const_30X;
+		cdev->can.bittiming_const = &m_can_bittiming_const_30X;
+		cdev->can.data_bittiming_const = &m_can_data_bittiming_const_30X;
 		break;
 	case 31:
 		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.1.x */
 		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
-		cdev->can.bittiming_const = cdev->bit_timing ?
-			cdev->bit_timing : &m_can_bittiming_const_31X;
-
-		cdev->can.data_bittiming_const = cdev->data_timing ?
-			cdev->data_timing :
-			&m_can_data_bittiming_const_31X;
+		cdev->can.bittiming_const = &m_can_bittiming_const_31X;
+		cdev->can.data_bittiming_const = &m_can_data_bittiming_const_31X;
 		break;
 	case 32:
 	case 33:
 		/* Support both MCAN version v3.2.x and v3.3.0 */
-		cdev->can.bittiming_const = cdev->bit_timing ?
-			cdev->bit_timing : &m_can_bittiming_const_31X;
-
-		cdev->can.data_bittiming_const = cdev->data_timing ?
-			cdev->data_timing :
-			&m_can_data_bittiming_const_31X;
+		cdev->can.bittiming_const = &m_can_bittiming_const_31X;
+		cdev->can.data_bittiming_const = &m_can_data_bittiming_const_31X;
 
 		cdev->can.ctrlmode_supported |=
 			(m_can_niso_supported(cdev) ?
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index ace071c3e58c..ea53322d110e 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -83,9 +83,6 @@ struct m_can_classdev {
 	struct work_struct tx_work;
 	struct sk_buff *tx_skb;
 
-	struct can_bittiming_const *bit_timing;
-	struct can_bittiming_const *data_timing;
-
 	struct m_can_ops *ops;
 
 	int version;
-- 
2.30.2


