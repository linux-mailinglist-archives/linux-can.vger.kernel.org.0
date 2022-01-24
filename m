Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A2F49A74D
	for <lists+linux-can@lfdr.de>; Tue, 25 Jan 2022 03:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiAYChE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 24 Jan 2022 21:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2371568AbiAYAIl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 24 Jan 2022 19:08:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F58FC0885A8
        for <linux-can@vger.kernel.org>; Mon, 24 Jan 2022 13:56:48 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nC7KQ-0003Yf-OC
        for linux-can@vger.kernel.org; Mon, 24 Jan 2022 22:56:46 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B47DF21380
        for <linux-can@vger.kernel.org>; Mon, 24 Jan 2022 21:56:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id A53012137A;
        Mon, 24 Jan 2022 21:56:43 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c06b714b;
        Mon, 24 Jan 2022 21:56:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 8/9] can: kvaser_usb: kvaser_usb_send_cmd(): remove redundant variable actual_len
Date:   Mon, 24 Jan 2022 22:56:41 +0100
Message-Id: <20220124215642.3474154-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124215642.3474154-1-mkl@pengutronix.de>
References: <20220124215642.3474154-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The function usb_bulk_msg() can be called with a NULL pointer as the
"actual_length" parameter. This patch removes this variable.

Cc: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index c4b4d3d0a387..e67658b53d02 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -205,12 +205,10 @@ MODULE_DEVICE_TABLE(usb, kvaser_usb_table);
 
 int kvaser_usb_send_cmd(const struct kvaser_usb *dev, void *cmd, int len)
 {
-	int actual_len; /* Not used */
-
 	return usb_bulk_msg(dev->udev,
 			    usb_sndbulkpipe(dev->udev,
 					    dev->bulk_out->bEndpointAddress),
-			    cmd, len, &actual_len, KVASER_USB_TIMEOUT);
+			    cmd, len, NULL, KVASER_USB_TIMEOUT);
 }
 
 int kvaser_usb_recv_cmd(const struct kvaser_usb *dev, void *cmd, int len,
-- 
2.34.1


