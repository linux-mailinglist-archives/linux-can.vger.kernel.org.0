Return-Path: <linux-can+bounces-7603-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE/MFAIpA2qw1AEAu9opvQ
	(envelope-from <linux-can+bounces-7603-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 15:20:02 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F07F852101F
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 15:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F22863086B1F
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 13:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4706394E80;
	Tue, 12 May 2026 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5m7iBrC"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4576A37206E;
	Tue, 12 May 2026 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591169; cv=none; b=fDHyz9JXbPloIpBxea3kJ9WwyOxYnyWy8Xpc80R0Z4RI6nHdQOgfo6o36/S2IYHMv6O9e9KYdMZgmlXsfISXEYhGM1KEqVHQZy3iQ5LEe5hox3Q1LuZ4dIVZIgkK6GrexXlhX2DewnYOYeqEoT1aVVxV773+lVwuwTt4sRG5L5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591169; c=relaxed/simple;
	bh=qcMzXO16kkW22ELXgXwx0wx3D5W96Xm2XbyK4K7bWS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=msHXue8bjMHOy+bk0QcaJ1CNR6p9W02/vPE4CyjIlIJjy9klyqKb0qJ9StaV9fDXcd/lXN/FrbQ3vc/Mw3Wp8Wn/yuXeAPInQ7iudA8WF05gMdR3JS0ofw2LH6ahyXP9MglC/LJab4NlQOPm3F2XAKuu4ti4viKADVnaxe4ZaUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5m7iBrC; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778591169; x=1810127169;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qcMzXO16kkW22ELXgXwx0wx3D5W96Xm2XbyK4K7bWS4=;
  b=Q5m7iBrCZptXxSrHKT9crEYv2Ds2wFjkTYM+r3BLTdx6rGV/peoAfEkt
   a8+giBm/IXA4O/yYjfXrV7gSvjxOl936eQbc6OQgOEm8NNh9Tmw33I/A9
   wC2ItL/3w9e9kN1bwidACof7ySyuNqpJ9KYgRrHf+mEmvnqZ+ZiOD0eMz
   xB6TZeAy/itUthrTirx2Rqn37aR0OLxkQKtRul2J3aMte9zIoyAhMECNR
   h3xsiEA14aiMs0oLj9koiUvTH93YlMKQpjGaFqiwePDeTrknKR6mFDbpw
   tsDvhYniu0gS8feOfy771Me13pn6JlRnboCzVzA3Dcsk0nzWT7jicPd3U
   Q==;
X-CSE-ConnectionGUID: RnCznnnPQ5Ouu7rzz+sJnA==
X-CSE-MsgGUID: rIECL4NjRNW5+PUS+MzZNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90600376"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="90600376"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:06:00 -0700
X-CSE-ConnectionGUID: UCybhSIKTYCXCfDz82Ye4w==
X-CSE-MsgGUID: eesEYDwqSzGxCb1rbjDvlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233294185"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 12 May 2026 06:05:56 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6DA4298; Tue, 12 May 2026 15:05:55 +0200 (CEST)
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
Subject: [PATCH v4 0/5] phy: phy-can-transceiver: Ad-hoc cleanups and refactoring
Date: Tue, 12 May 2026 15:01:48 +0200
Message-ID: <20260512130552.272476-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F07F852101F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7603-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action


The driver does two things that need to be addressed:
- includes subject to remove gpio.h
- checks for error code from device property APIs when it can be done in
  a robust way

This series addresses the above and adds a couple of additional refactoring.

On top of that it fixes potential NULL pointer dereference when driver_override
is in use.

Changelog v4:
- prepended the series with match and driver data check (Sashiko, Vinod)
- made the max_bitrate==0 warning only when property is present (Sashiko, Vinod)
- rebased the rest accordingly

v3: 20260504070054.29508-1-andriy.shevchenko@linux.intel.com

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

Andy Shevchenko (5):
  phy: phy-can-transceiver: Check driver match and driver data against
    NULL
  phy: phy-can-transceiver: use device_get_match_data()
  phy: phy-can-transceiver: Move OF ID table closer to their user
  phy: phy-can-transceiver: Don't check for specific errors when parsing
    properties
  phy: phy-can-transceiver: Drop unused include

 drivers/phy/phy-can-transceiver.c | 89 +++++++++++++++++--------------
 1 file changed, 49 insertions(+), 40 deletions(-)

-- 
2.50.1


