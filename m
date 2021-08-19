Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6150D3F17E3
	for <lists+linux-can@lfdr.de>; Thu, 19 Aug 2021 13:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbhHSLRq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Aug 2021 07:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbhHSLRo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Aug 2021 07:17:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4459BC061575
        for <linux-can@vger.kernel.org>; Thu, 19 Aug 2021 04:17:08 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mGg2k-0004Mi-Oe
        for linux-can@vger.kernel.org; Thu, 19 Aug 2021 13:17:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id CC35466A64A
        for <linux-can@vger.kernel.org>; Thu, 19 Aug 2021 11:17:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 728DC66A648;
        Thu, 19 Aug 2021 11:17:05 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ff8f1b3d;
        Thu, 19 Aug 2021 11:17:04 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] can: tcan4x5x: cdev_to_priv(): remove stray empty line
Date:   Thu, 19 Aug 2021 13:17:02 +0200
Message-Id: <20210819111703.599686-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch removes a stray empty line in the cdev_to_priv() function.

Fixes: ac33ffd3e2b0 ("can: m_can: let m_can_class_allocate_dev() allocate driver specific private data")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 4147cecfbbd6..a4cbfedb6621 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -105,7 +105,6 @@
 static inline struct tcan4x5x_priv *cdev_to_priv(struct m_can_classdev *cdev)
 {
 	return container_of(cdev, struct tcan4x5x_priv, cdev);
-
 }
 
 static void tcan4x5x_check_wake(struct tcan4x5x_priv *priv)
-- 
2.32.0


