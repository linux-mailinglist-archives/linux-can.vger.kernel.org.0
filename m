Return-Path: <linux-can+bounces-604-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FFF8C1368
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 19:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3572828CB
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 17:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F3C2F24;
	Thu,  9 May 2024 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="gxr20lvq"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577A88F7A;
	Thu,  9 May 2024 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274420; cv=none; b=C6V/RjJp3lCjUDYaOEGYbvgCbE5NbqcimHUa2fumenad2f7nCuldrZ4UUClSb8WFwv8xQEuQ3M7U66qbAD8bY6W9vGEuXTmaCNAgPK/se4LM349ehSpIUGbRgr/rG4cftFDmIyeA4VwBRElLIGVhvcn4XNJwl0HzHlFlF5GKOek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274420; c=relaxed/simple;
	bh=MxdtaIuvP3af2wFj0GTldAPW14Q+V43o4PQXcu6p13o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jBCF4cY0WRHFaVaS8yOKJwxa/yyOkPivc42NRSSUVc0aPPqV76Ocmxh5cf0vcuEfM33HdD34g8U8ybA0+QaCfbJegDKE8hmd9zW+VGeJj0XeHN0Y65UjKeZpqfNDHySejDOAVWEH33VVNX1UIErE0zH3iydWF3gjWPFkxUGMHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=gxr20lvq; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=25MzYlO2dmwacwaZXrREWevweli0BDq/E6j0rp9hAtM=; b=gxr20lvqEjMnY/UBmuWitZIj9+
	DUIqH7StRf/p5OXpbbH09L/EsjAPuV/9QWRmH58vcj5oC6PNA/H8YC3K7kSw3AmRC+pfR2xswEhUm
	LXwpCzG6LoMm6u1UmJcvdZNUfomrvoJc6MCdAU94kCrinPIQIwkf51oTaz2XJvJotoXY=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s57Dr-001jbE-0e;
	Thu, 09 May 2024 19:06:23 +0200
Message-ID: <333fae36f2332b705320186c2068e1236c9d1142.camel@hexdev.de>
Subject: Re: [PATCH v3 01/11] can: Add LIN bus as CAN abstraction
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Jiri Slaby <jirislaby@kernel.org>,  Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Andreas Lauser
 <andreas.lauser@mercedes-benz.com>, Jonathan Corbet <corbet@lwn.net>, Pavel
 Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org, Netdev
 <netdev@vger.kernel.org>,  devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, linux-serial <linux-serial@vger.kernel.org>
Date: Thu, 09 May 2024 19:06:19 +0200
In-Reply-To: <2024050852-vixen-arson-cb42@gregkh>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>
	 <20240502182804.145926-2-christoph.fritz@hexdev.de>
	 <61adf428-2205-1563-d0b6-fa843e08559d@linux.intel.com>
	 <e0f3d0716ed2f4281561f08bbcd3050dddcf1831.camel@hexdev.de>
	 <4e8a50a0-f938-8aaf-fe4b-d18765407d4d@linux.intel.com>
	 <215d898a0244d717467d44a8e93f186e2f282daa.camel@hexdev.de>
	 <2024050852-vixen-arson-cb42@gregkh>
Organization: hexDEV GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2024-05-08 at 19:48 +0100, Greg Kroah-Hartman wrote:
> On Wed, May 08, 2024 at 08:20:51PM +0200, Christoph Fritz wrote:
> > ...
> > > ...
> > > > > > +static int lin_create_sysfs_id_files(struct net_device *ndev)
> > > > > > +{
> > > > > > +	struct lin_device *ldev = netdev_priv(ndev);
> > > > > > +	struct kobj_attribute *attr;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	for (int id = 0; id < LIN_NUM_IDS; id++) {
> > > > > > +		ldev->sysfs_entries[id].ldev = ldev;
> > > > > > +		attr = &ldev->sysfs_entries[id].attr;
> > > > > > +		attr->attr.name = kasprintf(GFP_KERNEL, "%02x", id);
> > > > > > +		if (!attr->attr.name)
> > > > > > +			return -ENOMEM;
> > > > > > +		attr->attr.mode = 0644;
> > > > > > +		attr->show = lin_identifier_show;
> > > > > > +		attr->store = lin_identifier_store;
> > > > > > +
> > > > > > +		sysfs_attr_init(&attr->attr);
> > > > > > +		ret = sysfs_create_file(ldev->lin_ids_kobj, &attr->attr);
> > > > > > +		if (ret) {
> > > > > > +			kfree(attr->attr.name);
> > > > > > +			return -ENOMEM;
> > > > > > +		}
> > > > > > +	}
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > 
> > > > > Can you use .dev_groups instead ?
> > > > 
> > > > I'm not sure where to attach this in this glue code here. Should I do a
> > > > class_register() and add the .dev_groups there?
> > > 
> > > I guess struct class would be correct direction but I'm not sure if it's 
> > > viable in this case. It would avoid the need for custom sysfs setup code
> > > if it's workable.
> > 
> > I just tried to find a way, but these are 64 sysfs files and declaring
> > them all static looks a bit odd to me. I might be missing something
> > here.
> > 
> > For v4 I would stick to the dynamic setup and fix the rollback.
> > 
> > Any objections?
> 
> Yes, you race with userspace and loose by trying to do this "by hand".
> Make this static please.

OK, static init coming up in v4

thanks
  -- Christoph

