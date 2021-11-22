Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1933E458CCE
	for <lists+linux-can@lfdr.de>; Mon, 22 Nov 2021 11:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhKVK7u (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Nov 2021 05:59:50 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:60275 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232948AbhKVK7r (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Nov 2021 05:59:47 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4D9A35806CD;
        Mon, 22 Nov 2021 05:56:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 22 Nov 2021 05:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=3
        xg1j45XvLcI9SMbIPKJaFl/VijTp7HMTsSS/iuy1cA=; b=Y9sTf+oP8fkpJIixw
        0RtMD75j0yeEm1/xuNz3gJO93e4QP6Ff0/WTSuR33OhHJzfJByRWlkJ9J4OCRSod
        QaNngJtmyfJcoeC1qQt++T4/z8+jiAMUkSTLUImajCdPPx7jVxZQn7wySi6bUamQ
        NZpRuiQWrchJWAJXlPqWMxeFkjKn+OHFufL9MfMIRbLDCC5+5kEEEeelZ2VjtWN3
        ECaG138XTJkx5XnSk9ez7v7pxl0zbX+8s49k9vChquRo93bXRlk062hfeBvoh4Mg
        5eoR2g2kvM73f0Wn7bTWW92NuhYcLW3h9z2kQK+Ebrj5TqNFOtSpWpj0b5kFuTjf
        7PR+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=3xg1j45XvLcI9SMbIPKJaFl/VijTp7HMTsSS/iuy1
        cA=; b=jweKHrMdnyrAlhWhEbgDDoMaSU4+QZULqi12xrSHhAhNgxXBWvbjsJ14a
        wXAtR3ZTW5vIaZxmG/lcbBw63rOdCec2ugdzG56K2Oj0pBoWNgSr5qCd7Rw3wvpD
        uhMEf7vpYHFd1B0V4+ZAn2CMTaojA6u2+qPXJTQOEkfE/GI75srTjyqH330Rp6xp
        n+nPRwdOgxPpNkuPzCCp/BR/e0K7FQATvq/e5Pi8FFCitw9hAUQsXxReTfnVFdZc
        BvruT8qbhtDNHVylDP+cxQ4/3I4PgKXCpsfYVuIluAQfzft2Fre0SZ+aFvSuQ7Lq
        4syLLf66QhaYtGY3+nWLhzPDu63+w==
X-ME-Sender: <xms:ZnebYayr3JZOz4v3q6rsro0nCoCOk786FdgVYkcLwZ0wC_w0jFkE6A>
    <xme:ZnebYWS8tzC-A1viLVbImGZs-XilGcwnjkuXiHyFWtUNzjPjLUaUZHAEPA-yDTc0I
    rYs3yCBkZGOvweDKRQ>
X-ME-Received: <xmr:ZnebYcVmDS1BXn9x_4dwyKSdhGwVYVCsNf10MLOdmFqeG4G4GA-e_7vIwmmHORiywA4FUYifnwDau4D5qE_O5YZU0J8tmxlr0lE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeggddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepgfejtedtjefggfffvdetuedthedtheegheeuteekfeeghfdtteejkeeludeg
    vddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ZnebYQgsiREyA7MDZxp1G74xLfddFx-Oaznjplz59njAXQl812CXmA>
    <xmx:ZnebYcCzmngL_qkXEtp1Llt0l4E5KDFXFZXsknthcYyXTIDuxPrAiw>
    <xmx:ZnebYRKlQw2r5W1LhGOXoQXn7ceIJsAIrV-98wttSo6EvnfCHg__ng>
    <xmx:Z3ebYcte4ZY3YxejotSj9DJKGMq-0sdGkjKU4O0itJZVoPWs01D_Sg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Nov 2021 05:56:37 -0500 (EST)
Date:   Mon, 22 Nov 2021 11:56:35 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: Re: [PATCH 3/3] ARM: dts: sun8i: r40: add node for CAN controller
Message-ID: <20211122105635.mmusmv5hhulvrz6x@gilmour>
References: <20211122104616.537156-1-boger@wirenboard.com>
 <20211122104616.537156-4-boger@wirenboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211122104616.537156-4-boger@wirenboard.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

On Mon, Nov 22, 2021 at 01:46:16PM +0300, Evgeny Boger wrote:
> Allwinner R40 (also known as A40i, T3, V40) has a CAN controller. The
> controller is the same as in earlier A10 and A20 SoCs, but needs reset
> line to be deasserted before use.
>=20
> This patch adds a CAN node and the corresponding pinctrl descriptions.
>=20
> Signed-off-by: Evgeny Boger <boger@wirenboard.com>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r=
40.dtsi
> index 1d87fc0c24ee..c99c92f008a0 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -511,6 +511,16 @@ pio: pinctrl@1c20800 {
>  			#interrupt-cells =3D <3>;
>  			#gpio-cells =3D <3>;
> =20
> +			can_ph_pins: can-ph-pins {
> +				pins =3D "PH20", "PH21";
> +				function =3D "can";
> +			};
> +
> +			can_pa_pins: can-pa-pins {
> +				pins =3D "PA16", "PA17";
> +				function =3D "can";
> +			};
> +

These nodes should be ordered alphabetically

Also, we should mark them with /omit-if-no-ref/ to remove them from the
DT if they are not referenced anywhere else in the DT.

Maxime

>  			clk_out_a_pin: clk-out-a-pin {
>  				pins =3D "PI12";
>  				function =3D "clk_out_a";
> @@ -926,6 +936,15 @@ i2c3: i2c@1c2b800 {
>  			#size-cells =3D <0>;
>  		};
>
> +		can0: can@1c2bc00 {
> +			compatible =3D "allwinner,sun8i-r40-can";
> +			reg =3D <0x01c2bc00 0x400>;
> +			interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_CAN>;
> +			resets =3D <&ccu RST_BUS_CAN>;
> +			status =3D "disabled";
> +		};
> +
>  		i2c4: i2c@1c2c000 {
>  			compatible =3D "allwinner,sun6i-a31-i2c";
>  			reg =3D <0x01c2c000 0x400>;
> --
> 2.25.1
>
