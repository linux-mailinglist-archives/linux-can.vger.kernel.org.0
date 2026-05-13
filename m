Return-Path: <linux-can+bounces-7621-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNcxMV71BGoTQwIAu9opvQ
	(envelope-from <linux-can+bounces-7621-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 00:04:14 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 724FE53B3BE
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 00:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A165830440AB
	for <lists+linux-can@lfdr.de>; Wed, 13 May 2026 22:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9F03CAA50;
	Wed, 13 May 2026 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRbanQgn"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B73C9EE8;
	Wed, 13 May 2026 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709825; cv=none; b=QuRvRZo42W8LniJQG4C2jXeoKMxIf+W/okrFBOIvmn/dWy/z6pPSQmgoaCwVYWJmI5PVZSFuKgGmkXlfALwzOmjx3ZN6C6Q4lRMuDNH+kcFuI4aNK2LckRU2/hFzB0FbrGmAzHH/8LYhZyRjxpQ2vyk3XUfp87wxACztO0bPTx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709825; c=relaxed/simple;
	bh=s1l6DhuaA7WFVhf4UoEJrdxY4F6P6ok+s6nAgwQYEyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYm7wk2EZfq8EPuLJAo+90nN0B5pOLvcdGHdm6+BDL7Nce+gnl9TZ7KFh/jD9qRWKJfBQA1K7nxBG5SlAPO6fHkmu2Xyv9GN9YrKEZo2fFJaQs/JGYhdPTDg8myYCj1GLrMZo2CZCjZozP91zjthLd6/hMAOjVEVsqo0g+nePkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRbanQgn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778709825; x=1810245825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s1l6DhuaA7WFVhf4UoEJrdxY4F6P6ok+s6nAgwQYEyM=;
  b=YRbanQgnYrBu1KWnWlYTTsT3xFy5xB0DC3vdXa3+rk2bfun+E17NSjI2
   DTBS5WntDVicUQxPNghyvmZWTZX1mspeZQUXMoa/NcoINuHrY1GNkyOBK
   UNIMSFlKSX4YHRhivzVl4XEAV2RBQ+MonMV4PxtoAkIkxs26QWwDspSwz
   QzVVdZvtADfOrbhy4YsHufK3vXEjYXCAYw/s5BiSVgu41myXs+qhaLIRo
   U2iDBun+aPbTvJxM1BqjJ1MvIyGfUuSbz0HKg9eDe3Ix/28/OQvSz7qp4
   8m1WZ3urGNShtxeSlRafE/VTRJv59JrBOdNjCgfw6Up7WlJMIv2JvCr6q
   A==;
X-CSE-ConnectionGUID: VXZEgsxbRumQlD5vR/tpbw==
X-CSE-MsgGUID: FopKuq2QQVeRyxb2a5klTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90749922"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="90749922"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 15:03:43 -0700
X-CSE-ConnectionGUID: fSwRn+XBRfa1aqTgtgCdUg==
X-CSE-MsgGUID: mO5ryQoFST23JZGYRgMgzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="237224938"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 13 May 2026 15:03:40 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id A068F9D; Thu, 14 May 2026 00:03:38 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Peng Fan <peng.fan@nxp.com>,
	linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 4/6] phy: phy-can-transceiver: Don't check for specific errors when parsing properties
Date: Thu, 14 May 2026 00:01:29 +0200
Message-ID: <20260513220336.369628-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513220336.369628-1-andriy.shevchenko@linux.intel.com>
References: <20260513220336.369628-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 724FE53B3BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7621-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

Instead of checking for the specific error codes (that can be considered
a layering violation to some extent) check for the property existence first
and then either parse it, or apply a default value.

With that, return an error when parsing of the existing property fails.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/phy-can-transceiver.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 5c9698f77c7d..3cebaa54f7db 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -128,8 +128,9 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
 	struct mux_state *mux_state;
-	u32 max_bitrate = 0;
 	int err, i, num_ch = 1;
+	const char *propname;
+	u32 max_bitrate;
 
 	drvdata = device_get_match_data(dev);
 	if (!drvdata)
@@ -151,9 +152,17 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 
 	priv->mux_state = mux_state;
 
-	err = device_property_read_u32(dev, "max-bitrate", &max_bitrate);
-	if ((err != -EINVAL) && !max_bitrate)
-		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
+	propname = "max-bitrate";
+	if (device_property_present(dev, propname)) {
+		err = device_property_read_u32(dev, propname, &max_bitrate);
+		if (err)
+			return dev_err_probe(dev, err, "failed to parse %s\n", propname);
+
+		if (max_bitrate == 0)
+			dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
+	} else {
+		max_bitrate = 0;
+	}
 
 	for (i = 0; i < num_ch; i++) {
 		can_transceiver_phy = &priv->can_transceiver_phy[i];
-- 
2.50.1


