Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22148341D17
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 13:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCSMmP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 08:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhCSMlv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 08:41:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EDEC06174A
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 05:41:50 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lNERp-00030a-GR
        for linux-can@vger.kernel.org; Fri, 19 Mar 2021 13:41:49 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 86D6F5FA97D
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 12:41:47 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 9205B5FA966;
        Fri, 19 Mar 2021 12:41:44 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9f80b03e;
        Fri, 19 Mar 2021 12:41:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, mailhol.vincent@wanadoo.fr,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v13 03/11] can: etas_es58x: es58x_rx_err_msg() fix typo
Date:   Fri, 19 Mar 2021 13:41:33 +0100
Message-Id: <20210319124141.247844-4-mkl@pengutronix.de>
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
 drivers/net/can/usb/etas_es58x/es58x_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index f2dc943bb0b2..b8dfff4bc7ac 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -641,7 +641,7 @@ int es58x_rx_can_msg(struct net_device *netdev, u64 timestamp, const u8 *data,
  * Handle the errors and events received by the ES58X device, create
  * a CAN error skb and post it.
  *
- * In some rare cases the devices might get stucked alternating between
+ * In some rare cases the devices might get stuck alternating between
  * CAN_STATE_ERROR_PASSIVE and CAN_STATE_ERROR_WARNING. To prevent
  * this behavior, we force a bus off state if the device goes in
  * CAN_STATE_ERROR_WARNING for ES58X_MAX_CONSECUTIVE_WARN consecutive
-- 
2.30.2


