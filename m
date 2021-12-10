Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67C446FD1F
	for <lists+linux-can@lfdr.de>; Fri, 10 Dec 2021 09:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbhLJJBV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 10 Dec 2021 04:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238778AbhLJJBV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Dec 2021 04:01:21 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068BCC0617A1
        for <linux-can@vger.kernel.org>; Fri, 10 Dec 2021 00:57:47 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id q17so5823610plr.11
        for <linux-can@vger.kernel.org>; Fri, 10 Dec 2021 00:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spacecubics-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o78r8oCqesWT7jqTVPoth6IM19LStgzO1ZNNWGxpAcg=;
        b=vPd16In+A27Rtsr9JY+O/2Hhe6R2WbhGgeymIxYHdMog/u8sC6FA+A0AYVoLk8xwMA
         iDtr43nagI2JOPL5sk04xRMumKM2+C07uZI8HTbJjJZYO9NAjbuIFc+56B0kue+bMtJe
         G8JJbVJ8LmbR1w1tfl0lBJEXDZfid+5OXvO5GNNDE8U/uAN+kdpvRp7jRBFf6Q4oOUmh
         7h4Z5cwDvC8EdQOMUOGB0GNgQkU5mVVs8Y50vIRQV0gWVxVzGRsWJpXWGmdl0GGo4lis
         mb6+Ezxjoj4G28UsTlCPq2Jq0orWzGVTXEA47Ch7TO8IlC1+Euhf61FdP2jz/DPL3LZz
         aFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o78r8oCqesWT7jqTVPoth6IM19LStgzO1ZNNWGxpAcg=;
        b=OhAvfWk+IXubl+G0kTVcz4XljaahV2htUWKLfuwcwp5Q+OPbGFst6W6JoWcKxI2LA6
         4ghdzKJJfth2TEissuJ8jnVMJYx5Y/u5/TomWrCnqtFWcWM+qD+dicjYjM7PAP7ikew5
         GJS/D4Sk6L8MqWcRWCIM+lCQ2fZ8rAV1YRxAO/bo0SZdo74BnsejckNLIw3a7Bf8WR5N
         X8hnoOba+Pf4VlYq09LHTZa3t5/5potfpfIxr8bYyE2M0xXZgA+bDTFrBtBmWXUJ848Q
         UWwXl671gGr1MKwakP8b5bDAW+G7SON387yq+hddecKJpT1jRSZvzy4BQHDQi/i1G00n
         esig==
X-Gm-Message-State: AOAM532pB9EGQW7hN4dpCTh3MdhkhnOrxcHd09y+M0zmqYzZRpZk3Mxq
        vgJhL6JfnjLZhc6TuQDiCBYpsqz9z9jjqhL0f+ZsJki/w4yIjA==
X-Google-Smtp-Source: ABdhPJyStS5NlCVO8vdDsg26SLoOFytFOZeSf1AZFKF4jXizeNkyXoXGEeLcX55fgZCj2gqpe0wshFUG6BWMGgUQ+t0=
X-Received: by 2002:a17:90a:d515:: with SMTP id t21mr22452866pju.123.1639126666591;
 Fri, 10 Dec 2021 00:57:46 -0800 (PST)
MIME-Version: 1.0
References: <20211207121531.42941-1-mailhol.vincent@wanadoo.fr> <20211207121531.42941-4-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20211207121531.42941-4-mailhol.vincent@wanadoo.fr>
From:   Yasushi SHOJI <yashi@spacecubics.com>
Date:   Fri, 10 Dec 2021 17:57:35 +0900
Message-ID: <CAGLTpnJp_v3Eev61gPWRi6fzj400mUR7hLmezXGc2RmA7XDcoA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] can: do not copy the payload of RTR frames
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Jimmy Assarsson <extja@kvaser.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Vincent,

On Tue, Dec 7, 2021 at 9:16 PM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> The actual payload length of the CAN Remote Transmission Request (RTR)
> frames is always 0, i.e. nothing is transmitted on the wire. However,
> those RTR frames still use the DLC to indicate the length of the
> requested frame.
>
> For this reason, it is incorrect to copy the payload of RTR frames
> (the payload buffer would only contain garbage data). This patch
> encapsulates the payload copy in a check toward the RTR flag.
>
> CC: Yasushi SHOJI <yashi@spacecubics.com>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

It works and LGTM.

Tested-by: Yasushi SHOJI <yashi@spacecubics.com>
-- 
              yashi
