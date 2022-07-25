Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12B257F9B9
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 08:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiGYGzj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 02:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiGYGzG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 02:55:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE05312A86
        for <linux-can@vger.kernel.org>; Sun, 24 Jul 2022 23:54:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bp15so18847795ejb.6
        for <linux-can@vger.kernel.org>; Sun, 24 Jul 2022 23:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pq/5uoR3fJ3+2D6CJyRqXD1+RmzBjoigPwoKjoPD5TI=;
        b=J1YmFNSGqCGs0oFoTsH/GuL9y0lEMnoO0H1H2V9BVDeJmmoHUWp9Diatl+j3qPNdEH
         fNWgGg+vPLvwpfYFh20FkzTUurUwMFB4cOu+ZOKya/vq6g/8RbD8fut2cNI4Iw7dDN1H
         ww1gl39ZzAgR+f0Iu+TqdWVP7o6tvDjFgidLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pq/5uoR3fJ3+2D6CJyRqXD1+RmzBjoigPwoKjoPD5TI=;
        b=WAEfB23NLbzSEST65ld6oSty1ABRXwk0t/NsXwbq8eQreyDfg9UuF78VX7E29R6oSm
         nsAALAW/GzE5fXOZH9VZx96wC4WI30J0Bn/sGm1sVmNF+fyWTDDTY4FF8uPIuU+lAmQy
         SWAS+xrimESKFeFx1HIbZnvyhlaSGygLrPLUCFmy5UnTY/qCsb1Wn8hS8A17jiLb9JaB
         vg5JSJszUiXAuxZM+dUa7XvRkYSG2SQ8b+rFAvGxy/G7RX5HoxTsA0eoETqr+NJW+gpo
         shJlcNG6P5u6JlBYyCTreR1rZdxWmtB62LcQX54o+63yCFQqO5sFioAsmzc9WBa5fEnw
         2jEA==
X-Gm-Message-State: AJIora9OTGFzkMeJ03HRA0l9HRMRj09h8RjWqDqyF8ltFpnZgTOORkFF
        +6igz4zu+QCAlC7T2qikeNijWw==
X-Google-Smtp-Source: AGRyM1sP3g90eayg5p2dnArwYgQnccqgg13tHwuwEi32PELyLFY62vsbe+VXfs6nSaVzeWDIfLQpnQ==
X-Received: by 2002:a17:907:3ea6:b0:72b:4a06:989a with SMTP id hs38-20020a1709073ea600b0072b4a06989amr8756566ejc.168.1658732070983;
        Sun, 24 Jul 2022 23:54:30 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-14-98-67.retail.telecomitalia.it. [87.14.98.67])
        by smtp.gmail.com with ESMTPSA id r2-20020a1709060d4200b00722e57fa051sm4967711ejh.90.2022.07.24.23.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 23:54:30 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 5/6] can: slcan: add support for listen-only mode
Date:   Mon, 25 Jul 2022 08:54:18 +0200
Message-Id: <20220725065419.3005015-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220725065419.3005015-1-dario.binacchi@amarulasolutions.com>
References: <20220725065419.3005015-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

For non-legacy, i.e. ip based configuration, add support for listen-only
mode. If listen-only is requested send a listen-only ("L\r") command
instead of an open ("O\r") command to the adapter.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Remove comment on listen-only command.
- Update the commit subject and description.

 drivers/net/can/slcan/slcan-core.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 919311890d2c..76f20dc1aa90 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -724,10 +724,20 @@ static int slcan_netdev_open(struct net_device *dev)
 			}
 		}
 
-		err = slcan_transmit_cmd(sl, "O\r");
-		if (err) {
-			netdev_err(dev, "failed to send open command 'O\\r'\n");
-			goto cmd_transmit_failed;
+		if (sl->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
+			err = slcan_transmit_cmd(sl, "L\r");
+			if (err) {
+				netdev_err(dev,
+					   "failed to send listen-only command 'L\\r'\n");
+				goto cmd_transmit_failed;
+			}
+		} else {
+			err = slcan_transmit_cmd(sl, "O\r");
+			if (err) {
+				netdev_err(dev,
+					   "failed to send open command 'O\\r'\n");
+				goto cmd_transmit_failed;
+			}
 		}
 	}
 
@@ -814,6 +824,7 @@ static int slcan_open(struct tty_struct *tty)
 	/* Configure CAN metadata */
 	sl->can.bitrate_const = slcan_bitrate_const;
 	sl->can.bitrate_const_cnt = ARRAY_SIZE(slcan_bitrate_const);
+	sl->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY;
 
 	/* Configure netdev interface */
 	sl->dev	= dev;
-- 
2.32.0

