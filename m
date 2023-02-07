Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4247468E1C7
	for <lists+linux-can@lfdr.de>; Tue,  7 Feb 2023 21:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjBGURn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Feb 2023 15:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBGURn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Feb 2023 15:17:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8B122A31
        for <linux-can@vger.kernel.org>; Tue,  7 Feb 2023 12:17:42 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pPUPM-0006w5-HQ
        for linux-can@vger.kernel.org; Tue, 07 Feb 2023 21:17:40 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E9FE0172C0D
        for <linux-can@vger.kernel.org>; Tue,  7 Feb 2023 20:17:39 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 1839D172C09;
        Tue,  7 Feb 2023 20:17:39 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e156fb89;
        Tue, 7 Feb 2023 20:17:38 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] can: bittiming: can_calc_bittiming(): add missing parameter to no-op function
Date:   Tue,  7 Feb 2023 21:17:34 +0100
Message-Id: <20230207201734.2905618-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In commit 286c0e09e8e0 ("can: bittiming: can_changelink() pass extack
down callstack") a new parameter was added to can_calc_bittiming(),
however the static inline no-op (which is used if
CONFIG_CAN_CALC_BITTIMING is disabled) wasn't converted.

Add the new parameter to the static inline no-op of
can_calc_bittiming().

Fixes: 286c0e09e8e0 ("can: bittiming: can_changelink() pass extack down callstack")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/bittiming.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 6cb2ae308e3f..9b8a9c39614b 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -124,7 +124,7 @@ void can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
 #else /* !CONFIG_CAN_CALC_BITTIMING */
 static inline int
 can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
-		   const struct can_bittiming_const *btc)
+		   const struct can_bittiming_const *btc, struct netlink_ext_ack *extack)
 {
 	netdev_err(dev, "bit-timing calculation not available\n");
 	return -EINVAL;
-- 
2.39.1


