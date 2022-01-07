Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41906487D14
	for <lists+linux-can@lfdr.de>; Fri,  7 Jan 2022 20:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiAGTbO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 Jan 2022 14:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiAGTbN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Jan 2022 14:31:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0738C061746
        for <linux-can@vger.kernel.org>; Fri,  7 Jan 2022 11:31:12 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n5uxD-0004LO-A4
        for linux-can@vger.kernel.org; Fri, 07 Jan 2022 20:31:11 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id C93916D33D8
        for <linux-can@vger.kernel.org>; Fri,  7 Jan 2022 19:31:08 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 6E3126D33C0;
        Fri,  7 Jan 2022 19:31:07 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f3e23bc9;
        Fri, 7 Jan 2022 19:31:06 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 6/7] docs: networking: device drivers: add can sub-folder
Date:   Fri,  7 Jan 2022 20:31:04 +0100
Message-Id: <20220107193105.1699523-7-mkl@pengutronix.de>
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

Add the container for CAN drivers documentation.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../networking/device_drivers/can/index.rst    | 18 ++++++++++++++++++
 .../networking/device_drivers/index.rst        |  1 +
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/can/index.rst

diff --git a/Documentation/networking/device_drivers/can/index.rst b/Documentation/networking/device_drivers/can/index.rst
new file mode 100644
index 000000000000..218276818968
--- /dev/null
+++ b/Documentation/networking/device_drivers/can/index.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+Controller Area Network (CAN) Device Drivers
+============================================
+
+Device drivers for CAN devices.
+
+Contents:
+
+.. toctree::
+   :maxdepth: 2
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/networking/device_drivers/index.rst b/Documentation/networking/device_drivers/index.rst
index 3a5a1d46e77e..5f5cfdb2a300 100644
--- a/Documentation/networking/device_drivers/index.rst
+++ b/Documentation/networking/device_drivers/index.rst
@@ -11,6 +11,7 @@ Contents:
    appletalk/index
    atm/index
    cable/index
+   can/index
    cellular/index
    ethernet/index
    fddi/index
-- 
2.34.1


