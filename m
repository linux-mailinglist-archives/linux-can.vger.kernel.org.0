Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565BF7B7BE3
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjJDJYV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjJDJYT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:24:19 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249EC9E
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:24:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny74-0005Na-De
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:14 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny73-00AzkC-1Y
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:13 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B782922EB54
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:24:12 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C373322EB33;
        Wed,  4 Oct 2023 09:24:11 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 268c178a;
        Wed, 4 Oct 2023 09:24:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Wed, 04 Oct 2023 11:23:24 +0200
Subject: [PATCH 05/27] can: at91_can: ECR register: convert to FIELD_GET()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-at91_can-rx_offload-v1-5-c32bf99097db@pengutronix.de>
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
In-Reply-To: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=BA2SOOF1nVKGgmWh3hzGUZuUN9VEBhwEqRDuhASmkYM=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHS8YYz8pEL+wnMfs5zzSL3k/drP2GQWV+5/Bn
 /wfKSNfVQWJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR0vGAAKCRC+UBxKKooE
 6Cs0B/sFdVZLNBF8M0cNzbyHVlWdZpfe4SkYEU9E73YZafasSOOqRp7nfbXGC3U9+eF0hWnUWmL
 pd27PpDHx/0LYq95vKhg2R1UNvEZt3sZr/yxWt060/06NaVDAue2cqWLuEUDYe/LJvQEesbUYaB
 QUwAqBhrvNM+h03rDjaVfPc/tjXB4iOs1esxIwY7pWpXjVHvAH6zMBAX/ApIhRksOJYoJwHpkeU
 gY+hcaZykzBi9Jh5VAa9Qu1t2iXQEHTkZw+Oomur6efztGVbASf666PhBUo7rn8An+3FgwvnSSJ
 xoZuKnDQXTBZw16ZP6WtkyicBraqcY30lWHNEmYqvnosJZk4
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

Use FIELD_GET() to access the individual fields of the ECR register.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 79eb78b9f8ae..7597da543348 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -72,6 +72,9 @@ enum at91_reg {
 #define AT91_BR_BRP_MASK GENMASK(22, 16)
 #define AT91_BR_SMP BIT(24)
 
+#define AT91_ECR_REC_MASK GENMASK(8, 0)
+#define AT91_ECR_TEC_MASK GENMASK(23, 16)
+
 #define AT91_MMR_PRIO_SHIFT (16)
 
 #define AT91_MID_MIDE BIT(29)
@@ -385,8 +388,8 @@ static int at91_get_berr_counter(const struct net_device *dev,
 	const struct at91_priv *priv = netdev_priv(dev);
 	u32 reg_ecr = at91_read(priv, AT91_ECR);
 
-	bec->rxerr = reg_ecr & 0xff;
-	bec->txerr = reg_ecr >> 16;
+	bec->rxerr = FIELD_GET(AT91_ECR_REC_MASK, reg_ecr);
+	bec->txerr = FIELD_GET(AT91_ECR_TEC_MASK, reg_ecr);
 
 	return 0;
 }

-- 
2.40.1


