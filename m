Return-Path: <linux-can+bounces-6457-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCHfM7sJgWkCDwMAu9opvQ
	(envelope-from <linux-can+bounces-6457-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Feb 2026 21:31:55 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8D1D11AB
	for <lists+linux-can@lfdr.de>; Mon, 02 Feb 2026 21:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44860304AAD5
	for <lists+linux-can@lfdr.de>; Mon,  2 Feb 2026 20:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2882F1FC3;
	Mon,  2 Feb 2026 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mHmTPRmR"
X-Original-To: linux-can@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07722ECEBC;
	Mon,  2 Feb 2026 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064155; cv=none; b=WSYU4oGuRGn11iGYPlD9ftT/VIHPAEO1Z7bvQHABoI57ZjtZRK3xrDLnKc2QUikNd/bd8cPyJiUc7c7Z8k5dUAcdVPGfzmNKMTbLhB0jcBB590ZUkQBqHlGLou0dmqV2EiURgiZSEQYWv4pIteJP9Z6Ey6fxArQWf4xAFTcL5W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064155; c=relaxed/simple;
	bh=wndgnXwC+3NQLCSYu73XT7gvmQ7XHvuQXoXMLyUwj+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yg6DcITCnzGU90fG2d0ZvOoloIW/eWwXZId7AmqPTOyhRWw9zbTYRN8UzO+PPKbJRekh+DNgQ46eBevuq0Z5rSKJROc6VK35OxsYpX8nQ1LQw9ZZEE+I/MHcAzoBTuQl3NwUSTboTDigT4nIDe5aOEeTtap08W+ppfZpP81w9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mHmTPRmR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ci2PbKa2nNxEDukBqxUSNkI6L2yFMqmuuqGwITavS34=; b=mHmTPRmR6gmpO21VjfHb31nk37
	TvjHbls/wIHtHdk5SD6SZrTEyhLOwjAURyDHK22R8gM/D8LAMf1SHdFPqdMINb7Dq0t70KKywR+En
	nDUyPTKsQJPZSnPcKlWgwi+KJV2mo+yL9iZ61h+uHH+l95M5ieD+/fShkns0YjA3DPrI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vn0Xj-005roo-SG; Mon, 02 Feb 2026 21:29:07 +0100
Date: Mon, 2 Feb 2026 21:29:07 +0100
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
Message-ID: <66924451-2b19-4a3b-ba99-16437dc79011@lunn.ch>
References: <20260131004327.18112-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131004327.18112-1-enelsonmoore@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6457-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B8D1D11AB
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:42:56PM -0800, Ethan Nelson-Moore wrote:
> Many network drivers have unnecessary empty module_init and module_exit
> functions. Remove them (including some that just print a message). Note
> that if a module_init function exists, a module_exit function must also
> exist; otherwise, the module cannot be unloaded.

I could be missing it, but which module does not have an module_exit
function?

I ask, because maybe the author does not want to allow the module to
be unloaded. We should look at the history of that module.

   Andrew

