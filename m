Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182832A9A77
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgKFRLU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:11:20 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:60261 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFRLU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:11:20 -0500
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2020 12:11:19 EST
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id AFAB4FF9D2
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 17:03:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.902
X-Spam-Level: 
X-Spam-Status: No, score=-1.902 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001]
        autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WVY5mJWFKRfH for <linux-can@vger.kernel.org>;
        Fri,  6 Nov 2020 18:03:05 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 04/17] can: ems_usb: Added struct used for CAN FD initialization
Date:   Fri,  6 Nov 2020 18:01:53 +0100
Message-Id: <20201106170206.32162-5-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index fa96217c7d72..4ed0d681a68c 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -142,7 +142,7 @@ struct __packed cpc_canfd_msg {
 #define CPC_FDFLAG_XTD          0x80
 
 /* Representation of the CAN parameters for the SJA1000 controller */
-struct cpc_sja1000_params {
+struct __packed cpc_sja1000_params {
 	u8 mode;
 	u8 acc_code0;
 	u8 acc_code1;
@@ -157,12 +157,41 @@ struct cpc_sja1000_params {
 	u8 outp_contr;
 };
 
+#define CPC_GENERICCONF_FD          0x00000001
+#define CPC_GENERICCONF_FD_BOSCH    0x00000002
+#define CPC_GENERICCONF_LISTEN_ONLY 0x00000004
+#define CPC_GENERICCONF_SINGLE_SHOT 0x00000008
+#define CPC_GENERICCONF_RESET_MODE  0x00000010
+
+#define CPC_USB_RESET_MODE 0x00
+#define CPC_USB_RUN_MODE   0x01
+
+struct __packed cpc_generic_can_params {
+	/* config sets CAN initialization parameters like LOM */
+	__le32 config;
+	__le32 can_clk;
+	struct {
+		__le16 tseg1;  // Time segment 1 (before sample point)
+		__le16 tseg2;  // Time segment 2 (after sample point)
+		__le16 brp;    // Baud rate rate prescaler
+		__le16 sjw;    // (Re)synchronization jump width
+	} n;  // nominal baud rate
+	struct {
+		__le16 tseg1;  // Time segment 1 (before sample point)
+		__le16 tseg2;  // Time segment 2 (after sample point)
+		__le16 brp;    // Baud rate prescaler
+		__le16 sjw;    // (Re)synchronization jump width
+	} d;  // data baud rate
+	__le32 reserved[5];    // Set to 0. Reserved for future use
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
