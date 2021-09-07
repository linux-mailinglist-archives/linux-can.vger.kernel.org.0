Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2031402395
	for <lists+linux-can@lfdr.de>; Tue,  7 Sep 2021 08:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhIGGqr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Sep 2021 02:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhIGGqr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Sep 2021 02:46:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BEFC061757
        for <linux-can@vger.kernel.org>; Mon,  6 Sep 2021 23:45:41 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mNUrU-0004QY-6e
        for linux-can@vger.kernel.org; Tue, 07 Sep 2021 08:45:40 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 19E5A67882E
        for <linux-can@vger.kernel.org>; Tue,  7 Sep 2021 06:45:39 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id CC4E367882A;
        Tue,  7 Sep 2021 06:45:38 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4125da05;
        Tue, 7 Sep 2021 06:45:38 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-renesas-soc@vger.kernel.org,
        Cai Huoqing <caihuoqing@baidu.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] can: rcar_canfd: add __maybe_unused annotation to silence warning
Date:   Tue,  7 Sep 2021 08:45:37 +0200
Message-Id: <20210907064537.1054268-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since commit

| dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD driver")

the rcar_canfd driver can be compile tested on all architectures. On
non OF enabled archs, or archs where OF is optional (and disabled in
the .config) the compilation throws the following warning:

| drivers/net/can/rcar/rcar_canfd.c:2020:34: warning: unused variable 'rcar_canfd_of_table' [-Wunused-const-variable]
| static const struct of_device_id rcar_canfd_of_table[] = {
|                                  ^

This patch fixes the warning by marking the variable
rcar_canfd_of_table as __maybe_unused.

Fixes: ac4224087312 ("can: rcar: Kconfig: Add helper dependency on COMPILE_TEST")
Fixes: dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD driver")
Cc: linux-renesas-soc@vger.kernel.org
Cc: Cai Huoqing <caihuoqing@baidu.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

Changes since v1:
- moved __maybe_unused in front after "static const"

 drivers/net/can/rcar/rcar_canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index c47988d3674e..ff9d0f5ae0dd 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2017,7 +2017,7 @@ static int __maybe_unused rcar_canfd_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
 			 rcar_canfd_resume);
 
-static const struct of_device_id rcar_canfd_of_table[] = {
+static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = (void *)RENESAS_RCAR_GEN3 },
 	{ .compatible = "renesas,rzg2l-canfd", .data = (void *)RENESAS_RZG2L },
 	{ }
-- 
2.33.0


