Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50487581B85
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 23:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239832AbiGZVEH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 17:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239899AbiGZVDf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 17:03:35 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE6E3A484
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 14:03:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e15so19151478edj.2
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qy2wWA6vClyZGhjx9DWjei+yWAv7tqnCtNEo36hW/K4=;
        b=I6feiYwmbmUoz9RV4PxX4J5rNfVBlvt/FdVVUwAcY8gFd3MFHKy73+QR5pyYmEmlnt
         1zdPnnkJO+6MPYdENRqkZAicXR23cepCRnnLZbCLz3YXZjqzMZ2u3xd57Oz7KueBlHbQ
         6MjoTU1WRz4y0fu6I0WB2aTZ5/nnCQ4wL1SKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qy2wWA6vClyZGhjx9DWjei+yWAv7tqnCtNEo36hW/K4=;
        b=vpYVbV7CErKE/LTRAM4xs5FPfdsHPRIklehFfNOc4jER9F5+dWAvHXESHRI9wZxoZZ
         bKbjwiz+X+U7Awd1tGOqRFtaruzvrRPhXSI8IvBCQ4Gc54UuNp+/ZgdN1GxZ7tSPdKLc
         WUXw9qygWab3Xg0TPGFZP27qcKWq/NSg92yvJ5R18NrdQmkN/C+mdVIFJAZWJb8n6EDO
         7p5dUYqC2Ml7eO4ujjoU4XFOJaQEhXZ99564+fY/lQWTIAdXzkpAU1PJEbjWlcAlegka
         W454RIChjF+WZGlBZK4oCnzK65bhk7TBQRmXEiM23Bvmox0KhFUWz+/hHlFIqWX3GDQO
         3dmw==
X-Gm-Message-State: AJIora/+h0z2NFxSVUuHC5nhXg6WXz9C6QETcFy/Xh1OnOPYZKtQp0Sn
        4fbUZMKizXU14DFoqx3af6W+GA==
X-Google-Smtp-Source: AGRyM1s4FNyDintDCE4biiDE1x37+NYAxAB7vyhNTDmhtysxhBDeSBYBN40gfwIO4LgkL6ul4NTNZw==
X-Received: by 2002:a05:6402:371a:b0:43a:ece9:ab8e with SMTP id ek26-20020a056402371a00b0043aece9ab8emr19781113edb.126.1658869413951;
        Tue, 26 Jul 2022 14:03:33 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-14-98-67.retail.telecomitalia.it. [87.14.98.67])
        by smtp.gmail.com with ESMTPSA id y19-20020aa7d513000000b0043a7293a03dsm9092849edq.7.2022.07.26.14.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 14:03:33 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hao Chen <chenhao288@hisilicon.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Tom Rix <trix@redhat.com>, Yufeng Mo <moyufeng@huawei.com>,
        netdev@vger.kernel.org
Subject: [RFC PATCH v3 7/9] ethtool: add support to get/set CAN bit time register
Date:   Tue, 26 Jul 2022 23:02:15 +0200
Message-Id: <20220726210217.3368497-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220726210217.3368497-1-dario.binacchi@amarulasolutions.com>
References: <20220726210217.3368497-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add ethtool support to get/set tunable values from/to the CAN bit time
register (btr).

CC: Marc Kleine-Budde <mkl@pengutronix.de>
CC: linux-can@vger.kernel.org
Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 include/uapi/linux/ethtool.h | 1 +
 net/ethtool/common.c         | 1 +
 net/ethtool/ioctl.c          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index e0f0ee9bc89e..a2d24f689124 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -232,6 +232,7 @@ enum tunable_id {
 	ETHTOOL_TX_COPYBREAK,
 	ETHTOOL_PFC_PREVENTION_TOUT, /* timeout in msecs */
 	ETHTOOL_TX_COPYBREAK_BUF_SIZE,
+	ETHTOOL_CAN_BTR,
 	/*
 	 * Add your fresh new tunable attribute above and remember to update
 	 * tunable_strings[] in net/ethtool/common.c
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 566adf85e658..78f23b898243 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -90,6 +90,7 @@ tunable_strings[__ETHTOOL_TUNABLE_COUNT][ETH_GSTRING_LEN] = {
 	[ETHTOOL_TX_COPYBREAK]	= "tx-copybreak",
 	[ETHTOOL_PFC_PREVENTION_TOUT] = "pfc-prevention-tout",
 	[ETHTOOL_TX_COPYBREAK_BUF_SIZE] = "tx-copybreak-buf-size",
+	[ETHTOOL_CAN_BTR] = "can-btr",
 };
 
 const char
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 326e14ee05db..17b69d6fcab4 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2403,6 +2403,7 @@ static int ethtool_get_module_eeprom(struct net_device *dev,
 static int ethtool_tunable_valid(const struct ethtool_tunable *tuna)
 {
 	switch (tuna->id) {
+	case ETHTOOL_CAN_BTR:
 	case ETHTOOL_RX_COPYBREAK:
 	case ETHTOOL_TX_COPYBREAK:
 	case ETHTOOL_TX_COPYBREAK_BUF_SIZE:
-- 
2.32.0

