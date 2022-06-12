Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26BF547C85
	for <lists+linux-can@lfdr.de>; Sun, 12 Jun 2022 23:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbiFLVjt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 12 Jun 2022 17:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbiFLVjo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 12 Jun 2022 17:39:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D4B19283
        for <linux-can@vger.kernel.org>; Sun, 12 Jun 2022 14:39:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id v1so7635639ejg.13
        for <linux-can@vger.kernel.org>; Sun, 12 Jun 2022 14:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bs1pDxoqSwxHo6PhPuLte63s3qeUlbVxYb0CgUg+DU4=;
        b=OUYQfEQrOtz7F0Nm9V9fFHrIGYhY1uY24QXJxNItXxe5w8q6wW3ICsnjqbyHOW6DXr
         Jqmh+nt5FgmxYnt1u8l0tEFZFV8ZMiHIvBmm4bMYdii8Dq+3ltEx8X0CPs5qXkldwvXn
         j9jVXNuJcacNFK3uxOO+hAwfSkNBevUEwcNqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bs1pDxoqSwxHo6PhPuLte63s3qeUlbVxYb0CgUg+DU4=;
        b=pnUdb7/gX/sLtN58VDAL5BLS+kp8BUXTMiHhx0wiUJ6l9Nt3oLoRNkkm7CIBdlhGvd
         Dj9FUne9L9OpRQz+FxsEoEyR9XEbrR8jOGdEw4r43L7CVNSjBntCRn4BXFPZRNOiCpq3
         Td1004NEN3yoRBaYppo4votr8VtlHeVRDyDgrr9J9jxMkkrFn9TzdOMJJlDIIlxj8fyL
         8JppEu2gmm/AYjQCTVGhDdrBPuII0zW9l+VIxxt659hrcvrk+2igVoDTdjC+LEqAuDTV
         HPJfRSgLAkJQFKXNPUJa+3C/qTca29C2Aha4wWzTxPKfbdKSB3xLfUHnAdIr8tZMyFJv
         sO2A==
X-Gm-Message-State: AOAM533Hg+1Nk4CbGZdbCS1peUbissTG56fbsOlumVpTtSpQvDuPB7aj
        hY0Ja8IjbPQgUJHJLY4H7ehofg==
X-Google-Smtp-Source: ABdhPJxPU1NM0rh3G4bzrTJkWzWLp5YsG4UPwDoQRnwVyaL8yBwctHZy5nQSG3CaRRYu/WmNAouG0A==
X-Received: by 2002:a17:907:1b1e:b0:6d7:31b0:e821 with SMTP id mp30-20020a1709071b1e00b006d731b0e821mr49755379ejc.334.1655069982282;
        Sun, 12 Jun 2022 14:39:42 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id u10-20020a1709061daa00b00711d546f8a8sm2909398ejh.139.2022.06.12.14.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 14:39:41 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v3 01/13] can: slcan: use the BIT() helper
Date:   Sun, 12 Jun 2022 23:39:15 +0200
Message-Id: <20220612213927.3004444-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220612213927.3004444-1-dario.binacchi@amarulasolutions.com>
References: <20220612213927.3004444-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Use the BIT() helper instead of an explicit shift.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/net/can/slcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 64a3aee8a7da..b37d35c2a23a 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -413,7 +413,7 @@ static int slc_open(struct net_device *dev)
 	if (sl->tty == NULL)
 		return -ENODEV;
 
-	sl->flags &= (1 << SLF_INUSE);
+	sl->flags &= BIT(SLF_INUSE);
 	netif_start_queue(dev);
 	return 0;
 }
-- 
2.32.0

