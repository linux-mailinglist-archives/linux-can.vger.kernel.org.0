Return-Path: <linux-can+bounces-5859-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DB3CB8A88
	for <lists+linux-can@lfdr.de>; Fri, 12 Dec 2025 11:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66F643007225
	for <lists+linux-can@lfdr.de>; Fri, 12 Dec 2025 10:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAC330FF08;
	Fri, 12 Dec 2025 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvgDn2ys"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8292319600
	for <linux-can@vger.kernel.org>; Fri, 12 Dec 2025 10:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765537120; cv=none; b=I/NmviV3Q+124feEJ3LxoQr6Y1B2PAYXlEMIggPMhaYodAB6sUssGsgQpOJI+bwJFkjeJcpAPlUlQTIHT5d8PjvlokD44JfAoJyiWhyPmGGCRfEViK+h5SfZESCSpzQYQnzRk9ASGCIkw0eWu6rvmlklqLd/tHOLrtQmU5TETso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765537120; c=relaxed/simple;
	bh=WqXxoSqrDnwsvdO/PSfoKvUqgPvzTsDKzE39KogF71s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEuXWilwJHLHw6thfGYpcKKhdnvHsa6nXQuFQHYHuRmOsmzeJ+xbDptXoWVyjVrptxh8lTMFtQfNKaYJt+CNAnrpUyUs1RX4Pg74CplzwqtloHtO97EXeIkPArsRRWrnpbn1FmYrNbkEgovp2DQqUVcd6SgjKr2SfJp8EFS60uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvgDn2ys; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42e2e40582eso644274f8f.1
        for <linux-can@vger.kernel.org>; Fri, 12 Dec 2025 02:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765537117; x=1766141917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqR+IQTeub3ZkC8GS6Wk65+OamU6y/VpkmKlXNe7HxQ=;
        b=lvgDn2ysJzd39XPqVSstpGi+diianBQxBqw6zBAmxTHcLYzASsB+DmCYp1eD2GeaWX
         z/5vK+XhzkDmVaxIqK/IaoqPPcuC1wxB8Wmi61huhdFulcrj7rYJ+fUhpcC6/zEq2tCf
         EdDOWbAVbT2bVA7x1K/R79OGoz5Qg51+ojBpTi+R/PP8rd1g07yu1/zzUuXPSdiJ7eyw
         UZPx8+fpJyLtWfoghz9zk8o1GSnVx4gXdbtn54v1dtl3YH5i2jd0Ua8CDa2CVhlB0+NF
         wB8Ge06OxeYpywcbcXSqd+jJWeNGGJqMnrL5MH+QenmgwWWGF8hDHODj0TSx2DfhXWG8
         10UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765537117; x=1766141917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HqR+IQTeub3ZkC8GS6Wk65+OamU6y/VpkmKlXNe7HxQ=;
        b=WNdoh0JoL0W/9n4eSCwqH+uwuXdF9D6Psqf9NVWhCPlinwEvUyo467dOcY6YS5XU+3
         JR92eNj18+26Icz8LlbbVZr/3P1bnvg5/+8GuJaSCFmBwhUm/S9LMZ4HAeU0LMUBgZhh
         xIRJYwDxkl5Nfbv+BbygSJE+G+zp5Z5gtUmmyhzxqNIEo0Q7Lj0xMyupQ6OTtRbwEU7D
         SS2rXUyJCwg2rBaj/bYdrF5ixNLB7vG22MiF9eodO1xIoM8x3EzubRQAxj+9FciGKOxN
         54dgGKH6WigPvNUGu9QKIAQSvX2/k0fyN4z6geneDjeEdVo69gcmoFcsVMJUwT7zLR+n
         iCcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrlo51lnCXeBlKlujF85AdRqt6revGViPR0khekG4GoauY2Av2mRmqtPtdD4FILKPUveZLOCzRX80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOUscWRRSTzjtgmSvs40ovTbjdqpaXx7uL5U7JliNKdm97LrfX
	mx/uXqlV6fpdm8wlrPa+ClVjLJ27NVI5jpgjx/D/k6GqtFqWCT/xPm2TKDbo4XaLeA8ZFAIF3CH
	MZgXAYTxaOXPXgcIjcPX9lwA/2fF6X5o=
X-Gm-Gg: AY/fxX7NRZzDbA/0AQCjROPqzu/WjKl95WY8LInJAYeNDzmq31XE1dk7iro1P8PFQV5
	AvYFw2Vv2BKbOIQtZoaxQXTSTzb0bZHahIzs655HHa6fU/3La6SKpu6UMYK8vVHhS0iirpsq+F+
	XV7NO9SNb91L6fCKh3e7SXD/Pg1KQe7xAoktL5IDKB2c5n+78sJAwV8FhHx4u3W8EhQoS9gbjSV
	0I9jEyMsKfefhUNCooQPOU3QzNyUJfbk7bBP+szvTqQt0PjC37D4jFBI6aC+76rDu40IfasdnsU
	otBBTVxgWyzHCYPrPWrmFj3mF14=
X-Google-Smtp-Source: AGHT+IE+ahrc04Q/jrdoppQwasQ4J1Y0Y9w6+KHjcQu1lJlaMpy7m90wwcJKrOJXxvNDcByIW5d1baSzOlJ31jhyAq4=
X-Received: by 2002:a05:6000:186d:b0:3eb:c276:a347 with SMTP id
 ffacd0b85a97d-42fb42bb935mr1529919f8f.0.1765537117044; Fri, 12 Dec 2025
 02:58:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209162119.2038313-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251210-mauve-cow-of-hurricane-0f969d-mkl@pengutronix.de> <20251210-persuaded-rewire-8ac93b0cc039@spud>
In-Reply-To: <20251210-persuaded-rewire-8ac93b0cc039@spud>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 12 Dec 2025 10:58:11 +0000
X-Gm-Features: AQt7F2qVBwHpP3VeypyTa021PRhJeO9lvQ2ybqJTDVdXUznY1gpLQoN1_DLtzFc
Message-ID: <CA+V-a8sUPin=r=x6TVvyazqxwfDwW+RsnOfHaTJf1N-VpAPE7g@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: phy: ti,tcan104x-can: Document TI TCAN1046
To: Conor Dooley <conor@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aswath Govindraju <a-govindraju@ti.com>, Frank Li <Frank.li@nxp.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Wed, Dec 10, 2025 at 6:21=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, Dec 10, 2025 at 08:52:58AM +0100, Marc Kleine-Budde wrote:
> > On 09.12.2025 16:21:19, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Document the TI TCAN1046 automotive CAN transceiver. The TCAN1046 is =
a
> > > dual high-speed CAN transceiver with sleep-mode support and no EN pin=
,
> > > mirroring the behaviour of the NXP TJA1048, which also provides dual
> > > channels and STB1/2 sleep-control lines.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> > > ---
> > > TCAN 1046, https://www.ti.com/lit/ds/symlink/tcan1046v-q1.pdf?ts=3D17=
65297159307&ref_url=3Dhttps%253A%252F%252Fwww.ti.com%252Fproduct%252FTCAN10=
46V-Q1
> > > NXP TJA1048, https://www.nxp.com/docs/en/data-sheet/TJA1048.pdf
> >
> > The polarity of the standby line of the chips is different.
> >
> > You must set the correct active high/low property for the GPIO, as the
> > driver uses logical levels.
> >
> > Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> What you're saying seems to contradict the tag you've given, is a
> fallback really suitable if the standby polarity is not the same?
>
On the RZ/V2H I have,

    can_phy: can-phy {
        compatible =3D "ti,tcan1046", "nxp,tja1048";
        max-bitrate =3D <8000000>;
        #phy-cells =3D <1>;
        status =3D "okay";
        standby-gpios =3D <&pinctrl RZV2H_GPIO(7, 0) GPIO_ACTIVE_HIGH>,
                                  <&pinctrl RZV2H_GPIO(7, 2) GPIO_ACTIVE_HI=
GH>;
    };

When the CAN interface is brought up 0 is written to GPIO which brings
the CAN transceiver to Normal mode  and when the CAN chip is brought
down `1` is written to GPIO and it puts the CAN transceiver to Standby
mode. Which matches to the behaviour of TCAN1046 CAN transceiver. Am I
missing something?

Cheers,
Prabhakar

