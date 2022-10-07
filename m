Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353BE5F7709
	for <lists+linux-can@lfdr.de>; Fri,  7 Oct 2022 12:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiJGKpl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 Oct 2022 06:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJGKpk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Oct 2022 06:45:40 -0400
X-Greylist: delayed 55050 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Oct 2022 03:45:31 PDT
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791BED01A0
        for <linux-can@vger.kernel.org>; Fri,  7 Oct 2022 03:45:29 -0700 (PDT)
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.156])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 7FCCC200FE
        for <linux-can@vger.kernel.org>; Fri,  7 Oct 2022 10:45:28 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 9828020029;
        Fri,  7 Oct 2022 10:45:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id E44472A391;
        Fri,  7 Oct 2022 10:45:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8I75Nsg1GEEo; Fri,  7 Oct 2022 10:45:23 +0000 (UTC)
Received: from mail15.mymailcheap.com (mail15.mymailcheap.com [141.94.164.103])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Fri,  7 Oct 2022 10:45:23 +0000 (UTC)
Received: from daniel6430.localnet (c-73-64-181-209.hsd1.pa.comcast.net [73.64.181.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail15.mymailcheap.com (Postfix) with ESMTPSA id 82EC5202C4;
        Fri,  7 Oct 2022 10:45:21 +0000 (UTC)
From:   "Daniel S. Trevitz" <dan@sstrev.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Daniel Trevitz <daniel.trevitz@wika.com>,
        Ryan Edwards <ryan.edwards@gmail.com>
Subject: [PATCH 1/1 v2] Termination resistor documentation
Date:   Fri, 07 Oct 2022 06:45:20 -0400
Message-ID: <2498535.ElGaqSPkdT@daniel6430>
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
+termination resistor(s) to provide the correct impedance::
+
+  - Query the available resistances:
+      $ ip -details link show can0
+      ...
+      termination 120 [ 0, 120 ]
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




