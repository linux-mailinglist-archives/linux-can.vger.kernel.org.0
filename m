Return-Path: <linux-can+bounces-6618-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMrRCnLYnWk0SQQAu9opvQ
	(envelope-from <linux-can+bounces-6618-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 24 Feb 2026 17:57:22 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE1A18A2C4
	for <lists+linux-can@lfdr.de>; Tue, 24 Feb 2026 17:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB52B30696F6
	for <lists+linux-can@lfdr.de>; Tue, 24 Feb 2026 16:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CBF3A9601;
	Tue, 24 Feb 2026 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GR9pzav9"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D14A3A7F57;
	Tue, 24 Feb 2026 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952095; cv=none; b=XDPsSKJPn1PWJc55mk8x5zovt5c8YqiC5jQhV0Ieiz5Grprs2tfxb6L5dvHtD9NGfWD6qcZEt24FuNrpI9ppZGPmNW9fMoi6G7evAAPqTRXwBfKra1HxLQ3B6NZ21JGqgqJq1DuOACB3GObxWbBCVA1RVrbA7nQxZuid9vX3EIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952095; c=relaxed/simple;
	bh=ZD5nEyHUaQAAk+dGGdvp59svNKJS7ocIox+yEYYGTNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RV33VUPTHvAy6urV0ifF7j1UVOR/w5paDU5pBmVyjR6w77+kujXid0oFUorxZcDLmVIy9Ehi1UsoLhEO0nBcODZJCo8Zzy13shmqABpIhHQrutExS8/7wwMc+nPkT4eb42XSjvCVBkSdfsAHa90UQJkeYiFeIFic5VcYMWRVEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GR9pzav9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771952094; x=1803488094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZD5nEyHUaQAAk+dGGdvp59svNKJS7ocIox+yEYYGTNY=;
  b=GR9pzav9+rexFVJT0zjrVinTBAd87eEnQHh+NYx19/tdbtzLK+5Ngm8N
   jqXvkplQc/gCwXQJwSf6Bo0KgAcqKi8JU6HpX1K5oGWJv625CeoVHe8Mo
   Vn6MjzdjZFU4veWfjJsKxwyg5MZw0joHWlN5rqqaYY67+sFr/erQEQ3Pl
   23sRGRk8wHDh8vvpdkNtx/VlxGN2DHn/IaW0kLPvt6EyxtM3Huh/RtVo1
   Tppsl0AsZBgwA0NIqLQVV1uSmYn7ZPNt3whM/gpkzga5oFN2tHjU1KEYb
   yaZpjqZOk9+KamH6uWb8SvEY9EpJ2tNolIAWG92FktTBjld/OYyzs16Oj
   g==;
X-CSE-ConnectionGUID: t5WmbudhTB+K3E8p68hkbA==
X-CSE-MsgGUID: slZKfnN8Q9as2c4M0fiiCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="83593882"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="83593882"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 08:54:53 -0800
X-CSE-ConnectionGUID: mIqXZ8RKTHyPz8zc+HSQNw==
X-CSE-MsgGUID: BTMRsz0YRli0pf6fcawuaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="220075810"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 08:54:51 -0800
Date: Tue, 24 Feb 2026 18:54:48 +0200
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
Message-ID: <aZ3X2J1rBq1pMkae@smile.fi.intel.com>
References: <20260219202910.2304440-1-andriy.shevchenko@linux.intel.com>
 <20260219202910.2304440-1-andriy.shevchenko@linux.intel.com>
 <20260219202910.2304440-2-andriy.shevchenko@linux.intel.com>
 <20260219202910.2304440-2-andriy.shevchenko@linux.intel.com>
 <20260224162606.spnzzedvmvp2h7xd@skbuf>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224162606.spnzzedvmvp2h7xd@skbuf>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6618-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCE1A18A2C4
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 06:26:06PM +0200, Vladimir Oltean wrote:
> On Thu, Feb 19, 2026 at 09:26:19PM +0100, Andy Shevchenko wrote:

...

> > -	if (!of_property_present(dev->of_node, "mux-states"))
> > +	if (!device_property_present(dev, "mux-states"))
> 
> There's an entire saga with this function - devm_mux_state_get_optional().
> Josua Mayer is preparing to move it to the MUX core, which will be a cross-tree series.
> Would you mind not touching this, to avoid complicating what is already
> a complicated operation? It is going away anyway, and from what I can
> see in Josua's last series, its implementation from drivers/mux/core.c
> is already using device property APIs:
> https://lore.kernel.org/linux-phy/20260208-rz-sdio-mux-v9-2-9a3be13c1280@solid-run.com/

Basically you ask me to postpone the series until that will be in. Since this
file is a mess in terms of OF/fwnode API use in exchange I would like whoever
is doing the other part to speed up a bit if possible.

I prefer to see cleaner solution to be applied sooner and last in a long distance,
that's why I see either mine first but soon, or that first but also soon should
be in. Can we try to achieve that?

...

> > -		phy = devm_phy_create(dev, dev->of_node, &can_transceiver_phy_ops);
> > +		phy = devm_phy_create(dev, NULL, &can_transceiver_phy_ops);
> 
> It is not obvious why you replaced dev->of_node with NULL here.
> It doesn't appear correct. You seem to be breaking OF-based PHY lookups.

It's the default. Yeah, I probably have to explain this in the commit message.

Basically all devm_phy_create(dev, dev->of_node, ...) for clarity should be
converted to that approach. Or even better, a new (agnostic) API should take
default fwnode from the same device.

		phy = devm_phy_create_simple(dev, &..._phy_ops);

// name was quickly chosen and may be not the best we can come up with


...

Thanks for the review!

-- 
With Best Regards,
Andy Shevchenko



