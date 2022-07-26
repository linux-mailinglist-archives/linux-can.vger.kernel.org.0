Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF1D581115
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 12:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiGZKZo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 06:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiGZKZm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 06:25:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBADB7D6
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f11-20020a17090a4a8b00b001f2f7e32d03so708465pjh.0
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r5Txqu8QqXk1j94Vu9ZhuEySdqC2ZrZ0pryhl2/h6u4=;
        b=OratSyFjs8lguRMoLLR/6XbSIus3l89GNJQCnkMhiNE+yEq26tSWrhPDxGDuy1RrjV
         CY49k6KBT3flryi3LiyMQLt8rPS39DkKFNr9aqLftTTAArPXtwJrHqbbVI+DnpGzPAgx
         +yF3Bak1XL0x/itHSBsGme/5kx5Y7ARJYCHLUvSBhBIaC4GMquMNuy1alLHDkjQwk4ax
         DFTZbjqhlt3u1tqMMmruNIXx3SDIW5Be4w4yDZk9QwkvyTokBShm2bC+SyG4jfxLi/BE
         uuwFRS3IIqKDWonYEq1+ovUADDomBPDFJWUPkjXL6KbBur2hf0RlnvEC2ok/hyrJrbOw
         QSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=r5Txqu8QqXk1j94Vu9ZhuEySdqC2ZrZ0pryhl2/h6u4=;
        b=2m21QRbm2PeK4mR2U4VqDLlRyL3gme58XQP1xwj5OYkkIe3WuNMU5hjdJu5LKC70oJ
         qp0UT/zh3dnr0IerIOI+zMct3cxtIpKpcSN5URx4lsScmkAwm+dmZR1DgIzNdN2ju3VF
         CFLGwqDDuS1dJMzE/PhSXdukAvsTL82fygeGsLxFB0Sc7qxrki2wqG2sc6H+mxPFySBh
         P6p3ohLkoS+IkNjgNxFlEWYCFS8Wjqhyt3moOB46a7vzjvuIjRY85q+tjCsg0LRgGiRr
         oZjV8Sd7gVbq/mBFfG9LTl7EEAbEXagJJzp039xWi9EVHYJIAURpD+f3kHlo9qNXZR4/
         bTBA==
X-Gm-Message-State: AJIora9sXewf+H/InX6H8K2FclYYrsf1ROg7zRD1tWGPOKUAA+wY96l+
        4fgOnfupkYrFM/3PrJ2uUGusfnyn9hfoyw==
X-Google-Smtp-Source: AGRyM1skROypJl4H5W6U7pAZrXQFzlFg9UbNSMIr/UHar5I5xshaS0HV8DVRlnKsBSDVVwlOsWb9hA==
X-Received: by 2002:a17:903:2311:b0:16d:9b91:9547 with SMTP id d17-20020a170903231100b0016d9b919547mr3002596plh.18.1658831140444;
        Tue, 26 Jul 2022 03:25:40 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id y6-20020a655b46000000b00411bbcdfbf7sm9869894pgr.87.2022.07.26.03.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:25:40 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 08/14] can: dev: add generic function can_eth_ioctl_hwts()
Date:   Tue, 26 Jul 2022 19:24:48 +0900
Message-Id: <20220726102454.95096-9-mailhol.vincent@wanadoo.fr>
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
index f307034ff4fd..c1956b1e9faf 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -322,6 +322,35 @@ int can_change_mtu(struct net_device *dev, int new_mtu)
 }
 EXPORT_SYMBOL_GPL(can_change_mtu);
 
+/* generic implementation of netdev_ops::ndo_eth_ioctl for CAN devices
+ * supporting hardware timestamps
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
  * supporting hardware timestamps
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

