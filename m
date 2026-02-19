Return-Path: <linux-can+bounces-6603-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E36HOFyl2kSywIAu9opvQ
	(envelope-from <linux-can+bounces-6603-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 21:30:25 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B3C162548
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 21:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A488B3053DF5
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 20:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B0F31960A;
	Thu, 19 Feb 2026 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3Zomwb1"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F5E318EFA;
	Thu, 19 Feb 2026 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771532959; cv=none; b=UZgZWeI+mySGvO9EPw4wtYMD3pjJDOWrAoIiT88ZNc/fCxJx/kn/jYmb89naEFa0N/mvhznOjjzdbB4VGX0tnAglWmTQCpkyMjznE2oCPoeJsJRa2rdtlb3picermxFcS0KXDi3EIe+uAVpqQPQiqjzdYTAhJ/kwA4jwPACEdL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771532959; c=relaxed/simple;
	bh=O395g583JciclhAYkpkhPwswiSCKjgtzscqic/6jAKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shezwgB0ilZR3+kTY6bxO4mMhFkuO8rST4tNqzNIOXhRZYmQiv5PyVrarZjXSXKGxcwcq572hrsU/uS9lWv3wB1bEW2d3XTaHUPu1ZcSQx3SnW+gZcf7q5pg+8uXk7N7PGPEqDj5Lb6Wmyg04Ez4iN5nMxZpVEKmOCuuo5fWpCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3Zomwb1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771532957; x=1803068957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O395g583JciclhAYkpkhPwswiSCKjgtzscqic/6jAKw=;
  b=B3Zomwb1F5J/tDhTRL+byqr22jxjAcuaM0R2mHeKckq4cC6LtNbCrwKJ
   U8iU7FnqyCTqWU62o0gYihioZ883iBhX/zBKt7EukmdyLb7f68OGBwnIz
   3+fR2uge0VJHkGZRGD5FV982UTOkseZZjHA1Tp0mEjkwU/AwVyQHR3UYq
   jWY9pc1uuQp17TDK97P0YZnVqyoBAbVZ3bmy+ZMVpLchUkkXMtBZCaEFf
   W7eZpGxSlGUGDTWXy3jEjAgKSCan1p5ZuSAJ05om3FYKNJa2AsuIefjC8
   /jNBUZ6BdJi1mYryro3BECA9FcVuehvQN9xnnQjqR9UzouRnNXwJvZX0P
   Q==;
X-CSE-ConnectionGUID: 0ko//MtySY6UNxMJ4I0cvg==
X-CSE-MsgGUID: p8/mNKs1T060h1laAfuYHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72532342"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="72532342"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 12:29:15 -0800
X-CSE-ConnectionGUID: HwgZ1UnqRwORsfJSozvKEQ==
X-CSE-MsgGUID: OKz+UufCT4O4dB1lvn7Oxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="219183209"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 19 Feb 2026 12:29:13 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 035B999; Thu, 19 Feb 2026 21:29:12 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] phy: phy-can-transceiver: Move OF ID table closer to their user
Date: Thu, 19 Feb 2026 21:26:20 +0100
Message-ID: <20260219202910.2304440-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260219202910.2304440-1-andriy.shevchenko@linux.intel.com>
References: <20260219202910.2304440-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-6603-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,ti.com:email]
X-Rspamd-Queue-Id: C7B3C162548
X-Rspamd-Action: no action

There is no code that uses ID table directly, except the
struct device_driver at the end of the file. Hence, move
table closer to its user. It's always possible to access
them via a pointer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/phy-can-transceiver.c | 59 +++++++++++++++----------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index f2259af4af8a..dd08faf46837 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -97,35 +97,6 @@ static const struct can_transceiver_data tja1057_drvdata = {
 	.flags = CAN_TRANSCEIVER_SILENT_PRESENT,
 };
 
-static const struct of_device_id can_transceiver_phy_ids[] = {
-	{
-		.compatible = "ti,tcan1042",
-		.data = &tcan1042_drvdata
-	},
-	{
-		.compatible = "ti,tcan1043",
-		.data = &tcan1043_drvdata
-	},
-	{
-		.compatible = "nxp,tja1048",
-		.data = &tja1048_drvdata
-	},
-	{
-		.compatible = "nxp,tja1051",
-		.data = &tja1051_drvdata
-	},
-	{
-		.compatible = "nxp,tja1057",
-		.data = &tja1057_drvdata
-	},
-	{
-		.compatible = "nxp,tjr1443",
-		.data = &tcan1043_drvdata
-	},
-	{ }
-};
-MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
-
 /* Temporary wrapper until the multiplexer subsystem supports optional muxes */
 static inline struct mux_state *
 devm_mux_state_get_optional(struct device *dev, const char *mux_name)
@@ -239,6 +210,35 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
+static const struct of_device_id can_transceiver_phy_ids[] = {
+	{
+		.compatible = "ti,tcan1042",
+		.data = &tcan1042_drvdata
+	},
+	{
+		.compatible = "ti,tcan1043",
+		.data = &tcan1043_drvdata
+	},
+	{
+		.compatible = "nxp,tja1048",
+		.data = &tja1048_drvdata
+	},
+	{
+		.compatible = "nxp,tja1051",
+		.data = &tja1051_drvdata
+	},
+	{
+		.compatible = "nxp,tja1057",
+		.data = &tja1057_drvdata
+	},
+	{
+		.compatible = "nxp,tjr1443",
+		.data = &tcan1043_drvdata
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
+
 static struct platform_driver can_transceiver_phy_driver = {
 	.probe = can_transceiver_phy_probe,
 	.driver = {
@@ -246,7 +246,6 @@ static struct platform_driver can_transceiver_phy_driver = {
 		.of_match_table = can_transceiver_phy_ids,
 	},
 };
-
 module_platform_driver(can_transceiver_phy_driver);
 
 MODULE_AUTHOR("Faiz Abbas <faiz_abbas@ti.com>");
-- 
2.50.1


