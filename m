Return-Path: <linux-can+bounces-761-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9C0908E94
	for <lists+linux-can@lfdr.de>; Fri, 14 Jun 2024 17:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BCABB2CE15
	for <lists+linux-can@lfdr.de>; Fri, 14 Jun 2024 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8854715CD64;
	Fri, 14 Jun 2024 15:20:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17661591FD
	for <linux-can@vger.kernel.org>; Fri, 14 Jun 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378413; cv=none; b=IigP3kMZ1nBnk1O+RklaDo/CSqzI87F25JPeKukNpWzTXYk7WeS6bEg+mJItzDwG/iZDApzFejvfMTuFWpuY6YBGbZPk4vMZF/xzLyomlzXt6TaJ7WPhjpmd3SXQrlU5SjMlcmGZmTaU1vIIlnSZEGAcjMt3YzwGlPSF7Zfhvqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378413; c=relaxed/simple;
	bh=EzKvAtopeq9Ayfq68BjugjgjR8X1BOIDlTeeEmK7N7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dG3tXSYRmXiDVPeI2NWgkMjRQJQ847GCmKrmNVoPp51u1e0Wc6BCdC1Lw1TJTaLOE44aWmkHtI+Cu6L1NIreQswZ9vSVUgwx0En2jz5xqZ9ekWHCQ8dEE3HipOhIuvB9fN/hIDqYL5+3G1mjVS0mSqdZRD9MbWz1tiIVTp7szXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id C74C2E0418;
	Fri, 14 Jun 2024 17:20:10 +0200 (CEST)
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH 0/2] can: kvaser_pciefd: Support MSI interrupts
Date: Fri, 14 Jun 2024 17:20:06 +0200
Message-Id: <20240614152008.2730746-1-martin.jocic@kvaser.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for MSI interrupts. It depends on
the patch series can: kvaser_pciefd: Minor improvements and cleanups.

Martin Jocic (2):
  can: kvaser_pciefd: Move reset of DMA RX buffers to the end of the ISR
  can: kvaser_pciefd: Add MSI interrupts

 drivers/net/can/kvaser_pciefd.c | 54 ++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 15 deletions(-)

--
2.40.1


