Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 489377186B
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2019 14:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbfGWMoV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Jul 2019 08:44:21 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:11562 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731264AbfGWMoV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Jul 2019 08:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1563885858;
        s=strato-dkim-0002; d=hartkopp.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=shdI7NqlkBH4LG70rXL1XlF7l9AMyBwh+q5TojT1od0=;
        b=JKkxsUAsJ61Aj3yaLu9zxomDtAP6ucoh+FwrnqXLycNaQ5NVaKEBjd3F9KK/t7S1lO
        TciPHv7rC5ecF+7pj1/qhNVWqUf8twHc5frTlv77D2bwiodItsJuNG2DzEkD+PiWFuMY
        2MgyRRgvtUXQ7feLz2ekWZMsN4ph+qHEMIjm48FRTW0YpprmjLvJhLa7x3GSg/KfqXHU
        P9jAkE9bD35CEGiSNPjktvcZfKqlBC0E2g1zsvIVSn0pg7FQy6/iFkprT+es+j/X8HeA
        Rj5AkL/eeIyudyefhdkh2mrXWGmqiPW4AQXz6oMZqF1NJLphTpHTohbnZKESeqgMPx+7
        +mDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0lO8DsfULo/u/TWqP+w=="
X-RZG-CLASS-ID: mo00
Received: from zbook.lan
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv6NCiHeAx
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 23 Jul 2019 14:44:17 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: Add SPDX license identifiers for CAN subsystem
Date:   Tue, 23 Jul 2019 14:44:11 +0200
Message-Id: <20190723124411.17353-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add missing SPDX identifiers for the CAN network layer and correct the SPDX
license for two of its include files to make sure the BSD-3-Clause applies
for the entire subsystem.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/core.h | 2 +-
 include/linux/can/skb.h  | 2 +-
 net/can/af_can.c         | 1 +
 net/can/af_can.h         | 1 +
 net/can/bcm.c            | 1 +
 net/can/gw.c             | 1 +
 net/can/proc.c           | 1 +
 net/can/raw.c            | 1 +
 8 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index f8284a94a13d..708c10d3417a 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /*
  * linux/can/core.h
  *
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index b3379a97245c..a954def26c0d 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /*
  * linux/can/skb.h
  *
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 9c86de2da45e..414d8f213358 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /*
  * af_can.c - Protocol family CAN core module
  *            (used by different CAN protocol modules)
diff --git a/net/can/af_can.h b/net/can/af_can.h
index 9cb3719632bd..ef21f7c6bc80 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /*
  * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
  * All rights reserved.
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 1eecf4d3e8d2..f9e6d6bd89bc 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
  * bcm.c - Broadcast Manager to filter/send (cyclic) CAN content
  *
diff --git a/net/can/gw.c b/net/can/gw.c
index 5275ddf580bc..d535fcc48055 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
  * gw.c - CAN frame Gateway/Router/Bridge with netlink interface
  *
diff --git a/net/can/proc.c b/net/can/proc.c
index 70fea17bb04c..91f0fd106c3a 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
  * proc.c - procfs support for Protocol family CAN core module
  *
diff --git a/net/can/raw.c b/net/can/raw.c
index bbbe3dd0abe9..d0eaceaf12a2 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
  * raw.c - Raw sockets for protocol family CAN
  *
-- 
2.20.1

