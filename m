Return-Path: <linux-can+bounces-7622-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCHwKWj1BGoTQwIAu9opvQ
	(envelope-from <linux-can+bounces-7622-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 00:04:24 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F4253B3C6
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 00:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62382304C97B
	for <lists+linux-can@lfdr.de>; Wed, 13 May 2026 22:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B2C3CAA5E;
	Wed, 13 May 2026 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqY5CiWD"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA33CA4B2;
	Wed, 13 May 2026 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709825; cv=none; b=nL+sjgmLOsqAjiArhfuW+gSvccQKfORO/mKp/ksRKULr2fyjOkYtSwdoI3jX3oOOHmjbI3oknDIDOql/SEDmrscDujN/1YDL8h3XKHBlIJv5pErusXwnNXppB3ObzOWQu8ob9GJxOZB059WzEmXniQGBDT7x27VfxSJXLQHZqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709825; c=relaxed/simple;
	bh=Te4q2A4qL3QmWciWTToqRtfGDNdEIh4FL0tn9GrtLCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mab66VVpC5L/v9OupRpaYKy+TI3u9iY6QO6kwpWCtEOk2t4Ad2ddUYgEQLJ1e6+21klQj/j1GPX+iQ0kvzM64uOgBIgHPV8oNphUxU5cnDlyFdy0xt5dTDh4V7PUWh/VKHsUbYuVh7SfMZouf3UMMMN8Gvnw6BJaqPq4uYf1rp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqY5CiWD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778709825; x=1810245825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Te4q2A4qL3QmWciWTToqRtfGDNdEIh4FL0tn9GrtLCY=;
  b=AqY5CiWDnh5JPVA0qbfePOBl2kvIQDRRESpl31uC7K8cR+pOMRfPokhB
   bxMRpREL7MRofXdHafzblIZsDxISytUmDkd7E+ng5oy2tbWRzZKYbinjC
   TMpH8vSkGT59gz0KVubiQPyqZEbRE7waBjVLgJDVIeeqNlBD7+BOqkvOV
   0KmPP5zkJmbkhygAZ8ChZDjJx+kZiRa4JZ0Q+O+d1WljHsHi36TjTz+y3
   lAN42XENINQP8/78cKzJ/e+4Mv3beqQe55H4z3o3V1PbRT9gV4WwpuO/a
   Wzu07oX/tF5+T5wppgZTO16NUDjom8/baXtLUWMkIxt81dlGHYOaVnVJO
   Q==;
X-CSE-ConnectionGUID: UP7euYhMT3GSOyUKmGl1kg==
X-CSE-MsgGUID: MNZLKGoNRxaeEL77SLQXzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90749914"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="90749914"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 15:03:43 -0700
X-CSE-ConnectionGUID: vCJ8FGsJSQ2F/cC3YTt4QQ==
X-CSE-MsgGUID: odh5FsSKSlyTOSCOLjiWdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="237224939"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 13 May 2026 15:03:40 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 9C4989B; Thu, 14 May 2026 00:03:38 +0200 (CEST)
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
Subject: [PATCH v5 3/6] phy: phy-can-transceiver: Move OF ID table closer to their user
Date: Thu, 14 May 2026 00:01:28 +0200
Message-ID: <20260513220336.369628-4-andriy.shevchenko@linux.intel.com>
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
X-Rspamd-Queue-Id: 40F4253B3C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7622-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

There is no code that uses ID table directly, except the
struct device_driver at the end of the file. Hence, move
table closer to its user. It's always possible to access
them via a pointer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/phy-can-transceiver.c | 58 +++++++++++++++----------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 37b706d841ff..5c9698f77c7d 100644
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
 static struct phy *can_transceiver_phy_xlate(struct device *dev,
 					     const struct of_phandle_args *args)
 {
@@ -232,6 +203,35 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
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
-- 
2.50.1


