Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F8533280B
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 15:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhCIOEh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 09:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhCIOEb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 09:04:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFBAC06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 06:04:31 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJcyM-0005jH-Cp
        for linux-can@vger.kernel.org; Tue, 09 Mar 2021 15:04:30 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 7A2DA5F19E4
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 14:04:29 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 310CD5F19E0;
        Tue,  9 Mar 2021 14:04:29 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 752b7830;
        Tue, 9 Mar 2021 14:04:28 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] can: grcan: add missing Kconfig dependency to HAS_IOMEM
Date:   Tue,  9 Mar 2021 15:04:24 +0100
Message-Id: <20210309140424.3331010-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On ARCHs without IOMEM support the grcan driver fails to link due to
missing iomem functionality. This patch adds the missing Kconfig
dependency to HAS_IOMEM.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 1c28eade6bec..e355d3974977 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -103,7 +103,7 @@ config CAN_FLEXCAN
 
 config CAN_GRCAN
 	tristate "Aeroflex Gaisler GRCAN and GRHCAN CAN devices"
-	depends on OF && HAS_DMA
+	depends on OF && HAS_DMA && HAS_IOMEM
 	help
 	  Say Y here if you want to use Aeroflex Gaisler GRCAN or GRHCAN.
 	  Note that the driver supports little endian, even though little
-- 
2.30.1


