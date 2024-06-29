Return-Path: <linux-can+bounces-896-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1674591CBF8
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 11:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E23B21D9B
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 09:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E0A3BBEB;
	Sat, 29 Jun 2024 09:52:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B294E3BB30
	for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719654748; cv=none; b=pfWG54OJwpaUuuAmPXqD85WlWuDr6BcDr9Mn83smP0+5fhZP3qJ9hFQ4FJzVmPkD6ht2Pwo1Kpq9i+REc/MHtwv2A6sxJpPsMUM8m7x4qSw72ulVIBmIVpwbL4FwdP57I8HpOx6iuoAEOi2cK6WIwq58GGVAJ/cY+dXDm02e4bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719654748; c=relaxed/simple;
	bh=O6eCjHK0yIUixqjdY0h+BbwbRXrLBs4mp/Ra8dYcnzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+nirdPviEdqJ13NxwFATiTr6j1acHKeErYUXbhTPtUJSOpiw3BR/eEB/YrTirL+wXrOboQQY/Cj2iKr0iN2AApDQeAxMQt7a86ACXUH71/GXz4Q/Rk8fHJrQdjfFv6mnmHxvxNexBdjYhaveYb3qFbqaP33oB5znGo6j0zQFeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5c21c68b786so677268eaf.0
        for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 02:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719654746; x=1720259546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgArw37KC7B25EGjc/IQJl+5DRiNWpvmvweL+8DbN7I=;
        b=lN2r/sCEmAehz80a4JhLl0553rmO0cz/Bhnc9wy6xETBLdEJr9qjujcmRpF9zPeKPC
         n7UieljCLkrKigokNNx3S4if4mARNUK9caP9NjqsoTCQHlZpTHAUQQsHSLxhtNWA43yL
         cagKNGCo0eau18KkLqVOvLnVcjEctwjsF0FEMlNIdqE+Y6Kv+y6VWxIZoewW+pC96Bq+
         q7+A2HVyKEz9Ktoe+kiYlMTBHFSHO+bPGoOSd2w1Nb1PZxWw7MnwITtHUtrMxZ42p4OJ
         zwzN25yOvdqLjOwohYVRs2tXRardOEUCJIyb8VQUuwfDeOsLfPxOdABKVqBCsf7AmVOj
         0zmQ==
X-Gm-Message-State: AOJu0YwPtY0OVLRgUlUNqUNRx3nkn+IsUKezB99ug1HO/APnzw4vxwlS
	+JrlncrLBu7GImCe1DnbNb+sFpU4BTxyTVXgtbzg8LS+/J+usjSxVk0yPOqXYcvv26QA9r/vBht
	7p28u8Xu1Iv8lB8otuN/jsYmqi/U=
X-Google-Smtp-Source: AGHT+IFI6lYxJCR1U6Dmuas66Lbhyc+GivLL8Gh2KmD0RpGtJjFy9WNthyIzGMoexnn0lyVK2lM8iBXjuSyBPMp5QgI=
X-Received: by 2002:a05:6358:7e44:b0:1a5:cb16:bc48 with SMTP id
 e5c5f4694b2df-1a6acc3043fmr54350155d.3.1719654745666; Sat, 29 Jun 2024
 02:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628195514.316895-1-extja@kvaser.com> <20240628195514.316895-15-extja@kvaser.com>
In-Reply-To: <20240628195514.316895-15-extja@kvaser.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Sat, 29 Jun 2024 18:52:14 +0900
Message-ID: <CAMZ6RqJ8dyc62Hj+ACV99BSuX3g3ARGCfY4HHUtiKmpmmotDJw@mail.gmail.com>
Subject: Re: [PATCH can-next 14/15] can: kvaser_usb: Remove struct variables kvaser_usb_{ethtool,netdev}_ops
To: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Jimmy Assarsson <jimmyassarsson@gmail.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Sat. 29 June 2024 at 04:56, Jimmy Assarsson <extja@kvaser.com> wrote:
> Remove no longer used struct variables, kvaser_usb_ethtool_ops and
> kvaser_usb_netdev_ops.

Does the driver still compile after this patch? Wouldn't it be better
to squash patch 14 and 15 in one?

> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
>  drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> index a4f32d57173a..4b6c23121b5d 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> @@ -753,13 +753,6 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
>         return ret;
>  }
>
> -static const struct net_device_ops kvaser_usb_netdev_ops = {
> -       .ndo_open = kvaser_usb_open,
> -       .ndo_stop = kvaser_usb_close,
> -       .ndo_start_xmit = kvaser_usb_start_xmit,
> -       .ndo_change_mtu = can_change_mtu,
> -};
> -
>  static const struct net_device_ops kvaser_usb_netdev_ops_hwts = {
>         .ndo_open = kvaser_usb_open,
>         .ndo_stop = kvaser_usb_close,
> @@ -768,10 +761,6 @@ static const struct net_device_ops kvaser_usb_netdev_ops_hwts = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> -static const struct ethtool_ops kvaser_usb_ethtool_ops = {
> -       .get_ts_info = ethtool_op_get_ts_info,
> -};
> -
>  static const struct ethtool_ops kvaser_usb_ethtool_ops_hwts = {
>         .get_ts_info = can_ethtool_op_get_ts_info_hwts,
>  };
> --
> 2.45.2
>
>

