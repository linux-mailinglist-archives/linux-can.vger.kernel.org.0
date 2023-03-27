Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43FE6CAC57
	for <lists+linux-can@lfdr.de>; Mon, 27 Mar 2023 19:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjC0RyK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 27 Mar 2023 13:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjC0RyI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 27 Mar 2023 13:54:08 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E5B10E
        for <linux-can@vger.kernel.org>; Mon, 27 Mar 2023 10:54:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679939640; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UsqXcW7uqYIlsFm4DZOgHQcH/3MR2u9z9tTOkcIX9ejHJnyML2SpC6RtBEZqMNX07v
    ms8qd1nh5ezFOrSvxfbusvm02eCULJOl3PDQ9dH9r22COkzBBU82/aWMiOhfSPnU1K+C
    VtLGVDMBzWE4ysU2XvEqc8k8mHUjkJJa1eMNvOsq6fycfUZygItRCrunOvvck1NWoiH1
    bI/BORn/GZZi9AbIUBl6fhmmCb93OmdUlZx3pQskq+bsLHZKaP+Yyq9A06hTId2wdB7w
    4qLaKW0l4qv8Z6B/CHml/h7szmCNWv01FwMLroSvsfalcdwCWS2Eq24FjST6ODW7RhW/
    uXZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1679939640;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=FwwlCqt/j55i0mpw+ToKWRQQs+ONq60CbPYgsXqVyt8=;
    b=RuhRw0e+bUAYJU9en0MbPfK/tsblQ026AaNLs5qe3IyIFeg2/TlewnQBHyMo3BCweL
    fOkQS1KuQxJ+T80Pzq9fydq9rn68iH21l2QgqGXFZ1RpdQQsaWe+YddCvHmFlg6QRCxJ
    hOI1uroRqwIicJJtF8AaV+e1Npc0U7p9Tedq9MYUtELjOoiUWwL2xX/pMlt/AIymHSnl
    I8v+Xgi3nzt3B2r4EIsDhrXKgxkjx8rG2cjfJySI0KA2nPVB14rR1maU11m/k49Fezzz
    t1HG9xoc2klF1UUrg6VEsQoMJb3KGnT1uBqU10l3ONO+9JdXkpEZUghEBUJU0+xb9Wrd
    KhVA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1679939640;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=FwwlCqt/j55i0mpw+ToKWRQQs+ONq60CbPYgsXqVyt8=;
    b=QUwqa5tXvmEizbgLOfgcal1RKVW/UapaWn4zMMdB3SWqS9FkIbORUl2BeO6uJTTxf/
    k6cizE3GUqTBXh3TqDJZBt9X2KQ3rjMwH1LGy/QGPRzl+zqE6XoxlAApt6axFzRJu+mA
    IOaInEQnbWcjiJbPV2Ful8aeUQ6gwjN3N2VmmpjVt0d5UxUGBdaGj7aZmrHYUguSkacs
    Z6hMaAFeFwmO5zFilColPESNiFhcITSqSfOVYKs/YHt7OiC/i0AziZaSX+adv+6EC7uq
    36xq8BFjssRn2FyJDbqOBl5sDv/OsrnuAoLvKlEDXEu1kOhHc3Mvp+TmpqUn3c0sXD03
    ixoQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfh+rd"
Received: from silver.lan
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id n9397fz2RHs0WLx
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 27 Mar 2023 19:54:00 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next] kvaser_usb: convert USB IDs to hexadecimal values
Date:   Mon, 27 Mar 2023 19:53:44 +0200
Message-Id: <20230327175344.4668-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

USB IDs are usually represented in 16 bit hexadecimal values.
To match the common representation in lsusb and for searching USB IDs
in the internet convert the decimal values to hexadecimal.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jimmy Assarsson <extja@kvaser.com>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 102 +++++++++---------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index d4c5356d5884..d0015f83f924 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -29,67 +29,67 @@
 #include <linux/can/netlink.h>
 
 #include "kvaser_usb.h"
 
 /* Kvaser USB vendor id. */
-#define KVASER_VENDOR_ID			0x0bfd
+#define KVASER_VENDOR_ID			0x0BFD
 
 /* Kvaser Leaf USB devices product ids */
-#define USB_LEAF_DEVEL_PRODUCT_ID		10
-#define USB_LEAF_LITE_PRODUCT_ID		11
-#define USB_LEAF_PRO_PRODUCT_ID			12
-#define USB_LEAF_SPRO_PRODUCT_ID		14
-#define USB_LEAF_PRO_LS_PRODUCT_ID		15
-#define USB_LEAF_PRO_SWC_PRODUCT_ID		16
-#define USB_LEAF_PRO_LIN_PRODUCT_ID		17
-#define USB_LEAF_SPRO_LS_PRODUCT_ID		18
-#define USB_LEAF_SPRO_SWC_PRODUCT_ID		19
-#define USB_MEMO2_DEVEL_PRODUCT_ID		22
-#define USB_MEMO2_HSHS_PRODUCT_ID		23
-#define USB_UPRO_HSHS_PRODUCT_ID		24
-#define USB_LEAF_LITE_GI_PRODUCT_ID		25
-#define USB_LEAF_PRO_OBDII_PRODUCT_ID		26
-#define USB_MEMO2_HSLS_PRODUCT_ID		27
-#define USB_LEAF_LITE_CH_PRODUCT_ID		28
-#define USB_BLACKBIRD_SPRO_PRODUCT_ID		29
-#define USB_OEM_MERCURY_PRODUCT_ID		34
-#define USB_OEM_LEAF_PRODUCT_ID			35
-#define USB_CAN_R_PRODUCT_ID			39
-#define USB_LEAF_LITE_V2_PRODUCT_ID		288
-#define USB_MINI_PCIE_HS_PRODUCT_ID		289
-#define USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID	290
-#define USB_USBCAN_LIGHT_2HS_PRODUCT_ID		291
-#define USB_MINI_PCIE_2HS_PRODUCT_ID		292
-#define USB_USBCAN_R_V2_PRODUCT_ID		294
-#define USB_LEAF_LIGHT_R_V2_PRODUCT_ID		295
-#define USB_LEAF_LIGHT_HS_V2_OEM2_PRODUCT_ID	296
+#define USB_LEAF_DEVEL_PRODUCT_ID		0x000A
+#define USB_LEAF_LITE_PRODUCT_ID		0x000B
+#define USB_LEAF_PRO_PRODUCT_ID			0x000C
+#define USB_LEAF_SPRO_PRODUCT_ID		0x000E
+#define USB_LEAF_PRO_LS_PRODUCT_ID		0x000F
+#define USB_LEAF_PRO_SWC_PRODUCT_ID		0x0010
+#define USB_LEAF_PRO_LIN_PRODUCT_ID		0x0011
+#define USB_LEAF_SPRO_LS_PRODUCT_ID		0x0012
+#define USB_LEAF_SPRO_SWC_PRODUCT_ID		0x0013
+#define USB_MEMO2_DEVEL_PRODUCT_ID		0x0016
+#define USB_MEMO2_HSHS_PRODUCT_ID		0x0017
+#define USB_UPRO_HSHS_PRODUCT_ID		0x0018
+#define USB_LEAF_LITE_GI_PRODUCT_ID		0x0019
+#define USB_LEAF_PRO_OBDII_PRODUCT_ID		0x001A
+#define USB_MEMO2_HSLS_PRODUCT_ID		0x001B
+#define USB_LEAF_LITE_CH_PRODUCT_ID		0x001C
+#define USB_BLACKBIRD_SPRO_PRODUCT_ID		0x001D
+#define USB_OEM_MERCURY_PRODUCT_ID		0x0022
+#define USB_OEM_LEAF_PRODUCT_ID			0x0023
+#define USB_CAN_R_PRODUCT_ID			0x0027
+#define USB_LEAF_LITE_V2_PRODUCT_ID		0x0120
+#define USB_MINI_PCIE_HS_PRODUCT_ID		0x0121
+#define USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID	0x0122
+#define USB_USBCAN_LIGHT_2HS_PRODUCT_ID		0x0123
+#define USB_MINI_PCIE_2HS_PRODUCT_ID		0x0124
+#define USB_USBCAN_R_V2_PRODUCT_ID		0x0126
+#define USB_LEAF_LIGHT_R_V2_PRODUCT_ID		0x0127
+#define USB_LEAF_LIGHT_HS_V2_OEM2_PRODUCT_ID	0x0128
 
 /* Kvaser USBCan-II devices product ids */
-#define USB_USBCAN_REVB_PRODUCT_ID		2
-#define USB_VCI2_PRODUCT_ID			3
-#define USB_USBCAN2_PRODUCT_ID			4
-#define USB_MEMORATOR_PRODUCT_ID		5
+#define USB_USBCAN_REVB_PRODUCT_ID		0x0002
+#define USB_VCI2_PRODUCT_ID			0x0003
+#define USB_USBCAN2_PRODUCT_ID			0x0004
+#define USB_MEMORATOR_PRODUCT_ID		0x0005
 
 /* Kvaser Minihydra USB devices product ids */
-#define USB_BLACKBIRD_V2_PRODUCT_ID		258
-#define USB_MEMO_PRO_5HS_PRODUCT_ID		260
-#define USB_USBCAN_PRO_5HS_PRODUCT_ID		261
-#define USB_USBCAN_LIGHT_4HS_PRODUCT_ID		262
-#define USB_LEAF_PRO_HS_V2_PRODUCT_ID		263
-#define USB_USBCAN_PRO_2HS_V2_PRODUCT_ID	264
-#define USB_MEMO_2HS_PRODUCT_ID			265
-#define USB_MEMO_PRO_2HS_V2_PRODUCT_ID		266
-#define USB_HYBRID_2CANLIN_PRODUCT_ID		267
-#define USB_ATI_USBCAN_PRO_2HS_V2_PRODUCT_ID	268
-#define USB_ATI_MEMO_PRO_2HS_V2_PRODUCT_ID	269
-#define USB_HYBRID_PRO_2CANLIN_PRODUCT_ID	270
-#define USB_U100_PRODUCT_ID			273
-#define USB_U100P_PRODUCT_ID			274
-#define USB_U100S_PRODUCT_ID			275
-#define USB_USBCAN_PRO_4HS_PRODUCT_ID		276
-#define USB_HYBRID_CANLIN_PRODUCT_ID		277
-#define USB_HYBRID_PRO_CANLIN_PRODUCT_ID	278
+#define USB_BLACKBIRD_V2_PRODUCT_ID		0x0102
+#define USB_MEMO_PRO_5HS_PRODUCT_ID		0x0104
+#define USB_USBCAN_PRO_5HS_PRODUCT_ID		0x0105
+#define USB_USBCAN_LIGHT_4HS_PRODUCT_ID		0x0106
+#define USB_LEAF_PRO_HS_V2_PRODUCT_ID		0x0107
+#define USB_USBCAN_PRO_2HS_V2_PRODUCT_ID	0x0108
+#define USB_MEMO_2HS_PRODUCT_ID			0x0109
+#define USB_MEMO_PRO_2HS_V2_PRODUCT_ID		0x010A
+#define USB_HYBRID_2CANLIN_PRODUCT_ID		0x010B
+#define USB_ATI_USBCAN_PRO_2HS_V2_PRODUCT_ID	0x010C
+#define USB_ATI_MEMO_PRO_2HS_V2_PRODUCT_ID	0x010D
+#define USB_HYBRID_PRO_2CANLIN_PRODUCT_ID	0x010E
+#define USB_U100_PRODUCT_ID			0x0111
+#define USB_U100P_PRODUCT_ID			0x0112
+#define USB_U100S_PRODUCT_ID			0x0113
+#define USB_USBCAN_PRO_4HS_PRODUCT_ID		0x0114
+#define USB_HYBRID_CANLIN_PRODUCT_ID		0x0115
+#define USB_HYBRID_PRO_CANLIN_PRODUCT_ID	0x0116
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
 	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.ops = &kvaser_usb_hydra_dev_ops,
 };
-- 
2.30.2

