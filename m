Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EF15FA3AD
	for <lists+linux-can@lfdr.de>; Mon, 10 Oct 2022 20:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJJSxE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Oct 2022 14:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJJSxD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Oct 2022 14:53:03 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE481EC46
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 11:53:02 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d6so17833182lfs.10
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Weh/qGxkZyRaMYmLsZogxgSTlDb2PqHeeJcVrhLnVDg=;
        b=mpD8h70FdydG78mZ3ZC5S+s7saeXi/k6FODJT1GDdFVKWGoEmiTdY/u1F+KlIHmcP5
         HsElYUiB05Xe8C8lsb+yctCUmz9OeYW8LHmWRYb5Joyy4Vxb0hMBaMMoHho/uMPA+B/K
         +t22bcQYib+jheTgHv6GX58NS55vu3J0eBJ5xOQ4SvhOTlJbbas1CwzGkvH9zDeQZDu4
         1qSOtaGeU2GtDvmhoAq7C25AOdInvaociyQ0Ue5Ui5vufFawvt7T4Ys73P7cGVB6nyH7
         5DuVCHp6QL5EbymaIe9rvyLtgHRikpUl0nyYR1tolX6OsFq5eaFoUYFJ13ecSM0X3Kko
         Y+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Weh/qGxkZyRaMYmLsZogxgSTlDb2PqHeeJcVrhLnVDg=;
        b=6YslVPQYXOWz1cnH3r5b5xWm8HF5O0g2tqnO8S0n80xeqZ9ZjSNSg2lXAB4UF+LN22
         T+JYU1YP78LwwoOFK6UUypf1N8wliYPdRv8HmGrTFMSp9JX7QLu69NeUhZVNNRpS5+j7
         Wov58hOxMUC3VfG6O0vGtlxpeVQS3vnIgJ7fEW7oFX9fJWdN75xbGP28zzxkqu2/RPB4
         mS8gwB/HvyFSNst7NTHRJ9Sl5rxfmPPGQOXlPHE8VK/QDG3s91gRSmH+f7SLJDbEjbV5
         b2ftd+Wklz9qB+fPaoOWgmKkhvCXzRZx4fI7wNQreMSuB4KQkN/4SffANFsHkxJNN1g/
         +N4Q==
X-Gm-Message-State: ACrzQf06kywicfBItfBUlaU+G0MdXoedVyVaq7Vep8dm3/9U6uyKKIgy
        gecn2+bbwpprW6yVFsMAa6y9UWHONjld6Q==
X-Google-Smtp-Source: AMsMyM4AsFlucjp3pQ3gY621WiC1HcZhCC/ZUlJZPSqq8ORvV11KVVxisMI+a8jbnhrXLwT/tMBAZA==
X-Received: by 2002:a05:6512:358c:b0:4a2:9c55:c63c with SMTP id m12-20020a056512358c00b004a29c55c63cmr6989333lfr.598.1665427980591;
        Mon, 10 Oct 2022 11:53:00 -0700 (PDT)
Received: from archyz.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512070400b004a2386b8ce6sm1517769lfs.207.2022.10.10.11.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:52:59 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v5 01/11] can: kvaser_usb: Fix possible completions during init_completion
Date:   Mon, 10 Oct 2022 20:52:27 +0200
Message-Id: <20221010185237.319219-2-extja@kvaser.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221010185237.319219-1-extja@kvaser.com>
References: <20221010185237.319219-1-extja@kvaser.com>
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
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v5:
 - Split series and rebased on linux-can-next
 - Remove stable from CC

Changes in v4:
 - No changes

Changes in v3:
 - Rebased on 1d5eeda23f36 ("can: kvaser_usb: advertise timestamping capabilities and add ioctl support")
 - Add stable to CC
 - Add S-o-b

Changes in v2:
  - Rebased on b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")

 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 4 ++--
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 7b52fda73d82..66f672ea631b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1875,7 +1875,7 @@ static int kvaser_usb_hydra_start_chip(struct kvaser_usb_net_priv *priv)
 {
 	int err;
 
-	init_completion(&priv->start_comp);
+	reinit_completion(&priv->start_comp);
 
 	err = kvaser_usb_hydra_send_simple_cmd(priv->dev, CMD_START_CHIP_REQ,
 					       priv->channel);
@@ -1893,7 +1893,7 @@ static int kvaser_usb_hydra_stop_chip(struct kvaser_usb_net_priv *priv)
 {
 	int err;
 
-	init_completion(&priv->stop_comp);
+	reinit_completion(&priv->stop_comp);
 
 	/* Make sure we do not report invalid BUS_OFF from CMD_CHIP_STATE_EVENT
 	 * see comment in kvaser_usb_hydra_update_state()
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 50f2ac8319ff..19958037720f 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -1320,7 +1320,7 @@ static int kvaser_usb_leaf_start_chip(struct kvaser_usb_net_priv *priv)
 {
 	int err;
 
-	init_completion(&priv->start_comp);
+	reinit_completion(&priv->start_comp);
 
 	err = kvaser_usb_leaf_send_simple_cmd(priv->dev, CMD_START_CHIP,
 					      priv->channel);
@@ -1338,7 +1338,7 @@ static int kvaser_usb_leaf_stop_chip(struct kvaser_usb_net_priv *priv)
 {
 	int err;
 
-	init_completion(&priv->stop_comp);
+	reinit_completion(&priv->stop_comp);
 
 	err = kvaser_usb_leaf_send_simple_cmd(priv->dev, CMD_STOP_CHIP,
 					      priv->channel);
-- 
2.38.0

