Return-Path: <linux-can+bounces-895-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A051D91CBE8
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 11:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EAF21C20FD1
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 09:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB4B2033E;
	Sat, 29 Jun 2024 09:32:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C62F1C20
	for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719653536; cv=none; b=griun8TerugwxwKQNUfkB9h6gf+FUr5v8IeHbtuHdnTUWqZ2y60U/4yV6Ce0wbY4/zotgpGLmlpV3j/hiRO8Kx4RoiwCUJO0G+EcUtkt6BSh3CIfNZbQOlkvQoJ7epUPFPr7IO7Fqv8RrAh8sdPiATEhtl28Kqy54F557kJ3xQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719653536; c=relaxed/simple;
	bh=y5h/4bGI1kk39OAmDZzprOMgyl0uV+ipJtJQxlRnrzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pey5qqMuFajTRtZ9ADNVCmSO2oOONy6RPCeixDHcXamIXMQyOmbpIAQSbV6glL9FZq07/WYEUxOKwVQAIj+dzu9CAo0XOANvt20gmC+Ft5ftCZzDORNNc2QpiXXbrm26qLW2RP6A2ViUG/kZmuDzffkI8jA5aQf97+kviegGQa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-73aba5230b6so178391a12.1
        for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 02:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719653534; x=1720258334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIP6jScN4m+JHER+Iqkwwvq8INH2pmrZolzXX/4Ag+k=;
        b=vQlr7ICF4cApuomCIEaCcdqh2bpHhK9zWXN3B2EAz4TURxoX1HIpKGnVhYFNMpyqnb
         HGlt+tpOGm/c3ZpxVFxn1m43TbjualCieNwDr46EuPnPzW5EsOBS62FQcz9G55YdbiE9
         UKamlpxDWIfsQxfYTWmIVoZ3h1kZ+KyjAiHTHL2ctlHTmNigZCPDvro84NNyaoigSzqK
         GPDUya7NcupMv8mYzHjMHiRAzih+hfRhDahIE6a+Voq8PSWnsgE/j9+CHUALlF7gN6iM
         Q4CSIY4nTf6CndEhy8V2Qn9xQSLVBmFplk6dTe5N31+M6kdLp4UFsJnAQtOmNwggbx0e
         qDjQ==
X-Gm-Message-State: AOJu0YwVrLu9gKH+LtjdP5lH0fUMXgJJSB9vdwUBnIzDhSugbsEw2irl
	3kfpIU68mag34lVWUjZwECBIpBQfvtUZ+VYfMjpr3gRrrzN4SSvcwtxMhl7KpHZOI4KT7YeFrSq
	1fbm7oOnwMIyJHGELoH0Ut5DLG3UrZw==
X-Google-Smtp-Source: AGHT+IGUxDS8i2YrRKwBtr7x5MilXXx02Fdi+JlPqVGilPNXyZivzI8J1rBmmOCHjsyLT9UP0pqjKmavnDzqCBEaSX0=
X-Received: by 2002:a17:90b:230f:b0:2c4:e2d6:8de6 with SMTP id
 98e67ed59e1d1-2c93d2d18d8mr1017421a91.21.1719653534517; Sat, 29 Jun 2024
 02:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628195514.316895-1-extja@kvaser.com> <20240628195514.316895-5-extja@kvaser.com>
In-Reply-To: <20240628195514.316895-5-extja@kvaser.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Sat, 29 Jun 2024 18:32:03 +0900
Message-ID: <CAMZ6Rq+Xd7+th=dKV+vrqzRtS+GY-xq2UziH1CURcQ3HxEXMqQ@mail.gmail.com>
Subject: Re: [PATCH can-next 04/15] can: kvaser_usb: Add function kvaser_usb_ticks_to_ktime()
To: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Jimmy Assarsson <jimmyassarsson@gmail.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Sat. 29 June 2024 at 04:56, Jimmy Assarsson <extja@kvaser.com> wrote:
> Add function, kvaser_usb_ticks_to_ktime(), that converts from device ticks
> to ktime.
>
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
>  drivers/net/can/usb/kvaser_usb/kvaser_usb.h       | 8 ++++++++
>  drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
> index ff10b3790d84..f5868e0b3b23 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
> @@ -22,6 +22,8 @@
>   */
>
>  #include <linux/completion.h>
> +#include <linux/ktime.h>
> +#include <linux/math64.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
>  #include <linux/usb.h>
> @@ -216,4 +218,10 @@ int kvaser_usb_can_rx_over_error(struct net_device *netdev);
>
>  extern const struct can_bittiming_const kvaser_usb_flexc_bittiming_const;
>
> +static inline ktime_t kvaser_usb_ticks_to_ktime(const struct kvaser_usb_dev_cfg *cfg,
> +                                               u64 ticks)
> +{
> +       return ns_to_ktime(div_u64(ticks * 1000, cfg->timestamp_freq));
> +}

See my comment on patch 2: also add the timestamp to tick conversion here.

>  #endif /* KVASER_USB_H */
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index 28a99d78ba8d..08688514d142 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> @@ -553,7 +553,7 @@ static ktime_t kvaser_usb_hydra_ktime_from_cmd(const struct kvaser_usb_dev_cfg *
>                 ticks += (u64)(le16_to_cpu(cmd->tx_ack.timestamp[2])) << 32;
>         }
>
> -       return ns_to_ktime(div_u64(ticks * 1000, cfg->timestamp_freq));
> +       return kvaser_usb_ticks_to_ktime(cfg, ticks);
>  }
>
>  static int kvaser_usb_hydra_send_simple_cmd(struct kvaser_usb *dev,
> --
> 2.45.2
>
>

