Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2988653329
	for <lists+linux-can@lfdr.de>; Wed, 21 Dec 2022 16:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiLUPZ4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Dec 2022 10:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbiLUPZs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Dec 2022 10:25:48 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A028A38AA
        for <linux-can@vger.kernel.org>; Wed, 21 Dec 2022 07:25:46 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id a1so7451849edf.5
        for <linux-can@vger.kernel.org>; Wed, 21 Dec 2022 07:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pvhSkDS7sLr/yCRVBMsqsSsDc7feD385RgSjpw/bFA=;
        b=bkhs3owSb5fFeZ5stolKBxsxgzclcE1S6E6LBQZCMMFan2MMBBTMhTgMJUAPZD/lHs
         8zqKLzUb8t/KkUwk6kcY7mvlHggwNujTO8JAW/Sj5JPBPpXM2NejknROiCRGlZ1psfkn
         chNdR1RBvED/ZEUXNPHj1exrPPZ65rAmKx7ZiJnGG45IxFGHGDw3pPPLixHA5r2Q6YwE
         fo9hcMBeVEYGtOYkwOTHk7VVPeHO5//KrN+zTGAGkHlLm27VLrFK0Ky40PM9F+Oy9krI
         tySiUeRj+TiJUjxzIMyCBWQaOnUzBY3U1F1n5N0j4fu5+I9Lwh8yjbtByzj/lIaIJL4O
         Ugug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pvhSkDS7sLr/yCRVBMsqsSsDc7feD385RgSjpw/bFA=;
        b=VwuTdR0d1y1VrU5aqF2mIt0t3bdzD9efJwpQ9ZqXpUo0mMgMfEo9VBbqUsYweV59gf
         ftrvbK49zV3cjVRve6hb0WTIRzFEZG+Zc862CGEehMG7hjKKyzpB5UQiEEBKQVLnt4WV
         pq9E8WIWEr3LwStR+ByK+1YIUg2hAo9ALqyooe0EPs7RCZIxzBOovZpkJdlNmEG9KlCe
         zUOsrBq7+hbBd1ry7ratp2n7YLnzzKSXVr4CazVIk/j7uEU38soQwYcNTI1OeyWBCGKF
         MhZmjVRJvlacchFrfpYwaRBw6Ec7no9xzWHLGjokuA/DK0+92sMByDRLPhq20eXvRUzH
         i4kw==
X-Gm-Message-State: AFqh2krVpwH3j8GPTu+Lsu+1WD8kJPKlR5szNVbQDbYacLJ8bC6kmq1H
        Ow5zLi0eEFRtIsnQp5DQfwrCSw==
X-Google-Smtp-Source: AMrXdXvSCD11RIqk7ZVmORgmKZv80u9uhoq8DSE5lMteZzY4IpDmwnoF1hXmhkCaM4eI1G4KirHGsA==
X-Received: by 2002:a05:6402:f05:b0:46f:9a53:fdcc with SMTP id i5-20020a0564020f0500b0046f9a53fdccmr2470351eda.12.1671636346275;
        Wed, 21 Dec 2022 07:25:46 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a245:805c:8713:84e4:2a9e:cbe8])
        by smtp.gmail.com with ESMTPSA id n19-20020aa7c793000000b0045cf4f72b04sm7105428eds.94.2022.12.21.07.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 07:25:45 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 06/18] can: m_can: Disable unused interrupts
Date:   Wed, 21 Dec 2022 16:25:25 +0100
Message-Id: <20221221152537.751564-7-msp@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221221152537.751564-1-msp@baylibre.com>
References: <20221221152537.751564-1-msp@baylibre.com>
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
index a76465016e17..9749a3248517 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1252,6 +1252,12 @@ static void m_can_chip_config(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	u32 cccr, test;
+	u32 interrupts = IR_ALL_INT;
+
+	/* Disable unused interrupts */
+	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TEFW | IR_TFE |
+			IR_TCF | IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N |
+			IR_RF0F | IR_RF0W);
 
 	m_can_config_endisable(cdev, true);
 
@@ -1347,15 +1353,13 @@ static void m_can_chip_config(struct net_device *dev)
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
2.38.1

