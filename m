Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93413114667
	for <lists+linux-can@lfdr.de>; Thu,  5 Dec 2019 18:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfLER7d (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Dec 2019 12:59:33 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56250 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbfLER7d (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Dec 2019 12:59:33 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB5HxLsQ058077;
        Thu, 5 Dec 2019 11:59:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575568761;
        bh=mguqbPVDAdK1QM+8tGeS8vWBb5+cMg4Np8A4x6stZbU=;
        h=From:To:CC:Subject:Date;
        b=Ss0Wtuu551oaNHcLuI2DoZVwNRqSvmun3HHBKXsSFWFC/bx4x/7APtpWY9YP1wBXs
         nn/4lIX602nXQ7Ye/vLpxdcRflt7uSSL1Biv4b8CnzG+U/1eqxt7SCRemVlWI55w9Z
         TipjVuWLRZfLFsxgD/qo+lTZkefREIV90cBZ6cRw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB5HxKSO032802;
        Thu, 5 Dec 2019 11:59:20 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Dec
 2019 11:59:20 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Dec 2019 11:59:20 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB5HxK6E022405;
        Thu, 5 Dec 2019 11:59:20 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-kernel@vger.kernel.org>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <wg@grandegger.com>,
        <sriram.dash@samsung.com>
CC:     <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <robh@kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] MAINTAINERS: Add myself as a maintainer for MMIO m_can
Date:   Thu, 5 Dec 2019 11:57:15 -0600
Message-ID: <20191205175716.9905-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since I refactored the code to create a m_can framework and we
have a MMIO MCAN IP as well add myself to help maintain the code.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ecc354f4b692..64f51f312707 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10096,6 +10096,7 @@ F:	drivers/media/radio/radio-maxiradio*
 
 MCAN MMIO DEVICE DRIVER
 M:	Sriram Dash <sriram.dash@samsung.com>
+M:	Dan Murphy <dmurphy@ti.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/m_can.txt
-- 
2.23.0

