Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C44757A26
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 13:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjGRLLh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 07:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjGRLLe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 07:11:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D97173D
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 04:11:07 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLibh-0006Xt-OH
        for linux-can@vger.kernel.org; Tue, 18 Jul 2023 13:11:05 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id BA4C51F40D7
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 11:11:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id EA7E01F40C4;
        Tue, 18 Jul 2023 11:11:03 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c946d405;
        Tue, 18 Jul 2023 11:11:03 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Tue, 18 Jul 2023 13:10:23 +0200
Subject: [PATCH 01/11] can: gs_usb: remove leading space from goto labels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-gs_usb-cleanups-v1-1-c3b9154ec605@pengutronix.de>
References: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
In-Reply-To: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=yHikqZbGwymjYHys24Rb2CoBSkNGnkH8641Cjp3biQA=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktnMiMytRx9NTCVr4rGZPWYM6OK1RvBm4aK2s5
 N6sqUi6olaJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLZzIgAKCRC+UBxKKooE
 6CJQB/9rfqZKEZZgc8unvNKNPUIYETL5nYkk2XbgCd2MJWuzIX20QOLHkGHZSbWUefgzstVJObG
 n5uelC62llZ3JiaHL+HlQfdIqcjc4+4/Cbg+PZ378yStMzyDuV2l/Codzn7BPlwwUhrNzkfnv/x
 cqkI7U1an9ibvfuqmbFcqyaZaCNuruEyC1rFw0d41py2HhXV9Khwf0y7OciJteeH/bx15sJxgVN
 +WIsdGH02MhEVvjjKJaYUJFeKrSSEDgRvdsunpxeL5ELge9pytH+mlFyDLOdrdwOgsWRZjkSHoY
 eAZ1gioUL5Hnh5AZnrAURUHx23Qx/iA/eArgiHTjy1MM6WOT
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

Remove leading spaces from goto labels in accordance with the kernel
encoding style.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index bd9eb066ecf1..c604377138fd 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -645,7 +645,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		netif_rx(skb);
 	}
 
- resubmit_urb:
+resubmit_urb:
 	usb_fill_bulk_urb(urb, usbcan->udev,
 			  usb_rcvbulkpipe(usbcan->udev, GS_USB_ENDPOINT_IN),
 			  hf, dev->parent->hf_size_rx,
@@ -655,7 +655,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 	/* USB failure take down all interfaces */
 	if (rc == -ENODEV) {
- device_detach:
+device_detach:
 		for (rc = 0; rc < GS_MAX_INTF; rc++) {
 			if (usbcan->canch[rc])
 				netif_device_detach(usbcan->canch[rc]->netdev);
@@ -818,12 +818,12 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 
 	return NETDEV_TX_OK;
 
- badidx:
+badidx:
 	kfree(hf);
- nomem_hf:
+nomem_hf:
 	usb_free_urb(urb);
 
- nomem_urb:
+nomem_urb:
 	gs_free_tx_context(txc);
 	dev_kfree_skb(skb);
 	stats->tx_dropped++;
@@ -1354,7 +1354,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 	return dev;
 
- out_free_candev:
+out_free_candev:
 	free_candev(dev->netdev);
 	return ERR_PTR(rc);
 }

-- 
2.40.1


