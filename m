Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D3D582400
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiG0KRZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 06:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiG0KRY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 06:17:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8879F42ADA
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:23 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e1so5369831pjl.1
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=980oFUpwJI5Mz79NnWWqDdwdmI9aJZAPmUQwx1kpVq4=;
        b=UWnT+OhqkhtuYuTyZxYDrRxyIpoBZo8DR3IAxqtFRWM/LcE9ITAFVrX4OGmHpViaVO
         y7+WjzWR66FJIg2Zkx1377njoY+z0tTxNRy2A1SJmxNhRnvWvujQN2eADU/tdDMUQ2fr
         D9jXOCcg2+4l8/SgsxKlP0XGca78UKxSE6A+TrbDPELusiZ0RRLQf2LeXh0dICrdMlH7
         2H0+wIJcwqDoh5TAvS3c4wgBDYCoIE7lYjWaSlkWLaDB3YocQ7UhJomP3evwZXUW6U3R
         MA2BTB0jOIHzMZjLpc/TkCPSm1foSyfjeJSKiXVwhpdJRwIjrK947A7rh19s6jAmQ6BC
         Y+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=980oFUpwJI5Mz79NnWWqDdwdmI9aJZAPmUQwx1kpVq4=;
        b=n6+konhTaLnsnveqZiD/Ml5FdeM44x9hQI3posLJi2aL942L5uTTwQNLeWhGQ3AMUQ
         TS8K/5EKOF+XH21N5xmV8ZWlv8bXMeaOhDV6r9pY+FGvk8KN2il/5uf/WbXjmFLQXjXY
         X1u8ajzXGW2jgbsZeVASwtQchOa/NlhjtkN5zlMb7Agq787NcKt2kd5aSLGlIMOZE7g1
         61etyODWE0YhR7XtGSfwk/MbR8WCEWKajA0odX2yZ/hnhym2iIy+FTyIsB4pawMEK4lg
         TJw23E0i7JQZCzrF/eb3U7qULL66WAi0LE/gpSu4Lq9WEosiRgHGHuXP5pvy1Z5/VvjP
         ibBA==
X-Gm-Message-State: AJIora9P6gH6veDpogZZPnsxKSx8/rchuhfKnWnPYgURB8BEBRRbMGlx
        h7aFxT6aTmrgy9TjQlYI8jdZ2g6Bc+Ta8Q==
X-Google-Smtp-Source: AGRyM1uWHppPuCaZPrRPF/Q8aqlnnGDDMt9aPK5TfpS/ioYFC30P1sNOEx96+JM0+PRVTsmNhdyECA==
X-Received: by 2002:a17:90b:3ec4:b0:1f0:5aab:48d6 with SMTP id rm4-20020a17090b3ec400b001f05aab48d6mr3778967pjb.123.1658917042843;
        Wed, 27 Jul 2022 03:17:22 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id w22-20020aa79556000000b005284e98304csm13260666pfq.205.2022.07.27.03.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:17:22 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 09/14] can: mcp251xfd: advertise timestamping capabilities and add ioctl support
Date:   Wed, 27 Jul 2022 19:16:36 +0900
Message-Id: <20220727101641.198847-10-mailhol.vincent@wanadoo.fr>
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

Currently, userland has no methods to query which timestamping
features are supported by the mcp251xfd driver (aside maybe of getting
RX messages and observe whether or not hardware timestamps stay at
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

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c    | 1 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ethtool.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 7fc86ed405c6..68df6d4641b5 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1671,6 +1671,7 @@ static const struct net_device_ops mcp251xfd_netdev_ops = {
 	.ndo_open = mcp251xfd_open,
 	.ndo_stop = mcp251xfd_stop,
 	.ndo_start_xmit	= mcp251xfd_start_xmit,
+	.ndo_eth_ioctl = can_eth_ioctl_hwts,
 	.ndo_change_mtu = can_change_mtu,
 };
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ethtool.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ethtool.c
index 6c7a57f16cc6..3585f02575df 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ethtool.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ethtool.c
@@ -124,6 +124,7 @@ static const struct ethtool_ops mcp251xfd_ethtool_ops = {
 	.set_ringparam = mcp251xfd_ring_set_ringparam,
 	.get_coalesce = mcp251xfd_ring_get_coalesce,
 	.set_coalesce = mcp251xfd_ring_set_coalesce,
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
 
 void mcp251xfd_ethtool_init(struct mcp251xfd_priv *priv)
-- 
2.35.1

