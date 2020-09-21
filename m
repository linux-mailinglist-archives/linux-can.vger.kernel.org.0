Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC57A2725C8
	for <lists+linux-can@lfdr.de>; Mon, 21 Sep 2020 15:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgIUNjC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Sep 2020 09:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgIUNiz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Sep 2020 09:38:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AB3C061755
        for <linux-can@vger.kernel.org>; Mon, 21 Sep 2020 06:38:55 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKM1t-0000ox-CZ; Mon, 21 Sep 2020 15:38:53 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Wang Hai <wanghai38@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 19/38] can: peak_canfd: Remove unused macros
Date:   Mon, 21 Sep 2020 15:38:26 +0200
Message-Id: <20200921133845.2249271-20-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921133845.2249271-1-mkl@pengutronix.de>
References: <20200921133845.2249271-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>

CANFD_CLK_SEL_DIV_MASK and CANFD_OPTIONS_SET are
never used after they were introduced. Remove them.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Link: https://lore.kernel.org/r/20200904131247.23021-1-wanghai38@huawei.com
[mkl: keep CANFD_CLK_SEL_DIV_MASK for documentation purpose]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/peak_canfd/peak_pciefd_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
index 9469d4421afe..0df1cdfa6835 100644
--- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
+++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
@@ -116,8 +116,6 @@ MODULE_LICENSE("GPL v2");
 #define CANFD_CTL_IRQ_CL_DEF	16	/* Rx msg max nb per IRQ in Rx DMA */
 #define CANFD_CTL_IRQ_TL_DEF	10	/* Time before IRQ if < CL (x100 µs) */
 
-#define CANFD_OPTIONS_SET	(CANFD_OPTION_ERROR | CANFD_OPTION_BUSLOAD)
-
 /* Tx anticipation window (link logical address should be aligned on 2K
  * boundary)
  */
-- 
2.28.0

