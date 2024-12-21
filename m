Return-Path: <linux-can+bounces-2474-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7139F9E2B
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 04:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5501E16BFC6
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 03:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848121DC9B9;
	Sat, 21 Dec 2024 03:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="onGQsIae"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3C913A244;
	Sat, 21 Dec 2024 03:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734753271; cv=none; b=DjDECUxG2aX+g6Br310Vr/can4UVLrT0PS6wxVNZ4zHExif6lo1iX6ZHg+ghQjAwrHo92Wy5dZNObWc8m6Uzt8u5TPhmuVvJIWx6ur+mS5Kt4oSiStR58LzHrnJFygHUIz26Zqvl8lTJVF9x3WU2OaiY6UTezBBIvtKynrKyc4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734753271; c=relaxed/simple;
	bh=FF8B7+0RGu9p6ZX98LtsbrCpQ5iZLU71QjDKC8O2Aqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqpG1TnR19NmLW+PFiZac0s0SPNlaBf+HHd9G0hwj+19/IZf4aTe6cQ1CVuqcUfQj8k1gHLCSG7Xy8AHl4P4LbpPVhlEgX0eDPZAo7W7B0OJvoNWCskkNDwTc/FGQdHNlnjWOGL2tCzJV/q8uJ44jzFVIZQUsJcN2NBe006i6Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=onGQsIae; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1734753270; x=1766289270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FF8B7+0RGu9p6ZX98LtsbrCpQ5iZLU71QjDKC8O2Aqc=;
  b=onGQsIae2uqOG8zCCKHSoclbrUANkcOTJGYpqxRcBNMI02l6sltdM6Eg
   dyaxXQsnYOcxABJgnX57xFL5ERbIAo5pJEecvEvniH9HThGs7tqz8+Xxf
   ip2WR0DtKiZe1x2xvbaFPXJor5Qmfc6pSCp8/cnm+rjpr57WBv3dwn8Tc
   4=;
X-CSE-ConnectionGUID: 5WYlqwa2RwqwN+m26FPHxw==
X-CSE-MsgGUID: SvKPCDhoQDqRZpLYtHWL/w==
X-IronPort-AV: E=Sophos;i="6.12,252,1728943200"; 
   d="scan'208";a="28282876"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 21 Dec 2024 04:54:29 +0100
Received: from localhost.localdomain (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id 1128E24CB;
	Sat, 21 Dec 2024 04:54:28 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-can@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 2/3] usb/cx231xx: Remove unused value
Date: Sat, 21 Dec 2024 04:44:16 +0100
Message-ID: <20241221035352.1020228-3-ariel.otilibili-anieli@eurecom.fr>
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

Coverity-ID: 1269153
Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
---
 drivers/media/usb/cx231xx/cx231xx-avcore.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-avcore.c b/drivers/media/usb/cx231xx/cx231xx-avcore.c
index 1cfec76b72f3..f2a2d0c39080 100644
--- a/drivers/media/usb/cx231xx/cx231xx-avcore.c
+++ b/drivers/media/usb/cx231xx/cx231xx-avcore.c
@@ -1896,7 +1896,6 @@ int cx231xx_dif_set_standard(struct cx231xx *dev, u32 standard)
 		status = vid_blk_write_word(dev, DIF_SOFT_RST_CTRL_REVB,
 						0x00000000);
 		/* Save the Spec Inversion value */
-		dif_misc_ctrl_value &= FLD_DIF_SPEC_INV;
 		dif_misc_ctrl_value = 0x3A093F10;
 	} else if (standard &
 		  (V4L2_STD_SECAM_B | V4L2_STD_SECAM_D | V4L2_STD_SECAM_G |
-- 
2.47.1


