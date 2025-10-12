Return-Path: <linux-can+bounces-5135-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B3EBD03E5
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 16:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA4244EA57F
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 14:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE163289E0F;
	Sun, 12 Oct 2025 14:28:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D599287275
	for <linux-can@vger.kernel.org>; Sun, 12 Oct 2025 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760279338; cv=none; b=orCaBbGCWrZgwuWb1hqJ91LLANmEv9txiLSxV69NWC9OX8sQT980qykS0rbw8LULjtz2vY7HxDPErJksCGDM9vXZdYAWNtOX8pjb1V4ykPqsXRWXQR7tq+19Naxb1NnumbT5ni7x39ndwOrwZDMdMW+STvuh8FVEP6vhXpGOkck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760279338; c=relaxed/simple;
	bh=1DwAA/PTKWQMh2SYfuTdVvtOLAYNsGD728GvmV0y6+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTC9VrKbkaT/nElx2xzBeK9wmquNpYjXWLi7Gf7rvAtwAWf084z1ljxXNjbsda/MSRcNg8pgOQCPIPQH5t0PGt0U+zfIKgMo1j/aAxRFIvFsg5uDGiCumCYUIz+qBsc4Um7mUXE2n5Cb256IrDV9m3NFrO2yNPU8n2bj3R/9kRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v7x3w-00044p-8W; Sun, 12 Oct 2025 16:28:40 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v7x3v-003EUy-2Z;
	Sun, 12 Oct 2025 16:28:39 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7C4F5484065;
	Sun, 12 Oct 2025 14:28:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 8/9] can: remove false statement about 1:1 mapping between DLC and length
Date: Sun, 12 Oct 2025 16:20:52 +0200
Message-ID: <20251012142836.285370-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012142836.285370-1-mkl@pengutronix.de>
References: <20251012142836.285370-1-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol@kernel.org>

The CAN-FD section of can.rst still states that there is a 1:1 mapping
between the Classical CAN DLC and its length. This is only true for
the DLC values up to 8. Beyond that point, the length remains at 8.

For reference, the mapping between the CAN DLC and the length is given
in below table [1]:

	 DLC value	CBFF and CEFF	FBFF and FEFF
	 [decimal]	    [byte]	    [byte]
	----------------------------------------------
		 0		 0		 0
		 1		 1		 1
		 2		 2		 2
		 3		 3		 3
		 4		 4		 4
		 5		 5		 5
		 6		 6		 6
		 7		 7		 7
		 8		 8		 8
		 9		 8		12
		10		 8		16
		11		 8		20
		12		 8		24
		13		 8		32
		14		 8		48
		15		 8		64

Remove the erroneous statement. Instead just state that the length of
a Classical CAN frame ranges from 0 to 8.

[1] ISO 11898-1:2024, Table 5 -- DLC: coding of the four LSB

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20251012-can-fd-doc-v1-1-86cc7d130026@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/networking/can.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 7650c4b5be5f..ccd321d29a8a 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1398,10 +1398,9 @@ second bit timing has to be specified in order to enable the CAN FD bitrate.
 Additionally CAN FD capable CAN controllers support up to 64 bytes of
 payload. The representation of this length in can_frame.len and
 canfd_frame.len for userspace applications and inside the Linux network
-layer is a plain value from 0 .. 64 instead of the CAN 'data length code'.
-The data length code was a 1:1 mapping to the payload length in the Classical
-CAN frames anyway. The payload length to the bus-relevant DLC mapping is
-only performed inside the CAN drivers, preferably with the helper
+layer is a plain value from 0 .. 64 instead of the Classical CAN length
+which ranges from 0 to 8. The payload length to the bus-relevant DLC mapping
+is only performed inside the CAN drivers, preferably with the helper
 functions can_fd_dlc2len() and can_fd_len2dlc().
 
 The CAN netdevice driver capabilities can be distinguished by the network
-- 
2.51.0


