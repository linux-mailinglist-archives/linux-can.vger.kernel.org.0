Return-Path: <linux-can+bounces-5830-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B706CADB43
	for <lists+linux-can@lfdr.de>; Mon, 08 Dec 2025 17:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0E9030542E9
	for <lists+linux-can@lfdr.de>; Mon,  8 Dec 2025 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B487280324;
	Mon,  8 Dec 2025 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avNpNCvH"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CC0262FE7
	for <linux-can@vger.kernel.org>; Mon,  8 Dec 2025 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210151; cv=none; b=TEF7NNKAIBm7qU4GsGSlGl0tMbL8m1BZH5jeT7CG5wpiWhftyvzlS3gWXLVjp0+v3BSjGAKm8U22afPpAOE/bUqk0gRI5kcyuMOJFPzLc2MttB/MV/uAdv7HL9vK+FKMfry8S3kivV//tii/QV8ThU3NcgtbpqrG6aEU+c3+JzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210151; c=relaxed/simple;
	bh=RL5vla2iBJ25HcdaV0uhE6Ky6hIMB/opH7o7VaRBVYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Atk9i8cehulawcLqb1eoJBt7/JmbLrnovRL/lKcdDT4Qee7RxNognm/CLQAiYotqi92Do9ToELfIZGiGekEfX7G6Qq9ECGESX3Mw6TjvvpChPeVMy90GbB223ZS4SY57Im+bqQJhUOBcIjd24S3mf+GFyOdVq7rjEgmag4FQ57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avNpNCvH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477b91680f8so52001085e9.0
        for <linux-can@vger.kernel.org>; Mon, 08 Dec 2025 08:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765210147; x=1765814947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zdjba8hBGxOnTGFRvhD4ykuH5Qe1xLO/Pwcd0PhJxyk=;
        b=avNpNCvHqRiV+/Iwnskrm8yUjLgHSA5C339cM7aO/C/+Rv/yr41JqZ+ocj6N6flIX0
         ewLIf+k+eTmsPLJ8MxXI7FS/2V9BSmjyWSGOX/VSj1uFgEpzi6+yHhzvxZSWWBjmKTqw
         sgSmUrSLKpT53ewhfc1BdHea7/dCtL+SAya+ccB3DofQTHu8U3scS+T28drtFgfZywdT
         cf56ji/hN1fEOHelsZ7O6fjD4/fDYcqEtWM3nfEGXC1Pt9X+Va54ovjGoTd5EGSo5mfn
         DIj187i7z9GCyJaNpCdPR6+TNNwMhZRBCeUBVui3E7srqZRj6pL6/t4ofwY/Fmrjcs4D
         jvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765210147; x=1765814947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zdjba8hBGxOnTGFRvhD4ykuH5Qe1xLO/Pwcd0PhJxyk=;
        b=Rva3Mgt50N87sjMUUmcecyE5XvtKBQu503yoMsVAcPHGs1XXO+gU1P9s7D2KoejH8l
         s2lkS0LmtZaswlgl+sRSK+hLtyK2nR7bWDIPbUhZ60q/YcBq048feSCADrzpjefQmMOC
         O44aNCGtc0SlVuJH5gegDRdzr+EYZJ0CqefCJZ9er0x4PmON6UqidlTRgDykunOuQkGj
         rgCK3EW/+OLw4WaigfeaPNNNYSVwIwUrt4dwRjqDBzitGLth5R203NVWMqOtbxtV3Sjq
         qpT/qJzMGZz8b8/CxfCWjYY8GTEvm1lF+BhMkaB2dZ+kvyitjneoSIyj2gewME8WBq6W
         bvwA==
X-Forwarded-Encrypted: i=1; AJvYcCWCcep6PGdM1yTJ/njaN4iWTCDnc3hGxWD2NYyHZmbaTL2+rOZwim0W8Y079lF4004OVOwNMPLgfcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDIHpu+AutihwP+h4yvgBvYb+CuE97n5YJwrcOMiyxkRa36Wpp
	AsbnycehaAVvD1YB7bDGVE79pAau+5iYpq4WYvLmoOXNLv/RaD1ueBRii/LhZWmliVYeEYEttfQ
	5IwdxokS65p1z3pqxTnLR9rPnpdQubgw=
X-Gm-Gg: ASbGnctRWCrfjAfd8/sWr7HU4It8jPiBBnYDPe+QT0Qf/K1Tp1jOjNTvrhj/pCTIdWT
	lL/K3d0JsKKbBC4CwjA2EpkytSofd61TfTRGBAA61ZA9IkU6upZS9dHAbZKWeHn9zniMr93NZUw
	KgU2nbgnbbok3Q+h2UOqcSSiTFP6xs5UsNMWWu8vvULHMfWH47VDK46oImjfkp2CM5xd79UdM+M
	3YojhcnnilLlS2uQJyw5I5GUAoWimF0oTDi6H4qdZ5Jj4dDct2mNQPZ1k1PHXXnfLiwBe5z9gO3
	UtALDnLlsPM+v2vcpjlzKOU4tLQ=
X-Google-Smtp-Source: AGHT+IFOBf4kYlCOHQII/gMObV81xnIfGWW6V1LWfsU0I+KfwhAEK2mqEfxsYfyiN0pXHwrxrO9b8QclmlUqc870Mt4=
X-Received: by 2002:a5d:5f95:0:b0:3e9:ee54:af71 with SMTP id
 ffacd0b85a97d-42f89f1703emr8908100f8f.12.1765210147178; Mon, 08 Dec 2025
 08:09:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208155019.136076-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251208155019.136076-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <aTb2MuGSZvp9d0Al@lizhi-Precision-Tower-5810>
In-Reply-To: <aTb2MuGSZvp9d0Al@lizhi-Precision-Tower-5810>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 8 Dec 2025 16:08:41 +0000
X-Gm-Features: AQt7F2r5YSD8A41drLddmPekNoFw0-x2T7kYVaWOfrZad_IV3a03vwBr52GNX_E
Message-ID: <CA+V-a8tuP-C_0=atz0WXtw2mqNfjsaYCkDdsQE3QwyhFWTSSJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document TI TCAN1046
To: Frank Li <Frank.li@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aswath Govindraju <a-govindraju@ti.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frank,

Thank you for the review.

On Mon, Dec 8, 2025 at 4:01=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Mon, Dec 08, 2025 at 03:50:18PM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Document the TI TCAN1046 automotive CAN transceiver. The TCAN1046
> > provides dual high-speed CAN channels and includes STB1/2 control
> > lines.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml=
 b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > index c686d06f5f56..c53c4f703102 100644
> > --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > @@ -23,6 +23,7 @@ properties:
> >        - enum:
> >            - ti,tcan1042
> >            - ti,tcan1043
> > +          - ti,tcan1046
>
> according to patch2, which is the compatible as nxp,tja1048. why not allo=
w
> ti,tcan1046 fallback to nxp,tja1048.
>
> So needn't change driver code.
>
Agreed, I'll do this change and send a v2.

Cheers,
Prabhakar

> Frank
> >            - nxp,tja1048
> >            - nxp,tja1051
> >            - nxp,tja1057
> > @@ -84,7 +85,9 @@ allOf:
> >        properties:
> >          compatible:
> >            contains:
> > -            const: nxp,tja1048
> > +            enum:
> > +              - ti,tcan1046
> > +              - nxp,tja1048
> >      then:
> >        properties:
> >          '#phy-cells':
> > --
> > 2.52.0
> >

