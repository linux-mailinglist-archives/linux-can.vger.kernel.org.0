Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65CB4D4B08
	for <lists+linux-can@lfdr.de>; Thu, 10 Mar 2022 15:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244080AbiCJOcp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Mar 2022 09:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343974AbiCJObe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Mar 2022 09:31:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DCCEAC8E
        for <linux-can@vger.kernel.org>; Thu, 10 Mar 2022 06:29:16 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nSJn0-0005w4-51
        for linux-can@vger.kernel.org; Thu, 10 Mar 2022 15:29:14 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id F28FD47DAE
        for <linux-can@vger.kernel.org>; Thu, 10 Mar 2022 14:29:09 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 9055747DA6;
        Thu, 10 Mar 2022 14:29:09 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3b8b4de6;
        Thu, 10 Mar 2022 14:29:04 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 10/29] can: gs_usb: fix checkpatch warning
Date:   Thu, 10 Mar 2022 15:28:44 +0100
Message-Id: <20220310142903.341658-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310142903.341658-1-mkl@pengutronix.de>
References: <20220310142903.341658-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch fixes a checkpatch warning by converting a "unsigned" into
an "unsigned int".

Link: https://lore.kernel.org/all/20220309124132.291861-3-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index a63650b17931..894cfc1f7a43 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1015,8 +1015,9 @@ static int gs_usb_probe(struct usb_interface *intf,
 
 static void gs_usb_disconnect(struct usb_interface *intf)
 {
-	unsigned i;
 	struct gs_usb *dev = usb_get_intfdata(intf);
+	unsigned int i;
+
 	usb_set_intfdata(intf, NULL);
 
 	if (!dev) {
-- 
2.35.1


