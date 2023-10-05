Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63977B9F6C
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 16:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjJEOXs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 10:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjJEOWK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 10:22:10 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666E97EDA
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:50:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7h-0001FL-Hm
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:17 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7f-00BDLb-5i
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:15 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D509222F7B8
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:50:14 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 2BD0322F79B;
        Thu,  5 Oct 2023 07:50:14 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9dfa2982;
        Thu, 5 Oct 2023 07:50:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:49:37 +0200
Subject: [PATCH v2 09/27] can: at91_can: MCR Register: convert to
 FIELD_PREP()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-at91_can-rx_offload-v2-9-9987d53600e0@pengutronix.de>
References: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
In-Reply-To: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=YrM90VorI74f0rY0f0LwiI96RbngAxwugCi7U3Yt+i4=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmqXzpfhC7WIB/FvNz4IXw3/R/tsiwGKtk0Nd
 D9kTQc1gOCJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qlwAKCRC+UBxKKooE
 6LvUCACoPAAzDB5Tb8VgcGdjClAW1IMIkzh3xUJYLzI4sL+e+GZOPhEJGHrzwLSURfHlPIWWdr1
 JWqWxqo5+fumlMmPsldSa3QKgaNU2AaLxS8PixlgOJGQ7ypLmCd8QJEj7P0ECS5QBHUG7rcT68G
 vK3EdNPXSPwnCKg5uW5zYAhvk2Uehrzx40VRIbrAz/xoVOlvM/O+0dVx5pXD99a7Rn8nVN1axBb
 Fcli2Irue6q0KSsHQIVSMeUaDLAwWg9srO5H+L0y8PNi6VqNGsl5pPGWfppsHRIgZwWs7+VSlD8
 DrVp+36a6eQr5HwrHEU2pQp+cW4OQLVsL5XJB1BJyzs7H+M/
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

Use FIELD_PREP() to access the individual fields of the MCR register.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 41dd2ea239b9..0269e2a6508a 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -90,7 +90,9 @@ enum at91_reg {
 #define AT91_MSR_MRDY BIT(23)
 #define AT91_MSR_MMI BIT(24)
 
+#define AT91_MCR_MDLC_MASK GENMASK(19, 16)
 #define AT91_MCR_MRTR BIT(20)
+#define AT91_MCR_MACR BIT(22)
 #define AT91_MCR_MTCR BIT(23)
 
 /* Mailbox Modes */
@@ -490,8 +492,12 @@ static netdev_tx_t at91_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		return NETDEV_TX_BUSY;
 	}
 	reg_mid = at91_can_id_to_reg_mid(cf->can_id);
-	reg_mcr = ((cf->can_id & CAN_RTR_FLAG) ? AT91_MCR_MRTR : 0) |
-		(cf->len << 16) | AT91_MCR_MTCR;
+
+	reg_mcr = FIELD_PREP(AT91_MCR_MDLC_MASK, cf->len) |
+		AT91_MCR_MTCR;
+
+	if (cf->can_id & CAN_RTR_FLAG)
+		reg_mcr |= AT91_MCR_MRTR;
 
 	/* disable MB while writing ID (see datasheet) */
 	set_mb_mode(priv, mb, AT91_MB_MODE_DISABLED);

-- 
2.40.1


