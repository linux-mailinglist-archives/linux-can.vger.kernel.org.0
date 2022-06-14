Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6035754B0C2
	for <lists+linux-can@lfdr.de>; Tue, 14 Jun 2022 14:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357124AbiFNMbI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 14 Jun 2022 08:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243929AbiFNM2m (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 14 Jun 2022 08:28:42 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5845C22B1A
        for <linux-can@vger.kernel.org>; Tue, 14 Jun 2022 05:28:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x62so11387354ede.10
        for <linux-can@vger.kernel.org>; Tue, 14 Jun 2022 05:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XeYjdn9a4I+7ASW7s8Y7GsWrvaBO3fcqP0UZzQUkPdo=;
        b=JNHe/Rd3xGFz9IInBG2Hy0Pm2d3MVvP+X4Wukoxvlf641EooQhKNJ+NakxVF5Wom78
         xZoN3RMIeNIooYOLeQOlAVAfBHjnR6ybL4+SfBzywFTS5ovnLDscFB9uHC23pcSfSpmC
         6VGkJP6AkNy6mtmkdiNqzOqpyBXILnvebwLHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XeYjdn9a4I+7ASW7s8Y7GsWrvaBO3fcqP0UZzQUkPdo=;
        b=a9xomqxXusIebbJUkPNDa6z4CPSpGGvbqsmZxLOauQjDu8D2lPcdXfaNHOfPBWTZWt
         aOqv5phy7mOQxcVGtzK+tv514G8lFrXeHwljyGdDtiD23Vr1VH8TbQgEg32jCgR0Qpq6
         6gZ32JaKq2Zaxxv4iPLpWsBFANcvhI3pRjRKN5U8eYxyKAyJHqW1XOtf/UVJLwZ9vhe+
         g6XmTYD/z1FOH9tk97VFg1zTD09l2FK0/3zuFdvPKq29xOFYYqQ9CPQLO6kz2kCkfrEI
         DVSuQAipQM+51qtcOSTs/axGxXBAc08vEPoE60WkXoJ7juMc2hEyNRnK5aCRI/l33WzC
         /Hyg==
X-Gm-Message-State: AJIora87s8sKcXyhXm0qv4NV80NorIl+J/lw13Ikz3li1oytfGtY9/ju
        GgUdlQxA4uiekFN5eIdqoinJIg==
X-Google-Smtp-Source: ABdhPJyXdIRsXaLQQbGAQxvvELqbNihj8OdARByvUWbMOXO5BG5Gde1mUlfk/7MdRUD+koVfnaRC7w==
X-Received: by 2002:a05:6402:2381:b0:42d:c8fe:d7fe with SMTP id j1-20020a056402238100b0042dc8fed7femr5766685eda.248.1655209719900;
        Tue, 14 Jun 2022 05:28:39 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090655d600b006f3ef214e2csm5087043ejp.146.2022.06.14.05.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 05:28:39 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v4 10/12] can: slcan: add ethtool support to reset adapter errors
Date:   Tue, 14 Jun 2022 14:28:19 +0200
Message-Id: <20220614122821.3646071-11-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220614122821.3646071-1-dario.binacchi@amarulasolutions.com>
References: <20220614122821.3646071-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds a private flag to the slcan driver to switch the
"err-rst-on-open" setting on and off.

"err-rst-on-open" on  - Reset error states on opening command

"err-rst-on-open" off - Don't reset error states on opening command
                        (default)

The setting can only be changed if the interface is down:

    ip link set dev can0 down
    ethtool --set-priv-flags can0 err-rst-on-open {off|on}
    ip link set dev can0 up

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/net/can/slcan/Makefile        |  1 +
 drivers/net/can/slcan/slcan-core.c    | 36 +++++++++++++++
 drivers/net/can/slcan/slcan-ethtool.c | 65 +++++++++++++++++++++++++++
 drivers/net/can/slcan/slcan.h         | 18 ++++++++
 4 files changed, 120 insertions(+)
 create mode 100644 drivers/net/can/slcan/slcan-ethtool.c
 create mode 100644 drivers/net/can/slcan/slcan.h

diff --git a/drivers/net/can/slcan/Makefile b/drivers/net/can/slcan/Makefile
index 2e84f7bf7617..8a88e484ee21 100644
--- a/drivers/net/can/slcan/Makefile
+++ b/drivers/net/can/slcan/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_CAN_SLCAN) += slcan.o
 
 slcan-objs :=
 slcan-objs += slcan-core.o
+slcan-objs += slcan-ethtool.o
diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index b08e63f59b8e..b4f29ab2ab72 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -57,6 +57,8 @@
 #include <linux/can/dev.h>
 #include <linux/can/skb.h>
 
+#include "slcan.h"
+
 MODULE_ALIAS_LDISC(N_SLCAN);
 MODULE_DESCRIPTION("serial line CAN interface");
 MODULE_LICENSE("GPL");
@@ -98,6 +100,8 @@ struct slcan {
 #define SLF_INUSE		0		/* Channel in use            */
 #define SLF_ERROR		1               /* Parity, etc. error        */
 #define SLF_XCMD		2               /* Command transmission      */
+	unsigned long           cmd_flags;      /* Command flags             */
+#define CF_ERR_RST		0               /* Reset errors on open      */
 	wait_queue_head_t       xcmd_wait;      /* Wait queue for commands   */
 						/* transmission              */
 };
@@ -110,6 +114,28 @@ static const u32 slcan_bitrate_const[] = {
 	250000, 500000, 800000, 1000000
 };
 
+bool slcan_err_rst_on_open(struct net_device *ndev)
+{
+	struct slcan *sl = netdev_priv(ndev);
+
+	return !!test_bit(CF_ERR_RST, &sl->cmd_flags);
+}
+
+int slcan_enable_err_rst_on_open(struct net_device *ndev, bool on)
+{
+	struct slcan *sl = netdev_priv(ndev);
+
+	if (netif_running(ndev))
+		return -EBUSY;
+
+	if (on)
+		set_bit(CF_ERR_RST, &sl->cmd_flags);
+	else
+		clear_bit(CF_ERR_RST, &sl->cmd_flags);
+
+	return 0;
+}
+
  /************************************************************************
   *			SLCAN ENCAPSULATION FORMAT			 *
   ************************************************************************/
@@ -511,6 +537,15 @@ static int slc_open(struct net_device *dev)
 			goto cmd_transmit_failed;
 		}
 
+		if (test_bit(CF_ERR_RST, &sl->cmd_flags)) {
+			err = slcan_transmit_cmd(sl, "F\r");
+			if (err) {
+				netdev_err(dev,
+					   "failed to send error command 'F\\r'\n");
+				goto cmd_transmit_failed;
+			}
+		}
+
 		err = slcan_transmit_cmd(sl, "O\r");
 		if (err) {
 			netdev_err(dev, "failed to send open command 'O\\r'\n");
@@ -630,6 +665,7 @@ static struct slcan *slc_alloc(void)
 	snprintf(dev->name, sizeof(dev->name), "slcan%d", i);
 	dev->netdev_ops = &slc_netdev_ops;
 	dev->base_addr  = i;
+	slcan_set_ethtool_ops(dev);
 	sl = netdev_priv(dev);
 
 	/* Initialize channel control data */
diff --git a/drivers/net/can/slcan/slcan-ethtool.c b/drivers/net/can/slcan/slcan-ethtool.c
new file mode 100644
index 000000000000..bf0afdc4e49d
--- /dev/null
+++ b/drivers/net/can/slcan/slcan-ethtool.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2022 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ *
+ */
+
+#include <linux/can/dev.h>
+#include <linux/ethtool.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+
+#include "slcan.h"
+
+static const char slcan_priv_flags_strings[][ETH_GSTRING_LEN] = {
+#define SLCAN_PRIV_FLAGS_ERR_RST_ON_OPEN BIT(0)
+	"err-rst-on-open",
+};
+
+static void slcan_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
+{
+	switch (stringset) {
+	case ETH_SS_PRIV_FLAGS:
+		memcpy(data, slcan_priv_flags_strings,
+		       sizeof(slcan_priv_flags_strings));
+	}
+}
+
+static u32 slcan_get_priv_flags(struct net_device *ndev)
+{
+	u32 flags = 0;
+
+	if (slcan_err_rst_on_open(ndev))
+		flags |= SLCAN_PRIV_FLAGS_ERR_RST_ON_OPEN;
+
+	return flags;
+}
+
+static int slcan_set_priv_flags(struct net_device *ndev, u32 flags)
+{
+	bool err_rst_op_open = !!(flags & SLCAN_PRIV_FLAGS_ERR_RST_ON_OPEN);
+
+	return slcan_enable_err_rst_on_open(ndev, err_rst_op_open);
+}
+
+static int slcan_get_sset_count(struct net_device *netdev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_PRIV_FLAGS:
+		return ARRAY_SIZE(slcan_priv_flags_strings);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct ethtool_ops slcan_ethtool_ops = {
+	.get_strings = slcan_get_strings,
+	.get_priv_flags = slcan_get_priv_flags,
+	.set_priv_flags = slcan_set_priv_flags,
+	.get_sset_count = slcan_get_sset_count,
+};
+
+void slcan_set_ethtool_ops(struct net_device *netdev)
+{
+	netdev->ethtool_ops = &slcan_ethtool_ops;
+}
diff --git a/drivers/net/can/slcan/slcan.h b/drivers/net/can/slcan/slcan.h
new file mode 100644
index 000000000000..d463c8d99e22
--- /dev/null
+++ b/drivers/net/can/slcan/slcan.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * slcan.h - serial line CAN interface driver
+ *
+ * Copyright (C) Laurence Culhane <loz@holmes.demon.co.uk>
+ * Copyright (C) Fred N. van Kempen <waltje@uwalt.nl.mugnet.org>
+ * Copyright (C) Oliver Hartkopp <socketcan@hartkopp.net>
+ * Copyright (C) 2022 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ *
+ */
+
+#ifndef _SLCAN_H
+#define _SLCAN_H
+
+bool slcan_err_rst_on_open(struct net_device *ndev);
+int slcan_enable_err_rst_on_open(struct net_device *ndev, bool on);
+void slcan_set_ethtool_ops(struct net_device *ndev);
+
+#endif /* _SLCAN_H */
-- 
2.32.0

