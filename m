Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4670658111E
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 12:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbiGZKZ6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 06:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbiGZKZy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 06:25:54 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE86B7D6
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:53 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b9so12836942pfp.10
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xyDD8XmcRbnmcYGwa3rI3FXzzvrQt7B7Fewd8yZG7EY=;
        b=iAEsgBu8sjAcfcthMsGzSo0OGmPGnkDD5nO4xZKGbgiTUNAlXfFkrSojrxMI4ykhJJ
         /gTNKvbEMMxdBtaM2PULpVesExK6gHtIPp+DptgsIBw3/msxrSwIIv3HrskjyFrvJNLT
         1AVIb6UnOLSyV0PU+fKnEsXxCnjod4uB83jU/lbPtcTJ+oW1XJGV3F2AeR77cFvGJ06A
         Vc8SzySBHbwrbosvEtambzO/paAuoS6HbGSZFVUNCzY0fSEeU3SV+BcH+nbpfD06LcVs
         SRCzplkxTB2bBDoDiBwEH5fcdpW8/MYERNwdCguBazLblnYkz3LPHCspMoLr/zgFoRr1
         5rZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xyDD8XmcRbnmcYGwa3rI3FXzzvrQt7B7Fewd8yZG7EY=;
        b=DtjCSxS28uIhFNKTKpMy7yVNx5WfbkunDwORNxyOzImYU2YPd8rkvPmsEMf8Bxqa/y
         n5GluV+7p2VWG4atip+OpA8zyzPOnJJ/0JGUEYe72PVV6oop7Xa92z5x00zrCAqy6gjW
         Wp0hub7chWjtrDf7WGlmRAK31/FLzbx59DsQVkBgSdgD1Zs6ECv4s1lzCc1KeDl/hNDK
         n0v2847q6umyFGewHw5iqA1h/wqnqDdWfXMMl6Izj4m00neaRpo2h9Y56XkmC+X5c4Nw
         tJvaLxWIQKwgUzSCpvtBfi2T+lEizQvlQ+kURk1nwLEepvcPygLT6BIEH26SzYZehsD5
         rosA==
X-Gm-Message-State: AJIora+48AvoP7y6TC1Ca1ptmtd7aDPCkXRz8IneorxvWXz9/f8Fku2p
        NUZW9LgOq3V9mE76k5EPyvWMgYbJGTi+og==
X-Google-Smtp-Source: AGRyM1vJ1TmmxNTO48/2ekqVbFzcdc+Y7BD7ZouC2apH/+pusHihDNJYIMJsktmdxEv5nzgbS21raw==
X-Received: by 2002:a05:6a00:816:b0:52a:dea8:26a2 with SMTP id m22-20020a056a00081600b0052adea826a2mr16480312pfk.36.1658831152683;
        Tue, 26 Jul 2022 03:25:52 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id y6-20020a655b46000000b00411bbcdfbf7sm9869894pgr.87.2022.07.26.03.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:25:52 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 13/14] can: peak_canfd: advertise timestamping capabilities and add ioctl support
Date:   Tue, 26 Jul 2022 19:24:53 +0900
Message-Id: <20220726102454.95096-14-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726102454.95096-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220726102454.95096-1-mailhol.vincent@wanadoo.fr>
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
are supported by the peak_canfd driver (aside maybe of getting RX
messages and obseverse whever or not hardware timestamps stay at
zero).

The canonical way for a network driver to advertise what kind of
timestamping it supports is to implement
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

CC: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/peak_canfd/peak_canfd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index afb9adb3d5c2..634e24d99ac6 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -7,6 +7,7 @@
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
+#include <linux/ethtool.h>
 
 #include "peak_canfd_user.h"
 
@@ -745,10 +746,15 @@ static netdev_tx_t peak_canfd_start_xmit(struct sk_buff *skb,
 static const struct net_device_ops peak_canfd_netdev_ops = {
 	.ndo_open = peak_canfd_open,
 	.ndo_stop = peak_canfd_close,
+	.ndo_eth_ioctl = can_eth_ioctl_hwts,
 	.ndo_start_xmit = peak_canfd_start_xmit,
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static const struct ethtool_ops peak_canfd_ethtool_ops = {
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
+};
+
 struct net_device *alloc_peak_canfd_dev(int sizeof_priv, int index,
 					int echo_skb_max)
 {
@@ -789,6 +795,7 @@ struct net_device *alloc_peak_canfd_dev(int sizeof_priv, int index,
 
 	ndev->flags |= IFF_ECHO;
 	ndev->netdev_ops = &peak_canfd_netdev_ops;
+	ndev->ethtool_ops = &peak_canfd_ethtool_ops;
 	ndev->dev_id = index;
 
 	return ndev;
-- 
2.35.1

