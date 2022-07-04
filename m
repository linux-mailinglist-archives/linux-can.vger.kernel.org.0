Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467EC565628
	for <lists+linux-can@lfdr.de>; Mon,  4 Jul 2022 14:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbiGDMxH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 4 Jul 2022 08:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbiGDMwq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Jul 2022 08:52:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1081211C1A
        for <linux-can@vger.kernel.org>; Mon,  4 Jul 2022 05:52:40 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o8LZ0-00018U-DD
        for linux-can@vger.kernel.org; Mon, 04 Jul 2022 14:52:30 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 9B1FDA79CF
        for <linux-can@vger.kernel.org>; Mon,  4 Jul 2022 12:26:15 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 12AAEA7945;
        Mon,  4 Jul 2022 12:26:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6cff6fc0;
        Mon, 4 Jul 2022 12:26:14 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Jimmy Assarsson <extja@kvaser.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
Subject: [PATCH net 08/15] can: kvaser_usb: replace run-time checks with struct kvaser_usb_driver_info
Date:   Mon,  4 Jul 2022 14:26:06 +0200
Message-Id: <20220704122613.1551119-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220704122613.1551119-1-mkl@pengutronix.de>
References: <20220704122613.1551119-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Unify and move compile-time known information into new struct
kvaser_usb_driver_info, in favor of run-time checks.

All Kvaser USBcanII supports listen-only mode and error counter
reporting.

Link: https://lore.kernel.org/all/20220603083820.800246-2-extja@kvaser.com
Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
[mkl: move struct kvaser_usb_driver_info into kvaser_usb_core.c]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  22 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 274 ++++++++++--------
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  |  24 +-
 3 files changed, 172 insertions(+), 148 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 3a49257f9fa6..39d5bfd70ff4 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -35,9 +35,9 @@
 #define KVASER_USB_RX_BUFFER_SIZE		3072
 #define KVASER_USB_MAX_NET_DEVICES		5
 
-/* USB devices features */
-#define KVASER_USB_HAS_SILENT_MODE		BIT(0)
-#define KVASER_USB_HAS_TXRX_ERRORS		BIT(1)
+/* Kvaser USB device quirks */
+#define KVASER_USB_QUIRK_HAS_SILENT_MODE	BIT(0)
+#define KVASER_USB_QUIRK_HAS_TXRX_ERRORS	BIT(1)
 
 /* Device capabilities */
 #define KVASER_USB_CAP_BERR_CAP			0x01
@@ -65,12 +65,7 @@ struct kvaser_usb_dev_card_data_hydra {
 struct kvaser_usb_dev_card_data {
 	u32 ctrlmode_supported;
 	u32 capabilities;
-	union {
-		struct {
-			enum kvaser_usb_leaf_family family;
-		} leaf;
-		struct kvaser_usb_dev_card_data_hydra hydra;
-	};
+	struct kvaser_usb_dev_card_data_hydra hydra;
 };
 
 /* Context for an outstanding, not yet ACKed, transmission */
@@ -83,7 +78,7 @@ struct kvaser_usb {
 	struct usb_device *udev;
 	struct usb_interface *intf;
 	struct kvaser_usb_net_priv *nets[KVASER_USB_MAX_NET_DEVICES];
-	const struct kvaser_usb_dev_ops *ops;
+	const struct kvaser_usb_driver_info *driver_info;
 	const struct kvaser_usb_dev_cfg *cfg;
 
 	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
@@ -165,6 +160,12 @@ struct kvaser_usb_dev_ops {
 				  u16 transid);
 };
 
+struct kvaser_usb_driver_info {
+	u32 quirks;
+	enum kvaser_usb_leaf_family family;
+	const struct kvaser_usb_dev_ops *ops;
+};
+
 struct kvaser_usb_dev_cfg {
 	const struct can_clock clock;
 	const unsigned int timestamp_freq;
@@ -184,4 +185,5 @@ int kvaser_usb_send_cmd_async(struct kvaser_usb_net_priv *priv, void *cmd,
 			      int len);
 
 int kvaser_usb_can_rx_over_error(struct net_device *netdev);
+
 #endif /* KVASER_USB_H */
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index e67658b53d02..d5b293e673d8 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -61,8 +61,6 @@
 #define USB_USBCAN_R_V2_PRODUCT_ID		294
 #define USB_LEAF_LIGHT_R_V2_PRODUCT_ID		295
 #define USB_LEAF_LIGHT_HS_V2_OEM2_PRODUCT_ID	296
-#define USB_LEAF_PRODUCT_ID_END \
-	USB_LEAF_LIGHT_HS_V2_OEM2_PRODUCT_ID
 
 /* Kvaser USBCan-II devices product ids */
 #define USB_USBCAN_REVB_PRODUCT_ID		2
@@ -89,116 +87,144 @@
 #define USB_USBCAN_PRO_4HS_PRODUCT_ID		276
 #define USB_HYBRID_CANLIN_PRODUCT_ID		277
 #define USB_HYBRID_PRO_CANLIN_PRODUCT_ID	278
-#define USB_HYDRA_PRODUCT_ID_END \
-	USB_HYBRID_PRO_CANLIN_PRODUCT_ID
 
-static inline bool kvaser_is_leaf(const struct usb_device_id *id)
-{
-	return (id->idProduct >= USB_LEAF_DEVEL_PRODUCT_ID &&
-		id->idProduct <= USB_CAN_R_PRODUCT_ID) ||
-		(id->idProduct >= USB_LEAF_LITE_V2_PRODUCT_ID &&
-		 id->idProduct <= USB_LEAF_PRODUCT_ID_END);
-}
+static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
+	.quirks = 0,
+	.ops = &kvaser_usb_hydra_dev_ops,
+};
 
-static inline bool kvaser_is_usbcan(const struct usb_device_id *id)
-{
-	return id->idProduct >= USB_USBCAN_REVB_PRODUCT_ID &&
-	       id->idProduct <= USB_MEMORATOR_PRODUCT_ID;
-}
+static const struct kvaser_usb_driver_info kvaser_usb_driver_info_usbcan = {
+	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
+		  KVASER_USB_QUIRK_HAS_SILENT_MODE,
+	.family = KVASER_USBCAN,
+	.ops = &kvaser_usb_leaf_dev_ops,
+};
 
-static inline bool kvaser_is_hydra(const struct usb_device_id *id)
-{
-	return id->idProduct >= USB_BLACKBIRD_V2_PRODUCT_ID &&
-	       id->idProduct <= USB_HYDRA_PRODUCT_ID_END;
-}
+static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf = {
+	.quirks = 0,
+	.family = KVASER_LEAF,
+	.ops = &kvaser_usb_leaf_dev_ops,
+};
+
+static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err = {
+	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS,
+	.family = KVASER_LEAF,
+	.ops = &kvaser_usb_leaf_dev_ops,
+};
+
+static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err_listen = {
+	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
+		  KVASER_USB_QUIRK_HAS_SILENT_MODE,
+	.family = KVASER_LEAF,
+	.ops = &kvaser_usb_leaf_dev_ops,
+};
 
 static const struct usb_device_id kvaser_usb_table[] = {
 	/* Leaf USB product IDs */
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_DEVEL_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_DEVEL_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_SPRO_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_LS_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_SWC_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_LIN_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_SPRO_LS_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_SPRO_SWC_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO2_DEVEL_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO2_HSHS_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_UPRO_HSHS_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_GI_PRODUCT_ID) },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_GI_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_OBDII_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO2_HSLS_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_CH_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_BLACKBIRD_SPRO_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_OEM_MERCURY_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_OEM_LEAF_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_CAN_R_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_V2_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_HS_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_LIGHT_2HS_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_2HS_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_R_V2_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LIGHT_R_V2_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LIGHT_HS_V2_OEM2_PRODUCT_ID) },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_V2_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_HS_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_LIGHT_2HS_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_2HS_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_R_V2_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LIGHT_R_V2_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LIGHT_HS_V2_OEM2_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 
 	/* USBCANII USB product IDs */
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN2_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_usbcan },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_REVB_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_usbcan },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMORATOR_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_usbcan },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_VCI2_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_usbcan },
 
 	/* Minihydra USB product IDs */
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_BLACKBIRD_V2_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO_PRO_5HS_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_PRO_5HS_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_LIGHT_4HS_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_HS_V2_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_PRO_2HS_V2_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO_2HS_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO_PRO_2HS_V2_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_HYBRID_2CANLIN_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_ATI_USBCAN_PRO_2HS_V2_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_ATI_MEMO_PRO_2HS_V2_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_HYBRID_PRO_2CANLIN_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_U100_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_U100P_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_U100S_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_PRO_4HS_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_HYBRID_CANLIN_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_HYBRID_PRO_CANLIN_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_BLACKBIRD_V2_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO_PRO_5HS_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_PRO_5HS_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_LIGHT_4HS_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_HS_V2_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_PRO_2HS_V2_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO_2HS_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO_PRO_2HS_V2_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_HYBRID_2CANLIN_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_ATI_USBCAN_PRO_2HS_V2_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_ATI_MEMO_PRO_2HS_V2_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_HYBRID_PRO_2CANLIN_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_U100_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_U100P_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_U100S_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_PRO_4HS_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_HYBRID_CANLIN_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_HYBRID_PRO_CANLIN_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, kvaser_usb_table);
@@ -285,6 +311,7 @@ int kvaser_usb_can_rx_over_error(struct net_device *netdev)
 static void kvaser_usb_read_bulk_callback(struct urb *urb)
 {
 	struct kvaser_usb *dev = urb->context;
+	const struct kvaser_usb_dev_ops *ops = dev->driver_info->ops;
 	int err;
 	unsigned int i;
 
@@ -301,8 +328,8 @@ static void kvaser_usb_read_bulk_callback(struct urb *urb)
 		goto resubmit_urb;
 	}
 
-	dev->ops->dev_read_bulk_callback(dev, urb->transfer_buffer,
-					 urb->actual_length);
+	ops->dev_read_bulk_callback(dev, urb->transfer_buffer,
+				    urb->actual_length);
 
 resubmit_urb:
 	usb_fill_bulk_urb(urb, dev->udev,
@@ -396,6 +423,7 @@ static int kvaser_usb_open(struct net_device *netdev)
 {
 	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
 	struct kvaser_usb *dev = priv->dev;
+	const struct kvaser_usb_dev_ops *ops = dev->driver_info->ops;
 	int err;
 
 	err = open_candev(netdev);
@@ -406,11 +434,11 @@ static int kvaser_usb_open(struct net_device *netdev)
 	if (err)
 		goto error;
 
-	err = dev->ops->dev_set_opt_mode(priv);
+	err = ops->dev_set_opt_mode(priv);
 	if (err)
 		goto error;
 
-	err = dev->ops->dev_start_chip(priv);
+	err = ops->dev_start_chip(priv);
 	if (err) {
 		netdev_warn(netdev, "Cannot start device, error %d\n", err);
 		goto error;
@@ -467,22 +495,23 @@ static int kvaser_usb_close(struct net_device *netdev)
 {
 	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
 	struct kvaser_usb *dev = priv->dev;
+	const struct kvaser_usb_dev_ops *ops = dev->driver_info->ops;
 	int err;
 
 	netif_stop_queue(netdev);
 
-	err = dev->ops->dev_flush_queue(priv);
+	err = ops->dev_flush_queue(priv);
 	if (err)
 		netdev_warn(netdev, "Cannot flush queue, error %d\n", err);
 
-	if (dev->ops->dev_reset_chip) {
-		err = dev->ops->dev_reset_chip(dev, priv->channel);
+	if (ops->dev_reset_chip) {
+		err = ops->dev_reset_chip(dev, priv->channel);
 		if (err)
 			netdev_warn(netdev, "Cannot reset card, error %d\n",
 				    err);
 	}
 
-	err = dev->ops->dev_stop_chip(priv);
+	err = ops->dev_stop_chip(priv);
 	if (err)
 		netdev_warn(netdev, "Cannot stop device, error %d\n", err);
 
@@ -521,6 +550,7 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 {
 	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
 	struct kvaser_usb *dev = priv->dev;
+	const struct kvaser_usb_dev_ops *ops = dev->driver_info->ops;
 	struct net_device_stats *stats = &netdev->stats;
 	struct kvaser_usb_tx_urb_context *context = NULL;
 	struct urb *urb;
@@ -563,8 +593,7 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 		goto freeurb;
 	}
 
-	buf = dev->ops->dev_frame_to_cmd(priv, skb, &cmd_len,
-					 context->echo_index);
+	buf = ops->dev_frame_to_cmd(priv, skb, &cmd_len, context->echo_index);
 	if (!buf) {
 		stats->tx_dropped++;
 		dev_kfree_skb(skb);
@@ -648,15 +677,16 @@ static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
 	}
 }
 
-static int kvaser_usb_init_one(struct kvaser_usb *dev,
-			       const struct usb_device_id *id, int channel)
+static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 {
 	struct net_device *netdev;
 	struct kvaser_usb_net_priv *priv;
+	const struct kvaser_usb_driver_info *driver_info = dev->driver_info;
+	const struct kvaser_usb_dev_ops *ops = driver_info->ops;
 	int err;
 
-	if (dev->ops->dev_reset_chip) {
-		err = dev->ops->dev_reset_chip(dev, channel);
+	if (ops->dev_reset_chip) {
+		err = ops->dev_reset_chip(dev, channel);
 		if (err)
 			return err;
 	}
@@ -685,20 +715,19 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev,
 	priv->can.state = CAN_STATE_STOPPED;
 	priv->can.clock.freq = dev->cfg->clock.freq;
 	priv->can.bittiming_const = dev->cfg->bittiming_const;
-	priv->can.do_set_bittiming = dev->ops->dev_set_bittiming;
-	priv->can.do_set_mode = dev->ops->dev_set_mode;
-	if ((id->driver_info & KVASER_USB_HAS_TXRX_ERRORS) ||
+	priv->can.do_set_bittiming = ops->dev_set_bittiming;
+	priv->can.do_set_mode = ops->dev_set_mode;
+	if ((driver_info->quirks & KVASER_USB_QUIRK_HAS_TXRX_ERRORS) ||
 	    (priv->dev->card_data.capabilities & KVASER_USB_CAP_BERR_CAP))
-		priv->can.do_get_berr_counter = dev->ops->dev_get_berr_counter;
-	if (id->driver_info & KVASER_USB_HAS_SILENT_MODE)
+		priv->can.do_get_berr_counter = ops->dev_get_berr_counter;
+	if (driver_info->quirks & KVASER_USB_QUIRK_HAS_SILENT_MODE)
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
 
 	priv->can.ctrlmode_supported |= dev->card_data.ctrlmode_supported;
 
 	if (priv->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
 		priv->can.data_bittiming_const = dev->cfg->data_bittiming_const;
-		priv->can.do_set_data_bittiming =
-					dev->ops->dev_set_data_bittiming;
+		priv->can.do_set_data_bittiming = ops->dev_set_data_bittiming;
 	}
 
 	netdev->flags |= IFF_ECHO;
@@ -729,29 +758,22 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	struct kvaser_usb *dev;
 	int err;
 	int i;
+	const struct kvaser_usb_driver_info *driver_info;
+	const struct kvaser_usb_dev_ops *ops;
+
+	driver_info = (const struct kvaser_usb_driver_info *)id->driver_info;
+	if (!driver_info)
+		return -ENODEV;
 
 	dev = devm_kzalloc(&intf->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 
-	if (kvaser_is_leaf(id)) {
-		dev->card_data.leaf.family = KVASER_LEAF;
-		dev->ops = &kvaser_usb_leaf_dev_ops;
-	} else if (kvaser_is_usbcan(id)) {
-		dev->card_data.leaf.family = KVASER_USBCAN;
-		dev->ops = &kvaser_usb_leaf_dev_ops;
-	} else if (kvaser_is_hydra(id)) {
-		dev->ops = &kvaser_usb_hydra_dev_ops;
-	} else {
-		dev_err(&intf->dev,
-			"Product ID (%d) is not a supported Kvaser USB device\n",
-			id->idProduct);
-		return -ENODEV;
-	}
-
 	dev->intf = intf;
+	dev->driver_info = driver_info;
+	ops = driver_info->ops;
 
-	err = dev->ops->dev_setup_endpoints(dev);
+	err = ops->dev_setup_endpoints(dev);
 	if (err) {
 		dev_err(&intf->dev, "Cannot get usb endpoint(s)");
 		return err;
@@ -765,22 +787,22 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 
 	dev->card_data.ctrlmode_supported = 0;
 	dev->card_data.capabilities = 0;
-	err = dev->ops->dev_init_card(dev);
+	err = ops->dev_init_card(dev);
 	if (err) {
 		dev_err(&intf->dev,
 			"Failed to initialize card, error %d\n", err);
 		return err;
 	}
 
-	err = dev->ops->dev_get_software_info(dev);
+	err = ops->dev_get_software_info(dev);
 	if (err) {
 		dev_err(&intf->dev,
 			"Cannot get software info, error %d\n", err);
 		return err;
 	}
 
-	if (dev->ops->dev_get_software_details) {
-		err = dev->ops->dev_get_software_details(dev);
+	if (ops->dev_get_software_details) {
+		err = ops->dev_get_software_details(dev);
 		if (err) {
 			dev_err(&intf->dev,
 				"Cannot get software details, error %d\n", err);
@@ -798,14 +820,14 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 
 	dev_dbg(&intf->dev, "Max outstanding tx = %d URBs\n", dev->max_tx_urbs);
 
-	err = dev->ops->dev_get_card_info(dev);
+	err = ops->dev_get_card_info(dev);
 	if (err) {
 		dev_err(&intf->dev, "Cannot get card info, error %d\n", err);
 		return err;
 	}
 
-	if (dev->ops->dev_get_capabilities) {
-		err = dev->ops->dev_get_capabilities(dev);
+	if (ops->dev_get_capabilities) {
+		err = ops->dev_get_capabilities(dev);
 		if (err) {
 			dev_err(&intf->dev,
 				"Cannot get capabilities, error %d\n", err);
@@ -815,7 +837,7 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	}
 
 	for (i = 0; i < dev->nchannels; i++) {
-		err = kvaser_usb_init_one(dev, id, i);
+		err = kvaser_usb_init_one(dev, i);
 		if (err) {
 			kvaser_usb_remove_interfaces(dev);
 			return err;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index c805b999c543..5cf940ba3f7f 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -404,7 +404,7 @@ kvaser_usb_leaf_frame_to_cmd(const struct kvaser_usb_net_priv *priv,
 				      sizeof(struct kvaser_cmd_tx_can);
 		cmd->u.tx_can.channel = priv->channel;
 
-		switch (dev->card_data.leaf.family) {
+		switch (dev->driver_info->family) {
 		case KVASER_LEAF:
 			cmd_tx_can_flags = &cmd->u.tx_can.leaf.flags;
 			break;
@@ -550,7 +550,7 @@ static int kvaser_usb_leaf_get_software_info_inner(struct kvaser_usb *dev)
 	if (err)
 		return err;
 
-	switch (dev->card_data.leaf.family) {
+	switch (dev->driver_info->family) {
 	case KVASER_LEAF:
 		kvaser_usb_leaf_get_software_info_leaf(dev, &cmd.u.leaf.softinfo);
 		break;
@@ -597,7 +597,7 @@ static int kvaser_usb_leaf_get_card_info(struct kvaser_usb *dev)
 
 	dev->nchannels = cmd.u.cardinfo.nchannels;
 	if (dev->nchannels > KVASER_USB_MAX_NET_DEVICES ||
-	    (dev->card_data.leaf.family == KVASER_USBCAN &&
+	    (dev->driver_info->family == KVASER_USBCAN &&
 	     dev->nchannels > MAX_USBCAN_NET_DEVICES))
 		return -EINVAL;
 
@@ -730,7 +730,7 @@ kvaser_usb_leaf_rx_error_update_can_state(struct kvaser_usb_net_priv *priv,
 	    new_state < CAN_STATE_BUS_OFF)
 		priv->can.can_stats.restarts++;
 
-	switch (dev->card_data.leaf.family) {
+	switch (dev->driver_info->family) {
 	case KVASER_LEAF:
 		if (es->leaf.error_factor) {
 			priv->can.can_stats.bus_error++;
@@ -809,7 +809,7 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 		}
 	}
 
-	switch (dev->card_data.leaf.family) {
+	switch (dev->driver_info->family) {
 	case KVASER_LEAF:
 		if (es->leaf.error_factor) {
 			cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_PROT;
@@ -999,7 +999,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 	stats = &priv->netdev->stats;
 
 	if ((cmd->u.rx_can_header.flag & MSG_FLAG_ERROR_FRAME) &&
-	    (dev->card_data.leaf.family == KVASER_LEAF &&
+	    (dev->driver_info->family == KVASER_LEAF &&
 	     cmd->id == CMD_LEAF_LOG_MESSAGE)) {
 		kvaser_usb_leaf_leaf_rx_error(dev, cmd);
 		return;
@@ -1015,7 +1015,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 		return;
 	}
 
-	switch (dev->card_data.leaf.family) {
+	switch (dev->driver_info->family) {
 	case KVASER_LEAF:
 		rx_data = cmd->u.leaf.rx_can.data;
 		break;
@@ -1030,7 +1030,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 		return;
 	}
 
-	if (dev->card_data.leaf.family == KVASER_LEAF && cmd->id ==
+	if (dev->driver_info->family == KVASER_LEAF && cmd->id ==
 	    CMD_LEAF_LOG_MESSAGE) {
 		cf->can_id = le32_to_cpu(cmd->u.leaf.log_message.id);
 		if (cf->can_id & KVASER_EXTENDED_FRAME)
@@ -1128,14 +1128,14 @@ static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
 		break;
 
 	case CMD_LEAF_LOG_MESSAGE:
-		if (dev->card_data.leaf.family != KVASER_LEAF)
+		if (dev->driver_info->family != KVASER_LEAF)
 			goto warn;
 		kvaser_usb_leaf_rx_can_msg(dev, cmd);
 		break;
 
 	case CMD_CHIP_STATE_EVENT:
 	case CMD_CAN_ERROR_EVENT:
-		if (dev->card_data.leaf.family == KVASER_LEAF)
+		if (dev->driver_info->family == KVASER_LEAF)
 			kvaser_usb_leaf_leaf_rx_error(dev, cmd);
 		else
 			kvaser_usb_leaf_usbcan_rx_error(dev, cmd);
@@ -1147,12 +1147,12 @@ static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
 
 	/* Ignored commands */
 	case CMD_USBCAN_CLOCK_OVERFLOW_EVENT:
-		if (dev->card_data.leaf.family != KVASER_USBCAN)
+		if (dev->driver_info->family != KVASER_USBCAN)
 			goto warn;
 		break;
 
 	case CMD_FLUSH_QUEUE_REPLY:
-		if (dev->card_data.leaf.family != KVASER_LEAF)
+		if (dev->driver_info->family != KVASER_LEAF)
 			goto warn;
 		break;
 
-- 
2.35.1


