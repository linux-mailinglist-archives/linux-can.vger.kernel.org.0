Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E992757A25
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 13:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGRLLg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 07:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjGRLLd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 07:11:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E62173A
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 04:11:07 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLibh-0006Xx-MZ
        for linux-can@vger.kernel.org; Tue, 18 Jul 2023 13:11:05 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id BF13C1F40D8
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 11:11:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 118241F40C5;
        Tue, 18 Jul 2023 11:11:04 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3b0174fc;
        Tue, 18 Jul 2023 11:11:03 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Tue, 18 Jul 2023 13:10:24 +0200
Subject: [PATCH 02/11] can: gs_usb: gs_usb_probe(): align block comment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-gs_usb-cleanups-v1-2-c3b9154ec605@pengutronix.de>
References: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
In-Reply-To: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=854; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=b1oLSv+6YW1EbXYd+DH42aj7atttqQkv/HycXZLrVZ0=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktnMluan8QUxoxvin4Yup6wYhK+XBBtpumElGj
 UfWzrwOIvqJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLZzJQAKCRC+UBxKKooE
 6GVqB/986GTOcaqoQxuGupnFF25siomTzeWyucrj+KjnMFbDS2FHR8nISuCsr7Gh5pdXcwWC19U
 5N9G2mIk2rCRTTUCFoEfstobUfzsm/KakyJm87w+U35Hgskm1HpNYi7jzu64wS2F4smdaanFsGu
 IrIit9q9FsOwjUHWg2nLFiiVg9D8xyN0tZTicxUCvzDw0UTWFW8YOa0rnhMt+bobpU0s3TNbfFj
 qTP2AwaE1/fjwvjzjsK00QwP/09hOd+J+cvhZhNfFpCFXS7RKDu5NfvUsmWneQpfTM42yE1UUl4
 Q/flY7Dsg4zN5JcKQRdaXB+p+IHd806Pivd+9ZtBt9pRjmSw
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

Indent block comment so that it aligns the * on each line.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index c604377138fd..966e00ea768d 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1443,8 +1443,8 @@ static int gs_usb_probe(struct usb_interface *intf,
 		dev->canch[i]->parent = dev;
 
 		/* set RX packet size based on FD and if hardware
-                * timestamps are supported.
-		*/
+		 * timestamps are supported.
+		 */
 		if (dev->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
 			if (dev->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 				hf_size_rx = struct_size(hf, canfd_ts, 1);

-- 
2.40.1


