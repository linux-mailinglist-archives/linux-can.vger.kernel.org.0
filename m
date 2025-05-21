Return-Path: <linux-can+bounces-3610-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BAEABF073
	for <lists+linux-can@lfdr.de>; Wed, 21 May 2025 11:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ECD71B632FD
	for <lists+linux-can@lfdr.de>; Wed, 21 May 2025 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9BD259CAC;
	Wed, 21 May 2025 09:51:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C4D259C8B
	for <linux-can@vger.kernel.org>; Wed, 21 May 2025 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821093; cv=none; b=GsQfxRtp4lAjtrd0SBeFoafoLw0+NWA5xN/Aq8YyHctRflbLisOG62z8/9C5EVrp3uAagiVRHvXprQQpQgXVnuBNMLG9hRtAuxc6SKaB8pqU2DnViL+thKgsuMrsRB1MNz6Sx8Sfm8klqClXy+G6bjf950ks6xfEEmDU9ZXxAy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821093; c=relaxed/simple;
	bh=xrJuzbpRorAnN9mGOXoLPRNxKUvk4+A/9QDxx8iS3R4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBkORwuton2k731fxxmKJn5S6x8M9b5MowtW/g8ClXBSEbWLtlQZp8bbGiEpAF22JrvZulEvCT2iQyiGopDDbJROgMnpYCgMAYMkdBC5ben1iGUOYzNymv0je92U8ss37bIbndim9VlxibXP+Rbin15JgUOMdsexzmhE5HoSA/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:2bba:d77b:9240:3c4e])
	by laurent.telenet-ops.be with cmsmtp
	id rlrQ2E00F4GqtyW01lrQTG; Wed, 21 May 2025 11:51:29 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uHg6R-00000002iLy-10Ar;
	Wed, 21 May 2025 11:51:24 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uHg6e-00000002iau-1QTe;
	Wed, 21 May 2025 11:51:24 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Wolfgang Grandegger <wg@grandegger.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] documentation: networking: can: Document alloc_candev_mqs()
Date: Wed, 21 May 2025 11:51:21 +0200
Message-ID: <a679123dfa5a5a421b8ed3e34963835e019099b0.1747820705.git.geert+renesas@glider.be>
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

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Dunno if this deserves
Fixes: 39549eef3587f1c1 ("can: CAN Network device driver and Netlink interface")

 Documentation/networking/can.rst | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index b018ce346392652b..784dbd19b140d262 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1106,13 +1106,10 @@ General Settings
 
 .. code-block:: C
 
-    dev->type  = ARPHRD_CAN; /* the netdevice hardware type */
-    dev->flags = IFF_NOARP;  /* CAN has no arp */
+CAN network device drivers can use alloc_candev_mqs() and friends instead of
+alloc_netdev_mqs(), to automatically take care of CAN-specific setup:
 
-    dev->mtu = CAN_MTU; /* sizeof(struct can_frame) -> Classical CAN interface */
-
-    or alternative, when the controller supports CAN with flexible data rate:
-    dev->mtu = CANFD_MTU; /* sizeof(struct canfd_frame) -> CAN FD interface */
+    dev = alloc_candev_mqs(...);
 
 The struct can_frame or struct canfd_frame is the payload of each socket
 buffer (skbuff) in the protocol family PF_CAN.
-- 
2.43.0


