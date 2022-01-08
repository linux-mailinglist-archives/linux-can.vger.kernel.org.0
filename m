Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2842C488551
	for <lists+linux-can@lfdr.de>; Sat,  8 Jan 2022 19:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiAHSQp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 8 Jan 2022 13:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiAHSQo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 8 Jan 2022 13:16:44 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17DCC06173F
        for <linux-can@vger.kernel.org>; Sat,  8 Jan 2022 10:16:39 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id k15so35420196edk.13
        for <linux-can@vger.kernel.org>; Sat, 08 Jan 2022 10:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4VShwSPVfj7GfXP2tBCw17qNbBXH8y4PIVu4DylC+Yk=;
        b=deXjQd7iwt9NyWs3LiY3Y9oI7jXD9KYC0IAF+0hRTqNmUO46HyW8ILfoOLGfgz//vh
         bCPBuxZGgnjzyrl2hGUk+zougES865YL10Wa9bFX33dyhBpICNXBvbv61Ex2fXGdTLOW
         js2nQ8zOWSmp/Ib607pVKzFkn2YJ6TnrNafCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4VShwSPVfj7GfXP2tBCw17qNbBXH8y4PIVu4DylC+Yk=;
        b=sjqRdCvZJKvH68EQUxKMN3MJb0+s4n33SaeP4H0ACgk9aiuDSbDxEjhR8YovorIuAc
         fn0C7DAd5BgznDeXs+WFlRGfhCHYu8nmLalqvZGSQgH3rCOduB9i4OEQkQ0Z3p+fGKoT
         5/fc7I12PCXnbKPVOe7A+yPgl4AYpDXtpo90sbpUPjizRF39wHb+IwzlGfy2CTrjhY4a
         OKzpfcWHHHMBozpPgCM2pGxcqDxHsUoBAFEWpN0VgTVmE3RH4Ah7nBpKCJFDrHXzIkJa
         KcBvsdvSFFEJh31UqYwSObW0mb77Au6NomnLQ4t1m4EfnMjmug+JTV7yHxoMoQIP2E0y
         ownQ==
X-Gm-Message-State: AOAM530bcGWZ4tuP9zMzQlHieTv3A3WLVnHOQJIKmDFbT2D1Dva13TgC
        dv2b+rS3/SEwjv08hwYeKih3gw==
X-Google-Smtp-Source: ABdhPJwV7uU0oXOSs+GBb8Le/beFcuoTyG5jHEtbobZSHjJAhyGtEFElIRca3PoA1E/tV1K+/Oy+rA==
X-Received: by 2002:a17:906:6c1:: with SMTP id v1mr51856789ejb.638.1641665798545;
        Sat, 08 Jan 2022 10:16:38 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-244-92-231.retail.telecomitalia.it. [95.244.92.231])
        by smtp.gmail.com with ESMTPSA id cm12sm1016616edb.6.2022.01.08.10.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 10:16:38 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC PATCH] can: flexcan: add ethtool support to get rx/tx ring parameters
Date:   Sat,  8 Jan 2022 19:16:33 +0100
Message-Id: <20220108181633.420433-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Adds ethtool support to get the number of message buffers configured for
reception/transmission, which may also depends on runtime configurations
such as the 'rx-rtr' flag state.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/net/can/flexcan/flexcan-ethtool.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-ethtool.c b/drivers/net/can/flexcan/flexcan-ethtool.c
index 5bb45653e1ac..d119bca584f6 100644
--- a/drivers/net/can/flexcan/flexcan-ethtool.c
+++ b/drivers/net/can/flexcan/flexcan-ethtool.c
@@ -80,7 +80,24 @@ static int flexcan_set_priv_flags(struct net_device *ndev, u32 priv_flags)
 	return 0;
 }
 
+static void flexcan_get_ringparam(struct net_device *ndev,
+				  struct ethtool_ringparam *ring)
+{
+	struct flexcan_priv *priv = netdev_priv(ndev);
+
+	ring->rx_max_pending = priv->mb_count;
+	ring->tx_max_pending = priv->mb_count;
+
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX)
+		ring->rx_pending = __sw_hweight64(priv->rx_mask);
+	else
+		ring->rx_pending = 6;
+
+	ring->tx_pending = __sw_hweight64(priv->tx_mask);
+}
+
 static const struct ethtool_ops flexcan_ethtool_ops = {
+	.get_ringparam = flexcan_get_ringparam,
 	.get_sset_count = flexcan_get_sset_count,
 	.get_strings = flexcan_get_strings,
 	.get_priv_flags = flexcan_get_priv_flags,
-- 
2.32.0

