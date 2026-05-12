Return-Path: <linux-can+bounces-7606-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBYOO5gpA2r/1AEAu9opvQ
	(envelope-from <linux-can+bounces-7606-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 15:22:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A97521108
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 15:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFA8430C4FDD
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 13:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724123A719A;
	Tue, 12 May 2026 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yi6jTV6Q"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF483A2E15;
	Tue, 12 May 2026 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591203; cv=none; b=l86kG6aXy7zV9yk1t9iKr2NMf1aEKstZO0lQihRfZdp6AWgO4kwAC9F6DIKBsU7Wwe29/4xhBqOyaIllLgfBZh5iVP4ZrueZfkDwuvG4n0fx1PXrfTiag0zyTUzMcVvIaROL/qvImdNbq1xb3inlrfjhu1Ex1wy3bVTbbKcr6qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591203; c=relaxed/simple;
	bh=znNkGxCWUoP43q4FZmHtbfCbpkEWJzJh8FmA72szqWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5dXssLQYUqr8qE0UF8byEiYBL2PXJybUBE8VQ8dhn2KfbesSaVgL1RW2FtY/FNa9ZHhmAx9VNbAqo35iz4txjeYkXvMTmeDoDhsrZqZibSx2AGRPRs9gsjrZ9+cYgfAd+OhPZpR8rW9ZDWvmfzIlFXn+kmXrexQ5bxifNsnhDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yi6jTV6Q; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778591202; x=1810127202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=znNkGxCWUoP43q4FZmHtbfCbpkEWJzJh8FmA72szqWY=;
  b=Yi6jTV6Q8um2FJFcKwoXpw9mfErBUJroeKjyTRATKDDWQ/uAbFQVr+19
   QrjaUSgjrX7NcRuw4eCOtDJaxSbFOzMVg64b4dsTCzKTuWnc35x0mAUUR
   aUBA2ZaAARF6yK9PeM/FbBlxPPKPwbkcYDhkRZSxjRcbaD+dz/gJmGVSk
   rJFQ/AP2Ui0iGtvBpTWVJxEfeUjvsA5eHda4QWvcaYGkUsV8aPIQYA9rb
   3yzT/hcBr/YOJ+nAnBSl/1hWT1SvZi4fKsOLVeW/z/ndYtMeWR9eX88y2
   EuvxzN0+Fgpd7VmPRoemlN05IP8Zdes2rY0K5AD9d+qmq01NvEyr6XFaQ
   w==;
X-CSE-ConnectionGUID: aYGi4YN0SMuAiR/OtExwDA==
X-CSE-MsgGUID: L7IZ1+8CQCuzaL4dIwb2FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="67026599"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="67026599"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:06:38 -0700
X-CSE-ConnectionGUID: xg/iWjAPSE+p7scyEFDOnA==
X-CSE-MsgGUID: bP+pSJv1QK6ixYpICKEBqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="235099026"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:06:34 -0700
Date: Tue, 12 May 2026 16:06:31 +0300
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
Message-ID: <agMl17o5Ti4eSM4P@ashevche-desk.local>
References: <20260504070054.29508-1-andriy.shevchenko@linux.intel.com>
 <agBjOmnpKuZoDfWG@vaman>
 <agB_aj_2hzF3ON2h@ashevche-desk.local>
 <agIBJsOl4Trk4_KN@vaman>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agIBJsOl4Trk4_KN@vaman>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: E4A97521108
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7606-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,ashevche-desk.local:mid,sashiko.dev:url]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 09:47:42PM +0530, Vinod Koul wrote:
> On 10-05-26, 15:51, Andy Shevchenko wrote:
> > On Sun, May 10, 2026 at 04:21:38PM +0530, Vinod Koul wrote:
> > > On 04-05-26, 08:58, Andy Shevchenko wrote:
> > > > The driver does two things that need to be addressed:
> > > > - includes subject to remove gpio.h
> > > > - checks for error code from device property APIs when it can be done in
> > > >   a robust way
> > > > 
> > > > This series addresses the above and adds a couple of additional refactoring.
> > > 
> > > Sashiko flagged some issues, some of them not introduced by this, can
> > > you please check this:
> > > 
> > > https://sashiko.dev/#/patchset/20260504070054.29508-1-andriy.shevchenko%40linux.intel.com
> > 
> > "Could this result in a null pointer dereference if device_get_match_data()
> > returns null?"
> > Yes, it sounds legit but not introduced here.
> > 
> > "In the original code, the warning was suppressed when the property was missing
> > because err evaluated to -EINVAL. Now, if the property is absent, max_bitrate
> > is explicitly set to 0 in the else block, which then unconditionally triggers
> > this warning."
> > True, but I don't know which is better here, I consider that it's
> > good to inform user about default being used as a fallback. I can change
> > this back to the original logic. What do you prefer?
> > 
> > The third one is the repetition of the first one (see above).
> > 
> > TL;DR: The only one legitimated question is about a (new old) warning.
> 
> Yeah would be great if we could fix these as well please

I just sent a v4:
20260512130552.272476-1-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko



