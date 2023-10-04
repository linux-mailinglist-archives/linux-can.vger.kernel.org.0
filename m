Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD81D7B7BEC
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjJDJYZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjJDJYV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:24:21 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF256AF
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:24:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny75-0005Pp-Tm
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:16 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny73-00Azkn-HR
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:13 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 1BBA122EB65
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:24:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 64EC222EB46;
        Wed,  4 Oct 2023 09:24:12 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7b88e52a;
        Wed, 4 Oct 2023 09:24:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Wed, 04 Oct 2023 11:23:30 +0200
Subject: [PATCH 11/27] can: at91_can: at91_setup_mailboxes(): update
 comments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-at91_can-rx_offload-v1-11-c32bf99097db@pengutronix.de>
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
In-Reply-To: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1445; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=X+J+5aGBlGtr2wfQt8F5iWYvG06nguVjijl0p2RADHg=;
 b=owGbwMvMwMW4L0DGS6uL5QXjabUkhlRZfUX3TmGN1OBjrnktFauSNu5asn7KFPlHPeEWYnycd
 ce4ttzpZDRmYWDkYpAVU2ThO9u4d8Unk5XxX40CYAaxMoFMYeDiFICJzD/C/oezwXS3VP1Sb6f0
 wxOOFEvs+tmd+I2/MG+6iZRxsOINz7PMsX9Vxf6z6VlXTvxyIeZYu2pRi1u73t9TW22MH61JT47
 9Xh3fXbZ+wRHFeZEXZBPT24KXMuvmu5k0x3pwHeC/uDiFp9SW41TO+Tm1a7OCG6XD0qT7GTOtPj
 rIu4bcvmKs1/Z7w1arBt/0Mzu0Dk9Yd0Yq9iVfgONqxTt9ApPtHO61GPSsfuB86e1Sbm8nl5gvB
 9R8/xXNDGS5snN2TnhIiHVQd9FjSak9lWzNllbsz55tP3BTa7XtQe55WzXdGeSnb46Zw22z7qx6
 btBWk0ca0+Wv7ZsVH8StxnWkKzzYoO+u57Gb369NN14DAA==
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


