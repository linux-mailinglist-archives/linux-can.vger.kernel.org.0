Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9303D7B7BB5
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241946AbjJDJSA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242085AbjJDJR5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:17:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3119BB7
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:17:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny0t-0004Ad-LI
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:17:51 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny0t-00AzgT-16
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:17:51 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B9DB122EAED
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:17:50 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 0E63622EADE;
        Wed,  4 Oct 2023 09:17:50 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 572267ee;
        Wed, 4 Oct 2023 09:17:49 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Wed, 04 Oct 2023 11:17:29 +0200
Subject: [PATCH 2/5] can: dev: can_restart(): fix race condition between
 controller restart and netif_carrier_on()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-can-dev-fix-can-restart-v1-2-2e52899eaaf5@pengutronix.de>
References: <20231004-can-dev-fix-can-restart-v1-0-2e52899eaaf5@pengutronix.de>
In-Reply-To: <20231004-can-dev-fix-can-restart-v1-0-2e52899eaaf5@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3139; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=oEHQfe7mf9LSRC6kP92CwD+MM5HyrRcGZsTCS013mNc=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHS2zWUg72REbVylkIP935kjfBslfo80jOrQOL
 BZycTIfZDOJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR0tswAKCRC+UBxKKooE
 6PNHB/4xF/0taAh42p8XYUmjKuR03qawUTSabRdS2fh0dVeQNeaYMYy+Q5ukklmfFrNtpI8ZDKl
 9APxh/ZjmvWla2jwbV9udtC4nSQDXJjVRMDFd8dfKvixOfjD3WXZNPLNcSOwMt0HfqEwJxduV7c
 uj/FFrK0TX19ury7jynECk6cdBjG6jKkCulC3xcgv2mzqh2SXYlDkAA/gqBzOMh7oACUB/Qv8Gv
 dylWbt7xD3oFeK3gKNJy+X5MBJIoujUPWHYSPx0NhmDU05kayAHVkn0arAgMs8LEMuOgNqcPFxX
 4ylGn7jzmdLpNO/Mb4doTaVMY6uRFyW4oJUH9pk8F7iqHK0l
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This race condition was discovered while updating the at91_can driver
to use can_bus_off(). The following scenario describes how the
converted at91_can driver would behave.

When a CAN device goes into BUS-OFF state, the driver usually
stops/resets the CAN device and calls can_bus_off().

This function sets the netif carrier to off, and (if configured by
user space) schedules a delayed work that calls can_restart() to
restart the CAN device.

The can_restart() function first checks if the carrier is off and
triggers an error message if the carrier is OK.

Then it calls the driver's do_set_mode() function to restart the
device, then it sets the netif carrier to on. There is a race window
between these two calls.

The at91 CAN controller (observed on the sama5d3, a single core 32 bit
ARM CPU) has a hardware limitation. If the device goes into bus-off
while sending a CAN frame, there is no way to abort the sending of
this frame. After the controller is enabled again, another attempt is
made to send it.

If the bus is still faulty, the device immediately goes back to the
bus-off state. The driver calls can_bus_off(), the netif carrier is
switched off and another can_restart is scheduled. This occurs within
the race window before the original can_restart() handler marks the
netif carrier as OK. This would cause the 2nd can_restart() to be
called with an OK netif carrier, resulting in an error message.

The flow of the 1st can_restart() looks like this:

can_restart()
    // bail out if netif_carrier is OK

    netif_carrier_ok(dev)
    priv->do_set_mode(dev, CAN_MODE_START)
        // enable CAN controller
        // sama5d3 restarts sending old message

        // CAN devices goes into BUS_OFF, triggers IRQ

// IRQ handler start
    at91_irq()
        at91_irq_err_line()
            can_bus_off()
                netif_carrier_off()
                schedule_delayed_work()
// IRQ handler end

    netif_carrier_on()

The 2nd can_restart() will be called with an OK netif carrier and the
error message will be printed.

To close the race window, first set the netif carrier to on, then
restart the controller. In case the restart fails with an error code,
roll back the netif carrier to off.

Fixes: 39549eef3587 ("can: CAN Network device driver and Netlink interface")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index a5bbdfa9a269..735d5de3caa0 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -154,11 +154,12 @@ static void can_restart(struct net_device *dev)
 	priv->can_stats.restarts++;
 
 	/* Now restart the device */
-	err = priv->do_set_mode(dev, CAN_MODE_START);
-
 	netif_carrier_on(dev);
-	if (err)
+	err = priv->do_set_mode(dev, CAN_MODE_START);
+	if (err) {
 		netdev_err(dev, "Error %d during restart", err);
+		netif_carrier_off(dev);
+	}
 }
 
 static void can_restart_work(struct work_struct *work)

-- 
2.40.1


