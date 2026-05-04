Return-Path: <linux-can+bounces-7476-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKJ4CthE+Gn9rwIAu9opvQ
	(envelope-from <linux-can+bounces-7476-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 09:03:52 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD244B9252
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 09:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54DB930302AF
	for <lists+linux-can@lfdr.de>; Mon,  4 May 2026 07:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2961E8826;
	Mon,  4 May 2026 07:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYacqeDB"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916502773FF;
	Mon,  4 May 2026 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777878077; cv=none; b=KYoWntH4C78pHrdC1WOg7svdLtAkH9XOqwv5WhB/u6LvGZm8X6iQ2s8Sdv/NLL5ifSR40ADUGZ992JZLoOqPHSkLgoPU78fgQirkWCQ5nZSdBYXoKTEdS1+WNLkCqXrLAcYfoFwXUceqNiQFJuEcTed5ok/QDu9b+PWtitvVBYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777878077; c=relaxed/simple;
	bh=2C3RgUQGUgPre4/9d/tp99V+jaB/cgZ2W5hnW86hzMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pj5ihVhPBYMqxnTRgjnn29NFMqc5eA74Aw0i52u23428TsXNmfb/fDdpayo3O4B22GSsyUkJ2euMav/EPInFSJLImVUNvui4PPZum97BgBiP6LIamIVf2stg2O28oPDIP9rH5e+doqqgI/np+6fg9zFEMOiXZ9QQUPR5z+x7Bic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYacqeDB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777878077; x=1809414077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2C3RgUQGUgPre4/9d/tp99V+jaB/cgZ2W5hnW86hzMA=;
  b=JYacqeDBbC6aXzg8kQVrsDbHiDprEKxWxT5e+2bZqhoFAPq+5tanuzKT
   Izr26aeyRixp80ABuM4tQJ0yMWMX3ZBQlthUALnX2RhcG5Yhp/xAXrWKN
   iSeHATSPFJNr2HMhLatZJItLS5p99QwTJXNfrqw8oIWFL2sEM+xriuFsR
   Qk74N0VWMIaufYISxsBNv1wOVMrsBd/wRgJ7SLTQ90SauTnmjbhbKd/gZ
   SE9ZBukd6PtfM1WoRAnLhb1dLF8rvetLfhK0y2eSCiLJEhFtu47VrQu2o
   P6jVzfP6a0oace2zPHzA8LtXrB8A+a5/aj/joXDsf4mUsUcC/LNObiW7B
   g==;
X-CSE-ConnectionGUID: tafveHOaSIuGMRn+f4nmHQ==
X-CSE-MsgGUID: mU4A6L6/SOWOUpmoOGeD2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="82344164"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="82344164"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:01:17 -0700
X-CSE-ConnectionGUID: 30Di1k+GS9efkmI+mnyf3Q==
X-CSE-MsgGUID: oUliCpgYROymh1nOd4pB2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="240422915"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:01:13 -0700
Date: Mon, 4 May 2026 10:01:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/4] phy: phy-can-transceiver: Ad-hoc cleanups and
 refactoring
Message-ID: <afhENyhj9CEroKou@ashevche-desk.local>
References: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
 <ad6KwGIhpJn_2eVz@ashevche-desk.local>
 <afd_csl0eHFfVWLP@vaman>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afd_csl0eHFfVWLP@vaman>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 8AD244B9252
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7476-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sun, May 03, 2026 at 10:31:38PM +0530, Vinod Koul wrote:
> On 14-04-26, 21:43, Andy Shevchenko wrote:
> > On Tue, Mar 17, 2026 at 09:27:26PM +0100, Andy Shevchenko wrote:
> > > The driver does two things that need to be addressed:
> > > - includes subject to remove gpio.h
> > > - checks for error code from device property APIs when it can be done in
> > >   a robust way
> > > 
> > > This series addresses the above and adds a couple of additional refactoring.
> > 
> > Any comments on this? Doesn't look like it being applied so far...
> 
> Apart from stray delete, rest looks, fine. Can you fix that and rebase

Sent as 20260504070054.29508-1-andriy.shevchenko@linux.intel.com.

-- 
With Best Regards,
Andy Shevchenko



