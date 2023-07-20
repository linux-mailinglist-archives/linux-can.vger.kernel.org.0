Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1435975B193
	for <lists+linux-can@lfdr.de>; Thu, 20 Jul 2023 16:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjGTOsz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 20 Jul 2023 10:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjGTOsx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 20 Jul 2023 10:48:53 -0400
X-Greylist: delayed 471 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Jul 2023 07:48:50 PDT
Received: from mail3.ems-wuensche.com (mail3.ems-wuensche.com [81.169.186.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C399A26B8
        for <linux-can@vger.kernel.org>; Thu, 20 Jul 2023 07:48:50 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id EEC91FF350
        for <linux-can@vger.kernel.org>; Thu, 20 Jul 2023 14:40:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Score: -1.912
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DakZnjOoAEQL for <linux-can@vger.kernel.org>;
        Thu, 20 Jul 2023 16:40:57 +0200 (CEST)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     mkl@pengutronix.de, vincent.mailhol@gmail.com,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH] MAINTAINERS: Add myself as maintainer of the ems_pci.c driver
Date:   Thu, 20 Jul 2023 16:40:32 +0200
Message-Id: <20230720144032.28960-1-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

At the suggestion of Marc Kleine-Budde [1], I add myself as maintainer of the ems_pci.c driver.

[1] https://lore.kernel.org/all/20230720-purplish-quizzical-247024e66671-mkl@pengutronix.de/

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dfbb271f1667..610591a0ace5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7585,6 +7585,13 @@ L:	linux-mmc@vger.kernel.org
 S:	Supported
 F:	drivers/mmc/host/cqhci*
 
+EMS CPC-PCI CAN DRIVER
+M:	Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
+M:	support@ems-wuensche.com
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/sja1000/ems_pci.c
+
 EMULEX 10Gbps iSCSI - OneConnect DRIVER
 M:	Ketan Mukadam <ketan.mukadam@broadcom.com>
 L:	linux-scsi@vger.kernel.org
-- 
2.35.3

--
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
