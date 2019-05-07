Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 785EC16109
	for <lists+linux-can@lfdr.de>; Tue,  7 May 2019 11:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfEGJfM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 May 2019 05:35:12 -0400
Received: from first.geanix.com ([116.203.34.67]:44194 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfEGJfM (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 7 May 2019 05:35:12 -0400
Received: from localhost.localdomain (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 369049A4;
        Tue,  7 May 2019 09:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1557221671; bh=Pd8q3/s2f6PUgoD4hgdXCCpxwqFUSFL5YGrmr0pSyWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XP3X90C9NDs8maiEDoD+NSWimXCvUDDU4uBX69uQv7C9CQBpIg5YLMYq5PI07Ezwa
         YxxmFVXqO1tcsuUAYfQcRkD9KQqJAlb2hVbhtl4GbKehVJdPD471y0EOAe9TcZOoJQ
         /BTKZgx5PyrRo806BzF/0Z87SYYDnq5kep1iWRPqk4VWLAfLCcAAzNl3mFQzPME3Es
         Op8U4B7u/y5VqpM0/0+pbIo+rhpcrupHxfbi68bv/q1qBxUqfYcAoqVsCh5B/zJ6Ih
         1+j8Arid2cLB9xaRcTtnxAQ6uCdXZDlXHRwnq9WzTFuG0XuEZdB0slZiuG4ZTrF9nc
         WxWdqZmpOMErQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        mkl@pengutronix.de
Cc:     Sean Nyekjaer <sean@geanix.com>, robh+dt@kernel.org
Subject: [PATCH 2/2] dt-bindings: can: mcp251x: add mcp25625 support
Date:   Tue,  7 May 2019 11:34:37 +0200
Message-Id: <20190507093437.26025-2-sean@geanix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190507093437.26025-1-sean@geanix.com>
References: <20190507093437.26025-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 9cf0eadf640b
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fully compatible with mcp2515, the mcp25625 have
integrated transceiver.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt b/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
index 188c8bd4eb67..5a0111d4de58 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
@@ -4,6 +4,7 @@ Required properties:
  - compatible: Should be one of the following:
    - "microchip,mcp2510" for MCP2510.
    - "microchip,mcp2515" for MCP2515.
+   - "microchip,mcp25625" for MCP25625.
  - reg: SPI chip select.
  - clocks: The clock feeding the CAN controller.
  - interrupts: Should contain IRQ line for the CAN controller.
-- 
2.21.0

