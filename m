Return-Path: <linux-can+bounces-6207-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79294D39002
	for <lists+linux-can@lfdr.de>; Sat, 17 Jan 2026 18:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C4503019E1C
	for <lists+linux-can@lfdr.de>; Sat, 17 Jan 2026 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9046257431;
	Sat, 17 Jan 2026 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpgrzVGB"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D89202997;
	Sat, 17 Jan 2026 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768670145; cv=none; b=OMouLzf5gXWer2BF8tT1W1X7YRjDkOmW3uB2vKAgh5YAZ+MfgLR+icymRK9VwmYp4alCfTqs3xXy7EoJG+Y3YYISuIssBdhz5gtburz6jKqt23x9odEWpjPNdY3zgHvo3YnFbDlG/XAS5cyEPtWRZwES32kYyJOq/XV0D5rGG3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768670145; c=relaxed/simple;
	bh=jGr49H7lELR3ftr7XRFa0Z5/p9+HvUSv+Xd//G6J90g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GInulXTDounV48/u3QbtKkbq0oPIumI3D0Q+eygpAIYALYjUtmpKnBnWGo4oe3esM43hmy5ZgtS/4Giy6kMzCBrmg82VlLluRJzXb5KhGVc4UUCKaWHFqT6MukNVIgE/eYt+jIYYHjKR7z++KErQehovpDBH2aHD8YCyWgZY+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpgrzVGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E01C4CEF7;
	Sat, 17 Jan 2026 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768670145;
	bh=jGr49H7lELR3ftr7XRFa0Z5/p9+HvUSv+Xd//G6J90g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XpgrzVGBnnizfBHo6er1szMgiQGOEY2Ws1cA5Qfl875qIUz7a/6RHGXXuXlC7ChtO
	 l2QLfsN/7lwDEoRma+kg9TMDF61qzmvOmHnJMdT7AEtm5+EPpY+hn2N6TDq7Im+LVM
	 lRDBnfWeZLkVqiEBqI1CTXkVJ/bjqAUIjeMNXP9u7YP5pNF0BjqsEfwcel1sBn6L/v
	 FQNE8+CJ25/ygqxCOnX+UZWb3hxItRMkldGzoGxnh83XDt3KJOrg68CRdyH/0u1u4k
	 elhTxv9D3Jt7uY9lrevhn7V7SY6V84GVYc/fb0uQ1FRNMS0DrElotqLReRt+U+6hT3
	 e4/X9Nkqv/APA==
Date: Sat, 17 Jan 2026 09:15:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, Marc
 Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, davem@davemloft.net
Subject: Re: [can-next 0/5] can: remove private skb headroom infrastructure
Message-ID: <20260117091543.7881db1a@kernel.org>
In-Reply-To: <f2d293c1-bc6a-4130-b544-2216ec0b0590@hartkopp.net>
References: <20260112150908.5815-1-socketcan@hartkopp.net>
	<a2b9fde3-6c50-4003-bc9b-0d6f359e7ac9@redhat.com>
	<f2d293c1-bc6a-4130-b544-2216ec0b0590@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Jan 2026 11:31:14 +0100 Oliver Hartkopp wrote:
> Long story short: Using the common pattern to wrap a union around 
> dual-usable skb space is the most efficient and least risky solution IMHO.

The concern is that we're making a precedent for, let's call it -
not-routable-networking technology to redefine fields in skb that
it doesn't need. From the maintainability perspective that's a big
risk, IMHO. I fully acknowledge tho that using md dst will be a lot
more work. Which makes this situation an unpleasant judgment call :(

