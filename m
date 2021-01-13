Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C192F5841
	for <lists+linux-can@lfdr.de>; Thu, 14 Jan 2021 04:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbhANCQq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Jan 2021 21:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbhAMVQZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Jan 2021 16:16:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7040C061389
        for <linux-can@vger.kernel.org>; Wed, 13 Jan 2021 13:14:37 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kznTQ-0001xX-A4
        for linux-can@vger.kernel.org; Wed, 13 Jan 2021 22:14:36 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id C0F865C308C
        for <linux-can@vger.kernel.org>; Wed, 13 Jan 2021 21:14:28 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 6400B5C3031;
        Wed, 13 Jan 2021 21:14:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 51a7c136;
        Wed, 13 Jan 2021 21:14:11 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next 17/17] can: tcan4x5x: remove __packed attribute from struct tcan4x5x_map_buf
Date:   Wed, 13 Jan 2021 22:14:10 +0100
Message-Id: <20210113211410.917108-18-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113211410.917108-1-mkl@pengutronix.de>
References: <20210113211410.917108-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The first member of struct tcan4x5x_map_buf is the struct tcan4x5x_buf_cmd,
which has a size of 4 bytes. It's followed by an array of u8. The compiler
places the array directly after the struct tcan4x5x_buf_cmd.

This patch removes the not needed attribute __packed from the struct
tcan4x5x_map_buf.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20210113203955.912916-1-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.h b/drivers/net/can/m_can/tcan4x5x.h
index 7bf264f8e81f..c66da829b795 100644
--- a/drivers/net/can/m_can/tcan4x5x.h
+++ b/drivers/net/can/m_can/tcan4x5x.h
@@ -25,7 +25,7 @@ struct __packed tcan4x5x_buf_cmd {
 	u8 len;
 };
 
-struct __packed tcan4x5x_map_buf {
+struct tcan4x5x_map_buf {
 	struct tcan4x5x_buf_cmd cmd;
 	u8 data[256 * sizeof(u32)];
 } ____cacheline_aligned;
-- 
2.29.2


