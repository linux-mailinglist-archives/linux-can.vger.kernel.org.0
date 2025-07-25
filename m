Return-Path: <linux-can+bounces-4180-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3DCB121DA
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 18:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB64580C1C
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CFF2EF2B8;
	Fri, 25 Jul 2025 16:21:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D3D2EF289
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460479; cv=none; b=n8B1RwZECLL1n5RfIR/bpg3odYrEehNt/eJtILZeaQd2w+u7Hncj4O1lTHp7iP5TtMs2xZSSkbBysTdwyi9tDjnzjU5tjrutQBeROoNS7LvFDwMb7jSJbYhy8cibMaZpU3drhhNYDc+qoDgz5vMQloZntJn3n2hkl2zIgsJ0uCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460479; c=relaxed/simple;
	bh=f3zwhKqJ/4lwbPj/0Vzup166aIBBMEkKKJX/ERvu68g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJ7/SjqfPGIUu0266f0cJEtrKwegtTHylEIJtw9RNedTbPkPfxIRU6sTyGcLXvlwR+DU3uHskXy+G4H6rv+aBtIt54InRsz5C4Gfe9f3J8oSM9cwAlV9+tmz912IDwELKfhl6KyntFSSsnYUxbL4+5ZTxXmxMtOEDDFtbHjyWDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufLAa-0000oz-O1
	for linux-can@vger.kernel.org; Fri, 25 Jul 2025 18:21:16 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufLAa-00AFhh-1J
	for linux-can@vger.kernel.org;
	Fri, 25 Jul 2025 18:21:16 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id B3B20449907
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:36 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D9658449829;
	Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a274b819;
	Fri, 25 Jul 2025 16:13:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 16/27] Documentation: devlink: add devlink documentation for the kvaser_pciefd driver
Date: Fri, 25 Jul 2025 18:05:26 +0200
Message-ID: <20250725161327.4165174-17-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725161327.4165174-1-mkl@pengutronix.de>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
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

From: Jimmy Assarsson <extja@kvaser.com>

List the version information reported by the kvaser_pciefd driver
through devlink.

Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123230.8-11-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/networking/devlink/index.rst    |  1 +
 .../networking/devlink/kvaser_pciefd.rst      | 24 +++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 Documentation/networking/devlink/kvaser_pciefd.rst

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 250ae71f4023..053fbafeb491 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -85,6 +85,7 @@ parameters, info versions, and other features it supports.
    ionic
    ice
    ixgbe
+   kvaser_pciefd
    mlx4
    mlx5
    mlxsw
diff --git a/Documentation/networking/devlink/kvaser_pciefd.rst b/Documentation/networking/devlink/kvaser_pciefd.rst
new file mode 100644
index 000000000000..075edd2a508a
--- /dev/null
+++ b/Documentation/networking/devlink/kvaser_pciefd.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
+kvaser_pciefd devlink support
+=============================
+
+This document describes the devlink features implemented by the
+``kvaser_pciefd`` device driver.
+
+Info versions
+=============
+
+The ``kvaser_pciefd`` driver reports the following versions
+
+.. list-table:: devlink info versions implemented
+   :widths: 5 5 90
+
+   * - Name
+     - Type
+     - Description
+   * - ``fw``
+     - running
+     - Version of the firmware running on the device. Also available
+       through ``ethtool -i`` as ``firmware-version``.
-- 
2.47.2



