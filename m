Return-Path: <linux-can+bounces-3789-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B102AD32BF
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 11:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28A43A4100
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 09:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5DA28DB51;
	Tue, 10 Jun 2025 09:49:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F7728CF4E
	for <linux-can@vger.kernel.org>; Tue, 10 Jun 2025 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548983; cv=none; b=H7UBBwUaYE/t+VZxklys5smBQWoZguFh+AMGW1os8n7ya7TK5/TrQqbDX5LTR/0VZcwytuyk1B76nJ/pJIVJmnjR17SMxbhGdKPIr+Cxp+gq/11DkPt9BCMAEOhz+hhnCTiELfMbZ2ZJ6d18jFxBIMqVTNvYalizo7Kib7jVuUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548983; c=relaxed/simple;
	bh=tGc6CngZcAmwpDPpXzpkLeXMLc4Il0LReyTkQMtbQQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZugPG579/dV5wtTnsNESi3kF6kqGMSG9hem6bYlPAtLUYdzuIj0nFdsB3pQ+CNASbFf2cuwUzkM7qfIskR7prQMxB5WIbQiSD2wIKRoZLuX0NAti1+B1HdA8n5co+sa/wstweD6yWKxr8EG7Yeyeu2/CS7OMYAOjzXp1g9nDcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uOvbv-00065M-02
	for linux-can@vger.kernel.org; Tue, 10 Jun 2025 11:49:39 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uOvbu-002kdo-0f
	for linux-can@vger.kernel.org;
	Tue, 10 Jun 2025 11:49:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D4E594241B6
	for <linux-can@vger.kernel.org>; Tue, 10 Jun 2025 09:49:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 8B312424187;
	Tue, 10 Jun 2025 09:49:35 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a454389a;
	Tue, 10 Jun 2025 09:49:34 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 5/7] documentation: networking: can: Document alloc_candev_mqs()
Date: Tue, 10 Jun 2025 11:46:20 +0200
Message-ID: <20250610094933.1593081-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610094933.1593081-1-mkl@pengutronix.de>
References: <20250610094933.1593081-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Since the introduction of alloc_candev_mqs() and friends, there is no
longer a need to allocate a generic network device and perform explicit
CAN-specific setup.  Remove the code showing this setup, and document
alloc_candev_mqs() instead.

Fixes: 39549eef3587f1c1 ("can: CAN Network device driver and Netlink interface")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/c0f9a706ba31f1a49eb72e58526cd294d97a1ce9.1748865431.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/networking/can.rst | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index b018ce346392..bc1b585355f7 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1104,15 +1104,12 @@ for writing CAN network device driver are described below:
 General Settings
 ----------------
 
+CAN network device drivers can use alloc_candev_mqs() and friends instead of
+alloc_netdev_mqs(), to automatically take care of CAN-specific setup:
+
 .. code-block:: C
 
-    dev->type  = ARPHRD_CAN; /* the netdevice hardware type */
-    dev->flags = IFF_NOARP;  /* CAN has no arp */
-
-    dev->mtu = CAN_MTU; /* sizeof(struct can_frame) -> Classical CAN interface */
-
-    or alternative, when the controller supports CAN with flexible data rate:
-    dev->mtu = CANFD_MTU; /* sizeof(struct canfd_frame) -> CAN FD interface */
+    dev = alloc_candev_mqs(...);
 
 The struct can_frame or struct canfd_frame is the payload of each socket
 buffer (skbuff) in the protocol family PF_CAN.
-- 
2.47.2



