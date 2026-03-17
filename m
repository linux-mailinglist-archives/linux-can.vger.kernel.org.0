Return-Path: <linux-can+bounces-7097-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG1DGOa5uWnJMQIAu9opvQ
	(envelope-from <linux-can+bounces-7097-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 21:30:30 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B68BE2B2488
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 21:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE51330484C5
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 20:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF771389E05;
	Tue, 17 Mar 2026 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kchYytr8"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC92386C18;
	Tue, 17 Mar 2026 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773779426; cv=none; b=bpBGgWPdU99QUrQv2BsE86WcsYLHX2SsyDkbAyVqqkbaGVOFHsAoibwXGZL9O5wlaXVPBdc5bta1CmecWU2Q0OAZ5wqsh/B7jo3/PVHve1r9kDoRZJPdkbts+PilPxbgOSBBuhV8iaB0swZoFUSnCL2rqnxnbTIFD/r9d7UGSJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773779426; c=relaxed/simple;
	bh=1oTSEU4Uqt28G1kfDw6s8yAthnq4oOe8zjR0wi9b7S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyLmhoW46cd7cInAVJ4vfiZHJLEsAedZZi3m0tagxGDq6zlPJ4HKz3vPT8BZGp5hM8xSByyYNACm5T/7LKou+heMMdWMRpNz1K+QgpKmsOLxR3t/nslI4ARwZQ1DTOAjBlGxGmwVxcbTmvzZ0RRjcvHau7BAvpmhsu7IvkF6RFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kchYytr8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773779424; x=1805315424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1oTSEU4Uqt28G1kfDw6s8yAthnq4oOe8zjR0wi9b7S4=;
  b=kchYytr8RMh2Hr09+v5/9g/V9OYTCglmO5P8j6V+VsRoi6ENQV3LKRV7
   dXmnn8TXHzNkB8Vqke2iX51c0U77zPeeSW03fGKtw6DaPqm7IvKsyVLv8
   TrzKU9QljtWjafZHbGzsXvQCL5Iq1WxCIFLknBFWETxec65+1Nz6Z8KpP
   VRS2g9G5P5yC8c1lWWLSubNlT/IaKn7qnEXB9TpuDYleYQe7j7y2b1YR/
   mfY8JWGeATZ2dDfPXktLoO6Kfs7zTKnK/xkcNnOUon3UAZXniq/1rflcD
   2ut3ihyLUo6rO0DR6maE2Woj8yk067ODKPyJUg3H0k/0LCP2gs7//5fa5
   g==;
X-CSE-ConnectionGUID: e/Ng91PHS42iq5CzY4y8ug==
X-CSE-MsgGUID: eELJEE3RRwWZ0u21LVnriA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="77433957"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="77433957"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 13:30:24 -0700
X-CSE-ConnectionGUID: WrrQjR7JQ5KV8yJfGSa2fw==
X-CSE-MsgGUID: US82iz2RSRGV6bD0XvMUxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="222434439"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 17 Mar 2026 13:30:22 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 11D759D; Tue, 17 Mar 2026 21:30:20 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/4] phy: phy-can-transceiver: Drop unused include
Date: Tue, 17 Mar 2026 21:27:30 +0100
Message-ID: <20260317203001.2108568-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
References: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7097-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:url,intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: B68BE2B2488
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This file does not use the symbols from the legacy
<linux/gpio.h> header, so let's drop it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/phy-can-transceiver.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 21b0406d1a09..8e250039c183 100644
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


