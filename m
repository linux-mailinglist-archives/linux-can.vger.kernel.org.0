Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9983057FFFD
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbiGYNdZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiGYNdT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:33:19 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9AC13DEA
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t3-20020a17090a3b4300b001f21eb7e8b0so13807935pjf.1
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y5CEe75A8u3CWAEPd7ElkQN9WsCb16Ds2aGybxs5+A4=;
        b=ht8wEb41Vlr4wZHW0TZEPApleujN1wuzA2FLTPMKvi95NDx/A5r8QJvews9yjMsbmW
         wzOytmf55sUOPeRomhuqCOE3PEZ1VaOoV8rQ0/Ltj+WiYnp1aT26OwACFoNfbVDdb57e
         CycAUp+sQhxCZ+D1SnlDq6brPbzyybesxW1bRWZuhxwjb68LWdLeDneS80+JSdzygTNI
         XOU3arTlxaC32PeLV/iGzVshzG6sNRylzxgrlIf1AWiuwkk9sOCW15isAZDnDzE3el/u
         f+OZlGyVSIC+YtXdFoxx3uglSYrflBODyU3894RqcMCfZ57zHDlqbZv5sf6iitcYmJvF
         bVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Y5CEe75A8u3CWAEPd7ElkQN9WsCb16Ds2aGybxs5+A4=;
        b=tsflLZ6xacBLpGLT+4XokO2TbrQr3lCHctI85TvoReeQbdokAzffFecFMhvo0sQ4hY
         k4u6F4WMCWRmoAPrvvK3JcugMcoxmXTZ2ejhCvM/j91Ilywk9M4CI0ilmSjuedz62yxR
         r/5NMdncfNqOIvpfM6QnQZ0yQ/Sp/XeboEGUsbmfw+zTAlDheSgZPLYJ+M2oyY49viuO
         IUZL99QP4cknv4BSD3AI0VPYNIkP3oZ2iqYNLlXBMlWqkXKcBVwuT8oyzJ2SlXem8f9U
         2Ut0nxye3Hh1BSDAN+SRMINM4lMLhbV7nlpiuG5JEWMvZQzX2FcUMiR6xaPxsrRdVm7r
         kU9A==
X-Gm-Message-State: AJIora9untUT4rjMpNCkYqxKKPeZzMVoHJS1X03bud5iB8fpf68lteQP
        eNi7f9D4/mUHKKzZvaoIPSDHXphsTF8kMg==
X-Google-Smtp-Source: AGRyM1sz3vK0qobNEMcC99C5M0T829rz5hKF8gWuGGhJ9hmKkAAHBf/rLfJtTCLLGGrIbdTeLU2/fg==
X-Received: by 2002:a17:90b:fc9:b0:1f2:e0a5:8a67 with SMTP id gd9-20020a17090b0fc900b001f2e0a58a67mr665201pjb.181.1658755992870;
        Mon, 25 Jul 2022 06:33:12 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:33:12 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 20/24] can: etas_es58x: advertise timestamping capabilities and add ioctl support
Date:   Mon, 25 Jul 2022 22:32:04 +0900
Message-Id: <20220725133208.432176-21-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Currently, userland has no method to query which timestamping features
are supported by the etas_es58x driver (aside maybe of getting RX
messages and obseverse whever or not hardware timestamps stay at
zero).

The canonical way for a network driver to advertise what kind of
timestamping is supports is to implement
ethtool_ops::get_ts_info(). Here, we use the CAN specific
can_ethtool_op_get_ts_info_hwts() function to achieve this.

In addition, the driver currently does not support the hardware
timestamps ioctls. According to [1], SIOCSHWTSTAMP is "must" and
SIOCGHWTSTAMP is "should". This patch fills up that gap by
implementing net_device_ops::ndo_eth_ioctl() using the CAN specific
function can_eth_ioctl_hwts().

[1] kernel doc Timestamping, section 3.1: "Hardware Timestamping
Implementation: Device Drivers"
Link: https://docs.kernel.org/networking/timestamping.html#hardware-timestamping-implementation-device-drivers

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 0e692c2dc54d..aba203af39ea 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -1980,7 +1980,8 @@ static netdev_tx_t es58x_start_xmit(struct sk_buff *skb,
 static const struct net_device_ops es58x_netdev_ops = {
 	.ndo_open = es58x_open,
 	.ndo_stop = es58x_stop,
-	.ndo_start_xmit = es58x_start_xmit
+	.ndo_start_xmit = es58x_start_xmit,
+	.ndo_eth_ioctl = can_eth_ioctl_hwts,
 };
 
 static void es58x_get_drvinfo(struct net_device *netdev,
@@ -1991,6 +1992,7 @@ static void es58x_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops es58x_ethtool_ops = {
 	.get_drvinfo = es58x_get_drvinfo,
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
 
 /**
-- 
2.35.1

