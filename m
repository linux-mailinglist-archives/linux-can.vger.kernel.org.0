Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68AB46D6D5
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 16:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbhLHPZc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 10:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbhLHPZc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 10:25:32 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4024CC061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 07:22:00 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id a37so3296491ljq.13
        for <linux-can@vger.kernel.org>; Wed, 08 Dec 2021 07:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OZfy9zXZDnUWJQVon3FtKWGw+IASY1yh4Q4ffKUTsjQ=;
        b=T5w7vJzHD1nRL40xvOtwKUcvPvZkDXzhLr5Y2SfduzW4gz0dM2yU5FB7Lx1LYBwNmN
         tW9AyZuFVvhAE4pbGMnjx1CXjj8xo2tJAglvDNZq8PfpM99xL+sqj6Wg9tJ/5MuVVXBZ
         +bEkaCWHMHvEP4U+S2SZF5O77WzsGcSJvO66K8tnFLIFsdDK91bCS5Aut+vM0JP+xcGR
         yN4OFiSxDKDSaXodMkyLek4Nps/mlbNmCcwrB6kEIBGJ8prTD7rrbC0e9zmwqZX1gaeP
         QW/1tJZNbry13BflSIw7dT83S6HvEaKVx2REArXJezwsuAKSigko2D2hJQStr3xh/FvM
         w93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OZfy9zXZDnUWJQVon3FtKWGw+IASY1yh4Q4ffKUTsjQ=;
        b=MgN1ean4dAOdigoG9NSjTNw1cmpVJXVqTm2gN99WvBfBzbkiAsP2XW+zuRCq/FuctV
         A4ByoxnpZgww6F4C2Fso3aONg+63IRRQ7wzhyjHVUTzRkgJf9MOXD5TlyMBOBg7Hpyoh
         wYiuO/yDkyfathCXe+4QO0CauWFdISRbM7i36BlrjT2knBnEowGwP8bmQl7tK0CGs9ZX
         PrnMTeNmPes+kk6qkfR4b7BxWTig2NmcJHdiDq7fuMhS8eLywEKIhyIswPAglD0Whan5
         1uEOSkVEtR+YHjoCnUstXWRCmQjHETFFEHZ+x8M/r6DYyZPJ0HGslpDNsnZHbyoXyhue
         OO6A==
X-Gm-Message-State: AOAM533FYYOjLHD64Zus19ahHTXvbjyx8MMD/FHkCxMRgOM0f72O13eT
        9muPfmRb15xLk0MGCsYCVN7T5efIjaNbRc98
X-Google-Smtp-Source: ABdhPJyiph7GTEK4rtQdP7Jyi50/K1hdl5BZalgLTn1JU4J2ZP9YHwcuKI+JqssJp68vTRazeYbHbw==
X-Received: by 2002:a2e:a4b6:: with SMTP id g22mr82927ljm.447.1638976918549;
        Wed, 08 Dec 2021 07:21:58 -0800 (PST)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id m20sm279263lfu.241.2021.12.08.07.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 07:21:57 -0800 (PST)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v5 1/2] can: kvaser_pciefd: kvaser_pciefd_rx_error_frame(): increase correct stats->{rx,tx}_errors counter
Date:   Wed,  8 Dec 2021 16:21:21 +0100
Message-Id: <20211208152122.250852-1-extja@kvaser.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Check the direction bit in the error frame packet (EPACK) to determine
which net_device_stats {rx,tx}_errors counter to increase.

Link: https://lore.kernel.org/all/20211208115607.202859-2-extja@kvaser.com
Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v5:
  - No changes.
 drivers/net/can/kvaser_pciefd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 74d9899fc904..eb74cdf26b88 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -248,6 +248,9 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_SPACK_EWLR BIT(23)
 #define KVASER_PCIEFD_SPACK_EPLR BIT(24)
 
+/* Kvaser KCAN_EPACK second word */
+#define KVASER_PCIEFD_EPACK_DIR_TX BIT(0)
+
 struct kvaser_pciefd;
 
 struct kvaser_pciefd_can {
@@ -1285,7 +1288,10 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 
 	can->err_rep_cnt++;
 	can->can.can_stats.bus_error++;
-	stats->rx_errors++;
+	if (p->header[1] & KVASER_PCIEFD_EPACK_DIR_TX)
+		stats->tx_errors++;
+	else
+		stats->rx_errors++;
 
 	can->bec.txerr = bec.txerr;
 	can->bec.rxerr = bec.rxerr;
-- 
2.34.1

