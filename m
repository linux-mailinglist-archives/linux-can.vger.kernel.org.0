Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4697BA506
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 18:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbjJEQNc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 12:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjJEQMW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 12:12:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C077ED0
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:50:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7e-0001Dx-W8
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:15 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7e-00BDKM-B7
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:14 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 14A6022F796
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:50:14 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7166D22F786;
        Thu,  5 Oct 2023 07:50:13 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c448529e;
        Thu, 5 Oct 2023 07:50:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:49:30 +0200
Subject: [PATCH v2 02/27] can: at91_can: use a consistent indention
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-at91_can-rx_offload-v2-2-9987d53600e0@pengutronix.de>
References: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
In-Reply-To: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5336; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=7YoDjDi6sVfFBQ6b3SoU9HUtwH/Gqam9Y8OqODWvDxQ=;
 b=owGbwMvMwMW4L0DGS6uL5QXjabUkhlS5rN5vpyWi+y496H36zGZWaE7o6TnLTv3qrNNhPSqWo
 bFztqJIJ6MxCwMjF4OsmCIL39nGvSs+mayM/2oUADOIlQlkCgMXpwBM5I4VB0O/4/Kjb1Si/JND
 VSy2L5l+QuexafKWCQWXi7bNPZdgczw/iXE1s9+Rytbq/LfvXf2j0tQMjzCpsjgybc4OEbjya7V
 A3NdPJzuvuO7nW7feU0tl/o+j/757zIvwElNrP/bAT//9PfGaat65stkWkz60GM9K03hiHH3yHm
 9o8Vn25O/Whf7PYtjnNUtecEnqPa8g/vlzSOnFyeIBkmLdOhIcsw+enFp3bsMPGzHLrMOsN5w7d
 ++dayCUtqDNy1DIu1Pdon3bGfGGvIilD95tiVn30LZacq9b3IXnJZdEJRO/lum80ppjMC8u4Vx3
 z4dajyVeTNMMP+/guK8dlNb37KSSoKRmjthDjpKZPAm/AQ==
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

Convert the driver to use a consistent indention of one space after
defines and in enums. That makes it easier to add new defines, which
will be done in the coming patches.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 124 ++++++++++++++++++++++-----------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 4621266851ed..367ccf109652 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -25,89 +25,89 @@
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
 
-#define AT91_MB_MASK(i)		((1 << (i)) - 1)
+#define AT91_MB_MASK(i) ((1 << (i)) - 1)
 
 /* Common registers */
 enum at91_reg {
-	AT91_MR		= 0x000,
-	AT91_IER	= 0x004,
-	AT91_IDR	= 0x008,
-	AT91_IMR	= 0x00C,
-	AT91_SR		= 0x010,
-	AT91_BR		= 0x014,
-	AT91_TIM	= 0x018,
-	AT91_TIMESTP	= 0x01C,
-	AT91_ECR	= 0x020,
-	AT91_TCR	= 0x024,
-	AT91_ACR	= 0x028,
+	AT91_MR = 0x000,
+	AT91_IER = 0x004,
+	AT91_IDR = 0x008,
+	AT91_IMR = 0x00C,
+	AT91_SR = 0x010,
+	AT91_BR = 0x014,
+	AT91_TIM = 0x018,
+	AT91_TIMESTP = 0x01C,
+	AT91_ECR = 0x020,
+	AT91_TCR = 0x024,
+	AT91_ACR = 0x028,
 };
 
 /* Mailbox registers (0 <= i <= 15) */
-#define AT91_MMR(i)		((enum at91_reg)(0x200 + ((i) * 0x20)))
-#define AT91_MAM(i)		((enum at91_reg)(0x204 + ((i) * 0x20)))
-#define AT91_MID(i)		((enum at91_reg)(0x208 + ((i) * 0x20)))
-#define AT91_MFID(i)		((enum at91_reg)(0x20C + ((i) * 0x20)))
-#define AT91_MSR(i)		((enum at91_reg)(0x210 + ((i) * 0x20)))
-#define AT91_MDL(i)		((enum at91_reg)(0x214 + ((i) * 0x20)))
-#define AT91_MDH(i)		((enum at91_reg)(0x218 + ((i) * 0x20)))
-#define AT91_MCR(i)		((enum at91_reg)(0x21C + ((i) * 0x20)))
+#define AT91_MMR(i) ((enum at91_reg)(0x200 + ((i) * 0x20)))
+#define AT91_MAM(i) ((enum at91_reg)(0x204 + ((i) * 0x20)))
+#define AT91_MID(i) ((enum at91_reg)(0x208 + ((i) * 0x20)))
+#define AT91_MFID(i) ((enum at91_reg)(0x20C + ((i) * 0x20)))
+#define AT91_MSR(i) ((enum at91_reg)(0x210 + ((i) * 0x20)))
+#define AT91_MDL(i) ((enum at91_reg)(0x214 + ((i) * 0x20)))
+#define AT91_MDH(i) ((enum at91_reg)(0x218 + ((i) * 0x20)))
+#define AT91_MCR(i) ((enum at91_reg)(0x21C + ((i) * 0x20)))
 
 /* Register bits */
-#define AT91_MR_CANEN		BIT(0)
-#define AT91_MR_LPM		BIT(1)
-#define AT91_MR_ABM		BIT(2)
-#define AT91_MR_OVL		BIT(3)
-#define AT91_MR_TEOF		BIT(4)
-#define AT91_MR_TTM		BIT(5)
-#define AT91_MR_TIMFRZ		BIT(6)
-#define AT91_MR_DRPT		BIT(7)
+#define AT91_MR_CANEN BIT(0)
+#define AT91_MR_LPM BIT(1)
+#define AT91_MR_ABM BIT(2)
+#define AT91_MR_OVL BIT(3)
+#define AT91_MR_TEOF BIT(4)
+#define AT91_MR_TTM BIT(5)
+#define AT91_MR_TIMFRZ BIT(6)
+#define AT91_MR_DRPT BIT(7)
 
-#define AT91_SR_RBSY		BIT(29)
+#define AT91_SR_RBSY BIT(29)
 
-#define AT91_MMR_PRIO_SHIFT	(16)
+#define AT91_MMR_PRIO_SHIFT (16)
 
-#define AT91_MID_MIDE		BIT(29)
+#define AT91_MID_MIDE BIT(29)
 
-#define AT91_MSR_MRTR		BIT(20)
-#define AT91_MSR_MABT		BIT(22)
-#define AT91_MSR_MRDY		BIT(23)
-#define AT91_MSR_MMI		BIT(24)
+#define AT91_MSR_MRTR BIT(20)
+#define AT91_MSR_MABT BIT(22)
+#define AT91_MSR_MRDY BIT(23)
+#define AT91_MSR_MMI BIT(24)
 
-#define AT91_MCR_MRTR		BIT(20)
-#define AT91_MCR_MTCR		BIT(23)
+#define AT91_MCR_MRTR BIT(20)
+#define AT91_MCR_MTCR BIT(23)
 
 /* Mailbox Modes */
 enum at91_mb_mode {
-	AT91_MB_MODE_DISABLED	= 0,
-	AT91_MB_MODE_RX		= 1,
-	AT91_MB_MODE_RX_OVRWR	= 2,
-	AT91_MB_MODE_TX		= 3,
-	AT91_MB_MODE_CONSUMER	= 4,
-	AT91_MB_MODE_PRODUCER	= 5,
+	AT91_MB_MODE_DISABLED = 0,
+	AT91_MB_MODE_RX = 1,
+	AT91_MB_MODE_RX_OVRWR = 2,
+	AT91_MB_MODE_TX = 3,
+	AT91_MB_MODE_CONSUMER = 4,
+	AT91_MB_MODE_PRODUCER = 5,
 };
 
 /* Interrupt mask bits */
-#define AT91_IRQ_ERRA		BIT(16)
-#define AT91_IRQ_WARN		BIT(17)
-#define AT91_IRQ_ERRP		BIT(18)
-#define AT91_IRQ_BOFF		BIT(19)
-#define AT91_IRQ_SLEEP		BIT(20)
-#define AT91_IRQ_WAKEUP		BIT(21)
-#define AT91_IRQ_TOVF		BIT(22)
-#define AT91_IRQ_TSTP		BIT(23)
-#define AT91_IRQ_CERR		BIT(24)
-#define AT91_IRQ_SERR		BIT(25)
-#define AT91_IRQ_AERR		BIT(26)
-#define AT91_IRQ_FERR		BIT(27)
-#define AT91_IRQ_BERR		BIT(28)
+#define AT91_IRQ_ERRA BIT(16)
+#define AT91_IRQ_WARN BIT(17)
+#define AT91_IRQ_ERRP BIT(18)
+#define AT91_IRQ_BOFF BIT(19)
+#define AT91_IRQ_SLEEP BIT(20)
+#define AT91_IRQ_WAKEUP BIT(21)
+#define AT91_IRQ_TOVF BIT(22)
+#define AT91_IRQ_TSTP BIT(23)
+#define AT91_IRQ_CERR BIT(24)
+#define AT91_IRQ_SERR BIT(25)
+#define AT91_IRQ_AERR BIT(26)
+#define AT91_IRQ_FERR BIT(27)
+#define AT91_IRQ_BERR BIT(28)
 
-#define AT91_IRQ_ERR_ALL	(0x1fff0000)
-#define AT91_IRQ_ERR_FRAME	(AT91_IRQ_CERR | AT91_IRQ_SERR | \
-				 AT91_IRQ_AERR | AT91_IRQ_FERR | AT91_IRQ_BERR)
-#define AT91_IRQ_ERR_LINE	(AT91_IRQ_ERRA | AT91_IRQ_WARN | \
-				 AT91_IRQ_ERRP | AT91_IRQ_BOFF)
+#define AT91_IRQ_ERR_ALL (0x1fff0000)
+#define AT91_IRQ_ERR_FRAME (AT91_IRQ_CERR | AT91_IRQ_SERR | \
+			    AT91_IRQ_AERR | AT91_IRQ_FERR | AT91_IRQ_BERR)
+#define AT91_IRQ_ERR_LINE (AT91_IRQ_ERRA | AT91_IRQ_WARN | \
+			   AT91_IRQ_ERRP | AT91_IRQ_BOFF)
 
-#define AT91_IRQ_ALL		(0x1fffffff)
+#define AT91_IRQ_ALL (0x1fffffff)
 
 enum at91_devtype {
 	AT91_DEVTYPE_SAM9263,

-- 
2.40.1


