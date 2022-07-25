Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D108E58024C
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiGYPyd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiGYPyb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:54:31 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140D412745
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:29 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f11so10737841pgj.7
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mQ1sc4CN4pgYuLfnf1+74hlbDE6JwtC78DbNTmDYVt8=;
        b=cz4agYxAL3lhFRQphB5zq9W9ThdUa/0JEpkxu6baN5xqLukHT0S6H2NEyF7QzGuPWa
         meloANjcimBpNG/OrpirCVGNbGP8Xv8I8V9GLWQF+RJRAvh2prRqMIwPCpDF2h+RxwCE
         /EP4eFrF8eWzAVozCo8fdRxzRXsY6mgi2IVJvK/16vbTWPaCSqQ8Ew6EHNDCRqF7OzP0
         s9p6IFnMO3IVFKXtk1xEDjhyZDzpOlVzHpE3NQ5DDfZb8g7gLCcWfMyLO8LvlmyrYOIl
         oAP5lHZZidmbrRWL4T91X0aBAzVqw6iEQfuJXGAheKw0SxzXl8wBEY8xZtNan19rc5LF
         G6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mQ1sc4CN4pgYuLfnf1+74hlbDE6JwtC78DbNTmDYVt8=;
        b=0R1xYuo0sGexxz9BRHiutqOHvgJqZZKySs20M/Yrw5FwB77zfPCQqCElje2+hXAcCr
         0yapgH/mb3+EVJEqZzRx0hc46pGCWpEpFDL6t7osZDIsEpjZyb1P2Cmrp5GNXeye7F3d
         PCCrOB7IysrRgBBABSSu23XtHUHCA0g3dTdfbLHxmdL+TyRPZTFSM2mGKAbEjwVBKSmb
         MEqDIwLen+eS6wpf5uL2Kj0APbMY3uIyroFcygXdmh5xbDvdLoyz/GOsb8aDomjIK5Pp
         tQDN8r+lHSXW3y/MgWYfEJ7Bj+VsK78+JWMWwA7DIDasYSZ1UpLPYaAfbl7tBQP4VrNc
         mJMQ==
X-Gm-Message-State: AJIora/fXb9SWSs+ZSUdqlnO/lt9HLPqJ7J7okF+cohkf5bzhSu+3cI9
        FH4dZCqNVuYNnEEqRfipPSdWnuvU684cIQ==
X-Google-Smtp-Source: AGRyM1tLQ6rEpvppGVmun3tCtx6dl4S3P4JpEfgd/KFnwcj5zOMozgYr7eCIOEQql2WemJUgwrW3IA==
X-Received: by 2002:a05:6a00:27a6:b0:52a:e089:e777 with SMTP id bd38-20020a056a0027a600b0052ae089e777mr13600976pfb.53.1658764469021;
        Mon, 25 Jul 2022 08:54:29 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b0016d692ff95esm3511296plr.133.2022.07.25.08.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:54:28 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 09/14] can: mcp251xfd: advertise timestamping capabilities and add ioctl support
Date:   Tue, 26 Jul 2022 00:53:49 +0900
Message-Id: <20220725155354.482986-10-mailhol.vincent@wanadoo.fr>
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
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 7fc86ed405c6..5cd2c296d1c9 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -16,6 +16,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/ethtool.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
@@ -1671,9 +1672,14 @@ static const struct net_device_ops mcp251xfd_netdev_ops = {
 	.ndo_open = mcp251xfd_open,
 	.ndo_stop = mcp251xfd_stop,
 	.ndo_start_xmit	= mcp251xfd_start_xmit,
+	.ndo_eth_ioctl = can_eth_ioctl_hwts,
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static const struct ethtool_ops mcp251xfd_ethtool_ops = {
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
+};
+
 static void
 mcp251xfd_register_quirks(struct mcp251xfd_priv *priv)
 {
@@ -2050,6 +2056,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	SET_NETDEV_DEV(ndev, &spi->dev);
 
 	ndev->netdev_ops = &mcp251xfd_netdev_ops;
+	ndev->ethtool_ops = &mcp251xfd_ethtool_ops;
 	ndev->irq = spi->irq;
 	ndev->flags |= IFF_ECHO;
 
-- 
2.35.1

