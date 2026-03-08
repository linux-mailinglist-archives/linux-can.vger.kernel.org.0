Return-Path: <linux-can+bounces-7021-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KASKF2rPrWnz7gEAu9opvQ
	(envelope-from <linux-can+bounces-7021-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 08 Mar 2026 20:35:06 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 080AE231F7C
	for <lists+linux-can@lfdr.de>; Sun, 08 Mar 2026 20:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6E87300C992
	for <lists+linux-can@lfdr.de>; Sun,  8 Mar 2026 19:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C673631691A;
	Sun,  8 Mar 2026 19:25:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFE5F4FA;
	Sun,  8 Mar 2026 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772997949; cv=none; b=T61UGYGDwh4GerewbJoPawnOpKj2OAtdNwBmtPgERsoOdW3r18jMRUrM9TkM1G1p51S9AosJzZ8CJyEi7tkHzr5Pb1MAu5hxnDDWtwJPtKWjzzLjYyfDk5mlMvLmLdmVP4+3F8ekpfCJiDV2GFG0mMiTzMMqVhXrxrOTymjUtWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772997949; c=relaxed/simple;
	bh=EozQiSK5Ib3FOB1QloyQqe2rY0Z6fW3umZrG7hgNO7Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gzrk4q3GYARzfr7yXGvTtNMbI7oDy5C8S9oLyRargeNeM4CdtBoGtURdhfpyWWnp0leU91EzAkH4cV/nq8mcoZGb9dLrhhOedOSzgs//A2BE9cT6uZP5JqHP+mIGJoW7oMBh+rwHVzYP8l6rzd1OO1wlNbiKEuUs+qBCsWhbtho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 5C544B9DD1;
	Sun,  8 Mar 2026 19:25:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 0977B20024;
	Sun,  8 Mar 2026 19:25:33 +0000 (UTC)
Message-ID: <8c4c5d0c5d014d5cc19eb10906ca1bd83ffb3ce5.camel@perches.com>
Subject: Re: [PATCH v2 phy-next 24/24] MAINTAINERS: add regexes for linux-phy
From: Joe Perches <joe@perches.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, 	spacemit@lists.linux.dev,
 UNGLinuxDriver@microchip.com
Date: Sun, 08 Mar 2026 12:25:32 -0700
In-Reply-To: <20260308191017.kcyi7ka5pktq5jl4@skbuf>
References: <20260308114009.2546587-1-vladimir.oltean@nxp.com>
	 <20260308114009.2546587-25-vladimir.oltean@nxp.com>
	 <ca170cbaf2f8bcbc89bbda68914d8e0d7640f0e7.camel@perches.com>
	 <20260308191017.kcyi7ka5pktq5jl4@skbuf>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: j8cqfom7pfzfp6zpqz8ke1a1p9xdohfr
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18gVnVCxP9qO8FnxW5XHh2uO0wk84Ax7lg=
X-HE-Tag: 1772997933-957601
X-HE-Meta: U2FsdGVkX19ggjHhHzzB2ejeghViKyEU9/Qc1eCdZCBrv+N9xtOnahsspQvZ8jvhU2ga3Lye0QXeOR98rNiSHF/UgohYf3IygLBOBYTY3HQsWda9w1srC+kwAojgNxclR4J1W5hHzgzTrnHExi0J9Fc+5gWFMN63B5g6NiaVGlRxjf7RCVqIBOUj+j4kfyNff6yNQVlLB9e5ila4JDaBwgnDeOVtLtdUQTLLqec4LVPoU+hx+wN3fz8KEXlTs4FZTBiefRKJUZNU0NA/J0kpLWihVSYofGti+NOBrHO1dop4vyrejFOtF51kvKEWWm2P
X-Rspamd-Queue-Id: 080AE231F7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[perches.com:mid];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[perches.com];
	TAGGED_FROM(0.00)[bounces-7021-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	NEURAL_SPAM(0.00)[0.359];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@perches.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,perches.com:mid]
X-Rspamd-Action: add header
X-Spam: Yes

On Sun, 2026-03-08 at 21:10 +0200, Vladimir Oltean wrote:
> On Sun, Mar 08, 2026 at 11:40:44AM -0700, Joe Perches wrote:
> > Perhaps if matching only the include uses:
> > (/ is escaped because get_maintainer is stupid)
> > something like:
> >=20
> > K:	include\s*\<linux\/phy\/phy(?:-common-props|-provider)?\.h\>

> Why is get_maintainer stupid?

The get_maintainer code used to match keywords is

	    foreach my $line (keys %keyword_hash) {
		if ($text =3D~ m/$keyword_hash{$line}/x) {

so it seems the first / in the K: <foo> regex would terminate
the match.

It might have been better to use a different delimiter.
Maybe:

		if ($text =3D~ m{$keyword_hash{$line}}/x

