Return-Path: <linux-can+bounces-3001-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F058A54930
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 12:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DE31649E0
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516222040BD;
	Thu,  6 Mar 2025 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oFu2ZOP/"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70C019C540
	for <linux-can@vger.kernel.org>; Thu,  6 Mar 2025 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260299; cv=none; b=c948RvjHfaSW54DvD8j8oTIjYrHREuVMcvxo10hsxzvJrWMWghbrWCb9OIQMEVknkYRlypXpnuSNLCHSp/dWws0jkPVP+bdOkyX4Yi1RJKU2u9SaNH7lY27SWExoU9UOzxGlaqrLknUBG0Kp1DZAQonxOAxzht7Q9SdJVs7yDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260299; c=relaxed/simple;
	bh=Hsxu0Cen46DO8P34yAYOI0Cn+lUS9uiSDWUy4wlWcrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHup74VKpcq8bPchu82wzAkHQOtPNggAV8x9CPw+TWcPjQxjy6nXn/YkHhQOPa/oACAClE16MGwturI5wLsNYrEjSKQ6yaa5/ptg+4KqLR4cwd3y8I9p3YVMMtgaW6lIrLv4PwCfFRThAxuEV6TJBv88ZFXltaoJqrMQrcUgUcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oFu2ZOP/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e539ea490dso791165a12.0
        for <linux-can@vger.kernel.org>; Thu, 06 Mar 2025 03:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741260295; x=1741865095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PAwLX9is3aL3ULWeL+vv+ajzLUfc+N8ATyeSLCWRPJk=;
        b=oFu2ZOP/h07QRjnJPT0rHAiaJNjjf627Z1QIgcyFGznZEVTLbHueX81Q7wKEnuBsG0
         aoCc9O22oZ11kdGK+IqAYPZPQR+eIyg9q0By5SqgYPjI3qTSnZZ1GbZD4qrjFx4DqXcK
         OPKEoPmAiby2v2qSrb/bPK9MElDrT9mEbmziyKdMiah1FUl0MqHsW3OA/105DdpxRglQ
         BJaO2P/TvTo/yft0a2BUWOcE7LjdWpf4KJcV4tVTg9qO+KHZ8BNEekc2wLTQTxB1NoSN
         NoG/Tl4oZ7zM7B1U9dK31Ol/nf1K7IFkqiLYC5KOloWtPaxzPi8YPDgh/EHwLAnn9CYX
         lZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260295; x=1741865095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAwLX9is3aL3ULWeL+vv+ajzLUfc+N8ATyeSLCWRPJk=;
        b=YtkvDjmut9zr1vtpM6pJzNnlvHrRQ+QNlAz52B683OFliwE+2Vxz06Fu1ct8auv9kU
         ofeKQfByCOpW7GuzeXzqhGlGAUWwaqEXbQHGlMTXSMbI1y4vOIwRLKv1x/4ZZviRae8G
         Jf7LCG3ugU2jEGcn4XLKluCRdmNs3GaXuqGZWXWp9LsxT3MD1G1OSIvxLFq4B12XHgW5
         6E7x4PWc2odwJ/y8MIo7NpgWksg5ynFxaSef60GlNHpZxDxbRauUhUIdM57v/kEDwGJ8
         EfT0qxh9L0PjIq2dUPpYM3wST3uq/+gGUvved0x5QosdyfcFehlnGv+2vp0VhS3g2v8L
         Po3w==
X-Forwarded-Encrypted: i=1; AJvYcCUPIesbgql2kteaQ9zcdjRfDd19WjsAYIJNS1zgG0hue+mFqdXYPBs1dl3cxtzUTTriJAlJ7zDuTEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEYgEGRdgihhesBkbVeaUirzlFhIuyhc8RP5W0B23J3wpb7fde
	hksfqI2VXGs5KbPqIl+S86bjdaoKxTUgHw/O0YPu2J45w67r8hlk8CQ8M8IVqUM=
X-Gm-Gg: ASbGncu1aGY6j4tT0ng1Q7GrJqCSHGW8GOvZPNFQ09go/hZ5n/WhDqe5y5JTFJwlNZ/
	B30P9bl+pqWjhEZ34LWHSaIeBHkEcooFwLyb/qEQhuuk33NRwNW24QVxBEDdXfHipCGeDy4qW3Y
	EEMSvLvKP/uLIDqpnVJVm1rXSM+Lg9MvqL3WXDfj5KdiJSh9hW9u8yuFoNeQgNQKqAKiSNCVE7T
	GO6QpinEUoYG1SEywF5hWMDzLUBRBvTRFqOULnhoXxNLfj00RP82zpQd9X/y5eQFDabTCn7ZPBo
	9X5Z3VmWd++UJRIaajxFYA66lWU37FLt+duQvC7y
X-Google-Smtp-Source: AGHT+IHFHyx72/rUkO3YjxgA1iwqALKfUPcjawRZGk3ORB79xxVr1WX10axbXJs3pqJiVjvlnJgRwA==
X-Received: by 2002:a05:6402:5241:b0:5e5:c847:1a56 with SMTP id 4fb4d7f45d1cf-5e5c8472453mr3341954a12.10.1741260295016;
        Thu, 06 Mar 2025 03:24:55 -0800 (PST)
Received: from localhost ([2001:4091:a245:8327:7bba:546d:aa63:621e])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e5c745c552sm828535a12.17.2025.03.06.03.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:24:53 -0800 (PST)
Date: Thu, 6 Mar 2025 12:24:52 +0100
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
	Kendall Willis <k-willis@ti.com>, linux-can@vger.kernel.org
Subject: Re: [PATCH v5 00/13] firmware: ti_sci: Partial-IO support
Message-ID: <kzmgga2d64ic5dxohu4jnmwqg4t5febclzh2mg5g57ygvfkwva@jniad5zhdwg7>
References: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gnrxwuclzc4ha34t"
Content-Disposition: inline
In-Reply-To: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>


--gnrxwuclzc4ha34t
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 00/13] firmware: ti_sci: Partial-IO support
MIME-Version: 1.0

On Thu, Mar 06, 2025 at 12:14:38PM +0100, Markus Schneider-Pargmann wrote:
> Hi,
>=20
> up to last series, the Partial-IO support consisted of two independent
> series. As this last rework introduced file-based conflicts, I merged
> the mcan series introducing wakeup support into this series:
>=20
>   can: m_can: Add am62 wakeup support
>   https://lore.kernel.org/lkml/20241219-topic-mcan-wakeup-source-v6-12-v6=
-0-1356c7f7cfda@baylibre.com/
>=20
> Series
> ------
> The series contains three parts:
>  - m_can support for Partial-IO, in particular 'wakeup' pinctrl support.
>  - ti_sci support for Partial-IO, which checks wakeup-sources if they
>    are enabled for Partial-IO
>  - DT description of system states on am62, am62a, am62p and the
>    enabling of wakeup support on the starter kits that support it.
>=20
> The series is based on v6.14-rc1.

Small correction here, this is based on next-20250305.

Best
Markus

>=20
> Partial-IO
> ----------
> Partial-IO is a low power system state in which nearly everything is
> turned off except the pins of the CANUART group. CANUART contains the
> mcu_mcan0, mcu_mcan1, wkup_uart0 and mcu_uart0 devices. These can
> trigger a wakeup of the system on pin activity. Note that this does not
> resume the system as the DDR is off as well. So this state can be
> considered a power-off state with wakeup capabilities.
>=20
> The wakeup capability of a device is described in the devicetree with
> the wakeup-source property. This can hold phandles to system states in
> which the device is capable of wakeup. Additionally a WKUP_EN flag is
> set in the pinctrl of devices that are wakeup enabled.
>=20
> On poweroff ti_sci checks if potential wakeup-sources for Partial-IO are
> wakeup-enabled by the user. If that is the case, the poweroff is done
> by TI_SCI by sending a PREPARE_SLEEP message with a specific mode. Once
> sent the system will poweroff apart from the CANUART pins.
>=20
> Dependencies
> ------------
> This series requires an updated DT binding for the wakeup-source
> property that allows the use of system-states which are also being added
> in this pullrequest:
>  - dt-schema wakeup-source binding update
>    https://github.com/devicetree-org/dt-schema/pull/150
>=20
> Testing
> -------
> After enabling Wake-on-LAN the system can be powered off and will enter
> the Partial-IO state in which it can be woken up by activity on the
> specific pins:
>     ethtool -s can0 wol p
>     ethtool -s can1 wol p
>     poweroff
>=20
> These patches are tested on am62-lp-sk on linux-next.
>=20
> Best,
> Markus
>=20
> Previous versions "firmware: ti_sci: Partial-IO support":
>  v1: https://lore.kernel.org/lkml/20240523080225.1288617-1-msp@baylibre.c=
om/
>  v2: https://lore.kernel.org/lkml/20240729080101.3859701-1-msp@baylibre.c=
om/
>  v3: https://lore.kernel.org/r/20241012-topic-am62-partialio-v6-13-b4-v3-=
0-f7c6c2739681@baylibre.com
>  v4: https://lore.kernel.org/r/20241219-topic-am62-partialio-v6-12-b4-v4-=
0-1cb8eabd407e@baylibre.com
>=20
> Previous versions "can: m_can: Add am62 wakeup support":
>  v1: https://lore.kernel.org/lkml/20240523075347.1282395-1-msp@baylibre.c=
om/
>  v2: https://lore.kernel.org/lkml/20240729074135.3850634-1-msp@baylibre.c=
om/
>  v3: https://lore.kernel.org/lkml/20241011-topic-mcan-wakeup-source-v6-12=
-v3-0-9752c714ad12@baylibre.com
>  v4: https://lore.kernel.org/r/20241015-topic-mcan-wakeup-source-v6-12-v4=
-0-fdac1d1e7aa6@baylibre.com
>  v5: https://lore.kernel.org/r/20241028-topic-mcan-wakeup-source-v6-12-v5=
-0-33edc0aba629@baylibre.com
>  v6: https://lore.kernel.org/r/20241219-topic-mcan-wakeup-source-v6-12-v6=
-0-1356c7f7cfda@baylibre.com
>=20
> Changes in v5:
>  - Rebased to v6.14-rc1
>  - Merged m_can and ti_sci series to avoid conflicts and show
>    dependencies more easily
>  - Added definitions of system-states for am62/am62a/am62p
>  - Moved wakeup-source definitions into board dts files as they require
>    a bit of support on the board.
>  - Updated ti_sci support to walk through the wakeup-source phandle
>    lists
>  - Added pinctrl settings for mcu_mcan0/1 on all boards
>  - Minor style updates for ti_sci support for transfers without response
>  - Update and move the dt-binding for wakeup-source from the m_can
>    binding to the dt-schema repository
>=20
> Changes in v4:
>  - Rebased to v6.13-rc1
>  - Removed all regulator related structures from patches and implemented
>    the wakeup-source property use instead.
>=20
> Changes in v3:
>  - Remove other modes declared for PREPARE_SLEEP as they probably won't
>    ever be used in upstream.
>  - Replace the wait loop after sending PREPARE_SLEEP with msleep and do
>    an emergency_restart if it exits
>  - Remove uarts from DT wakeup sources
>  - Split no response handling in ti_sci_do_xfer() into a separate patch
>    and use goto instead of if ()
>  - Remove DT binding parital-io-wakeup-sources. Instead I am modeling
>    the devices that are in the relevant group that are powered during
>    Partial-IO with the power supplies that are externally provided to
>    the SoC. In this case they are provided through 'vddshv_canuart'. All
>    devices using this regulator can be considered a potential wakeup
>    source if they are wakeup capable and wakeup enabled.
>  - Added devicetree patches adding vcc_3v3_sys regulator and
>    vddshv_canuart for am62-lp-sk
>  - Add pinctrl entries for am62-lp-sk to add WKUP_EN for mcu_mcan0 and
>    mcu_mcan1
>=20
> Changes in v2:
>  - Rebase to v6.11-rc1
>  - dt-binding:
>     - Update commit message
>     - Add more verbose description of the new binding for a better
>       explanation.
>  - ti_sci driver:
>     - Combine ti_sci_do_send() into ti_sci_do_xfer and only wait on a
>       response if a flag is set.
>     - On failure to enter Partial-IO, do emergency_restart()
>     - Add comments
>     - Fix small things
>=20
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
> Markus Schneider-Pargmann (13):
>       firmware: ti_sci: Support transfers without response
>       firmware: ti_sci: Partial-IO support
>       dt-bindings: can: m_can: Add wakeup properties
>       can: m_can: Map WoL to device_set_wakeup_enable
>       can: m_can: Return ERR_PTR on error in allocation
>       can: m_can: Support pinctrl wakeup state
>       arm64: dts: ti: k3-pinctrl: Add WKUP_EN flag
>       arm64: dts: ti: k3-am62: Define possible system states
>       arm64: dts: ti: k3-am62a: Define possible system states
>       arm64: dts: ti: k3-am62p: Define possible system states
>       arm64: dts: ti: k3-am62-lp-sk: Set wakeup-source system-states
>       arm64: dts: ti: k3-am62a7-sk: Set wakeup-source system-states
>       arm64: dts: ti: k3-am62p5-sk: Set wakeup-source system-states
>=20
>  .../devicetree/bindings/net/can/bosch,m_can.yaml   |  18 +++
>  arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts           |  60 +++++++++
>  arch/arm64/boot/dts/ti/k3-am62.dtsi                |  22 ++++
>  arch/arm64/boot/dts/ti/k3-am62a.dtsi               |  27 +++++
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts            |  76 ++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62p.dtsi               |  27 +++++
>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts            |  76 ++++++++++++
>  arch/arm64/boot/dts/ti/k3-pinctrl.h                |   2 +
>  drivers/firmware/ti_sci.c                          | 134 +++++++++++++++=
+++++-
>  drivers/firmware/ti_sci.h                          |   5 +
>  drivers/net/can/m_can/m_can.c                      | 111 +++++++++++++++=
+-
>  drivers/net/can/m_can/m_can.h                      |   4 +
>  drivers/net/can/m_can/m_can_pci.c                  |   4 +-
>  drivers/net/can/m_can/m_can_platform.c             |   4 +-
>  drivers/net/can/m_can/tcan4x5x-core.c              |   4 +-
>  15 files changed, 562 insertions(+), 12 deletions(-)
> ---
> base-commit: 7ec162622e66a4ff886f8f28712ea1b13069e1aa
> change-id: 20241008-topic-am62-partialio-v6-12-b4-c273fbac4447
>=20
> Best regards,
> --=20
> Markus Schneider-Pargmann <msp@baylibre.com>
>=20

--gnrxwuclzc4ha34t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd8KHufh7XoFiu4kEkjLTi1BWuPwUCZ8mGAAAKCRAkjLTi1BWu
P3PjAQDt4mEbKQtVnYaQmmc3B3LmQD2DDd6V/a2t0VWHH1BtqgEArDHbE684gnnH
crTyi3FZu+K9XCPdDYdVJUKKmLJDRQg=
=yywR
-----END PGP SIGNATURE-----

--gnrxwuclzc4ha34t--

