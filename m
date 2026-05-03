Return-Path: <linux-can+bounces-7465-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eByFJ3t/92lsiQIAu9opvQ
	(envelope-from <linux-can+bounces-7465-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 03 May 2026 19:01:47 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B634B6B81
	for <lists+linux-can@lfdr.de>; Sun, 03 May 2026 19:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3E4330031D3
	for <lists+linux-can@lfdr.de>; Sun,  3 May 2026 17:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9690027FB3A;
	Sun,  3 May 2026 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDqRoans"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC0C23C4F2;
	Sun,  3 May 2026 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777827703; cv=none; b=d7cq68HLk35PCE+CExtPqB+Ltuhn8BdDYgUXnuxxArtvGDUII8gvfkZATKzxZKObkWXPSS9JRjz8lsJ0ErIn57LJySOPdVVzu0VH1omBUr918lkqplZFxOAMrq3HSMJG2YweokR+KIimdFpsLXaDwLI3EIBgzcPw1SAhWoeNyQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777827703; c=relaxed/simple;
	bh=fiLiaWwKrVIjOWaSnEWgSySv6Hyt/1f/Gq3WlcytnLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUYjlNnwEFZebLNajP36d0iHYCc3Tl1dmRDmFYfc+m8zCSDVMDJR2aGfVYH7drYf2bl8+CA3EfiHbhlLCfzgDPNhu9AbXFRuU6VbDDTx6s0slFBTVmoKJQC+3ZL+/DgFDypF5QzNZDyF5SC3Rc+CvY2TPR24DlMBWVb04xv6NS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDqRoans; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D568C2BCB4;
	Sun,  3 May 2026 17:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777827703;
	bh=fiLiaWwKrVIjOWaSnEWgSySv6Hyt/1f/Gq3WlcytnLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDqRoansc7LG0FO9DJlMaR6cfChtEWl70hCLSoGRDnFHnCkaQwAenBhsF2TzVfISa
	 NXqeR+nQdHHWLLvU5DmPtFtymssVHP5VuVxpa0mGwPH7htL6DspW+U5V9z7kJrixnk
	 0e0O3bvmgP8nP0PKboyyHyNXBHHyFIhoINu4wMetgRoEZ2XEj1F2LoiGncWJ6DDhWP
	 Qp3fCc+WHA6KhKHQxBQ0gJdXGq0pojPs2M9Xxz/k5RCDapNVMjkr5uFoQ1Ieu13I+F
	 q+/y48w4rfKewY+hSdHpZwkT+5kGY4tdPYTazqRO+NwWXi8y85gbSFblD5PGcDYdr6
	 Eg85pMzHzPmAQ==
Date: Sun, 3 May 2026 22:31:38 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/4] phy: phy-can-transceiver: Ad-hoc cleanups and
 refactoring
Message-ID: <afd_csl0eHFfVWLP@vaman>
References: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
 <ad6KwGIhpJn_2eVz@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad6KwGIhpJn_2eVz@ashevche-desk.local>
X-Rspamd-Queue-Id: 19B634B6B81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7465-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 14-04-26, 21:43, Andy Shevchenko wrote:
> On Tue, Mar 17, 2026 at 09:27:26PM +0100, Andy Shevchenko wrote:
> > The driver does two things that need to be addressed:
> > - includes subject to remove gpio.h
> > - checks for error code from device property APIs when it can be done in
> >   a robust way
> > 
> > This series addresses the above and adds a couple of additional refactoring.
> 
> Any comments on this? Doesn't look like it being applied so far...

Apart from stray delete, rest looks, fine. Can you fix that and rebase

-- 
~Vinod

