Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C14EC115443
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 16:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfLFP3b (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 10:29:31 -0500
Received: from first.geanix.com ([116.203.34.67]:39574 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfLFP3b (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 6 Dec 2019 10:29:31 -0500
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id EBE753DB;
        Fri,  6 Dec 2019 15:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575646162; bh=Jx7Za35zEhAyBjbRsGf+9ncvQeff2YDd+FMYoGhM2Rk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FSVripNEm8cNc2pUGgtt/zl41HCZeSDcVX9ygOwUF5gY3J3ZSr8uqSa2tP95NntsS
         jFffyWMjczlBIiKmz5rhyjFr12Mh+OuzcA31QXSlvA5JobdRwkh3vrnbKsvwuYBLxD
         pGrbyEcchwtyRMA+3Cro3iFxbV5d6MX7zge9ZsWYXEDa0FCp3WUrszlNgjsUos6dF8
         DO3/6GJaboo1L0zb3XmDMlSqFUfV7g5kb9jklIRUNGu77x5iES5WG0mMznJJHo8OVp
         35ws+Kd3gQUngYot2mumRnEHkvObXPiNk0vH+usF21UmjoCZDDeZM0m8iuQG3W7nOm
         mBq52x1S2vjSQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org,
        robh+dt@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, devicetree@vger.kernel.org,
        martin@geanix.com
Subject: [PATCH 2/2] dt-bindings: can: tcan4x5x: reset pin is active high
Date:   Fri,  6 Dec 2019 16:29:23 +0100
Message-Id: <20191206152923.470980-2-sean@geanix.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206152923.470980-1-sean@geanix.com>
References: <20191206152923.470980-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=4.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8b5b6f358cc9
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Change the reset pin example to active high to be in line with
the datasheet

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
index 27e1b4cebfbd..e8aa21d9174e 100644
--- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
+++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
@@ -36,5 +36,5 @@ tcan4x5x: tcan4x5x@0 {
 		interrupts = <14 GPIO_ACTIVE_LOW>;
 		device-state-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
 		device-wake-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
 };
-- 
2.24.0

