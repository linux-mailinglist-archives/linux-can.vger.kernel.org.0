Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6954E380D68
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 17:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhENPjC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 11:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbhENPi6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 11:38:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473B2C06174A
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 08:37:47 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lhZsn-0002ER-U4
        for linux-can@vger.kernel.org; Fri, 14 May 2021 17:37:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id C8B0B624523
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 15:37:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 2074262451B;
        Fri, 14 May 2021 15:37:44 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d57e2390;
        Fri, 14 May 2021 15:37:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 1/2] can: at91_can: silence clang warning
Date:   Fri, 14 May 2021 17:37:40 +0200
Message-Id: <20210514153741.1958041-2-mkl@pengutronix.de>
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

| drivers/net/can/at91_can.c:178:1: warning: unused function 'at91_is_sam9X5' [-Wunused-function]
| AT91_IS(9X5);
| ^
| drivers/net/can/at91_can.c:172:19: note: expanded from macro 'AT91_IS'
| static inline int at91_is_sam##_model(const struct at91_priv *priv) \
|                   ^
| <scratch space>:66:1: note: expanded from here
| at91_is_sam9X5
| ^

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 9ad9b39f480e..04d0bb3ffe89 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -169,7 +169,7 @@ static const struct can_bittiming_const at91_bittiming_const = {
 };
 
 #define AT91_IS(_model) \
-static inline int at91_is_sam##_model(const struct at91_priv *priv) \
+static inline int __maybe_unused at91_is_sam##_model(const struct at91_priv *priv) \
 { \
 	return priv->devtype_data.type == AT91_DEVTYPE_SAM##_model; \
 }

base-commit: ea89c862f01e02ec459932c7c3113fa37aedd09a
-- 
2.30.2


