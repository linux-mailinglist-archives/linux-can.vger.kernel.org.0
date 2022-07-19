Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD10579AD0
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 14:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiGSMU1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 08:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239622AbiGSMTh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 08:19:37 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195495887B
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 05:07:02 -0700 (PDT)
Received: from stf-laptop.peak-system.com (unknown [89.158.146.116])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 8E469200594;
        Tue, 19 Jul 2022 14:06:56 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 3/3] can: peak_usb: Includes support for a new MCU
Date:   Tue, 19 Jul 2022 14:06:32 +0200
Message-Id: <20220719120632.26774-3-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719120632.26774-1-s.grosjean@peak-system.com>
References: <20220719120632.26774-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_FAIL,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The CANFD-USB PCAN-USB FD interface undergoes an internal component change
that requires a slight modification of its drivers, which leads them to
dynamically use endpoint numbers provided by the interface itself.
In addition to a change in the calls to the USB functions exported by the
kernel, the detection of the USB interface dedicated to CAN must also be
modified, as some PEAK-System devices support other interfaces than CAN.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 70 ++++++++++++++++++----
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 65487ec33566..267a70d3a5d1 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -33,6 +33,10 @@
 #define PCAN_UFD_RX_BUFFER_SIZE		2048
 #define PCAN_UFD_TX_BUFFER_SIZE		512
 
+/* struct pcan_ufd_fw_info::type */
+#define PCAN_USBFD_TYPE_STD		1
+#define PCAN_USBFD_TYPE_EXT		2	/* includes EP numbers */
+
 /* read some versions info from the hw device */
 struct __packed pcan_ufd_fw_info {
 	__le16	size_of;	/* sizeof this */
@@ -44,6 +48,13 @@ struct __packed pcan_ufd_fw_info {
 	__le32	dev_id[2];	/* "device id" per CAN */
 	__le32	ser_no;		/* S/N */
 	__le32	flags;		/* special functions */
+
+	/* extended data when type == PCAN_USBFD_TYPE_EXT */
+	u8	cmd_out_ep;	/* ep for cmd */
+	u8	cmd_in_ep;	/* ep for replies */
+	u8	data_out_ep[2];	/* ep for CANx TX */
+	u8	data_in_ep;	/* ep for CAN RX */
+	u8	dummy[3];
 };
 
 /* handle device specific info used by the netdevices */
@@ -171,6 +182,9 @@ static inline void *pcan_usb_fd_cmd_buffer(struct peak_usb_device *dev)
 /* send PCAN-USB Pro FD commands synchronously */
 static int pcan_usb_fd_send_cmd(struct peak_usb_device *dev, void *cmd_tail)
 {
+	struct pcan_usb_fd_device *pdev =
+		container_of(dev, struct pcan_usb_fd_device, dev);
+	struct pcan_ufd_fw_info *fw_info = &pdev->usb_if->fw_info;
 	void *cmd_head = pcan_usb_fd_cmd_buffer(dev);
 	int err = 0;
 	u8 *packet_ptr;
@@ -200,7 +214,7 @@ static int pcan_usb_fd_send_cmd(struct peak_usb_device *dev, void *cmd_tail)
 	do {
 		err = usb_bulk_msg(dev->udev,
 				   usb_sndbulkpipe(dev->udev,
-						   PCAN_USBPRO_EP_CMDOUT),
+						   fw_info->cmd_out_ep),
 				   packet_ptr, packet_len,
 				   NULL, PCAN_UFD_CMD_TIMEOUT_MS);
 		if (err) {
@@ -426,6 +440,9 @@ static int pcan_usb_fd_set_bittiming_fast(struct peak_usb_device *dev,
 static int pcan_usb_fd_restart_async(struct peak_usb_device *dev,
 				     struct urb *urb, u8 *buf)
 {
+	struct pcan_usb_fd_device *pdev =
+		container_of(dev, struct pcan_usb_fd_device, dev);
+	struct pcan_ufd_fw_info *fw_info = &pdev->usb_if->fw_info;
 	u8 *pc = buf;
 
 	/* build the entire cmds list in the provided buffer, to go back into
@@ -439,7 +456,7 @@ static int pcan_usb_fd_restart_async(struct peak_usb_device *dev,
 
 	/* complete the URB */
 	usb_fill_bulk_urb(urb, dev->udev,
-			  usb_sndbulkpipe(dev->udev, PCAN_USBPRO_EP_CMDOUT),
+			  usb_sndbulkpipe(dev->udev, fw_info->cmd_out_ep),
 			  buf, pc - buf,
 			  pcan_usb_pro_restart_complete, dev);
 
@@ -839,6 +856,17 @@ static int pcan_usb_fd_get_berr_counter(const struct net_device *netdev,
 	return 0;
 }
 
+/*
+ * probe function for all PCAN-USB FD family usb interfaces.
+ */
+static int pcan_usb_fd_probe(struct usb_interface *intf)
+{
+	struct usb_host_interface *iface_desc = &intf->altsetting[0];
+
+	/* CAN interface is always interface #0 */
+	return iface_desc->desc.bInterfaceNumber;
+}
+
 /* stop interface (last chance before set bus off) */
 static int pcan_usb_fd_stop(struct peak_usb_device *dev)
 {
@@ -860,6 +888,7 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 {
 	struct pcan_usb_fd_device *pdev =
 			container_of(dev, struct pcan_usb_fd_device, dev);
+	struct pcan_ufd_fw_info *fw_info;
 	int i, err = -ENOMEM;
 
 	/* do this for 1st channel only */
@@ -878,10 +907,12 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 		/* number of ts msgs to ignore before taking one into account */
 		pdev->usb_if->cm_ignore_count = 5;
 
+		fw_info = &pdev->usb_if->fw_info;
+
 		err = pcan_usb_pro_send_req(dev, PCAN_USBPRO_REQ_INFO,
 					    PCAN_USBPRO_INFO_FW,
-					    &pdev->usb_if->fw_info,
-					    sizeof(pdev->usb_if->fw_info));
+					    fw_info,
+					    sizeof(*fw_info));
 		if (err) {
 			dev_err(dev->netdev->dev.parent,
 				"unable to read %s firmware info (err %d)\n",
@@ -895,14 +926,14 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 		 */
 		dev_info(dev->netdev->dev.parent,
 			 "PEAK-System %s v%u fw v%u.%u.%u (%u channels)\n",
-			 dev->adapter->name, pdev->usb_if->fw_info.hw_version,
-			 pdev->usb_if->fw_info.fw_version[0],
-			 pdev->usb_if->fw_info.fw_version[1],
-			 pdev->usb_if->fw_info.fw_version[2],
+			 dev->adapter->name, fw_info->hw_version,
+			 fw_info->fw_version[0],
+			 fw_info->fw_version[1],
+			 fw_info->fw_version[2],
 			 dev->adapter->ctrl_count);
 
 		/* check for ability to switch between ISO/non-ISO modes */
-		if (pdev->usb_if->fw_info.fw_version[0] >= 2) {
+		if (fw_info->fw_version[0] >= 2) {
 			/* firmware >= 2.x supports ISO/non-ISO switching */
 			dev->can.ctrlmode_supported |= CAN_CTRLMODE_FD_NON_ISO;
 		} else {
@@ -910,6 +941,14 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 			dev->can.ctrlmode |= CAN_CTRLMODE_FD_NON_ISO;
 		}
 
+		/* if vendor rsp is of type 2, then it contains EP numbers to
+		 * use for cmds pipes. If not, then default EP should be used.
+		 */
+		if (fw_info->type != PCAN_USBFD_TYPE_EXT) {
+			fw_info->cmd_out_ep = PCAN_USBPRO_EP_CMDOUT;
+			fw_info->cmd_in_ep = PCAN_USBPRO_EP_CMDIN;
+		}
+
 		/* tell the hardware the can driver is running */
 		err = pcan_usb_fd_drv_loaded(dev, 1);
 		if (err) {
@@ -930,12 +969,23 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 		/* do a copy of the ctrlmode[_supported] too */
 		dev->can.ctrlmode = ppdev->dev.can.ctrlmode;
 		dev->can.ctrlmode_supported = ppdev->dev.can.ctrlmode_supported;
+
+		fw_info = &pdev->usb_if->fw_info;
 	}
 
 	pdev->usb_if->dev[dev->ctrl_idx] = dev;
 	dev->device_number =
 		le32_to_cpu(pdev->usb_if->fw_info.dev_id[dev->ctrl_idx]);
 
+	/* if vendor rsp is of type 2, then it contains EP numbers to
+	 * use for data pipes. If not, then statically defined EP are used
+	 * (see peak_usb_create_dev()).
+	 */
+	if (fw_info->type == PCAN_USBFD_TYPE_EXT) {
+		dev->ep_msg_in = fw_info->data_in_ep;
+		dev->ep_msg_out = fw_info->data_out_ep[dev->ctrl_idx];
+	}
+
 	/* set clock domain */
 	for (i = 0; i < ARRAY_SIZE(pcan_usb_fd_clk_freq); i++)
 		if (dev->adapter->clock.freq == pcan_usb_fd_clk_freq[i])
@@ -1091,7 +1141,7 @@ const struct peak_usb_adapter pcan_usb_fd = {
 	.tx_buffer_size = PCAN_UFD_TX_BUFFER_SIZE,
 
 	/* device callbacks */
-	.intf_probe = pcan_usb_pro_probe,	/* same as PCAN-USB Pro */
+	.intf_probe = pcan_usb_fd_probe,
 	.dev_init = pcan_usb_fd_init,
 
 	.dev_exit = pcan_usb_fd_exit,
-- 
2.34.1

