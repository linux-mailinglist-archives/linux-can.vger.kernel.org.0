Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7964EB427
	for <lists+linux-can@lfdr.de>; Tue, 29 Mar 2022 21:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240979AbiC2Tgk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 29 Mar 2022 15:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiC2Tgj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 29 Mar 2022 15:36:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F22986DB
        for <linux-can@vger.kernel.org>; Tue, 29 Mar 2022 12:34:56 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nZHcE-0005hr-NA
        for linux-can@vger.kernel.org; Tue, 29 Mar 2022 21:34:54 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 266475670A
        for <linux-can@vger.kernel.org>; Tue, 29 Mar 2022 19:34:54 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 1105156707;
        Tue, 29 Mar 2022 19:34:54 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id fd933fde;
        Tue, 29 Mar 2022 19:34:53 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        syzbot+4d0ae90a195b269f102d@syzkaller.appspotmail.com
Subject: [PATCH] can: gs_usb: gs_make_candev(): fix memory leak for devices with extended bit timing configuration
Date:   Tue, 29 Mar 2022 21:34:50 +0200
Message-Id: <20220329193450.659726-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

Some CAN-FD capable devices offer extended bit timing information for
the data bit timing. The information must be read with an USB control
message. The memory for this message is allocated but not free()ed (in
the non error case). This patch adds the missing free.

Fixes: 6679f4c5e5a6 ("can: gs_usb: add extended bt_const feature")
Reported-by: syzbot+4d0ae90a195b269f102d@syzkaller.appspotmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 67408e316062..b29ba9138866 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1092,6 +1092,8 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		dev->data_bt_const.brp_inc = le32_to_cpu(bt_const_extended->dbrp_inc);
 
 		dev->can.data_bittiming_const = &dev->data_bt_const;
+
+		kfree(bt_const_extended);
 	}
 
 	SET_NETDEV_DEV(netdev, &intf->dev);
-- 
2.35.1


