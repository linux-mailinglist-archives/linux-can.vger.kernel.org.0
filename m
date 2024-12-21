Return-Path: <linux-can+bounces-2478-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F216A9FA05A
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 12:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64970167EEE
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 11:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9401F37D1;
	Sat, 21 Dec 2024 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="ebNFZMVG"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6EC1F2C3F;
	Sat, 21 Dec 2024 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734779723; cv=none; b=NtczvclpLftlvanKGjBBp0m+yuRnhA4SkauoERhepDxZ7CGe7cmT2SFaxxeF+4wMKi5RT0mVTHphX5nMUqB2D00pC+yMizdadSCy9CeyhGZq4+L9z2DPOF3XQT/YNjXsQoR+Qu0LctTnhDMjmwmBJZFNZ8vk11soCPqMhDGxJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734779723; c=relaxed/simple;
	bh=FF8B7+0RGu9p6ZX98LtsbrCpQ5iZLU71QjDKC8O2Aqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=equ42Yy2trs3yM7ehAJAEzkEkUjBvboikM6h52G4gEk8/iNgY4IDhBvx5JCKOLjwgKNhLDghpu0oDmDE8oShB/4wXermav9u7oz6xPIBAJk8wxHFghaJm7YYhWxzsT2UnRJntPH9z7L++9iPksWf7Y5BRQlOR1Dm9yo0TPhpwHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=ebNFZMVG; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1734779721; x=1766315721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FF8B7+0RGu9p6ZX98LtsbrCpQ5iZLU71QjDKC8O2Aqc=;
  b=ebNFZMVGwlP1nSHNQnZ+BmrDjYGFW1RoLix/7ev4Al1w2eVI+08OkFS4
   +u27ypGsqYITo+bFVXhSDTFXE40bG+TPFbTMjw4mVj+Zor7KxQTEP573/
   jw74mUXmVwBpI03wTztlyEr80Zd24hb2qMhF6VcS6mZMLgIjYUsDy/DhO
   I=;
X-CSE-ConnectionGUID: 0Htoea1LSy27Hydsge8c3w==
X-CSE-MsgGUID: 9Er96X2GTLKtfr/ATG7NlA==
X-IronPort-AV: E=Sophos;i="6.12,253,1728943200"; 
   d="scan'208";a="28285772"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 21 Dec 2024 12:15:12 +0100
Received: from localhost.localdomain (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id A424824E2;
	Sat, 21 Dec 2024 12:15:11 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-can@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 2/3] usb/cx231xx: Remove unused value
Date: Sat, 21 Dec 2024 12:06:48 +0100
Message-ID: <20241221111454.1074285-3-ariel.otilibili-anieli@eurecom.fr>
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


