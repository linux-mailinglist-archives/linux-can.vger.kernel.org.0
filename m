Return-Path: <linux-can+bounces-2581-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE0AA08F4A
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 12:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC5E188D6FE
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56FF20D4EF;
	Fri, 10 Jan 2025 11:27:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BF20ADF9
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508446; cv=none; b=l6uCwvLZb0Tuw6VMIo3jPqk9ldY2p9xvIcmgeJI37ItMecixTNTlBuGv7eIzFo/bKUNZxKpilUXtK7Ymv19MK5FXnL3eBSEO83jOq3Xlaywq7aJnnJNr2hGv2jzitYeSW8NZ8M4MEafJOu6Mqhl1yCltrP6hiGm+D7wIt66YXlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508446; c=relaxed/simple;
	bh=yn0o8hEYaMTdcy66ARgmJFgvwXamvbMgEP2lRsFg8+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vj9HHo92Z7fcH4ZKdWUpQzcm/KmgPSbAlX2l+ATtU84CqQ7DnHP5ptUD9W7yYQhTlKeaYDQ6DABk96+w65BAXOdlb2Id4yXKSND6/eGLOp9/NI23BvXJt6mZ7UG2QklUPmB9v3Tb6USU3HR+wvvNOSTZaEKgZMYzph5EHBLCvjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAf-000522-Is
	for linux-can@vger.kernel.org; Fri, 10 Jan 2025 12:27:21 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAc-0009gi-1C
	for linux-can@vger.kernel.org;
	Fri, 10 Jan 2025 12:27:18 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0E1A93A4604
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:17 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E010E3A459C;
	Fri, 10 Jan 2025 11:27:14 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8db13670;
	Fri, 10 Jan 2025 11:27:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 09/18] MAINTAINERS: assign em_canid.c additionally to CAN maintainers
Date: Fri, 10 Jan 2025 12:04:17 +0100
Message-ID: <20250110112712.3214173-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110112712.3214173-1-mkl@pengutronix.de>
References: <20250110112712.3214173-1-mkl@pengutronix.de>
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

The extended match rule em_canid is used to classify CAN frames based
on their CAN Identifier. To keep the CAN maintainers in the loop for
relevant changes which might affect the CAN specific functionality add
em_canid.c to the CAN NETWORK LAYER files.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20241219190837.3087-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0456a33ef657..a7716f48f50c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5065,6 +5065,7 @@ F:	include/uapi/linux/can/gw.h
 F:	include/uapi/linux/can/isotp.h
 F:	include/uapi/linux/can/raw.h
 F:	net/can/
+F:	net/sched/em_canid.c
 
 CAN-J1939 NETWORK LAYER
 M:	Robin van der Gracht <robin@protonic.nl>
-- 
2.45.2



