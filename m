Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46720158DE8
	for <lists+linux-can@lfdr.de>; Tue, 11 Feb 2020 13:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgBKMEv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Feb 2020 07:04:51 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:25352 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgBKMEv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Feb 2020 07:04:51 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Thomas.Kopp@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Thomas.Kopp@microchip.com";
  x-sender="Thomas.Kopp@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Thomas.Kopp@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Thomas.Kopp@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: NJ8CRVmA8TuplqU4yXiELBmz6AyLz5nAcyLdSMk0kKTJKoQiyzRLswJ4Hs9lHqInq2UNdbeUiU
 QyX2ha78aPd3pEnVLXgRxXk7CR6k3tDccgsP0BmOtra0bguS6fWrm8RlFN++070/hR80y+LFcR
 Lx/cOVpLmRTgd9ONP9D1/Je83YT75W3EsLAhUxXZiJPZqF/xY8eGeFdDkDawJFvc/CdSU/K9bL
 XfuxEaYhVz3BaB6/JW/5s9wgO+K9EB5pffQvdB7NHbkuJY1WyhbkOX4M029Sf0D/NQppbjbYsc
 eGE=
X-IronPort-AV: E=Sophos;i="5.70,428,1574146800"; 
   d="scan'208";a="64965346"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2020 05:04:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Feb 2020 05:04:49 -0700
Received: from HNO-LT-M43677A.microchip.com (10.10.85.251) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 11 Feb 2020 05:04:49 -0700
From:   Thomas Kopp <thomas.kopp@microchip.com>
To:     <linux-can@vger.kernel.org>
CC:     <mkl@pengutronix.de>, <thomas.kopp@microchip.com>
Subject: [PATCH] can: mcp25xxfd: minor register definition fixes
Date:   Tue, 11 Feb 2020 13:04:46 +0100
Message-ID: <20200211120446.1390-1-thomas.kopp@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Thomas Kopp <thomas.kopp@microchip.com>
---
Hi Marc,
I started testing your driver at https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/drivers/net/can/spi/mcp25xxfd?h=v5.4/mcp25xxfd and noticed two small things in the register definitions. Overall TX seems to be working fine - one thing I noticed when testing with cangen can0 -b -g 0 and another external node periodically sending frames on the bus (with 2ms gaps) I'm eventually getting stuffing errors from which the driver never really recovers. As soon as the external node then stops sending messages, the MCP2518FD node stops sending as well and gets unresponsive (ssh isn't possible anymore etc.). When resuming the external CAN traffic the node becomes responsive again. The driver was compiled with Additional Debugging output and Logging enabled. Ifconfig doesn't show any RX/TX errors and shows plausible numbers for packets transmitted/received. Am I chasing ghosts here or have you encountered similar behaviour?
Best Regards,
Thomas

 drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h
index 6bf211673d0e..13af06d7fd67 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h
@@ -94,7 +94,7 @@ static inline void __dump(const void *d, unsigned int len)
 #define MCP25XXFD_CAN_TDC 0x0c
 #define MCP25XXFD_CAN_TDC_EDGFLTEN BIT(25)
 #define MCP25XXFD_CAN_TDC_SID11EN BIT(24)
-#define MCP25XXFD_CAN_TDC_TDCMOD_MASK GENMASK(17, 6)
+#define MCP25XXFD_CAN_TDC_TDCMOD_MASK GENMASK(17, 16)
 #define MCP25XXFD_CAN_TDC_TDCMOD_AUTO 2
 #define MCP25XXFD_CAN_TDC_TDCMOD_MANUAL 1
 #define MCP25XXFD_CAN_TDC_TDCMOD_DISABLED 0
@@ -304,7 +304,7 @@ static inline void __dump(const void *d, unsigned int len)
 #define MCP25XXFD_CAN_FLTOBJ(x) (0x1f0 + 8 * (x))
 #define MCP25XXFD_CAN_FLTOBJ_EXIDE BIT(30)
 #define MCP25XXFD_CAN_FLTOBJ_SID11 BIT(29)
-#define MCP25XXFD_CAN_FLTOBJ_EID_MASK GENMASK(28. 11)
+#define MCP25XXFD_CAN_FLTOBJ_EID_MASK GENMASK(28, 11)
 #define MCP25XXFD_CAN_FLTOBJ_SID_MASK GENMASK(10, 0)
 
 #define MCP25XXFD_CAN_FLTMASK(x) (0x1f4 + 8 * (x))
-- 
2.17.1

