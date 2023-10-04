Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECB67B7BB3
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242006AbjJDJR7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242003AbjJDJR4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:17:56 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ABBB4
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:17:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny0t-0004Ay-LR
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:17:51 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny0t-00AzgY-44
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:17:51 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D14B922EAEF
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:17:50 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 299B622EADF;
        Wed,  4 Oct 2023 09:17:50 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c3de5ba9;
        Wed, 4 Oct 2023 09:17:49 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Wed, 04 Oct 2023 11:17:30 +0200
Subject: [PATCH 3/5] can: dev: can_restart(): reverse logic to remove need
 for goto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-can-dev-fix-can-restart-v1-3-2e52899eaaf5@pengutronix.de>
References: <20231004-can-dev-fix-can-restart-v1-0-2e52899eaaf5@pengutronix.de>
In-Reply-To: <20231004-can-dev-fix-can-restart-v1-0-2e52899eaaf5@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=853; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=nGQEpiksyuJeEdUcRtLUNhXcIwJiVwCzGVceJl1lCn4=;
 b=owEBbAGT/pANAwAKAb5QHEoqigToAcsmYgBlHS22UVIdTcn5Ye3eI3n2ZqrQ/yqDghaiwTlBV
 gYysjsasAWJATIEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR0ttgAKCRC+UBxKKooE
 6O2HB/jzirZF/qW3QId29/rjbBVRxGyJzki7MjEALJPDXu7LBB5GVkacDIzNs50SPCo+GFCSOG/
 QNqY99eYM7se2c2V2JS5h+c0X2Isy3W7Cuf+PcWcuh2hC9b9MRYBIeEzZ1BIqYvyk5EqVZOvBXl
 gKgXh70PBRJAUdmW9x0Oh5cn7yRsq/ucvUgG+TP2C3iUMnt2Lvkv1MiMwAS0UiKXhb//UZyFZ5B
 lkebjT/YKIpcW1hhCb61xnpPzbEP63gGqbTJ6BOMROwSfA/QjzjkTqnuyL67IBP1IhWUkDngPTe
 vhtCrApDInGdoxn7FkeaMG/8z2euy/ac9RqDLOMLGNGENi4=
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

Reverse the logic in the if statement and eliminate the need for a
goto to simplify code readability.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 735d5de3caa0..9014256c486a 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -142,14 +142,11 @@ static void can_restart(struct net_device *dev)
 
 	/* send restart message upstream */
 	skb = alloc_can_err_skb(dev, &cf);
-	if (!skb)
-		goto restart;
+	if (skb) {
+		cf->can_id |= CAN_ERR_RESTARTED;
+		netif_rx(skb);
+	}
 
-	cf->can_id |= CAN_ERR_RESTARTED;
-
-	netif_rx(skb);
-
-restart:
 	netdev_dbg(dev, "restarted\n");
 	priv->can_stats.restarts++;
 

-- 
2.40.1


