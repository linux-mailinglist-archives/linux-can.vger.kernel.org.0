Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079DE6BAE82
	for <lists+linux-can@lfdr.de>; Wed, 15 Mar 2023 12:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjCOLGo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 15 Mar 2023 07:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjCOLGi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 15 Mar 2023 07:06:38 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A8785348
        for <linux-can@vger.kernel.org>; Wed, 15 Mar 2023 04:06:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l12so8640041wrm.10
        for <linux-can@vger.kernel.org>; Wed, 15 Mar 2023 04:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678878388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jd8Qw6tYWP8+UhEwcLFiF9jauK6KGSZvnf2iBpWLLhI=;
        b=bFwVnfvJ+2RaVkxVOt+DW/N4wkI25kazo0eEW1ub/25j6bkDQFg0tFKk/f/Cw5vQ9h
         J/RNV6QKkAGFZ/y+Kiq8T1oDguqEisdAQLpOVWUatyJvoflbkv3Jve2MT2Cif2HQS4ER
         w5IpcvwsU48czgn46o1G9RNRl7O4tmmd2GsTlnmTnf8Bu93NKR39eogx8Et2RhqF/VJH
         7mQ8o/MnN2q24L00qA7jOMPPkPp0Nw9AXOyLln6mJUHyPBNrBqXDDpmCRpaYDqXPpLeg
         ifdnIcOJNxo+zXJn0JMuAy8QqkthgHP/hJl67rKIDNZFJTyuKYXfAnaARRdQQgBph4pd
         DAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678878388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jd8Qw6tYWP8+UhEwcLFiF9jauK6KGSZvnf2iBpWLLhI=;
        b=lL1MitGV5hdEUZ6Mnrvwfgbwu26/reC1dcQ5gRT0z9KdjUgKV4wwLnbpu0+iAMvV1c
         zzXk/2wry2zh1yWsFltxtM/wZY9vIxcCfm1AxDDBuJ8Of8G9r0Gl5xbINQ2ypwYhRmnA
         RnqSF7UXtPA5hvwSk4u5K9PVv/ADLasfQK4htQjECu0fwJUpewMiDHQIdQzhMIQwXmHj
         +PpsjI+Lx5G/dOkh/32lv7Rlas4PC0BxST3TAMmSmuYwwZVH8KB+8j6WRiWX7vI9e8tj
         iAA5qQQAysQ+ldJXyXyZgFYWJiZwIP9NZrgPwkzZDiNChcDTDs7tFTOYfByJl7YIJFaf
         ulPQ==
X-Gm-Message-State: AO0yUKXK+8d3/M+uZPc8B/MC/YMrF6gyFstXg5v1qSbJEwdwcP4HeIRJ
        fsNRb6EEDSaibGabAa6kayWCow==
X-Google-Smtp-Source: AK7set8Tw0/6hzErjilBTXFidTj6TUuIUL/ryySmlcsrQUaKbJHUC4KlqdZttqv7sZkJyGEMpvIsDA==
X-Received: by 2002:adf:f183:0:b0:2cf:f30f:cc04 with SMTP id h3-20020adff183000000b002cff30fcc04mr1545606wro.27.1678878388478;
        Wed, 15 Mar 2023 04:06:28 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a247:8056:be7d:83e:a6a5:4659])
        by smtp.gmail.com with ESMTPSA id l4-20020a7bc444000000b003eafc47eb09sm1460563wmi.43.2023.03.15.04.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:06:28 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v3 04/16] can: m_can: Disable unused interrupts
Date:   Wed, 15 Mar 2023 12:05:34 +0100
Message-Id: <20230315110546.2518305-5-msp@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315110546.2518305-1-msp@baylibre.com>
References: <20230315110546.2518305-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

There are a number of interrupts that are not used by the driver at the
moment. Disable all of these.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 5274d9642566..e7aceeba3759 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1261,6 +1261,7 @@ static int m_can_set_bittiming(struct net_device *dev)
 static int m_can_chip_config(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
+	u32 interrupts = IR_ALL_INT;
 	u32 cccr, test;
 	int err;
 
@@ -1270,6 +1271,11 @@ static int m_can_chip_config(struct net_device *dev)
 		return err;
 	}
 
+	/* Disable unused interrupts */
+	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TEFW | IR_TFE |
+			IR_TCF | IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N |
+			IR_RF0F | IR_RF0W);
+
 	m_can_config_endisable(cdev, true);
 
 	/* RX Buffer/FIFO Element Size 64 bytes data field */
@@ -1364,15 +1370,13 @@ static int m_can_chip_config(struct net_device *dev)
 	m_can_write(cdev, M_CAN_TEST, test);
 
 	/* Enable interrupts */
-	if (!(cdev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
+	if (!(cdev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)) {
 		if (cdev->version == 30)
-			m_can_write(cdev, M_CAN_IE, IR_ALL_INT &
-				    ~(IR_ERR_LEC_30X));
+			interrupts &= ~(IR_ERR_LEC_30X);
 		else
-			m_can_write(cdev, M_CAN_IE, IR_ALL_INT &
-				    ~(IR_ERR_LEC_31X));
-	else
-		m_can_write(cdev, M_CAN_IE, IR_ALL_INT);
+			interrupts &= ~(IR_ERR_LEC_31X);
+	}
+	m_can_write(cdev, M_CAN_IE, interrupts);
 
 	/* route all interrupts to INT0 */
 	m_can_write(cdev, M_CAN_ILS, ILS_ALL_INT0);
-- 
2.39.2

