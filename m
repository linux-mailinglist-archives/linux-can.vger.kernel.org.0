Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A566757A2F
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 13:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjGRLLm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 07:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjGRLLf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 07:11:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B201BD7
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 04:11:09 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLibk-0006bm-3M
        for linux-can@vger.kernel.org; Tue, 18 Jul 2023 13:11:08 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 9EE2B1F40F2
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 11:11:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 015081F40DF;
        Tue, 18 Jul 2023 11:11:04 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a92e2e3e;
        Tue, 18 Jul 2023 11:11:03 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Tue, 18 Jul 2023 13:10:33 +0200
Subject: [PATCH 11/11] can: gs_usb: gs_usb_disconnect(): remove not needed
 usb_kill_anchored_urbs()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-gs_usb-cleanups-v1-11-c3b9154ec605@pengutronix.de>
References: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
In-Reply-To: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=934; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=pkSKFMkhvNi8mliuhZEpitE4LycmPZvP2hG6I2XkPyU=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktnNDS7GAF6+DK6Fm8Uf7CDhTYyX4OsZZob8zd
 DvmoPNya9CJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLZzQwAKCRC+UBxKKooE
 6EDZB/4kkKqgMprVy9GOkEFvisDQe53Dtio972fnC29aPOP0s017t/hUfF48jSFVrn3TaMKQex2
 i/rosIeq1OtGqI0Oop+u3k6RNZu0w9MbBYeOTopSXQBD5uSPUUaWHB2vhx079MlqStPidOyrT2z
 5ncmQTBQzV+/ELriGyXKrIfG5Lfk8LLn90fyjt75kcWSAjcuea7++Ew3etDK1XfBwrNkfu+iUhI
 +ZaHtDMYCVKEjDPWNXT8dAn/wFd9uKI5VZ+pfBxKjtEntIqSdkQQW5urxykCiEwU+/9fmnLBSNP
 ktMXHZ3RHt6GECw9b5Diyzwwjb/IJdFOmAfYgphkZEzaaYsH
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

In gs_usb_disconnect(), all channels are destroyed first, then all
anchored RX URBs (parent->rx_submitted) are disposed with
usb_kill_anchored_urbs().

The call to usb_kill_anchored_urbs() is not needed, as
gs_destroy_candev() of the last active channel already disposes the RX
URBS.

Remove not needed call to usb_kill_anchored_urbs() from
gs_usb_disconnect().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 5a0017b98532..6caf3974e028 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1471,7 +1471,6 @@ static void gs_usb_disconnect(struct usb_interface *intf)
 		if (parent->canch[i])
 			gs_destroy_candev(parent->canch[i]);
 
-	usb_kill_anchored_urbs(&parent->rx_submitted);
 	kfree(parent);
 }
 

-- 
2.40.1


