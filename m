Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF5B2B0C33
	for <lists+linux-can@lfdr.de>; Thu, 12 Nov 2020 19:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgKLSEj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Nov 2020 13:04:39 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:40278 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgKLSEj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Nov 2020 13:04:39 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id E6462FFBB8
        for <linux-can@vger.kernel.org>; Thu, 12 Nov 2020 18:04:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kOOSNMgeJ0xn for <linux-can@vger.kernel.org>;
        Thu, 12 Nov 2020 19:04:36 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH v2 04/16] can: ems_usb: Added CAN FD message representation
Date:   Thu, 12 Nov 2020 19:03:34 +0100
Message-Id: <20201112180346.29070-5-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
References: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

cpc_canfd_msg struct is added, needed flags are given and the size of 
ems_cpc_msg is adjusted

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index a9819287e6a7..e75fdd457919 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -116,6 +116,27 @@ struct cpc_can_msg {
 	u8 msg[8];
 };
 
+/* CAN FD message representation in a CPC_MSG.
+ * Message object type is CPC_MSG_T_CANFD.
+ */
+struct __packed cpc_canfd_msg {
+	__le32 id;
+	u8  length;
+	u8  flags;
+	u8  msg[64];
+};
+
+/* This defines are used with the flags variable
+ * within the struct cpc_canfd_msg. A cpc_canfd_msg
+ * can also be used to send a classic CAN frame including
+ * RTR frames when CPC_FDFLAG_NONCANFD_MSG is set.
+ */
+#define CPC_FDFLAG_ESI          BIT(3)
+#define CPC_FDFLAG_RTR          BIT(4)
+#define CPC_FDFLAG_NONCANFD_MSG BIT(5)
+#define CPC_FDFLAG_BRS          BIT(6)
+#define CPC_FDFLAG_XTD          BIT(7)
+
 /* Representation of the CAN parameters for the SJA1000 controller */
 struct cpc_sja1000_params {
 	u8 mode;
@@ -190,8 +211,9 @@ struct __packed ems_cpc_msg {
 	__le32 ts_nsec;	/* timestamp in nano seconds */
 
 	union {
-		u8 generic[64];
+		u8 generic[70];
 		struct cpc_can_msg can_msg;
+		struct cpc_canfd_msg canfd_msg;
 		struct cpc_can_params can_params;
 		struct cpc_confirm confirmation;
 		struct cpc_overrun overrun;
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
