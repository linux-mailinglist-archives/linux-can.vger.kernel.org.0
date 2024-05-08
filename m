Return-Path: <linux-can+bounces-600-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA06B8BFE03
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 15:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9B21F21E06
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 13:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CD06A33F;
	Wed,  8 May 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfcCtNYT"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD77B26AFF;
	Wed,  8 May 2024 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715173712; cv=none; b=WMOx/B+9yYpTMQV8PcmMrnBNOFarUHMbOJuM2+BNPSbL8zWKPISdBmcyQA2lSYEHEc3Qz4aPWLqaDh8Dpvs1KoSaIw8WNxMm3a0SI24DN5Z8mdTP2xpKj92pPJrSlYYfspFIJ+7f4WDLK1yWY7oaWE3HSc+bcUk0m9LHz50lMV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715173712; c=relaxed/simple;
	bh=Nhek7t2kXbSnyS4ynbhye8pjdTcB5x58ll+RArMjhG4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IqOYgm185x3drXKw42ZvrL//8m89SGId8XBqkSkbRFX8lyr+8zNDJRZHJpP+Q081FITzBE0/86KC7456THMakYoawf4TmZIAA+fkjk4eUwrndL2kUlcxj+WEufLlKpg0MqEJuKzZv5LTjuSI4IfjYfp128tzg5M23Kq3q62TplQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfcCtNYT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715173711; x=1746709711;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Nhek7t2kXbSnyS4ynbhye8pjdTcB5x58ll+RArMjhG4=;
  b=jfcCtNYTHirOcv6y7VMtVHK9Zbk6Qo6r/cIpzvvYi6mbfw5G/uZOminI
   UzJbnvTJa331N0/AsnXDBRiKcsiN1fozENd7elmIlPiMopy6ihkvK/09S
   DewJFIlM5P0MfWtzbyhvD4EeJ7mHt24/QjIhoc/+iTdR63TUvgzNx1UVj
   ExaIvxb15RedOpuSuey2R7HKG3wzeaH8wCEeGRGPBKqNbMjHTf17HDsIV
   5KvSTE2NNOnC6Nx15+r2yXfzj1tfnc3L2fUkg/VXtN+8MhIwlk0fu/GFr
   EQ7/7wjrL3OoYpsp+r/eWnIHhOvmpmVqUb/h3iAVKiqtHPTlCU4CVho40
   A==;
X-CSE-ConnectionGUID: 6LniEL/vR6q3cpvYYkh/FA==
X-CSE-MsgGUID: hgUNPgKbTzSodfZyjqDoCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14837324"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="14837324"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 06:08:28 -0700
X-CSE-ConnectionGUID: gag7DJvuRZGkzb+94mIYag==
X-CSE-MsgGUID: unnb3CkzTJ23HcfMHdTsww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28858984"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.80])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 06:08:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 8 May 2024 16:08:15 +0300 (EEST)
To: Christoph Fritz <christoph.fritz@hexdev.de>
cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
    Marc Kleine-Budde <mkl@pengutronix.de>, Jiri Slaby <jirislaby@kernel.org>, 
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
Subject: Re: [PATCH v3 01/11] can: Add LIN bus as CAN abstraction
In-Reply-To: <e0f3d0716ed2f4281561f08bbcd3050dddcf1831.camel@hexdev.de>
Message-ID: <4e8a50a0-f938-8aaf-fe4b-d18765407d4d@linux.intel.com>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>  <20240502182804.145926-2-christoph.fritz@hexdev.de>  <61adf428-2205-1563-d0b6-fa843e08559d@linux.intel.com> <e0f3d0716ed2f4281561f08bbcd3050dddcf1831.camel@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1801532953-1715173426=:3164"
Content-ID: <48adb666-4c9a-aa9a-24fb-3a1d33c5cc32@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1801532953-1715173426=:3164
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <109eb976-de37-c302-06dc-7d4f63b0cbac@linux.intel.com>

On Wed, 8 May 2024, Christoph Fritz wrote:

> On Mon, 2024-05-06 at 19:24 +0300, Ilpo J=E4rvinen wrote:
> > On Thu, 2 May 2024, Christoph Fritz wrote:
> >=20
> > > This patch adds a LIN (local interconnect network) bus abstraction on
> > > top of CAN.  It is a glue driver adapting CAN on one side while offer=
ing
> > > LIN abstraction on the other side. So that upcoming LIN device driver=
s
> > > can make use of it.

> > > +static int lin_create_sysfs_id_files(struct net_device *ndev)
> > > +{
> > > +=09struct lin_device *ldev =3D netdev_priv(ndev);
> > > +=09struct kobj_attribute *attr;
> > > +=09int ret;
> > > +
> > > +=09for (int id =3D 0; id < LIN_NUM_IDS; id++) {
> > > +=09=09ldev->sysfs_entries[id].ldev =3D ldev;
> > > +=09=09attr =3D &ldev->sysfs_entries[id].attr;
> > > +=09=09attr->attr.name =3D kasprintf(GFP_KERNEL, "%02x", id);
> > > +=09=09if (!attr->attr.name)
> > > +=09=09=09return -ENOMEM;
> > > +=09=09attr->attr.mode =3D 0644;
> > > +=09=09attr->show =3D lin_identifier_show;
> > > +=09=09attr->store =3D lin_identifier_store;
> > > +
> > > +=09=09sysfs_attr_init(&attr->attr);
> > > +=09=09ret =3D sysfs_create_file(ldev->lin_ids_kobj, &attr->attr);
> > > +=09=09if (ret) {
> > > +=09=09=09kfree(attr->attr.name);
> > > +=09=09=09return -ENOMEM;
> > > +=09=09}
> > > +=09}
> > > +
> > > +=09return 0;
> > > +}
> >=20
> > Can you use .dev_groups instead ?
>=20
> I'm not sure where to attach this in this glue code here. Should I do a
> class_register() and add the .dev_groups there?

I guess struct class would be correct direction but I'm not sure if it's=20
viable in this case. It would avoid the need for custom sysfs setup code
if it's workable.

> > FWIW, this function doesn't do rollback when error occurs.
>=20
> OK, this issue can be fixed in revision v4.
>=20
> ...

> > > diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/ca=
n/netlink.h
> > > index 02ec32d694742..51b0e2a7624e4 100644
> > > --- a/include/uapi/linux/can/netlink.h
> > > +++ b/include/uapi/linux/can/netlink.h
> > > @@ -103,6 +103,7 @@ struct can_ctrlmode {
> > >  #define CAN_CTRLMODE_CC_LEN8_DLC=090x100=09/* Classic CAN DLC option=
 */
> > >  #define CAN_CTRLMODE_TDC_AUTO=09=090x200=09/* CAN transiver automati=
cally calculates TDCV */
> > >  #define CAN_CTRLMODE_TDC_MANUAL=09=090x400=09/* TDCV is manually set=
 up by user */
> >=20
> > BIT(x) is these days available also for uapi I think.
> >=20
> > > +#define CAN_CTRLMODE_LIN=09=090x800=09/* LIN bus mode */
>=20
> So, should I use just BIT(11) for the new define, or should I also
> refactor the whole list while at it?

Either is fine for me.

--=20
 i.
--8323328-1801532953-1715173426=:3164--

