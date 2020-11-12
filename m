Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A812B0C3A
	for <lists+linux-can@lfdr.de>; Thu, 12 Nov 2020 19:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgKLSE4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Nov 2020 13:04:56 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:48779 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgKLSE4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Nov 2020 13:04:56 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id D8B46FFA90
        for <linux-can@vger.kernel.org>; Thu, 12 Nov 2020 18:04:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y1RS_KVlK49W for <linux-can@vger.kernel.org>;
        Thu, 12 Nov 2020 19:04:53 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH v2 11/16] can: ems_usb: Added ems_usb_write_mode_fd
Date:   Thu, 12 Nov 2020 19:03:41 +0100
Message-Id: <20201112180346.29070-12-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
References: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch enables the supported CAN controller modes for CPC-USB/FD

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 8ada663350fa..6d8f733c6c7f 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -689,6 +689,32 @@ static int ems_usb_write_mode_arm7(struct ems_usb *dev, u32 mode)
 	return ems_usb_command_msg(dev, &dev->active_params);
 }
 
+static int ems_usb_write_mode_fd(struct ems_usb *dev, u32 mode)
+{
+	struct cpc_generic_can_params *gcp =
+		&dev->active_params.msg.can_params.cc_params.generic;
+
+	if (mode == CPC_USB_RESET_MODE) {
+		gcp->config |= cpu_to_le32(CPC_GENERICCONF_RESET_MODE);
+	} else if (mode == CPC_USB_RUN_MODE) {
+		gcp->config &= cpu_to_le32(~CPC_GENERICCONF_RESET_MODE);
+
+		if (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+			gcp->config |= cpu_to_le32(CPC_GENERICCONF_LISTEN_ONLY);
+		else
+			gcp->config &= cpu_to_le32(~CPC_GENERICCONF_LISTEN_ONLY);
+
+		if (dev->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+			gcp->config |= cpu_to_le32(CPC_GENERICCONF_SINGLE_SHOT);
+		else
+			gcp->config &= cpu_to_le32(~CPC_GENERICCONF_SINGLE_SHOT);
+	} else {
+		return -EINVAL;
+	}
+
+	return ems_usb_command_msg(dev, &dev->active_params);
+}
+
 /* Send a CPC_Control command to change behaviour when interface receives a CAN
  * message, bus error or CAN state changed notifications.
  */
@@ -1256,12 +1282,14 @@ static int ems_usb_probe(struct usb_interface *intf,
 		dev->can.data_bittiming_const = &ems_usb_bittiming_const_generic_data;
 		dev->can.do_set_bittiming = ems_usb_set_bittiming_generic;
 		dev->can.do_set_data_bittiming = ems_usb_set_bittiming_generic_data;
+		dev->can.do_set_mode = ems_usb_set_mode;
 		dev->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
 					      CAN_CTRLMODE_ONE_SHOT |
 					      CAN_CTRLMODE_BERR_REPORTING |
 					      CAN_CTRLMODE_FD |
 					      CAN_CTRLMODE_FD_NON_ISO;
 		init_params_generic(&dev->active_params);
+		dev->ems_usb_write_mode = ems_usb_write_mode_fd;
 		dev->bulk_rd_buf_size = CPC_USB_FD_RX_BUFFER_SIZE;
 	break;
 
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
