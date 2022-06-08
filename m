Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B75C5439BC
	for <lists+linux-can@lfdr.de>; Wed,  8 Jun 2022 18:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiFHQy7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Jun 2022 12:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243511AbiFHQxS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Jun 2022 12:53:18 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CF03C6B3E
        for <linux-can@vger.kernel.org>; Wed,  8 Jun 2022 09:51:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id q1so42639238ejz.9
        for <linux-can@vger.kernel.org>; Wed, 08 Jun 2022 09:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bs1pDxoqSwxHo6PhPuLte63s3qeUlbVxYb0CgUg+DU4=;
        b=f/RB/AADgG9sZPdH/FFOUOjP3DRCdWgEZkMCyF3Wrbhsdq21HPvBLY80JKH5KLQWx+
         6+x2um026CENOu0ajA+XBYLhJLbisgS+YtX6v51vRcba0N7G26i7I9TbyL5yV4qN/TeT
         depNj9mKPpvaNLgnb9VQwzA2JB3OKiiEM8vU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bs1pDxoqSwxHo6PhPuLte63s3qeUlbVxYb0CgUg+DU4=;
        b=Mxq/utldF5INhDoNcnW1lYlEQ8YWbKnma4ZuAt+GLAWmnRRPxt1BqU+HNDDo1OGKlJ
         YrYoixNZp7U3o5LeSSYcqSToN0lI2Lu19FPmFDSpTFM8wLwJrmKMPBzWBFtJ8HnuWl+U
         Bc2BT0+U3riPUalazVpiqGQoexqaQbUS3Phy9NLNFmPi5JOjqlyJGIQoq8K2OVlaRuVr
         v3wHVZPtbfp536oJXZd5KGHkxFqc1LT1GqUqu9k7OHS8W7hJAFhHOKr6pJai5ZtSWBSv
         OS4IlQ9z4tac4h5NzXiXJ9P7/m14ZAQiEXlSTF56aht4paUNsN+5E0EBE0GC5yCm0aAQ
         q9xg==
X-Gm-Message-State: AOAM531bxcqb+fVVwS/cv8tA8OZTmcr6DiFKSr0YsorlD0grdTmTmz/q
        m5r3y8dI8/XP0tc//sM8oiJAwQ==
X-Google-Smtp-Source: ABdhPJxs+KHSiIY16R/4F/cW1agfC4LfsUa/2oSVYolckwJQXrxz201mbFu3QGgcEOO+6n5FaSJTKA==
X-Received: by 2002:a17:907:3d8a:b0:70e:6b1:b004 with SMTP id he10-20020a1709073d8a00b0070e06b1b004mr27556484ejc.61.1654707085258;
        Wed, 08 Jun 2022 09:51:25 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090654d600b0070587f81bcfsm9569071ejp.19.2022.06.08.09.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 09:51:24 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 01/13] can: slcan: use the BIT() helper
Date:   Wed,  8 Jun 2022 18:51:04 +0200
Message-Id: <20220608165116.1575390-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220608165116.1575390-1-dario.binacchi@amarulasolutions.com>
References: <20220608165116.1575390-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

