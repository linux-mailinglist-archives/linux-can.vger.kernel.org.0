Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE951382B46
	for <lists+linux-can@lfdr.de>; Mon, 17 May 2021 13:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbhEQLix (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 May 2021 07:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbhEQLiu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 May 2021 07:38:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC7AC061573
        for <linux-can@vger.kernel.org>; Mon, 17 May 2021 04:37:33 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1libYy-0004ZM-D5
        for linux-can@vger.kernel.org; Mon, 17 May 2021 13:37:32 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 7EC80625A73
        for <linux-can@vger.kernel.org>; Mon, 17 May 2021 11:37:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 43AF1625A6F;
        Mon, 17 May 2021 11:37:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0f7528ce;
        Mon, 17 May 2021 11:37:30 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     socketcan@hartkopp.net, Marc Kleine-Budde <mkl@pengutronix.de>,
        Ayoub Kaanich <kayoub5@live.com>
Subject: [PATCH] can: uapi: update CAN-FD frame description
Date:   Mon, 17 May 2021 13:37:27 +0200
Message-Id: <20210517113727.77597-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since an early version of the CAN-FD specification the bit that
defines a CAN-FD frame on the wire, has been renamed from Extended
Data Length (EDL) to FD Frame (FDF).

To avoid confusion, update the struct canfd_frame description in the
UAPI headers accordingly.

Suggested-by: Ayoub Kaanich <kayoub5@live.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/uapi/linux/can.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index c7535352fef6..ac5d7a31671f 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -123,8 +123,8 @@ struct can_frame {
 /*
  * defined bits for canfd_frame.flags
  *
- * The use of struct canfd_frame implies the Extended Data Length (EDL) bit to
- * be set in the CAN frame bitstream on the wire. The EDL bit switch turns
+ * The use of struct canfd_frame implies the FD Frame (FDF) bit to
+ * be set in the CAN frame bitstream on the wire. The FDF bit switch turns
  * the CAN controllers bitstream processor into the CAN FD mode which creates
  * two new options within the CAN FD frame specification:
  *
-- 
2.30.2


