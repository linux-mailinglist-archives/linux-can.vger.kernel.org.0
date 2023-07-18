Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DD8757A2E
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 13:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjGRLLl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 07:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjGRLLf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 07:11:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FF01739
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 04:11:09 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLibk-0006bT-0j
        for linux-can@vger.kernel.org; Tue, 18 Jul 2023 13:11:08 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 99EF21F40F1
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 11:11:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E212A1F40DB;
        Tue, 18 Jul 2023 11:11:04 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4add1ac1;
        Tue, 18 Jul 2023 11:11:03 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Tue, 18 Jul 2023 13:10:32 +0200
Subject: [PATCH 10/11] can: gs_usb: gs_destroy_candev(): remove not needed
 usb_kill_anchored_urbs()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-gs_usb-cleanups-v1-10-c3b9154ec605@pengutronix.de>
References: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
In-Reply-To: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=+dqdwdsPsUpRIFRTgYAydnhePsZC4kmSIGA6cl7k5P4=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktnNAuLUMavxuMu6uEzejbmmH0pbHnTL7qZjTr
 VOhU4i0GzqJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLZzQAAKCRC+UBxKKooE
 6E9ECACI2VtYlOvPQMY9r0Pr0R0dXHflzFGFEpJXolEjN16BDts8CHOO3jgta+U4xmUSUs/deZp
 hZBlBvyQ3a3QieOPBysDW2504Hze/Db6sjwd1FVvCmH9XXmofLbVRiBm608pvPV7R/w8Yz6rKf8
 waZb/tWRXQcuyzA7NPPvPWtFW1+u7CxnzKPYjtLRVFnf3gtKaiKKzvFbPI+VGYUM8GwwY+fsYSa
 JC0biLRg0pf6W2htUoTKZ3Q1J9e/HlUbMONGcLv56tpvwLvgFd8RtcIDV0TNmn8YOxWswYZwb1n
 bUc3EP9HwdZgm+baBR/7rd2jS9ZVsqQ6ySzCLLxgObzjSQxI
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In gs_destroy_candev(), the netdev is unregistered first, then all
anchored TX URBs (dev->tx_submitted) are disposed with
usb_kill_anchored_urbs().

The call to usb_kill_anchored_urbs() is not needed, as
unregister_candev() calls gs_can_close(), which already disposes the
TX URBS.

Remove not needed call to usb_kill_anchored_urbs() from
gs_destroy_candev().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 7718f6a4367e..5a0017b98532 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1356,7 +1356,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 static void gs_destroy_candev(struct gs_can *dev)
 {
 	unregister_candev(dev->netdev);
-	usb_kill_anchored_urbs(&dev->tx_submitted);
 	free_candev(dev->netdev);
 }
 

-- 
2.40.1


