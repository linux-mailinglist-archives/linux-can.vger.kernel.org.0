Return-Path: <linux-can+bounces-7624-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFpEHlX1BGoTQwIAu9opvQ
	(envelope-from <linux-can+bounces-7624-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 00:04:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BA653B3A6
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 00:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C57E33010230
	for <lists+linux-can@lfdr.de>; Wed, 13 May 2026 22:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7183CB91F;
	Wed, 13 May 2026 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkFsOga3"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7BF3CAE84;
	Wed, 13 May 2026 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709827; cv=none; b=s9qw9RvJC+W15sUtc3eSeztwtHkeXo359eJVfueTLjdIe2Xm7fY+vk73aIyp0GV8xjPsW8eEeTCtxIymRs7rapcnJIivVMsMyOHCTuQ5C9YO/udJ+jy4/x3el4qGk5mFT3HZvvojOrwr11ZcOrZtNSmWQVKtBpbf8gLllIR3W/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709827; c=relaxed/simple;
	bh=gy1uI67ch6VNJy85J226jiXi1gtzpJYr85LZJvbDvLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=to5mTVzJ5I5JwEq3QYmLk+X2Q7MmO0u3WB59TDftPLL9ipUEFy8ma3tWKEr3kz5WHLW/rUImqwfW0Bs+Y9G7RkBIoyeDt7J5Mw0tNgcoJwWCdGvSeKUohUQsmPBhBBXd2Zrt3cJKohw4+uQb7eFSv7Tcq9SHl1iehlIO3TDb91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkFsOga3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778709827; x=1810245827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gy1uI67ch6VNJy85J226jiXi1gtzpJYr85LZJvbDvLQ=;
  b=lkFsOga3p4JJuM+MsV1CcxZLwRCcFOzbA7JmceSk+hgK1elRmIzxd6XP
   IZIdpW4MlI4/80ViQUxVmpS4Z8We2fQvm4Dg+LBIxuTHl05WepVAIYL5w
   Q1uEzIazVXgCihuizjETJqQtHXLDQ7kTyNmIzSg4teIfk8gxxkcHmlOdB
   PZiFUPxnqAY/zPvxK2D4slaINB/Sd9UT5qR4zBWXbdYbPkNqhI7Gi6Icw
   xhtcHYGrH7baZ5C286JjJ97+o1OBVWKijxYfqNwX29nfJkj8G5sXZ9vxB
   F7JP8NG+BKLymokDbUMsZjqPC3CzbLlhC1z9I2TSYlrdE/O3JZXZd9BrG
   w==;
X-CSE-ConnectionGUID: yHKcZ99URHGUZq9u7OWpwA==
X-CSE-MsgGUID: rZq413TsQG6SbsmZKfsC9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90749933"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="90749933"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 15:03:46 -0700
X-CSE-ConnectionGUID: 7kTdIxVUSbqu72h617A84Q==
X-CSE-MsgGUID: fRbaHHhgRzmHjPYNUkV/Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="237224945"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 13 May 2026 15:03:43 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id A93ABA1; Thu, 14 May 2026 00:03:38 +0200 (CEST)
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
Subject: [PATCH v5 6/6] phy: phy-can-transceiver: Drop unused include
Date: Thu, 14 May 2026 00:01:31 +0200
Message-ID: <20260513220336.369628-7-andriy.shevchenko@linux.intel.com>
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
X-Rspamd-Queue-Id: 81BA653B3A6
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
	TAGGED_FROM(0.00)[bounces-7624-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:url,linux.intel.com:mid,intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This file does not use the symbols from the legacy
<linux/gpio.h> header, so let's drop it.

Reviewed-by: Josua Mayer <josua@solid-run.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/phy-can-transceiver.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 30330499585b..75dc49e75ca0 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -5,12 +5,11 @@
  * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com
  *
  */
+#include <linux/gpio/consumer.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/module.h>
-#include <linux/gpio.h>
-#include <linux/gpio/consumer.h>
 #include <linux/mux/consumer.h>
 
 struct can_transceiver_data {
-- 
2.50.1


