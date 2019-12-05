Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCF8114669
	for <lists+linux-can@lfdr.de>; Thu,  5 Dec 2019 18:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbfLER7h (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Dec 2019 12:59:37 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52214 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbfLER7g (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Dec 2019 12:59:36 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB5HxLiN119277;
        Thu, 5 Dec 2019 11:59:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575568761;
        bh=jQhG6yR5lvOIRfZdBQ4a8XVR+ntF/rHQC65tp+1R5PU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=a8QsKTIws+aoAWYZWehpJZi/XfR/43CBW3ikYE+VbxEex6h+uEdY2ld04al0GLpwo
         wkXDEZK1+nQcbHEU/E96dKn6fF5uPTU5GszC+xnPjEbXXEwZ8fAK6/oRX5LCGO1LBn
         fQMBZkLk3HTFh7s18uH7caS9nzwsQJ1YpFzoCbQA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB5HxL7b042042
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Dec 2019 11:59:21 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Dec
 2019 11:59:20 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Dec 2019 11:59:20 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB5HxKWb075600;
        Thu, 5 Dec 2019 11:59:20 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-kernel@vger.kernel.org>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <wg@grandegger.com>,
        <sriram.dash@samsung.com>
CC:     <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <robh@kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/2] MAINTAINERS: Add myself as a maintainer for TCAN4x5x
Date:   Thu, 5 Dec 2019 11:57:16 -0600
Message-ID: <20191205175716.9905-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205175716.9905-1-dmurphy@ti.com>
References: <20191205175716.9905-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Adding myself to support the TI TCAN4X5X SPI CAN device.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64f51f312707..cbd8764dcec3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16498,6 +16498,12 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Odd Fixes
 F:	sound/soc/codecs/tas571x*
 
+TI TCAN4X5X DEVICE DRIVER
+M:	Dan Murphy <dmurphy@ti.com>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/m_can/tcan4x5x.c
+
 TI TRF7970A NFC DRIVER
 M:	Mark Greer <mgreer@animalcreek.com>
 L:	linux-wireless@vger.kernel.org
-- 
2.23.0

