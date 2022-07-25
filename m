Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA88580250
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbiGYPyo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbiGYPyl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:54:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0320C13DC6
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id y1so2731563pja.4
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xyDD8XmcRbnmcYGwa3rI3FXzzvrQt7B7Fewd8yZG7EY=;
        b=Rxgcfm7GNroq46szD03wbmREvRnyziJe+lqDjuUzptMvvov5Db/FCO6n3xqJt1Zn97
         1r9+xXijHT9ViPPlvKJoPExZ0lf08gxI3QSs0gVdZrZREiXFGkkhVqDQHSX79WWkOG9N
         elaX1wLIWccK8r6IjeWcUWRYJUWl8BqMKW2+RqEvzbVw+bFf1JAvfXFE0qHkv5u96B7x
         MiBz1JbrrJhifB8gdQhOGnhmHfk4RC6T4IkMhUKq3lRBHPirDOV/X/N6cZmcwq52kFDS
         DqenIrTWTISSnGtcz0aTZo+UpqztgGKeWgn96NVQHMnGz45SiMaYRnCS7tVxiD6Edj2A
         V0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xyDD8XmcRbnmcYGwa3rI3FXzzvrQt7B7Fewd8yZG7EY=;
        b=kz1EbiuU87vMkS8i5mXb6F84gyfj6PcH17YYAtyYTmXghWyfL0bC0OFYWviSLct47H
         UTNvZdFx8gh3rkGQSJRdSD+Bvi7EZVrOH3Dxm1seS5dk7nVDCEgn3H90YEQFN7iWmc8e
         LWXnA7CoRROarpGyMvsrZal/NQEgJNxP1iIsLQVGZKQsBbXtcooP9W4TRL2mxR6d7UYa
         9zW09qiv7kwAiD6zu08mOgVnRcmNVGxH8NC5fXBkkdO82U/+lNbx4UMJ4uY4SyflXSet
         o8SF31JDHGq8o1Z9fW8jMG8sSoNwSA4xORaKdZLG5EgMd3Ds8/CwR/hIBNa2d11/EcSC
         RKlw==
X-Gm-Message-State: AJIora+/d3W7/cRtkyr5fjnayAQYKWfB8NHy7Sn+zJ2J29+JYL+G2Wl2
        42PPYTza5A6VYjvyNhzbv8Al9zT+dnQOtw==
X-Google-Smtp-Source: AGRyM1u4Yz2WOVXcZJTudl9IV/49+tKb8b3WawTVJnyPSqLokp24V+SUfbXzM7gcmbBPx6jcKNUYUg==
X-Received: by 2002:a17:902:e84d:b0:16d:6c93:92fb with SMTP id t13-20020a170902e84d00b0016d6c9392fbmr6587855plg.146.1658764478128;
        Mon, 25 Jul 2022 08:54:38 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b0016d692ff95esm3511296plr.133.2022.07.25.08.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:54:37 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 13/14] can: peak_canfd: advertise timestamping capabilities and add ioctl support
Date:   Tue, 26 Jul 2022 00:53:53 +0900
Message-Id: <20220725155354.482986-14-mailhol.vincent@wanadoo.fr>
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

