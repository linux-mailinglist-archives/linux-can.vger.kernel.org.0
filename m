Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52D0579478
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 09:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiGSHqC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 03:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbiGSHqA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 03:46:00 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4611B840
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 00:45:57 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 64so25038133ybt.12
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 00:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3iwfIG0iGAlM+Jpz86lTtc9eLurGUwCss8Q+RSRu3Kw=;
        b=Qw357z8WMpTDtimb2Sb1UbVoX5Uu7aLDvd5RBaYCtydkgfKPcvV/ORzZJbbkur0/2T
         /8B+CVx7ZSVN2eWN5g91wUipGRAj0st5Gefc0UvE5UEftsnzABOHsUGZzNdctfVEnR3F
         4VW/3tQ5ead6GkH1oJnAcQ7qdOO8D+qRvS5cXX4Xu2D7N01KDRBVam3jkI4iaSeTWWXK
         HxsoYtCmx362AYCdgSwdr+FdeifVFYL7n+rk9TZpZuy9SYaMC6DOZ3c9En/cf13XEWC6
         nQ5mIj7P5Mnz8q58zXZsLn300OuRJsMy2kVrU1cXnDSCxu9Ff/KAvsyz406KS1/aP++Z
         Sn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3iwfIG0iGAlM+Jpz86lTtc9eLurGUwCss8Q+RSRu3Kw=;
        b=QyaAk3jg0KoHsHDH2njpood3LwzB8jLUQrzYQr5+BzzvYIzhJG+hI9mfcqG/JEuF7R
         1zbbUka3+BYiq9bpYeaaTdyBqqBRrzliY4pQODausrEPP7YMfjjUJ4EDAQaLeEymVTSi
         RPMMyPRtYjcxjufFl/hyjGHiXeM8+h313hCrBXE955Pglm0ZbExMoShVP2tzSN9jPk/m
         84H0avoB+OEuOsMfK0l5YUyogoUVgLj1y8bYiz6CNZsmr7nz9xfsa945r1tteXp8Fhi1
         Y09EjyThcwLLl69GYPXaul45gNZcxBfSllAJEFbWvebcIZv9NiWA5WutVzrG4kcIXPNf
         G85A==
X-Gm-Message-State: AJIora81A4/GHkdyRAe7s62PwKFPkLii3RHa+NDGIlg4/XqkaQQDm7iT
        5Korg/MSuT61nSM+2nu1mnhgAOP9kbcFQUozbWBKEUwY5Kk=
X-Google-Smtp-Source: AGRyM1t06d32lsIz8iVLDNPOEiiZn7qYl3RU0cTGFmB20z0/EQ91sJSomD1cVm0D4cJCwh2KtLe/f4Sof8/GdxfrocY=
X-Received: by 2002:a5b:ed0:0:b0:670:7cd1:a756 with SMTP id
 a16-20020a5b0ed0000000b006707cd1a756mr3351651ybs.151.1658216756767; Tue, 19
 Jul 2022 00:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220719054204.29061-1-socketcan@hartkopp.net> <20220719054204.29061-6-socketcan@hartkopp.net>
In-Reply-To: <20220719054204.29061-6-socketcan@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Tue, 19 Jul 2022 16:45:45 +0900
Message-ID: <CAMZ6RqJQ2ue7tdT+bxQimeVNDLrDJZBZZM35yAbQ1NZPTVbGiA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 5/5] can: raw: add CAN XL support
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 19 Jul. 2022 at 14:46, Oliver Hartkopp <socketcan@hartkopp.net> wro=
te:
> Enable CAN_RAW sockets to read and write CAN XL frames analogue to the
> CAN FD extension (new CAN_RAW_XL_FRAMES sockopt).
>
> A CAN XL network interface is capable to handle Classical CAN, CAN FD and
> CAN XL frames. When CAN_RAW_XL_FRAMES is enabled, the CAN_RAW socket chec=
ks
> whether the addressed CAN network interface is capable to handle the
> provided CAN frame.
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/uapi/linux/can/raw.h |  6 +++
>  net/can/raw.c                | 97 +++++++++++++++++++++++++++++++-----
>  2 files changed, 90 insertions(+), 13 deletions(-)
>
> diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
> index 3386aa81fdf2..5a0e480887ff 100644
> --- a/include/uapi/linux/can/raw.h
> +++ b/include/uapi/linux/can/raw.h
> @@ -60,8 +60,14 @@ enum {
>         CAN_RAW_ERR_FILTER,     /* set filter for error frames       */
>         CAN_RAW_LOOPBACK,       /* local loopback (default:on)       */
>         CAN_RAW_RECV_OWN_MSGS,  /* receive my own msgs (default:off) */
>         CAN_RAW_FD_FRAMES,      /* allow CAN FD frames (default:off) */
>         CAN_RAW_JOIN_FILTERS,   /* all filters must match to trigger */
> +       CAN_RAW_XL_FRAMES,      /* allow CAN XL frames (default:off) */
>  };
>
> +/* CAN XL data transfer modes for CAN_RAW_XL_FRAMES sockopt */
> +#define CAN_RAW_XL_ENABLE (1 << 0) /* enable CAN XL frames on this socke=
t */
> +#define CAN_RAW_XL_RX_DYN (1 << 1) /* enable truncated data[] for read()=
 */
> +#define CAN_RAW_XL_TX_DYN (1 << 2) /* enable truncated data[] for write(=
) */

This change leaves me perplexed. If I understand correctly, the only
purpose is to provide those two APIs is to have:
  * one for the beginner users: fixed packet size in order to keep the
approach of CAN(-FD).
  * one the advanced users: variable packet size.

I don=E2=80=99t think that there are any precedent cases where the kernel
exposed two differents APIs for the sake of pleasing both beginner and
advanced users. Sending packets of variable sizes between the kernel
and the userland is a solved problem and I feel uncomfortable
introducing custom solutions in order to prevent hypothetical misuses.

I am not even convinced that this solution is safer than the V2. If
you introduce different options, there will always be someone who will
mix up things by copy pasting some random code snippets and get an
unsafe result. IMHO, it is better to build a simple interface and give
a reference implementation rather than trying to add complexity to
anticipate misuses.


Yours sincerely,
Vincent Mailhol
