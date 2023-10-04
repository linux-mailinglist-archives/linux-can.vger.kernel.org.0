Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E00A7B7BE7
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241783AbjJDJYX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjJDJYT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:24:19 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FEEB8
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:24:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny75-0005OZ-10
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:15 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny73-00AzkU-8R
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:13 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E6BF622EB5C
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:24:12 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 2224E22EB3D;
        Wed,  4 Oct 2023 09:24:12 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 52519cc8;
        Wed, 4 Oct 2023 09:24:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Wed, 04 Oct 2023 11:23:27 +0200
Subject: [PATCH 08/27] can: at91_can: MSR Register: convert to FIELD_PREP()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-at91_can-rx_offload-v1-8-c32bf99097db@pengutronix.de>
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
In-Reply-To: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ZJk1Bd3+kEog0vHryLFsqyXkcRZW9vy9GYj/6CUyduU=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHS8dR89cnyyQaWHADyXDnMugtHjs8zQ6YfWfQ
 MQe2qSBHN6JATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR0vHQAKCRC+UBxKKooE
 6DT8B/9U3qk1xVff1+9ykubpyVck6SLbLJS1sjrWvxXJoFcZwetoJa/o8bvnk8V2NGe69UKtGk9
 awtDnKkRLpJrUNQanIolzFqWpIXQVM66WqxFHXrPcSuSLBp+2LxA4Lbaa+7HUmjufqZGFlabTtC
 G12SfskUFg2Ra8PCQc8qDzZDYEXLPULl4E2U4iCyRC0Adr1db+RNLA7N80vSwl0RevPcC4O/3Lb
 vw4Jnb5aTydrPqaJQ+1+JjcA1zxb5jNvja+EI2byTz5L38tEcrDg8FFegGHmznU89H9f4rXQx4I
 hEBJbEcMjnfeKO0SoU+9CE0r9KW84k31rYgogcStjqK4mqAn
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

Use FIELD_PREP() to access the individual fields of the MSR register.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index ec028fe833f0..41dd2ea239b9 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -83,6 +83,8 @@ enum at91_reg {
 #define AT91_MID_MIDVA_MASK GENMASK(28, 18)
 #define AT91_MID_MIDE BIT(29)
 
+#define AT91_MSR_MTIMESTAMP_MASK GENMASK(15, 0)
+#define AT91_MSR_MDLC_MASK GENMASK(19, 16)
 #define AT91_MSR_MRTR BIT(20)
 #define AT91_MSR_MABT BIT(22)
 #define AT91_MSR_MRDY BIT(23)
@@ -599,7 +601,7 @@ static void at91_read_mb(struct net_device *dev, unsigned int mb,
 		cf->can_id = FIELD_GET(AT91_MID_MIDVA_MASK, reg_mid);
 
 	reg_msr = at91_read(priv, AT91_MSR(mb));
-	cf->len = can_cc_dlc2len((reg_msr >> 16) & 0xf);
+	cf->len = can_cc_dlc2len(FIELD_GET(AT91_MSR_MDLC_MASK, reg_msr));
 
 	if (reg_msr & AT91_MSR_MRTR) {
 		cf->can_id |= CAN_RTR_FLAG;

-- 
2.40.1


