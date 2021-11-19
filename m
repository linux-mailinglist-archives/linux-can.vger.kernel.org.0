Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A9E456F7C
	for <lists+linux-can@lfdr.de>; Fri, 19 Nov 2021 14:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhKSNXi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Nov 2021 08:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhKSNXi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Nov 2021 08:23:38 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C695EC061574
        for <linux-can@vger.kernel.org>; Fri, 19 Nov 2021 05:20:36 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b1so43038273lfs.13
        for <linux-can@vger.kernel.org>; Fri, 19 Nov 2021 05:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MSJO/pVuVy6vxB1wTGwPSNanqRwUkC4buDa6Gb59pC0=;
        b=Pnb/lwOlfhkseFjf+zEdndACROJQwMQdqEDLAs64WwP2etTs8+3FRbYqDK6jGui4LF
         KdxMrPp4zdjwJ7Ceke2Gcx1o1ZI64iLcy18RPTL/3X6UeJLJS249B7uS4/S2YIE6hsgF
         LD/7dJJdj9FAJK5Zfpif90qoFC53NWA4arDQa8nq9iW33Fs6uDpsM832ENhfsxGgex/9
         K6HIUjF+BLunSfiQ5dIcH5VWlQGtHKZ2GzFmC9UcApGkjiYvF5r5I9gbelRLbTknn3np
         5OH30Hp4pNFHG1QsaXbj78gMHNqlInbOfhwCZq8tfNABTq9vo3FmttfR5nsBEz+Tg/Fc
         4oiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MSJO/pVuVy6vxB1wTGwPSNanqRwUkC4buDa6Gb59pC0=;
        b=WMnH3Kc2nNi963y0d96fQ3Lb/Tv5KTIL3fPS28cPaX+S3T1pSEyyEajGWBGg1ER10s
         geA+wT5ZRwoux9tLlIJRn3a1KhyoKq+dkZ+7t5LagSqk4wvrbKsQhDZxCY+yplACk31O
         +/D4CLSm/w1FO64LmrEVbpGW92bXKrekk2+NMabzNkdEyHAjYLnpRGBBK20jvwN1nJm6
         0VZ2PJ7ruphCjeSBczx9aQnrXYX/axblZ3vTTj06KVTWYRHqLNwx5Las7e5MWJvDXEt/
         j4+IDrN/4VzNJtxwj5ApBHo2GJzbbLfGdbSNZe33v6hDufkD8m+ohPM4hQSvVyBfql8k
         v+Uw==
X-Gm-Message-State: AOAM533UnGOdoA6LyaL4QNJxoxSTDoYU5u5FOh9JPVcfOfewp7TDKT0C
        suW/XTgbaluTQ3gZoKy0a5MJkgSucGs5pXNY
X-Google-Smtp-Source: ABdhPJz5uqHvUEwCeelbjz4KD4hl33FKtxYYXX5qEY/PFpYAfBmmMYehkyl3d4acQJbFDeWZNk34rg==
X-Received: by 2002:a05:651c:514:: with SMTP id o20mr25903060ljp.393.1637328035053;
        Fri, 19 Nov 2021 05:20:35 -0800 (PST)
Received: from localhost (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with UTF8SMTPSA id g4sm358948lfv.288.2021.11.19.05.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 05:20:34 -0800 (PST)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v1 3/5] can: kvaser_usb: Do not increase stats->rx_{packets,bytes} for error frames
Date:   Fri, 19 Nov 2021 14:19:13 +0100
Message-Id: <20211119131915.2033234-4-extja@kvaser.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211119131915.2033234-1-extja@kvaser.com>
References: <20211119131915.2033234-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Do not increase net_device_stats rx_{packets,bytes} when receiving
error frames.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index dcee8dc828ec..aa81b92237ca 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -920,8 +920,6 @@ static void kvaser_usb_hydra_update_state(struct kvaser_usb_net_priv *priv,
 	cf->data[7] = bec->rxerr;
 
 	stats = &netdev->stats;
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 }
 
@@ -1074,8 +1072,6 @@ kvaser_usb_hydra_error_frame(struct kvaser_usb_net_priv *priv,
 	cf->data[6] = bec.txerr;
 	cf->data[7] = bec.rxerr;
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 
 	priv->bec.txerr = bec.txerr;
@@ -1109,8 +1105,6 @@ static void kvaser_usb_hydra_one_shot_fail(struct kvaser_usb_net_priv *priv,
 	}
 
 	stats->tx_errors++;
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 }
 
-- 
2.31.1

