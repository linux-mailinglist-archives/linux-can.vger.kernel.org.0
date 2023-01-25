Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B362F67BB07
	for <lists+linux-can@lfdr.de>; Wed, 25 Jan 2023 20:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbjAYTvO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Jan 2023 14:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbjAYTvK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2023 14:51:10 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FF945229
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 11:51:09 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vw16so50582236ejc.12
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 11:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EadAaSBIPgk+IhFGEGl7ST9vXs3rcnt68GgP+MjrSEY=;
        b=Rk5M+PVeGH11E491B1aoDw/oKxxuhtw/OFCxkwW809SrHbXB/tOzU5FRR2xZM+QV/w
         0MyCeN4A1JXtDVRtJdh2HDOtEiENmjiSxuSoWftPsy4X3sj4e7XRDNcTGdqpT5ePIvvL
         97GZaqLNIlboRnu7swQMKDnryGNscRfU92ehuz7/tVVNPqlAQc5dNKceeGhd0qiM1BPa
         FFs+UIo7mF4YMnC5Dhx6ELs688A5LNM31fjLxipr7CdvNc3zxMtYjUjgtxMfoYyhhPv7
         Nyz9yjQhPQHCcH5F3VL8sFBWBHW1hZSk6VgtzoSOhqI9SJwfO11reWw0nuOl4RrqmAWt
         /Ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EadAaSBIPgk+IhFGEGl7ST9vXs3rcnt68GgP+MjrSEY=;
        b=BrVE3xbxsvF8QK9L73JbEpClokwZTAK1t6pL31QaHrTelVbhkjjVlUwH4A70lkOknj
         aF3xi2+4NwMcNz9VJiI1dsZQAH/nalggvKhdmIJCBBnfxARLS0IH7+NP92AD/xXPu/2j
         s0m2IOZm/PYQla7PTo6oFcSwSV4hZ+wvFG5jLrEfKIie74pznmgafw178kCM/kpCM/bh
         ij/K0g97u8QL+rJ9GH9ZtNu3SAYig8HTzItE2HfsCU6nAinTymmfQ5TA751E7ZvtUI/k
         opVryvtfBhtbOXQbsumr/Leedd8cgtOe8EOHi2610kob/f0MvtZLr7uGQS4V2cb7mAfi
         Gw8Q==
X-Gm-Message-State: AFqh2kolM4u0rTImfvwT9E4VhsaFIDaqsjpR2RQeIxtZrJ17RHVFbxNr
        kpP0+q1HSaUa/VS6/RXoiX61Rw==
X-Google-Smtp-Source: AMrXdXuaOJXfKYX1K96a1sVEJrFIg+FTI+sLU8LDjXt1W3pCD8pSrvYU7PcTAR25xBblf9jXwYjaUg==
X-Received: by 2002:a17:906:ce23:b0:85a:4230:6743 with SMTP id sd3-20020a170906ce2300b0085a42306743mr33795342ejb.23.1674676268965;
        Wed, 25 Jan 2023 11:51:08 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a247:815f:ef74:e427:628a:752c])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906454f00b00872c0bccab2sm2778830ejq.35.2023.01.25.11.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 11:51:08 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 05/18] can: m_can: Remove double interrupt enable
Date:   Wed, 25 Jan 2023 20:50:46 +0100
Message-Id: <20230125195059.630377-6-msp@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125195059.630377-1-msp@baylibre.com>
References: <20230125195059.630377-1-msp@baylibre.com>
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

Interrupts are enabled a few lines further down as well. Remove this
second call to enable all interrupts.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2df39dfa309b..a668a5836cf8 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1364,7 +1364,6 @@ static int m_can_chip_config(struct net_device *dev)
 	m_can_write(cdev, M_CAN_TEST, test);
 
 	/* Enable interrupts */
-	m_can_write(cdev, M_CAN_IR, IR_ALL_INT);
 	if (!(cdev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
 		if (cdev->version == 30)
 			m_can_write(cdev, M_CAN_IE, IR_ALL_INT &
-- 
2.39.0

