Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9E87B9FCE
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 16:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjJEO3l (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 10:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjJEO2N (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 10:28:13 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19177ED5
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:50:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7g-0001F9-5u
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:16 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7e-00BDLC-SV
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:14 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 98E5122F7AC
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:50:14 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D2FEA22F790;
        Thu,  5 Oct 2023 07:50:13 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e77d50b4;
        Thu, 5 Oct 2023 07:50:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:49:34 +0200
Subject: [PATCH v2 06/27] can: at91_can: MMR registers: convert to
 FIELD_PREP()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-at91_can-rx_offload-v2-6-9987d53600e0@pengutronix.de>
References: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
In-Reply-To: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1329; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=7/jKnhI3sCWYBeiuIIcpdIDnbPlZSqT0w4BNmU8ydxA=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmqTJAS7YrhD9LnnlhHvHQ/yqZPlZsjjo5WUr
 apLgUTRoeuJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qkwAKCRC+UBxKKooE
 6K2nB/400jZZYXo8xbIeLyAjby0I6nLkY1bEshXX1pvs5tjAvFgG5o8Oz68pdwXdlkPM42RWPPn
 03dWZNpWesmjfrXwUnEdvzVKH9SaJvqVSWhgRttqITGr86b0a8U1BufqHCi8riBBVs4jizd5vlO
 /Ru1ydnEJhmlSSbv55SkjiA982vkmxm4Xe3xVle7ASwJV9SQeENCHbGY/3HNt9XYKeVYJUqZJc+
 m6vp21O5wundQ+Z9TnPYlcVOoEe0anGBRt0IRY3xpLPKvpi88t1X4/+6+yBo5rNJBj1kjtpomHN
 tlFGN3AjXbBRdMialL3HGUsxqPMXhMtow/thIiVeOhhUX8C8
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

Use FIELD_PREP() to access the individual fields of the MMR register.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 7597da543348..16a62f649418 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -75,7 +75,9 @@ enum at91_reg {
 #define AT91_ECR_REC_MASK GENMASK(8, 0)
 #define AT91_ECR_TEC_MASK GENMASK(23, 16)
 
-#define AT91_MMR_PRIO_SHIFT (16)
+#define AT91_MMR_MTIMEMARK_MASK GENMASK(15, 0)
+#define AT91_MMR_PRIOR_MASK GENMASK(19, 16)
+#define AT91_MMR_MOT_MASK GENMASK(26, 24)
 
 #define AT91_MID_MIDE BIT(29)
 
@@ -299,9 +301,12 @@ static inline void at91_write(const struct at91_priv *priv, enum at91_reg reg,
 
 static inline void set_mb_mode_prio(const struct at91_priv *priv,
 				    unsigned int mb, enum at91_mb_mode mode,
-				    int prio)
+				    u8 prio)
 {
-	at91_write(priv, AT91_MMR(mb), (mode << 24) | (prio << 16));
+	const u32 reg_mmr = FIELD_PREP(AT91_MMR_MOT_MASK, mode) |
+		FIELD_PREP(AT91_MMR_PRIOR_MASK, prio);
+
+	at91_write(priv, AT91_MMR(mb), reg_mmr);
 }
 
 static inline void set_mb_mode(const struct at91_priv *priv, unsigned int mb,

-- 
2.40.1


