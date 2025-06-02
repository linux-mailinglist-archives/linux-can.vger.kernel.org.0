Return-Path: <linux-can+bounces-3751-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE1DACADBB
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 14:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E4417E669
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1482116EB;
	Mon,  2 Jun 2025 11:59:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E33220F078;
	Mon,  2 Jun 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748865598; cv=none; b=m+etkz42HGBXRnaja5I7ldv1HfGhgOBw6FdvvUau6Tm9QFOI6OPpmlDFComGK1BPY3yusUfIv72jIctp/4JIft5DdwSCrIRCu41RPb8lI/vFyaEF2yIjeHjU84gff7lyWTOpaSAc8MdBSIxT1i1Yz/ToYcvE+cnhuD6V1L0ynbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748865598; c=relaxed/simple;
	bh=7XYV3KkxV92L9ICtrPlZhbT2Bc4RXMJiRmkRccZBJ2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ooy9rzYIBZqj6JEEPRLW5/SrXUO5uSy/DRezBL6/dGeooA8//HhK9ZT7zB3Qk0rc5qToDATHdiajYM52/u7/aqGwO/1O+r6Z+lhtsMMLaxC2EeD41u+uZOjPJPhc/zE0eGaOcBU55zYDbOx9KrPO/8GdhwMQm3uedYAJPD61gGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB81C4CEEB;
	Mon,  2 Jun 2025 11:59:55 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-can@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] documentation: networking: can: Document alloc_candev_mqs()
Date: Mon,  2 Jun 2025 13:59:52 +0200
Message-ID: <c0f9a706ba31f1a49eb72e58526cd294d97a1ce9.1748865431.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the introduction of alloc_candev_mqs() and friends, there is no
longer a need to allocate a generic network device and perform explicit
CAN-specific setup.  Remove the code showing this setup, and document
alloc_candev_mqs() instead.

Fixes: 39549eef3587f1c1 ("can: CAN Network device driver and Netlink interface")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Fix RST rendering,
  - Promote Fixes-tag.
---
 Documentation/networking/can.rst | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index b018ce346392652b..bc1b585355f7ad99 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1104,15 +1104,12 @@ for writing CAN network device driver are described below:
 General Settings
 ----------------
 
-.. code-block:: C
-
-    dev->type  = ARPHRD_CAN; /* the netdevice hardware type */
-    dev->flags = IFF_NOARP;  /* CAN has no arp */
+CAN network device drivers can use alloc_candev_mqs() and friends instead of
+alloc_netdev_mqs(), to automatically take care of CAN-specific setup:
 
-    dev->mtu = CAN_MTU; /* sizeof(struct can_frame) -> Classical CAN interface */
+.. code-block:: C
 
-    or alternative, when the controller supports CAN with flexible data rate:
-    dev->mtu = CANFD_MTU; /* sizeof(struct canfd_frame) -> CAN FD interface */
+    dev = alloc_candev_mqs(...);
 
 The struct can_frame or struct canfd_frame is the payload of each socket
 buffer (skbuff) in the protocol family PF_CAN.
-- 
2.43.0


