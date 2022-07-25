Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCF1580002
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbiGYNdk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbiGYNdZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:33:25 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4EC13DCF
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:20 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 23so10354508pgc.8
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jjKb6TirPKLhfcVq5PbTY6uNTrlTo2aZTAUnFsk8e9o=;
        b=MgJ7YL7YSwwiqNFh4wox2ESEzjBkFDOE7bsWlZdEHbUwhikNFFz6m1PbDFHHD2z+dj
         /5i864rTS6bhVvy3k2TKJjyZTcjf6nIHbYH3UZsuxs+hhW45KfsGjCvkG62h+1t0BcQP
         eR7mV1f9aB4YyaNI/cXif1iyCvsi0oefl5GLkVeJa+1HfKDMJvRnuFE13bO6Nn2cLIqu
         q8BiaT69e6ml/Jf4GQUdB53qaB42OGQWfIbJu3c27Jrqc7I4gb1OqlQ9TLNBWVDQVJEX
         pYifekl7N9ycsHzXzLvKp7BpQBQilAP6en943SELLM3RN1fYVHPmdTYdBUxcRICsAQSS
         U6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jjKb6TirPKLhfcVq5PbTY6uNTrlTo2aZTAUnFsk8e9o=;
        b=txl8efgiJJOPMluW6+bXoUys5LOxy5GjHp7yZXQ9mlEhUwqyknfIWbS3ZhuTW2OasT
         pWz9sKdmYSVnAs3UTYky1rRvvEJ8E4AQoa4qZQz67PDKnDm9t4DhvK7XNw7BZ/eJFGl7
         kcmLRG6Zb6nwSZNMotxh4ok9FBsAafFE3vb4Yv+Sn4SPP36thxuhqRQsvvbhpM9jEZiv
         KNNqb/atWp0FJmV7O9vKj33//2IQFqGRIXz2spU7Gxcqg7ZzXzZ05CSQh5Q0APmkDZyD
         C4CYBNdlh5jFHatwlFHZc+9WzLdDwicPLEIVEE5OSYN9uIDaWAIiPAago1j4sc/R0ogT
         Aj1w==
X-Gm-Message-State: AJIora8xUSVXNFqGI2Ko+QRDNFHpUWAcmoxos8u3pVp0pCetWhth6iZr
        VSl0OyVUPkhXQZ7y+WkSwiNKWsbL8kEo2g==
X-Google-Smtp-Source: AGRyM1vHIs+Q5jtJBeSb2uKD7SbdHQP7NnozekPkq7oLaAk3LCP7dkuOK6pDebC/ykSt4QS2YlhkgQ==
X-Received: by 2002:a63:6984:0:b0:40d:9ebe:5733 with SMTP id e126-20020a636984000000b0040d9ebe5733mr11132265pgc.170.1658755999384;
        Mon, 25 Jul 2022 06:33:19 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:33:19 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 23/24] can: peak_canfd: advertise timestamping capabilities and add ioctl support
Date:   Mon, 25 Jul 2022 22:32:07 +0900
Message-Id: <20220725133208.432176-24-mailhol.vincent@wanadoo.fr>
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
 drivers/net/can/peak_canfd/peak_canfd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 9b94d5b4be2d..b0915cc80cc8 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -746,6 +746,7 @@ static netdev_tx_t peak_canfd_start_xmit(struct sk_buff *skb,
 static const struct net_device_ops peak_canfd_netdev_ops = {
 	.ndo_open = peak_canfd_open,
 	.ndo_stop = peak_canfd_close,
+	.ndo_eth_ioctl = can_eth_ioctl_hwts,
 	.ndo_start_xmit = peak_canfd_start_xmit,
 	.ndo_change_mtu = can_change_mtu,
 };
@@ -758,6 +759,7 @@ static void peak_canfd_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops peak_canfd_ethtool_ops = {
 	.get_drvinfo = peak_canfd_get_drvinfo,
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
 
 struct net_device *alloc_peak_canfd_dev(int sizeof_priv, int index,
-- 
2.35.1

