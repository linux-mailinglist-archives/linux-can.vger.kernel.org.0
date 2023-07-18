Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E54F757A24
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 13:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjGRLLf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 07:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjGRLLd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 07:11:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509661731
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 04:11:07 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLibh-0006Y1-Ns
        for linux-can@vger.kernel.org; Tue, 18 Jul 2023 13:11:05 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id DA8601F40DA
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 11:11:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 24A261F40C7;
        Tue, 18 Jul 2023 11:11:04 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 037ca5e8;
        Tue, 18 Jul 2023 11:11:03 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Tue, 18 Jul 2023 13:10:25 +0200
Subject: [PATCH 03/11] can: gs_usb: gs_usb_set_timestamp(): remove return
 statements form void function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-gs_usb-cleanups-v1-3-c3b9154ec605@pengutronix.de>
References: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
In-Reply-To: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=733; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=jUIp+y/YRF+bokFoGZBePwkGqQ0e2tE/XROX80xgXgo=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktnMoENt8vLYU8YN6gVr/aMYawr/xtcsyhv3Zj
 VijaUsn+e+JATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLZzKAAKCRC+UBxKKooE
 6M3bB/99dm0o4Os5iva/ytQEumzlS+c+Ku39tPn5HyfusUL6nBEvFo/bTnf2eIR3bXA0WO1+RhQ
 uopNyfu0Of6hxNAjT2GczQawz+YLWtc9299OiJR4hvXNyJiia3Jg9biNryR54P8x5r3JnYoAqYL
 Tdy8tbCCMzXlz1qb/vttdNyxz/yMrreCLNUEEiFsYgnFMNiRON31Ai87mmNAylco5iT7E+FSRvz
 NmwQfphgxSO/T19XF3RXtr8z4qTyZMr4Yl1mXJL4lm+P32NIX1v5F2VC28/sDY08Gg+p5gk/Wji
 e94Ub+a80zl7Iok9INg3ILnM4BolqzUOAJQKRyLMpB83Setg
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Remove the return statements from void gs_usb_set_timestamp()
function, as it's not generally useful.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 966e00ea768d..1e08d38b0f96 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -520,8 +520,6 @@ static void gs_usb_set_timestamp(struct gs_can *dev, struct sk_buff *skb,
 		timestamp = le32_to_cpu(hf->classic_can_ts->timestamp_us);
 
 	gs_usb_skb_set_timestamp(dev, skb, timestamp);
-
-	return;
 }
 
 static void gs_usb_receive_bulk_callback(struct urb *urb)

-- 
2.40.1


