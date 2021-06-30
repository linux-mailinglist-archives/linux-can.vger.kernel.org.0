Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86C03B8AC0
	for <lists+linux-can@lfdr.de>; Thu,  1 Jul 2021 01:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhF3XEG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 30 Jun 2021 19:04:06 -0400
Received: from mail.kernel-space.org ([195.201.34.187]:59578 "EHLO
        mail.kernel-space.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhF3XEG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Jun 2021 19:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1625094093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OC2atBQYSHKT1C+vdyI62X0uCb/rX4yvt449kNC8P/M=;
        b=LBN+od0sTnfKKzFmadRLyQ6GnCj4nBQMYH8Gg1RFux/NjiUIZoYyjXtnfnd0sG+7oV2tVm
        O34utazXCicrYNIoV0rvUtBCXIagA4ajUqYOnbKYek7b08d5m7fkEiGhsAa28KP8kk9nfF
        0kjPvVK9IDp6ZoRoVUu5oAb2lQj/7mk=
Received: from dfj.bfc.timesys.com (host-87-4-238-130.retail.telecomitalia.it [87.4.238.130])
        by ziongate (OpenSMTPD) with ESMTPSA id 530afb2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 30 Jun 2021 23:01:33 +0000 (UTC)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     gerg@linux-m68k.org, wg@grandegger.com, mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com,
        Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v4 2/5] m68k: stmark2: update board setup
Date:   Thu,  1 Jul 2021 01:00:13 +0200
Message-Id: <20210630230016.4099050-2-angelo@kernel-space.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630230016.4099050-1-angelo@kernel-space.org>
References: <20210630230016.4099050-1-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add configuration for flexcan pads.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
Changes for v2:
none
Changes for v3:
none
Changes for v4:
none
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

