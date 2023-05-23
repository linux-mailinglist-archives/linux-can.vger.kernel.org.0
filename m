Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC4970D95E
	for <lists+linux-can@lfdr.de>; Tue, 23 May 2023 11:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbjEWJpY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 May 2023 05:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbjEWJpU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 05:45:20 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2854B18F
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:09 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2af31dc49f9so34506871fa.0
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684835047; x=1687427047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Kh3GE/onMXlqrdTcNUXpV+Llc2FWPUXYEluUub7yYQ=;
        b=PqhsugZPYPAQAqX/rjZgHpHbp/UTmiogcAi777u7/RodwJV/mD0kS3YClEVvvF7av8
         WXhOIkt/R3QEoSzI8DCaKYhWNDipQbSgxaxr1K08spWaVDxTT8pyixZj4t+NQ4KE2VX/
         3xb4eLjfVm2KPLkilhCkoJY6JZlizQuNhMeCaz80N95lYV0JVRJn8FPkIc8FG52sK0Ae
         cF6amlrrh+JnrNEARJC1Pmq7FhZzoR9czaOnStGH2kCsQn+747OXSp0BM9rOFJ6LNIsa
         0qB8z07NUA7FD1D0CKdSnIp0exB7onHBdQNYKLFeH50rAiM5//OKQcZVIcD0ARXO55Ij
         SudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835047; x=1687427047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Kh3GE/onMXlqrdTcNUXpV+Llc2FWPUXYEluUub7yYQ=;
        b=UwLuTnZMG4zGI2vAljyqHnP6Ykgp/GB3OVuxQemDgN10Epmj8Im4+g4VpTBIdeW2By
         l/stT/m/FMtCeYU2FSmcV4f5zBYnMqkbkmbt3lYh8TS5zc2Om7nFt9VQdG6RVROTiGuD
         RIVj/wfOnBQN6ET3CZSm77qBHm6EuWtNIjoX/a9FVNshQaGtEfADyh8g8xLeSe6wiCQr
         TKbtQrPUUKfulT0XkF/ZS9OdvSBvZqn6vhMUdIaaYiFyMRRQwA+oqN63VFqvYHHTKLtz
         jS6Pr5c9oLgGxpIvrFDX56FFfLkeXpmGVIuy5Ibi0K/E1pm8gWrh6t8dkujdc3Qpz27c
         ixoA==
X-Gm-Message-State: AC+VfDz/jiasM+xYtdLQVnRRSyTCO3bEbJQFn6vHC6BGynkv1b3jaGGN
        NkPGdoivuwI0vCESKtblN8TXisD9r3Z1mqxk9Qk=
X-Google-Smtp-Source: ACHHUZ6yaimE1C9mYqOgnJ8JMhRHwyPdvipW8YRD0xBRIQyTZiCX5IOpcAYo8yFWBO+1uVzEc+uhFA==
X-Received: by 2002:a2e:8216:0:b0:2ad:8380:770d with SMTP id w22-20020a2e8216000000b002ad8380770dmr4124881ljg.21.1684835047376;
        Tue, 23 May 2023 02:44:07 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9490000000b002ac87c15fd4sm1535551ljh.95.2023.05.23.02.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:44:06 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 05/12] can: kvaser_pciefd: Define unsigned constants with type suffix 'U'
Date:   Tue, 23 May 2023 11:43:43 +0200
Message-Id: <20230523094354.83792-6-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230523094354.83792-1-extja@kvaser.com>
References: <20230523094354.83792-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Define unsigned constants with type suffix 'U'

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 88bad2c2b641..abb556fb5cb6 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -25,12 +25,12 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 
 #define KVASER_PCIEFD_WAIT_TIMEOUT msecs_to_jiffies(1000)
 #define KVASER_PCIEFD_BEC_POLL_FREQ (jiffies + msecs_to_jiffies(200))
-#define KVASER_PCIEFD_MAX_ERR_REP 256
-#define KVASER_PCIEFD_CAN_TX_MAX_COUNT 17
-#define KVASER_PCIEFD_MAX_CAN_CHANNELS 4
-#define KVASER_PCIEFD_DMA_COUNT 2
+#define KVASER_PCIEFD_MAX_ERR_REP 256U
+#define KVASER_PCIEFD_CAN_TX_MAX_COUNT 17U
+#define KVASER_PCIEFD_MAX_CAN_CHANNELS 4U
+#define KVASER_PCIEFD_DMA_COUNT 2U
 
-#define KVASER_PCIEFD_DMA_SIZE (4 * 1024)
+#define KVASER_PCIEFD_DMA_SIZE (4U * 1024U)
 #define KVASER_PCIEFD_64BIT_DMA_BIT BIT(0)
 
 #define KVASER_PCIEFD_VENDOR 0x1a07
-- 
2.40.0

