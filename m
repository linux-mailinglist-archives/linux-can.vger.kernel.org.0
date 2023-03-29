Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC14B6CD5FC
	for <lists+linux-can@lfdr.de>; Wed, 29 Mar 2023 11:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjC2JJo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 29 Mar 2023 05:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjC2JJo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 29 Mar 2023 05:09:44 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A17019BA
        for <linux-can@vger.kernel.org>; Wed, 29 Mar 2023 02:09:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680080969; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tglIiGexhex4nKTEBiTri7ZVTWkohrsN30/aSr15Ug7+Y4BaLFaYed2qN+xcgKzRMU
    BGqvulGCdDqz/IwRoehx8nPe/nK3sD6iXMp+Ug04Qgk3QSaNKMIVEMKFskqGJKYqTD8d
    YNajxqiP766Iz5g5FyU3uz3AWdC2qA/lxIi/yiw/LVeVsCEn7pkoOQqhL/7y2LquCcml
    2h4Qc6bGh8EH0A0vaCTm0oLY40Lf/jiP0De+v21awEpgt7szzvEDso5JT4tBVDpYZ8hN
    SdP22y4ijVug0S4NHhVxPVw+58/AJTAaxJyoqosMcbDNM9WtGaPGSCyXiJDMzQcVBCDj
    P4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680080969;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=4Lwbn4HXpLWamSMTL1OW8XXrCgzNvK2I0ZaVeGcZ9hE=;
    b=DTjJaOyCLAA/GKYdP1doS13xYbf8kd+44n+KPDl9n3cSK7RvK7cPhRzdDObGUXy0lO
    F0KlxyvEgV+h9mptJDgcxVZ70ew15gSnvlakIbaL/Ux8ucghNDPXtfU8TXQkeqeMU8+i
    41Y/wfsqOBN9ua2JRquOkgJJvs8hjHqGChTcPl1K514f57SCs9DGvJcwQ4X06ZjkEpAO
    nt59ep9zkHZqOfq8LAVA6KWDY/BqtutSAtLgD9GfjBFkCwlHDJ6pvvNjooUERBZfxTa9
    CRst1ZoKvMvI2+ofenbmdfV6dhDf8Jat4VDxCMOWl+t83ChPo0vaS39FJvy5V/0oMKbw
    582A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680080969;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=4Lwbn4HXpLWamSMTL1OW8XXrCgzNvK2I0ZaVeGcZ9hE=;
    b=NoFluEKtmMayNwwO4pGbZ24vhEWHyd9WvFGpPsDErZdUs7ek8Q+qC7PSJHIgPbyYJB
    8D3WJwkAkh9eAm2Y41tsjwW1QkzVMUTSuVc+z9OJnIl4jfqfBXQlV7Z3/5QGppuSOtBS
    BxNUqMW0sSP0z73bnmc/UqsLLezMYotB/rqCg6zv9Wu8dUCq6qgE+iIpP986+DdvwrJ6
    WAqwh6fcq0m7Jye8VIHTj5cYWjkNn4nXjMrLWBRp5rPGT8Szl8Pe0qFNKI19W6xFVmew
    1a/tSm/s1l71zGUa5P4IOLP4nvf53DAvH+E2XWQhZqLaZ9VVluJ0lIOaw7NIJQv+L6pS
    Mjdw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS8n/QfmFMLQeogKjM+Ci1u"
Received: from silver.monzoon.net
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id n9397fz2T99Tbsq
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 29 Mar 2023 11:09:29 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Jimmy Assarsson <extja@kvaser.com>,
        Alexander Dahl <ada@thorsis.com>
Subject: [PATCH can-next v2] kvaser_usb: convert USB IDs to hexadecimal values
Date:   Wed, 29 Mar 2023 11:09:15 +0200
Message-Id: <20230329090915.3127-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

USB IDs are usually represented in 16 bit hexadecimal values.
To match the common representation in lsusb and for searching USB IDs
in the internet convert the decimal values to lowercase hexadecimal.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Alexander Dahl <ada@thorsis.com>
---

v2: - drop the aligned block indentation (suggested by Jimmy)
    - use lowercase hex values (suggested by Alex)

.../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 102 +++++++++---------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index d4c5356d5884..7135ec851341 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -29,67 +29,67 @@
 #include <linux/can/netlink.h>
 
 #include "kvaser_usb.h"
 
 /* Kvaser USB vendor id. */
-#define KVASER_VENDOR_ID			0x0bfd
+#define KVASER_VENDOR_ID 0x0bfd
 
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
+#define USB_LEAF_DEVEL_PRODUCT_ID 0x000a
+#define USB_LEAF_LITE_PRODUCT_ID 0x000b
+#define USB_LEAF_PRO_PRODUCT_ID 0x000c
+#define USB_LEAF_SPRO_PRODUCT_ID 0x000e
+#define USB_LEAF_PRO_LS_PRODUCT_ID 0x000f
+#define USB_LEAF_PRO_SWC_PRODUCT_ID 0x0010
+#define USB_LEAF_PRO_LIN_PRODUCT_ID 0x0011
+#define USB_LEAF_SPRO_LS_PRODUCT_ID 0x0012
+#define USB_LEAF_SPRO_SWC_PRODUCT_ID 0x0013
+#define USB_MEMO2_DEVEL_PRODUCT_ID 0x0016
+#define USB_MEMO2_HSHS_PRODUCT_ID 0x0017
+#define USB_UPRO_HSHS_PRODUCT_ID 0x0018
+#define USB_LEAF_LITE_GI_PRODUCT_ID 0x0019
+#define USB_LEAF_PRO_OBDII_PRODUCT_ID 0x001a
+#define USB_MEMO2_HSLS_PRODUCT_ID 0x001b
+#define USB_LEAF_LITE_CH_PRODUCT_ID 0x001c
+#define USB_BLACKBIRD_SPRO_PRODUCT_ID 0x001d
+#define USB_OEM_MERCURY_PRODUCT_ID 0x0022
+#define USB_OEM_LEAF_PRODUCT_ID 0x0023
+#define USB_CAN_R_PRODUCT_ID 0x0027
+#define USB_LEAF_LITE_V2_PRODUCT_ID 0x0120
+#define USB_MINI_PCIE_HS_PRODUCT_ID 0x0121
+#define USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID 0x0122
+#define USB_USBCAN_LIGHT_2HS_PRODUCT_ID 0x0123
+#define USB_MINI_PCIE_2HS_PRODUCT_ID 0x0124
+#define USB_USBCAN_R_V2_PRODUCT_ID 0x0126
+#define USB_LEAF_LIGHT_R_V2_PRODUCT_ID 0x0127
+#define USB_LEAF_LIGHT_HS_V2_OEM2_PRODUCT_ID 0x0128
 
 /* Kvaser USBCan-II devices product ids */
-#define USB_USBCAN_REVB_PRODUCT_ID		2
-#define USB_VCI2_PRODUCT_ID			3
-#define USB_USBCAN2_PRODUCT_ID			4
-#define USB_MEMORATOR_PRODUCT_ID		5
+#define USB_USBCAN_REVB_PRODUCT_ID 0x0002
+#define USB_VCI2_PRODUCT_ID 0x0003
+#define USB_USBCAN2_PRODUCT_ID 0x0004
+#define USB_MEMORATOR_PRODUCT_ID 0x0005
 
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
+#define USB_BLACKBIRD_V2_PRODUCT_ID 0x0102
+#define USB_MEMO_PRO_5HS_PRODUCT_ID 0x0104
+#define USB_USBCAN_PRO_5HS_PRODUCT_ID 0x0105
+#define USB_USBCAN_LIGHT_4HS_PRODUCT_ID 0x0106
+#define USB_LEAF_PRO_HS_V2_PRODUCT_ID 0x0107
+#define USB_USBCAN_PRO_2HS_V2_PRODUCT_ID 0x0108
+#define USB_MEMO_2HS_PRODUCT_ID 0x0109
+#define USB_MEMO_PRO_2HS_V2_PRODUCT_ID 0x010a
+#define USB_HYBRID_2CANLIN_PRODUCT_ID 0x010b
+#define USB_ATI_USBCAN_PRO_2HS_V2_PRODUCT_ID 0x010c
+#define USB_ATI_MEMO_PRO_2HS_V2_PRODUCT_ID 0x010d
+#define USB_HYBRID_PRO_2CANLIN_PRODUCT_ID 0x010e
+#define USB_U100_PRODUCT_ID 0x0111
+#define USB_U100P_PRODUCT_ID 0x0112
+#define USB_U100S_PRODUCT_ID 0x0113
+#define USB_USBCAN_PRO_4HS_PRODUCT_ID 0x0114
+#define USB_HYBRID_CANLIN_PRODUCT_ID 0x0115
+#define USB_HYBRID_PRO_CANLIN_PRODUCT_ID 0x0116
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
 	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.ops = &kvaser_usb_hydra_dev_ops,
 };
-- 
2.30.2

