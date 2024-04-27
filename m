Return-Path: <linux-can+bounces-497-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 617608B46DD
	for <lists+linux-can@lfdr.de>; Sat, 27 Apr 2024 17:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70901F2151D
	for <lists+linux-can@lfdr.de>; Sat, 27 Apr 2024 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27796A937;
	Sat, 27 Apr 2024 15:35:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DE023DE
	for <linux-can@vger.kernel.org>; Sat, 27 Apr 2024 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.2.72.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714232132; cv=none; b=nLNPJuP37fnnefUU2bD58jJG6JKdSINH1oyu6tK8JF7EqSfj3Kq4ZHk7pnTa2uDWwwzUL9AM0OdK8EV3RKNi6guJBgLNWzKulAf+iYmdDBKvC8YnxqsivhPSVJkQ3fK/YZqMcuS+CfyDSqdqDsz0sy9pEo2u+LQImuvkkveO0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714232132; c=relaxed/simple;
	bh=BFYHwahEpZijc9K1ulYRm2Qjb3sYKj9yWfDySmj5WNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ty4DAGSzmdejka7XBLvnxVgBvD70dZRTB6f6w/dsk8UkgmdB67MVzC5AQapKXzf0BuluSljBd76O5UrETVQQmkjpFyyX1HuQmdodZXZZ4z7Q8X7uw23ZwYNjsQWBNOs77/i7auauEX3dzU4RJaaAb1RDbRYvXLl4UVEtQ1rx8qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com; spf=pass smtp.mailfrom=mansr.com; arc=none smtp.client-ip=81.2.72.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mansr.com
Received: from raven.mansr.com (raven.mansr.com [81.2.72.235])
	by unicorn.mansr.com (Postfix) with ESMTPS id 1E76015365;
	Sat, 27 Apr 2024 16:27:40 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
	id BFD2021A4DE; Sat, 27 Apr 2024 16:27:39 +0100 (BST)
From: Mans Rullgard <mans@mansr.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org
Subject: [PATCH] can: Kconfig: remove obsolete help text for slcan
Date: Sat, 27 Apr 2024 16:26:48 +0100
Message-ID: <20240427152648.25434-1-mans@mansr.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cfcb4465e992 ("can: slcan: remove legacy infrastructure")
removed the 10-device limit.  Update the Kconfig help text accordingly.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/net/can/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index f8cde9f9f554..2e7bea4129a0 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -184,9 +184,8 @@ config CAN_SLCAN
 	  slcand) can be found in the can-utils at the linux-can project, see
 	  https://github.com/linux-can/can-utils for details.
 
-	  The slcan driver supports up to 10 CAN netdevices by default which
-	  can be changed by the 'maxdev=xx' module option. This driver can
-	  also be built as a module. If so, the module will be called slcan.
+	  This driver can also be built as a module. If so, the module
+	  will be called slcan.
 
 config CAN_SUN4I
 	tristate "Allwinner A10 CAN controller"
-- 
2.44.0


