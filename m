Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B693565E8
	for <lists+linux-can@lfdr.de>; Wed,  7 Apr 2021 10:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbhDGIBj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Apr 2021 04:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbhDGIBh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Apr 2021 04:01:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A51C06174A
        for <linux-can@vger.kernel.org>; Wed,  7 Apr 2021 01:01:28 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lU37v-0001xT-2l
        for linux-can@vger.kernel.org; Wed, 07 Apr 2021 10:01:27 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 795D86097E9
        for <linux-can@vger.kernel.org>; Wed,  7 Apr 2021 08:01:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id A5F6F6097D1;
        Wed,  7 Apr 2021 08:01:20 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 87386490;
        Wed, 7 Apr 2021 08:01:19 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next 3/6] can: c_can: remove unused enum BOSCH_C_CAN_PLATFORM
Date:   Wed,  7 Apr 2021 10:01:15 +0200
Message-Id: <20210407080118.1916040-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407080118.1916040-1-mkl@pengutronix.de>
References: <20210407080118.1916040-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch removes the unused enum BOSCH_C_CAN_PLATFORM.

Link: https://lore.kernel.org/r/20210406110617.1865592-2-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 8acedd9e63a7..06045f610f0e 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -149,7 +149,6 @@ static const u16 __maybe_unused reg_map_d_can[] = {
 };
 
 enum c_can_dev_id {
-	BOSCH_C_CAN_PLATFORM,
 	BOSCH_C_CAN,
 	BOSCH_D_CAN,
 };
-- 
2.30.2


