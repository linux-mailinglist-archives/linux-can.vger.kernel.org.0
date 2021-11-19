Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68564456F7B
	for <lists+linux-can@lfdr.de>; Fri, 19 Nov 2021 14:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhKSNXh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Nov 2021 08:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhKSNXh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Nov 2021 08:23:37 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6B8C061574
        for <linux-can@vger.kernel.org>; Fri, 19 Nov 2021 05:20:35 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id n12so43488669lfe.1
        for <linux-can@vger.kernel.org>; Fri, 19 Nov 2021 05:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7UNxfWJloEkKYMcxN9mT7rffNNA9Oni+HipJu8ICj04=;
        b=TqiO372+NBZhMhNqBEf9qTAQT2dYvq2sEX8n24eeBlgeFFJzwhJYjT8bBHS9NETzCV
         1jRqNZTrD0qKdAewubTCrMIm79l49W/m5xN1wAWKPtpeC2wu2NYQLTpwu6wvWdth207y
         JIKmOb73zfU3KJfyZo8CyBpRbYX0VfOLydWx6qBBLSzCvBHML9a+g6milJjSvDrKjVUn
         cY9g853zNTPUMT/ZN3kKGcVtgJr9C8D0DgoFG2DledwJHdA3WBO21LE0efCH0keAEBtY
         wiuFb9b+1E29VBh59nGbi/MDcYvuT75UhB8pCK0q5wEWPTliehLUdl48V+sgBbFGTRwB
         YTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7UNxfWJloEkKYMcxN9mT7rffNNA9Oni+HipJu8ICj04=;
        b=GAkGTmkO1MSqdK31GjcMQUaUL44/wccvmY8grMVBv9VLOEC5+Nv+Yfk1tz0E7pzGgV
         1qE45hq7XhobHjy+Nob9h6IKRcFJ27b7cigk9E3fL8BT4f2CSO+Oo0HI1h9Gg/VNaGMV
         z3YupHKLNL3j0M1Oh7l0K0cUpyP7VclLd+LRKyCH23bQnorqnoskpSR29N4i5Yk27ygW
         NTpTqs9SgT0g7rXA96vmH5edN3wylZ/IGXl7Y5KIpQp6UwVzvl+yB0/mUKcNCWEJidBo
         Icfwstr9gg+42TBcSA8bR668B8/nsiC/6e9NEVy9cJBPADFSG9p0YP5RaSAoK18jpYcy
         sBRw==
X-Gm-Message-State: AOAM53347werAQExy3PWJ/6Mp0NCd9Gl1B3fOhxbjp504MvQeXjM1XM+
        +uXeRMX7aVV+ZSJNNC37i0QVuEXJ6T05EJec
X-Google-Smtp-Source: ABdhPJxJIShHLbUlyzEaUm4sMb3cJiBmzcTH4QH0YTPyzsim5QL/q1k7yAAtzADXpeYuSCSa6scbvg==
X-Received: by 2002:ac2:4c4d:: with SMTP id o13mr31785361lfk.196.1637328033794;
        Fri, 19 Nov 2021 05:20:33 -0800 (PST)
Received: from localhost (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with UTF8SMTPSA id u25sm362061lfg.53.2021.11.19.05.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 05:20:33 -0800 (PST)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v1 2/5] can: kvaser_pciefd: Increase correct stats->{rx,tx}_errors counter
Date:   Fri, 19 Nov 2021 14:19:12 +0100
Message-Id: <20211119131915.2033234-3-extja@kvaser.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211119131915.2033234-1-extja@kvaser.com>
References: <20211119131915.2033234-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Check the direction bit in the error frame packet (EPACK) to determine
which net_device_stats {rx,tx}_errors counter to increase.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 2c98befcf2a0..6fb18ced1806 100644
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
2.31.1

