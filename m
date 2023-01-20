Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A74675366
	for <lists+linux-can@lfdr.de>; Fri, 20 Jan 2023 12:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjATL1X (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Jan 2023 06:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjATL1W (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Jan 2023 06:27:22 -0500
Received: from mail3.ems-wuensche.com (mail3.ems-wuensche.com [81.169.186.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 154C24E53A
        for <linux-can@vger.kernel.org>; Fri, 20 Jan 2023 03:27:18 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 3B86EFF4E9
        for <linux-can@vger.kernel.org>; Fri, 20 Jan 2023 11:27:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Score: -1.902
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3_7Q0uAmG5p7 for <linux-can@vger.kernel.org>;
        Fri, 20 Jan 2023 12:27:16 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org, mkl@pengutronix.de
Cc:     vincent.mailhol@gmail.com, wg@grandegger.com,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH v2 8/8] can: ems_pci: Add myself as module author
Date:   Fri, 20 Jan 2023 12:26:16 +0100
Message-Id: <20230120112616.6071-9-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230120112616.6071-1-uttenthaler@ems-wuensche.com>
References: <20230120112616.6071-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Added myself as module author

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/sja1000/ems_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index e720b7f3db34..6c6baaeb06f9 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -21,6 +21,7 @@
 #define DRV_NAME  "ems_pci"
 
 MODULE_AUTHOR("Sebastian Haas <support@ems-wuensche.com>");
+MODULE_AUTHOR("Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>");
 MODULE_DESCRIPTION("Socket-CAN driver for EMS CPC-PCI/PCIe/104P CAN cards");
 MODULE_LICENSE("GPL v2");
 
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
