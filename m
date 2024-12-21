Return-Path: <linux-can+bounces-2475-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAFD9F9E30
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 04:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9871188FEA4
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 03:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF3E1DB943;
	Sat, 21 Dec 2024 03:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="RvQC99rs"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F219713B5A9;
	Sat, 21 Dec 2024 03:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734753276; cv=none; b=cIuClgiLEZvLG6SsZchXyJtGABo0Kq+F5SKIXDROzxUetBUf/Iz8VnhU1OpFxuT67P7PdLPeiBUFMD3iQQ9CpM2+4qh5K61zb6D+C8LksF8fXPECsBS1CxLRbTipTtX8kHSlC5dXjUxpbuxEGEDViG/zSbCOybv4jmY9fQiFWhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734753276; c=relaxed/simple;
	bh=9LxhP2Una6DEO/awpeuo7oWgBNDXGbZ0xno755wh+Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FE76vncognbmnjOBjizT8WZcKxlDC9P7u+dZwv+arh6Oax9kNbTN7SwoFNYrTiJmL8cmfsAMXkH4p/yGu7IUONIoTT1OQwtNolvb62ueykQqj0JrQpsz9DkfXbrxVcvragKRcW/Lm+cYgAfHlHzdP5JHl8+/jEplzmJ1izBzdl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=RvQC99rs; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1734753275; x=1766289275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9LxhP2Una6DEO/awpeuo7oWgBNDXGbZ0xno755wh+Wo=;
  b=RvQC99rsaP+gcrKxysIL6WlCAYe9T4n2+hOoQrRmw9wPFhQYICsUgG/U
   9unUoHnNOHbd/iWOCGlhDxTze+O+Q1ogpLCn0k0iGzq2mQq8/Jcj41kDT
   lcijOnevW1PGrfS0XrU8QhDR6HA3WOWx7K7v9/5sxsHGMrRWXHk7cLLhA
   A=;
X-CSE-ConnectionGUID: son8TozXTGSzhCADkuivKQ==
X-CSE-MsgGUID: UjZvEwmAQQGFR1YhZCi7ww==
X-IronPort-AV: E=Sophos;i="6.12,252,1728943200"; 
   d="scan'208";a="28282877"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 21 Dec 2024 04:54:33 +0100
Received: from localhost.localdomain (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id E84BC24CC;
	Sat, 21 Dec 2024 04:54:31 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-can@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 3/3] net/can/dev: Remove dead code
Date: Sat, 21 Dec 2024 04:44:17 +0100
Message-ID: <20241221035352.1020228-4-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221035352.1020228-1-ariel.otilibili-anieli@eurecom.fr>
References: <20241221035352.1020228-1-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default switch case ends with a return; meaning this return is never reached.

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


