Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6882F36A7FE
	for <lists+linux-can@lfdr.de>; Sun, 25 Apr 2021 17:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhDYPga (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Apr 2021 11:36:30 -0400
Received: from mail-yb1-f176.google.com ([209.85.219.176]:39926 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhDYPga (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Apr 2021 11:36:30 -0400
Received: by mail-yb1-f176.google.com with SMTP id z1so61628659ybf.6
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 08:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fy2b9DcmPURO1GLJUCuHqfsmgbBlL7O7NoddbJP4W0=;
        b=LaV41E4y20/YWSHYVJcEP/awAOcJ9dXwdCHgyB/H8gZjX9p27sdruU0I0SivOPpfHo
         crvFG49ubK+1DgcVFKwBEUsT2MylFeLg7lr8p5HdUVWmO4SWy3YFQVGBoTQXqi9cq7zZ
         Mr4lB7ffTBO1Khhk0m0GrBD5c2T/okHG93P/BhXGf9CtCHFyutqADXETMePv58SPHDXM
         ZNCyAeE4qduXdzMjF2bVNnhRAjaT9yjcP2ENie/kS/cAsw77F+gKyzOWcHJIYf59EEgw
         H9E8cvXiShgKRcz+krD+FC9JQx6BTqHDMCGaRPsNQVnSeimnXw3ui9ezTOLBC3B3vZjd
         ggdA==
X-Gm-Message-State: AOAM532GrHurreT6LJrEqPFDTShTZPkN95RLWWJLJGt1ZQfrc+Kww+aV
        y/W7UmsTV4QwWSvum4fEEDptFb0+PKhVnF81WVzilWZAlh0QrQ==
X-Google-Smtp-Source: ABdhPJxduGkmuUMnHRKpKB8RhPKr+q7Ap3IQI5ZKwxmjYbf0pC/tDUyE7ifueB+24zJEUZt1MwdBQz9Ia6HbrYkbnJk=
X-Received: by 2002:a25:c696:: with SMTP id k144mr15652085ybf.307.1619364948922;
 Sun, 25 Apr 2021 08:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210425151028.8238-1-menschel.p@posteo.de>
In-Reply-To: <20210425151028.8238-1-menschel.p@posteo.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 26 Apr 2021 00:35:37 +0900
Message-ID: <CAMZ6RqKkeq6vo0X4_KH01=SXfjKF7YMXGT_cgm+sS+T10hr_CA@mail.gmail.com>
Subject: Re: [PATCH] can-isotp: Add error message if txqueuelen is too small.
To:     Patrick Menschel <menschel.p@posteo.de>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun. 26 Apr 2021 at 00:10, Patrick Menschel <menschel.p@posteo.de> wrote:
>
> This patch adds a comprehensive error message in
> case that txqueuelen is too small and the isotp
> driver encounters ENOBUFS (105), e.g.
> "no buffer space available" while it does
> enqueue its generated frames.
>
> Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
> ---
>  net/can/isotp.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 9f94ad3ca..c50e238b0 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -946,8 +946,17 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>         err = can_send(skb, 1);
>         dev_put(dev);
>         if (err) {
> -               pr_notice_once("can-isotp: %s: can_send_ret %d\n",
> -                              __func__, err);
> +               if (err == -ENOBUFS) {
> +                       /* if txqueuelen is not of sufficient length
> +                        * for this transfer
> +                        */
> +                       pr_notice_once("can-isotp: %s: can_send_ret %d : No buffer space available in tx queue\n",
> +                                      __func__, err);

Speaking of comprehensive error messages, it would be great to
print the mnemotechnic of the error code instead of its value:
|                       pr_notice_once("can-isotp: %s: can_send_ret
%pe : tx queue is full\n",
|                                      __func__, ERR_PTR(err));

> +               } else {
> +                       /* general error */
> +                       pr_notice_once("can-isotp: %s: can_send_ret %d\n",
> +                                      __func__, err);

Same here:
|                       pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
|                                      __func__, ERR_PTR(err));

Yours sincerely,
Vincent
