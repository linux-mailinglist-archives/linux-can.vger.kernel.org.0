Return-Path: <linux-can+bounces-6459-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMdEEBsegWm0EAMAu9opvQ
	(envelope-from <linux-can+bounces-6459-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Feb 2026 22:58:51 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C19DD1E6C
	for <lists+linux-can@lfdr.de>; Mon, 02 Feb 2026 22:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90BF3304DEA7
	for <lists+linux-can@lfdr.de>; Mon,  2 Feb 2026 21:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A3C318BB2;
	Mon,  2 Feb 2026 21:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TnPxR8X+"
X-Original-To: linux-can@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C33164D8;
	Mon,  2 Feb 2026 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770069407; cv=none; b=gxYvkmupPEgutV+XS7Z5qg3Z/Mw9lTfPaO5yWHqOjCGiKPxjVG/dGwUx9faSaXXNx9M0ivacA5CtsRENYn2mdAEfLPLzWMeMidGU5O1AqIz2T5B/nSyTw47pFS7sM7D30Mm5W6KpFLcD1qZy98qT2XnUhoFaf29yHdJzCocTmWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770069407; c=relaxed/simple;
	bh=icNL53FMGHZpKJ4q+2FtrZzRr7eH0qXFby9T73+w2xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNsa1IJDZbA+u4hDB2eaYQ2ecZVQPG5I7dEGMPM1XqyGgykuBMn4L99Zrs+Lsmpyk4wBWVk5FGm4HXv/sjwFYxBm+uMI/vJcdUA4h33Wc/J4smVAc7Ul1nqFSq0rdG9Pb+iGXw1rXti2jpBQG/gI+PGh6oynuYwcfuWavrQ56R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TnPxR8X+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=rJvzut9ZNDadtUO4vR0GCubAl85vutbghKxFZL86ddI=; b=Tn
	PxR8X+/lLbO1GfT2BaLa4eARDN6IEu7e9CjwsRQ5R4hH/L1ShhyD4GOae6iH8OsOg0IYv5idoI9fp
	xYKcV5GFu8MwUlDGM6Nb4xeq1y/KPEaG5yluGqwqfHOUrHnvdqNLhZx/rcHk7M695EzjPfVAhmgCM
	1aSTmhpLBNleiPY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vn1uV-005sPv-2L; Mon, 02 Feb 2026 22:56:43 +0100
Date: Mon, 2 Feb 2026 22:56:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Thomas =?iso-8859-1?Q?M=FChlbacher?= <tmuehlbacher@posteo.net>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH net-next] net: remove unnecessary module_init/exit
 functions
Message-ID: <4b7b8238-3997-45d1-a8ee-b659afc0374c@lunn.ch>
References: <20260131004327.18112-1-enelsonmoore@gmail.com>
 <66924451-2b19-4a3b-ba99-16437dc79011@lunn.ch>
 <CADkSEUjEYY=Wwyumv3Ft_T=xWLJY2hiy4uw_YMus=4o=61H+BQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkSEUjEYY=Wwyumv3Ft_T=xWLJY2hiy4uw_YMus=4o=61H+BQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6459-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C19DD1E6C
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 12:33:08PM -0800, Ethan Nelson-Moore wrote:
> Hi, Andrew,
> 
> On Mon, Feb 2, 2026 at 12:29 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > I could be missing it, but which module does not have an module_exit
> > function?
> None of them. That sentence was just to explain why other instances of
> empty module_exit functions were not removed, in case someone else
> tries to do that. I didn't realize module_exit was required to unload
> the module at first, and other people might not either.

You need to be careful with commit messages. Reviewers read them, and
think about the implications of what they say. As a result, you wasted
some of my time looking for a driver which did not have an
module_exit, and wondering if there was a legitimate reason for not
having it, and had you just broken it....

       Andrew


