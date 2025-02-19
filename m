Return-Path: <linux-can+bounces-2865-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C9CA3BCF0
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 12:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E717A423F
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 11:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32CD1E0080;
	Wed, 19 Feb 2025 11:34:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F164B1D9A49
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964846; cv=none; b=kapny1sh4te3WO2g9MrUqVX/BCSOeXQr/ptZ7ymGV3k29Xv/PfAfWOhqMht5BIbmsdmIuntGLTHB4y9fnOqCB4dZZhvq7ZpEfaSx8kg88Ob/vM8JcWdQlHu9XYuQZPQ6yAxOjIFrVsGPboBQsKJs8wQyXh2irWXutMbtN7ax5Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964846; c=relaxed/simple;
	bh=E5JG4Djtn+vkP4X2K2++KgtWExulRo1bEJk7lVevN5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uR3dMsqH7e5E9faAdecvayfbIGDSoYGBUtBQdYNctGLeITKtNIkQHYgEMwiczGa0LNNyhXmBE3oGZFAVb3w5MKnUPl0GrdQzfI3NMZAz1wDqkeSyIN3v9ZpE1dn9MFkTiY5JCbbTyL+NvV9gyzm8pbtOlaEUmf0Qa76DsAzkRtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkiL4-0001aK-Ue
	for linux-can@vger.kernel.org; Wed, 19 Feb 2025 12:34:02 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkiL3-001l21-0U
	for linux-can@vger.kernel.org;
	Wed, 19 Feb 2025 12:34:01 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id C68803C6939
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 11:34:00 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 042A83C68EC;
	Wed, 19 Feb 2025 11:33:58 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f419a61c;
	Wed, 19 Feb 2025 11:33:56 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 10/12] can: canxl: support Remote Request Substitution bit access
Date: Wed, 19 Feb 2025 12:21:15 +0100
Message-ID: <20250219113354.529611-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250219113354.529611-1-mkl@pengutronix.de>
References: <20250219113354.529611-1-mkl@pengutronix.de>
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

From: Oliver Hartkopp <socketcan@hartkopp.net>

The Remote Request Substitution bit is a dominant bit ("0") in the CAN
XL frame. As some CAN XL controllers support to access this bit a new
CANXL_RRS value has been defined for the canxl_frame.flags element.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20250124142347.7444-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/uapi/linux/can.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index e78cbd85ce7c..42abf0679fb4 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -182,7 +182,7 @@ struct canfd_frame {
 /*
  * defined bits for canxl_frame.flags
  *
- * The canxl_frame.flags element contains two bits CANXL_XLF and CANXL_SEC
+ * The canxl_frame.flags element contains three bits CANXL_[XLF|SEC|RRS]
  * and shares the relative position of the struct can[fd]_frame.len element.
  * The CANXL_XLF bit ALWAYS needs to be set to indicate a valid CAN XL frame.
  * As a side effect setting this bit intentionally breaks the length checks
@@ -192,6 +192,7 @@ struct canfd_frame {
  */
 #define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
 #define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */
+#define CANXL_RRS 0x02 /* Remote Request Substitution */
 
 /* the 8-bit VCID is optionally placed in the canxl_frame.prio element */
 #define CANXL_VCID_OFFSET 16 /* bit offset of VCID in prio element */
-- 
2.47.2



