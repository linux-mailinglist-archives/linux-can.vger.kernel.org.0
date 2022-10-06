Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302ED5F6E47
	for <lists+linux-can@lfdr.de>; Thu,  6 Oct 2022 21:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiJFTgG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Oct 2022 15:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJFTgD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2022 15:36:03 -0400
X-Greylist: delayed 478 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Oct 2022 12:36:01 PDT
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9747CE99B
        for <linux-can@vger.kernel.org>; Thu,  6 Oct 2022 12:36:01 -0700 (PDT)
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id F06E7200D0
        for <linux-can@vger.kernel.org>; Thu,  6 Oct 2022 19:28:01 +0000 (UTC)
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [151.80.165.199])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 35796206D5
        for <linux-can@vger.kernel.org>; Thu,  6 Oct 2022 19:27:59 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id E322D401F1;
        Thu,  6 Oct 2022 21:27:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 4D7BB2A391;
        Thu,  6 Oct 2022 19:27:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 66GK5uFgcjSw; Thu,  6 Oct 2022 19:27:53 +0000 (UTC)
Received: from mail15.mymailcheap.com (mail15.mymailcheap.com [141.94.164.103])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Thu,  6 Oct 2022 19:27:53 +0000 (UTC)
Received: from daniel6430.localnet (c-73-64-181-209.hsd1.pa.comcast.net [73.64.181.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail15.mymailcheap.com (Postfix) with ESMTPSA id 484CD20033;
        Thu,  6 Oct 2022 19:27:51 +0000 (UTC)
From:   "Daniel S. Trevitz" <dan@sstrev.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Daniel Trevitz <daniel.trevitz@wika.com>,
        Ryan Edwards <ryan.edwards@gmail.com>
Subject: [PATCH 1/1] Termination resistor documentation
Date:   Thu, 06 Oct 2022 15:27:50 -0400
Message-ID: <4514353.LvFx2qVVIh@daniel6430>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add documentation for how to use and setup the switchable termination
resistor support for the can-controllers.

Signed-off-by: Daniel Trevitz <dan@sstrev.com>
---
 Documentation/networking/can.rst | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index ebc822e605f5..bb39cfa4c502 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1148,6 +1148,36 @@ tuning on deep embedded systems'. The author is running a MPC603e
 load without any problems ...


+Switchable Termination Resistors
+--------------------------------
+
+CAN bus requires a specific impedance across the differential pair,
+typically provided by two 120Ohm resistors on the farthest nodes of
+the bus. Some CAN controllers support activating / deactivating a
+termination resistor(s) to provide the correct impedance.::
+
+  - Query the available resistances:
+      $ ip -details link show can0
+      ...
+      termination 120 [ 0, 120
+
+  - Activate the terminating resistor:
+      $ ip link set dev can0 type can termination 120
+
+  - Deactivate the terminating resistor:
+      $ ip link set dev can0 type can termination 0
+
+To enable termination resistor support to a can-controller, either
+implement in the controller's struct can-priv::
+
+    termination_const
+    termination_const_cnt
+    do_set_termination
+
+or add gpio control with the device tree entries from
+Documentation/devicetree/bindings/net/can/can-controller.yaml
+
+
 The Virtual CAN Driver (vcan)
 -----------------------------

--
2.35.1




