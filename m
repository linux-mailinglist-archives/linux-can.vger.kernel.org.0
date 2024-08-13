Return-Path: <linux-can+bounces-1192-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA78950B43
	for <lists+linux-can@lfdr.de>; Tue, 13 Aug 2024 19:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A1C1C223E9
	for <lists+linux-can@lfdr.de>; Tue, 13 Aug 2024 17:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E46B1A0710;
	Tue, 13 Aug 2024 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClJKROuA"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17013D38E;
	Tue, 13 Aug 2024 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569257; cv=none; b=Zm116XSnsZpoON1L6/swfAcGIF0JMT5K7JSLsnsYtaOqg5XfMVNQr4LYU7uDD7kXgeVc4iOcHONqznOPR0ySaTebBgY01JquD64BLRx77CvglfTkqqTLM6wl/2ZiDhfXhZ4RSwe4TA0JyxWTn9OzcLMv3sEBDoiRPDc2FyVnGJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569257; c=relaxed/simple;
	bh=jvOeIXVgGCt6WRfdXqI7flO0Leqov1TGs9XNO326Xhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjSzzwNioiijInXK85V34IgW5Pg7k0oH0+P6asl8A1FmItbIepqqVlrNmpYIssJoIR9ofwBD0AM1mkhWwWdtBvGAhjp+cVxmfiWDeGFYxZzFjnpZPEytQ0NEsUHX1yaaWA1+9T9/L7j/cUUKsC8j+WP5ZCeHKxRm1CLgdwuBnNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClJKROuA; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-39b3c36d247so23525365ab.3;
        Tue, 13 Aug 2024 10:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723569255; x=1724174055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XnQW8pYG6LCHnllh5P1GTODS6+I9/wuKSdiLV/Ktwcw=;
        b=ClJKROuAcO2jJszujhIqLe9xDSulexPrb8L+uP/6e0+h9THQtx8bbifqG316176Enh
         CTkswP2djC05rGJLS/RHb01hKPNa9eVrWt181I9/m942Slw6cQyyayIPRaWwdVUtx1H8
         jHC1Cf/T8xAgZLFOeHXt3AdOH59vHwNI4Acz0NmUox3EG4ocuyln4Z2a761Va28Vr1Bl
         IizecJHj/lHenhoNakwfHa3AJGmtg3jZElOM1GfxJjlyJ3orzRhxspNndQdrXrjt3V1d
         A7gcP+8K96fxnPCRlcoArcOEAXptnTFHJx08tedgCbFtXcRkCxBWg5wUDZiYJFO69fNG
         xKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723569255; x=1724174055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XnQW8pYG6LCHnllh5P1GTODS6+I9/wuKSdiLV/Ktwcw=;
        b=NHOzrhP9Ri/Iyd7JPeHWmVNSB6PrNvbrae82onl6sRJSFetgBEyKCaFktOdGZjQRVO
         Qe9UtEEwcAxOvpYghtmBSbBLBCG/R5nOduc3VSinwxS6jY6N+1IM2xT/ZhKbwGgA0DPT
         dJ2YZO7ug8QoOoA4Iabeydi3AR74eKl0xWu/mcKw9+4UcIcox6JnV06wmtvWbaiKtHBA
         bATSPSQdbuztMIbKthkdWHG/xocfFyFp6DJwJFgM6hcYEfYojCQRr3fKYVRftF1UOo3T
         OqMrzsAyPu44LkS1XyvkxEXfplO/MmBi3Pn8CrUEHCD4AhHgMu4l5B2a2mEWHWzvsQDs
         F9dA==
X-Forwarded-Encrypted: i=1; AJvYcCU5lG8l2DZt8/LE2IRgvV1jd4vIxL8dp99xF1S9GcGkmwreg4NSl6AjcJUX5Sb3+m9hpTCczlamG9hfT/MLZB5NElIjYcQbyhGEFPdVdqaHaKPXprrldQ2Bc/7imsk00igJIh6MRA==
X-Gm-Message-State: AOJu0YwStwTUiOR35LGI4CpjGsPN/O8Z+cim8h4iTvkEs+uQuOKualy8
	cc7mcBg9P25ukC07YSeV+YC6H6q+Q/wqYK3pNau/bvnr63vUMabK51QiLtMphjaTJLUzDuuk1d3
	KIexMNBCyntocIqb1D/dFmI4s/aQ=
X-Google-Smtp-Source: AGHT+IE1SEdB2S6FPvLqmHpU+NfPOzND/hei07NGJ6SnXJB1C3ScxKKZcSU1n+qObrhFw1qzFXpNI0UnKg5i8mH7VNU=
X-Received: by 2002:a05:6e02:184b:b0:383:6af0:eb0d with SMTP id
 e9e14a558f8ab-39d124c3641mr4830845ab.26.1723569254595; Tue, 13 Aug 2024
 10:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <56a52c81-68de-438d-94ae-9decc799d824@kernel.org> <20240808191735.1483572-1-ilordash02@gmail.com>
In-Reply-To: <20240808191735.1483572-1-ilordash02@gmail.com>
From: Ilya Orazov <ilordash02@gmail.com>
Date: Tue, 13 Aug 2024 20:14:03 +0300
Message-ID: <CAGCz5Hk=mSjQ1eFWstQQu=JZUkavJ_mRhnp8DRELUXP_syq4Zw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip ATA6561
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Aug 2024 at 22:18, Ilya Orazov <ilordash02@gmail.com> wrote:
>
> Microchip ATA6561 is High-Speed CAN Transceiver with Standby Mode.
> It is pin-compatible with TI TCAN1042 and has a compatible programming
> model, therefore use ti,tcan1042 as fallback compatible.
>
> Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
> ---
>  .../devicetree/bindings/phy/ti,tcan104x-can.yaml    | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> index 79dad3e89aa6..4a8c3829d85d 100644
> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -14,10 +14,15 @@ properties:
>      pattern: "^can-phy"
>
>    compatible:
> -    enum:
> -      - nxp,tjr1443
> -      - ti,tcan1042
> -      - ti,tcan1043
> +    oneOf:
> +      - items:
> +          - enum:
> +              - microchip,ata6561
> +          - const: ti,tcan1042
> +      - enum:
> +          - ti,tcan1042
> +          - ti,tcan1043
> +          - nxp,tjr1443
>
>    '#phy-cells':
>      const: 0
>
> base-commit: 6a0e38264012809afa24113ee2162dc07f4ed22b
> --
> 2.34.1
>

Could you please review my patch?

I hope the new patch version hasn't been lost in your inbox. Thanks to
Conor, I understand now that sending new versions as a reply wasn't
the best approach. I appreciate your time and feedback.

-- 
Best regards,
Ilya Orazov

