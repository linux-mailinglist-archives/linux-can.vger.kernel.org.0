Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4E8756BD6
	for <lists+linux-can@lfdr.de>; Mon, 17 Jul 2023 20:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjGQSXS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jul 2023 14:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjGQSWu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jul 2023 14:22:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D7910DD
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 11:22:37 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLSrj-0001bx-Pa
        for linux-can@vger.kernel.org; Mon, 17 Jul 2023 20:22:35 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 049671F39F8
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 18:22:33 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 8E4631F39BF;
        Mon, 17 Jul 2023 18:22:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 37f8e5da;
        Mon, 17 Jul 2023 18:22:30 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Michal Simek <michal.simek@amd.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 5/8] dt-bindings: can: xilinx_can: Add reset description
Date:   Mon, 17 Jul 2023 20:22:26 +0200
Message-Id: <20230717182229.250565-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717182229.250565-1-mkl@pengutronix.de>
References: <20230717182229.250565-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Michal Simek <michal.simek@amd.com>

IP core has input for reset signal which can be connected that's why
describe optional reset property.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/all/bfaed896cc51af02fe5f290675313ab4dcab0d33.1689164442.git.michal.simek@amd.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
index 897d2cbda45b..64d57c343e6f 100644
--- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
+++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
@@ -46,6 +46,9 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: CAN Tx mailbox buffer count (CAN FD)
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.40.1


