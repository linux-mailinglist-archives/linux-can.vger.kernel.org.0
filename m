Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53C97B7BE1
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjJDJYU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjJDJYS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:24:18 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EE9AD
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:24:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny73-0005ML-Mw
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:13 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny72-00AzjW-Iv
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:12 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 4F7D722EB43
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:24:12 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 8991922EB2E;
        Wed,  4 Oct 2023 09:24:11 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ff3250b7;
        Wed, 4 Oct 2023 09:24:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Wed, 04 Oct 2023 11:23:22 +0200
Subject: [PATCH 03/27] can: at91_can: at91_irq_tx(): remove one level of
 indention
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-at91_can-rx_offload-v1-3-c32bf99097db@pengutronix.de>
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
In-Reply-To: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=sV9DcKYzUHX0bevzb/vhNyQqkr7UfQ2LmqsDKzZCKIM=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHS8VEBDjHwxLiR9NhFjkSzTNNrCFZDTz4X3zQ
 ZfUaCSZDf2JATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR0vFQAKCRC+UBxKKooE
 6LAPB/9eEofAB8CI95NBdnGp4+DiuLv8J2P5jYWr3zIGVz8/WpDvb3r4WAMgmW3wn31owYcT4hw
 QAGjhVqzh/vIwtQkTzb7q/me+2oMQt66kSyKnwRxLjGrfOSFuM9Erf24J1RZs6EdzRDY+owYZtE
 WThtH1dFzMl7PgvPQDB1zznGqOtAebGsEBdtSjqKheIiiFATV6MQlfaENf9V+3QRrZ19Ob/qnGz
 LdRHjtbwO7w9JeJx6AWcsxInmJA6LP4pncrtpLXQXGGX3ZPVJKvYdUK2Le+qJ1ldLA0rhKnEQGK
 n4jvNT1zGKz69+/YJo8i0siJth+ZK2eZXHkmDya9Ur98FD6/
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

Improve code readability by removing one level of indention.

If a mailbox is not ready, continue the loop early.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 367ccf109652..966980d4b5dd 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -844,15 +844,14 @@ static void at91_irq_tx(struct net_device *dev, u32 reg_sr)
 		 * parked in the echo queue.
 		 */
 		reg_msr = at91_read(priv, AT91_MSR(mb));
-		if (likely(reg_msr & AT91_MSR_MRDY &&
-			   ~reg_msr & AT91_MSR_MABT)) {
-			/* _NOTE_: subtract AT91_MB_TX_FIRST offset from mb! */
-			dev->stats.tx_bytes +=
-				can_get_echo_skb(dev,
-						 mb - get_mb_tx_first(priv),
-						 NULL);
-			dev->stats.tx_packets++;
-		}
+		if (unlikely(!(reg_msr & AT91_MSR_MRDY &&
+			       ~reg_msr & AT91_MSR_MABT)))
+			continue;
+
+		/* _NOTE_: subtract AT91_MB_TX_FIRST offset from mb! */
+		dev->stats.tx_bytes +=
+			can_get_echo_skb(dev, mb - get_mb_tx_first(priv), NULL);
+		dev->stats.tx_packets++;
 	}
 
 	/* restart queue if we don't have a wrap around but restart if

-- 
2.40.1


