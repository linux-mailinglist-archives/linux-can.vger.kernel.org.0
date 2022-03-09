Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D59F4D2F43
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 13:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiCIMmo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 07:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbiCIMmn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 07:42:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AA21768FB
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 04:41:44 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nRvdO-0002om-O9
        for linux-can@vger.kernel.org; Wed, 09 Mar 2022 13:41:42 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 5C6AE46BDC
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 12:41:39 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E0F0C46BCC;
        Wed,  9 Mar 2022 12:41:38 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5a7ddf71;
        Wed, 9 Mar 2022 12:41:33 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Peter Fink <pfink@christ-es.de>,
        Ryan Edwards <ryan.edwards@gmail.com>,
        =?UTF-8?q?Christoph=20M=C3=B6hring?= <cmoehring@christ-es.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 18/21] can: gs_usb: activate quirks for CANtact Pro unconditionally
Date:   Wed,  9 Mar 2022 13:41:29 +0100
Message-Id: <20220309124132.291861-19-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309124132.291861-1-mkl@pengutronix.de>
References: <20220309124132.291861-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Peter Fink <pfink@christ-es.de>

The CANtact Pro from LinkLayer Labs is based on the LPC54616 µC, which
is affected by the NXP LPC USB transfer erratum. However, the current
firmware (version 2) doesn't set the
GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX bit.

This patch sets the feature GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX to
workaround this issue.

For the GS_USB_BREQ_DATA_BITTIMING USB control message the CANtact Pro
firmware uses a request value, which is already used by the
candleLight firmware for a different purpose
(GS_USB_BREQ_GET_USER_ID).

This patch set the feature GS_CAN_FEATURE_QUIRK_BREQ_CANTACT_PRO to
workaround this issue.

Cc: Ryan Edwards <ryan.edwards@gmail.com>
Signed-off-by: Peter Fink <pfink@christ-es.de>
Signed-off-by: Christoph Möhring <cmoehring@christ-es.de>
[mkl: improve check for CANtact Pro and add GS_CAN_FEATURE_QUIRK_BREQ_OVERLAP quirk]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 1661b91de364..915c5dd8199b 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -993,6 +993,29 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		dev->can.do_set_data_bittiming = gs_usb_set_data_bittiming;
 	}
 
+	/* The CANtact Pro from LinkLayer Labs is based on the
+	 * LPC54616 µC, which is affected by the NXP LPC USB transfer
+	 * erratum. However, the current firmware (version 2) doesn't
+	 * set the GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX bit. Set the
+	 * feature GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX to workaround
+	 * this issue.
+	 *
+	 * For the GS_USB_BREQ_DATA_BITTIMING USB control message the
+	 * CANtact Pro firmware uses a request value, which is already
+	 * used by the candleLight firmware for a different purpose
+	 * (GS_USB_BREQ_GET_USER_ID). Set the feature
+	 * GS_CAN_FEATURE_QUIRK_BREQ_CANTACT_PRO to workaround this
+	 * issue.
+	 */
+	if (dev->udev->descriptor.idVendor == cpu_to_le16(USB_GSUSB_1_VENDOR_ID) &&
+	    dev->udev->descriptor.idProduct == cpu_to_le16(USB_GSUSB_1_PRODUCT_ID) &&
+	    dev->udev->manufacturer && dev->udev->product &&
+	    !strcmp(dev->udev->manufacturer, "LinkLayer Labs") &&
+	    !strcmp(dev->udev->product, "CANtact Pro") &&
+	    (le32_to_cpu(dconf->sw_version) <= 2))
+		dev->feature |= GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX |
+			GS_CAN_FEATURE_QUIRK_BREQ_CANTACT_PRO;
+
 	if (le32_to_cpu(dconf->sw_version) > 1)
 		if (feature & GS_CAN_FEATURE_IDENTIFY)
 			netdev->ethtool_ops = &gs_usb_ethtool_ops;
-- 
2.34.1


