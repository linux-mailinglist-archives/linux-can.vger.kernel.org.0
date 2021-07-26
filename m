Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FF93D5861
	for <lists+linux-can@lfdr.de>; Mon, 26 Jul 2021 13:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhGZKf4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Jul 2021 06:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbhGZKf4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 06:35:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02099C061757
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 04:16:24 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m7yat-00069i-06
        for linux-can@vger.kernel.org; Mon, 26 Jul 2021 13:16:23 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 22CF3657F8B
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 11:16:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D6007657F88;
        Mon, 26 Jul 2021 11:16:21 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 263100d5;
        Mon, 26 Jul 2021 11:16:21 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Yasushi SHOJI <yashi@spacecubics.com>
Subject: [PATCH v2] MAINTAINERS: add Yasushi SHOJI as reviewer for the Microchip CAN BUS Analyzer Tool driver
Date:   Mon, 26 Jul 2021 13:16:19 +0200
Message-Id: <20210726111619.1023991-1-mkl@pengutronix.de>
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

This patch adds Yasushi SHOJI as a reviewer for the Microchip CAN BUS
Analyzer Tool driver.

Acked-by: Yasushi SHOJI <yashi@spacecubics.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v1:
- update Yasushi's email
- add Yasushi's Acked-by

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 58afeb12d3b3..42ea3183e87c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11327,6 +11327,12 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/radio/radio-maxiradio*
 
+MCAB MICROCHIP CAN BUS ANALYZER TOOL DRIVER
+R:	Yasushi SHOJI <yashi@spacecubics.com>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/usb/mcba_usb.c
+
 MCAN MMIO DEVICE DRIVER
 M:	Chandrasekar Ramakrishnan <rcsekar@samsung.com>
 L:	linux-can@vger.kernel.org
-- 
2.30.2


