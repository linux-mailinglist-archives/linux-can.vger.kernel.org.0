Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB697575EC
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 09:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjGRH6N (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 03:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjGRH5r (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 03:57:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B07EE3
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 00:57:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3142a9ff6d8so5470023f8f.3
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 00:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689667037; x=1690271837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uatwJm2PlUSbozsbYna8OyygyVe3MwDeYyEPTgg8b48=;
        b=Arq8X2JsqAujk8hjNYLnTe/epbrHDgvZo3ZiX/ZkWCgJaBdc0rNjhlXmGkYHB9nWnV
         tPZ3CMz6qu/Qv9kBos6lqtfj9mwz4F3q5AFYfWIZeDxdZ9rB1u4O1DOFkieZwwK2k6QF
         cqMZZDEBqLTNRtyfCNqFyzrRJKLi1/xcp+Ac25+Tx94TO9PKR1A8NAI+0okXEmD+/Km1
         znZhUAgqe4qKLoESplgBuXwj7UicD2KVfJpkX/IiCAVKlwYxk/O9xGdosRMwEwAZSXiD
         Wo2TZamcViwYJty/cb8qbrRr86X3US5nToacvG9fW3XxLI7NBq/rZbqac07W0AZ9/1+Z
         CifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667037; x=1690271837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uatwJm2PlUSbozsbYna8OyygyVe3MwDeYyEPTgg8b48=;
        b=lrMN0uddBctOtvmBMUh/wMfVwp77qn97gwRHWLWcR1S2uTkBFi/y1dDzvu+Crn3ukg
         DrcpGtjZBV1bluolUVBtc2BcYjclbY6FhaudRu+LxPPoiahUbV323p5UK0EVXJFEk8u3
         r2TPCfB+/ezFO2mDhIENvbSx4YlzUx0sC2d4p8MhjHx8kdJtNIcd7nixKBgxta2Anoy/
         0yCHg2bCRf6T5M74i9XrikSDcExrOpi0i6zNKMZtNi+qmZrnc2uX9jKYO6k1FDjDYT41
         zqi041jQARSsgqD6TxZ3OPmkHoPitkqlcJ1qSUC5+Hlcu1umMGZstFvSbRhXh9L17dlQ
         6hNA==
X-Gm-Message-State: ABy/qLYnzr7pSf57l1uyQ6oN/lQQSjuqvX5qfobV5WVBXypbD+HXE2QY
        ox1voQggQOxgV9bFq6VdoPQcJQ==
X-Google-Smtp-Source: APBJJlFld5Dg1NigahHEH9yi70FfP7nkOB9K1hNSFdVmhncd3gHkZhJFq7w00hxQQ4KUe/h3gmbAkg==
X-Received: by 2002:a5d:6850:0:b0:314:53a4:2d3f with SMTP id o16-20020a5d6850000000b0031453a42d3fmr12703298wrw.63.1689667036932;
        Tue, 18 Jul 2023 00:57:16 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d54c4000000b003142439c7bcsm1585959wrv.80.2023.07.18.00.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:57:16 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v5 05/12] can: m_can: Add tx coalescing ethtool support
Date:   Tue, 18 Jul 2023 09:57:01 +0200
Message-Id: <20230718075708.958094-6-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230718075708.958094-1-msp@baylibre.com>
References: <20230718075708.958094-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add TX support to get/set functions for ethtool coalescing.
tx-frames-irq and tx-usecs-irq can only be set/unset together.
tx-frames-irq needs to be less than TXE and TXB.

As rx and tx share the same timer, rx-usecs-irq and tx-usecs-irq can be
enabled/disabled individually but they need to have the same value if
enabled.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 38 ++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index c19fc10a7645..6af5fa8c7eb3 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1952,6 +1952,8 @@ static int m_can_get_coalesce(struct net_device *dev,
 
 	ec->rx_max_coalesced_frames_irq = cdev->rx_max_coalesced_frames_irq;
 	ec->rx_coalesce_usecs_irq = cdev->rx_coalesce_usecs_irq;
+	ec->tx_max_coalesced_frames_irq = cdev->tx_max_coalesced_frames_irq;
+	ec->tx_coalesce_usecs_irq = cdev->tx_coalesce_usecs_irq;
 
 	return 0;
 }
@@ -1978,16 +1980,50 @@ static int m_can_set_coalesce(struct net_device *dev,
 		netdev_err(dev, "rx-frames-irq and rx-usecs-irq can only be set together\n");
 		return -EINVAL;
 	}
+	if (ec->tx_max_coalesced_frames_irq > cdev->mcfg[MRAM_TXE].num) {
+		netdev_err(dev, "tx-frames-irq %u greater than the TX event FIFO %u\n",
+			   ec->tx_max_coalesced_frames_irq,
+			   cdev->mcfg[MRAM_TXE].num);
+		return -EINVAL;
+	}
+	if (ec->tx_max_coalesced_frames_irq > cdev->mcfg[MRAM_TXB].num) {
+		netdev_err(dev, "tx-frames-irq %u greater than the TX FIFO %u\n",
+			   ec->tx_max_coalesced_frames_irq,
+			   cdev->mcfg[MRAM_TXB].num);
+		return -EINVAL;
+	}
+	if ((ec->tx_max_coalesced_frames_irq == 0) != (ec->tx_coalesce_usecs_irq == 0)) {
+		netdev_err(dev, "tx-frames-irq and tx-usecs-irq can only be set together\n");
+		return -EINVAL;
+	}
+	if (ec->rx_coalesce_usecs_irq != 0 && ec->tx_coalesce_usecs_irq != 0 &&
+	    ec->rx_coalesce_usecs_irq != ec->tx_coalesce_usecs_irq) {
+		netdev_err(dev, "rx-usecs-irq %u needs to be equal to tx-usecs-irq %u if both are enabled\n",
+			   ec->rx_coalesce_usecs_irq,
+			   ec->tx_coalesce_usecs_irq);
+		return -EINVAL;
+	}
 
 	cdev->rx_max_coalesced_frames_irq = ec->rx_max_coalesced_frames_irq;
 	cdev->rx_coalesce_usecs_irq = ec->rx_coalesce_usecs_irq;
+	cdev->tx_max_coalesced_frames_irq = ec->tx_max_coalesced_frames_irq;
+	cdev->tx_coalesce_usecs_irq = ec->tx_coalesce_usecs_irq;
+
+	if (cdev->rx_coalesce_usecs_irq)
+		cdev->irq_timer_wait =
+			ns_to_ktime(cdev->rx_coalesce_usecs_irq * NSEC_PER_USEC);
+	else
+		cdev->irq_timer_wait =
+			ns_to_ktime(cdev->tx_coalesce_usecs_irq * NSEC_PER_USEC);
 
 	return 0;
 }
 
 static const struct ethtool_ops m_can_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
-		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ,
+		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
+		ETHTOOL_COALESCE_TX_USECS_IRQ |
+		ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
 	.get_ts_info = ethtool_op_get_ts_info,
 	.get_coalesce = m_can_get_coalesce,
 	.set_coalesce = m_can_set_coalesce,
-- 
2.40.1

