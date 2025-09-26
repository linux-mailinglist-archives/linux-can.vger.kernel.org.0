Return-Path: <linux-can+bounces-5034-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C8FBA3A8A
	for <lists+linux-can@lfdr.de>; Fri, 26 Sep 2025 14:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1101D1891616
	for <lists+linux-can@lfdr.de>; Fri, 26 Sep 2025 12:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AB92D6E5C;
	Fri, 26 Sep 2025 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="jL6a/pNa"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC67283CB5
	for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758890584; cv=none; b=EKzK2/slqg1KWoTBIbrAj6eJB93COjOOhEWkAmCJ15dwnFgVK6odOL2N9kwH+L3FidA+pVIg3UA4OUlteD17PMYkGQJiXS3a75oI+C8KpfkpGHppl9DU8knc/+nBuXap5U7sLZE9k2/kbQeJDHR7qbwnIiZQYJunRr4NHtDJA60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758890584; c=relaxed/simple;
	bh=ppnqmuTdH3n76Jdemg/67F4rgAfwLStSaPhQhVLkGUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hdIn8a+QaEBXabAddbDNNU0qmt1bCO07a1EU2kt4dLIiRzYWHqXng8ANFSJ1vpqJxigIttk99gUBdMl2SmCCcy23bX14tFHfEDsk9c+/5QsSmdI1CYGWy/BcNSTXG9C4QGiKN1hQDYTVjjSSvlJobXpqOjBVRLn/1i96QbiJS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=jL6a/pNa; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 5ABAB4DCB0
	for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 14:42:52 +0200 (CEST)
Received: from stf-laptop.. (unknown [IPv6:2a02:8428:60a1:3e01:1da0:a281:a825:e63])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 57B116013D;
	Fri, 26 Sep 2025 14:42:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1758890565;
	bh=ppnqmuTdH3n76Jdemg/67F4rgAfwLStSaPhQhVLkGUQ=;
	h=From:To:Cc:Subject:Date:From;
	b=jL6a/pNaUfGa1jN4cdzrekQF2VRA5SsfpBM8FGaQ59+LJL4G5clifZKF7Zz6ssY1f
	 R2cdCKrQEuilBq8Jk4FmnohKrg5dGdnOYmM4oE2u2SY2+WuNvtnBtnunzhQrkE73GM
	 l766Q2MaX4yMzDfCdLwKutAzPUj3y+coARmHJwx/PCO914Z+WAkKNa4G8kljW/Kw9I
	 chGehy8DwlsKb/K/NBYTtLUW48JglbJCcRoVCWlKthgVsplpG1z/4rzj5LNwFSW9QY
	 Av1Ue1F4BD0QxGZ4zv0ACvasbqeLybpuzGQu8/xg1IMRlY+0Mokqj7GCzxd7vaX1Z1
	 pKaii/Sv0uo2w==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@hms-networks.com>
Subject: [PATCH] can: peak_usb: align variable declaration and usage
Date: Fri, 26 Sep 2025 14:42:20 +0200
Message-ID: <20250926124234.376881-1-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <stephane.grosjean@hms-networks.com>

delta_ts must be 64-bit due to possible 32-bit shift.

Signed-off-by: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
Fixes: c443be70aaee ("can: peak_usb: fix shift-out-of-bounds issue") 
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index dd5caa1c302b..93b33ee6f6a3 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -108,7 +108,7 @@ void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now)
 
 	/* should wait at least two passes before computing */
 	if (ktime_to_ns(time_ref->tv_host) > 0) {
-		u32 delta_ts = time_ref->ts_dev_2 - time_ref->ts_dev_1;
+		u64 delta_ts = time_ref->ts_dev_2 - time_ref->ts_dev_1;
 
 		if (time_ref->ts_dev_2 < time_ref->ts_dev_1)
 			delta_ts &= (1ULL << time_ref->adapter->ts_used_bits) - 1;
-- 
2.43.0


