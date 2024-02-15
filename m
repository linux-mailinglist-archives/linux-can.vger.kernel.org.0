Return-Path: <linux-can+bounces-281-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47825856784
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 16:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86121F210BE
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395BB133282;
	Thu, 15 Feb 2024 15:27:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFB2132C1C
	for <linux-can@vger.kernel.org>; Thu, 15 Feb 2024 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010841; cv=none; b=G/W4KOmiKSMtxErPWtTtl/E6l8xlNcPxgRiod6Nkczp3uqGHCL0DY1i3hb+zesQ9MhN3bZFzUfJ0O4L2l+dptuNBkwnzWBFAM9mJuOi/3lO9IEzsu7RPcb1j4pEzZuLixB9y4fQavVMgg7oOHtMtoNTlGsUpJTrCopCBT7+2kx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010841; c=relaxed/simple;
	bh=KjHOOGxx3VW3eiB5SGwJOFMHLo6NbJjw6XNHpiUO95Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cHCGDX64hi4iFNEffN8ozDbji8uMRSV0R2pgRwrBwkG1+/a2bKDCA5o9O0Kc+E/Kz+JR3nGUDFi/0tuP8ybpr6XV/TyQUrsWvN5NMSZ985RzbTFjmaRehRCSHXE/F/Rrh99QTmDg+C4Z6oqTDL8QjjLBBqmsv9Fhk+sxCNBtfbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peak-system.com; spf=fail smtp.mailfrom=peak-system.com; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peak-system.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=peak-system.com
Received: from stf-laptop.. (unknown [IPv6:2a02:8428:60a1:3e01:d1b:b57b:aee8:95cc])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 72D01B005AA;
	Thu, 15 Feb 2024 16:27:06 +0100 (CET)
From: Stephane Grosjean <s.grosjean@peak-system.com>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 1/3] can: peak_usb: fix potential "UBSAN: shitf-out-of-bounds" issue
Date: Thu, 15 Feb 2024 16:26:54 +0100
Message-Id: <20240215152656.13883-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shift exponent 32 is too large for 32-bit type 'int' so u64 values are
used instead.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 1efa39e134f4..edecb6e09c3c 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -108,10 +108,10 @@ void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now)
 
 	/* should wait at least two passes before computing */
 	if (ktime_to_ns(time_ref->tv_host) > 0) {
-		u32 delta_ts = time_ref->ts_dev_2 - time_ref->ts_dev_1;
+		u64 delta_ts = time_ref->ts_dev_2 - time_ref->ts_dev_1;
 
 		if (time_ref->ts_dev_2 < time_ref->ts_dev_1)
-			delta_ts &= (1 << time_ref->adapter->ts_used_bits) - 1;
+			delta_ts &= (1UL << time_ref->adapter->ts_used_bits) - 1;
 
 		time_ref->ts_total += delta_ts;
 	}
-- 
2.34.1


