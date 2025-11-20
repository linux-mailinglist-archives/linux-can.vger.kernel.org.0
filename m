Return-Path: <linux-can+bounces-5507-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4D7C737A9
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 11:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A2AD62A5B7
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 10:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EE1372AB7;
	Thu, 20 Nov 2025 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="THYJMOAe"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5D1205E25
	for <linux-can@vger.kernel.org>; Thu, 20 Nov 2025 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763634866; cv=none; b=Lsnu1YZtSIzNlelXlohmmoU0155lOhTdgrqrNX9TAyjjw861VqdgVCT2q1X6heOCtwALG4bZKR87hcs4owtMg+RTRaH4QJIcXJVgkNkFTinO3e9bYQpmOIXh9Y11bjMcZ7W4tCEItycPG7bjZqRrv/qFbXmjfLRuk4r74wlOOtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763634866; c=relaxed/simple;
	bh=X9Uk6my+2oWSmDNBBejfGv3hDlCyxPluPCdIxbdQG5c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=sVC0Y9C2DC2TGLlY+3386NSxDPHE8bz3jmEtJLLy04IoNtdwWD9i9yxk36Rrig5gGqtYt3kmTWMYJfUwzpLtl+0zF6elXzMuW0fELDdyxBPn64kt45+4O7VkeI6W0JlY7U6lHvHLAcTG9jVl0PrRKstMmE5gu9ajBeO2TF9PfHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=THYJMOAe; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from zimbra65-e11.priv.proxad.net (unknown [172.20.243.215])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 7090713F899;
	Thu, 20 Nov 2025 11:34:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1763634855;
	bh=X9Uk6my+2oWSmDNBBejfGv3hDlCyxPluPCdIxbdQG5c=;
	h=Date:From:To:Cc:In-Reply-To:Subject:From;
	b=THYJMOAeuHjc27l9vOE+2X6+8TQfBtx8dwcCCa9ZfhHu/yTXwM/8pCerLKmdbhDwE
	 e4ojyv1M4fENNe7H2U8N7ygYQ/NsxFfzpTF6OYx/nEQWXMetqKr7GQ6wrI9uWTNKFx
	 nM60+prIU83A8oAR9jzXA/pEFx6yoI7VEvGIUpO9rpAH2IoEx1LyT4D86ktPqpegNb
	 tadH7wxNf/HteVjMouZHyJJNSsgl/K9+y0MamWR1bQ0oYdxbCFKT/la/ieKHHvsZ2Q
	 jRDXZB8u154QSbFQ9OqcpLpc35QNDB4sDem/VY9rHT885kaTZRR/xZpYYBGdnoa1nX
	 4+pW23cibVsyQ==
Date: Thu, 20 Nov 2025 11:34:14 +0100 (CET)
From: =?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@free.fr>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, 
	=?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@hms-networks.com>
Message-ID: <473832673.673623427.1763634854731.JavaMail.root@zimbra65-e11.priv.proxad.net>
In-Reply-To: <cedee756-ae5b-456c-96b0-9263177a647a@hartkopp.net>
Subject: Re: Mainlining of [canxl v2 00/15] CAN XL support for review (full
 series)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - GC142 (Linux)/7.2.0-GA2598)
X-Authenticated-User: stephane.grosjean@free.fr

Hello,

Only small nitpicks from my side:

> - make RESTRICTED a normal ctrlmode_supported option
> - make TMS a normal ctrlmode_supported option

If I understand =E2=80=9Cnormal=E2=80=9D (for RESTRICTED) as an option that=
 is not solely linked to CANXL, I no longer understand it for TMS. Could yo=
u explain please?

The BOSCH communication refers to =E2=80=9Cpure-CANXL=E2=80=9D mode rather =
than =E2=80=9CCANXL-only=E2=80=9D mode as used here. Is this an intentional=
 choice on your part?

> Open discussions / review results:
> - not removing "const" in can_update_sample_point()

This topic has nothing to do with CANXL, and I have already expressed my op=
inion on it: =E2=80=9Cconst=E2=80=9D has its place in the parameter declara=
tion of a function in C.

> - have the ctrlmode names in ip feedback messages capitalized

The use of capital letters here is simply a matter of adopting the formalis=
m generally used in C for constant symbols. Which itself is inspired by the=
 formalism generally used for acronyms. I don't see anything else to add he=
re. IMHO.

And finally, as little as my opinion on the various patches in the v2 serie=
s may be of use, I didn't see anything terrible. I did have some doubts abo=
ut:

[canxl v2 08/15] can: bittiming: add PWM validation

+        if (pwm->pwmo >=3D pwm->pwms + pwm->pwml) {

but it turns out that >=3D is actually more sensible than >

Regards,

-- St=C3=A9phane

----- Mail original -----
> Hello Marc/Vincent/St=C3=A9phane!
>=20
> We are right before Linux 6.18-rc7 and I would like to have the CAN
> XL
> support ready for the 6.19 merge window.
>=20
> Unfortunately the reaction time and feedback from Vincent is
> currently
> very intermittent. This is no criticism but risky for catching the
> 6.19
> merge window.
>=20
> This v2 patch set is feature complete and tested.
>=20
> Finalized discussions (code complete in v2 patch set and tested):
> - make RESTRICTED a normal ctrlmode_supported option
> - make TMS a normal ctrlmode_supported option
> - omit CAN_CTRLMODE_XL_ERR_SIGNAL in netlink API
>=20
> Open discussions / review results:
> - not removing "const" in can_update_sample_point()
> - have the ctrlmode names in ip feedback messages capitalized
> - increase the resolution to two decimal places in
> can_calc_bittiming()
> - can_calc_pwm() has no return value (kernel test robot report)
>=20
> The latter are tiny fixes and beautifications that potentially can
> also
> be done after the merge window.
>=20
> Therefore I would propose to mainline the current v2 patch set right
> now
> and see what we can improve until the merge window closes.
>=20
> @Vincent: If you are currently busy I can offer to work on the open
> points for you. So it would just be a review-job for you and I would
> send a v3 patch set until Friday (latest).
>=20
> Best regards,
> Oliver
>=20
> On 15.11.25 17:37, Oliver Hartkopp wrote:
> > This series is based on Vincents CAN XL patches 2025-10-13 11:01
> >=20
> > https://lore.kernel.org/linux-can/20251017-enchanted-quiet-civet-84dd47=
-mkl@pengutronix.de/T/#mdecc959e0ef7c16c64f35e9dd3d687954e15c8ac
> >=20
> > For a better review here is the complete series of available
> > patches with
> > some changes, especially the error-signalling handling.
> >=20
> > The changes to Vincents original patches are documented below:
> >=20
> > Oliver Hartkopp (2):
> >    can: dev: can_dev_dropped_skb: drop CC/FD frames in CANXL-only
> >    mode
> >    (replaces can: netlink: add CAN_CTRLMODE_XL_ERR_SIGNAL flag
> >    patch)
> >    can: raw: instantly reject unsupported CAN frames
> >    (the adapted version using can_dev_in_xl_only_mode() helper)
> >=20
> > Vincent Mailhol (13):
> >    can: bittiming: apply NL_SET_ERR_MSG() to can_calc_bittiming()
> >    (no change)
> >    can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
> >    (no change)
> >    can: netlink: add CAN_CTRLMODE_RESTRICTED
> >    (no change)
> >    can: netlink: add initial CAN XL support
> >    (remove the "bad device" warning for CAN_CTRLMODE_RESTRICTED)
> >    can: netlink: add CAN_CTRLMODE_XL_TMS flag
> >    (remove the requirement that TMS MUST be set. Use defaults: off)
> >    can: bittiming: add PWM parameters
> >    (no change)
> >    can: bittiming: add PWM validation
> >    (no change)
> >    can: calc_bittiming: add PWM calculation
> >    (no change)
> >    can: netlink: add PWM netlink interface
> >    (no change)
> >    can: calc_bittiming: get rid of the incorrect "nominal" word
> >    (no change)
> >    can: calc_bittiming: add can_calc_sample_point_nrz()
> >    (no change)
> >    can: calc_bittiming: add can_calc_sample_point_pwm()
> >    (no change)
> >    can: add dummy_can driver
> >    (remove CAN_CTRLMODE_XL_ERR_SIGNAL but print error-signalling
> >    state)
> >=20
> >   drivers/net/can/Kconfig              |  17 ++
> >   drivers/net/can/Makefile             |   1 +
> >   drivers/net/can/dev/bittiming.c      |  63 ++++++
> >   drivers/net/can/dev/calc_bittiming.c | 104 +++++++--
> >   drivers/net/can/dev/dev.c            |  18 +-
> >   drivers/net/can/dev/netlink.c        | 319
> >   +++++++++++++++++++++++++--
> >   drivers/net/can/dummy_can.c          | 284
> >   ++++++++++++++++++++++++
> >   include/linux/can/bittiming.h        |  81 ++++++-
> >   include/linux/can/dev.h              |  68 ++++--
> >   include/uapi/linux/can/netlink.h     |  34 +++
> >   net/can/raw.c                        |  54 ++++-
> >   11 files changed, 970 insertions(+), 73 deletions(-)
> >   create mode 100644 drivers/net/can/dummy_can.c
> >=20
>=20
>=20

