Return-Path: <linux-can+bounces-244-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5A9852F6D
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 12:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7855B1F22B78
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 11:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDB136AF0;
	Tue, 13 Feb 2024 11:34:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8DE36AF3
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824085; cv=none; b=k90rsV+xsNZsTO1qie+T/QcNZ1sfMzU4pCfcn5lodrUnHzMxx4aaiaA/y5mMsMFTdRKoWKUmH/nx2FlmUyZCzum8o6MoKSXISFt7swM/x1DXvDf74WhkhbZb+s4+Ph36uCQsN1/cRtmlVge1e3cS+jLtkLtJKFQzmXTZwyaTn7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824085; c=relaxed/simple;
	bh=lipl8soirIYmwPi+Kly5amy4lTxTkDXyRuRkyAcnvdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WY/Z1VybcP1sg15XJZPHzzlDXfoXSRC/jfr/lXUhwdBTm6Bg3m4sNQxANFc8goviSA9v0hF/PGxmJoSIjrt7gcw/xN684BD4TBtWh9BMPV7LwO/kEHLHV2QaFVZRlUWAsAFA2GJ1+sV1JWkStC8zHYwR+VhyDBc6Ojuye2HDjY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3h-00015m-SB
	for linux-can@vger.kernel.org; Tue, 13 Feb 2024 12:34:41 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3g-000TQu-V8
	for linux-can@vger.kernel.org; Tue, 13 Feb 2024 12:34:40 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 6CB3428D64D
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 11:34:40 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id F200A28D625;
	Tue, 13 Feb 2024 11:34:38 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 73a30919;
	Tue, 13 Feb 2024 11:34:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/23] =?UTF-8?q?MAINTAINERS:=20add=20Stefan=20M?= =?UTF-8?q?=C3=A4tje=20as=20maintainer=20for=20the=20esd=20electronics=20G?= =?UTF-8?q?mbH=20PCIe/402=20CAN=20drivers?=
Date: Tue, 13 Feb 2024 12:25:06 +0100
Message-ID: <20240213113437.1884372-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213113437.1884372-1-mkl@pengutronix.de>
References: <20240213113437.1884372-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Stefan Mätje <stefan.maetje@esd.eu>

Adding myself (Stefan Mätje) as a maintainer for the upcoming driver of
the PCIe/402 interface card family.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
Link: https://lore.kernel.org/all/20231122160211.2110448-2-stefan.maetje@esd.eu
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 83e20516ebff..7f3e554671c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7887,6 +7887,13 @@ S:	Maintained
 F:	include/linux/errseq.h
 F:	lib/errseq.c
 
+ESD CAN NETWORK DRIVERS
+M:	Stefan Mätje <stefan.maetje@esd.eu>
+R:	socketcan@esd.eu
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/esd/
+
 ESD CAN/USB DRIVERS
 M:	Frank Jungclaus <frank.jungclaus@esd.eu>
 R:	socketcan@esd.eu
-- 
2.43.0



