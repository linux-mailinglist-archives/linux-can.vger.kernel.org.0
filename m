Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F36C3AE92B
	for <lists+linux-can@lfdr.de>; Mon, 21 Jun 2021 14:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhFUMhK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Jun 2021 08:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhFUMhB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Jun 2021 08:37:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608B9C061760
        for <linux-can@vger.kernel.org>; Mon, 21 Jun 2021 05:34:46 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lvJ8W-0007FH-Pe
        for linux-can@vger.kernel.org; Mon, 21 Jun 2021 14:34:44 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id BB86F640600
        for <linux-can@vger.kernel.org>; Mon, 21 Jun 2021 12:34:42 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 3AE5B6405DE;
        Mon, 21 Jun 2021 12:34:39 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 72964fb3;
        Mon, 21 Jun 2021 12:34:38 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 5/8] can: ti_hecc: convert to can_rx_offload_irq_finish()
Date:   Mon, 21 Jun 2021 14:34:33 +0200
Message-Id: <20210621123436.2897023-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621123436.2897023-1-mkl@pengutronix.de>
References: <20210621123436.2897023-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ti_hecc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 73245d8836a9..353062ead98f 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -786,6 +786,8 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
 		int_status = hecc_read(priv, HECC_CANGIF0);
 	}
 
+	can_rx_offload_irq_finish(&priv->offload);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.30.2


