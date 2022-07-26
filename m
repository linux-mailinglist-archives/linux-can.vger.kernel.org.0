Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A733E581116
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 12:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiGZKZq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 06:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238240AbiGZKZo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 06:25:44 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D98E221
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:43 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id r8so4547739plh.8
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LMdZm/OPCrLt/1vfaRKLNUwgE88ZWLQZ7TTBYd562hU=;
        b=YLfL2iNZuGP4kMUjUXc1zvLoe9iM8/tC+VeCiW8EvP/8e7ujGU/6rD4xTKhbfbB7oN
         V/wh1kmXPjf+1U76VIJAkUlHIR/mjYmGsS3UHPguKzmCo+U9mZmIjWzSoqTR4pwpxgZn
         xaVQgVQht9DPo00irwEmxjfTZ7Ueg5YwLkSLx6TCakjjbRUGr6fC+80+//LGfhl0uz5V
         48vstFbi9b1hEXUrdn9hOetvL1AY+NTNsllJR6/foKo28FLB3+jL8ZOCa8nnVzI4Y7W3
         LMmisaW4VI26VhkBAyvohpZl82ALOpdlObTapV8C+OUiPpQVDjVyRg9mcMW0uAuHRLAx
         yfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LMdZm/OPCrLt/1vfaRKLNUwgE88ZWLQZ7TTBYd562hU=;
        b=NHWz5jJIn11zqXkXw+DEfYp2fOG1Y5bCkbQxcvD00hPPXqOSNRGpgbofMgcUOTMjxd
         SKpf1yINpK7r0sCJJAJxFdGpXvJ7dnJwQn2lon2FRw94X2Xd9kdiiKJKCf1d6Yxa2rI6
         rQ0HqOEt0p0yChH2JZ5of1jWt1z8VzNvY6nyuGJCgCr/Idstoi3VR0Fq8rlUXXxOthzS
         aeC8d2EtsvPFMrgf2barZ06n3ZiLr532B0wMwryHAr94xVjjoSIoKdPGN+Z7t/Hp59JX
         MJtQk+q96jqOW59aro1b/W+yFkh8HVp1CYZDACph6nXsfOkVYQ28cnrdkQdcpciy4UvR
         ARYQ==
X-Gm-Message-State: AJIora+iAAHPo03tYk+SCX1IEt2n5Rp3mk/Mm/ztY5sJpjt581uz94pr
        s4hC98nXfrZJCruE1BxcYoK9OYtaptXtjw==
X-Google-Smtp-Source: AGRyM1uTLHOipLvXBNUIKQRt94O4O9N+1xHytA4XGZOtFl88GFB49y3VX3nrJKw5ys7zTQtE9TKBZQ==
X-Received: by 2002:a17:90b:2c02:b0:1f2:fdb2:dc23 with SMTP id rv2-20020a17090b2c0200b001f2fdb2dc23mr544689pjb.182.1658831143054;
        Tue, 26 Jul 2022 03:25:43 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id y6-20020a655b46000000b00411bbcdfbf7sm9869894pgr.87.2022.07.26.03.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:25:42 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 09/14] can: mcp251xfd: advertise timestamping capabilities and add ioctl support
Date:   Tue, 26 Jul 2022 19:24:49 +0900
Message-Id: <20220726102454.95096-10-mailhol.vincent@wanadoo.fr>
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

Currently, userland has no methods to query which timestamping
features are supported by the mcp251xfd driver (aside maybe of getting
RX messages and obseverse whether or not hardware timestamps stay at
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

