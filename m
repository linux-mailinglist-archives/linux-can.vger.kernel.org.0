Return-Path: <linux-can+bounces-6011-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4BACFA378
	for <lists+linux-can@lfdr.de>; Tue, 06 Jan 2026 19:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47692305481E
	for <lists+linux-can@lfdr.de>; Tue,  6 Jan 2026 18:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F5C2D46A2;
	Tue,  6 Jan 2026 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7gmMuN8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F57270540;
	Tue,  6 Jan 2026 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721177; cv=none; b=AUOUjCZ6TRw6W4yS6Yqm/ssxRkBW9hsnUM31tT7uzKwOluAwGTwbaEbBEuGyCKcpFfI0soxICtJuN/c7Zu7sdOwiY93RgRUM2NXx354pT53sRAmGTysqei3p6q2WhThuh54NPc4t0BcR7cxBmjaMR024A6s/L1OiPAY0ixsDS34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721177; c=relaxed/simple;
	bh=UeQThee7Jg0GXveKVrE4HC5sJTaTObfyhIxsWJAiOhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQM/SnQtMfogDmjl/6mIyjaWkBorfM7LjehqCtnP2F/KrneN5Cy7l4MVprn91nY2/Uy1/AxAZYN7dxSFVC5eDs4MxKxhfaStP9b8iD7aAi7JmOq8NJ2FQvA3k2By8Ae6lJPOLjgulOxdEZMiEUy+IRE4n9HK8Mti9VT8BDnyeXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7gmMuN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B30C116C6;
	Tue,  6 Jan 2026 17:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767721177;
	bh=UeQThee7Jg0GXveKVrE4HC5sJTaTObfyhIxsWJAiOhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7gmMuN8anFcz7RQ7re6oQHbHF67Z98w65+9ey825G5ZzVqGaI7oDP2EXqTNWbs47
	 VrbvaZPZ5Xniw5bTLl9yT5UcCEOKqOLSB3dG8nr2ahFc5MO1W1gV3ac89vKnKZgxzu
	 5XcJZ2zFkRtjETyvD1teebQY2dLfNznR3rzrh6prhtkoK3xQyuDXaJi5pAHhRnRyrT
	 wtTqIX1VeYSlL3BA9LES3wmBK7EYGfJzIP7Uqxwi1tOWOxPGA5Q28VMOoHuz6Vkm5h
	 934f23hPxZ5Bs3fTVoCl9i6j3ummJEV7SAQ2ex+aMItu9NuXxr5ogMChwZGNs+qFNW
	 A6GJTV9a5Jhkg==
Date: Tue, 6 Jan 2026 11:39:36 -0600
From: Rob Herring <robh@kernel.org>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: can: renesas,rcar-canfd: Specify
 reset-names
Message-ID: <20260106173936.GA2345468-robh@kernel.org>
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251230115814.53536-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260102-quirky-hornet-of-downpour-ddda69@quoll>
 <CA+V-a8sY0QneUWQ4A0XCKUGPL8VYkU5NQE2h_cOK=06JG_1c2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+V-a8sY0QneUWQ4A0XCKUGPL8VYkU5NQE2h_cOK=06JG_1c2g@mail.gmail.com>

On Tue, Jan 06, 2026 at 05:17:17PM +0000, Lad, Prabhakar wrote:
> Hi Krzysztof,
> 
> Thank you for the review.
> 
> On Fri, Jan 2, 2026 at 11:16 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Tue, Dec 30, 2025 at 11:58:11AM +0000, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Specify the expected reset-names for the Renesas CAN-FD controller on
> > > RZ/G2L and RZ/G3E SoCs.
> >
> > You should explain here from where you got the actual names.
> >
> > Otherwise you got following review:
> >
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > v1->v2:
> > > - Moved reset-names to top-level properties.
> > > ---
> > >  .../bindings/net/can/renesas,rcar-canfd.yaml  | 33 +++++++++++--------
> > >  1 file changed, 19 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > > index e129bdceef84..9bfd4f44e4d4 100644
> > > --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > > +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > > @@ -122,6 +122,11 @@ properties:
> > >
> > >    resets: true
> > >
> > > +  reset-names:
> > > +    items:
> > > +      - const: rstp_n
> > > +      - const: rstc_n
> >
> > rst seems redundant. _n as well. Are these names from datasheet? How are
> > they called in this device (not the soc) datasheet exactly? Because it
> > feels you use pin or SoC names which is not useful.
> >
> rstp_n/rstc_n are coming from the SoC HW manual and is already used by
> the driver (since commit 76e9353a80e9 "can: rcar_canfd: Add support
> for RZ/G2L family"). The reset-names existed previously but were
> dropped as of commit 466c8ef7b66b "dt-bindings: can:
> renesas,rcar-canfd: Simplify the conditional schema". Let me know if
> you want me to rename them but the driver will have to maintain the
> backward compatibility or do you want me to drop this patch.

The names are fine. The above is useful information that should be in 
the commit msg. Please help us if we've already reviewed something.

Rob

