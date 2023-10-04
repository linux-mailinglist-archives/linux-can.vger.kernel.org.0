Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B5F7B7BE9
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjJDJYY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjJDJYU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:24:20 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17075AB
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:24:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny75-0005Ob-AX
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:15 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny73-00AzkQ-7X
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:13 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E022222EB5B
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:24:12 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id F3F9022EB3A;
        Wed,  4 Oct 2023 09:24:11 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a3046cb9;
        Wed, 4 Oct 2023 09:24:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Wed, 04 Oct 2023 11:23:26 +0200
Subject: [PATCH 07/27] can: at91_can: MID registers: convert access to
 FIELD_PREP(), FIELD_GET()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-at91_can-rx_offload-v1-7-c32bf99097db@pengutronix.de>
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
In-Reply-To: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1690; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=iA29O5YTjLylfsam0UhbNbMZJVw65488piQNwvezgMQ=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHS8bEgduHGv5j820V1Cauu1iJlKWgIxjg688H
 xPyN19AD6uJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR0vGwAKCRC+UBxKKooE
 6M1YCACmy1pgifmbHvt8/lqJKnzNCZZ0RS8TDAbFpgmQdHn8zZ+fGM3mf79OhfsWvDweM5OGkxt
 N3O6xfmgIndY1FnOypl6BiADvgVlZ13NAx9KkmZ3lVUDqLdzud2UCtsQYk2D/ZArz03lGtsuuNv
 3Kpgbf33IYorGqcJpW8wITT8CfECL8abtGd/1OTn+n0ydTDkft2HrU7r6XSuzHyuvKZYT9eh/R0
 migt9UMpm9QhEVXFfSLBj014L22Zogq/fs/Clk1yfPBIJgcUC9wHptR0QfimHl5z7aK4LYhHSd6
 acgVDPt3dAql1D+6S8i+pFSjVD/HUU1oNRvL9i41eHTBI1Cq
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

Use FIELD_PREP() and FIELD_GET() to access the individual fields of
the MID register.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 16a62f649418..ec028fe833f0 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -79,6 +79,8 @@ enum at91_reg {
 #define AT91_MMR_PRIOR_MASK GENMASK(19, 16)
 #define AT91_MMR_MOT_MASK GENMASK(26, 24)
 
+#define AT91_MID_MIDVB_MASK GENMASK(17, 0)
+#define AT91_MID_MIDVA_MASK GENMASK(28, 18)
 #define AT91_MID_MIDE BIT(29)
 
 #define AT91_MSR_MRTR BIT(20)
@@ -320,9 +322,10 @@ static inline u32 at91_can_id_to_reg_mid(canid_t can_id)
 	u32 reg_mid;
 
 	if (can_id & CAN_EFF_FLAG)
-		reg_mid = (can_id & CAN_EFF_MASK) | AT91_MID_MIDE;
+		reg_mid = FIELD_PREP(AT91_MID_MIDVA_MASK | AT91_MID_MIDVB_MASK, can_id) |
+			AT91_MID_MIDE;
 	else
-		reg_mid = (can_id & CAN_SFF_MASK) << 18;
+		reg_mid = FIELD_PREP(AT91_MID_MIDVA_MASK, can_id);
 
 	return reg_mid;
 }
@@ -590,9 +593,10 @@ static void at91_read_mb(struct net_device *dev, unsigned int mb,
 
 	reg_mid = at91_read(priv, AT91_MID(mb));
 	if (reg_mid & AT91_MID_MIDE)
-		cf->can_id = ((reg_mid >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
+		cf->can_id = FIELD_GET(AT91_MID_MIDVA_MASK | AT91_MID_MIDVB_MASK, reg_mid) |
+			CAN_EFF_FLAG;
 	else
-		cf->can_id = (reg_mid >> 18) & CAN_SFF_MASK;
+		cf->can_id = FIELD_GET(AT91_MID_MIDVA_MASK, reg_mid);
 
 	reg_msr = at91_read(priv, AT91_MSR(mb));
 	cf->len = can_cc_dlc2len((reg_msr >> 16) & 0xf);

-- 
2.40.1


