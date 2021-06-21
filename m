Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC2A3AF576
	for <lists+linux-can@lfdr.de>; Mon, 21 Jun 2021 20:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhFUSth (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Jun 2021 14:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhFUStg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Jun 2021 14:49:36 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E4FC061574;
        Mon, 21 Jun 2021 11:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1624301240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1SnPLFIfuWfSyGTkfECmwCl/i8AJTYKvPA+HqHuoIgk=;
        b=hzaX3t5Q8ZpTFg2iiTf+J4LTEjYp9cwKCflRbC09hETm2Jx/IxA+n6xqXu90z/Gj9ByRGI
        c0jlh7mig8yT8j1bHzWn4hv1csngMPevRdVDl+HZXV5fx4JKBbadssMD7sMnEuhYfqpDZU
        ACgysTCHrpZTSMjPqjJlyWEjooQW1uA=
Received: from dfj.bfc.timesys.com (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id 43b3086a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 21 Jun 2021 18:47:20 +0000 (UTC)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     gerg@linux-m68k.org, wg@grandegger.com, mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com,
        Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v3 4/5] can: flexcan: update Kconfig to allow non-of cases
Date:   Mon, 21 Jun 2021 20:46:14 +0200
Message-Id: <20210621184615.3345846-4-angelo@kernel-space.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210621184615.3345846-1-angelo@kernel-space.org>
References: <20210621184615.3345846-1-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Update flexcan to support architectures without fdt.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
Changes for v2:
none
Changes for v3:
- change to just remove OF
---
 drivers/net/can/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index e355d3974977..a0f4ae7ccb84 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -97,7 +97,7 @@ config CAN_AT91
 
 config CAN_FLEXCAN
 	tristate "Support for Freescale FLEXCAN based chips"
-	depends on OF && HAS_IOMEM
+	depends on HAS_IOMEM
 	help
 	  Say Y here if you want to support for Freescale FlexCAN.
 
-- 
2.31.1

