Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B29E57FFFA
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiGYNdU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbiGYNdQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:33:16 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6220E13F8A
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id r8so2040487plh.8
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Du/pzGmqmfmfF4VKZCXX3QoxQcHpmPfz07SonHqEUh8=;
        b=FHhX4eEfXHWKwe7QJOXCaUlmmyaIh6CNFVHv4dyB/BDW7sfI5YBZJ4LxQugkZmgkPK
         jAYy4bf7in61+eRAAAo43Nuxw4GbRXdgC6NGIzmyY1LIeTDEZBxTNiIiAOzPiMPW3Qz2
         BNEvaAx7EZAxCNaG4Lhiad0Whu+xmGs96VnCdhvOc/peDFyyOyxtSjIn+s7P+nketIM0
         XJjpdRWygEH/R3G+mUdhKwJb8z+3t97SUnFWHEzq41tsd/wTURD+BLxn//0Vqyv9xLq0
         hNMXWTnRLG/qIAbRM/oEtlXCWu5u9iKWvpjMk2PTjFWe/K/5FK5kgTjm6dWP8/XoC4WP
         M2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Du/pzGmqmfmfF4VKZCXX3QoxQcHpmPfz07SonHqEUh8=;
        b=kEpVLNl3uzAaYm35Vt3gkYhzkgcarbA4BQNfb95MCUI6/gmDW5d9KvmX38P2SQsY6Z
         yhjfOrtUqwz7K8ewYoDF2j0IYoP6MpQE7Ps83Ckak40Pj70OUIjrl6Apa07KxpAhOeDG
         196hgRyAmaJwggRQerOI4q0vamcyXMd6J4KLXfuDvIFSmCa0iWa5toBZ4hWRBSUFk6bv
         SoXGm6Fk9p0QV5i2XgXCU+E8tGc5qSck//G1UkZqWkhQTH73etEZgJjuigolPg0zgPMO
         wgVoT1ixnRfk/2Mzmf06Z1aW6ZczsCknMaTfnIJ+tED4U75qlBWJnMLMeIpMUU7evzLM
         d1Mg==
X-Gm-Message-State: AJIora9TSlLsEBqXKMokDG63JytUqzI7tBsTc7KzIJmrMKeulKPiWS8D
        4jJjHnnaH5lbAkbVGt75k8gXBJ/jjSAkcQ==
X-Google-Smtp-Source: AGRyM1uitBBaTfwRPi3ReMfLoogYwRKYIOxGsBgIO2LrP7BUEVKz6qakHyZ9EnX9jG9vleSnOK57Sg==
X-Received: by 2002:a17:90a:f595:b0:1f2:336a:55b6 with SMTP id ct21-20020a17090af59500b001f2336a55b6mr14328291pjb.40.1658755990724;
        Mon, 25 Jul 2022 06:33:10 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:33:10 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 19/24] can: mcp251xfd: advertise timestamping capabilities and add ioctl support
Date:   Mon, 25 Jul 2022 22:32:03 +0900
Message-Id: <20220725133208.432176-20-mailhol.vincent@wanadoo.fr>
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
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index d9a7de1927d6..f3196c603459 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1672,6 +1672,7 @@ static const struct net_device_ops mcp251xfd_netdev_ops = {
 	.ndo_open = mcp251xfd_open,
 	.ndo_stop = mcp251xfd_stop,
 	.ndo_start_xmit	= mcp251xfd_start_xmit,
+	.ndo_eth_ioctl = can_eth_ioctl_hwts,
 	.ndo_change_mtu = can_change_mtu,
 };
 
@@ -1683,6 +1684,7 @@ static void mcp251xfd_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops mcp251xfd_ethtool_ops = {
 	.get_drvinfo = mcp251xfd_get_drvinfo,
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
 
 static void
-- 
2.35.1

