Return-Path: <linux-can+bounces-6188-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CFED385FB
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 20:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A483130428F4
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 19:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14A53A1D01;
	Fri, 16 Jan 2026 19:35:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFA3395258
	for <linux-can@vger.kernel.org>; Fri, 16 Jan 2026 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592159; cv=none; b=DC6BxkSP72Y0rGdvLTcWdrkSQke8+abJ7V+rJUTaFLmlTxfYTq5djoBVPL+YUE6v+jSSDNvDKikM8P6ZTLtNmvb5bKgJeClf07LsxbRXsdsIEbEeef7zlMZkKkz3xQAonNcAtgo6PEk811IcgUPCdWqmVSXxNbmPdrFNeBA4GV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592159; c=relaxed/simple;
	bh=+oOoxQRgxhh2HVjyFDqQeuKDv4oPjvs8MJ+wjvvQW8E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Fw/jN9Tm6mJGMvQ4hag+m+CzUD/PJv8VzKKffhnTcoRKjGFZNvLwaMsU5G0FmLTJJnwEfUeYCekKCVAaiyVVCGZEcPIX8u2+xxqO/a1rQ0yCOMJf6NyKgNL40/NqjlHdDVYoq6YE4Z27kDPb4jYh7viVtU4t3BAEr7vAEJWYQC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgpbi-000800-HI; Fri, 16 Jan 2026 20:35:42 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgpbg-000yK2-0h;
	Fri, 16 Jan 2026 20:35:39 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 429224CEEDE;
	Fri, 16 Jan 2026 19:35:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can v2 0/5] can: usb: fix URB memory leaks
Date: Fri, 16 Jan 2026 20:35:13 +0100
Message-Id: <20260116-can_usb-fix-memory-leak-v2-0-4b8cb2915571@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPGSamkC/3WNzQ6CMBCEX4Xs2TXbYvjx5HsYYkpZoSqFtEAwh
 He3wNnjTGa+bwHPzrCHa7SA48l409kQ5CkC3ShbM5oqZJAkExKUo1b2MfoSn2bGltvOffHD6o1
 UpUnORDLOYwjv3nGY7OQ7hBMUR+nH8sV62JjbrDF+CIzdP4l9fKgE/VVNAgkvKtWUSZVSJm492
 3ocXGfNfK4YinVdf+BnlUfaAAAA
X-Change-ID: 20260109-can_usb-fix-memory-leak-0d769e002393
To: Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Sebastian Haas <haas@ems-wuensche.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Frank Jungclaus <frank.jungclaus@esd.eu>, socketcan@esd.eu, 
 Yasushi SHOJI <yashi@spacecubics.com>, Daniel Berglund <db@kvaser.com>, 
 Olivier Sobrie <olivier@sobrie.be>, 
 =?utf-8?q?Remigiusz_Ko=C5=82=C5=82=C4=85taj?= <remigiusz.kollataj@mobica.com>, 
 Bernd Krumboeck <b.krumboeck@gmail.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1928; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=+oOoxQRgxhh2HVjyFDqQeuKDv4oPjvs8MJ+wjvvQW8E=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpapL/l4/kk7tf6E11Q9FVQCtfWPQPCLDHCV2bU
 HcjKPq2ZkCJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaWqS/wAKCRAMdGXf+ZCR
 nGyhB/4rvtfi4/62P/rm5IbpCQl4IOAH4xM8irDjR5voRKudpeICNbknlpzVn8Y4TAYvTPpNQng
 yRrVtnR55ZumB82PZ60etO3Cw1PNE1jzFQL6nGxCy8aJUBXw0RniZTT6nkO/Qo+nbjV/FlQJ7ih
 GeqQ5WuBDd3qdglVY707qXrV03mL2ubWhvKE6Xkp/9uiF273uEEnONnuLbmqZLhUcGLF9v3cvZ0
 Xkm5f1Tv6TSDuRvbZxSx5TtQuTJDR8ZC7xgvEC+BwcWJmkHrNo4OXl/r5rYwWfkIIWAfNqQ95sc
 wRQNp+d0SNQfVp57+6E6fkn4sob1hVAM9FwRPcGF1tNOzun5
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

An URB memory leak [1][2] was recently fixed in the gs_usb driver. The
driver did not take into account that completed URBs are no longer
anchored, causing them to be lost during ifdown. The memory leak was fixed
by re-anchoring the URBs in the URB completion callback.

Several USB CAN drivers are affected by the same error. Fix them
accordingly.

[1] https://lore.kernel.org/all/20260109135311.576033-3-mkl@pengutronix.de/
[2] https://lore.kernel.org/all/20260116-can_usb-fix-reanchor-v1-1-9d74e7289225@pengutronix.de/

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v2:
- removed Remigiusz Kołłątaj from list of recipients
  (their email address is no longer valid)
- rebased to latest net/main
- all: add review feedback, unanchor in case of error
  https://lore.kernel.org/all/20260110223836.3890248-1-kuba@kernel.org/
- Link to v1: https://patch.msgid.link/20260110-can_usb-fix-memory-leak-v1-0-4a7c082a7081@pengutronix.de

---
Marc Kleine-Budde (5):
      can: ems_usb: ems_usb_read_bulk_callback(): fix URB memory leak
      can: esd_usb: esd_usb_read_bulk_callback(): fix URB memory leak
      can: kvaser_usb: kvaser_usb_read_bulk_callback(): fix URB memory leak
      can: mcba_usb: mcba_usb_read_bulk_callback(): fix URB memory leak
      can: usb_8dev: usb_8dev_read_bulk_callback(): fix URB memory leak

 drivers/net/can/usb/ems_usb.c                    | 8 +++++++-
 drivers/net/can/usb/esd_usb.c                    | 9 ++++++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 9 ++++++++-
 drivers/net/can/usb/mcba_usb.c                   | 8 +++++++-
 drivers/net/can/usb/usb_8dev.c                   | 8 +++++++-
 5 files changed, 37 insertions(+), 5 deletions(-)
---
base-commit: a74c7a58ca2ca1cbb93f4c01421cf24b8642b962
change-id: 20260109-can_usb-fix-memory-leak-0d769e002393

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


