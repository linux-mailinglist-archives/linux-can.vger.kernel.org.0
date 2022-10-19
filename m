Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B336051FE
	for <lists+linux-can@lfdr.de>; Wed, 19 Oct 2022 23:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiJSVas (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Oct 2022 17:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJSVap (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Oct 2022 17:30:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3466018C432
        for <linux-can@vger.kernel.org>; Wed, 19 Oct 2022 14:30:45 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1olGeB-0004fC-Co
        for linux-can@vger.kernel.org; Wed, 19 Oct 2022 23:30:43 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D5F3F104173
        for <linux-can@vger.kernel.org>; Wed, 19 Oct 2022 21:30:42 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 2906510416D;
        Wed, 19 Oct 2022 21:30:42 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 77dad1fd;
        Wed, 19 Oct 2022 21:30:36 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 7/7] can: gs_usb: add support for reading error counters
Date:   Wed, 19 Oct 2022 23:30:35 +0200
Message-Id: <20221019213035.1607752-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221019213035.1607752-1-mkl@pengutronix.de>
References: <20221019213035.1607752-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jeroen Hofstee <jhofstee@victronenergy.com>

Add support for reading the device state and CAN error counters, using
the GS_USB_BREQ_GET_STATE control message, if supported by the device,
indicated by the GS_CAN_FEATURE_GET_STATE feature flag.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 3f00e8d79b75..b279cf54cca1 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -961,6 +961,42 @@ static int gs_can_open(struct net_device *netdev)
 	return 0;
 }
 
+static int gs_usb_get_state(const struct net_device *netdev,
+			    struct can_berr_counter *bec,
+			    enum can_state *state)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+	struct gs_device_state ds;
+	int rc;
+
+	rc = usb_control_msg_recv(interface_to_usbdev(dev->iface), 0,
+				  GS_USB_BREQ_GET_STATE,
+				  USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+				  dev->channel, 0,
+				  &ds, sizeof(ds),
+				  USB_CTRL_GET_TIMEOUT,
+				  GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	if (ds.state >= CAN_STATE_MAX)
+		return -EOPNOTSUPP;
+
+	*state = ds.state;
+	bec->txerr = ds.txerr;
+	bec->rxerr = ds.rxerr;
+
+	return 0;
+}
+
+static int gs_usb_can_get_berr_counter(const struct net_device *netdev,
+				       struct can_berr_counter *bec)
+{
+	enum can_state state;
+
+	return gs_usb_get_state(netdev, bec, &state);
+}
+
 static int gs_can_close(struct net_device *netdev)
 {
 	int rc;
@@ -1235,6 +1271,9 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	if (feature & GS_CAN_FEATURE_BERR_REPORTING)
 		dev->can.ctrlmode_supported |= CAN_CTRLMODE_BERR_REPORTING;
 
+	if (feature & GS_CAN_FEATURE_GET_STATE)
+		dev->can.do_get_berr_counter = gs_usb_can_get_berr_counter;
+
 	/* The CANtact Pro from LinkLayer Labs is based on the
 	 * LPC54616 µC, which is affected by the NXP LPC USB transfer
 	 * erratum. However, the current firmware (version 2) doesn't
-- 
2.35.1


