Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466024D4B99
	for <lists+linux-can@lfdr.de>; Thu, 10 Mar 2022 16:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244064AbiCJOcn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Mar 2022 09:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343996AbiCJObf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Mar 2022 09:31:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44485EB14F
        for <linux-can@vger.kernel.org>; Thu, 10 Mar 2022 06:29:20 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nSJn4-00067y-Hs
        for linux-can@vger.kernel.org; Thu, 10 Mar 2022 15:29:18 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 4FE7A47DDA
        for <linux-can@vger.kernel.org>; Thu, 10 Mar 2022 14:29:11 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D1EAE47DC7;
        Thu, 10 Mar 2022 14:29:10 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4e4ca53f;
        Thu, 10 Mar 2022 14:29:05 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 16/29] can: gs_usb: add HW timestamp mode bit
Date:   Thu, 10 Mar 2022 15:28:50 +0100
Message-Id: <20220310142903.341658-17-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310142903.341658-1-mkl@pengutronix.de>
References: <20220310142903.341658-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Newer versions of the widely used open source firmware candleLight
support hardware timestamps. The support is activated by setting the
GS_CAN_MODE_HW_TIMESTAMP in the GS_USB_BREQ_MODE request.

Although timestamp support is not yet supported by this driver, add
the missing bit for documentation purpose.

Link: https://lore.kernel.org/all/20220309124132.291861-9-mkl@pengutronix.de
Link: https://github.com/candle-usb/candleLight_fw/commit/44431f4a4354a878fbd15b273bf04fce1dcdff7e
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index fa370549bd9e..62076c5e8e4e 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -92,6 +92,7 @@ struct gs_device_config {
 #define GS_CAN_MODE_LOOP_BACK BIT(1)
 #define GS_CAN_MODE_TRIPLE_SAMPLE BIT(2)
 #define GS_CAN_MODE_ONE_SHOT BIT(3)
+#define GS_CAN_MODE_HW_TIMESTAMP BIT(4)
 
 struct gs_device_mode {
 	__le32 mode;
-- 
2.35.1


