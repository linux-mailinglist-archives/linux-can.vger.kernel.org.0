Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3580B380D69
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 17:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhENPjD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 11:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbhENPjB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 11:39:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61063C061756
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 08:37:47 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lhZso-0002EX-1B
        for linux-can@vger.kernel.org; Fri, 14 May 2021 17:37:46 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id CEEC6624524
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 15:37:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 30F8262451C;
        Fri, 14 May 2021 15:37:44 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8c054cea;
        Fri, 14 May 2021 15:37:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 2/2] can: mcp251xfd: silence clang warning
Date:   Fri, 14 May 2021 17:37:41 +0200
Message-Id: <20210514153741.1958041-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210514153741.1958041-1-mkl@pengutronix.de>
References: <20210514153741.1958041-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

| drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:564:1: warning: unused function 'mcp251xfd_chip_set_mode_nowait' [-Wunused-function]
| mcp251xfd_chip_set_mode_nowait(const struct mcp251xfd_priv *priv,
| ^
| 1 warning generated.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index e0ae00e34c7b..47c3f408a799 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -560,7 +560,7 @@ mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
 	return __mcp251xfd_chip_set_mode(priv, mode_req, false);
 }
 
-static inline int
+static inline int __maybe_unused
 mcp251xfd_chip_set_mode_nowait(const struct mcp251xfd_priv *priv,
 			       const u8 mode_req)
 {
-- 
2.30.2


