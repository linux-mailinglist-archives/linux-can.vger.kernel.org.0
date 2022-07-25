Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B90E58024D
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbiGYPyf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbiGYPye (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:54:34 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25B913DCC
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:32 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f65so10716719pgc.12
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O77AFzlnueoeomxY72O5VIzvJ+neo5so+JCqOldWoGc=;
        b=KdKblyKDMRYbVoDdOq2iekOBYwxBaVhsTKgWHzQyjO3KYPCgUCT0VoO796341j6q5H
         vcmpnylppRj58Ebe8S7ODfAuKPspg0B/9R0oDII8OjWK3BFHh840N/ZhxF6TzFrtcakc
         Y3D/v9F/y7RfxR4pKTwezmrXTZZuDr5WR/D7UMCAVECoT+yaytpD+l2/nQIylTJ0VSo1
         cwGm+30UPSN1pXKL93U688izq2uXDcZPcDYQLPFjgug1KLA00yqU60JCZz452QAehjrS
         5812LvI1tBbeP0N4zyyu7RmEJngjgrIinuX/VO+tZs4Ei4Q5779hY2/+Sy3Sq3UrCNzf
         rt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=O77AFzlnueoeomxY72O5VIzvJ+neo5so+JCqOldWoGc=;
        b=QiXUXTofPBA2FeKuYd8MOOSMGLJQqvn6VrY6Q2JGrLpdRo2O+vE7huaBm82fXtS6PE
         lu5ZZ7zugbFglu97l1kfjpTfGpUuQ8RV3GQHYC9kuJREIx395nbkSZfLIMvt+uz0ZBrZ
         1gPN2sbZP3jRHvRwiBj1T0HxBdyUBBvyWdsgv8pu5DVDP7gKhAr5wSTKiXi8HjoxhpTf
         xVPwOPctxx/Zuz+a96r3/3va/ksonFP87uU42p9UGRMcJNBtKHLsi+gvCfhikeI0mcXt
         iDbedZTr3lh/2VOfiFw+/W+rrmgPUuiGvQcjq4f7Da4mXgUjgpoRS+oc609f9LfxGSvO
         p/5w==
X-Gm-Message-State: AJIora9lpKu2/YGe2DEBRfUaq1h0u9emBTux5QQYCYIdY8Spd38VeGbs
        sa161AhALHBS67mdWrvCc9jmACHBHC663g==
X-Google-Smtp-Source: AGRyM1uugoq5/rFoZl3pL/6gKkfxpZqEDpggG/uiOgobidPjS1D1eX9ZY8PIxPuC7liA3DxgOtRPxw==
X-Received: by 2002:a63:86c2:0:b0:415:eb:d166 with SMTP id x185-20020a6386c2000000b0041500ebd166mr11302910pgd.124.1658764471529;
        Mon, 25 Jul 2022 08:54:31 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b0016d692ff95esm3511296plr.133.2022.07.25.08.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:54:30 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 10/14] can: etas_es58x: advertise timestamping capabilities and add ioctl support
Date:   Tue, 26 Jul 2022 00:53:50 +0900
Message-Id: <20220725155354.482986-11-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725155354.482986-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220725155354.482986-1-mailhol.vincent@wanadoo.fr>
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

