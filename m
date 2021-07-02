Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71003B9E85
	for <lists+linux-can@lfdr.de>; Fri,  2 Jul 2021 11:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhGBJwe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Jul 2021 05:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhGBJwe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Jul 2021 05:52:34 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FD3C061762;
        Fri,  2 Jul 2021 02:50:01 -0700 (PDT)
Received: from ziongate (localhost [127.0.0.1])
        by ziongate (OpenSMTPD) with ESMTP id 2d19de6b;
        Fri, 2 Jul 2021 09:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=kernel-space.org; h=from:to
        :cc:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=default; bh=ECvJ9Cyxo33qhlhGsOSluc
        /EX/g=; b=ocz6K3wCjZ7OzyEKGWbDu5/g/iLm/POIcSETMYbJ9ukL1jpzhhPIQ+
        +O87tMPRQZH2SycPCOQ4w9ZLG6MEkNB5+879NbRCOXuOcIhwlZuADsnYFRPOoCyV
        JnuL0tYrNKU9gbwCEoWLkG16HeQnC8r1R1IrPe2zx7675jqGPKrSg=
DomainKey-Signature: a=rsa-sha1; c=simple; d=kernel-space.org; h=from:to
        :cc:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=default; b=XMNkCkvy2Aa+h4iY
        B/1fu3uq46mvXcdVOkro2QyJXof/i1akTnleqq3RBBTO8zbpk1ZjTDL8q277G+kX
        3RAmBS0jXSX51WOy5+JQngfUCQCVne6QWQBfv4duDoznzJvPG9RmtByh4F4MQbGh
        uILBz3xBd6bAGy5kW88uR52iqKQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1625219399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GHHjPO7gqPKABLVxaaNEquMN5wofZyoCFa64+0hZaOY=;
        b=t/NrxEjcZoT0FrVprWUndIRWwjVdo+FuuWjmxoPD+3bT7SRNQGciPRP83GYqp2WL1+FE7e
        kDn+e9zsZKpJNOMmPZDw5YXwRA5aabsRmcYCFe1wyB2WQrPqg10VsFkyGxNtt5EsIxVWPE
        o3ABnB+xM0IBUbjHWyXI3Szw3cyYDF0=
Received: from dfj.bfc.timesys.com (<unknown> [95.236.232.230])
        by ziongate (OpenSMTPD) with ESMTPSA id 5bdd83e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 2 Jul 2021 09:49:59 +0000 (UTC)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     gerg@linux-m68k.org, wg@grandegger.com, mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com,
        Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v5 2/5] m68k: stmark2: update board setup
Date:   Fri,  2 Jul 2021 11:48:38 +0200
Message-Id: <20210702094841.327679-2-angelo@kernel-space.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210702094841.327679-1-angelo@kernel-space.org>
References: <20210702094841.327679-1-angelo@kernel-space.org>
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
Changes for v5:
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

