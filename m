Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940EF3B8AC1
	for <lists+linux-can@lfdr.de>; Thu,  1 Jul 2021 01:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhF3XEI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 30 Jun 2021 19:04:08 -0400
Received: from mail.kernel-space.org ([195.201.34.187]:59578 "EHLO
        mail.kernel-space.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbhF3XEH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Jun 2021 19:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1625094095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mmPDE3VlbR9VXMhfBgRckluol3pC5EBN+PJXyue4LTI=;
        b=AgaYvQTvk3QBx28lr00mpQYbkTb9rqd6fikPRr6XAFk2JP02iEEkxPqtT7mPf5VaxzrwHh
        i06aTeIP30JaSnLpn9UjJtnWZqf1Hxk6m7vTbw7G1sgvguNSx4fhNSfcu2Qk3M2n7yMNvm
        4YyirhdV+KUW7nBON4AzYUmxwKtExkA=
Received: from dfj.bfc.timesys.com (host-87-4-238-130.retail.telecomitalia.it [87.4.238.130])
        by ziongate (OpenSMTPD) with ESMTPSA id d457665a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 30 Jun 2021 23:01:35 +0000 (UTC)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     gerg@linux-m68k.org, wg@grandegger.com, mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com,
        Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v4 4/5] can: flexcan: update Kconfig to enable coldfire
Date:   Thu,  1 Jul 2021 01:00:15 +0200
Message-Id: <20210630230016.4099050-4-angelo@kernel-space.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630230016.4099050-1-angelo@kernel-space.org>
References: <20210630230016.4099050-1-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Update flexcan to support coldfire architecture.

Any new platform should use OF, but coldfire architecture is
actually not supporting devicetrees.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
Changes for v2:
none
Changes for v3:
- change to just remove OF
Changes for v4:
- readjust options with coldfire and compile test additions
---
 drivers/net/can/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index e355d3974977..3d6f319f6c91 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -97,7 +97,8 @@ config CAN_AT91
 
 config CAN_FLEXCAN
 	tristate "Support for Freescale FLEXCAN based chips"
-	depends on OF && HAS_IOMEM
+	depends on OF || COLDFIRE || COMPILE_TEST 
+	depends on HAS_IOMEM
 	help
 	  Say Y here if you want to support for Freescale FlexCAN.
 
-- 
2.31.1

