Return-Path: <linux-can+bounces-7023-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKyKCcb4rWlK+QEAu9opvQ
	(envelope-from <linux-can+bounces-7023-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 08 Mar 2026 23:31:34 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8014A2326F9
	for <lists+linux-can@lfdr.de>; Sun, 08 Mar 2026 23:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 011C53012E81
	for <lists+linux-can@lfdr.de>; Sun,  8 Mar 2026 22:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BF832AABF;
	Sun,  8 Mar 2026 22:22:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1B51DE8BE;
	Sun,  8 Mar 2026 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773008545; cv=none; b=XiPQ897q5YcKhwCBWmWXV8ph3Aid/93nf7n5QspfGzVLVFyJ/5JVw8tVy9J1opydiemuGpcMFfkOLPBJgPr7zNBYBOi7WDhg2sU3JbhCa04V/rmbKlRzAC+p0SaMf2HJc7iIUg8aMwwJJ22XAkuUFKABJuKEdpWvsFDqOzdQKH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773008545; c=relaxed/simple;
	bh=n8fdsNpksQMyzDLZEkSIk2mSFJWH1PAnAyRdAAkVywk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CMgBcMVhsuOLuwMxHF54Ytpp1e+83IjoZ62tEipsmr/13AbztmpOxwvt53sKRW1xQZHHB+joRtvphzzSRahATe/CPQdh+op/9FvQd9XbKXIlDU8FXpTD0G21edL8cL6+vpeMa+2Fra8odSRkPK1Vyd849vKOrxTepFiTEbrbYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 42DD81B91B3;
	Sun,  8 Mar 2026 22:22:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id BD6C56000E;
	Sun,  8 Mar 2026 22:22:14 +0000 (UTC)
Message-ID: <9fd14d166e860f26febfbc9061a6dcae6a166961.camel@perches.com>
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
Date: Sun, 08 Mar 2026 15:22:13 -0700
In-Reply-To: <20260308205623.5trrqdmdrzj744hi@skbuf>
References: <20260308114009.2546587-1-vladimir.oltean@nxp.com>
	 <20260308114009.2546587-25-vladimir.oltean@nxp.com>
	 <ca170cbaf2f8bcbc89bbda68914d8e0d7640f0e7.camel@perches.com>
	 <20260308191017.kcyi7ka5pktq5jl4@skbuf>
	 <8c4c5d0c5d014d5cc19eb10906ca1bd83ffb3ce5.camel@perches.com>
	 <20260308205623.5trrqdmdrzj744hi@skbuf>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: zgtxuwsb3363ai68tf6p7s8zp8seinzy
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19wsONHcaef5rI729O90pckRr9dLrQEYXs=
X-HE-Tag: 1773008534-677296
X-HE-Meta: U2FsdGVkX19zIqgNUKb+c+5Mu7Q3C+Gpl/B+X8eI5i6bGv7WE3zpj355qMm6YCbRSW7Vrhs2aumEBIt791syA8wOI3oaCj+46xwg3qNvWJkp2gLycZfqNtZEDdNuGCB0y349Wog5E09dSEbmxlYo3wEry6L0kQTHpHQi1eemnMz3eHRJ8lW0g+PBe0pZnw/seBVjwauSFyG+tNp9GhFkZXlt5WBWbJRv4eXsvXAwTvZLp/ToUvk9BlaA2J9NhuyWc4djQ+wNnPyIbjEf3YbjCt97pmlbZeZatO9Oxpnpbki4SgQq7YX4GOxv15JoA/1s08cXIoR5CaQiUuDxwOWahT02urVywBVxEzsYACoHDQg9R+OY8J92EbaYAELi/zOh
X-Rspamd-Queue-Id: 8014A2326F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[perches.com:mid];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[perches.com];
	TAGGED_FROM(0.00)[bounces-7023-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	NEURAL_SPAM(0.00)[0.277];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@perches.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64];
	DBL_BLOCKED_OPENRESOLVER(0.00)[perches.com:mid,perl.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: add header
X-Spam: Yes

On Sun, 2026-03-08 at 22:56 +0200, Vladimir Oltean wrote:
> On Sun, Mar 08, 2026 at 12:25:32PM -0700, Joe Perches wrote:
> > On Sun, 2026-03-08 at 21:10 +0200, Vladimir Oltean wrote:
> On Sun, Mar 08, 2026 at 11:40:44AM -0700, Joe Perches wrote:
> > > Perhaps if matching only the include uses:
> > > > (/ is escaped because get_maintainer is stupid)
> > > > something like:
> > > >=20
> > > > K:	include\s*\<linux\/phy\/phy(?:-common-props|-provider)?\.h\>
>=20
> > > Why is get_maintainer stupid?
> >=20
> > The get_maintainer code used to match keywords is
> >=20
> 	    foreach my $line (keys %keyword_hash) {
> 		if ($text =3D~ m/$keyword_hash{$line}/x) {
> >=20
> > so it seems the first / in the K: <foo> regex would terminate
> > the match.
> >=20
> > It might have been better to use a different delimiter.
> > Maybe:
> >=20
> 		if ($text =3D~ m{$keyword_hash{$line}}/x
>=20
> So why does it match in my example?

Not sure really.  But it does match exactly.
Maybe the regex code scans forward until the last /
as the / character is not a "real" metacharacter.

I added some test code and it produced:

line:	<+#include <linux/phy/phy.h>>
kw:	<(?:linux/phy/phy\.h|phy-props\.h|phy-provider\.h)>
test:	<^[+-].*(?:linux/phy/phy\.h|phy-props\.h|phy-provider\.h)>
match:	<+#include <linux/phy/phy.h>

From https://perldoc.perl.org/perlrequick

Not all characters can be used 'as is' in a match.
Some characters, called metacharacters, are considered special,
and reserved for use in regex notation. The metacharacters are

{}[]()^$.|*+?\

A metacharacter can be matched literally by putting a backslash before it:

"2+2=3D4" =3D~ /2+2/;    # doesn't match, + is a metacharacter
"2+2=3D4" =3D~ /2\+2/;   # matches, \+ is treated like an ordinary +
'C:\WIN32' =3D~ /C:\\WIN/;                       # matches
"/usr/bin/perl" =3D~ /\/usr\/bin\/perl/;  # matches

In the last regex, the forward slash '/' is also backslashed, because it is=
 used to delimit the regex.

