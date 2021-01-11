Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36202F17FF
	for <lists+linux-can@lfdr.de>; Mon, 11 Jan 2021 15:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbhAKOWs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jan 2021 09:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbhAKOWs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jan 2021 09:22:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD5CC061786
        for <linux-can@vger.kernel.org>; Mon, 11 Jan 2021 06:22:08 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kyy59-0007Zr-4v
        for linux-can@vger.kernel.org; Mon, 11 Jan 2021 15:22:07 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 0E77D5C0F83
        for <linux-can@vger.kernel.org>; Mon, 11 Jan 2021 14:19:38 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id B9FDE5C0F60;
        Mon, 11 Jan 2021 14:19:35 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c483da9c;
        Mon, 11 Jan 2021 14:19:32 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next v3 09/15] can: length: canfd_sanitize_len(): add function to sanitize CAN-FD data length
Date:   Mon, 11 Jan 2021 15:19:24 +0100
Message-Id: <20210111141930.693847-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111141930.693847-1-mkl@pengutronix.de>
References: <20210111141930.693847-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The data field in CAN-FD frames have specifig frame length (0, 1, 2, 3, 4, 5,
6, 7, 8, 12, 16, 20, 24, 32, 48, 64). This function "rounds" up a given length
to the next valid CAN-FD frame length.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/length.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/can/length.h b/include/linux/can/length.h
index 156b9d17969a..b2313b2a0b02 100644
--- a/include/linux/can/length.h
+++ b/include/linux/can/length.h
@@ -45,4 +45,10 @@ u8 can_fd_dlc2len(u8 dlc);
 /* map the sanitized data length to an appropriate data length code */
 u8 can_fd_len2dlc(u8 len);
 
+/* map the data length to an appropriate data link layer length */
+static inline u8 canfd_sanitize_len(u8 len)
+{
+	return can_fd_dlc2len(can_fd_len2dlc(len));
+}
+
 #endif /* !_CAN_LENGTH_H */
-- 
2.29.2


