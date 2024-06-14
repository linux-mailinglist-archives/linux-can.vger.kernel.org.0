Return-Path: <linux-can+bounces-752-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DFA908E76
	for <lists+linux-can@lfdr.de>; Fri, 14 Jun 2024 17:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515371F27775
	for <lists+linux-can@lfdr.de>; Fri, 14 Jun 2024 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A52B1591E8;
	Fri, 14 Jun 2024 15:15:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A65915FCE7
	for <linux-can@vger.kernel.org>; Fri, 14 Jun 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378152; cv=none; b=R7DGTZvIMeXFbEWQHgu6N0ntwlngvdQFg/dkcLOWl9vCtDh/MGeMhX744q3RF9ZVNwudTxXZLMwHWfegFHx12NkAQtD0V71TY81kB4sZ8MfwqqLSBLwiURa4jeMOLJCevB8TFafGAtGlpO1q0/Zm0ajUvabHjjMoAXsbuZkgPjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378152; c=relaxed/simple;
	bh=a0comCYX5UTVsuppaBqCQ/6FtvXp3om3CP+5NzCrGY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RxCerWb4mEO0ru/yM2K8JDg922YYwIMeeBqnb8LjYMp0peU3g4neJ/1Og3bCuO9knRRqvK/J4hqLZcDD+eYwvaW5WZrOKp0T/ALWjAy4uUVoIJ1XqkGOGiK4VnMECZWg5OeptKa4hZiT031sWAiF0CqEZYx67SOBFJSme4B/bhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id A83A4E00FF;
	Fri, 14 Jun 2024 17:15:41 +0200 (CEST)
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH 0/7] can: kvaser_pciefd: Minor improvements and cleanups
Date: Fri, 14 Jun 2024 17:15:17 +0200
Message-Id: <20240614151524.2718287-1-martin.jocic@kvaser.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Minor improvements and cleanups for the kvaser_pciefd driver
in preparation for an upcoming MSI interrupts patch series.

Martin Jocic (7):
  can: kvaser_pciefd: Group #defines together
  can: kvaser_pciefd: Skip redundant NULL pointer check in ISR
  can: kvaser_pciefd: Remove unnecessary comment
  can: kvaser_pciefd: Add inline
  can: kvaser_pciefd: Add unlikely
  can: kvaser_pciefd: Rename board_irq to pci_irq
  can: kvaser_pciefd: Change name of return code variable

 drivers/net/can/kvaser_pciefd.c | 85 +++++++++++++++------------------
 1 file changed, 39 insertions(+), 46 deletions(-)

--
2.40.1


