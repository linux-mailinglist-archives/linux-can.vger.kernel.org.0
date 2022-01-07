Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DF9487D10
	for <lists+linux-can@lfdr.de>; Fri,  7 Jan 2022 20:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiAGTbN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 Jan 2022 14:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiAGTbM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Jan 2022 14:31:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD66DC061574
        for <linux-can@vger.kernel.org>; Fri,  7 Jan 2022 11:31:12 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n5uxD-0004LD-3q
        for linux-can@vger.kernel.org; Fri, 07 Jan 2022 20:31:11 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B7F9E6D33D7
        for <linux-can@vger.kernel.org>; Fri,  7 Jan 2022 19:31:08 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7A0FD6D33C1;
        Fri,  7 Jan 2022 19:31:07 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b42ba4be;
        Fri, 7 Jan 2022 19:31:06 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 7/7] docs: networking: device drivers: can: add flexcan
Date:   Fri,  7 Jan 2022 20:31:05 +0100
Message-Id: <20220107193105.1699523-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107193105.1699523-1-mkl@pengutronix.de>
References: <20220107193105.1699523-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Add initial documentation for Flexcan driver.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../device_drivers/can/freescale/flexcan.rst  | 54 +++++++++++++++++++
 .../networking/device_drivers/can/index.rst   |  2 +
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/can/freescale/flexcan.rst

diff --git a/Documentation/networking/device_drivers/can/freescale/flexcan.rst b/Documentation/networking/device_drivers/can/freescale/flexcan.rst
new file mode 100644
index 000000000000..8cc0359a8588
--- /dev/null
+++ b/Documentation/networking/device_drivers/can/freescale/flexcan.rst
@@ -0,0 +1,54 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+=============================
+Flexcan CAN Controller driver
+=============================
+
+Authors: Marc Kleine-Budde <mkl@pengutronix.de>,
+Dario Binacchi <dario.binacchi@amarula.solutions.com>
+
+On/off RTR frames reception
+===========================
+
+For most flexcan IP cores the driver supports 2 RX modes:
+
+- FIFO
+- mailbox
+
+The older flexcan cores (integrated into the i.MX25, i.MX28, i.MX35
+and i.MX53 SOCs) only reception of RTR frames if the controller is
+configured for RX-FIFO mode.
+
+The RX FIFO mode uses a hardware FIFO with a depth of 6 CAN frames,
+while the mailbox mode uses a software FIFO with a depth of up to 62
+CAN frames. With the help of the bigger buffer, the mailbox mode
+performs better under high system load situations.
+
+As reception of RTR frames is part of the CAN standard, all flexcan
+core come up in a mode where RTR reception is possible.
+
+With the "rx-rtr" private flag the ability to receive RTR frames can
+be waived at the expense of losing the ability to receive RTR
+messages. This trade off is beneficial in certain use cases.
+
+"rx-rtr" on
+  Receive RTR frames. (default)
+
+  The CAN controller can and will receive RTR frames.
+
+  On some IP cores the controller cannot receive RTR frames in the
+  more performant "RX mailbox" mode and will use "RX FIFO" mode
+  instead.
+
+"rx-rtr" off
+
+  Waive ability to receive RTR frames. (not supported on all IP cores)
+
+  This mode activates the "RX mailbox mode" for better performance, on
+  some IP cores RTR frames cannot be received anymore.
+
+The setting can only be changed if the interface is down::
+
+    ip link set dev can0 down
+    ethtool --set-priv-flags can0 rx-rtr {off|on}
+    ip link set dev can0 up
diff --git a/Documentation/networking/device_drivers/can/index.rst b/Documentation/networking/device_drivers/can/index.rst
index 218276818968..58b6e0ad3030 100644
--- a/Documentation/networking/device_drivers/can/index.rst
+++ b/Documentation/networking/device_drivers/can/index.rst
@@ -10,6 +10,8 @@ Contents:
 .. toctree::
    :maxdepth: 2
 
+   freescale/flexcan
+
 .. only::  subproject and html
 
    Indices
-- 
2.34.1


