Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C8958111C
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 12:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiGZKZv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 06:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238618AbiGZKZs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 06:25:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599871E3D4
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so12844508pjl.0
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O77AFzlnueoeomxY72O5VIzvJ+neo5so+JCqOldWoGc=;
        b=eMnsONX56trJk264HlHqJyLWCl+vvq6iwl9SivdpBkZuY4IQO2X1tbRvN5eci7ezY3
         n7lyWGnfVMXu+sIMvyjBpmRLKkbzbmGva9FfLbNrvssr4G/8yOq52wLGFq1rmBA8w3pc
         88vYQk3Z1xJmnkNjCrtL5JjjqD1Xkl3YCo2bV9V/rVdKTWW16Zc2z5EjfQ6Fsj84RXS+
         oe+OP3QeRrulBn0uFN+nzJl5ywgeva5iURWDXZEtbEDz6aL7hslGZcX2xI+OJffloFO2
         L3RbZ+ehHOxK7vVx6CrpC1Tz7ActbTIu3Y+E8XOsL31uDxQ5MOfNSWSvYvjUqXCICRaF
         Mvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=O77AFzlnueoeomxY72O5VIzvJ+neo5so+JCqOldWoGc=;
        b=R1NvIsEOPLd+QBs3zv3MpCi0LFJkAkuiE+GMBwR/LOaLv8I7NTAqx/H3ArpX4nITiv
         CenRtxy+8vxPMvT5RpKJBZCUlkPCRmZX5hvBcX2IVA7dj/AUJniWTCwaPVNlU/bFLpBw
         jsyEAM/wIJocpUDM10D+/XpgApMKifx1CTDCjteAwv0GK+0haCW2bJ3Pg17zHVKkgvSc
         K96tZpqc6QZ2CQ3v0EjfsJeqyYOFMPB9MaYUkl4yXJVeEZYKTyBFPkQj63rGI+/XsSKW
         h43OcnSh1+R/zvOejMVm9RhfxVAw4aZ9q+zQUT2WDtmghiSri6ATW2Gf7APJgoLIF7ys
         v9FQ==
X-Gm-Message-State: AJIora+LLRKhBcP5A4Pdr2yY8hpDDfIT9/dMlU1j69rTsEf3H64uOheC
        MFOilzdeXZ5ouyyVULmC5pA8wXiqLHW7xQ==
X-Google-Smtp-Source: AGRyM1v/qevSIvq0mc5vBirhH1A8+hmNXI/kBYTaxy/BBnlHRxsGPMGMs/hLywgGHTv/Uj42fMNFLA==
X-Received: by 2002:a17:903:1053:b0:16d:9ef2:5f43 with SMTP id f19-20020a170903105300b0016d9ef25f43mr2074831plc.117.1658831145674;
        Tue, 26 Jul 2022 03:25:45 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id y6-20020a655b46000000b00411bbcdfbf7sm9869894pgr.87.2022.07.26.03.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:25:45 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 10/14] can: etas_es58x: advertise timestamping capabilities and add ioctl support
Date:   Tue, 26 Jul 2022 19:24:50 +0900
Message-Id: <20220726102454.95096-11-mailhol.vincent@wanadoo.fr>
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

