Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91C77B7BE4
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241775AbjJDJYW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjJDJYT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:24:19 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D150B7
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:24:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny74-0005Nz-Ra
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:14 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny73-00AzkI-4G
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:13 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D124322EB57
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:24:12 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D7B4122EB36;
        Wed,  4 Oct 2023 09:24:11 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 30de33d1;
        Wed, 4 Oct 2023 09:24:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Wed, 04 Oct 2023 11:23:25 +0200
Subject: [PATCH 06/27] can: at91_can: MMR registers: convert to
 FIELD_PREP()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-at91_can-rx_offload-v1-6-c32bf99097db@pengutronix.de>
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
In-Reply-To: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1329; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=7/jKnhI3sCWYBeiuIIcpdIDnbPlZSqT0w4BNmU8ydxA=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHS8aSNytHGm/pck4mDe+EDe4ohBA//zbs3JHm
 t8nB9GZT8eJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR0vGgAKCRC+UBxKKooE
 6GUmB/9NwyHYq+lGJY+7AlogLSZejMaSIY3y2j4MvZ0jdSOpslEWFSaJN2pQ7HO4Fmh14amg3LC
 xSoNnsYe/em6SsSE54T6/Fbu3Y2df8qlCvGzkqk7yCZU+J9SYKMuNUNadBTZK8iCdCV129jM1p2
 4Qzfg+0WCmHFZKiOhp3jf62xf7fYzZ0XCVasc0cHmh9bbgKfrD4T+WKypjTzvS/UibaVZplHeFV
 vYMCPi+iLhsYp7n8boQr795vvkFnbuiLTnlEwODA5eJfbuRZxLgzl6grH0dtO28a4D3zyG5IO1r
 VXiP7IVbjTaiyJlqNhqXeg+0smZIARLeupYuyFF6uMThSxTa
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


