Return-Path: <linux-can+bounces-7619-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ4HH0T1BGoTQwIAu9opvQ
	(envelope-from <linux-can+bounces-7619-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 00:03:48 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 131E053B397
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 00:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCAB1302D117
	for <lists+linux-can@lfdr.de>; Wed, 13 May 2026 22:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3970C3C9881;
	Wed, 13 May 2026 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QChkLC57"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465C3C3453;
	Wed, 13 May 2026 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709824; cv=none; b=odgK4HWt8l93an5hxCQX8CctV6sbDdQU+PSb+E/4tJCp2Uy+dktMoopuxgp1/IdmQPkU79rMxczRbWOgcTqA54sKGzUtCwT9/0upmeG4ZwSR0cSN4dBVkxYag7NJcIzb9xXs2Tmm0ggUCLBkYsjOOKqmDvLwzi1NcW7zYR/kpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709824; c=relaxed/simple;
	bh=UyFfe1RpnocjlGDV7b3omhVXqWEqHJ/3s895StkmShs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDvhVnwU/9WJIMhQyY3JfGJ3tg9fJRQaOOFFA6ukaPh2Z5Nbu8KXMk8HW6zbu4Go+4Qtao3WzPFDTMbP+Hy0Fm5dBkHuzEuC9psz4l7KUm5iQ/ON5e9hK5VwnxyMOuad4bQyY8dlUU4xbxxxO+yGRzaTtahNWSHZ9ABCSuVxiBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QChkLC57; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778709823; x=1810245823;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UyFfe1RpnocjlGDV7b3omhVXqWEqHJ/3s895StkmShs=;
  b=QChkLC577JRjMmw00s70VraIvy8ovEfglwHfHUpEpRbBvxYx0GZj8RIv
   DrUkg1KvCErPH72cAPZIXB3kGBXX4GWpj7X0UKHpEbokmXJ53m7aRw0g6
   pgBoeHx0hJB+/+2YWE8hYIJ20tjweqtTmW+MtAlSgK1nTNZRfEZ1Nj9sq
   yxPPiJeNYH0GfxLtfgS+WbmCe6xT4j8WejUXRr90b96ELopC1wdlri0B8
   TnsADCpybUPhBgIPd8L6D1069zbRKtRw+KsPnurXDfme6jM8beKHA7egO
   edi3r9VMPH7iv/cKCTK5zA1R53T0EN4oq5jm+4LPTOpn1FRQK8Kdr69Ri
   A==;
X-CSE-ConnectionGUID: 2teHOTW/SNWQmD7LLj0XSQ==
X-CSE-MsgGUID: 9F+0s6JAT9+3s3+Ha9NwuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90749906"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="90749906"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 15:03:43 -0700
X-CSE-ConnectionGUID: Ec2n8dmNQLCfy8vRg8j8Lg==
X-CSE-MsgGUID: DwaCqn07Rdu2eAKl01cMTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="237224937"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 13 May 2026 15:03:40 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 9104995; Thu, 14 May 2026 00:03:38 +0200 (CEST)
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
Subject: [PATCH v5 0/6] phy: phy-can-transceiver: Ad-hoc cleanups and refactoring
Date: Thu, 14 May 2026 00:01:25 +0200
Message-ID: <20260513220336.369628-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 131E053B397
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
	TAGGED_FROM(0.00)[bounces-7619-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action


The driver does two things that need to be addressed:
- includes subject to remove gpio.h
- checks for error code from device property APIs when it can be done in
  a robust way

This series addresses the above and adds a couple of additional refactoring.

On top of that it fixes potential NULL pointer dereference when driver_override
is in use.

Changelog v5:
- fixed typo due to rebasing of patch 2 (Sashiko)
- added patch 5 to slightly improve maintainability

v4: 20260512130552.272476-1-andriy.shevchenko@linux.intel.com

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

*** BLURB HERE ***

Andy Shevchenko (6):
  phy: phy-can-transceiver: Check driver match and driver data against
    NULL
  phy: phy-can-transceiver: use device_get_match_data()
  phy: phy-can-transceiver: Move OF ID table closer to their user
  phy: phy-can-transceiver: Don't check for specific errors when parsing
    properties
  phy: phy-can-transceiver: Decouple assignment and definition in probe
  phy: phy-can-transceiver: Drop unused include

 drivers/phy/phy-can-transceiver.c | 93 +++++++++++++++++--------------
 1 file changed, 52 insertions(+), 41 deletions(-)

-- 
2.50.1


