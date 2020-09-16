Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8649826C1A0
	for <lists+linux-can@lfdr.de>; Wed, 16 Sep 2020 12:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgIPK1J (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Sep 2020 06:27:09 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:42384 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgIPKT0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Sep 2020 06:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600251565; x=1631787565;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wBMWVsYbct4I7iWQUi/vl1et8VkHkEgjH2l7i3mGURo=;
  b=WQyTI52Qz06FkLBJM7MwOBeCpm3I0ulTS0feSBHlSxKnvWtPpUVLIg8n
   bI0kf+bxiS6NI3B13vdl9D183GC4z8L/QUiRmUpOOlomyy9pZF0q1ORj7
   +gIxMHorylkPIOi/TUQ95s1jiYBbgNIXc/swBfwE1f0kNp/KeXtg+avRX
   WLMQujsbzn7DVkQHbc2pq8N7ICDecVOTqsfxgU9WYSeu7sWXPzphJEb+L
   IfKv3QDkZFgiB6jzPl7/3WyxgN6x7sEEiFMaSd03dxCDa3pQBrn0fZke/
   KLbf31m0HyJrxDoDi3cpvVKPSJQia8whORKpcP8oVMGsE/dAJr+X+v3Rj
   g==;
IronPort-SDR: jfwUfRMVej8+55KxFgbyaBkuIFDHzjO3VwHwFg4E/yDJJwyh1sqIpb/QPmhqIHiXo0JO9gwux2
 D8GPMc8QOs6GEOJldUdh2yBt8P1qMM0LrwqzWWN7G3Uf4Pewls3zOfzcv5EMHPIdvVro0MLV+o
 ETbBjYu6ydQAt+XtLejoXCNLJq+ZbnD/VROtUj0hikB5+mAZsE7Q/fLMSZMwDwqRCL+COf+FEL
 hs0QKpzJTT42zMehvijRzHDuYKQt9T4ZWJszD87J7V9uHfafBzOEV2p7kdXaNUWKQLlzvYQIA/
 /9E=
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="95986441"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2020 03:13:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Sep 2020 03:13:35 -0700
Received: from HNO-LT-M43677A.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 16 Sep 2020 03:13:19 -0700
From:   Thomas Kopp <thomas.kopp@microchip.com>
To:     <linux-can@vger.kernel.org>
CC:     <mkl@pengutronix.de>, <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] MAINTAINERS: Add reviewer entry for microchip mcp25xxfd SPI-CAN network driver
Date:   Wed, 16 Sep 2020 12:13:34 +0200
Message-ID: <20200916101334.1277-1-thomas.kopp@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fcb63f0c9635..e3c1c70057e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10674,6 +10674,7 @@ F:	drivers/hid/hid-mcp2221.c
 MCP25XXFD SPI-CAN NETWORK DRIVER
 M:	Marc Kleine-Budde <mkl@pengutronix.de>
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+R:	Thomas Kopp <thomas.kopp@microchip.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
-- 
2.25.1

