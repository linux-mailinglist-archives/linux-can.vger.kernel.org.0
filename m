Return-Path: <linux-can+bounces-7585-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MDuHDyAAGo2JgEAu9opvQ
	(envelope-from <linux-can+bounces-7585-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 10 May 2026 14:55:24 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E24A450434B
	for <lists+linux-can@lfdr.de>; Sun, 10 May 2026 14:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E051300C82C
	for <lists+linux-can@lfdr.de>; Sun, 10 May 2026 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4856C3783C8;
	Sun, 10 May 2026 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EGN1L8ij"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E52E19DF62;
	Sun, 10 May 2026 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778417522; cv=none; b=VUiLo6h9w7S5+iMXycBVO25ZGt5ay5lmISUWe3yIVwrO6EYBYFZeD9X4uDQOYc6NYY+d2AG3VN3I8A6awxmP23b8aGWEKJWbh80/UAAuPbTc3DUgSpieRkJ7oS+oIGVTazLagWWnUnUnd6gqba1QepWmIDqinohOd7Edjn/ws5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778417522; c=relaxed/simple;
	bh=2DvbnoTQCS7Wsxem7vg1TUbb+5RuywPoURhAB4F046E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHTNY26A3t5IMZYjxKsPjUBcoLvG7eeie+Mqajdo7S3z1kiLcaYZLLthrh5/Q357gdwlSYQfuZv9KgaknFBrCGBnqki9w8xAiW11/07DgP49KJo9YupCt+rqh/y8GZHA5hTyGeTUa/sfMgFXYJm31FXMZ+4x6CDOuEQuH7MuJ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EGN1L8ij; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778417521; x=1809953521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2DvbnoTQCS7Wsxem7vg1TUbb+5RuywPoURhAB4F046E=;
  b=EGN1L8ijQz4nXCYevfuJkcvLQsmupHpiZUji6CBuhrwb9I4xITM4vc0j
   3BaI95LXZFuVcS8hhVzJI8O0ZHuRD1CgXhUyhJVilNHS7JFbpeZ//v9Ue
   /PA7cjPXutU8Cj1OwtiWH8+ToRD6KDTs9Myk2bm+Pp0Q0DSAtbehqMMEA
   5z30xPA0TX+myjR84Yv7uQ2gln/9HSGXI/zARHRHFv3U/+eVexBNtquaz
   9wIhC7xYj1PvjoECFdTOIkEvckq5RSXBpMZhFaa90svZn4LRDvMTatxr0
   iyjzHTSdDWzzW6qwpETqKYrC91ruP+fg+dAI8E18GRvVtfH0+7nHgzHAo
   w==;
X-CSE-ConnectionGUID: NvtG/YsHQN6O30CWvqXJnA==
X-CSE-MsgGUID: qjO6Tn7BSnWZbU/+aL0fXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="89632183"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="89632183"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 05:52:00 -0700
X-CSE-ConnectionGUID: 9984BpVGQIysUJuhcmIG/w==
X-CSE-MsgGUID: R1gWf7xvQjKEOatdPl2yzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="232738753"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 05:51:57 -0700
Date: Sun, 10 May 2026 15:51:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>, Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH v3 0/4] phy: phy-can-transceiver: Ad-hoc cleanups and
 refactoring
Message-ID: <agB_aj_2hzF3ON2h@ashevche-desk.local>
References: <20260504070054.29508-1-andriy.shevchenko@linux.intel.com>
 <agBjOmnpKuZoDfWG@vaman>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agBjOmnpKuZoDfWG@vaman>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: E24A450434B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7585-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 04:21:38PM +0530, Vinod Koul wrote:
> On 04-05-26, 08:58, Andy Shevchenko wrote:
> > The driver does two things that need to be addressed:
> > - includes subject to remove gpio.h
> > - checks for error code from device property APIs when it can be done in
> >   a robust way
> > 
> > This series addresses the above and adds a couple of additional refactoring.
> 
> Sashiko flagged some issues, some of them not introduced by this, can
> you please check this:
> 
> https://sashiko.dev/#/patchset/20260504070054.29508-1-andriy.shevchenko%40linux.intel.com

"Could this result in a null pointer dereference if device_get_match_data()
returns null?"
Yes, it sounds legit but not introduced here.

"In the original code, the warning was suppressed when the property was missing
because err evaluated to -EINVAL. Now, if the property is absent, max_bitrate
is explicitly set to 0 in the else block, which then unconditionally triggers
this warning."
True, but I don't know which is better here, I consider that it's
good to inform user about default being used as a fallback. I can change
this back to the original logic. What do you prefer?

The third one is the repetition of the first one (see above).

TL;DR: The only one legitimated question is about a (new old) warning.

-- 
With Best Regards,
Andy Shevchenko



