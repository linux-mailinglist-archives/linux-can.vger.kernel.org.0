Return-Path: <linux-can+bounces-2479-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3520A9FA060
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 12:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDDA87A1005
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 11:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3589F1F543B;
	Sat, 21 Dec 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="zJzq7UBa"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6B91F0E3C;
	Sat, 21 Dec 2024 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734779724; cv=none; b=hFXUip8m3wkTeUDPFNkeP/YYPQzFnZHpWctNHx9bH5ri6dBg3H+/CFd8xYB04P673Bh3ROEcfWV38TilZCq4Rr49XevvRkp7LQc+Uck/kg8jY5qLyfy6qQZ72LeaSHXbGOtxVBOgUks2MoBdCNW7a8iIsYRFq6VyIDCi8oAI7XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734779724; c=relaxed/simple;
	bh=qyuZSQuSPdf+MYhk0zy0wHji1939KejojCXtx3DRgXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAobpJ/5+3JMgsAOxhgWZFGnId1vUPI4V3h9XSMyKLMIFmMfCAQaK0n9KUrf8AVHJTU03oySa/+xpTBANpCbDWvexuQVMiUt+OrUhZi6bKfhIk4vNbHenT3r0O+W6nODUfES3F9rQg7flXjYmdCYedNz3kqUMdGh2qJ8D/tLWOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=zJzq7UBa; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1734779722; x=1766315722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qyuZSQuSPdf+MYhk0zy0wHji1939KejojCXtx3DRgXA=;
  b=zJzq7UBa0jfvwb+7LaP/COgp9O07a51HzDsUyuoxC0Bfe4Ru4qqEzExU
   Ou1UsOThjxJ35P4mX1nPi4c4I5NGW2XkMdg6HezsCRGj3wOzaT4yEz3h3
   IB2elz0wG9IdWCYtwhyn6HddIr+3mQchIlSbwQWwbQbCG/ICFQc4MqS+u
   c=;
X-CSE-ConnectionGUID: zjX0CKoeTtyYI2U61AsfwQ==
X-CSE-MsgGUID: iNsk4kxzSX2gvtZZPyxRwQ==
X-IronPort-AV: E=Sophos;i="6.12,253,1728943200"; 
   d="scan'208";a="28285774"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 21 Dec 2024 12:15:17 +0100
Received: from localhost.localdomain (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id 7247D24E3;
	Sat, 21 Dec 2024 12:15:16 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-can@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 3/3] net/can/dev: Remove dead code
Date: Sat, 21 Dec 2024 12:06:49 +0100
Message-ID: <20241221111454.1074285-4-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221111454.1074285-1-ariel.otilibili-anieli@eurecom.fr>
References: <20241221035352.1020228-1-ariel.otilibili-anieli@eurecom.fr>
 <20241221111454.1074285-1-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default switch case ends with a return; meaning this return is never
reached.

Coverity-ID: 1497123
Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
---
 drivers/net/can/dev/dev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 681643ab3780..5ec3170b896a 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -85,8 +85,6 @@ const char *can_get_state_str(const enum can_state state)
 	default:
 		return "<unknown>";
 	}
-
-	return "<unknown>";
 }
 EXPORT_SYMBOL_GPL(can_get_state_str);
 
-- 
2.47.1


