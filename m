Return-Path: <linux-can+bounces-7096-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFl1NRW6uWnJMQIAu9opvQ
	(envelope-from <linux-can+bounces-7096-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 21:31:17 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4781A2B24A1
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 21:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70B613053661
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 20:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6FE38944B;
	Tue, 17 Mar 2026 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akmlEYUq"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A3638756E;
	Tue, 17 Mar 2026 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773779425; cv=none; b=YEKcDyxCjePlITdkvw/Zfiyw+mtMmNXAaUblO47MRNqNU9Y02J4jxiX/OGeGfMa3SlPdsACuMyOConYw7NOIDaNQA4MggWG5Hk+q/fLcPFCFbiOotI5BMuX1MpGwWlqy6lZPBsEReyvVoFsmSy2VxMvHSWY5Y6WelnR8NJRNm1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773779425; c=relaxed/simple;
	bh=xLeLleax5TCQNPTg61bOs9yT2cCjVjiPOVMyP9cMJmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUl7DfD7gadGtHG+RYfG6rHLGKUEK8ofnTrgPC0+DaayIuJvi6TNuoDLOTIkDDAnuiKExE3bEiux/rTsM6Oh7huu0HYTHc9zZmDKEZqdSW0C2EI8F/rpk/85bBBo7vgc0MfLo0/0lae0VBTj5E/QdH8sRnNnjfzcWVBUvmfIUlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akmlEYUq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773779424; x=1805315424;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xLeLleax5TCQNPTg61bOs9yT2cCjVjiPOVMyP9cMJmI=;
  b=akmlEYUq6IBkG5GTilsAf0eNegE/GHv0BBzVZibGjqwgejnt1XFO8UWx
   uaE/e2TcAoXz9A8ZQC76nhkpkIQgqeKW0I/bghKT+iQ+ExgCtEQiZheOi
   qebr57Ml4fT4uDL7xvcI3LANrDfZbQ726QbHh/u/9y/gltolNUEvq6AGQ
   4QSCHj9JJ3qRg/2P/Yn3kHDuMwQrZYXpQM/7k/wFq1NKskHlVccptq0Dp
   WSf0zOk5745KPc3osCCPe2+qDe9SbvNcSKKK5eGVl7uLvmeL8B/LEJS91
   /3Rs4izg2DeJrnz6CmepryyKUsGygYxNMLPdt09PNEKTB/qCagaUjeyaJ
   A==;
X-CSE-ConnectionGUID: AmiqpA98S5qJPyzw6KaiLg==
X-CSE-MsgGUID: yFsMzfUWRXO3r3c36e1s9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85456292"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="85456292"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 13:30:24 -0700
X-CSE-ConnectionGUID: gPm3KkzaQvu1v37aSgCSfA==
X-CSE-MsgGUID: xGI3cHaZTz+VNUXaZdtx9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="226527805"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 17 Mar 2026 13:30:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0246295; Tue, 17 Mar 2026 21:30:19 +0100 (CET)
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
Subject: [PATCH v2 0/4] phy: phy-can-transceiver: Ad-hoc cleanups and refactoring
Date: Tue, 17 Mar 2026 21:27:26 +0100
Message-ID: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7096-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4781A2B24A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver does two things that need to be addressed:
- includes subject to remove gpio.h
- checks for error code from device property APIs when it can be done in
  a robust way

This series addresses the above and adds a couple of additional refactoring.

Changelog v2:
- rebased on top of the latest changes in the driver
- Cc'ed to Ulf and Josua due to above
- elaborated dropping of_node parameter (Vladimir)

v1: 20260219202910.2304440-1-andriy.shevchenko@linux.intel.com

Andy Shevchenko (4):
  phy: phy-can-transceiver: Convert to use device property API
  phy: phy-can-transceiver: Move OF ID table closer to their user
  phy: phy-can-transceiver: Don't check for specific errors when parsing
    properties
  phy: phy-can-transceiver: Drop unused include

 drivers/phy/phy-can-transceiver.c | 84 ++++++++++++++++---------------
 1 file changed, 44 insertions(+), 40 deletions(-)

-- 
2.50.1


