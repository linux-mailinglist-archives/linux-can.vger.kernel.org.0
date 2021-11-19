Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2CF456F7A
	for <lists+linux-can@lfdr.de>; Fri, 19 Nov 2021 14:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhKSNXg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Nov 2021 08:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhKSNXf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Nov 2021 08:23:35 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDC5C061574
        for <linux-can@vger.kernel.org>; Fri, 19 Nov 2021 05:20:33 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id z34so43429875lfu.8
        for <linux-can@vger.kernel.org>; Fri, 19 Nov 2021 05:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZBD3hwssD2tYPAWF7NI321hEOU/HFZTnf5tmgEOXk3k=;
        b=SMzVvetxVameQ84srw62lBlNwPGAvc9jClyF2EzItLweFm/ywlNMs7Pmi1TsUDqpfL
         nJ/QPWrRyfoX4RurFLJD1fnhYUXWLN4Ip9RDWJs8OZ0MYKMNThIsQ6NnES0sc0G3k0fD
         TDmtSzBWpbKzoyRjhTpg7snFm9LIUWjmjvQUEJuqtbkrUf/Hh3zXnDQ2yBvY5nzcp8xx
         TMLlOkTiCWDvGoAjaz2jzYb0uI+yPKudpVjOFy5ys1KNYYgFMgs5f1NvLI/QkeTjyaca
         Djx8A+VM2LOmsJeU02q4mboXspexusK2wEajHJv35y3FF65M10ewXsiV5pPMLs+IHN4L
         YYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZBD3hwssD2tYPAWF7NI321hEOU/HFZTnf5tmgEOXk3k=;
        b=WhLx5yUHyLHT1/f7F7x9aGHCYkKb4xYymzVaYKsHg90secGkX7EcOmCU/UjWXfUNwI
         i96xfKza6mlFEqC3gJD3NUbynRv7zxfQPXuFD6SXCL7WiGenqr2znevr7BzKYu0zCbtr
         AvkGAiLe2R6pnAIeKCRA20rD0h+tC2Bt5jImdNpG/CmHoW4BOSk3rGBLmZJb5Q0X5tFf
         NHtEfMlL/TcopXKrHndbuqIpwkz0bpERzYny/q++LdRpSZo/R28fV+8ycTD+8q/6GmVt
         Sw4MSO2GfwH2HdiNFPTmYNeO6su9AJhXzeQlp8tdXmocV5uat7y8TGVuQrDxiu+j5R5X
         OLnw==
X-Gm-Message-State: AOAM533WeH7DytajIYrNV1A8sCGMOV18degH9HkCxT5ql42C/LTYYzpn
        ysocwq2ztxOMDjJEpwNgsQPRNzM+DJ7z9okr
X-Google-Smtp-Source: ABdhPJw73SFrHftvgjE+w4Awal+AF4BziAwIaO5UMnEtMIUsJjElEHhoJ96FxWCNXNsA5TIqJOEPeA==
X-Received: by 2002:a05:6512:ac5:: with SMTP id n5mr30695433lfu.246.1637328032189;
        Fri, 19 Nov 2021 05:20:32 -0800 (PST)
Received: from localhost (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with UTF8SMTPSA id s13sm360509lfg.126.2021.11.19.05.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 05:20:31 -0800 (PST)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v1 1/5] can: kvaser_pciefd: Do not increase stats->rx_{packets,bytes} for error frames
Date:   Fri, 19 Nov 2021 14:19:11 +0100
Message-Id: <20211119131915.2033234-2-extja@kvaser.com>
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
 drivers/net/can/kvaser_pciefd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 74d9899fc904..2c98befcf2a0 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1304,9 +1304,6 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 	cf->data[6] = bec.txerr;
 	cf->data[7] = bec.rxerr;
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
-
 	netif_rx(skb);
 	return 0;
 }
-- 
2.31.1

