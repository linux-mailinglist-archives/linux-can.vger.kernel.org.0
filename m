Return-Path: <linux-can+bounces-6652-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCqlAxHNomkj5gQAu9opvQ
	(envelope-from <linux-can+bounces-6652-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 28 Feb 2026 12:10:09 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 762E31C27CE
	for <lists+linux-can@lfdr.de>; Sat, 28 Feb 2026 12:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 254533014753
	for <lists+linux-can@lfdr.de>; Sat, 28 Feb 2026 11:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F974218B9;
	Sat, 28 Feb 2026 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1dKaVqe"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487742857CC;
	Sat, 28 Feb 2026 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772277005; cv=none; b=m9/271aq0UQM2qgbgkIbuNYboI4pqduxU9q/rrxDnFkzJos7VRaTKP7IBeWHZi90CbhX8hq7tmiM5KM38xFjHT7l9A3n7pPwlQrWSdCjiBBEnQKBZU/q7JMjKoMyWebBR9OnZ/QNq3sGAsCn/RXp93HSNl6lJORG2QW8Yn+aU24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772277005; c=relaxed/simple;
	bh=AxtK5aNDu+VdCrf2+LU5bZDcJ1M/wjN7Kf28wXjowmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEH3ABdJuIsfHkDPhhztckWDhGLiLw2F4pfYFQFZT9ZwXMPKajpS6M+/xkiubMpLUePpneqsSqgVQwEdbqEC37i5B9IKKussTk5fI3L6SPTyCGNtsmjK9nswe7lyBcocCxBwjIrFk5Pv5pSLtTCSowahYzbTLtzs5GIwy4iPLrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1dKaVqe; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772277003; x=1803813003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AxtK5aNDu+VdCrf2+LU5bZDcJ1M/wjN7Kf28wXjowmQ=;
  b=h1dKaVqeDruUIjKP4JzqnEWlsNFEISUsXa2n46Bmw+HhTo0bwwy3vsYr
   JfCp3+ZLwUmfAiDPWLVDc9TtIMYVIfVsD/vKSNYooq+XFrpcap9q7NX5L
   P9IONCj1TRUbuAWUwgiLAQZjfTJKQlC6bxfyIDLrpHbltUenToNwN79ku
   irWDvjIxMOtJQs1rKnE4qQTrJ8CLF3Fk24LX5SUK/LCu0pMh1OD545Y1Z
   PK5usNxQXdiLZHbCz4OWUqaTPdx6WUKjL9WVwOEsT6Zx255s5dpoxEvGN
   IuwTNBWF5CG/Br6QLYBDRaYrd4yn1n38sKLv6ZdG41AOLuswC1L3ft+3z
   A==;
X-CSE-ConnectionGUID: Kd9q1pyNTKaf3S4HqPzbaQ==
X-CSE-MsgGUID: 7tw3v4fGTYGwO7XbiXLPKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="72551841"
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="72551841"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 03:10:03 -0800
X-CSE-ConnectionGUID: ZUZ41NSPTU29uoTjC37wiw==
X-CSE-MsgGUID: TzyD1p44TNSAvNSGE7MjYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="254974712"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.224])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 03:10:00 -0800
Date: Sat, 28 Feb 2026 13:09:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>
Subject: Re: [PATCH v1 1/4] phy: phy-can-transceiver: Convert to use device
 property API
Message-ID: <aaLNBTZsUQ2vMfOW@ashevche-desk.local>
References: <20260219202910.2304440-1-andriy.shevchenko@linux.intel.com>
 <20260219202910.2304440-1-andriy.shevchenko@linux.intel.com>
 <20260219202910.2304440-2-andriy.shevchenko@linux.intel.com>
 <20260219202910.2304440-2-andriy.shevchenko@linux.intel.com>
 <20260224162606.spnzzedvmvp2h7xd@skbuf>
 <aZ3X2J1rBq1pMkae@smile.fi.intel.com>
 <20260224183000.txlazzyw7z34nhsj@skbuf>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224183000.txlazzyw7z34nhsj@skbuf>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
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
	TAGGED_FROM(0.00)[bounces-6652-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 762E31C27CE
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 08:30:00PM +0200, Vladimir Oltean wrote:
> On Tue, Feb 24, 2026 at 06:54:48PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 24, 2026 at 06:26:06PM +0200, Vladimir Oltean wrote:
> > > On Thu, Feb 19, 2026 at 09:26:19PM +0100, Andy Shevchenko wrote:

...

> > > > -	if (!of_property_present(dev->of_node, "mux-states"))
> > > > +	if (!device_property_present(dev, "mux-states"))
> > > 
> > > There's an entire saga with this function - devm_mux_state_get_optional().
> > > Josua Mayer is preparing to move it to the MUX core, which will be a cross-tree series.
> > > Would you mind not touching this, to avoid complicating what is already
> > > a complicated operation? It is going away anyway, and from what I can
> > > see in Josua's last series, its implementation from drivers/mux/core.c
> > > is already using device property APIs:
> > > https://lore.kernel.org/linux-phy/20260208-rz-sdio-mux-v9-2-9a3be13c1280@solid-run.com/
> > 
> > Basically you ask me to postpone the series until that will be in. Since this
> > file is a mess in terms of OF/fwnode API use in exchange I would like whoever
> > is doing the other part to speed up a bit if possible.
> > 
> > I prefer to see cleaner solution to be applied sooner and last in a long distance,
> > that's why I see either mine first but soon, or that first but also soon should
> > be in. Can we try to achieve that?
> 
> The idea is that Ulf already expressed the availability to take the phy-can-transceiver
> patch through the mmc tree and provide back a tag to be pulled into linux-phy:
> https://lore.kernel.org/linux-phy/CAPDyKFrtTaJ5fqqbGrE_K6SAdTZYUfp-BycGjtWs4SabwBysKA@mail.gmail.com/
> 
> If linux-phy takes your patch first, there will be a conflict when pulling the
> stable branch, and it won't be so fun, plus we can't even build-test Josua's
> submission on linux-phy, so that's obviously not great.
> 
> So yeah, I'm not requesting you to postpone the entire series, just not
> touch devm_mux_state_get_optional() and don't let it appear in your
> patch context.

Thanks for explanation. I prefer that Ulf's staff settles down first as it seems
more important.

> Somebody will have to remove "#include <linux/of.h>" at the end of the
> whole process, but that's minor.

> > ...
> > 
> > > > -		phy = devm_phy_create(dev, dev->of_node, &can_transceiver_phy_ops);
> > > > +		phy = devm_phy_create(dev, NULL, &can_transceiver_phy_ops);
> > > 
> > > It is not obvious why you replaced dev->of_node with NULL here.
> > > It doesn't appear correct. You seem to be breaking OF-based PHY lookups.
> > 
> > It's the default. Yeah, I probably have to explain this in the commit message.
> 
> Ah, ok. Found the "phy->dev.of_node = node ?: dev->of_node;" assignment.
> Sorry and noted, but please add it to the commit message too.

Sure.

> > Basically all devm_phy_create(dev, dev->of_node, ...) for clarity should be
> > converted to that approach. Or even better, a new (agnostic) API should take
> > default fwnode from the same device.
> > 
> > 		phy = devm_phy_create_simple(dev, &..._phy_ops);
> > 
> > // name was quickly chosen and may be not the best we can come up with
> 
> I agree in principle. PHY drivers shouldn't be given a function where
> they routinely have to set one of the arguments to NULL, but a simpler
> function without that argument.
> 
> But the phy-core.c doesn't support fwnode at all yet, it uses OF
> throughout. I think it would be preferable to leave this change to
> somebody who has business in that area.
> 
> (are you interested in PHYs with a fwnode for any particular reason, or
> just because the API is more "generic" just in case?)

Because of inconsistency. This makes my mind blown and the code is not good
for others to read and understand when it's inconsistent like this. That's it.

-- 
With Best Regards,
Andy Shevchenko



