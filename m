Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE7E3321CB
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 10:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCIJT2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 04:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhCIJTG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 04:19:06 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F172FC06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 01:19:05 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id w11so14380461wrr.10
        for <linux-can@vger.kernel.org>; Tue, 09 Mar 2021 01:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NOPpVPEfwsPCm/IrqTIA8c1KcuoQPElvZGV6eeikJJE=;
        b=Gq5+Al88Fv52oanhDcS+Z1iyduSVfYA2xBUdF3at9ClGMbq0Qy9t/j3Gfhrzw1HSad
         pBoW1hkvyuTjpryIgMvQTPQKLRH7JPxRo+FSwouW39IsV3USbu2FAxeScHitcRVkhYqZ
         KPLqB79UqyksLfUaE2JFp7ZOfUpp3+cXGy+VMi4mBp++XWgR68OrYvu5Y2Ou3VlK+DS7
         9hC71us9mz9GaJmHGaZvWAooCgb+XdZY2uyreO2el6iMjA6XQ6IPzZ2gMRxMTXlawdCM
         fb99Krp72SjRl67p+T1e5N7oID5BGGgOyyf9We+K27E9UJFgl3iXcP7OG0xNY4MM9PAJ
         GMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NOPpVPEfwsPCm/IrqTIA8c1KcuoQPElvZGV6eeikJJE=;
        b=Vos5gOpf91VZljbr8Wrsit3Feh0+AJpWpRZmeMIbM8UcwHgfLokcVS4SpegyXG+19I
         AI94cTFJH+98o7U/Tc9K75GFa96dYVOgrTBNjBMt7B07p5hqNqxYVK4RxBQO0NMgSFyM
         vlc2bThY0kTsWL0byW7mMpmalaBNcuGTKrxYrfiGF836eoeVGDcHEwW5CD2KgO+mXoah
         Myf7xsYDrscrlcdy5bJmDT9HSSzpgjc4Rb5qxRNBbpJcE/djShPmyQ78VUo4RZA6wk+A
         QZZpyU57J6gWyfAlfvRZkDY8MN5Kr6RcfnHXaVdhljc9o/4wVxrwy32ognuzkjB1nWyN
         mSmQ==
X-Gm-Message-State: AOAM531ql1eLfHPIJmjeqqiJDaLq5YreqNGac57Zi3HzkshQUIywF735
        spe0K1iiXmvSDkNqIOj6oKQH8fRjsPE=
X-Google-Smtp-Source: ABdhPJwBVveJ14pgBhwWfiCTiJtJRkw8blU5Wu4HO7EML28bcCoFqrlJvinXgmnNVIeSrE/wYgR80w==
X-Received: by 2002:adf:ed87:: with SMTP id c7mr27326086wro.9.1615281544818;
        Tue, 09 Mar 2021 01:19:04 -0800 (PST)
Received: from localhost.localdomain (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id r26sm3098022wmn.28.2021.03.09.01.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 01:19:04 -0800 (PST)
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH] can: kvaser_pciefd: Always disable bus load reporting
Date:   Tue,  9 Mar 2021 10:17:23 +0100
Message-Id: <20210309091724.31262-1-jimmyassarsson@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Under certain circumstances, when switching from Kvaser's linuxcan driver
(kvpciefd) to the SocketCAN driver (kvaser_pciefd), the bus load reporting
is not disabled.
This is flooding the kernel log with prints like:
[3485.574677] kvaser_pciefd 0000:02:00.0: Received unexpected packet type 0x00000009

Always put the controller in the expected state, instead of assuming that
bus load reporting is inactive.

Note: If bus load reporting is enabled when the driver is loaded, you will
      still get a number of bus load packages (and printouts), before it is
      disabled.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 37e05010ca91..74d9899fc904 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -57,6 +57,7 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_KCAN_STAT_REG 0x418
 #define KVASER_PCIEFD_KCAN_MODE_REG 0x41c
 #define KVASER_PCIEFD_KCAN_BTRN_REG 0x420
+#define KVASER_PCIEFD_KCAN_BUS_LOAD_REG 0x424
 #define KVASER_PCIEFD_KCAN_BTRD_REG 0x428
 #define KVASER_PCIEFD_KCAN_PWM_REG 0x430
 /* Loopback control register */
@@ -949,6 +950,9 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		timer_setup(&can->bec_poll_timer, kvaser_pciefd_bec_poll_timer,
 			    0);
 
+		/* Disable Bus load reporting */
+		iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_BUS_LOAD_REG);
+
 		tx_npackets = ioread32(can->reg_base +
 				       KVASER_PCIEFD_KCAN_TX_NPACKETS_REG);
 		if (((tx_npackets >> KVASER_PCIEFD_KCAN_TX_NPACKETS_MAX_SHIFT) &
-- 
2.30.0

