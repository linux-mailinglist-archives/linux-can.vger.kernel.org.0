Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F312F7DFA
	for <lists+linux-can@lfdr.de>; Fri, 15 Jan 2021 15:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbhAOOTF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Jan 2021 09:19:05 -0500
Received: from mail-yb1-f181.google.com ([209.85.219.181]:46877 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbhAOOTE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Jan 2021 09:19:04 -0500
Received: by mail-yb1-f181.google.com with SMTP id f6so5113679ybq.13
        for <linux-can@vger.kernel.org>; Fri, 15 Jan 2021 06:18:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czr7LTu7GYm0Fo67ngNO0k345ZnuDTn31AKqpdTgzxA=;
        b=i7miYtFXILsXp0rWyNdfmo7/vvOIG1k39v9lTrtSjL6zP/0QYLRUCEoyrBQN1e4yWc
         1T9T+GheKw7eC6LnfvV/kVQJo8W5WnodSiLiowD05zOawKS4k3nXuiN2EyHRfAKVBNAP
         t/RjkWH2iA19Oa5kWAuFvqpdoSyirtokA9dK15Hq+3p3o1JSUgDb1z83hkijp49E/YAE
         qhwWrVyzRd9a7G0+vjRcFQcvoK0yT0hzPSJDbi7bdGSAMBpqVzpyUM/NPbf3lzcTittq
         vb7YhKXb07z+X9VWmLp6gs1Gm90xnBhMCbKgneFN1D3/ye515zh7ig4mDtkbWj+34uBh
         sK/Q==
X-Gm-Message-State: AOAM530k0ysF6zEo9i+I6OtdDRyqW9T2107rXnQWo1i8aGiJtQZhhfCM
        nFD1XcnqtvoC3fs9qO9k4P9OQOqiHXHghQWL0HM=
X-Google-Smtp-Source: ABdhPJz0rbQ8Ou2doDECiNAkP4S+WdB5JDTLkl0u3eWfjr6z6VJtuTKp3V8MfvMmt4RLL/nR/LIrQOyeERfaJuW6vcI=
X-Received: by 2002:a25:ba05:: with SMTP id t5mr17384853ybg.360.1610720303796;
 Fri, 15 Jan 2021 06:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20210113211410.917108-1-mkl@pengutronix.de> <20210113211410.917108-10-mkl@pengutronix.de>
 <CAMZ6Rq+Wxn_kG7rSkUrMYMqNw790SMe-UKmpUVdEA_eGcjoT+g@mail.gmail.com>
 <2f3fff1a-9a50-030b-6a29-2009c8b65b68@hartkopp.net> <CAMZ6RqLKYnGDePueN1ftL9a47Qf-ZR7bc4eLGwzCkncsD6ok2Q@mail.gmail.com>
 <75d3c8e9-acbd-09e9-e185-94833dbfb391@hartkopp.net> <CAMZ6RqKZcuJH2DPeZjgqvL2MG+LoLScHTdd4s+K9OFYDUFT2ZQ@mail.gmail.com>
 <a79041a9-a211-bd3f-42b3-35919bd12470@hartkopp.net> <CAMZ6RqLYnLYySQ0ZY3tvR7zk0x6BRoBmw2gh-8pf7kt-nMbQfQ@mail.gmail.com>
 <44eb1d41-a434-76a2-4c28-9aab7edb54e6@pengutronix.de>
In-Reply-To: <44eb1d41-a434-76a2-4c28-9aab7edb54e6@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 15 Jan 2021 23:18:12 +0900
Message-ID: <CAMZ6RqK5BuGiVXjwS2p5bjUbgcRS=AfPzGC7OmwBnKfP8VvCcw@mail.gmail.com>
Subject: Re: [net-next 09/17] can: length: can_fd_len2dlc(): simplify length calculcation
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 15 janv. 2021 at 22:51, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 1/15/21 2:20 PM, Vincent MAILHOL wrote:
> > /* map the data length to an appropriate data length code */
> > u8 can_fd_len2dlc(u8 len)
> > {
> >     switch(len) {
> >     case 0 ... 8:
> >         return len;
> >     case 9 ... 12:
> >         return 9;
> >     case 13 ... 16:
> >         return 10;
> >     case 17 ... 20:
> >         return 11;
> >     case 21 ... 24:
> >         return 12;
> >     case 25 ... 32:
> >         return 13;
> >     case 33 ... 48:
> >         return 14;
> >     case 49 ... 64:
> >     default:
> >         return CANFD_MAX_DLC;
> >     }
> > }
> >
> > And we will just leave the optimizations in the hand of the compiler.
>
> I've already tried this. It results in a longer object file on ARM, even if you
> remove the array....

You are right. I just checked the assembly code: it does a
dichotomy which means that in addition to being bigger, it is
also slower.

Please forget my previous message, it wasn't really smart.


Yours sincerely,
Vincent

> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
>
