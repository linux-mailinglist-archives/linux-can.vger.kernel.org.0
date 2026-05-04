Return-Path: <linux-can+bounces-7472-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNDvOmBE+Gn9rwIAu9opvQ
	(envelope-from <linux-can+bounces-7472-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 09:01:52 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8817C4B91FD
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 09:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B8E33005AFB
	for <lists+linux-can@lfdr.de>; Mon,  4 May 2026 07:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2EC2773FF;
	Mon,  4 May 2026 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1zzyOfN"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4882D883F;
	Mon,  4 May 2026 07:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777878064; cv=none; b=c0gdbHBf10VELvDapznTEJewsG0UpbJhHTucx6X8Xuu17lMSISUrWJb/AzUB1DhqMA54mEtJj+6dBUDmdDZi469Woca4A6Ac4cGlNfXBwjcnr7ohyVU25VDOzFE9/y+tS5JhmvVCSlURNV+3XjvjLyhr29k8pxECSW+vKNSTUls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777878064; c=relaxed/simple;
	bh=6a+NuN4eKBbINrUS/oYZuMVtQvHS3uko34ju1kyMzEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PkfP0gDUKSGE/cadXMrJWr0ZxdkalalEiipw4AVY73hmPKBOAqxYM9ByqgdWBi8MlXEMvvuQtgNebopOHrqaNvKnL1YAWo7egkr8BY9NmYpPdDe2vzw0mW007BLx8o9vreOVcAk1CzFm8o7FdNDW/RZx3cUPPP9av4dNK7l1YGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1zzyOfN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777878063; x=1809414063;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6a+NuN4eKBbINrUS/oYZuMVtQvHS3uko34ju1kyMzEg=;
  b=O1zzyOfNLP1VLNyxeNvp+Y8QtJ9tKUqrncvMUWX7+2++YSn43tbMJ+LC
   J3tDd4hKL+cNqH7ZvfPsed15Y3y0EF13X493ruVO6WvqfNvEVikftnM4t
   b8CmiFFHU7w0WtOqiLkJaeJ51jK0NTEW0FkuYU+ZRPgWDW2YfAw49Jmfb
   Wh0Tp7jtYLzZZrA3Uaw6Hb5PvR6kM6dnV1uiR86/wpULvWLPbVB5p+mGj
   Zhbg4Um60H5+aX/e5WcN8PUxZWTIkjMC8Pb9hr2hD+VJE8v/bgzkPhiTJ
   888yVd94IwGyMZjptuDqsn9GHKHO9ypl/KAYnerHc2CGhWUjIe1yOO/XW
   Q==;
X-CSE-ConnectionGUID: ahmnUsrcQoS2BnkOfdKNiA==
X-CSE-MsgGUID: dIYTLOLTRg+XJ4o23nGrcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="82344144"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="82344144"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:01:02 -0700
X-CSE-ConnectionGUID: 5F5rVd/PT+yZ4vvXdx470g==
X-CSE-MsgGUID: Bw3EQpWXTlqPbZWoCeDl0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="240422852"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 04 May 2026 00:00:59 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 3157F98; Mon, 04 May 2026 09:00:58 +0200 (CEST)
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
Subject: [PATCH v3 0/4] phy: phy-can-transceiver: Ad-hoc cleanups and refactoring
Date: Mon,  4 May 2026 08:58:51 +0200
Message-ID: <20260504070054.29508-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8817C4B91FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7472-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

The driver does two things that need to be addressed:
- includes subject to remove gpio.h
- checks for error code from device property APIs when it can be done in
  a robust way

This series addresses the above and adds a couple of additional refactoring.

Changelog v3:
- fixed commit message in patch 1 (Josua)
- dropped stray change (Vinod)
- collected tags (Josua)

v2: 20260317203001.2108568-1-andriy.shevchenko@linux.intel.com

Changelog v2:
- rebased on top of the latest changes in the driver
- Cc'ed to Ulf and Josua due to above
- elaborated dropping of_node parameter (Vladimir)

v1: 20260219202910.2304440-1-andriy.shevchenko@linux.intel.com

Andy Shevchenko (4):
  phy: phy-can-transceiver: use device_get_match_data()
  phy: phy-can-transceiver: Move OF ID table closer to their user
  phy: phy-can-transceiver: Don't check for specific errors when parsing
    properties
  phy: phy-can-transceiver: Drop unused include

 drivers/phy/phy-can-transceiver.c | 83 ++++++++++++++++---------------
 1 file changed, 44 insertions(+), 39 deletions(-)

-- 
2.50.1


