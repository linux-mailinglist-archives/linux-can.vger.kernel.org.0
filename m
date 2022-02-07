Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A106F4ABFEA
	for <lists+linux-can@lfdr.de>; Mon,  7 Feb 2022 14:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359471AbiBGNrq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Feb 2022 08:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385704AbiBGNL0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Feb 2022 08:11:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCB4C03FEED
        for <linux-can@vger.kernel.org>; Mon,  7 Feb 2022 05:10:57 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nH3nD-0003mY-DP
        for linux-can@vger.kernel.org; Mon, 07 Feb 2022 14:10:55 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id BCF432D7CE
        for <linux-can@vger.kernel.org>; Mon,  7 Feb 2022 13:10:49 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 96E312D7C1;
        Mon,  7 Feb 2022 13:10:49 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e66b1342;
        Mon, 7 Feb 2022 13:10:49 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 14/15] can: mcp251xfd: mcp251xfd_register(): prepare to activate PLL after softreset
Date:   Mon,  7 Feb 2022 14:10:46 +0100
Message-Id: <20220207131047.282110-15-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207131047.282110-1-mkl@pengutronix.de>
References: <20220207131047.282110-1-mkl@pengutronix.de>
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

If the PLL is needed ist must be switched on after chip reset. This
patch adds the required call to mcp251xfd_register().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 937424e5ac2b..1086c8974f89 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1792,6 +1792,12 @@ static int mcp251xfd_register(struct mcp251xfd_priv *priv)
 	if (err)
 		goto out_chip_sleep;
 
+	err = mcp251xfd_chip_clock_init(priv);
+	if (err == -ENODEV)
+		goto out_runtime_disable;
+	if (err)
+		goto out_chip_sleep;
+
 	err = mcp251xfd_register_chip_detect(priv);
 	if (err)
 		goto out_chip_sleep;
-- 
2.34.1


