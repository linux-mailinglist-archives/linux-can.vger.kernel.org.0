Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5914F7B9FCC
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 16:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjJEO3j (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 10:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbjJEO1i (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 10:27:38 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F537EC7
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:48:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ60-0000aC-9T
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:48:32 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ5z-00BDJ6-RD
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:48:31 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 86FAB22F763
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:48:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id CF6D922F754;
        Thu,  5 Oct 2023 07:48:30 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1ff9ce07;
        Thu, 5 Oct 2023 07:48:29 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:48:21 +0200
Subject: [PATCH v2 4/5] can: dev: can_restart(): update debug and error
 messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-can-dev-fix-can-restart-v2-4-91b5c1fd922c@pengutronix.de>
References: <20231005-can-dev-fix-can-restart-v2-0-91b5c1fd922c@pengutronix.de>
In-Reply-To: <20231005-can-dev-fix-can-restart-v2-0-91b5c1fd922c@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=6WoHl5aVYFfT31hoJpDNqQF7WQmYnmOXBn76uNtecio=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmpKuaor6v/+/B4CMUKZQxo1jv4eDHNKqig7M
 osoCj67wUmJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qSgAKCRC+UBxKKooE
 6CC6B/4xPpoIv4xGcHuJJeLbfsrjM2OvRz17xZKrg4kosf/kp+h2lJJVo7RJMJklZZ94+3UX3sk
 lNeJbpfDv9tP9aWLctuiwJVWVEMINwjHL6V57+WRBlBzcmZD2td10tKf4USSKWF4VtCTMTgvS9P
 /UTH3hwMTW7klTqManeM03misth+nG4v+VTPMEIbwr+IrUJpZPY3jha/t6EUfMpZdgUH1OGaxT7
 gDSnVU7jcS68Lb/k6jSOv4cRVLOK5aKyaKmWAjupEh9AKGrr18dAU+oPusUKH6/3ff8JkL1cFNR
 fx93irlpILfOwzLbWgmeKwLq1mDyR2mFxR2/D+OntvX0bnyy
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

Move the debug message "restarted" _after_ the successful restart of
the CAN device, because the restart may fail.

Also update the error message from printing the error number to
printing symbolic error names.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 9014256c486a..82b12902fc35 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -147,15 +147,15 @@ static void can_restart(struct net_device *dev)
 		netif_rx(skb);
 	}
 
-	netdev_dbg(dev, "restarted\n");
-	priv->can_stats.restarts++;
-
 	/* Now restart the device */
 	netif_carrier_on(dev);
 	err = priv->do_set_mode(dev, CAN_MODE_START);
 	if (err) {
-		netdev_err(dev, "Error %d during restart", err);
+		netdev_err(dev, "Restart failed, error %pe\n", ERR_PTR(err));
 		netif_carrier_off(dev);
+	} else {
+		netdev_dbg(dev, "Restarted\n");
+		priv->can_stats.restarts++;
 	}
 }
 

-- 
2.40.1


