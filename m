Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CBC7BA02C
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 16:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjJEOev (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 10:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjJEOd0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 10:33:26 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575027ED9
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:50:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7h-0001Ff-G6
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:17 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7f-00BDLx-B8
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:15 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 0C52A22F7BF
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:50:15 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5E05D22F7A3;
        Thu,  5 Oct 2023 07:50:14 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 320d25dc;
        Thu, 5 Oct 2023 07:50:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:49:39 +0200
Subject: [PATCH v2 11/27] can: at91_can: at91_setup_mailboxes(): update
 comments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-at91_can-rx_offload-v2-11-9987d53600e0@pengutronix.de>
References: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
In-Reply-To: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1445; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=X+J+5aGBlGtr2wfQt8F5iWYvG06nguVjijl0p2RADHg=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmqa7ScjRIjC+COxW+IY/6AzXyjAAV+Use2MB
 FVGhZ67SDWJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qmgAKCRC+UBxKKooE
 6JgjCACHJe6kK1iIw+/KWpOAOVA3o/0xuX3XYpVqgdqMlr3dTy1X3R0PamW+Qr7Y9NHgpKkMnUT
 4rScNKUZgEGzT0xALe8aMH0p5HP3Ga65mfJFVWR7MJPZ2mT/C6rHeel2sPkWN68guyS8cRDENp7
 enZqqOAMxkPZpAZDQM1zYRmvGO4nJ59rCxfr1piYZ8oZoJfZ0L9flTwlyx+k3wqhTRBSABy/q5H
 KWpxoeW5dXG6aAzX7lILYGqaZWS/mccbl4LGYbdUKlDe6f0XLXeSHSyPAHfCeqDZoQXfEHYJZj2
 NCBLm4UFsdft04ajR7o7CRBLIkomdg4ZtteqXBfHL5kot3sC
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

Since 6388b3961420 ("can: at91_can: add support for the AT91SAM9X5
SOCs") the number of mailboxes used for RX and TX is no longer
constant, but depends on the IP core used.

Remove the fixed number of mailboxes from the comment.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index f23d036d947d..b94fb35dc59e 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -347,8 +347,8 @@ static void at91_setup_mailboxes(struct net_device *dev)
 	u32 reg_mid;
 
 	/* Due to a chip bug (errata 50.2.6.3 & 50.3.5.3) the first
-	 * mailbox is disabled. The next 11 mailboxes are used as a
-	 * reception FIFO. The last mailbox is configured with
+	 * mailbox is disabled. The next mailboxes are used as a
+	 * reception FIFO. The last of the RX mailboxes is configured with
 	 * overwrite option. The overwrite flag indicates a FIFO
 	 * overflow.
 	 */
@@ -369,7 +369,7 @@ static void at91_setup_mailboxes(struct net_device *dev)
 		at91_write(priv, AT91_MID(i), AT91_MID_MIDE);
 	}
 
-	/* The last 4 mailboxes are used for transmitting. */
+	/* The last mailboxes are used for transmitting. */
 	for (i = get_mb_tx_first(priv); i <= get_mb_tx_last(priv); i++)
 		set_mb_mode_prio(priv, i, AT91_MB_MODE_TX, 0);
 

-- 
2.40.1


