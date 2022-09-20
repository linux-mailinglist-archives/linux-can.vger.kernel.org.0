Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB41D5BE29C
	for <lists+linux-can@lfdr.de>; Tue, 20 Sep 2022 12:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiITKEz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Sep 2022 06:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiITKEx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Sep 2022 06:04:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A672AC71
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 03:04:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oaa7V-0003qp-Kv
        for linux-can@vger.kernel.org; Tue, 20 Sep 2022 12:04:49 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 2FA1DE7474
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 10:04:48 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7C560E7469;
        Tue, 20 Sep 2022 10:04:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d99cd969;
        Tue, 20 Sep 2022 10:04:47 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     John Whittington <git@jbrengineering.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/3] can: gs_usb: gs_usb_get_timestamp(): fix endpoint parameter for usb_control_msg_recv()
Date:   Tue, 20 Sep 2022 12:04:15 +0200
Message-Id: <20220920100416.959226-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220920100416.959226-1-mkl@pengutronix.de>
References: <20220920100416.959226-1-mkl@pengutronix.de>
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

The 2nd argument of usb_control_msg_recv() is the "endpoint",
usb_control_msg_recv() will internally convert the endpoint into a
pipe with usb_rcvctrlpipe().

In gs_usb_get_timestamp() not the endpoint "0" is passed, but the
pipe. This worked by accident as endpoint is a __u8 and the lowest 8
bits of the pipe are 0. Fix this copy/paste error by using the correct
endpoint of "0".

Fixes: 45dfa45f52e6 ("can: gs_usb: add RX and TX hardware timestamp support")
Cc: John Whittington <git@jbrengineering.co.uk>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 5ba159f49c4e..12e7437a9496 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -386,8 +386,7 @@ static inline int gs_usb_get_timestamp(const struct gs_can *dev,
 	__le32 timestamp;
 	int rc;
 
-	rc = usb_control_msg_recv(interface_to_usbdev(dev->iface),
-				  usb_sndctrlpipe(interface_to_usbdev(dev->iface), 0),
+	rc = usb_control_msg_recv(interface_to_usbdev(dev->iface), 0,
 				  GS_USB_BREQ_TIMESTAMP,
 				  USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
 				  dev->channel, 0,
-- 
2.35.1


