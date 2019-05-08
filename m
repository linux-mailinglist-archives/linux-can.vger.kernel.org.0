Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85B6C17AF1
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2019 15:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfEHNoZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 May 2019 09:44:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42315 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfEHNoY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2019 09:44:24 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <mkl@pengutronix.de>)
        id 1hOMru-0007vK-Jb; Wed, 08 May 2019 15:44:22 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@martin.sperl.org, linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/6] can: mcp25xxfd_can: mcp25xxfd_can_int: sort include alphabetically
Date:   Wed,  8 May 2019 15:44:17 +0200
Message-Id: <20190508134420.29982-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508134420.29982-1-mkl@pengutronix.de>
References: <20190508134420.29982-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c
index f159267e7f6c..446716d38c10 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c
@@ -18,7 +18,6 @@
 #include <linux/slab.h>
 #include <linux/sort.h>
 
-#include "mcp25xxfd_regs.h"
 #include "mcp25xxfd_can.h"
 #include "mcp25xxfd_can_debugfs.h"
 #include "mcp25xxfd_can_priv.h"
@@ -26,6 +25,7 @@
 #include "mcp25xxfd_can_tx.h"
 #include "mcp25xxfd_cmd.h"
 #include "mcp25xxfd_ecc.h"
+#include "mcp25xxfd_regs.h"
 
 static unsigned int reschedule_int_thread_after = 4;
 module_param(reschedule_int_thread_after, uint, 0664);
-- 
2.20.1

