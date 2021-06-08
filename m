Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246E23A0557
	for <lists+linux-can@lfdr.de>; Tue,  8 Jun 2021 22:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhFHUzM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Jun 2021 16:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhFHUzM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Jun 2021 16:55:12 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0B2C061574;
        Tue,  8 Jun 2021 13:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1623185196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEvCmMNpxeYO45M5lh0EKK3/k+qeySJGXHyN0xv7Mj8=;
        b=uKkAboyQiDnhc4KNbQzo8Gr2TXaihPZgzvDkIrjOKhwwggy7IZReOJEbot+kg0+hJi9TkA
        jkiAX3oqQJ24jbaGXKyYK9WhyZ6peVZRjZcPmRWTNC34jukEPv7aS29oqAk+2yjLgvMcaa
        r+DiHpsp7oNbzpA7yAQkPST4A9x3Q70=
Received: from dfj.1.1.1.1 (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id 50314316 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 8 Jun 2021 20:46:36 +0000 (UTC)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     gerg@linux-m68k.org, wg@grandegger.com, mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com,
        Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH 4/5] can: flexcan: enable Kconfig for ColdFire
Date:   Tue,  8 Jun 2021 22:45:41 +0200
Message-Id: <20210608204542.983925-4-angelo@kernel-space.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608204542.983925-1-angelo@kernel-space.org>
References: <20210608204542.983925-1-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Enable flexcan KConfig for ColdFire m5441x cpu's.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
 drivers/net/can/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index e355d3974977..7a1be9dad52d 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -97,7 +97,7 @@ config CAN_AT91
 
 config CAN_FLEXCAN
 	tristate "Support for Freescale FLEXCAN based chips"
-	depends on OF && HAS_IOMEM
+	depends on (OF || M5441x) && HAS_IOMEM
 	help
 	  Say Y here if you want to support for Freescale FlexCAN.
 
-- 
2.31.1

