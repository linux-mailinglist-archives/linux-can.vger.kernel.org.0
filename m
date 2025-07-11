Return-Path: <linux-can+bounces-3959-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95C1B018FD
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 11:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0381732AD
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 09:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8087527E07B;
	Fri, 11 Jul 2025 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="lmFS5kwL"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E786827E1AC;
	Fri, 11 Jul 2025 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227954; cv=none; b=mJHPxWGDpbM4OdLD59laEHZ/FbSjxWkJW2sOdVPwcSNLs5us24gtkBTHySn/Gi+YwmdXm+UREM26EG/EJpDSN3ytrVPchfzo4/ufIOr7FW7/g2OhiYDU95JcD1EmN7HWJX+0F8DQYgh8LDx200a6XIBDT2qOCq6o1gyRyYggzB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227954; c=relaxed/simple;
	bh=mRpDbLmUE4UhOYnKEFMxZgDfRVRQj7DSkhbNrT4V1pI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6PNra1lUS1pTbYIcwv95A6Py6KNsMlJHVzXnzeDXLPk+dS7p/aXT4I1Vm9wIN3TK6mGiPCJk0++/KADd92Mon8p3iltRw85CkFO3OZNMdkgYz5ydGb+uDQIQQR3+OpXiOescMja1ZdPLjb3nOMbn6jHh25onEHQMRAN1QSH6L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=lmFS5kwL; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752227939; x=1752487139;
	bh=xvF2aSWSqqBO05cN0sTOxCgtVge8RdAFdTQlScpH9Eg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lmFS5kwL2YtEeOsG+rdTD7E6jSLYUe+N62vYY8y5Daw+3PoHfqAIFee6tK0SNfBah
	 oyA9zqgp4+mU6ToH+rmpWPahOQOOmQgXyX511SnoFVzVW66n/luX8kdLdT3oBL4XdZ
	 vQv5r/fWFimNW63YIRYBsBXzv9Wlzy4AWgAM/NUZMyjAwV/JFhWuCFZGLSe13KpL/a
	 OizFUJWdYPfhBmGwCRmmSUhTYziqWa/a5hqDK565pMmXJJFc52zJvF2W49N/alCPsO
	 WyY3Q3jCsgxpVPeZjSMfb5ltEFBRIwmqdsP9SpWgvrOCyddaG1OhOaQvblQnpjIu3n
	 Nl7M8e6TYEjrw==
Date: Fri, 11 Jul 2025 09:58:53 +0000
To: Marc Kleine-Budde <mkl@pengutronix.de>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Fengguang Wu <fengguang.wu@intel.com>, Varka Bhadram <varkabhadram@gmail.com>, Dong Aisheng <b29396@freescale.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] can: m_can: apply rate-limiting to lost msg in rx
Message-ID: <ku5336aidq5j24dswy5egbuse6a6jpfmf5j7ochenifxzy7he7@lth6f55c4nz4>
In-Reply-To: <20250711-astonishing-tentacled-tench-9fe229-mkl@pengutronix.de>
References: <20250630-mcan_ratelimit-v2-1-6b7a01341ea9@geanix.com> <20250711-astonishing-tentacled-tench-9fe229-mkl@pengutronix.de>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 7840f87d63de82f4d7eb80479cc4dae2a8f33d4b
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 11, 2025 at 11:33:35AM +0100, Marc Kleine-Budde wrote:
> On 30.06.2025 09:52:44, Sean Nyekjaer wrote:
> > Wrap the "msg lost in rxf0" error in m_can_handle_lost_msg() with
> > a call to net_ratelimit() to prevent flooding the kernel log
> > with repeated debug messages.
> >
> > Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
> > Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> > Changes in v2:
> > - Changed to dbg msg
> > - Link to v1: https://lore.kernel.org/r/20250620-mcan_ratelimit-v1-1-e7=
47ee30f71f@geanix.com
> > ---
> >  drivers/net/can/m_can/m_can.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> > index 6c656bfdb3235e1f5d6405c49b07b821ddacc1b9..9f43111609d364c01c6df10=
489fc4708deab9fbb 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -665,7 +665,8 @@ static int m_can_handle_lost_msg(struct net_device =
*dev)
> >  =09struct can_frame *frame;
> >  =09u32 timestamp =3D 0;
> >
> > -=09netdev_err(dev, "msg lost in rxf0\n");
> > +=09if (net_ratelimit())
> > +=09=09netdev_dbg(dev, "msg lost in rxf0\n");
>=20
> This has some subtle side effects. Even if debugging is not enabled, you
> will still get the "... output lines suppressed due to ratelimiting"
> message, which is IMHO very confusing :)

Indeed yes :)

>=20
> What about replacing the netdev_err() by netdev_dbg()?
>=20
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -665,7 +665,7 @@ static int m_can_handle_lost_msg(struct net_device *d=
ev)
>         struct can_frame *frame;
>         u32 timestamp =3D 0;
>=20
> -       netdev_err(dev, "msg lost in rxf0\n");
> +       netdev_dbg(dev, "msg lost in rxf0\n");
>=20
>         stats->rx_errors++;
>         stats->rx_over_errors++;
>=20

Yeah that will do. V3 or?

/Sean


