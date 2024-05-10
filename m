Return-Path: <linux-can+bounces-622-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A737F8C20F5
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2024 11:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 535FCB21B3A
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2024 09:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89FA161330;
	Fri, 10 May 2024 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezKgTlxb"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36F0161320;
	Fri, 10 May 2024 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333505; cv=none; b=ItpJItFN46twCQFDqtZpxk10lm4xBFGs8dNNZHxqiT1DiqMaQXkth5PooyzgrEEtPVOEg2XjvCBtqWqzjdFQ/R6D5hoa1QeqZ2LeYDHyH0rfsY8fVAs0WW4e5ckgW2EHAXo8NUPP8yhOfBFMHyT23WHtdEz9gz/AzjWglVkc/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333505; c=relaxed/simple;
	bh=CmhmnGOQuXsOk0dotnePWkVJo7uvjGnh1DT+ouho8lg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p+ujbxVxILWV0P7cNQiW6eHlZCaFFZgbTb4ORckQmS4EdAxhNHoTXLwA+MiXxFGvRSRxdPggxfKTJ85Oub4KrdYzcDFJukAOrphIi4XqpZPb3vs78acB0Clky+y7dVWpz9dmFVbqxKQd+aETVgKvfp0w3ZAMYZgatcySQnvABzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezKgTlxb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715333504; x=1746869504;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=CmhmnGOQuXsOk0dotnePWkVJo7uvjGnh1DT+ouho8lg=;
  b=ezKgTlxbFwImueLJ9bvzMAup2EEfcfX6LvJWdgk2y1pQAZCybhQcPxjO
   7FpAOlsjNv6iW6XeCxB+ikHV73kpGRUuKxjgB5zWPX2DyKIt/TOYoI5RC
   6hDkHbL1uGcDSkL2ZTx+T4emCZiEmg/54C7WUPPPxuf7tdanJzTP4NwBl
   0qoiIzB5EdYFAp/soolIah0DNva01rARNQAhiLBltnw4+GZZlnwbDwSnP
   wLrrnBregfS7Eh96851ch4SswPDCX8+rTOnlNjxQkSF6+2Jni5JNF/ro8
   rtCwR3PoyDtm5eo6oC4vMLdz1Ac82FxS92kXlOXXsFVCHmpp2vFL4JtoY
   Q==;
X-CSE-ConnectionGUID: av0GeApZTOyJt9vUhbi0mA==
X-CSE-MsgGUID: 50uVox6kTA2DAgW11d0DNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15102054"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="15102054"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 02:31:43 -0700
X-CSE-ConnectionGUID: ODFNwHZvR8OKLwhEHP4wkQ==
X-CSE-MsgGUID: GUk6LxVGQcGmFr9T2LaERw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="34092610"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.85])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 02:31:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 May 2024 12:31:31 +0300 (EEST)
To: Christoph Fritz <christoph.fritz@hexdev.de>
cc: Jiri Slaby <jirislaby@kernel.org>, 
    Oliver Hartkopp <socketcan@hartkopp.net>, 
    Marc Kleine-Budde <mkl@pengutronix.de>, 
    Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
    "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Sebastian Reichel <sre@kernel.org>, 
    Linus Walleij <linus.walleij@linaro.org>, 
    Andreas Lauser <andreas.lauser@mercedes-benz.com>, 
    Jonathan Corbet <corbet@lwn.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
    linux-can@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
    devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3 02/11] HID: hexLIN: Add support for USB LIN bus
 adapter
In-Reply-To: <02d9e48619cff27fb846b5d8f367bc033bbf91e6.camel@hexdev.de>
Message-ID: <f558341c-288a-533c-1fcc-6c18f68e311e@linux.intel.com>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>  <20240502182804.145926-3-christoph.fritz@hexdev.de>  <422e0d3a-3eb9-ff78-8419-56e894e04137@linux.intel.com> <02d9e48619cff27fb846b5d8f367bc033bbf91e6.camel@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1639080712-1715333388=:1562"
Content-ID: <e3cb9b45-d6d0-3a2e-0556-568fa992ae76@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1639080712-1715333388=:1562
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <fec66c8d-f78a-b62f-9231-3713e918c1cc@linux.intel.com>

On Thu, 9 May 2024, Christoph Fritz wrote:

> On Mon, 2024-05-06 at 19:53 +0300, Ilpo J=E4rvinen wrote:
> > On Thu, 2 May 2024, Christoph Fritz wrote:
> >=20
> > > This patch introduces driver support for the hexLIN USB LIN bus adapt=
er,
> > > enabling LIN communication over USB for both controller and responder
> > > modes. The driver interfaces with the CAN_LIN framework for userland
> > > connectivity.
> > >=20
> > > For more details on the adapter, visit: https://hexdev.de/hexlin/
> > >=20
> > > Tested-by: Andreas Lauser <andreas.lauser@mercedes-benz.com>
> > > Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> > > ---

> > > +=09le32_to_cpus(hxf.flags);
> >=20
> > You must use correct endianess typing. The struct hexlin_frame should h=
ave=20
> > __le32 flags so sparse's endianness check is happy.
>=20
> OK
>=20
> >=20
> > But .flags are not used at all so why is this required in the first pla=
ce?
>=20
> Was necessary in the development process and will be used in hid_dbg()
> below in v4.

Ok, I was expecting you'd print it out there but since it wasn't, I made=20
the unused comment.

BTW, you don't need to reply "OK" to me for the review comments which=20
you're going to do in the next version. I trust you'll address those=20
comments which are not replied into. It saves us both time :-).

> > > +=09lf.len =3D hxf.len;
> > > +=09lf.lin_id =3D hxf.lin_id;
> > > +=09memcpy(lf.data, hxf.data, LIN_MAX_DLEN);
> > > +=09lf.checksum =3D hxf.checksum;
> > > +=09lf.checksum_mode =3D hxf.checksum_mode;
> > > +
> > > +=09hid_dbg(hdev, "id:%02x, len:%u, data:%*ph, checksum:%02x (%s)\n",
> > > +=09=09   lf.lin_id, lf.len, lf.len, lf.data, lf.checksum,
> > > +=09=09   lf.checksum_mode ? "enhanced" : "classic");
> > > +
> > > +=09lin_rx(priv->ldev, &lf);
> > > +
> > > +=09return 0;
> > > +}


--=20
 i.
--8323328-1639080712-1715333388=:1562--

