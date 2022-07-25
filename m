Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B376657FFFB
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbiGYNdX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbiGYNdS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:33:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EB613F60
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q43-20020a17090a17ae00b001f1f67e053cso10284931pja.4
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w7IlGxqZgIq+Cp3tlkA2p8aXUNQbxCg5YzQR5bI1YWE=;
        b=myWO05lkzo45ymzPXW8rHxXScYcRWooV43V8kSc+7UykLDAi1bL0nfwOWg0emKoSoL
         9mFpuj5DSyzWWnhH+aRphZsQn6YdRfRslO44z0/BQswhsjGP6U3/a0RxuPzCSiShQh0z
         +lfJ2E9mQgp4z+Z26Fb8QWaX2j0i8ZJXWHw+hj2ohgDXJ2CQFiyhEWCkyB+b1nSVkJMN
         sYMzhTW3wHOV8i0fxLptd9i2t9iR4TkHikwMaKftezqAKoym9reR/PTfe/O1qW81zu3g
         CEqdpfSaS3P5CcsZHWkEeX4hGTZ8blYaG2oZPvtqbpSa/ZSZdibQ2OdNW/a3cANn4ouS
         u18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=w7IlGxqZgIq+Cp3tlkA2p8aXUNQbxCg5YzQR5bI1YWE=;
        b=EcmgWE3VRV6D36bADYc9waunY/PQCUX8ygQwaE+vGhQwbmfzmCCuiY6UxbYFDgZMcL
         jcV/Izs7a4b3iSZnA3OOLni70MgQwKsuUObOtm3k/mgbMusPu7CtDPy3s2FehvkKXBI0
         632opRI8Hr6UcZKYu6rR+vX5xbIRcb4cpfkyL0qp5rZrZbQggBOaSVjKSXGMZ/PeHpJy
         nH2Yfy4EjPiSHXmGxnhu1xWaPwyOSSRL/9If4TmQuZUTRp1J0ro/2EK5j4JKESVZA5Bi
         HRYBdN7lN8l9jz2WOGcPz6Bn2DuI7YRsHzHG7BFaARcN8hts1+g41KITsSvMZozYXofR
         UCLg==
X-Gm-Message-State: AJIora8BUj01Gk9HThLIiY/ntUtkttaJL5Np+NZiPLaKatYjTNNbLg4C
        oQpt3R2xsGpknnsQhMxplgMuvCWc29IImA==
X-Google-Smtp-Source: AGRyM1sY1CMAmLZmOVRXkC1E9O6kqZagjvOCd72zTjgvllI0q+XLYk4hm/5OXozBmrmJm9vSF/N8Lw==
X-Received: by 2002:a17:90b:38c5:b0:1ef:a7ad:ebb9 with SMTP id nn5-20020a17090b38c500b001efa7adebb9mr33351070pjb.110.1658755988556;
        Mon, 25 Jul 2022 06:33:08 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:33:08 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 18/24] can: dev: add generic function can_eth_ioctl_hwts()
Date:   Mon, 25 Jul 2022 22:32:02 +0900
Message-Id: <20220725133208.432176-19-mailhol.vincent@wanadoo.fr>
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

Tools based on libpcap (such as tcpdump) expect the SIOCSHWTSTAMP
ioctl call to be supported. This is also specified in the kernel doc
[1]. The purpose of this ioctl is to toggle the hardware timestamps.

Currently, CAN devices which support hardware timestamping have those
always activated. can_eth_ioctl_hwts() is a dumb function that will
always succeed when requested to set tx_type to HWTSTAMP_TX_ON or
rx_filter to HWTSTAMP_FILTER_ALL.

[1] Kernel doc: Timestamping, section 3.1 "Hardware Timestamping
Implementation: Device Drivers"
Link: https://docs.kernel.org/networking/timestamping.html#hardware-timestamping-implementation-device-drivers

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/dev.c | 29 +++++++++++++++++++++++++++++
 include/linux/can/dev.h   |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 7ad56d31cec9..750dc7cae9d4 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -322,6 +322,35 @@ int can_change_mtu(struct net_device *dev, int new_mtu)
 }
 EXPORT_SYMBOL_GPL(can_change_mtu);
 
+/* generic implementation of netdev_ops::ndo_eth_ioctl for CAN devices
+ * supporting hardware RX timestamps
+ */
+int can_eth_ioctl_hwts(struct net_device *netdev, struct ifreq *ifr, int cmd)
+{
+	struct hwtstamp_config hwts_cfg = { 0 };
+
+	switch (cmd) {
+	case SIOCSHWTSTAMP: /* set */
+		if (copy_from_user(&hwts_cfg, ifr->ifr_data, sizeof(hwts_cfg)))
+			return -EFAULT;
+		if (hwts_cfg.tx_type == HWTSTAMP_TX_ON &&
+		    hwts_cfg.rx_filter == HWTSTAMP_FILTER_ALL)
+			return 0;
+		return -ERANGE;
+
+	case SIOCGHWTSTAMP: /* get */
+		hwts_cfg.tx_type = HWTSTAMP_TX_ON;
+		hwts_cfg.rx_filter = HWTSTAMP_FILTER_ALL;
+		if (copy_to_user(ifr->ifr_data, &hwts_cfg, sizeof(hwts_cfg)))
+			return -EFAULT;
+		return 0;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+EXPORT_SYMBOL(can_eth_ioctl_hwts);
+
 /* generic implementation of ethtool_ops::get_ts_info for CAN devices
  * supporting hardware RX timestamps
  */
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 752bd45d8ebf..c3e50e537e39 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -163,6 +163,7 @@ struct can_priv *safe_candev_priv(struct net_device *dev);
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
 int can_change_mtu(struct net_device *dev, int new_mtu);
+int can_eth_ioctl_hwts(struct net_device *netdev, struct ifreq *ifr, int cmd);
 int can_ethtool_op_get_ts_info_hwts(struct net_device *dev,
 				    struct ethtool_ts_info *info);
 
-- 
2.35.1

