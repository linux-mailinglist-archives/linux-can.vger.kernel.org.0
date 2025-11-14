Return-Path: <linux-can+bounces-5393-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEA9C5C045
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 09:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B00B934D8C4
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 08:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E392FDC41;
	Fri, 14 Nov 2025 08:37:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838092FFFBE
	for <linux-can@vger.kernel.org>; Fri, 14 Nov 2025 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763109428; cv=none; b=Icixi7WFXbTukd52iaimW8fIWRnm8+Ii/UMgxztkr+rFmVuZpwQRz3fE1tn1Ec8drHI1zhv+pUl326nOpYv+sDqGxtggE+pH6OJExQTPP/vndvE0E+0+xQyvsWHonyEDEoI67u3FxzasS6LZbiu2C8kadmulj5wLkXaJAb0vojQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763109428; c=relaxed/simple;
	bh=Sa+Fuz9f3l3AT3cWzrHI/taVLuBWhq9+Uu6Cx1x+LCA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T4AhbGYVn0NRJBgn9GxEtd7s8yeGeKCo0xRfplj2Lp3Oq2pWGISt0FWtJHrdLKcKClNZrtMSqeo7n7UW5qpjUfwGNhWuk+PVdT2qXeVBTAKGIexEaZDHVvfxy2+fiO8pV2cFCM70rGpiZN/77+wdvqqgTAeXW2clInxn0UFsg7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJpIe-0007Pl-NX; Fri, 14 Nov 2025 09:36:56 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJpId-000OMW-36;
	Fri, 14 Nov 2025 09:36:55 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9E6D649F2FC;
	Fri, 14 Nov 2025 08:36:55 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can 0/3] can: gs_usb: fix USB bulk in and out callbacks
Date: Fri, 14 Nov 2025 09:36:42 +0100
Message-Id: <20251114-gs_usb-fix-usb-callbacks-v1-0-a29b42eacada@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABrqFmkC/x2M0QqDMAxFf0XybMBWinS/MobELGqYdKNBEcR/t
 +7pcODce4BJVjF4VAdk2dT0m4q4ugKeKU2C+i4OvvHBuabDyfrVBhx1x5tMyzIQfwzDSD6G4GP
 kFsr8l6VE/+snMCV4necFxxJfpm8AAAA=
X-Change-ID: 20251107-gs_usb-fix-usb-callbacks-5fa2955299c3
To: Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Maximilian Schneider <max@schneidersoft.net>
Cc: Henrik Brix Andersen <henrik@brixandersen.dk>, kernel@pengutronix.de, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-509f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1216; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Sa+Fuz9f3l3AT3cWzrHI/taVLuBWhq9+Uu6Cx1x+LCA=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpFuof/BAdLDq2D+pwQ20xy6U4MSjAphzhDuWNI
 r9OJnU3+m6JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaRbqHwAKCRAMdGXf+ZCR
 nOWICAC2tJIarn0GpeO0UQLhtIvuvCZDY0H+UHAhdc4H/2v1ekX/dw6A+YuIraA8QSIHv8sgmoX
 Dl8j5JV/XxkL8y0E4pa893lkrY6dPaC0cqDjcjGvOW2MJOZIeIV3uuqRQ8TA83eNp0BOQih5geI
 93TJoroZXVuO6zyTmgBxVTJIiir9u2W3YYLgCLwcSiLMZ9CGpi7YyfDGqgFB78Oj628d9642OoV
 jTV6vvQS99Kej7rMWARrDxoMKrfNJ0xWVx+li1OoJAFLINPJ5i88mSURrbDFx2jmacT48o3toN8
 ny+n3f84ZHEqTfLVYuls5M5EalX1HPbCRlyOK2BYSa2Vz2zd
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

The bulk-out callback gs_usb_xmit_callback() does not take care of the
cleanup of failed transfers of URBs. The 1st patch adds the missing
cleanup.

The bulk-in callback gs_usb_receive_bulk_callback() accesses the buffer of
the URB without checking how much data has actually been received. The last
2 patches fix this problem.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v2:
- patch 3: TX-echo length: take timestamps into account (thanks: Henrik)
- Link to v1: https://patch.msgid.link/20251108-gs_usb-fix-usb-callbacks-v1-0-8a2534a7ea05@pengutronix.de

---
Marc Kleine-Budde (3):
      can: gs_usb: gs_usb_xmit_callback(): fix handling of failed transmitted URBs
      can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing header
      can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing data

 drivers/net/can/usb/gs_usb.c | 102 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 88 insertions(+), 14 deletions(-)
---
base-commit: 407a06507c2358554958e8164dc97176feddcafc
change-id: 20251107-gs_usb-fix-usb-callbacks-5fa2955299c3

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


