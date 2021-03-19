Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7B3341D1F
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 13:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhCSMmS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 08:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCSMl4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 08:41:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310F0C06175F
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 05:41:56 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lNERu-0003EJ-QP
        for linux-can@vger.kernel.org; Fri, 19 Mar 2021 13:41:54 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 048555FA99D
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 12:41:51 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7754B5FA97F;
        Fri, 19 Mar 2021 12:41:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3a8a0ca8;
        Fri, 19 Mar 2021 12:41:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, mailhol.vincent@wanadoo.fr,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v13 11/11] can: etas_es58x: es58x_fd: remove setting of dql.min_limit for now
Date:   Fri, 19 Mar 2021 13:41:41 +0100
Message-Id: <20210319124141.247844-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319124141.247844-1-mkl@pengutronix.de>
References: <20210319124141.247844-1-mkl@pengutronix.de>
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
 drivers/net/can/usb/etas_es58x/es58x_fd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
index 5260c14c6378..e0c4f9f5f94e 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_fd.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
@@ -576,10 +576,6 @@ const struct es58x_parameters es58x_fd_param = {
 	 * maximum, so no impact on performance was measured.
 	 */
 	.fifo_mask = 255, /* echo_skb_max = 256 */
-#ifdef CONFIG_BQL
-	/* Empirical value. */
-	.dql_limit_min = CAN_FRAME_LEN_MAX * 15,
-#endif
 	.tx_bulk_max = ES58X_FD_TX_BULK_MAX,
 	.urb_cmd_header_len = ES58X_FD_URB_CMD_HEADER_LEN,
 	.rx_urb_max = ES58X_RX_URBS_MAX,
-- 
2.30.2


