Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A131A5FA0EA
	for <lists+linux-can@lfdr.de>; Mon, 10 Oct 2022 17:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJJPJO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Oct 2022 11:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJJPJL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Oct 2022 11:09:11 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8E965838
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 08:09:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a29so17055635lfo.1
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVjyZ6RPpXNEyZvmFfJXSqMx0n7JI79QpjEdzUplq7s=;
        b=q+o1gHOKIvmZevh5kQ4fQ6LcFBZdULNRStkWVUrGdC5Vmv9AK3GKfZmB6374KthoCM
         f1nMuUSFqusnNoota7BuTf3hDX8Fbfmlp58Ux5KhVEaovm98bgPy4OzCOT4V6BzEYMgb
         a9Yymv6rbro6k9Ph4ALLpOrC9b+3pcy6Csi57HcW6irn9XFk7twkIRXg1hj+vWv6TtF/
         cNIVl4gNTNlKRhSUC6YF06Du0FpVqaKVdAUFswhONz+hetGaG/T7b64UEak4yhnJEkcg
         oAK5g3vHnQsN7x/S/N23vcZwlVWv0h7z3ZLbpNj7vZLKDvmr8l6eqgAYDp0Y0vOt7Arw
         L4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVjyZ6RPpXNEyZvmFfJXSqMx0n7JI79QpjEdzUplq7s=;
        b=vjwMENHmoDUjIfJMHcQAVXH4pw0R8cz8nNWQ+Lg/s94ioqAKIw+jD6zhYWNZDMz1q6
         9N/pec//+mEcP21Kr+wyTAczdN/mExUlyrmfRuVVnICm0xv8itc4n00BBCHY6+tqYGxD
         B1O8ePpBZm4CB8V6LFEBoa6IwqZ7ajX1EWkJZLbjMwP10iCSKr5c3e06uERClwReOIWS
         MXjXIJRlWJ8hONVipSFXBTnj91ml446usVIdAI/LFlk1bWLks7sav7ZoZJASVXwry35K
         FVccdRqJOWyHzk14fs6V08B5zqMPji/BRZgesnRercmuY8zL5bRROMeg+Prs9F7wPqvT
         5umw==
X-Gm-Message-State: ACrzQf0ppfo0HU/fbEY9OufRTfZP+RFHMvKAEYirlQvrwwAtzj/hbcYc
        dGrgnnVSuruxqKS+BXYMkJf2prtttBU4HA==
X-Google-Smtp-Source: AMsMyM53RbZF3BqFH7lI2oQop/p+9h5witjA5xPc5BFXD475MIg+4uIeR0w/ghAeczazSzmgQuUaQg==
X-Received: by 2002:a19:f811:0:b0:4a2:71df:7940 with SMTP id a17-20020a19f811000000b004a271df7940mr6468537lff.306.1665414548014;
        Mon, 10 Oct 2022 08:09:08 -0700 (PDT)
Received: from archyz.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id q7-20020ac24a67000000b0049ebc44994fsm1450280lfp.128.2022.10.10.08.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 08:09:05 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v5 3/4] can: kvaser_usb_leaf: Fix TX queue out of sync after restart
Date:   Mon, 10 Oct 2022 17:08:28 +0200
Message-Id: <20221010150829.199676-4-extja@kvaser.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221010150829.199676-1-extja@kvaser.com>
References: <20221010150829.199676-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Anssi Hannula <anssi.hannula@bitwise.fi>

The TX queue seems to be implicitly flushed by the hardware during
bus-off or bus-off recovery, but the driver does not reset the TX
bookkeeping.

Despite not resetting TX bookkeeping the driver still re-enables TX
queue unconditionally, leading to "cannot find free context" /
NETDEV_TX_BUSY errors if the TX queue was full at bus-off time.

Fix that by resetting TX bookkeeping on CAN restart.

Tested with 0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778.

Cc: stable@vger.kernel.org
Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v5:
 - Split series and rebased

Changes in v4:
 - No changes

Changes in v3:
 - Rebased on 1d5eeda23f36 ("can: kvaser_usb: advertise timestamping capabilities and add ioctl support")
 - Add stable to CC
 - Add S-o-b

Changes in v2:
  - Rebased on b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")
  - Removed explicit queue flush.

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h      | 2 ++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 841da29cef93..f6c0938027ec 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -178,6 +178,8 @@ struct kvaser_usb_dev_cfg {
 extern const struct kvaser_usb_dev_ops kvaser_usb_hydra_dev_ops;
 extern const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops;
 
+void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv);
+
 int kvaser_usb_recv_cmd(const struct kvaser_usb *dev, void *cmd, int len,
 			int *actual_len);
 
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index c2bce6773adc..e91648ed7386 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -477,7 +477,7 @@ static void kvaser_usb_reset_tx_urb_contexts(struct kvaser_usb_net_priv *priv)
 /* This method might sleep. Do not call it in the atomic context
  * of URB completions.
  */
-static void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv)
+void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv)
 {
 	usb_kill_anchored_urbs(&priv->tx_submitted);
 	kvaser_usb_reset_tx_urb_contexts(priv);
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 8e11cda85624..59c220ef3049 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -1426,6 +1426,8 @@ static int kvaser_usb_leaf_set_mode(struct net_device *netdev,
 
 	switch (mode) {
 	case CAN_MODE_START:
+		kvaser_usb_unlink_tx_urbs(priv);
+
 		err = kvaser_usb_leaf_simple_cmd_async(priv, CMD_START_CHIP);
 		if (err)
 			return err;
-- 
2.38.0

