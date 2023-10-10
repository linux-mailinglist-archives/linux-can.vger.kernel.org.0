Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882297BFB69
	for <lists+linux-can@lfdr.de>; Tue, 10 Oct 2023 14:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjJJM2F (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Oct 2023 08:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjJJM2E (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Oct 2023 08:28:04 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A25BAC
        for <linux-can@vger.kernel.org>; Tue, 10 Oct 2023 05:28:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qqBqB-00040Z-VB
        for linux-can@vger.kernel.org; Tue, 10 Oct 2023 14:27:59 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qqBqB-000evz-IL
        for linux-can@vger.kernel.org; Tue, 10 Oct 2023 14:27:59 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 48A9323362B
        for <linux-can@vger.kernel.org>; Tue, 10 Oct 2023 12:27:59 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 87095233628;
        Tue, 10 Oct 2023 12:27:58 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ec28f71b;
        Tue, 10 Oct 2023 12:27:57 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Tue, 10 Oct 2023 14:27:51 +0200
Subject: [PATCH can-next] MAINTAINERS: can: xilinx_can: remove Naga
 Sureshkumar Relli
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231010-maintainers-remove-naga-sureshkumar-relli-v1-1-d9231c388f4a@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAEZDJWUC/x2NQQqDQAxFryJZNzCjBdtepXQRxqihTiyJiiDe3
 aGLt3hv8f8Bzibs8KoOMN7EZdYi8VZBGkkHRumKQx3qJoYYMJPoUmBzNM7zxqg0EPpq7ON3zWS
 lT5Pg83GnjpuQWiIoez/jXvb/1xsSKSrvC3zO8wJQqfBshQAAAA==
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=rzmkhLSscRXgii1oQiQI+FNm9rFyLEqwkIrUW52SC1s=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlJUNJ8defxwQaeNL1PsAofOalvAuVzbxEg7S0w
 mZCVaJaFuKJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZSVDSQAKCRC+UBxKKooE
 6FhdB/4n6gi3NS24ZlLTLGPdZ+DmHUuepjgXfZ2fvWA4wt3MA8aBe4epHcYWXrtQt58ClBP3uwi
 dPI3Svh2P7nThq/kQrJ9iKHgOfvya7ndhRuscfKo/lREJ2CKBKGU4FM0H0HieKljOOcj18n39aU
 sMDJy2xDFgyj+ONWYDnW/sv+mZxpFKOir0OPlIYk/UK1KZrne8O3FwJH89gdf0uFEnDUOZPUGDU
 ddqRdLotG5A1AUFziZFaq7uY9SHxIsLk3jHxG8rnmki8lkXtw2xvlFWJ7mBajos5nOY68TXfnSx
 3DhPASp9CBbj0Ga1NPG0IZc+G+SHJUXCYAYOCmzuunnA4iE6
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Mails to naga.sureshkumar.relli@xilinx.com are bouncing due to a mail
loop. Seems Naga Sureshkumar Relli has left the company.

Remove Naga Sureshkumar Relli from the xilinx_can driver.

Cc: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1bd96045beb8..fdbcb5915cce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23664,7 +23664,6 @@ F:	drivers/net/ethernet/xilinx/xilinx_axienet*
 
 XILINX CAN DRIVER
 M:	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
-R:	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/xilinx,can.yaml

---
base-commit: 4d48776301cfb930cb6690226b5df4744af7824b
change-id: 20231010-maintainers-remove-naga-sureshkumar-relli-984ade30c7aa

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>


