Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698593AA752
	for <lists+linux-can@lfdr.de>; Thu, 17 Jun 2021 01:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhFPXT4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Jun 2021 19:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbhFPXTz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Jun 2021 19:19:55 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D012C061574;
        Wed, 16 Jun 2021 16:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1623885466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m7KVCAK7iXGjxO1S5uOhHWczpAYoTH+/+pkV0JwaCyo=;
        b=tJt3U2nP2BhcTVPz2DJtfcS/tA8yAKA+0z23DjdPOdAs6xE5YxxHQgC1rcG2goBSezKSEy
        njyuNaXAMTvTcYXIx/dV15A2/l4ODrqm4LOHFFRl/6f1AqU0h5fWBo91oWK0jKMRYYAn3x
        Eyth+2yuoy4wPivpKDAlueOByBc8JEA=
Received: from dfj.1.1.1.1 (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id 1ce47e53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Jun 2021 23:17:46 +0000 (UTC)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     gerg@linux-m68k.org, wg@grandegger.com, mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com,
        Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v2 2/5] m68k: stmark2: update board setup
Date:   Thu, 17 Jun 2021 01:16:49 +0200
Message-Id: <20210616231652.738027-2-angelo@kernel-space.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616231652.738027-1-angelo@kernel-space.org>
References: <20210616231652.738027-1-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add configuration for flexcan pads.

---
Changes for v2:
none

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
 arch/m68k/coldfire/stmark2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/coldfire/stmark2.c b/arch/m68k/coldfire/stmark2.c
index 8b5af9c83244..036a6ae5f599 100644
--- a/arch/m68k/coldfire/stmark2.c
+++ b/arch/m68k/coldfire/stmark2.c
@@ -111,7 +111,9 @@ static int __init init_stmark2(void)
 	__raw_writeb(0x00, MCFGPIO_PAR_BE);
 	__raw_writeb(0x00, MCFGPIO_PAR_FBCTL);
 	__raw_writeb(0x00, MCFGPIO_PAR_CS);
-	__raw_writeb(0x00, MCFGPIO_PAR_CANI2C);
+
+	/* CAN pads */
+	__raw_writeb(0x50, MCFGPIO_PAR_CANI2C);
 
 	platform_add_devices(stmark2_devices, ARRAY_SIZE(stmark2_devices));
 
@@ -121,4 +123,4 @@ static int __init init_stmark2(void)
 	return 0;
 }
 
-late_initcall(init_stmark2);
+device_initcall(init_stmark2);
-- 
2.31.1

