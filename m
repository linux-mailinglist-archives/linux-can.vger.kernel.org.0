Return-Path: <linux-can+bounces-6601-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uD6xKrNyl2kdywIAu9opvQ
	(envelope-from <linux-can+bounces-6601-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 21:29:39 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 535C016251B
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 21:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 280E03035240
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 20:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2788318EFF;
	Thu, 19 Feb 2026 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZP/N5Lhl"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCFC311C2D;
	Thu, 19 Feb 2026 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771532957; cv=none; b=kcOVlktBFOCmmT1r/RNj80QGUQb4xW2OGHxg4m67D74SzB4B8oHuAN7hw90z09kKI8kgUYP03HDnD6QC9A1F+N0Q/wr+CLta5RkgY5b4FLo7a9RXCLqS4QpDMQ8HQT8JyRUcIHvUW6X9bSj5g3CTDJrJlEOuDbV97JkGaUyvHww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771532957; c=relaxed/simple;
	bh=UGGpnkOvYPbrXSd8q4HPF1cTvjy9favFkK4diENBEpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OnEvQ9C2xlps2a1DUAFlfug0liKlDFWDA2SAA1tVsuXuffSGzuA06fK0LP+jIYFBU5iHyNz6Kya2uTfKlbJiAu22XSD1vXaSMy7wlTmB7ZFYt1Ur6zb8V2oYZWNnOoUecyXiDd+x/pscxnCim1SlHB0FbwqCjmUs5XFoepV3LIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZP/N5Lhl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771532956; x=1803068956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UGGpnkOvYPbrXSd8q4HPF1cTvjy9favFkK4diENBEpc=;
  b=ZP/N5LhlVQ/9nPQZUBIU8y3h9WL5SQcPRMSpsNa1hX+R5Wnke0euZoAt
   YybMiAZd134c0l/OIX9UeFKKal7DTWmQ5l0B2KrhBsVjBEn7G9PPr4xVP
   UK/dqJAHxHO9zsuNoC/N9+DNXSfbcNQSc03YlXdtP+vgN4hUo0/oUzuiD
   9r2kmrKNWa/5YAOk0kkpuqlRxWNRznvFNy95h/sm1g4HwNIfW49Dh7aqv
   5k/B7xFDk1q9PLs82fp8qeUAIATZgxXy5iQI1TB3mBpqT8GAAjucZEuBE
   UnTmSRsmDfoj1T+Sl2oDXwIeCp1hLcD+oxUR/LUn7ihHK/P1iDI1ONbDN
   g==;
X-CSE-ConnectionGUID: mfdBqgS3QOibZ/BBrYk6bw==
X-CSE-MsgGUID: 1xt+YsnCSyOef/6FsEnoyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72532332"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="72532332"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 12:29:14 -0800
X-CSE-ConnectionGUID: 72B2VFTLROqp7e9PeEtwgA==
X-CSE-MsgGUID: VMf519aCQ8yJ4M8xDzEMcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="219183207"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 19 Feb 2026 12:29:13 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id F046B95; Thu, 19 Feb 2026 21:29:11 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/4] phy: phy-can-transceiver: Ad-hoc cleanups and refactoring
Date: Thu, 19 Feb 2026 21:26:18 +0100
Message-ID: <20260219202910.2304440-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
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
	TAGGED_FROM(0.00)[bounces-6601-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 535C016251B
X-Rspamd-Action: no action

The driver does two things that need to be addressed:
- includes subject to remove gpio.h
- checks for error code from device property APIs when it can be done in
  a robust way

This series addresses the above and adds a couple of additional refactoring.

Andy Shevchenko (4):
  phy: phy-can-transceiver: Convert to use device property API
  phy: phy-can-transceiver: Move OF ID table closer to their user
  phy: phy-can-transceiver: Don't check for specific errors when parsing
    properties
  phy: phy-can-transceiver: Drop unused include

 drivers/phy/phy-can-transceiver.c | 86 ++++++++++++++++---------------
 1 file changed, 45 insertions(+), 41 deletions(-)

-- 
2.50.1


