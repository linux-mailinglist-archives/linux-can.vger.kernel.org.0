Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66918582402
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 12:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiG0KR1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 06:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiG0KR0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 06:17:26 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE8E42AE3
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so1686854pjk.1
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DWvv44f0oidaLjWvc3PVOzvgSJgMfwiQURzAtfi7eA4=;
        b=RZqk0c7YIMHwpn28eYF6Fm4w1ZKu/o2gpCsGRyNQ3kZ6p3r8hXkSqssfRwlLgON49U
         1kKYCugi2JbGlbaR+MMn5KkvrerrHiTLptLiwbCXh0BfWbA8vbyTkM0PiCr09mfYMPqV
         B9Ig9oRZ6W7wiZlmurZ9w2i8E4jFrM1fu8es8e1F0itqU0/BNf0/wKPH0pu+/6hiEU2u
         I/QX8PIy0RlUIhPi1sZuFe+6BaGkC6CNHLpPu/F4Y+jeRnnx01T7Oinbcp8upsQumbEm
         yKaH2lIdZJLoGFIkKI/fZuCgoVcVm4ZhONgFVels1kaxe3eNRBq4luinRHJvHY3+skjz
         HkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DWvv44f0oidaLjWvc3PVOzvgSJgMfwiQURzAtfi7eA4=;
        b=q0Oz7X4Bh9pXh7lJqFO1Q+Sogy/l4kXW7hGp96RsOI5+qgyGyxN2NrTvJdkbCmBw+z
         mRRV5vVsSOf0y1j78T/M0U/s8a4TanTmF+cDapu8+fnuSJLkyBicrawktO1van0kBZdM
         1E1jYCtIXbcPfAKdEVrtqQgxx4IxQwKmiOmSNxvIWCZMPoqHx5v8KJg/5+VYuWHrrcni
         6G0w8vW1YBZ6Ewy98Y4DmFLMddz/UJp6c5zHToTsluCZGPlqaJHgmu9J2qGfKhxnULKb
         /KD+NhUUcW38NG3bnTsbW/bVf29iasDyEwCRbpfZ3/rZVSJHwF7muShiJFdWPwnKFWiD
         freA==
X-Gm-Message-State: AJIora/S/nJn/PB5yxWpPUZpqJh16Xdoi3oe6ZGRMADZKLRUUd0cyO4C
        8mNjpWobGgQDY6tM2FpoWSiMXbeehyBRyA==
X-Google-Smtp-Source: AGRyM1tgzSxGKdQiV0UWurtoDBQjJ0iBTya3OEPVzBPw+nZ0qKqtPRWhW3kMoAFS1s7qS+fsAZZOvw==
X-Received: by 2002:a17:902:f649:b0:16d:22fd:5c14 with SMTP id m9-20020a170902f64900b0016d22fd5c14mr21539756plg.98.1658917045093;
        Wed, 27 Jul 2022 03:17:25 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id w22-20020aa79556000000b005284e98304csm13260666pfq.205.2022.07.27.03.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:17:24 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 10/14] can: etas_es58x: advertise timestamping capabilities and add ioctl support
Date:   Wed, 27 Jul 2022 19:16:37 +0900
Message-Id: <20220727101641.198847-11-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220727101641.198847-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220727101641.198847-1-mailhol.vincent@wanadoo.fr>
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
messages and observe whether or not hardware timestamps stay at zero).

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
 drivers/net/can/usb/etas_es58x/es58x_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 7353745f92d7..5e2585c85500 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -10,6 +10,7 @@
  * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
+#include <linux/ethtool.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/usb.h>
@@ -1981,7 +1982,12 @@ static netdev_tx_t es58x_start_xmit(struct sk_buff *skb,
 static const struct net_device_ops es58x_netdev_ops = {
 	.ndo_open = es58x_open,
 	.ndo_stop = es58x_stop,
-	.ndo_start_xmit = es58x_start_xmit
+	.ndo_start_xmit = es58x_start_xmit,
+	.ndo_eth_ioctl = can_eth_ioctl_hwts,
+};
+
+static const struct ethtool_ops es58x_ethtool_ops = {
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
 
 /**
@@ -2088,6 +2094,7 @@ static int es58x_init_netdev(struct es58x_device *es58x_dev, int channel_idx)
 	es58x_init_priv(es58x_dev, es58x_priv(netdev), channel_idx);
 
 	netdev->netdev_ops = &es58x_netdev_ops;
+	netdev->ethtool_ops = &es58x_ethtool_ops;
 	netdev->flags |= IFF_ECHO;	/* We support local echo */
 	netdev->dev_port = channel_idx;
 
-- 
2.35.1

