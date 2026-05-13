Return-Path: <linux-can+bounces-7625-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCcQC131BGoTQwIAu9opvQ
	(envelope-from <linux-can+bounces-7625-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 00:04:13 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BD753B3B6
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 00:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02852300C3B3
	for <lists+linux-can@lfdr.de>; Wed, 13 May 2026 22:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C473CC323;
	Wed, 13 May 2026 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BsYfrTui"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB3C3CBE6D;
	Wed, 13 May 2026 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709829; cv=none; b=s3xM6v2bPX0EkyFT/I+lt97m78MuhCDB29eyTxI0QiDD0z6f3mQ7nxtEPa2HlQJiKKkDE2tWipMJTqrMPTYIRGBPWuupXJQGEe4zOj9r5Ld+reAkcnCwraud0mWuKhkJyKeDIiKCZptL8sj/3VPjWhr9sr2RNoB2aIJGGLRsQFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709829; c=relaxed/simple;
	bh=DaSEWkcGChJRbPa/Kx7Iym2uzGhsNUktEg9iDbhkjbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtQWLRJv9sY7QLdOPOlkTl3BVsRQJhtiex2nymR9J3Yyi5gEzSXbsKO5JvaUPNtR29Bmnfhu2pe42P5Mg+RG8V/9fD75z+rD/g4dcWpvtgyUBcAtzSxEDZMSrbLUzDoW9NN7/HITXp1voK0zwsYI4yZeP4NFHQORn9OGVW++7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BsYfrTui; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778709828; x=1810245828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DaSEWkcGChJRbPa/Kx7Iym2uzGhsNUktEg9iDbhkjbA=;
  b=BsYfrTuidnvMJKCRFvqPAzoHhU2QdmocmDMSXOAL/ers0U8EfKZPZYNw
   GSblgtjwkoSidxsfYFRsVv0QxYWY7tE99sHXGIJLB0vA0Zc9uluuooqsL
   2wrnGSro88Is4AS8Cfmj/abZGZ5U/yVemG0HthAIbdABdm4XdUpfszPes
   t5oixpJo+RVL3bVdyy/GU2mgKCtjKOkuh1K+YLxHwYiZZmbctgMrTQTYO
   BmphtTypmks9NxxBTfAY2AbVN2r/AtFeSJcz2+OWaJvxWFufWeFnpgdM8
   SPllJ6INtoYGv2F9tW+EdwIwYJ93qXhBpApsq6tJmX/8EvLYqqnt2apv5
   g==;
X-CSE-ConnectionGUID: 2AwnK3w+QoSBjwVF1HQY+w==
X-CSE-MsgGUID: ApFJlayTQ1+mPh+8WWWbOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90749942"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="90749942"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 15:03:46 -0700
X-CSE-ConnectionGUID: tLdInD+aSRSBc/tIw5b1wA==
X-CSE-MsgGUID: AcF7mBz3S9GpOE2PnWCriQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="237224944"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 13 May 2026 15:03:43 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id A4B759E; Thu, 14 May 2026 00:03:38 +0200 (CEST)
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
Subject: [PATCH v5 5/6] phy: phy-can-transceiver: Decouple assignment and definition in probe
Date: Thu, 14 May 2026 00:01:30 +0200
Message-ID: <20260513220336.369628-6-andriy.shevchenko@linux.intel.com>
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
X-Rspamd-Queue-Id: 04BD753B3B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7625-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Action: no action

The code like

	int foo = X;
	...
	if (bar)
		foo = Y;

is prone to subtle mistakes and hence harder to maintain as the foo value
may be changed inadvertently while code in '...' grown in lines. On top
it's harder to navigate to understand the possible values of foo when branch
is not taken (requires to look somewhere else in the code, far from the piece
at hand).

Besides that in case of taken branch the foo will be rewritten, which is
not a problem per se, just an unneeded operation.

Decouple assignment and definition to use if-else to address the inconveniences
described above.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/phy-can-transceiver.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 3cebaa54f7db..30330499585b 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -128,8 +128,8 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
 	struct mux_state *mux_state;
-	int err, i, num_ch = 1;
 	const char *propname;
+	int err, i, num_ch;
 	u32 max_bitrate;
 
 	drvdata = device_get_match_data(dev);
@@ -138,6 +138,8 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 
 	if (drvdata->flags & CAN_TRANSCEIVER_DUAL_CH)
 		num_ch = 2;
+	else
+		num_ch = 1;
 
 	priv = devm_kzalloc(dev, struct_size(priv, can_transceiver_phy, num_ch), GFP_KERNEL);
 	if (!priv)
-- 
2.50.1


