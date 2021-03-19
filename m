Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA543341D12
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 13:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCSMmP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 08:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhCSMlv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 08:41:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8FCC06175F
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 05:41:50 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lNERp-00030Y-Gu
        for linux-can@vger.kernel.org; Fri, 19 Mar 2021 13:41:49 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 55AE45FA97A
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 12:41:46 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 73AB25FA964;
        Fri, 19 Mar 2021 12:41:44 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id fcd112d7;
        Fri, 19 Mar 2021 12:41:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, mailhol.vincent@wanadoo.fr,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v13 02/11] can: etas_es58x: make core driver compile without glue code drivers
Date:   Fri, 19 Mar 2021 13:41:32 +0100
Message-Id: <20210319124141.247844-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319124141.247844-1-mkl@pengutronix.de>
References: <20210319124141.247844-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/etas_es58x/es581_4.h    | 19 ++++++++++++++++++
 drivers/net/can/usb/etas_es58x/es58x_core.h |  2 --
 drivers/net/can/usb/etas_es58x/es58x_fd.h   | 22 +++++++++++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/can/usb/etas_es58x/es581_4.h
 create mode 100644 drivers/net/can/usb/etas_es58x/es58x_fd.h

diff --git a/drivers/net/can/usb/etas_es58x/es581_4.h b/drivers/net/can/usb/etas_es58x/es581_4.h
new file mode 100644
index 000000000000..06a1fad105df
--- /dev/null
+++ b/drivers/net/can/usb/etas_es58x/es581_4.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Driver for ETAS GmbH ES58X USB CAN(-FD) Bus Interfaces.
+ *
+ * File es581_4.h: Definitions and declarations specific to ETAS
+ * ES581.4.
+ *
+ * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
+ * Copyright (c) 2020 ETAS K.K.. All rights reserved.
+ * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ */
+
+#ifndef __ES581_4_H__
+#define __ES581_4_H__
+
+#define ES581_4_NUM_CAN_CH 2
+#define ES581_4_RX_LOOPBACK_BULK_MAX 30
+
+#endif /* __ES581_4_H__ */
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.h b/drivers/net/can/usb/etas_es58x/es58x_core.h
index 28e50a048934..71f278e6e85c 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.h
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.h
@@ -200,8 +200,6 @@ enum es58x_ret_type {
 };
 
 union es58x_urb_cmd {
-	struct es581_4_urb_cmd es581_4_urb_cmd;
-	struct es58x_fd_urb_cmd es58x_fd_urb_cmd;
 	struct {		/* Common header parts of all variants */
 		__le16 sof;
 		u8 cmd_type;
diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.h b/drivers/net/can/usb/etas_es58x/es58x_fd.h
new file mode 100644
index 000000000000..6be26f4b32dc
--- /dev/null
+++ b/drivers/net/can/usb/etas_es58x/es58x_fd.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Driver for ETAS GmbH ES58X USB CAN(-FD) Bus Interfaces.
+ *
+ * File es58x_fd.h: Definitions and declarations specific to ETAS
+ * ES582.1 and ES584.1 (naming convention: we use the term "ES58X FD"
+ * when referring to those two variants together).
+ *
+ * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
+ * Copyright (c) 2020 ETAS K.K.. All rights reserved.
+ * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ */
+
+#ifndef __ES58X_FD_H__
+#define __ES58X_FD_H__
+
+#define ES582_1_NUM_CAN_CH 2
+#define ES584_1_NUM_CAN_CH 1
+#define ES58X_FD_NUM_CAN_CH 2
+#define ES58X_FD_RX_LOOPBACK_BULK_MAX 100
+
+#endif /* __ES58X_FD_H__ */
-- 
2.30.2


