Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7450449A759
	for <lists+linux-can@lfdr.de>; Tue, 25 Jan 2022 03:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357801AbiAYCh1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 24 Jan 2022 21:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3409129AbiAYAZF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 24 Jan 2022 19:25:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AB9C0C63D2
        for <linux-can@vger.kernel.org>; Mon, 24 Jan 2022 14:06:58 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nC7UH-0004RK-0B
        for linux-can@vger.kernel.org; Mon, 24 Jan 2022 23:06:57 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D157F213CC
        for <linux-can@vger.kernel.org>; Mon, 24 Jan 2022 22:06:54 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 91CC0213B6;
        Mon, 24 Jan 2022 22:06:54 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b85cd05a;
        Mon, 24 Jan 2022 22:06:54 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        lrich Hecht <uli+renesas@fpond.eu>
Subject: [PATCH net-next 4/4] dt-binding: can: rcar-can: include common CAN controller bindings
Date:   Mon, 24 Jan 2022 23:06:53 +0100
Message-Id: <20220124220653.3477172-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124220653.3477172-1-mkl@pengutronix.de>
References: <20220124220653.3477172-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since commit

| 1f9234401ce0 ("dt-bindings: can: add can-controller.yaml")

there is a common CAN controller binding. Add this to the rcar-can
binding.

Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lrich Hecht <uli+renesas@fpond.eu>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../devicetree/bindings/net/can/renesas,rcar-can.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-can.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-can.yaml
index fadc871fd6b0..64247d3635e9 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-can.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-can.yaml
@@ -9,6 +9,9 @@ title: Renesas R-Car CAN Controller
 maintainers:
   - Sergei Shtylyov <sergei.shtylyov@gmail.com>
 
+allOf:
+  - $ref: can-controller.yaml#
+
 properties:
   compatible:
     oneOf:
-- 
2.34.1


