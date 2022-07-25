Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4468757FFFF
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbiGYNd3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbiGYNdY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:33:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5680E0BB
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n10-20020a17090a670a00b001f22ebae50aso10295326pjj.3
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Rj1+qLgX9PKJlGGql5VxIx3n29BZXPRUS2TXJB5cxU=;
        b=O1Mxob14yRwQ2vGDZJECSHuCb+z6kuBp/2v3uQh42inMlwVpY/Vj+5Vtm0nIyavWRj
         4dOrapJ28hj268MBAUqOHoiL8hExl6Io/tDr/4yHoErk6v+1eH1KPc2/mSpqkVUB/acn
         n2LiDUaKLq9WnG5NFmxPQvGd5bSUeQftrIve75ZV0WSGYdiElB+FbgHIk+aVi0J5p/3r
         DJbmzTL/ua2iHIAQkGH0Lu+s3rFPYSj/vcLjfG0hcKNy9AkCCqwWQV4UZm1GmFm+Jbof
         sFGkzi+uGAZhcDqHAtJ4XzFgtaRdXYvs1hR4Mfq8sGcIRfabHQQkoqY33Vlzdd0L3SIX
         vlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/Rj1+qLgX9PKJlGGql5VxIx3n29BZXPRUS2TXJB5cxU=;
        b=u/77m6uQ+i8byNpOEgVTfXemTUdqKB3Rl37FMZOMCWBmahacb3Vvz1ohCkbXpieCzI
         v5VsQNlyzu4d/N1EtCkztR1+oxvNln1BreI9OPvMRIRzNVL0vKy7tqIGrLmoiJweJ4JQ
         YmMdDBERU+Fb/PRpGqnAHmQjkqIQr9qqnSyRBaLEGAis0zxRhgEF2A8qRNg4eqAB3yhM
         v9MecCZ3UthN+6tneUMlsFFKzayKZhermRDa66HXAShHq3ppSQMrAzC4vxmPrrwLFJi3
         5UaRxHeXY7vnU5Tgy0Ob89c5oOg0oSw+eiTBAY+FvxYymfGSdt7DZvd5ix98BPTW6Vvg
         k1JQ==
X-Gm-Message-State: AJIora+YS/imzTTW8Uvy/+dQj5J23GEqDjrcMMb2pccHXoH2TVNje60q
        36TJO/lfWYzGeuPwNSJsw2IwMXrvYVSyfg==
X-Google-Smtp-Source: AGRyM1vK0OXq0YzgsE/TVfx1rV+A+7NVPKjh5parrUebNY9TJR9X5iFEFdr7GnDhpxx1ZGF4oQ2uDA==
X-Received: by 2002:a17:90b:380c:b0:1f2:460a:2b30 with SMTP id mq12-20020a17090b380c00b001f2460a2b30mr19772233pjb.103.1658755994978;
        Mon, 25 Jul 2022 06:33:14 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:33:14 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 21/24] can: kvaser_pciefd: advertise timestamping capabilities and add ioctl support
Date:   Mon, 25 Jul 2022 22:32:05 +0900
Message-Id: <20220725133208.432176-22-mailhol.vincent@wanadoo.fr>
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
are supported by the kvaser_pciefd driver (aside maybe of getting RX
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

CC: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/kvaser_pciefd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index f7f7a0287a8d..2109f904b052 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -920,6 +920,7 @@ static void kvaser_pciefd_bec_poll_timer(struct timer_list *data)
 static const struct net_device_ops kvaser_pciefd_netdev_ops = {
 	.ndo_open = kvaser_pciefd_open,
 	.ndo_stop = kvaser_pciefd_stop,
+	.ndo_eth_ioctl = can_eth_ioctl_hwts,
 	.ndo_start_xmit = kvaser_pciefd_start_xmit,
 	.ndo_change_mtu = can_change_mtu,
 };
@@ -932,6 +933,7 @@ static void kvaser_pciefd_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops kvaser_pciefd_ethtool_ops = {
 	.get_drvinfo = kvaser_pciefd_get_drvinfo,
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
 
 static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
-- 
2.35.1

