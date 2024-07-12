Return-Path: <linux-can+bounces-972-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32DA92F414
	for <lists+linux-can@lfdr.de>; Fri, 12 Jul 2024 04:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14DB5B20EC2
	for <lists+linux-can@lfdr.de>; Fri, 12 Jul 2024 02:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7F3BA50;
	Fri, 12 Jul 2024 02:37:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B410517C8D;
	Fri, 12 Jul 2024 02:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720751820; cv=none; b=hodWvMy7axRx0M1i1qLRz9QzMBY5aAPyhoBbSpiETZ92zIio1FFkyOSqaP+Bkukd6SoXnvT8cCZF3AbDnZmg/QDVgzRDOyXDIxjR94snWFX/dwjpdiInjc1c54oiVJQKlvBo/0r9B/7ugJTWwwvq+qIUCdkYWMvId/4Ms/RQxbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720751820; c=relaxed/simple;
	bh=LwRp7M9+Iv6W6VZqsKwMwUpkjTAA0AqCeyYcKJsUNIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2KOXNBGeArWRXR770JStYsn11pDwKVQKEi1otn82FExz06UJsko1x0l7kEW312QrrI7dZZPOsaukxAf6DVgacX5F7GRJ3M+Q6llvJ0StUqko/Y2gsslEdQe2AkqUdGFHVtGNqpaLe5U0cl2VY88GVTa25buvmu6MW9Q9wiA+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70af8062039so1281299b3a.0;
        Thu, 11 Jul 2024 19:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720751818; x=1721356618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcus94JvdaYN36pjzwcYofoNVy/FnfCuu5gLU1GImrg=;
        b=RgdP+AgycD2D3n4eouXiUxpkkEZyvBXggtnOCBMYf6MT4lO5BIivN6T6ySiomFgHni
         15t0y4wTvrjqehweN4TuBNePc2d1Q/4V+BWfo5ioQZPYYQ8mxcOUhSrhpWiU8lNAV+Ux
         BfvaBL2nFGnFByoEOKydErx9uqi9qLlEGCptkMuCTSQfoxPMFkOfpm26cWFkDfdD5Ue+
         lQtzdtokMUh/Z1Qr13oFDUSi9O6BCieT8l8UbJtKKVOhJq37wjt/s/W+P/+N1AbwVgh0
         RnWgRqIENqQqOAubRtL5v4ISbpxrXEc9bl1/a/KrCFbRmWUP4x3Korl5uLlC9Gqpn+Xt
         DvGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1V7dQVySHRu7TqQYqxOp5tElNGp/7JKVU6tv91Eq1htPB0dSEHncu0k4POyUkzbp0cFKigXLxu+pjWBX9v1PG/QM9NnGWAxigj9/nbLJNlrM9ix2WCdaJIxqullBIqCmgfHJgYqr8kFcmwL/o0d48cqyiQoyt3IPwJc6h+jXU7TMgDFSM4gC2FpZ4j9T4bVtw/Eqx89psbfXIcQ==
X-Gm-Message-State: AOJu0YzdcJ6Ulk2PoLgxb/x6Ulxx9YH32J18eNofuE8+hOBmBaMPD0zo
	X3MLm4dmmno26xmGbP+5WgjN7oB85pplrvdV5amjNbsxxcwnC9sfWmvL8RGsqdvFlgIU02oCBoV
	6wfCExqFFGhmtEA3Snb8uHs1Su89Nhfwb
X-Google-Smtp-Source: AGHT+IHE+bo+6bFeaD/wgffcQ9yZJ6QnIr/6GIOzBR0ASIFNAEirzgMhtRinvmoWFiuJ5sITOrJFQjXinzGQMMPJuKU=
X-Received: by 2002:a05:6a20:734a:b0:1c0:eb1e:868e with SMTP id
 adf61e73a8af0-1c29821acbemr12251451637.19.1720751817868; Thu, 11 Jul 2024
 19:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-flexcan-v1-0-d5210ec0a34b@nxp.com> <20240711-flexcan-v1-4-d5210ec0a34b@nxp.com>
In-Reply-To: <20240711-flexcan-v1-4-d5210ec0a34b@nxp.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Fri, 12 Jul 2024 11:36:43 +0900
Message-ID: <CAMZ6RqLcUoaD9ErNXyN5gxGSU7qPtW4HPRft=EnH0V1yVSYGCQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] can: flexcan: add wakeup support for imx95
To: Frank Li <Frank.Li@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, haibo.chen@nxp.com, imx@lists.linux.dev, 
	han.xu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for the patch. I am not familiar with the iMX95 quirks, but
to the extent of my knowledge, the patch looks good.

Here are a few nits. Next time, maybe you should run a syntax checker
to catch the easy mistakes in the English grammar.

You can directly add my review tag to the v2:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Le ven. 12 juil. 2024 =C3=A0 03:24, Frank Li <Frank.Li@nxp.com> a =C3=A9cri=
t :
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> iMX95 define a bit in GPR that assert/desert IPG_STOP signal to Flex CAN
        ^^^^^^
define -> defines
assert/desert -> desert means to "run away" or "leave behind". Not
sure this is the correct word here. Maybe something like set/unset is
better here? This sentence is worth rephrasing.

> module. It control flexcan enter STOP mode. Wakeup should work even FlexC=
AN
             ^^^^^^^                                             ^^^^
control -> controls
even -> even if

> is in STOP mode.
>
> Due to iMX95 architecture design, A-Core can't access GPR. Only the syste=
m
> manager (SM) can config GPR. To support the wakeup feature, follow below
                   ^^^^^^
config -> configure
>
> For suspend:
>
> 1) linux suspend, when CAN suspend, do nothing for GPR, and keep CAN
> related clock on.
> 2) In ATF, check whether the CAN need to support wakeup, if yes, send a
                                   ^^^^
need -> needs

> request to SM through SCMI protocol.
> 3) In SM, config the GPR and assert IPG_STOP.
> 4) A-Core suspend.
>
> For wakeup and resume:
>
> 1) A-core wakeup event arrive.
> 2) In SM, deassert IPG_STOP.
> 3) Linux resume.

Indent your lists:

  - For suspend:

    1) linux suspend, when CAN suspend, do nothing for GPR, and keep CAN
       related clock on.
    2) In ATF, check whether the CAN need to support wakeup, if yes, send a
       request to SM through SCMI protocol.
    3) In SM, config the GPR and assert IPG_STOP.
    4) A-Core suspend.

  - For wakeup and resume:

    1) A-core wakeup event arrive.
    2) In SM, deassert IPG_STOP.
    3) Linux resume.

> Add a new fsl_imx95_devtype_data and FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI t=
o
> reflect this.
>
> Reviewed-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 49 ++++++++++++++++++++++++++++=
++----
>  drivers/net/can/flexcan/flexcan.h      |  2 ++
>  2 files changed, 46 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index f6e609c388d55..ad3240e7e6ab4 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -354,6 +354,14 @@ static struct flexcan_devtype_data fsl_imx93_devtype=
_data =3D {
>                 FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
>  };
>
> +static struct flexcan_devtype_data fsl_imx95_devtype_data =3D {
> +       .quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EAC=
EN_RRS |
> +               FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX=
 |
> +               FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SETUP_STO=
P_MODE_SCMI |
> +               FLEXCAN_QUIRK_SUPPORT_FD | FLEXCAN_QUIRK_SUPPORT_ECC |
> +               FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
> +               FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
> +};

Can you declare this as constant?

  static const struct flexcan_devtype_data fsl_imx95_devtype_data =3D {

>  static const struct flexcan_devtype_data fsl_vf610_devtype_data =3D {
>         .quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EAC=
EN_RRS |
>                 FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX=
 |
> @@ -548,6 +556,13 @@ static inline int flexcan_enter_stop_mode(struct fle=
xcan_priv *priv)
>         } else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_M=
ODE_GPR) {
>                 regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
>                                    1 << priv->stm.req_bit, 1 << priv->stm=
.req_bit);
> +       } else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_M=
ODE_SCMI) {
> +               /* For the SCMI mode, driver do nothing, ATF will send re=
quest to
> +                * SM(system manager, M33 core) through SCMI protocol aft=
er linux
> +                * suspend. Once SM get this request, it will send IPG_ST=
OP signal
> +                * to Flex_CAN, let CAN in STOP mode.
> +                */
> +               return 0;
>         }
>
>         return flexcan_low_power_enter_ack(priv);
> @@ -559,7 +574,11 @@ static inline int flexcan_exit_stop_mode(struct flex=
can_priv *priv)
>         u32 reg_mcr;
>         int ret;
>
> -       /* remove stop request */
> +       /* Remove stop request, for FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI,
> +        * do nothing here, because ATF already send request to SM before
> +        * linux resume. Once SM get this request, it will deassert the
> +        * IPG_STOP signal to Flex_CAN.
> +        */
>         if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCF=
W) {
>                 ret =3D flexcan_stop_mode_enable_scfw(priv, false);
>                 if (ret < 0)
> @@ -1987,6 +2006,9 @@ static int flexcan_setup_stop_mode(struct platform_=
device *pdev)
>                 ret =3D flexcan_setup_stop_mode_scfw(pdev);
>         else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MOD=
E_GPR)
>                 ret =3D flexcan_setup_stop_mode_gpr(pdev);
> +       else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MOD=
E_SCMI)
> +               /* ATF will handle all STOP_IPG related work */
> +               ret =3D 0;
>         else
>                 /* return 0 directly if doesn't support stop mode feature=
 */
>                 return 0;
> @@ -2013,6 +2035,7 @@ static const struct of_device_id flexcan_of_match[]=
 =3D {
>         { .compatible =3D "fsl,imx8qm-flexcan", .data =3D &fsl_imx8qm_dev=
type_data, },
>         { .compatible =3D "fsl,imx8mp-flexcan", .data =3D &fsl_imx8mp_dev=
type_data, },
>         { .compatible =3D "fsl,imx93-flexcan", .data =3D &fsl_imx93_devty=
pe_data, },
> +       { .compatible =3D "fsl,imx95-flexcan", .data =3D &fsl_imx95_devty=
pe_data, },
>         { .compatible =3D "fsl,imx6q-flexcan", .data =3D &fsl_imx6q_devty=
pe_data, },
>         { .compatible =3D "fsl,imx28-flexcan", .data =3D &fsl_imx28_devty=
pe_data, },
>         { .compatible =3D "fsl,imx53-flexcan", .data =3D &fsl_imx25_devty=
pe_data, },
> @@ -2311,9 +2334,22 @@ static int __maybe_unused flexcan_noirq_suspend(st=
ruct device *device)
>         if (netif_running(dev)) {
>                 int err;
>
> -               if (device_may_wakeup(device))
> +               if (device_may_wakeup(device)) {
>                         flexcan_enable_wakeup_irq(priv, true);
>
> +                       /* For FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI, it nee=
d
> +                        * ATF to send request to SM through SCMI protoco=
l,
> +                        * SM will assert the IPG_STOP signal. But all th=
is
> +                        * works need the CAN clocks keep on.
> +                        * After the CAN module get the IPG_STOP mode, an=
d
> +                        * switch to STOP mode, whether still keep the CA=
N
> +                        * clocks on or gate them off depend on the Hardw=
are
> +                        * design.
> +                        */
> +                       if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SET=
UP_STOP_MODE_SCMI)
> +                               return 0;
> +               }
> +
>                 err =3D pm_runtime_force_suspend(device);
>                 if (err)
>                         return err;
> @@ -2330,9 +2366,12 @@ static int __maybe_unused flexcan_noirq_resume(str=
uct device *device)
>         if (netif_running(dev)) {
>                 int err;
>
> -               err =3D pm_runtime_force_resume(device);
> -               if (err)
> -                       return err;
> +               if (!(device_may_wakeup(device) &&
> +                     priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STO=
P_MODE_SCMI)) {
> +                       err =3D pm_runtime_force_resume(device);
> +                       if (err)
> +                               return err;
> +               }
>
>                 if (device_may_wakeup(device))
>                         flexcan_enable_wakeup_irq(priv, false);
> diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/=
flexcan.h
> index 025c3417031f4..4933d8c7439e6 100644
> --- a/drivers/net/can/flexcan/flexcan.h
> +++ b/drivers/net/can/flexcan/flexcan.h
> @@ -68,6 +68,8 @@
>  #define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR BIT(15)
>  /* Device supports RX via FIFO */
>  #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
> +/* Setup stop mode with ATF SCMI protocol to support wakeup */
> +#define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
>
>  struct flexcan_devtype_data {
>         u32 quirks;             /* quirks needed for different IP cores *=
/
>
> --
> 2.34.1
>
>

