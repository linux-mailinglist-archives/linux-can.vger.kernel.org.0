Return-Path: <linux-can+bounces-625-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A7A8C2676
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2024 16:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909821F22BAD
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2024 14:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996A01311B9;
	Fri, 10 May 2024 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mj+tXYBF"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81EF12D1FC;
	Fri, 10 May 2024 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350313; cv=none; b=GXUaUWA4VG2os0S4h1hfa8+Oys80dy7L81+fjX37HgrGFAIWJIx3Ld6eebuK6OuXV8VpjjSys6/0SHuXHl7YI02tRUo+HVA2HH/8byCnXfa1o3uPMWP/zG9rcdVtTNshBd3CFONjXZGovbCGOUUuigwgE9D+TuVpqoinwTof0l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350313; c=relaxed/simple;
	bh=niXu5BRKreyX5/VTQBuiYRQjncvEAW4BczDH+O37lJw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M8vVDyt23GYj78PZVDTbcQaixYUlAPz2w3pqORrchpXV3KESYhp3zMolqKGZoi1S93lNRdkEpUZUNSqz9KoEtaKQd8bSeGUdPmbtIU0AvBkmjTvTDnQ7yWIQx0/Nupdtk2jLVYjhmgE85Noo9Vi5H4febl6CSfQc7zTbC1QzyhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mj+tXYBF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715350312; x=1746886312;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=niXu5BRKreyX5/VTQBuiYRQjncvEAW4BczDH+O37lJw=;
  b=mj+tXYBFyAUy8o5u4awAf7+PHZ4AsmYXSWXBEmT0c/iBmciIwlxime5o
   VyJ0LJvTBwl+rDEl3Z/s8j4uL1Z3Fcwhe2M6x6RIlkO+tq5o9SisNSOO9
   zAcL1pkEdnmhXX7dUWxedPCRXpDSPhzqXrbJvZktKeV2rxAfdtnZZQg2E
   XUme6IpR0+WyY/EW69sO/LHs3D4fggCI+CItnhY23DYxzWdZuiH941Kwt
   7SCgHBzsHjIjotfJWoMZzFWbOwq0DqKrzcMqpVBVAq9JMv/axljBJxRWc
   IzmpA82fZA2M+vQuiuyx+qm+xhOBw1n6IQZDyV7mIaquGw10j9kDdVZI/
   w==;
X-CSE-ConnectionGUID: WFLcp63AQ/WYvERw1KM/FA==
X-CSE-MsgGUID: yUf+LUxjQduz8tiRt8fR5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11467050"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11467050"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:11:51 -0700
X-CSE-ConnectionGUID: 2fjYUrKGRuGcgXGQnG2rFg==
X-CSE-MsgGUID: UX7epV3VTMGFUeERNoVg2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="34277538"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.85])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:11:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 May 2024 17:11:38 +0300 (EEST)
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
Subject: Re: [PATCH v4 03/11] treewide, serdev: add flags argument to
 receive_buf()
In-Reply-To: <20240509171736.2048414-4-christoph.fritz@hexdev.de>
Message-ID: <45f76c2f-924c-92bc-05b9-683c8d253c66@linux.intel.com>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de> <20240509171736.2048414-4-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1417362723-1715350228=:1562"
Content-ID: <64cdd69b-ef99-9434-9000-64224cf6df52@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1417362723-1715350228=:1562
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <b0478e3d-6cca-a4ae-44c7-dee24fc629b3@linux.intel.com>

On Thu, 9 May 2024, Christoph Fritz wrote:

> For serdev device drivers to be able to detect TTY_BREAK and other flags
> in the buffer, pass the flag buffer pointer down to serdev its receive
> function and update all drivers using it.
>=20
> The changes were mostly done using the following Coccinelle
> semantic patch:
>=20
> // <smpl>
> @ rule1 @
> identifier fn;
> identifier opsname;
> @@
> struct serdev_device_ops opsname =3D {
> =09.receive_buf =3D fn,
> };
> @@
> identifier rule1.fn;
> parameter E1, E2, E3;
> typedef u8;
> @@
>   fn(E1, E2,
> + const u8 *flags,
>   E3)
>   { ... }
> // </smpl>
>=20
> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>

> + * @receive_buf:=09Function called with data received from device (char
> + *=09=09=09buffer), flags buffer (%TTY_NORMAL, %TTY_BREAK, etc)
> + *=09=09=09and number of bytes;
>   *=09=09=09returns number of bytes accepted; may sleep.
>   * @write_wakeup:=09Function called when ready to transmit more data; mu=
st
>   *=09=09=09not sleep.
>   */
>  struct serdev_device_ops {
> -=09size_t (*receive_buf)(struct serdev_device *, const u8 *, size_t);
> +=09size_t (*receive_buf)(struct serdev_device *, const u8 *, const u8 *,
> +=09=09=09      size_t);

These parameters should be named now that they're being touched.

With that done,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.
--8323328-1417362723-1715350228=:1562--

