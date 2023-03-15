Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233886BAE7C
	for <lists+linux-can@lfdr.de>; Wed, 15 Mar 2023 12:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjCOLGk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 15 Mar 2023 07:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjCOLGg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 15 Mar 2023 07:06:36 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F6584F4C
        for <linux-can@vger.kernel.org>; Wed, 15 Mar 2023 04:06:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id bh21-20020a05600c3d1500b003ed1ff06fb0so903974wmb.3
        for <linux-can@vger.kernel.org>; Wed, 15 Mar 2023 04:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678878386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPa68xqtezsL6sMRTVQ0tfny5rcXKUsYatwd7qGowxE=;
        b=6WZgOzyygg0zRDnl3x/YHL5WQkORuaTJ3lR0M74jAepA1G3LCh5lIi/ACzhN23kh6t
         DB+ETgEBdCDGDFCnDfn3UJVs6avbYkgcoKaSccEQ81OtapN79fKP0F/WPpFDUiKQyG6P
         /c7z4V6opxq/IodaPmKHbrA60YSsQE60iMQsV53eOC6rlGVvK3B2WN1l3p0OfLA4eVzN
         Qy2mNmBD7eYw4lPY/dAFHwoGRdr9CKiguskEkiqoCIbi1FgJJ/1dp/DI2M3z81VxhVbN
         Gb7VqWDnGcd/ZDQ0JxaYqBEDLrWJkiOMyhGj+zpULJC8v1D/R3D8WIboM9nepXMVC8dg
         rrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678878386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPa68xqtezsL6sMRTVQ0tfny5rcXKUsYatwd7qGowxE=;
        b=Xct8UDdtSduIjKhBp5Udfi68cgusBI7Hzan0a/PaNTMsLxsOKUupysfnh2MLL7biww
         yGeZKs/7R1bWKRq1XamuwyhxGM3ZHm4UqW5FuKD54QcVVpFOEzvz3F5G5c7DcvuH1veB
         d5FHUpVj8qX9t0+Zt2j78srA6nb1KBEUPTwZizkgN47nDx0xbdDuts/s3utQxPrv3BLv
         rgJNSKTiWT5cEgKKOmiwCLymjwzMes0tfBriy6uOODAyOIyXNyITLK9DtYPdrICZuJ5Z
         KnI0KbG3MxoLhANZfXJ/TaZiqrjVJJLRFoBCWXBjxzqTHiPGJRUzYLa9mUsHkeq8j9Ze
         7eXg==
X-Gm-Message-State: AO0yUKUFNFOthNk8CnNGZ4OU/RTczw9DdANqrFOE4KFIJtLWyKdt5rsj
        OaFLcrH0k6+G8sScz+XaPqr1+Q==
X-Google-Smtp-Source: AK7set9JUe0wMzSCJXqHUAnQUw+QhcZC4zYsaYFMqvPaJrHOvwKZCKTlaUMmFjuxjePf2A3cWgzEog==
X-Received: by 2002:a05:600c:548b:b0:3e2:6ec:61ea with SMTP id iv11-20020a05600c548b00b003e206ec61eamr17703012wmb.28.1678878385936;
        Wed, 15 Mar 2023 04:06:25 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a247:8056:be7d:83e:a6a5:4659])
        by smtp.gmail.com with ESMTPSA id l4-20020a7bc444000000b003eafc47eb09sm1460563wmi.43.2023.03.15.04.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:06:25 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v3 01/16] can: m_can: Remove repeated check for is_peripheral
Date:   Wed, 15 Mar 2023 12:05:31 +0100
Message-Id: <20230315110546.2518305-2-msp@baylibre.com>
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

Merge both if-blocks to fix this.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 8e83d6963d85..563625a701fc 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1592,10 +1592,8 @@ static int m_can_close(struct net_device *dev)
 		cdev->tx_skb = NULL;
 		destroy_workqueue(cdev->tx_wq);
 		cdev->tx_wq = NULL;
-	}
-
-	if (cdev->is_peripheral)
 		can_rx_offload_disable(&cdev->offload);
+	}
 
 	close_candev(dev);
 
-- 
2.39.2

