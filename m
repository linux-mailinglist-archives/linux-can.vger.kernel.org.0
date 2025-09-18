Return-Path: <linux-can+bounces-4751-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C4CB84C9A
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 15:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5273B05DB
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 13:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B8E1DDC2B;
	Thu, 18 Sep 2025 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="XTUHvNZW"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE88F302151
	for <linux-can@vger.kernel.org>; Thu, 18 Sep 2025 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201945; cv=none; b=cGzg5b4nzmpMd0x+1pVWyo33/DieuuVMxt4tDShqBFfaLomW9erLyZSB1BI9RTpUuHFi5dbnshzO8X9sqmNdvqN7vapg+ffEi8OXrVkN+wxJtxrtu2b7hu9DXQHMXKa1eNBAM5YCVAZfeMbCp373+DmIs9KC9N9Azc+oN77Ga6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201945; c=relaxed/simple;
	bh=4jq0HeZwzJ9A7i4E6BhF4oqQ0PXhUljO0ZYEXORUXlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SA2LIk5mfPe9X0kAxZWBB5bvnEJhsUn4Rk4LmLCMKVb3bXkUo+E8V6Mg9dG1Us2GBw+5xXYFdPlV6vkKXVOIUefNI+TQhOwFdC059+iKZBom4swqofJYG2st+BJRl/lk7D4DyEofZQfvMYVYqxGdIWChEfzR3tCPymO7lQw7Na8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=XTUHvNZW; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 5CFEFDF963C
	for <linux-can@vger.kernel.org>; Thu, 18 Sep 2025 15:25:33 +0200 (CEST)
Received: from stf-laptop.. (unknown [IPv6:2a02:8428:60a1:3e01:3bd5:7f5f:ab:b3a6])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 8546319F73F;
	Thu, 18 Sep 2025 15:25:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1758201926;
	bh=4jq0HeZwzJ9A7i4E6BhF4oqQ0PXhUljO0ZYEXORUXlc=;
	h=From:To:Cc:Subject:Date:From;
	b=XTUHvNZWYFX8hjC1Km7sFdk7pyXd438NQBnihiCW6+hfuK2KWJ/z/tRuZooQgSCdp
	 Hc1N2P5Nba8MBCJeQE902xGGdrn/2tMlf8l5BUhki3Z3iZwiU67pNrBjjCLIEmDArx
	 h6Os0Hxfe+FWpRMM/ZmyM/a/UYi5PeH5YYfby22HQcBZtXfiEgZCE1pyCPjS+2Gtp0
	 2zo8AGAUDza7414fLZmdNVO19O3JXqFJoETzqs8LQ+RZnOVmTWZTluHP42niKhW0+5
	 /mBnT+sQTVD1Yg4usjdHs/a2W2UXeyCWwVhpm5zR3SikATjD9RqKDI1RF6CDiR7ob1
	 25TdsLcjwSDwg==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@hms-networks.com>
Subject: [PATCH] can: peak_usb: fix shift-out-of-bounds issue for 32-bit architectures
Date: Thu, 18 Sep 2025 15:23:57 +0200
Message-ID: <20250918132413.30071-1-stephane.grosjean@free.fr>
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

Explicitly uses a 64-bit constant when the number of bits used for its
shifting is 32 (which is the case for PC CAN FD interfaces supported by
this driver).

Signed-off-by: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 5a207c96383f..3fb9bd729959 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -111,7 +111,8 @@ void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now)
 		u64 delta_ts = time_ref->ts_dev_2 - time_ref->ts_dev_1;
 
 		if (time_ref->ts_dev_2 < time_ref->ts_dev_1)
-			delta_ts &= (1UL << time_ref->adapter->ts_used_bits) - 1;
+			delta_ts &=
+				(1ULL << time_ref->adapter->ts_used_bits) - 1;
 
 		time_ref->ts_total += delta_ts;
 	}
-- 
2.43.0


