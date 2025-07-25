Return-Path: <linux-can+bounces-4172-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D62F9B121B4
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 18:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C179AC4BB5
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B37F2F1FC2;
	Fri, 25 Jul 2025 16:13:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59C92EF2B7
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460026; cv=none; b=RMRCxlm4QXADZU9MIJCvVfLL+JuGIpyLw4vIw/d7Cn31ofCfYoQeLReeD5HCkgB2MFJ5C6W5UUTqGpXZlefbxmFPCAXSPpI26mFI+LeK1AfNXpzUErBEohhnrxPJs4HgGuKx0/T31vYdDUe5jPfGBOV+0PPitfbUFiX9YqPGeaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460026; c=relaxed/simple;
	bh=9KnqqFaFwDyZCZMWE+vUJz9uknZmucVEElwrEblaJ7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIRr2elfF1YqmPIrQJnxyhTVfvfSOO9zIzlahzDdDPCCo2FYNyMWma47jYCHdydB2EfrXk/z9HwD5vSeX6oLSiAGgifXrEzDE8FhJJ27Ottcr8mnAhQdUxf93VUpTzePYSvrF52SOYLc2/hErGzbu1XsVwv8FjueeC/mdr3fM7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3F-0006la-Cs
	for linux-can@vger.kernel.org; Fri, 25 Jul 2025 18:13:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3B-00AFeO-2G
	for linux-can@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:37 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 435C044990F
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 0BCFE449851;
	Fri, 25 Jul 2025 16:13:32 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5ee017b6;
	Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 27/27] Documentation: devlink: add devlink documentation for the kvaser_usb driver
Date: Fri, 25 Jul 2025 18:05:37 +0200
Message-ID: <20250725161327.4165174-28-mkl@pengutronix.de>
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

List the version information reported by the kvaser_usb driver
through devlink.

Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123452.41-12-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/networking/devlink/index.rst    |  1 +
 .../networking/devlink/kvaser_usb.rst         | 33 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 Documentation/networking/devlink/kvaser_usb.rst

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 053fbafeb491..270a65a01411 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -86,6 +86,7 @@ parameters, info versions, and other features it supports.
    ice
    ixgbe
    kvaser_pciefd
+   kvaser_usb
    mlx4
    mlx5
    mlxsw
diff --git a/Documentation/networking/devlink/kvaser_usb.rst b/Documentation/networking/devlink/kvaser_usb.rst
new file mode 100644
index 000000000000..403db3766cb4
--- /dev/null
+++ b/Documentation/networking/devlink/kvaser_usb.rst
@@ -0,0 +1,33 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+kvaser_usb devlink support
+==========================
+
+This document describes the devlink features implemented by the
+``kvaser_usb`` device driver.
+
+Info versions
+=============
+
+The ``kvaser_usb`` driver reports the following versions
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
+   * - ``board.rev``
+     - fixed
+     - The device hardware revision.
+   * - ``board.id``
+     - fixed
+     - The device EAN (product number).
+   * - ``serial_number``
+     - fixed
+     - The device serial number.
-- 
2.47.2



