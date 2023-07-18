Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635BE75792F
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 12:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjGRKTj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 06:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjGRKTh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 06:19:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A0F198
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 03:19:36 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLhnr-0000rH-3v
        for linux-can@vger.kernel.org; Tue, 18 Jul 2023 12:19:35 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 6C1241F406D
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 10:19:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id B9F9B1F406A;
        Tue, 18 Jul 2023 10:19:33 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id efa93325;
        Tue, 18 Jul 2023 10:19:33 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Tue, 18 Jul 2023 12:19:30 +0200
Subject: [PATCH] can: gs_usb: gs_can_close(): add missing set of CAN state
 to CAN_STATE_STOPPED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-gs_usb-fix-can-state-v1-1-f19738ae2c23@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIADJntmQC/x2MQQqAIBAAvxJ7biEtsPpKRJhttRcLtyIQ/550H
 JiZCEKBSaAvIgR6WPjwGVRZgNut3wh5yQy60nVlVIubTLfMuPKLznqUy16E1nW6MUaZlWrI6Rk
 oC/92GFP6AId2dNJmAAAA
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, stable@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=BbAO6x5LqiWdy0ngYk0CNMno+9Z9BNL2rK0nPKdACCU=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktmcyKoJb2TjqIXxRgtkqVyuV+HaqlldFLXCSr
 efkMa00zaSJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLZnMgAKCRC+UBxKKooE
 6BI7B/4+ZEqXZXQds3Wq35SeNb+l1OyenFio+J1DJU9L8Tn8b/35ghlXS6Ukc3mW/gzNZidbAS9
 HnAXywXk1Ryx24gWXCPeEvtx1dmo8uh4ajgpcpKeCXNAvWaYzy2ghCQFZnbn0UP4M8a4IRTOul8
 VAmn85zdwSrTqUJXjEC5WZOGTiUtPB3FfMm4T92Xddc0pJjCcXtP49VK0byDpKi2iz+gQdraB5E
 jMFZhb8r5AJot99ZCBvvBWFmRTvgXiNHbt8H1Cx6umbF0XgqzHby8CRSDC1LS0gfAYGSW2TbWFY
 sR2mI7ij5fmNyQaGARVLgXUHvj4xQ7biJrnikqI/l+MIQ8zf
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

After an initial link up the CAN device is in ERROR-ACTIVE mode. Due
to a missing CAN_STATE_STOPPED in gs_can_close() it doesn't change to
STOPPED after a link down:

| ip link set dev can0 up
| ip link set dev can0 down
| ip --details link show can0
| 13: can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 10
|     link/can  promiscuity 0 allmulti 0 minmtu 0 maxmtu 0
|     can state ERROR-ACTIVE restart-ms 1000

Add missing assignment of CAN_STATE_STOPPED in gs_can_close().

Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index f418066569fc..bd9eb066ecf1 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1030,6 +1030,8 @@ static int gs_can_close(struct net_device *netdev)
 	usb_kill_anchored_urbs(&dev->tx_submitted);
 	atomic_set(&dev->active_tx_urbs, 0);
 
+	dev->can.state = CAN_STATE_STOPPED;
+
 	/* reset the device */
 	rc = gs_cmd_reset(dev);
 	if (rc < 0)

---
base-commit: 9efa1a5407e81265ea502cab83be4de503decc49
change-id: 20230718-gs_usb-fix-can-state-ac9247717fe3

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>


