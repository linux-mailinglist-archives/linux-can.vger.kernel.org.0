Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A42253C36A
	for <lists+linux-can@lfdr.de>; Fri,  3 Jun 2022 05:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiFCDjM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Jun 2022 23:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiFCDjL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Jun 2022 23:39:11 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC55B1CFFC
        for <linux-can@vger.kernel.org>; Thu,  2 Jun 2022 20:39:09 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so6331780pjb.3
        for <linux-can@vger.kernel.org>; Thu, 02 Jun 2022 20:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x8SxNnSlRoxPxJO9Uoy9HTF5RbNrzxny49a/wwWHJlI=;
        b=m+Dp64OKhHxtIwoYnPdn8ou+Ei7x0N76Ed4+7OCiDQ9nPxlgSDaVPEilak1ti2967e
         tANiXmeB9ZSfnsWI9uzMHrKPTcwBDqFDrPqIW9fAVTMk+WleIsfRHMtwPnAh1vYzmAGz
         6w39s2xoN5VdcT4fN9W0P/PoN4joxlBE4YdpvMqrxJCAGZFgSAUPvGK2gRdEjLLyaHji
         gDtPyD4nY5579am5AhI9bYGp6jT+3UL0lWNQcM0kQxtQ/mt8F278e2oO4AGRsFNpuZxl
         bWoEwhx2q41m6Hb6bFGEm5eaCz5R3Meg4gDXlwylma4f4mg5iHpc2kqSoK9s1oU0Qdeh
         7+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x8SxNnSlRoxPxJO9Uoy9HTF5RbNrzxny49a/wwWHJlI=;
        b=eP63YuZ3y+jj3Cggx9UQMm7C1+okUIMxGIk320i9B/umxbnBnuahRmQ2G6bPXNBEz+
         zMjyPIVEDWvhVZ7+bo8xvuwzThJNKcxUHP4LQvNuDZLI1Y6PDo22fMmmpo8azanrkYFh
         97v7Zb+IIJTiiSCNywzTYlWnYpRW2uxjIYqV+WUEzonLayos+leqlZRlm/hcTIIS+fXF
         hYvVbaq33Atz9olps+oF72M1HTx0Iz0N6rlSNYEldSMXDQGdBxyv5N45zU0sAckKv9UK
         wNd42qXmKamo0pRfT7/2KRssOZeKCS9C3bgALGIcxL/hrnb8ranrdiXeZQHSUpUGduAr
         Lt7w==
X-Gm-Message-State: AOAM530e186g92JyZfb2hXtiW8VT3P18pv0PJ6+aiSjrLbm7InOtUf+G
        /eIuFZyNNXl5vQYmryUQ+R3Zrw==
X-Google-Smtp-Source: ABdhPJw7SQjHZk0kByADgeyyofvzlhVc+Y0r1t6LeLRAAv19IN+3gyxnUWZY6FCi/7RLYD02yd53wg==
X-Received: by 2002:a17:902:b214:b0:161:f6d8:45cd with SMTP id t20-20020a170902b21400b00161f6d845cdmr8296208plr.95.1654227549020;
        Thu, 02 Jun 2022 20:39:09 -0700 (PDT)
Received: from hermes.local (204-195-112-199.wavecable.com. [204.195.112.199])
        by smtp.gmail.com with ESMTPSA id ft19-20020a17090b0f9300b001e2fed48f48sm4029801pjb.41.2022.06.02.20.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 20:39:08 -0700 (PDT)
Date:   Thu, 2 Jun 2022 20:39:04 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Kaarel =?UTF-8?B?UMOkcnRlbA==?= <kaarelp2rtel@gmail.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: add operstate for vcan and dummy
Message-ID: <20220602203904.65f7261f@hermes.local>
In-Reply-To: <20220602081929.21929-1-kaarelp2rtel@gmail.com>
References: <20220602081929.21929-1-kaarelp2rtel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu,  2 Jun 2022 11:19:29 +0300
Kaarel P=C3=A4rtel <kaarelp2rtel@gmail.com> wrote:

> The idea here is simple. The vcan and the dummy network devices
> currently do not set the operational state of the interface.
> The result is that the interface state will be UNKNOWN.
>=20
> The kernel considers the unknown state to be the same as up:
> https://elixir.bootlin.com/linux/latest/source/include/linux/netdevice.h#=
L4125
>=20
> However for users this creates confusion:
> https://serverfault.com/questions/629676/dummy-network-interface-in-linux
>=20
> The change in this patch is very simple. When the interface is set up, the
> operational state is set to IF_OPER_UP.
>=20
> Signed-off-by: Kaarel P=C3=A4rtel <kaarelp2rtel@gmail.com>
> ---
>  drivers/net/can/vcan.c | 1 +
>  drivers/net/dummy.c    | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
> index a15619d883ec..79768f9d4294 100644
> --- a/drivers/net/can/vcan.c
> +++ b/drivers/net/can/vcan.c
> @@ -162,6 +162,7 @@ static void vcan_setup(struct net_device *dev)
> =20
>  	dev->netdev_ops		=3D &vcan_netdev_ops;
>  	dev->needs_free_netdev	=3D true;
> +	dev->operstate =3D IF_OPER_UP;
>  }
> =20
>  static struct rtnl_link_ops vcan_link_ops __read_mostly =3D {
> diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
> index f82ad7419508..ab128f66de00 100644
> --- a/drivers/net/dummy.c
> +++ b/drivers/net/dummy.c
> @@ -133,6 +133,7 @@ static void dummy_setup(struct net_device *dev)
> =20
>  	dev->min_mtu =3D 0;
>  	dev->max_mtu =3D 0;
> +	dev->operstate =3D IF_OPER_UP;
>  }
> =20
>  static int dummy_validate(struct nlattr *tb[], struct nlattr *data[],

Normally carrier state is propogated to operstate by linkwatch.
You may need to add a call for that.

