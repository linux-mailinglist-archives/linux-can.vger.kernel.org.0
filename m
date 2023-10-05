Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B18A7B9F91
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 16:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjJEOZy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 10:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjJEOXw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 10:23:52 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25AB7ED4
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:50:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7g-0001F6-6O
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:16 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7e-00BDLD-T0
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:14 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 9B93F22F7AD
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:50:14 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C2F8D22F78E;
        Thu,  5 Oct 2023 07:50:13 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8ec655b8;
        Thu, 5 Oct 2023 07:50:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:49:33 +0200
Subject: [PATCH v2 05/27] can: at91_can: ECR register: convert to
 FIELD_GET()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-at91_can-rx_offload-v2-5-9987d53600e0@pengutronix.de>
References: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
In-Reply-To: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=BA2SOOF1nVKGgmWh3hzGUZuUN9VEBhwEqRDuhASmkYM=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmqS9wh2OqIgMSVoiVKOMztrCUVNqqSR6IRMD
 TyReoUpymCJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qkgAKCRC+UBxKKooE
 6NpHB/44OMh1lM87ay50f8QG1LPCsVKdXvXxWlghsqIDd23YVD99VN1LUlA+8HKIFCD/FoPrydY
 z9BtdY1oKbLBxiPX18gjrANO12qeJ95h85k3i1rYg3z3LHhLZOdJJRi9/58krJVuILoxj1zJduW
 NmqdalkLNL5jBG1lDq4v1/DD282EMPfehmIlXJGMSe20FimF7iA8XK1bAVnqUMn4dkhhpjwIHoZ
 jc25FFoI8EcoagmrpsCSk7/ATO7U4UPDzDSZ0nWnDpZWuNegsP99alTv8j/bAyIKNqFGhVo7jwc
 45poQO6E+dIiHHEb3xmlQpzAh5Oc8kw5JPD57hcXQWEgQQJ+
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


