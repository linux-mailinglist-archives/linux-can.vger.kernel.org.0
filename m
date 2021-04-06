Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308E43551C0
	for <lists+linux-can@lfdr.de>; Tue,  6 Apr 2021 13:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbhDFLQt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Apr 2021 07:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhDFLQn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Apr 2021 07:16:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7EAC061762
        for <linux-can@vger.kernel.org>; Tue,  6 Apr 2021 04:16:33 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lTjh9-0000yk-Lo
        for linux-can@vger.kernel.org; Tue, 06 Apr 2021 13:16:31 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E8FED60872F
        for <linux-can@vger.kernel.org>; Tue,  6 Apr 2021 11:16:28 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 6FF8060870C;
        Tue,  6 Apr 2021 11:16:24 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 66e35a00;
        Tue, 6 Apr 2021 11:16:23 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 08/10] can: peak_usb: pcan_usb_get_serial(): make use of le32_to_cpup()
Date:   Tue,  6 Apr 2021 13:16:20 +0200
Message-Id: <20210406111622.1874957-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406111622.1874957-1-mkl@pengutronix.de>
References: <20210406111622.1874957-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch replaces the memcpy() + le32_to_cpu() by le32_to_cpup().

Cc: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index fd5ea95fd55d..ffb01c3a3827 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -368,12 +368,8 @@ static int pcan_usb_get_serial(struct peak_usb_device *dev, u32 *serial_number)
 	if (err)
 		return err;
 
-	if (serial_number) {
-		__le32 tmp32;
-
-		memcpy(&tmp32, args, 4);
-		*serial_number = le32_to_cpu(tmp32);
-	}
+	if (serial_number)
+		*serial_number = le32_to_cpup((__le32 *)args);
 
 	return 0;
 }
-- 
2.30.2


