Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5CE714A8D
	for <lists+linux-can@lfdr.de>; Mon, 29 May 2023 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjE2Nox (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 May 2023 09:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjE2Now (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 May 2023 09:44:52 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C83DA0
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso3430714e87.3
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1685367889; x=1687959889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Kh3GE/onMXlqrdTcNUXpV+Llc2FWPUXYEluUub7yYQ=;
        b=W0T7YoRhr1f5GhGMwQTrhexns4qVMJ7bqjbNtx74w3CVFJ+cb5oJZvFCNoPrsNEnwu
         jRYlpaB2L0213nHdk1lVa8NM4aoMFbEsjJZdAmSSLVd2izjkf1p7jLK04UhHbavf8JHg
         Rl/C2L4/wUeAgdDIEtyCuTvTs0lVi9JHgxRp4miM7KUorW8295noTNYdOEeom8cjY7tO
         6bpIyqgHq6i8Fdo2vWyOdpFhzTSZevV04tE4txCP4R4G4RosQJcUpKZv5keIyWyfu2ML
         ps8oc+liWY9pikSar6FFES0Kd6s4iajY9ih/CxfbakU8cUmgDUWHWsygP7/N8avrj20i
         2hFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367889; x=1687959889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Kh3GE/onMXlqrdTcNUXpV+Llc2FWPUXYEluUub7yYQ=;
        b=W87YHMOsDHhLC4PpYE7fk2Lwq9DrMNBZ67guVgsQloo75tZa/NjZN660URU3Snbmuw
         6HckG0Zs3UShPTZiN8uexhpLlb89rnMkElIOhwExJJqoD+fE24ZxTaShxxQ6MnRT0xc4
         aD6+lwZbdkNg7qOf0a82ZeNIKYJAaOfobSXYauZXsWUrSSJAB1eBsx2/dVMzjYZXyeFm
         32jzTVldr8P1OrbXQFAYZW7IdbG/bqsumzF5dVmRweFdpKJ6Vg+u8h1t+u80s2kgwWBl
         JgvldwCffjLY12nSJ7/BmWiA2uwP2tJTRvs0zzEdoQTjsW5K9DnZpPiGAOYhTm8Vnclg
         /yUA==
X-Gm-Message-State: AC+VfDxuqoYBqoO6DgWvlCZIcBjQ+WWHRLhAYWH8zbK1l8BdIgIL+dL0
        OvOL3AT811I+96YMM57SFnFaf3MpuZl3dKIB9aU=
X-Google-Smtp-Source: ACHHUZ5+WixBpoEDa2snd2/o97MidBa4OFdhwiNuoL6Aa5rKKOzesAKT7S/gy9GasW7q3hUV7zAyTw==
X-Received: by 2002:ac2:5339:0:b0:4f4:b28f:6b9c with SMTP id f25-20020ac25339000000b004f4b28f6b9cmr3293665lfh.29.1685367889431;
        Mon, 29 May 2023 06:44:49 -0700 (PDT)
Received: from freke.kvaser.se (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id s7-20020a19ad47000000b004ebae99cc1dsm580lfd.159.2023.05.29.06.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:44:49 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 05/14] can: kvaser_pciefd: Define unsigned constants with type suffix 'U'
Date:   Mon, 29 May 2023 15:42:39 +0200
Message-Id: <20230529134248.752036-6-extja@kvaser.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230529134248.752036-1-extja@kvaser.com>
References: <20230529134248.752036-1-extja@kvaser.com>
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

