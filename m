Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB8C46D2D4
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 12:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhLHL76 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 06:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhLHL75 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 06:59:57 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FB3C061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 03:56:25 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id b40so5086980lfv.10
        for <linux-can@vger.kernel.org>; Wed, 08 Dec 2021 03:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ERFTF3cgEW0FixPNNTp542OiRNHtcM/gwCyEK0K71vQ=;
        b=Z7r4UO/Isu3BkfHXG7eInkR5a7fncwG9D3spi7uUQMnkvBdEjA4mpC/048P6CREOrn
         ShZP9Kl4OmCOXDmjAjQqREfRsDptvyDjEIEMktO2VN69+Nc+DB6Vs5MCTpvdvJJPbWcu
         G+eOj8I+gy/r/xKPpdrns7zkWuN+ISgXHm+qeisgHPnQTxiakO6fSTLvCyFvxA8TKS/m
         mmAhx/NoX4sRW3r30RcRxSVpNZ2ah2g8AVKnNg/Iq6E/Ln6JMajE8SSF5TbCuOFTdVy1
         2n5Acclky6e8Fh/j1E0CyZDIwqefuW6UJQNLhw+zkKFPR/Vumn+ab2GJoRYORztuG31A
         hIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ERFTF3cgEW0FixPNNTp542OiRNHtcM/gwCyEK0K71vQ=;
        b=MGmfFkjfPguVrRYU/3PpOHdic4cUQccmJngQpiSeRvKbHaw3dBMcBv4LlyR8GTEM8e
         XobVmrr7flhzhGar6W7/BuazzFr2IYK4TKKV2Oc2wjXrnAonS4oID674PW/11eHGyvwm
         LhGH8s84XatJh9c8KHy4q0JbPLZWO+3Ctz2zr9ZE8K373DXlq1KWNz7XCWuZRmJlY855
         a6Os73j2To1UB9SrUdErG2V8AQhwg8WAT8gq10aEf2F5rcLN0+td1z5iV4WL44AEWIDT
         UUyeBZLEe236k5NxtRbv6ZqFlyVvru7WoMUgq1qzwEhnwbV01lU4/eL3bPZukmqzAvLn
         6J+Q==
X-Gm-Message-State: AOAM530zzGCh+WI90eWHMDsFRnPQ7oDAlT0qE728uBxKA0uaPMYAkJqt
        Y18iSixa0RLieGo7sM2FBAJgewzGaCg7DuID
X-Google-Smtp-Source: ABdhPJwsHYD6pyTOPzt35Ticozlzt+YbOUGFi16axJgK3PQ+lIsk+vKynFR1e51+KJ1ZEnrVAFZeHA==
X-Received: by 2002:ac2:491e:: with SMTP id n30mr48938133lfi.97.1638964583967;
        Wed, 08 Dec 2021 03:56:23 -0800 (PST)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id c25sm256977lja.38.2021.12.08.03.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 03:56:23 -0800 (PST)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 1/4] can: kvaser_pciefd: Increase correct stats->{rx,tx}_errors counter
Date:   Wed,  8 Dec 2021 12:56:04 +0100
Message-Id: <20211208115607.202859-2-extja@kvaser.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208115607.202859-1-extja@kvaser.com>
References: <20211208115607.202859-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Check the direction bit in the error frame packet (EPACK) to determine
which net_device_stats {rx,tx}_errors counter to increase.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v3:
  - No changes.

Changes in v2:
  - Rebased on [PATCH v5 0/5] fix statistics and payload issues for
    error [1] series.

[1]
https://lore.kernel.org/all/20211207121531.42941-1-mailhol.vincent@wanadoo.fr

 drivers/net/can/kvaser_pciefd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 6fd6bed04577..017f2d36ffc3 100644
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
@@ -1286,7 +1289,10 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 
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

