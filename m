Return-Path: <linux-can+bounces-7470-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gM5FLwlE+Gn9rwIAu9opvQ
	(envelope-from <linux-can+bounces-7470-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 09:00:25 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3404B9194
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 09:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61E0A301912B
	for <lists+linux-can@lfdr.de>; Mon,  4 May 2026 06:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6687F2BEC2A;
	Mon,  4 May 2026 06:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i0rQvET4"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE17727057D;
	Mon,  4 May 2026 06:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777877922; cv=none; b=lY8mNfZHJbxUNXE0SVngFVUyR6je9o1A5d0eiSBgdnHEOIsoE63gz0VOp+uL2JjHg+KSMdor6VZcu++f4NPG1aMSUKTju6U2ynYxK4KrQNf09eQ1+4pqGHe9fGwenthSfRDIQdZISHkJ+Ie8MdmBuWp4+XrghzKV0UeFSJFf9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777877922; c=relaxed/simple;
	bh=HvE9Ruc8oUHtLsgmJ7bKJpqjHWRjMVBob2gyiyfqOk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Htnwe5ZddQgJwZ5qTWAxJPI7ENfZvQEpgY8WQFeCq5hT1M7hkQDLP9ifFpxS0edjtEQHdIXtM7uCdITo1hsO5+uhocQ52xu6ONwqs8GQPk5bEXE1yptuwycuwFJYVUH+Ya1xnyvD2WvBy1TzbMlWIl0hj6HT0/TvjQnQN8VfbJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i0rQvET4; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777877921; x=1809413921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HvE9Ruc8oUHtLsgmJ7bKJpqjHWRjMVBob2gyiyfqOk8=;
  b=i0rQvET45qr0PKjX4VEHe9DZEHSU2Wr6XA5ldfzUym7bvuAx5HdTqfys
   2air4M/iKSvaPG+CUxbE4y6oSR52QzuXQqhcJv8cCF7TUDbL2vVHFx7Tb
   EFiG5VxH63/x2x9LOahPzMVmCLuKLQcbR4yRbK28JZnfUY2D+83mqiJQl
   RD+o8jABU7Kzz0tMwlU0f/eZR3TaXRGQP9MC/qast97FujAnASuzqAC0W
   EChhB1+Z8TqK9ziGBQh7pK3/RRFdZUvxl8MLmLMSUBgjY/VnySBh9Dlpt
   xGRnY2X/mUIahV7hSmgUfiZ3cN/rGbV7I8kiWZGCGcg1aQQXvqsF8EZPl
   w==;
X-CSE-ConnectionGUID: YrB/Ba1TQQSH88EKr3xHMw==
X-CSE-MsgGUID: M99etK1pRP2K5n5uML3MTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78436930"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78436930"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 23:58:41 -0700
X-CSE-ConnectionGUID: JCXgGk+rR6i2nSfOpMFl2g==
X-CSE-MsgGUID: DuO2+JgmTzuW74sPUnpvqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="234578650"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 23:58:38 -0700
Date: Mon, 4 May 2026 09:58:35 +0300
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
Message-ID: <afhDm5_ydU83xFKU@ashevche-desk.local>
References: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
 <ad6KwGIhpJn_2eVz@ashevche-desk.local>
 <7bcb68c4-e4bd-4ad9-bb75-99e0845b204c@solid-run.com>
 <ae9l4n8wocbVegcJ@ashevche-desk.local>
 <5d4c3c95-cbe1-4439-8036-b014264ce8c2@solid-run.com>
 <ae-AJdSrnXiuc1mW@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae-AJdSrnXiuc1mW@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 2B3404B9194
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-7470-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 06:26:34PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 27, 2026 at 01:41:43PM +0000, Josua Mayer wrote:
> > Am 27.04.26 um 15:34 schrieb Andy Shevchenko:
> > > On Mon, Apr 27, 2026 at 11:09:48AM +0000, Josua Mayer wrote:
> > >> Am 14.04.26 um 20:43 schrieb Andy Shevchenko:
> > >>> On Tue, Mar 17, 2026 at 09:27:26PM +0100, Andy Shevchenko wrote:

...

> > >> For unknown reason your patch-set did not arrive in my inbox.
> > >> Perhaps it went missing for others, too?
> > > Are you in the MAINTAINERS for this part of the kernel?
> > > The CAN NETWORK DRIVERS and GENERIC PHY FRAMEWORK do not list your name.
> > Correct. I touched can phy once related to mux only.
> > > If you think of mail delivery in general, it's delivered at least to the ML
> > > https://lore.kernel.org/all/20260317203001.2108568-1-andriy.shevchenko@linux.intel.com/
> > >
> > > TBH I don't know what to answer to your question as I don't know your expectations and
> > > how it should be fulfilled taking into account my above question...
> > 
> > Changelog v2:
> > - Cc'ed to Ulf and Josua due to above
> > 
> > This is why I expected it in my inbox.
> > Usually in this situation I blame my provider.
> 
> Ah, blame me then. I most likely missed to add your name to the Cc list.

Hmm... I have checked and your address is in the Cc for the whole series,
so I withdraw that I admit earlier that problem is on my side. Please, check
if everything fine on yours. Note, I'm about to send a v3.

> > > But thanks for the reviewing! I will address the commit message in v3.
> > Great!
> 
> And will try hard to make sure your address will be in the Cc list.

-- 
With Best Regards,
Andy Shevchenko



