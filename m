Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85572B0C34
	for <lists+linux-can@lfdr.de>; Thu, 12 Nov 2020 19:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgKLSEl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Nov 2020 13:04:41 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:48390 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgKLSEl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Nov 2020 13:04:41 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 4CC90FFA5D
        for <linux-can@vger.kernel.org>; Thu, 12 Nov 2020 18:04:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CH02BcBv-WuA for <linux-can@vger.kernel.org>;
        Thu, 12 Nov 2020 19:04:38 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH v2 05/16] can: ems_usb: Added CAN FD initialization struct
Date:   Thu, 12 Nov 2020 19:03:35 +0100
Message-Id: <20201112180346.29070-6-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
References: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

cpc_generic_can_params is used to initialize the CPC-USB/FD in a CAN
controller independent way

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index e75fdd457919..cb7a002e8627 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -153,12 +153,40 @@ struct cpc_sja1000_params {
 	u8 outp_contr;
 };
 
+#define CPC_GENERICCONF_FD          BIT(0)
+#define CPC_GENERICCONF_FD_BOSCH    BIT(1)
+#define CPC_GENERICCONF_LISTEN_ONLY BIT(2)
+#define CPC_GENERICCONF_SINGLE_SHOT BIT(3)
+#define CPC_GENERICCONF_RESET_MODE  BIT(4)
+
+#define CPC_USB_RESET_MODE 0x00
+#define CPC_USB_RUN_MODE   0x01
+
+struct __packed cpc_generic_can_params {
+	__le32 config; /* config sets CAN initialization parameters like LOM */
+	__le32 can_clk;
+	struct {
+		__le16 tseg1;  /* Time segment 1 (before sample point) */
+		__le16 tseg2;  /* Time segment 2 (after sample point) */
+		__le16 brp;    /* Baud rate rate prescaler */
+		__le16 sjw;    /* (Re)synchronization jump width */
+	} nominal_bitrate;
+	struct {
+		__le16 tseg1;  /* Time segment 1 (before sample point) */
+		__le16 tseg2;  /* Time segment 2 (after sample point) */
+		__le16 brp;    /* Baud rate prescaler */
+		__le16 sjw;    /* (Re)synchronization jump width */
+	} data_bitrate;
+	__le32 reserved[5];    /* Set to 0. Reserved for future use */
+};
+
 /* CAN params message representation */
-struct cpc_can_params {
+struct __packed cpc_can_params {
 	u8 cc_type;
 
 	union {
 		struct cpc_sja1000_params sja1000;
+		struct cpc_generic_can_params generic;
 	} cc_params;
 };
 
-- 
2.26.2

-- 
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
