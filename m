Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4D656B903
	for <lists+linux-can@lfdr.de>; Fri,  8 Jul 2022 13:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbiGHL5h (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jul 2022 07:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238214AbiGHL5f (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 07:57:35 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727E19A6B2
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 04:57:34 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id r9so25623452ljp.9
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 04:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=diRCbeVEjbtRzKIAvXXKMcpzYzr5Rz2Sj3M2x4tfyYc=;
        b=AeF6Dda39O2ksLLsh3OVSz+YURIH3VVtaXvqZrxLy01LYeVGNS9hESLVktrII+Pgtk
         +3kQ1S+yi/xT8J2C3WjObIS89dkKyx2iWed6mQkwCFP2/QD5Unj/khu+et/MjS0tCqCD
         2mEKRpNtevuni4ipGIGqGuRPWzC3fQo+ub2bQaJz0Tc28Ymjnb0bcPBXg+BmF9JLQj9c
         4wCqS43SP1iE/wZXGT+z8dloqORYdJjEBSCakB4ZKrJR7YacCSWEHrM8IDQ/MjfY80iH
         alPOgIK5wD+UtIqjjlj/Af7tAWWclUkFM3Zi3+DqjBZvvx8XyA6SdgmqECQd1d790qQX
         mNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=diRCbeVEjbtRzKIAvXXKMcpzYzr5Rz2Sj3M2x4tfyYc=;
        b=gvr7H6FCAv5OXfAw0yh20DnKNxNDkX3UHMj+IbCNvdmjP+ZZVX2zD4V7E2Sdp8Vn+s
         QsE27mnu12lV7YK9KhxFuuGzxFyrNopybP//vr/l6afmU/5G9HS9e+f2TnDzVk37Ggr4
         L1fToxz69gJ9EzO0WMw1LvynbcIRvbPw3+e+I4Vz7hrHvt+EyerALT2GIlMW5KVHlRx8
         P56yzgZew+SJr8CTY/R21XDAaw3ReDptObZHxOOb6No/PfhVU6faMGw+690Is4ueCbzu
         YF+1PKK+pn8ahyONQnBa5BnYJivzmZ0TdKu/P8wMrecIhNRh04HcR8d6FTcn6RG7Okpi
         uTIQ==
X-Gm-Message-State: AJIora9dl3I2hTFrXobdBWVdYZC0lt0o7yiLnPE4Ocefymg2mgwYQbFv
        vF2Ul40xiYAL+hZrza6nzkam5/gDUVE7LQ==
X-Google-Smtp-Source: AGRyM1uiPyETCH4sfmAGGTyeVhczMksso9SZCJttSZb9uI35wkD5tTryhxut5v1gMaBAerQeZmJcqA==
X-Received: by 2002:a2e:87da:0:b0:25a:6883:d6aa with SMTP id v26-20020a2e87da000000b0025a6883d6aamr1764378ljj.196.1657281452781;
        Fri, 08 Jul 2022 04:57:32 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id h7-20020a2e9ec7000000b0025a724f2935sm7336199ljk.137.2022.07.08.04.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 04:57:32 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 03/15] can: kvaser_usb: Fix possible completions during init_completion
Date:   Fri,  8 Jul 2022 13:56:57 +0200
Message-Id: <20220708115709.232815-4-extja@kvaser.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708115709.232815-1-extja@kvaser.com>
References: <20220708115709.232815-1-extja@kvaser.com>
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

From: Anssi Hannula <anssi.hannula@bitwise.fi>

kvaser_usb uses completions to signal when a response event is received
for outgoing commands.

However, it uses init_completion() to reinitialize the start_comp and
stop_comp completions before sending the start/stop commands.

In case the device sends the corresponding response just before the
actual command is sent, complete() may be called concurrently with
init_completion() which is not safe.

This might be triggerable even with a properly functioning device by
stopping the interface (CMD_STOP_CHIP) just after it goes bus-off (which
also causes the driver to send CMD_STOP_CHIP when restart-ms is off),
but that was not tested.

Fix the issue by using reinit_completion() instead.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---
Changes in v2:
  - Rebased on b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")

 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 4 ++--
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 46133993be86..e469a7471719 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1869,7 +1869,7 @@ static int kvaser_usb_hydra_start_chip(struct kvaser_usb_net_priv *priv)
 {
 	int err;
 
-	init_completion(&priv->start_comp);
+	reinit_completion(&priv->start_comp);
 
 	err = kvaser_usb_hydra_send_simple_cmd(priv->dev, CMD_START_CHIP_REQ,
 					       priv->channel);
@@ -1887,7 +1887,7 @@ static int kvaser_usb_hydra_stop_chip(struct kvaser_usb_net_priv *priv)
 {
 	int err;
 
-	init_completion(&priv->stop_comp);
+	reinit_completion(&priv->stop_comp);
 
 	/* Make sure we do not report invalid BUS_OFF from CMD_CHIP_STATE_EVENT
 	 * see comment in kvaser_usb_hydra_update_state()
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index abe9c75e0fd2..4a82550bdda9 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -1317,7 +1317,7 @@ static int kvaser_usb_leaf_start_chip(struct kvaser_usb_net_priv *priv)
 {
 	int err;
 
-	init_completion(&priv->start_comp);
+	reinit_completion(&priv->start_comp);
 
 	err = kvaser_usb_leaf_send_simple_cmd(priv->dev, CMD_START_CHIP,
 					      priv->channel);
@@ -1335,7 +1335,7 @@ static int kvaser_usb_leaf_stop_chip(struct kvaser_usb_net_priv *priv)
 {
 	int err;
 
-	init_completion(&priv->stop_comp);
+	reinit_completion(&priv->stop_comp);
 
 	err = kvaser_usb_leaf_send_simple_cmd(priv->dev, CMD_STOP_CHIP,
 					      priv->channel);
-- 
2.36.1

