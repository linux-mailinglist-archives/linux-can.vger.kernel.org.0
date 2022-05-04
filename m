Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FA2519757
	for <lists+linux-can@lfdr.de>; Wed,  4 May 2022 08:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242171AbiEDG34 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 May 2022 02:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbiEDG3z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 May 2022 02:29:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1F91FCDB
        for <linux-can@vger.kernel.org>; Tue,  3 May 2022 23:26:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nm8Sp-0006fF-35
        for linux-can@vger.kernel.org; Wed, 04 May 2022 08:26:19 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 180FC75614
        for <linux-can@vger.kernel.org>; Wed,  4 May 2022 06:26:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 4E44A7560E;
        Wed,  4 May 2022 06:26:17 +0000 (UTC)
Received: from blackshift.org (ip6-localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0df21d59;
        Wed, 4 May 2022 06:23:45 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Pavel Pisa <pisa@cmp.felk.cvut.cz>,
        Ondrej Ille <ondrej.ille@gmail.com>
Subject: [PATCH can-next] dt-binding: can: ctucanfd: include common CAN controller bindings
Date:   Wed,  4 May 2022 08:23:42 +0200
Message-Id: <20220504062342.52529-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
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

Since commit

| 1f9234401ce0 ("dt-bindings: can: add can-controller.yaml")

there is a common CAN controller binding. Add this to the ctucanfd
binding.

Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Ondrej Ille <ondrej.ille@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml b/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml
index fb34d971dcb3..4635cb96fc64 100644
--- a/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml
@@ -25,6 +25,9 @@ maintainers:
   - Ondrej Ille <ondrej.ille@gmail.com>
   - Martin Jerabek <martin.jerabek01@gmail.com>
 
+allOf:
+  - $ref: can-controller.yaml#
+
 properties:
   compatible:
     oneOf:
-- 
2.35.1


