Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F7F771B9C
	for <lists+linux-can@lfdr.de>; Mon,  7 Aug 2023 09:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjHGHi7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Aug 2023 03:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjHGHi6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Aug 2023 03:38:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6985910EC;
        Mon,  7 Aug 2023 00:38:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bed101b70so610597466b.3;
        Mon, 07 Aug 2023 00:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691393936; x=1691998736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKlDQ+6KryCA/4iw0V7tSUE5pap9UHCwwXY0QJsX+QA=;
        b=dTVTs7P80fSB4+OYv2fhGZLdlgPMGGgfF6PXZX24Hen2Mv8Gr2UGEHnfDxW3B4hEb5
         p6AsxViAd5gnBiUD/06S4HXpI4ouwFqnaeb8oEsZdoh0imDj4yHWmjigdDnFLXOhUa7U
         b0CMkCZUp0OzBZyFYDsT4U6IAQgwHB3fbOjkzCmRYtjfZzjstK+lCrNl0AEGjsVl+ae6
         sYa+u/mgqhlVKjcovTHpPZoyOzuQN3BRdep9LxuhM71YPOHUPBgzUiHX7GLvhC+Rzq2z
         bZmO8+nsMKSv83G3IqJzC24zBxQvM0Fz3hHiNkzmaQiQniGmFkdxcvgUxuDVGE2gCEnI
         39UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691393936; x=1691998736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKlDQ+6KryCA/4iw0V7tSUE5pap9UHCwwXY0QJsX+QA=;
        b=NXDS+dKPrinCnKJTJL503cX4Atyla0wFHqICTsa8q3Q3GzPuqyxuRyX4kPTtdl7dok
         zeIyuZuHRWwv4Vgrh85Hz78Di75xeNqeM+ESxkpmb3TJCmMN4yJE4EHExfs/9Fp+y8Wl
         mQ86Yxo1kcrzoMAhTsglzGnwxvag5kcOIpaF6X2UjNc+AJJ7tDe5evOQj0+oAT14aPXX
         DRM5RBYhfu1H+O0nacCjw0Kd+27pnAgePrGQoEAVbjvuOFXORWjT59sxiGa8gIe6hSnq
         nfmAWbRmStAiKblSwiUBW/z7ZkuGg7Z8STFil9aMVYuwIC2C9OjVPKifm9bV4EpnK4di
         MRoQ==
X-Gm-Message-State: AOJu0YxIR6CFDoHWSCr8Bbvje9ZXxxlWorrxTvLFMWCacoLFQtm1zTmU
        jrqqi+y7gMFauW5h4mmFFidQibg5jvX8Og==
X-Google-Smtp-Source: AGHT+IHYGcnDyV/Muvy86Soo94JJb+xzGrEkQtOMDdzz0rNl5dBhCgGm8XGGc/NPrqAwmxP6+t2xeg==
X-Received: by 2002:a17:906:74d1:b0:99b:d1cb:5add with SMTP id z17-20020a17090674d100b0099bd1cb5addmr7546617ejl.35.1691393935645;
        Mon, 07 Aug 2023 00:38:55 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id r16-20020a170906a21000b00988b8ff849csm4782399ejy.108.2023.08.07.00.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 00:38:55 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     John Watts <contact@jookia.org>, kernel@pengutronix.de,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] Revert "riscv: dts: allwinner: d1: Add CAN controller nodes"
Date:   Mon, 07 Aug 2023 09:38:54 +0200
Message-ID: <2644763.X9hSmTKtgW@jernej-laptop>
In-Reply-To: <20230807-riscv-allwinner-d1-revert-can-controller-nodes-v1-1-eb3f70b435d9@pengutronix.de>
References: <20230807-riscv-allwinner-d1-revert-can-controller-nodes-v1-1-eb3f70b435d9@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Dne ponedeljek, 07. avgust 2023 ob 09:28:50 CEST je Marc Kleine-Budde=20
napisal(a):
> It turned out the dtsi changes were not quite ready, revert them for
> now.
>=20
> This reverts commit 6ea1ad888f5900953a21853e709fa499fdfcb317.
>=20
> Link: https://lore.kernel.org/all/2690764.mvXUDI8C0e@jernej-laptop
> Suggested-by: Jernej =C5=A0krabec <jernej.skrabec@gmail.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 30
> ----------------------- 1 file changed, 30 deletions(-)
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
> ---
> base-commit: c35e927cbe09d38b2d72183bb215901183927c68
> change-id:
> 20230807-riscv-allwinner-d1-revert-can-controller-nodes-65f62e04619c
>=20
> Best regards,




