Return-Path: <linux-can+bounces-7410-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LckA+xl72kIBAEAu9opvQ
	(envelope-from <linux-can+bounces-7410-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 15:34:36 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A402F473826
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 15:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14AEE30071F3
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 13:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16453B961F;
	Mon, 27 Apr 2026 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUXA0xVf"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7436D1F192E;
	Mon, 27 Apr 2026 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296873; cv=none; b=Rz1ArLFaei8CFPkd81JNYgA1u1ulLxwsaAg0xyjVZD0JYCvJQW/Ckedl5OnqZ8jEBA5C83jS9s3uuByUStkgYgJyEajsfSme9lkvAqumaV9M7Do14kZ/rZfTt4fqv/QPQpVbyMRyTKwx3dC3ZbRbjO602IMV60C+DnMGnyK8ciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296873; c=relaxed/simple;
	bh=CxJ728BK4g6l5AEja2sNEowQIIAIo5d8EbB+gqZ212k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2A3uMegvDedjYOyGWKFgorc3M6tfYzrmm709YMH6Z6RqwYtl8VQJT2DMMLigDgR4L4dt02XEa7FE5xNNmfff/WbkH8t1n3MbkMwfGmI6oMDdzsAlKfAHmTE+haYa0Y31gw1avszhhsi846o4TuBTVbqBGj/uxTi9pF70UsyBdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUXA0xVf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777296872; x=1808832872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CxJ728BK4g6l5AEja2sNEowQIIAIo5d8EbB+gqZ212k=;
  b=hUXA0xVfOy7BiE+nfL+4ym/p4bNZy84C9f5pF7YPDky6rq8ESm2KsxgO
   E7CGbSA0NC45A6l3XvKL5rDVTvGQnCOyNohNj3zGwNVsnxIDmjUUSxPLB
   dP6HlKfc0fP9C/v8Lpaj73QwvcWJyq7Yg82OI2CBhs5UF5bYMyOgbCSD9
   WBIfxddWJPcbtfYCjgd0LM2099LhwCTpCUpK4kA5rVJxj2k++b3Xr/5WJ
   Zi/Z8yTETlU1ifMM9jl+L6yJe+y0DE5iTUDb0e/EDXmui3SUoOv8J/YJO
   u8k6VbWtvIZtnJYpSE96fw5yBryhlW563QzQmCSebeK87spwu8VTJolWn
   w==;
X-CSE-ConnectionGUID: 7/Y+8j0fT62qYI+JenSqqw==
X-CSE-MsgGUID: PJ24B5vwQ6WHfems3v3viQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="100840561"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="100840561"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 06:34:31 -0700
X-CSE-ConnectionGUID: LslyeJx8TyeRyzT+Q0/pcA==
X-CSE-MsgGUID: 11RsWyCPTqWg7oiZUeZOsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="271771646"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 06:34:29 -0700
Date: Mon, 27 Apr 2026 16:34:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Josua Mayer <josua@solid-run.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/4] phy: phy-can-transceiver: Ad-hoc cleanups and
 refactoring
Message-ID: <ae9l4n8wocbVegcJ@ashevche-desk.local>
References: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
 <ad6KwGIhpJn_2eVz@ashevche-desk.local>
 <7bcb68c4-e4bd-4ad9-bb75-99e0845b204c@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bcb68c4-e4bd-4ad9-bb75-99e0845b204c@solid-run.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: A402F473826
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-7410-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,ashevche-desk.local:mid]

On Mon, Apr 27, 2026 at 11:09:48AM +0000, Josua Mayer wrote:
> Am 14.04.26 um 20:43 schrieb Andy Shevchenko:
> > On Tue, Mar 17, 2026 at 09:27:26PM +0100, Andy Shevchenko wrote:
> >> The driver does two things that need to be addressed:
> >> - includes subject to remove gpio.h
> >> - checks for error code from device property APIs when it can be done in
> >>   a robust way
> >>
> >> This series addresses the above and adds a couple of additional refactoring.
> > Any comments on this? Doesn't look like it being applied so far...
> For unknown reason your patch-set did not arrive in my inbox.
> Perhaps it went missing for others, too?

Are you in the MAINTAINERS for this part of the kernel?
The CAN NETWORK DRIVERS and GENERIC PHY FRAMEWORK do not list your name.

If you think of mail delivery in general, it's delivered at least to the ML
https://lore.kernel.org/all/20260317203001.2108568-1-andriy.shevchenko@linux.intel.com/

TBH I don't know what to answer to your question as I don't know your expectations and
how it should be fulfilled taking into account my above question...

But thanks for the reviewing! I will address the commit message in v3.

-- 
With Best Regards,
Andy Shevchenko



