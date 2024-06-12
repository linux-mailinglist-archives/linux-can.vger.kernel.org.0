Return-Path: <linux-can+bounces-723-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF12905523
	for <lists+linux-can@lfdr.de>; Wed, 12 Jun 2024 16:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB43BB21536
	for <lists+linux-can@lfdr.de>; Wed, 12 Jun 2024 14:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B05F17E456;
	Wed, 12 Jun 2024 14:29:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0D917E450
	for <linux-can@vger.kernel.org>; Wed, 12 Jun 2024 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718202573; cv=none; b=Xa3Yf767a59GBFuTXGpW04rvLL4MB+QHegS+VfazkzG0bhya3VyQ4SRc14FpkTWdDl0zPOvcuKjNBtZtC4Rbvt0b9xTsoaYZSNuAFWPGGOJthkwnIoo83l16uZPZUmCPIOwxEg5rdbckgjvSOEyhKNneOxNuIMZu7sa0AjvBaIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718202573; c=relaxed/simple;
	bh=t6XhiMOR5D7FNfmEZ3+Lmf6aOenjFwVl3lb+tsEeEvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K+kn6PvfEdkc0mj+drJvKcthJhugQkzqX0Q+ei6LzeJkTsHjMTHvCxBX8VcWnerggDsJgpfCpvK+BRWItTCuDA18eDecJh4Az+Y1+q7aqaSEnzfWzti12XfRzWbB+jQuPgfPgxjqoO9UMdkgs0tJDV1EutVTMzlI9OwoTSRjg7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id AB2D4E00B0;
	Wed, 12 Jun 2024 16:19:49 +0200 (CEST)
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH 1/3] can: kvaser_usb: Add support for Vining 800
Date: Wed, 12 Jun 2024 16:19:44 +0200
Message-Id: <20240612141946.3352364-2-martin.jocic@kvaser.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240612141946.3352364-1-martin.jocic@kvaser.com>
References: <20240612141946.3352364-1-martin.jocic@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Vining 800, a branded device based on the hydra
platform.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
---
 drivers/net/can/usb/Kconfig                      | 1 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index bd58c636d465..d01b46a8071a 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -117,6 +117,7 @@ config CAN_KVASER_USB
 	    - Kvaser U100S
 	    - ATI Memorator Pro 2xHS v2
 	    - ATI USBcan Pro 2xHS v2
+	    - Vining 800
 
 	  If unsure, say N.
 
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 8faf8a462c05..b828fad123b2 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -89,6 +89,7 @@
 #define USB_HYBRID_CANLIN_PRODUCT_ID 0x0115
 #define USB_HYBRID_PRO_CANLIN_PRODUCT_ID 0x0116
 #define USB_LEAF_V3_PRODUCT_ID 0x0117
+#define USB_VINING_800_PRODUCT_ID 0x0119
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
 	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
@@ -238,6 +239,8 @@ static const struct usb_device_id kvaser_usb_table[] = {
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_V3_PRODUCT_ID),
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_VINING_800_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, kvaser_usb_table);
-- 
2.40.1


