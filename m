Return-Path: <linux-can+bounces-596-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9248BF905
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 10:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E94B23013
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 08:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5080E45018;
	Wed,  8 May 2024 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="E/Lq6AFw"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51E79476;
	Wed,  8 May 2024 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715158115; cv=none; b=Qx6+w5CTsvOg1izSWmQ3HHGVSv4KbTcvwGpbr6ShN5U87TgSUBo18NEw2QFyJjup0243njBky+H3b13F7jdASjZ7Nw/I5ZhjA01MCCE090AuNghY80EHrKcfByLSC+NYG3CSegcgRKH0ICQoSiqA+Wz5+lk0ud1DJ5Roc7JGLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715158115; c=relaxed/simple;
	bh=KFMj3U7Obl/qOELPmA1G8lQsydYqYK1yXc1XYG2gwpM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qkQokaU8CnyNK/h7wI4593BfmvCuxUZGFVrfK3r6iyqUs3vtN6bVCW75pD1lFWyCAYXVSs3+Ouj9ShShBFSKaxBXvx4HuASpsgbv1VpwLuBsFGHsACAcvyTd3ce5WFN0EofuoBhAPoEnvigNUYgmv88S51H9hQLx/SPPTz18M1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=E/Lq6AFw; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/zOyVvtd4hHv6CKYy7zMjS3W53YqU2ozpdmDgVx4s6Y=; b=E/Lq6AFw4vjvpx20b7f7bacPYa
	Q7jIGpOHSFZqz28PYM10ruDXqZ4t9fmlDxsNpFFNw0FTwKB0MWw64tCk8Y7pnfQ0NZM+vbQz80l6c
	9IFVivOdwvcWD11NfMIrwMrTJmgBLkmu9OZTuBH4mLMGC8rd/me/MyZlHbM34U0nOT/4=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s4cyO-001hNS-1B;
	Wed, 08 May 2024 10:48:24 +0200
Message-ID: <663ea6b946a1a18637a1eae9bd8abe43607d9619.camel@hexdev.de>
Subject: Re: [PATCH v3 03/11] tty: serdev: Add flag buffer aware
 receive_buf_fp()
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Oliver Hartkopp
 <socketcan@hartkopp.net>,  Marc Kleine-Budde <mkl@pengutronix.de>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <bentiss@kernel.org>,  Sebastian Reichel <sre@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Andreas Lauser
 <andreas.lauser@mercedes-benz.com>, Jonathan Corbet <corbet@lwn.net>, Pavel
 Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-input@vger.kernel.org,  linux-serial@vger.kernel.org
Date: Wed, 08 May 2024 10:48:23 +0200
In-Reply-To: <2024050410-gigolo-giddily-97b6@gregkh>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>
	 <20240502182804.145926-4-christoph.fritz@hexdev.de>
	 <2024050410-gigolo-giddily-97b6@gregkh>
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

On Sat, 2024-05-04 at 18:00 +0200, Greg Kroah-Hartman wrote:
> On Thu, May 02, 2024 at 08:27:56PM +0200, Christoph Fritz wrote:
> > This patch introduces an additional receive buffer callback variation
> > besides the already existing receive_buf(). This new callback function
> > also passes the flag buffer (TTY_NORMAL, TTY_BREAK, and friends).
> > 
> > If defined, this function gets prioritized and called instead of the
> > standard receive_buf().
> > 
> > An alternative approach could have been to enhance the receive_buf()
> > function and update all drivers that use it.
> 
> Please, let's do that instead of adding random letters at the end of a
> function pointer :)

:) sure

> 
> > Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> > ---
> >  drivers/tty/serdev/serdev-ttyport.c |  2 +-
> >  include/linux/serdev.h              | 17 ++++++++++++++---
> >  2 files changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> > index 3d7ae7fa50186..bb47691afdb21 100644
> > --- a/drivers/tty/serdev/serdev-ttyport.c
> > +++ b/drivers/tty/serdev/serdev-ttyport.c
> > @@ -32,7 +32,7 @@ static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp,
> >  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
> >  		return 0;
> >  
> > -	ret = serdev_controller_receive_buf(ctrl, cp, count);
> > +	ret = serdev_controller_receive_buf(ctrl, cp, fp, count);
> >  
> >  	dev_WARN_ONCE(&ctrl->dev, ret > count,
> >  				"receive_buf returns %zu (count = %zu)\n",
> > diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> > index ff78efc1f60df..c6ef5a8988e07 100644
> > --- a/include/linux/serdev.h
> > +++ b/include/linux/serdev.h
> > @@ -23,11 +23,17 @@ struct serdev_device;
> >   * struct serdev_device_ops - Callback operations for a serdev device
> >   * @receive_buf:	Function called with data received from device;
> >   *			returns number of bytes accepted; may sleep.
> > + * @receive_buf_fp:	Function called with data and flag buffer received
> > + *			from device; If defined, this function gets called
> > + *			instead of @receive_buf;
> > + *			returns number of bytes accepted; may sleep.
> 
> I don't remember waht "fp" means here, and you don't document it, so
> let's just have one recieve_buf() callback please.

OK, that is a great opportunity for me to use Coccinelle. In the
upcoming revision v4 I'll add the "flag buffer pointer" treewide, then
named "flags".

thanks
  -- Christoph

