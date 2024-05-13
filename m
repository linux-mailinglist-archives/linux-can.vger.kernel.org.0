Return-Path: <linux-can+bounces-637-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27788C40C7
	for <lists+linux-can@lfdr.de>; Mon, 13 May 2024 14:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6755C282591
	for <lists+linux-can@lfdr.de>; Mon, 13 May 2024 12:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C79145B18;
	Mon, 13 May 2024 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJy1syuG"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CBF2232B;
	Mon, 13 May 2024 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715603622; cv=none; b=byfvG5cqLryOHj1vsyTaLBL382PZrXe5C1g2yZFZ9U3SeN4KMMr/S6Vs1c0SnQKL5mv8x1CQU4bGjMXkNEbChYOyUoNYP72Kv3QxHKPygNnPF3dfglDrWgZ9voI5m5H2KpyJvAcGjpYyWyrLtJFq1wKXQK4OPQcyW7x9hcZm4e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715603622; c=relaxed/simple;
	bh=kPyF0jgu4H5hc7AOKJ8pwY8s21f/hJiC03MAXMeC9O8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pPq+t/4i4eK1NXr8pQ+caWxuzMZX7X5JBVqsA+5GClrQWxxKV+N5tMCk96ia56fQkCNevEhpOtDQHBvJdOyuPXUHxHycLtnVOFvng5jPngSJGFS2UUvvKy+zl1YcZNDa+16tm2BNG0x0pwuzYXLnR2252ckFmv/HlSWYu+u7EEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJy1syuG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715603622; x=1747139622;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kPyF0jgu4H5hc7AOKJ8pwY8s21f/hJiC03MAXMeC9O8=;
  b=YJy1syuGedTejNtnBNV5SvRw+dW4WmwFnS5hQd4SBGlPSH0cwvZhhTje
   eHMFgFInY5/DylQRnwCBSgnkxh9Of2XoFN7yY5gSDBlTFqZ3DOeqJw9NM
   4nlg/S/l886MpiBppHw3MOFybSeMC8RrqxoXkVXbpffy7vg+qCKGFkRuA
   RoMoVuQNDN2I05eoEZ31A6AdONf67r/O0yxV+iLTDefFl2yQ6RMgB4gJ1
   lQUYKvQoc9E60vMhG1xWH8+kFrg8bE/sNoBFtsGZuqY6IWJDAEE9iWuBa
   y93j6DfA8qvR68TJkCa3bFwnzbykFokASi0elq0K3vTNM0xaAAuBM3QSq
   w==;
X-CSE-ConnectionGUID: yaYomly2QPyDYnCcUaBC7w==
X-CSE-MsgGUID: AZM1Ss6DTcifPv1v5suPnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="34047267"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="34047267"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 05:30:44 -0700
X-CSE-ConnectionGUID: Wf1iV9fgSXuMoHhnkQrZng==
X-CSE-MsgGUID: Wq+r6hbtTomJSRQqbzpzRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="34738156"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.89])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 05:30:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 May 2024 15:30:31 +0300 (EEST)
To: Christoph Fritz <christoph.fritz@hexdev.de>
cc: Jiri Slaby <jirislaby@kernel.org>, Simon Horman <horms@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Marc Kleine-Budde <mkl@pengutronix.de>, 
    Oliver Hartkopp <socketcan@hartkopp.net>, 
    Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
    "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Sebastian Reichel <sre@kernel.org>, 
    Linus Walleij <linus.walleij@linaro.org>, 
    Andreas Lauser <andreas.lauser@mercedes-benz.com>, 
    Jonathan Corbet <corbet@lwn.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
    linux-can@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
    devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v4 04/11] tty: serdev: Add method to enable break flags
In-Reply-To: <3070ec70b2477560f205cc4c34dd84b320831365.camel@hexdev.de>
Message-ID: <d5406164-0a65-cb97-3e23-8b4ae1b79905@linux.intel.com>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de>  <20240509171736.2048414-5-christoph.fritz@hexdev.de>  <36b0d460-1d96-89d8-db4a-76d735f7ee6b@linux.intel.com> <3070ec70b2477560f205cc4c34dd84b320831365.camel@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-333432669-1715603431=:1286"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-333432669-1715603431=:1286
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 12 May 2024, Christoph Fritz wrote:

> On Fri, 2024-05-10 at 17:21 +0300, Ilpo J=C3=A4rvinen wrote:
> > On Thu, 9 May 2024, Christoph Fritz wrote:
> ...
> > > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > > index 613cb356b918d..23a1e76cb553b 100644
> > > --- a/drivers/tty/serdev/core.c
> > > +++ b/drivers/tty/serdev/core.c
> > > @@ -339,6 +339,17 @@ unsigned int serdev_device_set_baudrate(struct s=
erdev_device *serdev, unsigned i
> > >  }
> > >  EXPORT_SYMBOL_GPL(serdev_device_set_baudrate);
> > > =20
> > > +void serdev_device_set_break_detection(struct serdev_device *serdev,=
 bool enable)
> > > +{
> > > +=09struct serdev_controller *ctrl =3D serdev->ctrl;
> > > +
> > > +=09if (!ctrl || !ctrl->ops->set_break_detection)
> > > +=09=09return;
> >=20
> > Why you need to test for !ctrl?
>=20
> In our case we don't, it's an extra check like all the other functions
> here:
>=20
> https://elixir.bootlin.com/linux/v6.9-rc7/source/drivers/tty/serdev/core.=
c#L330

Okay. It might be I just don't understand all the structs in serdev well=20
enough to understand when ctrl actually end ups being NULL so I don't=20
object leaving it as is.

--=20
 i.

--8323328-333432669-1715603431=:1286--

