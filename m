Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509236442A8
	for <lists+linux-can@lfdr.de>; Tue,  6 Dec 2022 12:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbiLFL5r (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Dec 2022 06:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbiLFL5n (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Dec 2022 06:57:43 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6E85FEE
        for <linux-can@vger.kernel.org>; Tue,  6 Dec 2022 03:57:39 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z92so19981132ede.1
        for <linux-can@vger.kernel.org>; Tue, 06 Dec 2022 03:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/SM3kRtE0QNFZxUupuZ+9fh0CsrCFYSaqu7nZYqZws=;
        b=0+4ZNoct0t37OCBI0Y3zYjJ0HnauWB5gfqosr2YiHb/KDkgUB0W0OrWp6Td60o/qh2
         mj23yCSgRd5vUr7yuTKBqXK1rKj0Dhlne1ZTLoggSHVQcVUnynig5NLWmEpmVyZtjCR9
         irNVKd5e/1zjgrEagyZdtsouWAoDH1YU6TEqfWDYe8sKqoV5xy6a8vH3wt1gX/C2iF05
         D9RYNZvOzX9Iu3F07nBTc6L5AZpNP9kV7QGs67cWBAQAzMJTfsXEK36ablfRhBOVi8rt
         LtImRuyGjgccVT2bgzzGb5sl8iVYYFbWE+C+3BKu1JbqA6qOh3YMau4R9iC5+p7Ap9Uw
         8DQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/SM3kRtE0QNFZxUupuZ+9fh0CsrCFYSaqu7nZYqZws=;
        b=GFjvQbtVnp9Cmluh+jpGXWffPhOhqc5hrBSsnO75NIg3/OJ08siIUG9vsQNh+OGvXR
         zpgHBLW2vxpwoa2zHsxDuLZaIO4r5+1Wxsrd7IbWc40p8tfrMfvccwJio+tQXf3w/+Er
         rZkpIEBrtfpt63KqbF0PiUqPnPKKVf3HhCI3iUx/m4eD4AVZ5uqYQTQC82gQXoTG5QGK
         o7/q/889jTtU8kCrNfHym6sPUatxzAcZl/kSshkED/VBdtemLPGtTh3aUI0aIdREHHAl
         sDMzNTOGRAHyau6WSElOchOZIumwSs4P7qKotCEdgiVAAOhhViP5phD/tWvrrw6KXgiA
         l+UA==
X-Gm-Message-State: ANoB5plQ+pGtDGAPvrNkX6XC01AZH8YjxH2PLsr74O3emYqYYvVc7Gdd
        Jdnmr4bAhqa9Kw10RL8bx8yoGA==
X-Google-Smtp-Source: AA0mqf7dfp5M+1XwnbbDWRD6RfH8MEGTMzGyhpgQVfsezjb8oi7qrVaCy9qNcQuAtPlBn6W5MrBokw==
X-Received: by 2002:a05:6402:2b91:b0:457:23cb:20ab with SMTP id fj17-20020a0564022b9100b0045723cb20abmr12075583edb.254.1670327858359;
        Tue, 06 Dec 2022 03:57:38 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a245:805c:8713:84e4:2a9e:cbe8])
        by smtp.gmail.com with ESMTPSA id ky20-20020a170907779400b007c0ac4e6b6esm6472076ejc.143.2022.12.06.03.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 03:57:38 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 03/11] can: m_can: Read register PSR only on error
Date:   Tue,  6 Dec 2022 12:57:20 +0100
Message-Id: <20221206115728.1056014-4-msp@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206115728.1056014-1-msp@baylibre.com>
References: <20221206115728.1056014-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Only read register PSR if there is an error indicated in irqstatus.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index d30afbb3503b..45c718413abf 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -900,7 +900,6 @@ static int m_can_rx_handler(struct net_device *dev, int quota, u32 irqstatus)
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	int rx_work_or_err;
 	int work_done = 0;
-	u32 psr;
 
 	if (!irqstatus)
 		goto end;
@@ -926,13 +925,13 @@ static int m_can_rx_handler(struct net_device *dev, int quota, u32 irqstatus)
 		}
 	}
 
-	psr = m_can_read(cdev, M_CAN_PSR);
-
 	if (irqstatus & IR_ERR_STATE)
-		work_done += m_can_handle_state_errors(dev, psr);
+		work_done += m_can_handle_state_errors(dev,
+						       m_can_read(cdev, M_CAN_PSR));
 
 	if (irqstatus & IR_ERR_BUS_30X)
-		work_done += m_can_handle_bus_errors(dev, irqstatus, psr);
+		work_done += m_can_handle_bus_errors(dev, irqstatus,
+						     m_can_read(cdev, M_CAN_PSR));
 
 	if (irqstatus & IR_RF0N) {
 		rx_work_or_err = m_can_do_rx_poll(dev, (quota - work_done));
-- 
2.38.1

