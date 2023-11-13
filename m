Return-Path: <linux-can+bounces-15-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D47E7E9D2E
	for <lists+linux-can@lfdr.de>; Mon, 13 Nov 2023 14:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8D8280CEB
	for <lists+linux-can@lfdr.de>; Mon, 13 Nov 2023 13:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B5920309;
	Mon, 13 Nov 2023 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="MetA3/Tq"
X-Original-To: linux-can@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94920200CB;
	Mon, 13 Nov 2023 13:31:30 +0000 (UTC)
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AB0AF;
	Mon, 13 Nov 2023 05:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=MIME-Version:Content-Transfer-Encoding:Content-Type:
	References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/i7Gul/5kLAcXXIbacRf1/dns4r84n9fAaRE9oWxEAI=; b=MetA3/TqYwKyRbh9ykc5/z6vij
	EzdZ4qYzBfVnr3TvzFqiHhqH528mYv0NelqVcMy33yUWHVM9K5OoHLCWqx7YVSVgJDF5mJEUmrcFl
	VsWXOSVfbm/aBNZAGCirlkUwwR7hOLDBiLuf7NS7++KPgJwoHfBkxVV8Nqvke1QyXYN9fS/FO31uI
	Lf+FjxxVVjahf3/9s0xmUvcdJOmTZwt+4e4lg66YP+F0EyO0C7odlKhiY0oAQ4ACScW8gJL9v5ULZ
	FaYQnuYEsjpq0n0Pae6Sb5MRZdb1L0V8j6Lik3yv4wzUgaQh318LB5RZvOohErf2cqOcepTRX5mFU
	OqkxGBhg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1r2X2A-000AXK-9y; Mon, 13 Nov 2023 14:31:22 +0100
Received: from [85.184.138.13] (helo=[192.168.8.20])
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <martin@geanix.com>)
	id 1r2X29-000KaS-GF; Mon, 13 Nov 2023 14:31:21 +0100
Message-ID: <33102cbb65e24c5c17eda06ce9ac912a91f8d03c.camel@geanix.com>
Subject: Re: [PATCH v6 00/14] can: m_can: Optimizations for m_can/tcan part 2
From: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, Chandrasekar Ramakrishnan
 <rcsekar@samsung.com>, Wolfgang Grandegger <wg@grandegger.com>, Vincent
 MAILHOL <mailhol.vincent@wanadoo.fr>, Simon Horman
 <simon.horman@corigine.com>,  "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Julien Panis
 <jpanis@baylibre.com>, Judith Mendez <jm@ti.com>
Date: Mon, 13 Nov 2023 14:31:20 +0100
In-Reply-To: <20231113-mastiff-confetti-955bda37a458-mkl@pengutronix.de>
References: <20230929141304.3934380-1-msp@baylibre.com>
	 <0c14d3d4372a29a9733c83af4c4254d5dfaf17c2.camel@geanix.com>
	 <20231113-mastiff-confetti-955bda37a458-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27092/Mon Nov 13 09:38:20 2023)

On Mon, 2023-11-13 at 14:30 +0100, Marc Kleine-Budde wrote:
> On 13.11.2023 14:25:37, Martin Hundeb=C3=B8ll wrote:
> > On Fri, 2023-09-29 at 16:12 +0200, Markus Schneider-Pargmann wrote:
> > > Hi Marc, Simon, Martin and everyone,
> > >=20
> > > v6 is a rebase on v6.6. As there was a conflicting change merged
> > > for
> > > v6.6 which introduced irq polling, I had to modify the patches
> > > that
> > > touch the hrtimer.
> > >=20
> > > @Simon: I removed a couple of your reviewed-by tags because of
> > > the
> > > changes.
> > >=20
> > > @Martin: as the functionality changed, I did not apply your
> > > Tested-by
> > > tag as I may have introduced new bugs with the changes.
> > >=20
> > > The series implements many small and bigger throughput
> > > improvements
> > > and
> > > adds rx/tx coalescing at the end.
> > >=20
> > > Based on v6.6-rc2. Also available at
> > > https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-optimization=
/v6.6?ref_type=3Dheads
> >=20
> > For the whole series:
> > Tested-by: Martin Hundeb=C3=B8ll <martin@geanix.com>
>=20
> On which hardware? On an mmio mapped m_can or the tcan4x5x?

tcan4x5x on a custom iMX6UL.

Sorry for mentioning it.

// Martin

