Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C87F46D1B1
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 12:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhLHLNc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 06:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhLHLNb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 06:13:31 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E761CC061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 03:09:59 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id bi37so4895072lfb.5
        for <linux-can@vger.kernel.org>; Wed, 08 Dec 2021 03:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xsTkfM2z6kN99tXFEXnZlGVpIzPI1BmCQSDh3dg0VKw=;
        b=dZ+G0UZu86uJzfYPN16ffqn7qegT9AxXQNaZsqDpNV1GNrQR7l4G1Z5XFtULq3/oHw
         ETY1XARuP4ZSZaXf08tw0fkVFoAyhAiFU7OipfBnU/t+2o1AakKD1fH17BWu7ij1V32F
         f/k3QMPfP0APAIAO9YfXl47OshKtGcy8nnIEJiRSnGE4WeEGbL29mdOmZOD5cukGMpPf
         H2nNPbx7wJqZb9L53VLPuQbUXhxTmGPLLA+duRlxL2+L+QxL3nRI2bCvEK6YFFQ7BL5n
         MRM9ngVm75SysHWprKZckwHgIauyVCiqsdi4wPSuN1pgMsoK6eBfIVlAKk412B0Xci5D
         13hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xsTkfM2z6kN99tXFEXnZlGVpIzPI1BmCQSDh3dg0VKw=;
        b=VcuXmULucer7wc32PIYEzJk6L607rYV6wINvam53I2vjY0BeNE5YPTCPJl96LXeSpI
         Ykwu/80KA8rH6lPSbk4jiMFK/M0qPme6kjKbwhqCuP6djEOIE+Ds18pGX56rNFJ+gSRn
         mxanatNRdQSQLY8si/l5YlzlTO5hpPdw4zPvmRERcvmNZvNgR5fjuQ93JASiiM11d8QH
         cSA/9AsevI9pcojy98xXTKLQL03Ok24K5wEmupEZCpZMGZOn1R5Uj5WqNlEdMbtQNVBW
         ws7Cdic6JS11gmCw27K53VzalaLXVnPrdycXb0pmKZfuABI5Hn82VSy01GJSFa+EigYz
         VKrQ==
X-Gm-Message-State: AOAM531uClDQq/Vw1h8FNVItbMMbnRPlR880vHrgmruEsBQQyqPHM5ev
        k3O1mCSpJ87Cg9KP2mRjsKuLtOruEV/kSC5a
X-Google-Smtp-Source: ABdhPJyaoLDteG9FA1oY052CT0qzE3tCPBXiF5evSF8GVVpu3rmjNY8LcUv6/5sypXjqszLcvVE/pg==
X-Received: by 2002:ac2:447b:: with SMTP id y27mr18176776lfl.405.1638961798220;
        Wed, 08 Dec 2021 03:09:58 -0800 (PST)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id q6sm223786lfa.133.2021.12.08.03.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 03:09:57 -0800 (PST)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 1/3] can: kvaser_pciefd: Increase correct stats->{rx,tx}_errors counter
Date:   Wed,  8 Dec 2021 12:09:38 +0100
Message-Id: <20211208110940.185629-2-extja@kvaser.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208110940.185629-1-extja@kvaser.com>
References: <20211208110940.185629-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Check the direction bit in the error frame packet (EPACK) to determine
which net_device_stats {rx,tx}_errors counter to increase.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
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

