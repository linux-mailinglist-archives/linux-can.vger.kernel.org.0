Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813CA7BA695
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 18:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjJEQin (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 12:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjJEQiN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 12:38:13 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B917ED6
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:50:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7g-0001FE-Ry
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:16 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7f-00BDLR-3i
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:15 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id BDAED22F7B3
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:50:14 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id F0F9022F793;
        Thu,  5 Oct 2023 07:50:13 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id cbd47d92;
        Thu, 5 Oct 2023 07:50:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:49:35 +0200
Subject: [PATCH v2 07/27] can: at91_can: MID registers: convert access to
 FIELD_PREP(), FIELD_GET()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-at91_can-rx_offload-v2-7-9987d53600e0@pengutronix.de>
References: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
In-Reply-To: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1690; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=iA29O5YTjLylfsam0UhbNbMZJVw65488piQNwvezgMQ=;
 b=owGbwMvMwMW4L0DGS6uL5QXjabUkhlS5rKnc7tpuCowPHuX7rlbN7fWTEEpdGWqe69/y6/Ybz
 3OhOk86GY1ZGBi5GGTFFFn4zjbuXfHJZGX8V6MAmEGsTCBTGLg4BWAiCgbs/73/HFE+zXCWj984
 bSWH36W6qRUamfkBC3K1E16Lus3y6JaLO2XJKT9RYJX83e13TpycXZ2zw3lTwvQm5xnV4ibfv1h
 6fJq2Y4+B3pWpphtfe/pKat01O2cqMFHvmOcrhe6fgvqsf3ZPaFFMs+T33rzxcLiReL/eL1+lea
 5yf6ZwhUht5dB9tfCNy9avm1ku+whs0HkRt99H2ejjEVWbhjmzTuwvu7+4UEtU/kHZXyWvjp5dS
 XfEG02eBbolFOT1XKySbQvS27ZTlm9b7+SMj6294jtzLLL2uvxoVLifz83MNluc997zpq3Pmp6l
 /X3U5Vcpeuo8e1PIqhe14uzn51mvWrvYJmBpx7OIeVUSAA==
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


