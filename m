Return-Path: <linux-can+bounces-7584-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Eri4CERjAGqVIQEAu9opvQ
	(envelope-from <linux-can+bounces-7584-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 10 May 2026 12:51:48 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA82503AC4
	for <lists+linux-can@lfdr.de>; Sun, 10 May 2026 12:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2788E300BCAD
	for <lists+linux-can@lfdr.de>; Sun, 10 May 2026 10:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329E730C608;
	Sun, 10 May 2026 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIRnF+DP"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF3317B418;
	Sun, 10 May 2026 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778410302; cv=none; b=cDw8lnlxZzmjgx7/YmA0IgZxy3gB7QeTywGH+knKJY+oBgZpFBm24LcHBv9TyyNXmEGeXpgFWaQNbiMoLZRbHC/vW8Oepnf7KTdge0QCQM0QRodIuOCQWJ+SQMIzSkJh7AC+AV4jd1mN3zOq4UVHOBYT3mhwO1O2sdRfhQej08c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778410302; c=relaxed/simple;
	bh=QCxXfmiA59KqWTFUH9USIWlvPZ5PP7UwMzDy7DfipsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAoyI4bizp95UN+bhSq4lfNMOnSv9yW24Jh6f8TFYfbjzlwIEH6yewDphTAERf2ZUuPuVnns3uFJclePcxvulmugmB3lLVgANsjBd3S/vE6AbmWZnURFOgNeHI8LLZYlF3xEBcNGaCSxlYO745sTkoVn9pwXliTbBkXlb5NQo/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIRnF+DP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F915C2BCB8;
	Sun, 10 May 2026 10:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778410301;
	bh=QCxXfmiA59KqWTFUH9USIWlvPZ5PP7UwMzDy7DfipsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nIRnF+DPrVYWaPJrNdeS9Nf5F0i9YVo9QTITqZrrY6eL/3ULkMplwZJb53vPdfHHQ
	 FGokGYnIN1JjtY5iccsVwjFEGsvhiQ57FJEKOsS8IKHbfKR0BZfwHYfOOrRxebis/A
	 f80jAfoyHFlPQCR+Oh8uzeySJ2aYsyxojDTH2/E3mK28nu979GzNOg+5dW4iA5o0zA
	 dfAIw/2iu129t8Q60SbITgzr+5Uag52KBA0zf+ekDcs2g3D3TqDUYzulp2qy4++aWp
	 7wmRaORrNVw+Mt3a6uA3bG7KqWnOkB/yaTgkGzfsQ9qKGzwHn5XrkkMCwIFdZXQJ+w
	 AFDYADD7V//cw==
Date: Sun, 10 May 2026 16:21:38 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Peng Fan <peng.fan@nxp.com>, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>, Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH v3 0/4] phy: phy-can-transceiver: Ad-hoc cleanups and
 refactoring
Message-ID: <agBjOmnpKuZoDfWG@vaman>
References: <20260504070054.29508-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504070054.29508-1-andriy.shevchenko@linux.intel.com>
X-Rspamd-Queue-Id: 5CA82503AC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7584-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 04-05-26, 08:58, Andy Shevchenko wrote:
> The driver does two things that need to be addressed:
> - includes subject to remove gpio.h
> - checks for error code from device property APIs when it can be done in
>   a robust way
> 
> This series addresses the above and adds a couple of additional refactoring.

Sashiko flagged some issues, some of them not introduced by this, can
you please check this:

https://sashiko.dev/#/patchset/20260504070054.29508-1-andriy.shevchenko%40linux.intel.com

-- 
~Vinod

