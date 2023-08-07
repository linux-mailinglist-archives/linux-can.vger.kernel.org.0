Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D41771BC5
	for <lists+linux-can@lfdr.de>; Mon,  7 Aug 2023 09:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjHGHss (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Aug 2023 03:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHGHsr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Aug 2023 03:48:47 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED3E10F4;
        Mon,  7 Aug 2023 00:48:46 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5230df1ce4fso5623536a12.1;
        Mon, 07 Aug 2023 00:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691394524; x=1691999324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UL0o1cj/eei8y+uTEs2qS6VJnF3fAnQeBKOVacn3Q4Q=;
        b=iWTf28EwFL4bcyx/zmeKYHCNmHco2o7a6UKB/Wamqc5c2THNEO+JgxLSfuqWwPgdqF
         eSRRHaYmRPEZfhEHdez2J6fWmcEXOZgu/Bj0LRYpin5zZyrYnJmcH3Mmc7bnrYFicazK
         +c8R9Znb2uqlH/MVukhx+b8YUpKM8jPcGIYVDR0iIzuzm4eVOy4Bz+7Zal08ZyV3LPQV
         QCzEZ9wwbaZXlPm+eZBDwG5Z7KfDzDRzxzD2czOxB7IeQwDBPEmd30tpY5JSmVN9/RtI
         +ZblUYgOuPKDN+rbJz/jeokXikzhO4+ov5kqp7yP3HyveveOY6yrfOUNebFWEhsCP5OP
         VlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691394524; x=1691999324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UL0o1cj/eei8y+uTEs2qS6VJnF3fAnQeBKOVacn3Q4Q=;
        b=IJvjSNsSirOM4yioqaokA1UtpbsefvGaeyTULT3soANAfjuC07GmoOj2Vtb4vTot24
         LFdzm0IdeE6b6grbjdbX+aUJ8e851UoI12dwczAcdW6zZkf8BfJnOcffa723d6UZOFSi
         tdVzAYjq6MkM5V70oI15jeDqL261lJdKUKkX8WWhdVExqzy+bLLHEK4fsQ82Z/WzAyyj
         eVblY4rgXV1iZpYM6xK87i6KEQdC0eAsoNAyLOurjgW+X4kAEaME/5wIHgel7T9qjb20
         l7kWORgqiglmRnR5QJphabRiGORyT+wsMSg6N67U71jtHZ88F0pvJBzbNpP6uXKIDJGL
         PHew==
X-Gm-Message-State: AOJu0YyM2WYYQgy4LkojOA4jY9dMDyG+Q78qxKxi4ZPvyeeV7zRdnUzL
        8tbYhTo04L2UxqTTny+p72yrc6slheBgYA==
X-Google-Smtp-Source: AGHT+IHTM52GLRJtykHMDtgCgqzdXSmtfm1DDvxR1P2wGTX+NS22tLRqCh3Sl57SgauYCgTVRh5ckQ==
X-Received: by 2002:a17:906:109:b0:99b:dfd7:b0d3 with SMTP id 9-20020a170906010900b0099bdfd7b0d3mr7053794eje.56.1691394524381;
        Mon, 07 Aug 2023 00:48:44 -0700 (PDT)
Received: from jernej-laptop.localnet (APN-123-242-229-gprs.simobil.net. [46.123.242.229])
        by smtp.gmail.com with ESMTPSA id v14-20020a17090690ce00b009893b06e9e3sm4826315ejw.225.2023.08.07.00.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 00:48:43 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH net-next] Revert "riscv: dts: allwinner: d1: Add CAN controller
 nodes"
Date:   Mon, 07 Aug 2023 09:48:42 +0200
Message-ID: <2690985.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20230807074222.1576119-2-mkl@pengutronix.de>
References: <20230807074222.1576119-1-mkl@pengutronix.de>
 <20230807074222.1576119-2-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Dne ponedeljek, 07. avgust 2023 ob 09:42:22 CEST je Marc Kleine-Budde=20
napisal(a):
> It turned out the dtsi changes were not quite ready, revert them for
> now.
>=20
> This reverts commit 6ea1ad888f5900953a21853e709fa499fdfcb317.
>=20
> Link: https://lore.kernel.org/all/2690764.mvXUDI8C0e@jernej-laptop
> Suggested-by: Jernej =C5=A0krabec <jernej.skrabec@gmail.com>
> Link:
> https://lore.kernel.org/all/20230807-riscv-allwinner-d1-revert-can-contro=
ll
> er-nodes-v1-1-eb3f70b435d9@pengutronix.de Signed-off-by: Marc Kleine-Budde
> <mkl@pengutronix.de>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 30 -------------------
>  1 file changed, 30 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi index
> 4086c0cc0f9d..1bb1e5cae602 100644
> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> @@ -131,18 +131,6 @@ uart3_pb_pins: uart3-pb-pins {
>  				pins =3D "PB6", "PB7";
>  				function =3D "uart3";
>  			};
> -
> -			/omit-if-no-ref/
> -			can0_pins: can0-pins {
> -				pins =3D "PB2", "PB3";
> -				function =3D "can0";
> -			};
> -
> -			/omit-if-no-ref/
> -			can1_pins: can1-pins {
> -				pins =3D "PB4", "PB5";
> -				function =3D "can1";
> -			};
>  		};
>=20
>  		ccu: clock-controller@2001000 {
> @@ -891,23 +879,5 @@ rtc: rtc@7090000 {
>  			clock-names =3D "bus", "hosc", "ahb";
>  			#clock-cells =3D <1>;
>  		};
> -
> -		can0: can@2504000 {
> -			compatible =3D "allwinner,sun20i-d1-can";
> -			reg =3D <0x02504000 0x400>;
> -			interrupts =3D <SOC_PERIPHERAL_IRQ(21)=20
IRQ_TYPE_LEVEL_HIGH>;
> -			clocks =3D <&ccu CLK_BUS_CAN0>;
> -			resets =3D <&ccu RST_BUS_CAN0>;
> -			status =3D "disabled";
> -		};
> -
> -		can1: can@2504400 {
> -			compatible =3D "allwinner,sun20i-d1-can";
> -			reg =3D <0x02504400 0x400>;
> -			interrupts =3D <SOC_PERIPHERAL_IRQ(22)=20
IRQ_TYPE_LEVEL_HIGH>;
> -			clocks =3D <&ccu CLK_BUS_CAN1>;
> -			resets =3D <&ccu RST_BUS_CAN1>;
> -			status =3D "disabled";
> -		};
>  	};
>  };
>=20
> base-commit: c35e927cbe09d38b2d72183bb215901183927c68




